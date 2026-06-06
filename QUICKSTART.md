# Quick Start - Dental Pro Growth

## 🚀 One-Command Setup

Get Dental Pro Growth running in **< 5 minutes**:

```bash
# 1. Clone
git clone https://github.com/Woodbury149/Dental-Pro-Growth.git && cd Dental-Pro-Growth

# 2. Setup
cp .env.example .env.local

# 3. Deploy
docker-compose up -d

# 4. Done! 🎉
# Frontend: http://localhost
# API: http://localhost:5000/health
```

## ✅ Verify Installation

```bash
# Check all services
docker-compose ps

# Test backend
curl http://localhost:5000/health

# View logs
docker-compose logs -f
```

## 📋 What You Get

- ✅ **React Frontend** - Modern practice dashboard
- ✅ **Node.js Backend** - RESTful API server
- ✅ **MongoDB** - Patient & appointment data
- ✅ **Redis** - Session caching
- ✅ **Nginx** - Reverse proxy (SSL-ready)
- ✅ **Docker** - Fully containerized

## 🎯 Next Steps

1. **Explore the API** → Visit http://localhost:5000/api/health
2. **View Frontend** → Visit http://localhost
3. **Check Logs** → `docker-compose logs backend`
4. **Read Docs** → See `DEPLOYMENT.md` & `DEVELOPMENT.md`

## 📞 Need Help?

```bash
# Stop everything
docker-compose down

# Restart
docker-compose up -d

# View issues
docker-compose logs
```

**Full guide**: See [DEPLOYMENT.md](./DEPLOYMENT.md)
