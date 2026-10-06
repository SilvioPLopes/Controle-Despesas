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
- Status: concluída
- Requisitos atendidos: MOB-01 e MOB-02 (fluxos locais, validação, restauração e redirecionamento)
- Decisões: os exemplos de payload e respostas de AUTH foram adicionados à seção 10.3 do contrato; `AuthApi` e `AuthRepositoryImpl` implementam esses exemplos, o repository real tem provider alternativo e `FakeAuthRepository` continua como provider ativo até a S04 do backend. `SessionNotifier` coordena restauração, login, cadastro e logout; logout limpa tokens mesmo quando a chamada remota falha; mensagens usam `messageForCode`; esqueci a senha exibe sempre a mesma mensagem.
- Mudança de contrato: seção 10.3 agora especifica os corpos de register, login, refresh, logout, forgot-password e reset-password, incluindo `accepted_terms`, `terms_version` e status/respostas esperados.
- Validação: `flutter test` passou (36 testes); `dart analyze` sem problemas.
- Pendências: **trocar FakeAuthRepository pelo real quando a S04 do backend existir** e validar a integração contra o backend quando estiver disponível.
- Instruções: `.github/copilot-instructions.md` foi criado com o bloco da Seção 1, pois o arquivo não existia.

## M4 — Finanças (2026-10-06)
- Status: concluída
- Requisitos atendidos: FIN-01 a FIN-07; MOB-03, MOB-04 e MOB-05
- Decisões: `Decimal` permanece no domínio e no tráfego JSON; o valor é convertido para o tipo numérico exigido pelo fl_chart somente para desenhar as fatias do gráfico. `FakeFinanceRepository` é o provider ativo e `FinanceRepositoryImpl` está disponível via provider alternativo. Providers de dashboard, transações e categorias usam `AsyncNotifier`. HomeShell substitui o placeholder e as datas/material UI usam localização pt-BR.
- Mudança de contrato: seção 10.3 agora descreve filtros/paginação de transações, respostas de transação, criação/edição/exclusão e CRUD/arquivamento de categorias, conforme campos autorizados para M4.
- Validação: `flutter test` passou (46 testes); `dart analyze` sem problemas.
- Pendências: **trocar o provider fake pelo `FinanceRepositoryImpl` quando as sessões S05/S06 do backend existirem** e validar a integração contra a API real.
