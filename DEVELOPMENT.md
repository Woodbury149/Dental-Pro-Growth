# Development Guide - Dental Pro Growth

## Local Development Setup

This guide covers setting up a development environment for contributing to Dental Pro Growth.

### Prerequisites

- Node.js 18+ and npm 9+
- Docker & Docker Compose (for services)
- Git
- Code editor (VS Code recommended)

### Initial Setup

```bash
# Clone repository
git clone https://github.com/Woodbury149/Dental-Pro-Growth.git
cd Dental-Pro-Growth

# Install dependencies
npm install
cd frontend && npm install && cd ..

# Set up environment
cp .env.example .env.local

# Start Docker services (database, cache)
docker-compose up -d mongodb redis nginx

# Start development servers
npm run dev
```

The app will be available at:
- Frontend: http://localhost:3000
- Backend: http://localhost:5000

### Directory Structure

```
dentalbrightpath/
├── frontend/              # React application
│   ├── src/
│   │   ├── components/   # React components
│   │   ├── pages/        # Page components
│   │   ├── hooks/        # Custom hooks
│   │   ├── context/      # Context providers
│   │   └── utils/        # Utility functions
│   └── package.json
├── src/                   # Backend source code
│   ├── routes/           # API routes
│   ├── middleware/        # Express middleware
│   ├── models/           # Database models
│   ├── controllers/      # Route controllers
│   └── utils/            # Utility functions
├── .github/
│   └── workflows/        # GitHub Actions CI/CD
├── nginx.conf            # Nginx configuration
├── Dockerfile            # Docker image definition
├── docker-compose.yml    # Multi-container setup
├── package.json          # Backend dependencies
└── server.js             # Backend entry point
```

### Development Scripts

```bash
# Backend only
npm run server

# Frontend only
cd frontend && npm start

# Both backend and frontend
npm run dev

# Build for production
npm run build

# Run tests
npm test

# Run linter
npm run lint

# Fix lint issues
npm run lint:fix

# Docker commands
npm run docker:build   # Build Docker image
npm run docker:run     # Run Docker container
```

### Code Style & Linting

We use ESLint and Prettier for code consistency.

```bash
# Lint all files
npm run lint

# Auto-fix issues
npm run lint:fix

# Format code
npx prettier --write .
```

### Testing

```bash
# Run all tests
npm test

# Run with coverage
npm test -- --coverage

# Watch mode
npm test -- --watch

# E2E tests (Cypress)
npm run test:e2e
```

### Git Workflow

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make changes and commit**
   ```bash
   git add .
   git commit -m "feat: add new feature"
   ```

3. **Push and create pull request**
   ```bash
   git push origin feature/your-feature-name
   ```

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `style:` Code style changes
- `refactor:` Code refactoring
- `test:` Adding/updating tests
- `chore:` Maintenance tasks

Example:
```bash
git commit -m "feat: add patient search functionality"
```

### Environment Variables

Create `.env.local` for local development:

```bash
NODE_ENV=development
PORT=5000
CLIENT_URL=http://localhost:3000
MONGODB_URI=mongodb://root:rootpassword@localhost:27017/dental-pro-growth
REDIS_URL=redis://localhost:6379
JWT_SECRET=dev-secret-key-change-in-production
```

### Database Management

```bash
# Access MongoDB
docker exec -it dental-pro-growth-db mongosh

# View databases
show dbs

# Switch database
use dental-pro-growth

# View collections
show collections

# Sample queries
db.patients.find()
db.appointments.find()
db.users.find()
```

### Debugging

#### Backend

```bash
# With Node Inspector
node --inspect server.js

# In VS Code, add to .vscode/launch.json:
{
  "type": "node",
  "request": "attach",
  "name": "Attach",
  "port": 9229
}
```

#### Frontend

- Open Chrome DevTools (F12)
- Use React Developer Tools browser extension
- Set breakpoints in Sources tab

### Common Issues

**Port 5000 already in use**
```bash
lsof -i :5000
kill -9 <PID>
```

**MongoDB connection failed**
```bash
docker-compose restart mongodb
```

**Node modules issues**
```bash
rm -rf node_modules package-lock.json
npm install
```

### Performance Tips

1. **Frontend optimization**
   - Use React DevTools Profiler
   - Code-split with React.lazy()
   - Memoize expensive components

2. **Backend optimization**
   - Use indexes in MongoDB
   - Cache with Redis
   - Profile with --inspect flag

3. **Database optimization**
   ```bash
   # Create indexes
   db.patients.createIndex({ email: 1 })
   db.appointments.createIndex({ patientId: 1, date: 1 })
   ```

### Resources

- [React Docs](https://react.dev)
- [Express.js Guide](https://expressjs.com/)
- [MongoDB Documentation](https://docs.mongodb.com/)
- [Docker Compose Docs](https://docs.docker.com/compose/)

---

**Need help?** Check GitHub Issues or contact the team.
