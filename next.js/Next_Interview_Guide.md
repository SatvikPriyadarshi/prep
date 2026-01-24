# Next.js Interview Guide: Basic to Advanced

## Table of Contents
1. [Next.js Basics](#nextjs-basics)
2. [Pages & Routing](#pages--routing)
3. [API Routes](#api-routes)
4. [Data Fetching](#data-fetching)
5. [Image Optimization](#image-optimization)
6. [Static Generation & SSR](#static-generation--ssr)
7. [Middleware](#middleware)
8. [Performance](#performance)
9. [Deployment](#deployment)
10. [Advanced Concepts](#advanced-concepts)

---

## NEXT.JS BASICS

### Q1: What is Next.js and what are its key features?

**Answer:**
Next.js is a React framework that enables production-ready applications with server-side rendering, static generation, and more.

Key features:
- **File-based routing**: Automatic routing based on file structure
- **Server-side rendering**: Render pages on server
- **Static generation**: Pre-render pages at build time
- **API routes**: Build API endpoints
- **Image optimization**: Automatic image optimization
- **Code splitting**: Automatic code splitting
- **Built-in CSS support**: CSS modules and styled-jsx

```javascript
// pages/index.js
export default function Home() {
  return <h1>Welcome to Next.js</h1>;
}

// pages/about.js
export default function About() {
  return <h1>About Page</h1>;
}

// Automatic routing:
// pages/index.js -> /
// pages/about.js -> /about
// pages/blog/[id].js -> /blog/:id
```

### Q2: What is the difference between SSR, SSG, and ISR?

**Answer:**

| Feature | SSR | SSG | ISR |
|---------|-----|-----|-----|
| Rendering | Server | Build time | On-demand |
| Speed | Slower | Fastest | Fast |
| Fresh data | Always | Static | Periodic |
| Use case | Dynamic | Static | Hybrid |

```javascript
// Server-Side Rendering (SSR)
export async function getServerProps() {
  const res = await fetch('https://api.example.com/data');
  const data = await res.json();
  
  return {
    props: { data },
    revalidate: false // No caching
  };
}

function Page({ data }) {
  return <div>{data}</div>;
}

export default Page;

// Static Generation (SSG)
export async function getStaticProps() {
  const res = await fetch('https://api.example.com/data');
  const data = await res.json();
  
  return {
    props: { data },
    revalidate: 3600 // Revalidate every hour
  };
}

// Dynamic routes with SSG
export async function getStaticPaths() {
  const res = await fetch('https://api.example.com/posts');
  const posts = await res.json();
  
  const paths = posts.map((post) => ({
    params: { id: post.id.toString() }
  }));
  
  return {
    paths,
    fallback: 'blocking' // Generate on-demand
  };
}

export async function getStaticProps({ params }) {
  const res = await fetch(`https://api.example.com/posts/${params.id}`);
  const post = await res.json();
  
  return {
    props: { post },
    revalidate: 60
  };
}

// Incremental Static Regeneration (ISR)
export async function getStaticProps() {
  const data = await fetchData();
  
  return {
    props: { data },
    revalidate: 10 // Regenerate every 10 seconds
  };
}
```

### Q3: What are API routes in Next.js?

**Answer:**
API routes allow you to build API endpoints as serverless functions.

```javascript
// pages/api/users.js
export default function handler(req, res) {
  if (req.method === 'GET') {
    res.status(200).json({ users: [] });
  } else if (req.method === 'POST') {
    const user = req.body;
    res.status(201).json({ message: 'User created', user });
  } else {
    res.status(405).json({ error: 'Method not allowed' });
  }
}

// pages/api/users/[id].js
export default function handler(req, res) {
  const { id } = req.query;
  
  if (req.method === 'GET') {
    res.status(200).json({ id, name: 'User' });
  } else if (req.method === 'PUT') {
    res.status(200).json({ message: 'User updated' });
  } else if (req.method === 'DELETE') {
    res.status(200).json({ message: 'User deleted' });
  }
}

// Middleware in API routes
function withAuth(handler) {
  return (req, res) => {
    const token = req.headers.authorization;
    if (!token) {
      return res.status(401).json({ error: 'Unauthorized' });
    }
    return handler(req, res);
  };
}

export default withAuth(function handler(req, res) {
  res.status(200).json({ message: 'Protected route' });
});

// File upload
export const config = {
  api: {
    bodyParser: {
      sizeLimit: '4mb'
    }
  }
};

export default function handler(req, res) {
  if (req.method === 'POST') {
    const file = req.body;
    res.status(200).json({ message: 'File uploaded' });
  }
}
```

### Q4: How do you handle routing in Next.js?

**Answer:**
Next.js uses file-based routing where the file structure determines the routes.

```javascript
// File structure
pages/
├── index.js              // /
├── about.js              // /about
├── blog/
│   ├── index.js          // /blog
│   ├── [id].js           // /blog/:id
│   └── [...slug].js      // /blog/*
└── api/
    └── users.js          // /api/users

// Dynamic routes
// pages/blog/[id].js
import { useRouter } from 'next/router';

export default function BlogPost() {
  const router = useRouter();
  const { id } = router.query;
  
  return <h1>Blog Post {id}</h1>;
}

// Catch-all routes
// pages/blog/[...slug].js
export default function CatchAll() {
  const router = useRouter();
  const { slug } = router.query;
  
  return <h1>Slug: {slug?.join('/')}</h1>;
}

// Link navigation
import Link from 'next/link';

export default function Home() {
  return (
    <div>
      <Link href="/about">About</Link>
      <Link href="/blog/1">Blog Post 1</Link>
    </div>
  );
}

// Programmatic navigation
import { useRouter } from 'next/router';

export default function Home() {
  const router = useRouter();
  
  const handleClick = () => {
    router.push('/about');
  };
  
  return <button onClick={handleClick}>Go to About</button>;
}
```

### Q5: What is Image Optimization in Next.js?

**Answer:**
Next.js provides the Image component for automatic image optimization.

```javascript
import Image from 'next/image';

// Basic usage
export default function Home() {
  return (
    <Image
      src="/image.jpg"
      alt="Description"
      width={500}
      height={300}
    />
  );
}

// With responsive images
export default function Home() {
  return (
    <Image
      src="/image.jpg"
      alt="Description"
      width={500}
      height={300}
      responsive
      sizes="(max-width: 768px) 100vw, 50vw"
    />
  );
}

// With priority
export default function Home() {
  return (
    <Image
      src="/hero.jpg"
      alt="Hero"
      width={1200}
      height={600}
      priority
    />
  );
}

// Benefits:
// 1. Lazy loading
// 2. Responsive images
// 3. Format optimization (WebP)
// 4. Prevents layout shift
// 5. Automatic sizing
```



---

## DATA FETCHING & RENDERING

### Q6: What is getStaticProps and when should you use it?

**Answer:**
getStaticProps generates static pages at build time for better performance.

```javascript
// pages/blog/[id].js
export async function getStaticProps({ params }) {
  const res = await fetch(`https://api.example.com/posts/${params.id}`);
  const post = await res.json();
  
  return {
    props: { post },
    revalidate: 60 // ISR: revalidate every 60 seconds
  };
}

export async function getStaticPaths() {
  const res = await fetch('https://api.example.com/posts');
  const posts = await res.json();
  
  const paths = posts.map(post => ({
    params: { id: post.id.toString() }
  }));
  
  return {
    paths,
    fallback: 'blocking' // Generate on-demand
  };
}

function BlogPost({ post }) {
  return <h1>{post.title}</h1>;
}

export default BlogPost;

// Use cases:
// 1. Blog posts
// 2. Product pages
// 3. Documentation
// 4. Static content
```

### Q7: What is getServerSideProps and when should you use it?

**Answer:**
getServerSideProps renders pages on every request for dynamic content.

```javascript
// pages/user/[id].js
export async function getServerSideProps({ params, req, res }) {
  const userId = params.id;
  
  // Set cache headers
  res.setHeader(
    'Cache-Control',
    'public, s-maxage=10, stale-while-revalidate=59'
  );
  
  const userRes = await fetch(`https://api.example.com/users/${userId}`);
  const user = await userRes.json();
  
  if (!user) {
    return {
      notFound: true
    };
  }
  
  return {
    props: { user },
    revalidate: 10
  };
}

function UserPage({ user }) {
  return <h1>{user.name}</h1>;
}

export default UserPage;

// Use cases:
// 1. User-specific data
// 2. Real-time data
// 3. Personalized content
// 4. Frequently changing data
```

### Q8: What is middleware in Next.js?

**Answer:**
Middleware runs before a request is processed, useful for authentication and redirects.

```javascript
// middleware.js (or middleware.ts)
import { NextResponse } from 'next/server';

export function middleware(request) {
  const token = request.cookies.get('token');
  
  // Redirect if no token
  if (!token && request.nextUrl.pathname.startsWith('/dashboard')) {
    return NextResponse.redirect(new URL('/login', request.url));
  }
  
  // Add custom header
  const response = NextResponse.next();
  response.headers.set('x-custom-header', 'value');
  
  return response;
}

export const config = {
  matcher: ['/dashboard/:path*', '/api/:path*']
};

// Middleware with authentication
export function middleware(request) {
  const token = request.cookies.get('auth-token');
  
  if (!token) {
    return NextResponse.redirect(new URL('/login', request.url));
  }
  
  // Verify token
  try {
    const decoded = jwt.verify(token.value, process.env.JWT_SECRET);
    const response = NextResponse.next();
    response.headers.set('x-user-id', decoded.userId);
    return response;
  } catch (error) {
    return NextResponse.redirect(new URL('/login', request.url));
  }
}

// Middleware for redirects
export function middleware(request) {
  if (request.nextUrl.pathname === '/old-page') {
    return NextResponse.redirect(new URL('/new-page', request.url), 301);
  }
}

// Middleware for rate limiting
const rateLimit = new Map();

export function middleware(request) {
  const ip = request.ip || 'unknown';
  const now = Date.now();
  
  if (!rateLimit.has(ip)) {
    rateLimit.set(ip, []);
  }
  
  const requests = rateLimit.get(ip);
  const recentRequests = requests.filter(time => now - time < 60000);
  
  if (recentRequests.length > 100) {
    return new NextResponse('Too many requests', { status: 429 });
  }
  
  recentRequests.push(now);
  rateLimit.set(ip, recentRequests);
  
  return NextResponse.next();
}
```

### Q9: How do you handle environment variables in Next.js?

**Answer:**
Environment variables in Next.js are configured through .env files.

```javascript
// .env.local
DATABASE_URL=mongodb://localhost/myapp
API_SECRET=secret123
NEXT_PUBLIC_API_URL=https://api.example.com

// .env.production
DATABASE_URL=mongodb://prod-server/myapp
API_SECRET=prod-secret
NEXT_PUBLIC_API_URL=https://api.prod.example.com

// Usage in code
const dbUrl = process.env.DATABASE_URL;
const apiSecret = process.env.API_SECRET;
const publicApiUrl = process.env.NEXT_PUBLIC_API_URL;

// In getStaticProps
export async function getStaticProps() {
  const data = await fetch(process.env.NEXT_PUBLIC_API_URL + '/data');
  return { props: { data } };
}

// In API routes
export default function handler(req, res) {
  const secret = process.env.API_SECRET;
  res.json({ secret });
}

// Validation
if (!process.env.DATABASE_URL) {
  throw new Error('DATABASE_URL is required');
}
```

### Q10: How do you handle errors in Next.js?

**Answer:**
Next.js provides error handling through error pages and error boundaries.

```javascript
// pages/404.js - Custom 404 page
export default function NotFound() {
  return (
    <div>
      <h1>404 - Page Not Found</h1>
      <Link href="/">Go home</Link>
    </div>
  );
}

// pages/500.js - Custom 500 page
export default function ServerError() {
  return (
    <div>
      <h1>500 - Server Error</h1>
      <Link href="/">Go home</Link>
    </div>
  );
}

// pages/_error.js - Fallback error page
function Error({ statusCode }) {
  return (
    <p>
      {statusCode
        ? `An error ${statusCode} occurred on server`
        : 'An error occurred on client'}
    </p>
  );
}

Error.getInitialProps = ({ res, err }) => {
  const statusCode = res ? res.statusCode : err ? err.statusCode : 404;
  return { statusCode };
};

export default Error;

// Error handling in getStaticProps
export async function getStaticProps() {
  try {
    const data = await fetchData();
    return { props: { data } };
  } catch (error) {
    return {
      notFound: true // Shows 404 page
    };
  }
}

// Error handling in API routes
export default function handler(req, res) {
  try {
    const data = processRequest(req);
    res.status(200).json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}

// Error boundary
import { useEffect } from 'react';

export default function Error({ error, reset }) {
  useEffect(() => {
    console.error(error);
  }, [error]);
  
  return (
    <div>
      <h2>Something went wrong!</h2>
      <button onClick={() => reset()}>Try again</button>
    </div>
  );
}
```

### Q11: How do you optimize performance in Next.js?

**Answer:**
Next.js provides built-in optimization features for performance.

```javascript
// 1. Image optimization
import Image from 'next/image';

export default function Home() {
  return (
    <Image
      src="/image.jpg"
      alt="Description"
      width={500}
      height={300}
      priority
    />
  );
}

// 2. Font optimization
import { Inter } from '@next/font/google';

const inter = Inter({ subsets: ['latin'] });

export default function Home() {
  return <div className={inter.className}>Optimized font</div>;
}

// 3. Script optimization
import Script from 'next/script';

export default function Home() {
  return (
    <>
      <Script
        src="https://example.com/script.js"
        strategy="lazyOnload"
      />
    </>
  );
}

// 4. Dynamic imports
import dynamic from 'next/dynamic';

const DynamicComponent = dynamic(() => import('../components/Heavy'), {
  loading: () => <p>Loading...</p>
});

export default function Home() {
  return <DynamicComponent />;
}

// 5. Code splitting
export async function getStaticProps() {
  return {
    props: {},
    revalidate: 3600
  };
}

// 6. Compression
// next.config.js
module.exports = {
  compress: true
};

// 7. Bundle analysis
// npm install --save-dev @next/bundle-analyzer
// next.config.js
const withBundleAnalyzer = require('@next/bundle-analyzer')({
  enabled: process.env.ANALYZE === 'true'
});

module.exports = withBundleAnalyzer({});
```

### Q12: How do you deploy Next.js applications?

**Answer:**
Next.js can be deployed to various platforms.

```javascript
// Vercel deployment (recommended)
// 1. Push code to GitHub
// 2. Connect repository to Vercel
// 3. Vercel automatically deploys on push

// next.config.js for production
module.exports = {
  reactStrictMode: true,
  swcMinify: true,
  images: {
    domains: ['example.com']
  }
};

// Docker deployment
// Dockerfile
FROM node:16-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]

// docker-compose.yml
version: '3'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=mongodb://db/myapp
    depends_on:
      - db
  db:
    image: mongo
    ports:
      - "27017:27017"

// Self-hosted deployment
// 1. Build: npm run build
// 2. Start: npm start
// 3. Use PM2 for process management
// 4. Use Nginx as reverse proxy

// PM2 ecosystem.config.js
module.exports = {
  apps: [{
    name: 'nextjs-app',
    script: 'npm',
    args: 'start',
    instances: 'max',
    exec_mode: 'cluster'
  }]
};

// Nginx configuration
server {
  listen 80;
  server_name example.com;
  
  location / {
    proxy_pass http://localhost:3000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
  }
}
```

