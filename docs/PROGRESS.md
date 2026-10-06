# Progresso

## S00 — Monorepo, Docker Compose e CI (partes 1 e 3 de 4) (2026-10-06)
- Status: parcial
- Requisitos atendidos: parte de RNF-14 / D05 (estrutura do monorepo e backend mínimo); RNF-09 (`/health`)
- Decisões: app em `create_app()`; health em `app/modules/plat/router.py`; dependências mínimas por ora
- CI (parte 3): `.github/workflows/backend-ci.yml` roda ruff, ruff format, mypy e pytest com cobertura mínima de 80%. service container Postgres 15 já no CI (ainda sem testes que o usem; `DATABASE_URL` pronta para a S01); Redis entra quando for usado
- Problemas encontrados (não corrigidos): —
- Pendências para próximas sessões: Docker Compose (parte 2), `flutter create` (parte 4); CI rodar de fato no GitHub (depende do push)

## M2 — Núcleo do app (2026-10-06)
- Status: concluída
- Requisitos atendidos: MOB-11, D01 e RNF-11
- Decisões: Dio separado para refresh, refresh único compartilhado entre 401 simultâneos, tokens em `flutter_secure_storage`, dinheiro mantido em `Decimal`, rotas de negócio protegidas por presença de tokens; páginas ainda são placeholders
- Validação: `flutter test` passou; `dart analyze` sem problemas
- Pendências: integrar com a API real e ligar as rotas à sessão de autenticação implementada em M3.

## M3 — Autenticação (2026-10-06)
- Status: parcial — sessão, telas e repositório fake implementados; integração real bloqueada por campos de requisição ausentes no contrato
- Requisitos atendidos: MOB-01 e MOB-02 (fluxos locais, validação, restauração e redirecionamento)
- Decisões: `FakeAuthRepository` em memória é o provider ativo; `SessionNotifier` coordena restauração, login, cadastro e logout; logout limpa tokens mesmo quando a chamada remota falha; mensagens de erro usam `messageForCode`; esqueci a senha exibe sempre a mesma mensagem
- Validação: `flutter test` passou (31 testes); `dart analyze` sem problemas
- Pendências: a seção 10 lista endpoints mas não especifica os corpos de cadastro, refresh, logout, recuperação e redefinição de senha; aguardar definição desses campos antes de implementar `AuthApi` e `AuthRepositoryImpl`, sem inventar contrato. **Trocar FakeAuthRepository pelo real quando a S04 do backend existir.**
- Instruções: `.github/copilot-instructions.md` foi criado com o bloco da Seção 1, pois o arquivo não existia.
