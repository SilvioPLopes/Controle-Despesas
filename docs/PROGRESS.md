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
- Pendências: `.github/copilot-instructions.md` não existe neste checkout; as regras técnicas do plano e o contrato da seção 10 foram usados. Resta integrar com API real e ligar as rotas à sessão de autenticação implementada em M3.
