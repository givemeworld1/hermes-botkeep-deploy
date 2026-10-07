# Hermes Agent — Botkeep Deployment

A minimal source package for deploying the [Hermes](https://hermes-agent.nousresearch.com)
messaging gateway to [Botkeep](https://botkeep.cloud).

This repo is the Hermes source (trimmed to the runtime essentials) plus:

- `requirements.txt` — pip dependencies (Botkeep auto-detects this)
- `main.py` — start command entry point (runs `hermes gateway run`)
- `Dockerfile` — optional, for Docker-based runtimes
- `botkeep.yml` — reference configuration notes

---

## How to deploy on Botkeep

1. **Connect the repo** — Botkeep → GitHub tab → authorise the Botkeep
   GitHub App for `givemeworld1/hermes-botkeep-deploy` (repo is private).
2. **Pick branch** `master`.
3. **Runtime** — Botkeep should detect Python from `requirements.txt`.
   If asked for a start command, use:
   ```
   python main.py
   ```
4. **Resource pool** — Hermes is heavier than a typical bot. Assign
   enough RAM/CPU from your account pool (2 GB / 1.5 vCore recommended).

## Secrets to set (Botkeep → Secrets)

Hermes needs at minimum:
- **An LLM provider** — e.g. `OPENROUTER_API_KEY`, `OPENAI_API_KEY`,
  `ANTHROPIC_API_KEY`, or a Nous portal login. See `.env.example` for the
  full list of supported providers.
- **A messaging platform token** — e.g. `DISCORD_TOKEN`, `TELEGRAM_BOT_TOKEN`.

> ⚠️ Botkeep does not ship a managed `.env` for Python — load credentials
> from environment variables (Botkeep injects secrets as env vars). `main.py`
> already sets `HERMES_HOME` to a writable local dir.

## Caveats

- **Python version**: Hermes targets Python 3.14. Confirm the version
  Botkeep's creation form offers; if it ships < 3.14, the pinned deps and
  some source syntax may fail. In that case, use the `Dockerfile` path or
  pin a `python_version` that matches the lock file.
- **Gateway setup**: `hermes gateway run` assumes an enrolled/configured
  profile. A truly fresh gateway may need `hermes gateway setup` (interactive)
  first — provide pre-configured state (config + tokens) via secrets/files.
- **Verify after deploy**: Botkeep acceptance ≠ readiness. Check the Console
  logs for a successful gateway start (bot logged in, no restart loop).

## Local test

```bash
pip install -r requirements.txt
python main.py            # should start the messaging gateway
```
