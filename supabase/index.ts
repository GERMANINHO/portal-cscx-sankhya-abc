import { withSupabase } from "npm:@supabase/server@^1";

type AcaoNps = "teste_rascunho" | "criar_rascunho";

const ACOES_PERMITIDAS = new Set<AcaoNps>([
  "teste_rascunho",
  "criar_rascunho",
]);

const PERFIS_PERMITIDOS = new Set([
  "cscx",
  "gestao",
  "administrador",
]);

function resposta(
  body: Record<string, unknown>,
  status = 200,
): Response {
  return Response.json(body, { status });
}

function numeroSeguro(value: unknown): number {
  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : 0;
}

export default {
  fetch: withSupabase(
    { auth: "user" },
    async (req, ctx) => {
      if (req.method !== "POST") {
        return resposta(
          {
            ok: false,
            message: "Método não permitido. Utilize POST.",
          },
          405,
        );
      }

      const claims = ctx.userClaims as
        | { id?: string; sub?: string; email?: string }
        | undefined;

      const userId = claims?.id ?? claims?.sub;

      if (!userId) {
        return resposta(
          {
            ok: false,
            message: "Não foi possível identificar o usuário autenticado.",
          },
          401,
        );
      }

      const { data: perfil, error: perfilError } = await ctx.supabase
        .from("perfis")
        .select("nome, email, perfil, status")
        .eq("id", userId)
        .maybeSingle();

      if (perfilError) {
        console.error("Erro ao consultar perfil:", perfilError);
        return resposta(
          {
            ok: false,
            message: "Não foi possível validar as permissões do usuário.",
          },
          500,
        );
      }

      if (!perfil || perfil.status !== "aprovado") {
        return resposta(
          {
            ok: false,
            message: "Usuário sem acesso aprovado ao Portal.",
          },
          403,
        );
      }

      if (!PERFIS_PERMITIDOS.has(perfil.perfil)) {
        return resposta(
          {
            ok: false,
            message:
              "Seu perfil possui acesso somente para consulta e não pode executar a Blitz NPS.",
          },
          403,
        );
      }

      let payload: { action?: string };

      try {
        payload = await req.json();
      } catch {
        return resposta(
          {
            ok: false,
            message: "Corpo da requisição inválido.",
          },
          400,
        );
      }

      const action = String(payload.action ?? "").trim() as AcaoNps;

      if (!ACOES_PERMITIDAS.has(action)) {
        return resposta(
          {
            ok: false,
            message:
              "Ação inválida. Utilize teste_rascunho ou criar_rascunho.",
          },
          400,
        );
      }

      const appsScriptUrl = Deno.env.get("NPS_APPS_SCRIPT_URL");
      const appsScriptToken = Deno.env.get("NPS_APPS_SCRIPT_TOKEN");

      if (!appsScriptUrl || !appsScriptToken) {
        console.error("Segredos do Apps Script não configurados.");
        return resposta(
          {
            ok: false,
            message:
              "A integração NPS ainda não está configurada no servidor.",
          },
          500,
        );
      }

      const formulario = new URLSearchParams({
        action,
        token: appsScriptToken,
      });

      let appsResponse: Response;

      try {
        appsResponse = await fetch(appsScriptUrl, {
          method: "POST",
          headers: {
            "Content-Type":
              "application/x-www-form-urlencoded;charset=UTF-8",
          },
          body: formulario.toString(),
          redirect: "follow",
          signal: AbortSignal.timeout(120_000),
        });
      } catch (error) {
        console.error("Falha de comunicação com Apps Script:", error);
        return resposta(
          {
            ok: false,
            message:
              "Não foi possível comunicar com o serviço da Blitz NPS.",
          },
          502,
        );
      }

      const raw = await appsResponse.text();

      let appsData: Record<string, any>;

      try {
        appsData = JSON.parse(raw);
      } catch {
        console.error(
          "Resposta não JSON do Apps Script:",
          raw.slice(0, 500),
        );
        return resposta(
          {
            ok: false,
            message:
              "O Apps Script retornou uma resposta inesperada.",
          },
          502,
        );
      }

      if (!appsResponse.ok) {
        console.error(
          "Erro HTTP do Apps Script:",
          appsResponse.status,
          appsData,
        );
        return resposta(
          {
            ok: false,
            message:
              appsData.message ??
              `O Apps Script retornou HTTP ${appsResponse.status}.`,
          },
          502,
        );
      }

      const resultado = (appsData.data ?? appsData) as Record<
        string,
        unknown
      >;

      console.log(
        JSON.stringify({
          evento: "nps_blitz",
          action,
          usuario_id: userId,
          usuario_email: perfil.email,
          ok: Boolean(appsData.ok),
          rascunhos: numeroSeguro(
            resultado.totalRascunhosCriados,
          ),
          contatos: numeroSeguro(
            resultado.totalContatosProcessados,
          ),
          data_hora: new Date().toISOString(),
        }),
      );

      return resposta({
        ok: Boolean(appsData.ok),
        action,
        message:
          appsData.message ??
          resultado.mensagem ??
          "Processamento concluído.",
        data: {
          tipo: resultado.tipo ?? action,
          rascunhoId: resultado.rascunhoId ?? null,
          enviadoPara: resultado.enviadoPara ?? null,
          totalContatosEncontrados: numeroSeguro(
            resultado.totalContatosEncontrados,
          ),
          totalContatosParaRascunho: numeroSeguro(
            resultado.totalContatosParaRascunho,
          ),
          totalContatosProcessados: numeroSeguro(
            resultado.totalContatosProcessados,
          ),
          totalRascunhosCriados: numeroSeguro(
            resultado.totalRascunhosCriados,
          ),
          totalIgnorado: numeroSeguro(
            resultado.totalIgnorado,
          ),
          totalDuplicado: numeroSeguro(
            resultado.totalDuplicado,
          ),
          totalJaProcessado: numeroSeguro(
            resultado.totalJaProcessado,
          ),
          totalEmailInvalido: numeroSeguro(
            resultado.totalEmailInvalido,
          ),
          totalErro: numeroSeguro(resultado.totalErro),
        },
      });
    },
  ),
};
