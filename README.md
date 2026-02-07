# Valentine

A Valentine's Day web page built with Vue 3 + Vite, served via nginx in Docker.

## Features
- Photo carousel with your pictures
- Animated "Will you be my valentine?" button

## Setup

1. Drop photos into `app/public/photos/`
2. Update photo references in `app/src/components/Carousel.vue`
3. Run:
```bash
sudo docker-compose down && sudo docker-compose up --build -d
```

## CI/CD
Pushes to `main` auto-deploy via GitHub Actions. Requires these repo secrets:
- `VM_IP` — VM hostname/IP
- `VM_USER` — SSH username
- `VM_SSH_KEY` — SSH private key

> **Note:** Photos are gitignored. They must exist on the VM at `app/public/photos/` for builds to include them.