# Deployment Guide - Dental Pro Growth

## Local Deployment with Docker Compose

This guide walks you through setting up and running the full Dental Pro Growth stack locally.

### Prerequisites

- [Docker](https://www.docker.com/products/docker-desktop) (v20.10+)
- [Docker Compose](https://docs.docker.com/compose/install/) (v1.29+)
- [Git](https://git-scm.com/)
- At least 4GB RAM available for Docker

### Quick Start (5 minutes)

#### 1. Clone the repository

```bash
git clone https://github.com/Woodbury149/Dental-Pro-Growth.git
cd Dental-Pro-Growth
```

#### 2. Set up environment variables

```bash
cp .env.example .env.local
```

Edit `.env.local` and update these essential variables:

```bash
# Server
NODE_ENV=development
PORT=5000
CLIENT_URL=http://localhost:3000

# Database
MONGODB_URI=mongodb://root:rootpassword@mongodb:27017/dental-pro-growth
MONGODB_PASSWORD=rootpassword

# JWT
JWT_SECRET=your_secure_secret_key_here_change_this

# Optional services (leave as-is for local testing)
STRIPE_SECRET_KEY=sk_test_your_test_key
EMAIL_USER=your-email@gmail.com
EMAIL_PASSWORD=your-app-password
```

#### 3. Deploy with Docker Compose

```bash
docker-compose up -d
```

This will start all services:
- **MongoDB** - Database (port 27017)
- **Redis** - Cache (port 6379)
- **Backend** - API Server (port 5000)
- **Nginx** - Reverse Proxy (ports 80/443)

#### 4. Verify services are running

```bash
docker-compose ps
```

You should see all containers running:

```
NAME                           STATUS
dentalbrightpath-db-1         Up (healthy)
dentalbrightpath-redis-1      Up (healthy)
dentalbrightpath-api-1        Up (healthy)
dentalbrightpath-nginx-1      Up
```

#### 5. Access the application

- **Frontend**: http://localhost (or http://localhost:80)
- **Backend API**: http://localhost:5000
- **API Health Check**: http://localhost:5000/health
- **MongoDB**: mongodb://localhost:27017
- **Redis CLI**: `docker exec -it dental-pro-growth-redis redis-cli`

### Useful Commands

#### View logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f backend
docker-compose logs -f nginx
```

#### Stop services

```bash
# Stop all services (keeps data)
docker-compose stop

# Stop and remove containers (keeps volumes)
docker-compose down

# Stop and remove everything (deletes data)
docker-compose down -v
```

#### Restart services

```bash
# Restart all
docker-compose restart

# Restart specific service
docker-compose restart backend
```

#### Build images locally

```bash
# Rebuild all images
docker-compose build

# Rebuild and restart
docker-compose up -d --build
```

#### Access container shell

```bash
# Backend shell
docker exec -it dental-pro-growth-api /bin/sh

# MongoDB shell
docker exec -it dental-pro-growth-db mongosh

# Redis CLI
docker exec -it dental-pro-growth-redis redis-cli
```

### Development Workflow

#### Making changes to backend

1. Edit files in `src/` directory
2. Changes auto-reload via nodemon
3. Check logs: `docker-compose logs -f backend`

#### Making changes to frontend

1. Edit files in `frontend/src/` directory
2. Rebuild if needed: `docker-compose build --no-cache frontend`
3. Restart: `docker-compose restart backend`

#### Database access

```bash
# Access MongoDB
docker exec -it dental-pro-growth-db mongosh
use dental-pro-growth
db.patients.find() # View patients collection
```

### Troubleshooting

#### Port already in use

```bash
# Check what's using port 5000
lsof -i :5000

# Kill process (macOS/Linux)
kill -9 <PID>

# On Windows
netstat -ano | findstr :5000
taskkill /PID <PID> /F
```

#### Containers failing to start

```bash
# Check logs
docker-compose logs backend

# Rebuild from scratch
docker-compose down -v
docker system prune -a
docker-compose up -d --build
```

#### Database connection issues

```bash
# Verify MongoDB is healthy
docker-compose exec mongodb mongosh --eval "db.adminCommand('ping')"

# Check connection string in .env.local
```

#### Memory issues

```bash
# Increase Docker resources:
# - Desktop: Preferences > Resources > Memory (set to 4GB+)
# - Linux: Already uses host resources
```

### Production Deployment

For production deployment, see:
- **Vercel**: `vercel.json`
- **Netlify**: `netlify.toml`
- **AWS/Azure**: Use the `Dockerfile` for containerized deployment

### CI/CD Pipeline

GitHub Actions automatically:
- Runs tests on every push to `main` or `develop`
- Builds Docker image and pushes to GitHub Container Registry
- Deploys to staging on `develop` branch
- Deploys to production on `main` branch

See `.github/workflows/ci.yml` for details.

### Health Checks

The application includes health checks for all services:

```bash
# Backend health
curl http://localhost:5000/health

# Expected response
{
  "status": "ok",
  "timestamp": "2026-06-06T20:30:00Z",
  "uptime": 1234.56
}
```

### Security Notes

⚠️ **Local Development Only**

- Change `JWT_SECRET` in `.env.local`
- Don't commit `.env.local` to git
- Use strong passwords for MongoDB
- SSL certificates are self-signed in local setup

✅ **For Production**

- Use environment variables from your hosting provider
- Generate proper SSL/TLS certificates
- Enable authentication on Redis
- Set up database backups
- Use strong, unique secrets

### Next Steps

1. ✅ Run locally with Docker Compose
2. 📝 Create `.env.local` with your configuration
3. 🧪 Run tests: `docker-compose exec backend npm test`
4. 📦 Deploy to staging/production
5. 🚀 Monitor with health checks and logs

### Support

For issues or questions:
- 📧 Email: support@dentalprogrowtsh.com
- 🐛 GitHub Issues: [Report a bug](https://github.com/Woodbury149/Dental-Pro-Growth/issues)
- 📖 Documentation: [Full docs](https://docs.dentalprogrowtsh.com)

---

**Last Updated**: June 2026
