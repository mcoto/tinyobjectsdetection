.PHONY: setup test lint format

setup:
\tpython -m venv .venv && . .venv/bin/activate && pip install -U pip && pip install -r requirements.txt

test:
\tpytest -q

lint:
\tpython -m pip install ruff && ruff check .

format:
\tpython -m pip install ruff && ruff format .
