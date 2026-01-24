# Node.js & Express Interview Guide: Basic to Advanced

## Table of Contents
1. [Node.js Basics](#nodejs-basics)
2. [Express Fundamentals](#express-fundamentals)
3. [Routing & Middleware](#routing--middleware)
4. [Request & Response](#request--response)
5. [Error Handling](#error-handling)
6. [Authentication & Authorization](#authentication--authorization)
7. [Database Integration](#database-integration)
8. [Performance & Optimization](#performance--optimization)
9. [Testing](#testing)
10. [Advanced Concepts](#advanced-concepts)

---

## NODE.JS BASICS

### Q1: What is Node.js and what are its key features?

**Answer:**
Node.js is a JavaScript runtime built on Chrome's V8 engine that allows running JavaScript on the server-side. Key features include:

- **Event-driven**: Non-blocking I/O model
- **Single-threaded**: Uses event loop for concurrency
- **NPM**: Largest package ecosystem
- **Fast execution**: V8 engine compilation
- **Scalable**: Handles thousands of concurrent connections
- **Cross-platform**: Runs on Windows, Linux, macOS

```javascript
// Simple Node.js server
const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello World');
});

server.listen(3000, () => {
  console.log('Server running on port 3000');
});
```

### Q2: What is the event loop in Node.js?

**Answer:**
The event loop is the core of Node.js that handles asynchronous operations and callbacks.

```javascript
// Event loop phases:
// 1. timers - execute setTimeout/setInterval callbacks
// 2. pending callbacks - execute deferred I/O callbacks
// 3. idle, prepare - internal use
// 4. poll - retrieve new I/O events
// 5. check - execute setImmediate callbacks
// 6. close callbacks - close callbacks

// Example
console.log('Start');

setTimeout(() => {
  console.log('setTimeout');
}, 0);

setImmediate(() => {
  console.log('setImmediate');
});

Promise.resolve().then(() => {
  console.log('Promise');
});

console.log('End');

// Output:
// Start
// End
// Promise
// setTimeout
// setImmediate
```

### Q3: What is the difference between require and import?

**Answer:**

| Feature | require | import |
|---------|---------|--------|
| Type | CommonJS | ES6 Module |
| Syntax | require('module') | import x from 'module' |
| Loading | Runtime | Compile-time |
| Caching | Cached | Cached |
| Circular deps | Handled | Error |

```javascript
// CommonJS (require)
const express = require('express');
const { Router } = require('express');
module.exports = app;

// ES6 Modules (import)
import express from 'express';
import { Router } from 'express';
export default app;

// Mixed usage (with .mjs or "type": "module" in package.json)
import express from 'express';
const app = express();
export default app;
```

### Q4: What are streams in Node.js?

**Answer:**
Streams are objects that let you read data from a source or write data to a destination in chunks.

```javascript
const fs = require('fs');

// Readable stream
const readStream = fs.createReadStream('file.txt', {
  encoding: 'utf8',
  highWaterMark: 16 * 1024 // 16KB chunks
});

readStream.on('data', (chunk) => {
  console.log('Received chunk:', chunk.length);
});

readStream.on('end', () => {
  console.log('Stream ended');
});

readStream.on('error', (error) => {
  console.log('Error:', error);
});

// Writable stream
const writeStream = fs.createWriteStream('output.txt');

writeStream.write('Hello ');
writeStream.write('World');
writeStream.end();

writeStream.on('finish', () => {
  console.log('Write complete');
});

// Pipe - connect readable to writable
fs.createReadStream('input.txt')
  .pipe(fs.createWriteStream('output.txt'));

// Transform stream
const { Transform } = require('stream');

const uppercase = new Transform({
  transform(chunk, encoding, callback) {
    this.push(chunk.toString().toUpperCase());
    callback();
  }
});

fs.createReadStream('input.txt')
  .pipe(uppercase)
  .pipe(fs.createWriteStream('output.txt'));
```

### Q5: What is the difference between process.nextTick and setImmediate?

**Answer:**

```javascript
// process.nextTick - executes in current phase
// setImmediate - executes in check phase (next iteration)

console.log('Start');

process.nextTick(() => {
  console.log('nextTick');
});

setImmediate(() => {
  console.log('setImmediate');
});

console.log('End');

// Output:
// Start
// End
// nextTick
// setImmediate

// In I/O cycle
const fs = require('fs');

fs.readFile(__filename, () => {
  setTimeout(() => {
    console.log('setTimeout');
  }, 0);
  
  setImmediate(() => {
    console.log('setImmediate');
  });
  
  process.nextTick(() => {
    console.log('nextTick');
  });
});

// Output:
// nextTick
// setImmediate
// setTimeout
```



---

## EXPRESS FUNDAMENTALS

### Q6: What is Express.js and how do you create a basic server?

**Answer:**
Express is a minimal and flexible Node.js web application framework that provides a robust set of features for web and mobile applications.

```javascript
const express = require('express');
const app = express();

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.get('/', (req, res) => {
  res.send('Hello World');
});

app.post('/users', (req, res) => {
  const user = req.body;
  res.status(201).json({ message: 'User created', user });
});

// Error handling
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something went wrong' });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

### Q7: What are middleware functions in Express?

**Answer:**
Middleware functions are functions that have access to request, response, and next middleware function.

```javascript
// Basic middleware
app.use((req, res, next) => {
  console.log('Request received');
  next(); // Pass to next middleware
});

// Middleware with specific route
app.get('/users', (req, res, next) => {
  console.log('GET /users');
  next();
}, (req, res) => {
  res.json({ users: [] });
});

// Error handling middleware (4 parameters)
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ error: err.message });
});

// Custom middleware
const authenticate = (req, res, next) => {
  const token = req.headers.authorization;
  if (!token) {
    return res.status(401).json({ error: 'No token' });
  }
  req.user = { id: 1 }; // Verify token
  next();
};

app.get('/protected', authenticate, (req, res) => {
  res.json({ message: 'Protected route', user: req.user });
});

// Middleware execution order
app.use(express.json());
app.use(authenticate);
app.use(logRequest);

app.get('/data', (req, res) => {
  res.json({ data: 'value' });
});
```

### Q8: How do you handle routing in Express?

**Answer:**
Express provides methods for defining routes for different HTTP methods.

```javascript
// Basic routing
app.get('/users', (req, res) => {
  res.json({ users: [] });
});

app.post('/users', (req, res) => {
  res.status(201).json({ message: 'User created' });
});

app.put('/users/:id', (req, res) => {
  res.json({ message: 'User updated' });
});

app.delete('/users/:id', (req, res) => {
  res.json({ message: 'User deleted' });
});

// Route parameters
app.get('/users/:id', (req, res) => {
  const id = req.params.id;
  res.json({ id });
});

// Query parameters
app.get('/search', (req, res) => {
  const query = req.query.q;
  res.json({ query });
});

// Route handlers
app.get('/users', 
  (req, res, next) => {
    console.log('Handler 1');
    next();
  },
  (req, res) => {
    console.log('Handler 2');
    res.json({ users: [] });
  }
);

// Router
const router = express.Router();

router.get('/', (req, res) => {
  res.json({ users: [] });
});

router.post('/', (req, res) => {
  res.status(201).json({ message: 'Created' });
});

app.use('/users', router);
```

### Q9: How do you handle errors in Express?

**Answer:**
Express provides error handling middleware and try-catch for async operations.

```javascript
// Error handling middleware
app.use((err, req, res, next) => {
  const status = err.status || 500;
  const message = err.message || 'Internal Server Error';
  
  res.status(status).json({
    error: {
      status,
      message
    }
  });
});

// Async error handling
app.get('/users/:id', async (req, res, next) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.json(user);
  } catch (error) {
    next(error); // Pass to error handler
  }
});

// Wrapper for async routes
const asyncHandler = (fn) => (req, res, next) => {
  Promise.resolve(fn(req, res, next)).catch(next);
};

app.get('/users/:id', asyncHandler(async (req, res) => {
  const user = await User.findById(req.params.id);
  res.json(user);
}));

// Custom error class
class AppError extends Error {
  constructor(message, status) {
    super(message);
    this.status = status;
  }
}

app.get('/users/:id', asyncHandler(async (req, res) => {
  const user = await User.findById(req.params.id);
  if (!user) {
    throw new AppError('User not found', 404);
  }
  res.json(user);
}));
```

### Q10: What is CORS and how do you enable it in Express?

**Answer:**
CORS (Cross-Origin Resource Sharing) allows requests from different origins.

```javascript
const cors = require('cors');

// Enable CORS for all routes
app.use(cors());

// Enable CORS for specific route
app.get('/users', cors(), (req, res) => {
  res.json({ users: [] });
});

// Custom CORS options
app.use(cors({
  origin: 'http://localhost:3000',
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));

// CORS for specific origins
const corsOptions = {
  origin: function(origin, callback) {
    const whitelist = ['http://localhost:3000', 'http://localhost:3001'];
    if (whitelist.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  }
};

app.get('/users', cors(corsOptions), (req, res) => {
  res.json({ users: [] });
});
```



---

## AUTHENTICATION & AUTHORIZATION

### Q11: What is JWT and how do you implement it?

**Answer:**
JWT (JSON Web Token) is a stateless authentication mechanism that encodes user information in a token.

```javascript
const jwt = require('jsonwebtoken');

// Generate JWT
const token = jwt.sign(
  { userId: 1, email: 'john@example.com' },
  'secret-key',
  { expiresIn: '1h' }
);

// Verify JWT
jwt.verify(token, 'secret-key', (err, decoded) => {
  if (err) {
    console.log('Invalid token');
  } else {
    console.log(decoded);
  }
});

// Middleware for JWT authentication
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  
  if (!token) {
    return res.status(401).json({ error: 'No token' });
  }
  
  jwt.verify(token, 'secret-key', (err, user) => {
    if (err) {
      return res.status(403).json({ error: 'Invalid token' });
    }
    req.user = user;
    next();
  });
};

// Login route
app.post('/login', (req, res) => {
  const user = { userId: 1, email: 'john@example.com' };
  const token = jwt.sign(user, 'secret-key', { expiresIn: '1h' });
  res.json({ token });
});

// Protected route
app.get('/protected', authenticateToken, (req, res) => {
  res.json({ message: 'Protected data', user: req.user });
});

// Refresh token
app.post('/refresh', (req, res) => {
  const { refreshToken } = req.body;
  
  jwt.verify(refreshToken, 'refresh-secret', (err, user) => {
    if (err) {
      return res.status(403).json({ error: 'Invalid refresh token' });
    }
    
    const newToken = jwt.sign(
      { userId: user.userId },
      'secret-key',
      { expiresIn: '1h' }
    );
    
    res.json({ token: newToken });
  });
});
```

### Q12: What is session-based authentication?

**Answer:**
Session-based authentication stores user information on the server and uses cookies to track sessions.

```javascript
const session = require('express-session');
const MongoStore = require('connect-mongo');

// Configure session
app.use(session({
  secret: 'secret-key',
  resave: false,
  saveUninitialized: false,
  store: new MongoStore({ mongoUrl: 'mongodb://localhost/sessions' }),
  cookie: {
    secure: true,
    httpOnly: true,
    maxAge: 1000 * 60 * 60 * 24 // 24 hours
  }
}));

// Login
app.post('/login', (req, res) => {
  const user = { id: 1, email: 'john@example.com' };
  req.session.user = user;
  res.json({ message: 'Logged in' });
});

// Check session
app.get('/profile', (req, res) => {
  if (!req.session.user) {
    return res.status(401).json({ error: 'Not authenticated' });
  }
  res.json({ user: req.session.user });
});

// Logout
app.post('/logout', (req, res) => {
  req.session.destroy((err) => {
    if (err) {
      return res.status(500).json({ error: 'Logout failed' });
    }
    res.json({ message: 'Logged out' });
  });
});

// Session vs JWT:
// Session: Stateful, server stores data, more secure for sensitive data
// JWT: Stateless, client stores token, better for scalability
```

### Q13: How do you handle file uploads in Express?

**Answer:**
File uploads can be handled using multer middleware.

```javascript
const multer = require('multer');
const path = require('path');

// Configure storage
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname));
  }
});

// File filter
const fileFilter = (req, file, cb) => {
  const allowedMimes = ['image/jpeg', 'image/png', 'application/pdf'];
  
  if (allowedMimes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error('Invalid file type'));
  }
};

// Create upload middleware
const upload = multer({
  storage,
  fileFilter,
  limits: { fileSize: 5 * 1024 * 1024 } // 5MB
});

// Single file upload
app.post('/upload', upload.single('file'), (req, res) => {
  res.json({
    message: 'File uploaded',
    file: req.file
  });
});

// Multiple file upload
app.post('/upload-multiple', upload.array('files', 5), (req, res) => {
  res.json({
    message: 'Files uploaded',
    files: req.files
  });
});

// Field with file
app.post('/upload-form', upload.single('avatar'), (req, res) => {
  const { name, email } = req.body;
  const file = req.file;
  
  res.json({
    name,
    email,
    avatar: file.filename
  });
});

// Error handling
app.use((err, req, res, next) => {
  if (err instanceof multer.MulterError) {
    return res.status(400).json({ error: err.message });
  }
  res.status(500).json({ error: err.message });
});
```

### Q14: How do you validate input in Express?

**Answer:**
Input validation ensures data integrity and security.

```javascript
const { body, validationResult, param, query } = require('express-validator');

// Validation middleware
const validateUser = [
  body('name')
    .trim()
    .notEmpty().withMessage('Name is required')
    .isLength({ min: 3 }).withMessage('Name must be at least 3 characters'),
  body('email')
    .isEmail().withMessage('Invalid email')
    .normalizeEmail(),
  body('age')
    .isInt({ min: 0, max: 150 }).withMessage('Age must be between 0 and 150'),
  body('password')
    .isLength({ min: 8 }).withMessage('Password must be at least 8 characters')
    .matches(/[A-Z]/).withMessage('Password must contain uppercase')
    .matches(/[0-9]/).withMessage('Password must contain number')
];

// Route with validation
app.post('/users', validateUser, (req, res) => {
  const errors = validationResult(req);
  
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  
  // Process valid data
  res.json({ message: 'User created', user: req.body });
});

// Custom validation
app.post('/register', [
  body('email').custom(async (value) => {
    const user = await User.findOne({ email: value });
    if (user) {
      throw new Error('Email already exists');
    }
  })
], (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  res.json({ message: 'Registered' });
});

// Param validation
app.get('/users/:id', [
  param('id').isMongoId().withMessage('Invalid user ID')
], (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  res.json({ userId: req.params.id });
});

// Query validation
app.get('/search', [
  query('q').trim().notEmpty().withMessage('Search query required'),
  query('limit').optional().isInt({ min: 1, max: 100 })
], (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  res.json({ query: req.query.q });
});
```

### Q15: How do you implement rate limiting?

**Answer:**
Rate limiting prevents abuse by limiting requests from a client.

```javascript
const rateLimit = require('express-rate-limit');
const RedisStore = require('rate-limit-redis');
const redis = require('redis');

// Basic rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: 'Too many requests, please try again later'
});

// Apply to all routes
app.use(limiter);

// Apply to specific route
app.post('/login', limiter, (req, res) => {
  res.json({ message: 'Login successful' });
});

// Stricter limit for login
const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 5,
  skipSuccessfulRequests: true
});

app.post('/login', loginLimiter, (req, res) => {
  res.json({ message: 'Login successful' });
});

// Rate limiting with Redis
const client = redis.createClient();

const redisLimiter = rateLimit({
  store: new RedisStore({
    client,
    prefix: 'rl:'
  }),
  windowMs: 15 * 60 * 1000,
  max: 100
});

app.use(redisLimiter);

// Custom key generator
const customLimiter = rateLimit({
  keyGenerator: (req, res) => {
    return req.user?.id || req.ip;
  },
  skip: (req, res) => {
    return req.user?.isAdmin;
  }
});

app.use(customLimiter);
```

### Q16: How do you implement logging in Express?

**Answer:**
Logging helps track application behavior and debug issues.

```javascript
const morgan = require('morgan');
const winston = require('winston');
const fs = require('fs');

// Morgan HTTP logging
app.use(morgan('combined'));

// Custom morgan format
app.use(morgan(':method :url :status :res[content-length] - :response-time ms'));

// Log to file
const accessLogStream = fs.createWriteStream('access.log', { flags: 'a' });
app.use(morgan('combined', { stream: accessLogStream }));

// Winston logger
const logger = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  transports: [
    new winston.transports.File({ filename: 'error.log', level: 'error' }),
    new winston.transports.File({ filename: 'combined.log' })
  ]
});

if (process.env.NODE_ENV !== 'production') {
  logger.add(new winston.transports.Console({
    format: winston.format.simple()
  }));
}

// Use logger in routes
app.get('/users', (req, res) => {
  logger.info('Fetching users');
  res.json({ users: [] });
});

// Error logging
app.use((err, req, res, next) => {
  logger.error(err.message);
  res.status(500).json({ error: 'Internal server error' });
});

// Custom logging middleware
const requestLogger = (req, res, next) => {
  const start = Date.now();
  
  res.on('finish', () => {
    const duration = Date.now() - start;
    logger.info({
      method: req.method,
      url: req.url,
      status: res.statusCode,
      duration
    });
  });
  
  next();
};

app.use(requestLogger);
```

### Q17: How do you handle environment variables?

**Answer:**
Environment variables store configuration that varies between environments.

```javascript
require('dotenv').config();

// Access environment variables
const PORT = process.env.PORT || 3000;
const NODE_ENV = process.env.NODE_ENV || 'development';
const DB_URL = process.env.DB_URL;
const API_KEY = process.env.API_KEY;

// .env file
// PORT=3000
// NODE_ENV=development
// DB_URL=mongodb://localhost/myapp
// API_KEY=secret123

// Use in application
const app = express();

if (NODE_ENV === 'production') {
  app.use(helmet());
  app.use(cors({ origin: process.env.ALLOWED_ORIGINS }));
}

// Database connection
const mongoose = require('mongoose');
mongoose.connect(DB_URL, {
  useNewUrlParser: true,
  useUnifiedTopology: true
});

// API configuration
const apiClient = {
  baseURL: process.env.API_BASE_URL,
  apiKey: process.env.API_KEY,
  timeout: process.env.API_TIMEOUT || 5000
};

// Validation
if (!process.env.DB_URL) {
  throw new Error('DB_URL environment variable is required');
}

// Different configs per environment
const config = {
  development: {
    debug: true,
    logLevel: 'debug'
  },
  production: {
    debug: false,
    logLevel: 'error'
  }
};

const currentConfig = config[NODE_ENV];
```

### Q18: How do you implement caching in Express?

**Answer:**
Caching improves performance by storing frequently accessed data.

```javascript
const redis = require('redis');
const client = redis.createClient();

// Simple caching middleware
const cache = (req, res, next) => {
  const key = req.originalUrl;
  
  client.get(key, (err, data) => {
    if (err) throw err;
    
    if (data) {
      res.send(JSON.parse(data));
    } else {
      res.sendResponse = res.send;
      res.send = (body) => {
        client.setex(key, 3600, JSON.stringify(body));
        res.sendResponse(body);
      };
      next();
    }
  });
};

app.get('/users', cache, (req, res) => {
  res.json({ users: [] });
});

// Cache with expiration
const cacheWithTTL = (ttl) => {
  return (req, res, next) => {
    const key = req.originalUrl;
    
    client.get(key, (err, data) => {
      if (data) {
        return res.json(JSON.parse(data));
      }
      
      res.sendResponse = res.send;
      res.send = (body) => {
        client.setex(key, ttl, JSON.stringify(body));
        res.sendResponse(body);
      };
      next();
    });
  };
};

app.get('/posts', cacheWithTTL(1800), (req, res) => {
  res.json({ posts: [] });
});

// Cache invalidation
app.post('/posts', (req, res) => {
  // Create post
  const post = { id: 1, title: 'New Post' };
  
  // Invalidate cache
  client.del('/posts');
  
  res.json(post);
});

// Cache with tags
const cacheWithTag = (tag, ttl) => {
  return (req, res, next) => {
    const key = req.originalUrl;
    
    client.get(key, (err, data) => {
      if (data) {
        return res.json(JSON.parse(data));
      }
      
      res.sendResponse = res.send;
      res.send = (body) => {
        client.setex(key, ttl, JSON.stringify(body));
        client.sadd(`tag:${tag}`, key);
        res.sendResponse(body);
      };
      next();
    });
  };
};

// Invalidate by tag
const invalidateTag = (tag) => {
  client.smembers(`tag:${tag}`, (err, keys) => {
    keys.forEach(key => client.del(key));
    client.del(`tag:${tag}`);
  });
};
```

### Q19: How do you implement pagination in Express?

**Answer:**
Pagination divides large datasets into manageable chunks.

```javascript
// Pagination middleware
const paginate = (req, res, next) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const skip = (page - 1) * limit;
  
  req.pagination = { page, limit, skip };
  next();
};

app.use(paginate);

// Paginated route
app.get('/users', async (req, res) => {
  const { skip, limit } = req.pagination;
  
  const users = await User.find()
    .skip(skip)
    .limit(limit);
  
  const total = await User.countDocuments();
  
  res.json({
    users,
    pagination: {
      total,
      page: req.pagination.page,
      pages: Math.ceil(total / limit),
      limit
    }
  });
});

// Cursor-based pagination
app.get('/posts', async (req, res) => {
  const limit = parseInt(req.query.limit) || 10;
  const cursor = req.query.cursor;
  
  let query = {};
  if (cursor) {
    query = { _id: { $gt: cursor } };
  }
  
  const posts = await Post.find(query)
    .limit(limit + 1);
  
  const hasMore = posts.length > limit;
  const data = posts.slice(0, limit);
  const nextCursor = hasMore ? data[data.length - 1]._id : null;
  
  res.json({
    data,
    nextCursor,
    hasMore
  });
});

// Offset-based pagination
app.get('/articles', async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const pageSize = parseInt(req.query.pageSize) || 20;
  const offset = (page - 1) * pageSize;
  
  const articles = await Article.find()
    .skip(offset)
    .limit(pageSize)
    .sort({ createdAt: -1 });
  
  const total = await Article.countDocuments();
  
  res.json({
    articles,
    total,
    page,
    pageSize,
    totalPages: Math.ceil(total / pageSize)
  });
});
```

### Q20: How do you implement API versioning?

**Answer:**
API versioning allows maintaining multiple versions of an API.

```javascript
// URL-based versioning
app.get('/v1/users', (req, res) => {
  res.json({ users: [], version: 'v1' });
});

app.get('/v2/users', (req, res) => {
  res.json({ users: [], version: 'v2', newField: 'data' });
});

// Header-based versioning
app.get('/users', (req, res) => {
  const version = req.headers['api-version'] || '1';
  
  if (version === '2') {
    res.json({ users: [], version: 'v2' });
  } else {
    res.json({ users: [], version: 'v1' });
  }
});

// Router-based versioning
const v1Router = express.Router();
const v2Router = express.Router();

v1Router.get('/users', (req, res) => {
  res.json({ users: [], version: 'v1' });
});

v2Router.get('/users', (req, res) => {
  res.json({ users: [], version: 'v2' });
});

app.use('/api/v1', v1Router);
app.use('/api/v2', v2Router);

// Deprecation headers
app.get('/api/v1/users', (req, res) => {
  res.set('Deprecation', 'true');
  res.set('Sunset', new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toUTCString());
  res.set('Link', '</api/v2/users>; rel="successor-version"');
  res.json({ users: [] });
});
```

