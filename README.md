# Chatwoot Assessment - Developer Setup Guide

This README provides a complete guide to setup the project for local development and testing.

---

## Prerequisites

| Tool | Version |
| ---- | ------- |
| Ruby | 3.3.3 |
| Rails | 7.0.8.7 |
| Node.js | 22.x (or 23.x if supported by pnpm) |
| pnpm | 10.x |
| PostgreSQL | 14+ |
| Redis | 6+ |
| Yarn | *(optional if using pnpm)* |
| Overmind | latest |
| Foreman | latest |
| Docker | optional for DB |
| rbenv | recommended for Ruby version management |

---

## Installation Steps

### 1. Clone the repository

```bash
git clone <your-fork-url>
cd chatwoot-omnifylabs
```

### 2. Setup Ruby

```bash
rbenv install 3.3.3
rbenv local 3.3.3
gem install bundler
bundle install
```

### 3. Setup Node.js and Frontend dependencies

```bash
pnpm install
```

#### If using nvm, use

```bash
nvm install 22
nvm use 22
```

### 4. Setup Database

```bash
bundle exec rails db:setup
bundle exec rails db:migrate
```

> For PostgreSQL

```bash
brew install postgresql
brew services start postgresql
```

### 5. Setup Redis

```bash
brew install redis
brew services start redis
```

### 6. Setup ENV variables

```bash
cp .env.example .env
```

Edit .env as required for:
 • PostgreSQL credentials
 • Redis
 • Frontend BASE_URL
 • Storage configs

### 7 Running the application locally

Full development mode - Starts backend, frontend (Vite), worker & websocket

```bash
pnpm run dev
```

individual processes

```
# Backend
bundle exec rails s

# Frontend (Vite)
pnpm run story:dev

# Background worker
bundle exec sidekiq
```

| Problem | Solution |
| ---- | ------- |
| Address already in use - bind(2) | Kill conflicting processes using port 3000 or 3036 |
| vite-dev Failed to resolve import | Ensure correct casing for imports after renames|
| redis-server not found | Install redis via brew install redis |
| sentimental gem not found | bundle install |

## Testing Core Functionality

 • Create new conversation via widget ✅
 • Verify sentiment enrichment works ✅
 • Verify AI Agent renamed flow works ✅
 • Verify Topic renamed flow works ✅
