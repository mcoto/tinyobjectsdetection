#!/usr/bin/env bash
set -euo pipefail

REPO="tiny-object-detection"
mkdir -p "$REPO"/{apps/{frontend,api},analytics/{notebooks,reports,dashboards},dataops/{scripts,schemas,exploration},datasets/{raw,processed,annotations},src/{core,models,training,evaluation,inference,visualization},experiments/exp_$(date +%Y%m%d)_template,results/{metrics,plots,predictions},infra/{docker,k8s,scripts},tests,docs,.github/ISSUE_TEMPLATE}
cd "$REPO"

########################################
# Archivos base
########################################


cat > CONTRIBUTING.md <<'EOF'
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
EOF

cat > requirements.txt <<'EOF'
numpy
pandas
matplotlib
opencv-python
scikit-learn
torch
torchvision
ultralytics
pyyaml
tqdm
EOF

cat > Makefile <<'EOF'
.PHONY: setup test lint format

setup:
\tpython -m venv .venv && . .venv/bin/activate && pip install -U pip && pip install -r requirements.txt

test:
\tpytest -q

lint:
\tpython -m pip install ruff && ruff check .

format:
\tpython -m pip install ruff && ruff format .
EOF

cat > LICENSE <<'EOF'
Copyright (c) 2025
All rights reserved. For research use only.
EOF

########################################
# .gitignore para datasets y artefactos
########################################
cat > .gitignore <<'EOF'
# Python
__pycache__/
*.pyc
.venv/
venv/
.env
.ipynb_checkpoints/

# Node / Frontend
node_modules/
dist/
build/

# Data (keep repo light)
datasets/**
!datasets/README.md
!datasets/**/.gitkeep
!datasets/annotations/**
datasets/**/*.zip
datasets/**/*.tar
datasets/**/*.tar.gz

# Models / weights (track with LFS if needed)
**/*.pt
**/*.pth
**/*.onnx

# Results (allow metrics, block heavy artifacts)
results/plots/
results/predictions/

# OS
.DS_Store
Thumbs.db
EOF

########################################
# Placeholders y READMEs mínimos
########################################
echo "# Datasets" > datasets/README.md
touch datasets/raw/.gitkeep datasets/processed/.gitkeep datasets/annotations/.gitkeep

for d in \
  apps apps/frontend apps/api \
  analytics analytics/notebooks analytics/reports analytics/dashboards \
  dataops dataops/scripts dataops/schemas dataops/exploration \
  src src/core src/models src/training src/evaluation src/inference src/visualization \
  experiments results results/metrics results/plots results/predictions \
  infra infra/docker infra/k8s infra/scripts \
  tests docs
do
  [ -d "$d" ] || mkdir -p "$d"
  echo "# $(basename "$d")" > "$d/README.md"
done

########################################
# Semillas de código / plantillas
########################################
cat > dataops/scripts/download_data.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
# Download or sync datasets here (do not commit raw data).
echo "Implement dataset download here."
EOF
chmod +x dataops/scripts/download_data.sh

cat > src/training/train_template.py <<'EOF'
def main():
    print("Training template - replace with your pipeline.")

if __name__ == "__main__":
    main()
EOF

cat > src/evaluation/evaluate_template.py <<'EOF'
def main():
    print("Evaluation template - compute metrics (precision/recall/mAP).")

if __name__ == "__main__":
    main()
EOF

cat > src/inference/infer_template.py <<'EOF'
def main():
    print("Inference template - load model and run detection on sample images.")

if __name__ == "__main__":
    main()
EOF

cat > apps/api/README.md <<'EOF'
# API
Recommended: FastAPI for serving inference endpoints.
EOF

cat > apps/frontend/README.md <<'EOF'
# Frontend
Option A: React/Vite UI. Option B: Streamlit app for rapid prototyping.
EOF

cat > analytics/notebooks/README.md <<'EOF'
# Notebooks
Place exploratory analysis and EDA notebooks here (avoid heavy outputs).
EOF

cat > experiments/exp_$(date +%Y%m%d)_template/README.md <<'EOF'
# Experiment Template
## Objective
## Data / Split
## Config
## Metrics
## Conclusions
EOF

########################################
# Plantillas de PR / Issues (GitHub)
########################################
cat > .github/pull_request_template.md <<'EOF'
## Purpose
## Methods / Changes
## Results (metrics, plots)
## How to Reproduce
## Checklist
- [ ] Code runs end-to-end
- [ ] No large binaries committed
- [ ] Docs/README updated
EOF

cat > .github/ISSUE_TEMPLATE/bug_report.md <<'EOF'
---
name: Bug report
about: Report a problem
title: "[BUG]"
labels: bug
assignees: ""
---
**Describe the bug**
**To Reproduce**
**Expected behavior**
**Environment**
EOF

cat > .github/ISSUE_TEMPLATE/feature_request.md <<'EOF'
---
name: Feature request
about: Suggest an enhancement
title: "[FEATURE]"
labels: enhancement
assignees: ""
---
**Describe the feature**
**Why is it needed?**
**Proposed solution**
EOF

########################################
# Git init
########################################
git init
git add .
git commit -m "Scaffold research monorepo structure"
echo "✅ Repository scaffold created in: $(pwd)"

