# learning-moonshot

Component | Link
----------| -----
GH Pages | https://aiverify-foundation.github.io/moonshot/
Installation | https://aiverify-foundation.github.io/moonshot/getting_started/quick_install/
Starter Kit | https://aiverify-foundation.github.io/moonshot/getting_started/starter_kit/
API Reference | https://aiverify-foundation.github.io/moonshot/api_reference/web_api_swagger/
GitHub | https://github.com/aiverify-foundation/moonshot

## Docker Setup

Two deployment modes are available via Docker Compose profiles, both running on Linux (avoids OS conflicts on Windows/Mac).

### Full deployment — UI + API

Runs the web UI on port 3000 and the web API on port 5000.

```bash
docker compose --profile full up --build
```

- UI: http://localhost:3000 (Chrome recommended)
- API: http://localhost:5000/docs (Swagger)

### API-only deployment

Runs just the web API on port 5000. No Node.js, no UI — smaller image.

```bash
docker compose --profile api up --build
```

- API: http://localhost:5000/docs (Swagger)

### Files

| File | Purpose |
|------|---------|
| `Dockerfile` | Full deployment (UI + API). Installs Node.js, all Python deps, moonshot-data + moonshot-ui. |
| `Dockerfile.api` | API-only. Installs only `aiverify-moonshot[web-api]` and moonshot-data. No Node.js. |
| `docker-compose.yml` | Defines both services with `full` and `api` profiles. |

### Notes

- First build downloads several GB of ML dependencies (PyTorch, TensorFlow, CUDA libs) — expect 15-30 min.
- Subsequent builds reuse the pip cache layer and are faster.
- `moonshot-data` is persisted in a named Docker volume so it survives container restarts.
