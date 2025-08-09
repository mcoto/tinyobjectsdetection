# Contributing Guidelines

## Workflow
1. **Fork** this repository.
2. Create a **feature branch**: `git checkout -b feature/<scope>-<brief-desc>`.
3. Keep code **modular**, **documented**, and **reproducible**.
4. Add tests where relevant (`tests/`).
5. Update docs if you change interfaces/behavior.
6. Open a **Pull Request** with:
   - Purpose and context
   - Methods / changes
   - Results (metrics/plots)
   - How to reproduce

## Code Organization
- DataOps → `dataops/`
- Models/Training/Eval/Inference → `src/`
- Analytics (EDA, reports, dashboards) → `analytics/`
- Frontend/UI → `apps/frontend/`
- API/serving → `apps/api/`
- Experiments → `experiments/exp_YYYYMMDD_name/`

## Data Policy
- **Do not commit large datasets or model binaries.**
- Provide download scripts (`dataops/scripts/`) and metadata.
- `datasets/annotations/` may include lightweight labels.
