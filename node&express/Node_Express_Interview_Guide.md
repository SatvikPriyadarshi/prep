# Complete Node.js & Express.js Interview Guide

## Table of Contents

### Core JavaScript & Node.js Fundamentals
1. [Node.js Basics & Architecture](#nodejs-basics--architecture)
2. [Event Loop & Asynchronous Programming](#event-loop--asynchronous-programming)
3. [Modules & NPM](#modules--npm)
4. [File System Operations](#file-system-operations)
5. [Streams & Buffers](#streams--buffers)
6. [Error Handling](#error-handling)

### Express.js Core Concepts
7. [Express Basics & Middleware](#express-basics--middleware)
8. [Routing & HTTP Methods](#routing--http-methods)
9. [Request & Response Objects](#request--response-objects)
10. [Template Engines & Views](#template-engines--views)
11. [Error Handling in Express](#error-handling-in-express)
12. [Static Files & Assets](#static-files--assets)

### Middleware & Request Processing
13. [Custom Middleware](#custom-middleware)
14. [Third-party Middleware](#third-party-middleware)
15. [Middleware Order & Execution](#middleware-order--execution)
16. [Error Handling Middleware](#error-handling-middleware)

### Routing & API Design
17. [Route Parameters & Query Strings](#route-parameters--query-strings)
18. [Route Organization & Modularization](#route-organization--modularization)
19. [RESTful API Design](#restful-api-design)
20. [API Versioning Strategies](#api-versioning-strategies)
21. [HTTP Status Codes & Headers](#http-status-codes--headers)

### Authentication & Authorization
22. [Authentication Fundamentals](#authentication-fundamentals)
23. [JWT (JSON Web Tokens)](#jwt-json-web-tokens)
24. [Session-based Authentication](#session-based-authentication)
25. [OAuth & Social Login](#oauth--social-login)
26. [Role-based Access Control (RBAC)](#role-based-access-control-rbac)

### Database Integration
27. [MongoDB with Mongoose](#mongodb-with-mongoose)
28. [SQL Databases (MySQL, PostgreSQL)](#sql-databases-mysql-postgresql)
29. [Database Connections & Pooling](#database-connections--pooling)
30. [ORM/ODM Patterns](#ormodm-patterns)
31. [Database Transactions](#database-transactions)
32. [Database Migrations & Seeding](#database-migrations--seeding)

### API Security
33. [Security Best Practices](#security-best-practices)
34. [Helmet.js & Security Headers](#helmetjs--security-headers)
35. [CORS Implementation](#cors-implementation)
36. [Rate Limiting & Throttling](#rate-limiting--throttling)
37. [Input Validation & Sanitization](#input-validation--sanitization)
38. [SQL/NoSQL Injection Prevention](#sqlnosql-injection-prevention)
39. [XSS & CSRF Protection](#xss--csrf-protection)

### Performance & Optimization
40. [Caching Strategies](#caching-strategies)
41. [Load Balancing & Clustering](#load-balancing--clustering)
42. [Compression & Minification](#compression--minification)
43. [Database Optimization](#database-optimization)
44. [Memory Leak Detection & Prevention](#memory-leak-detection--prevention)
45. [Performance Monitoring](#performance-monitoring)

### File Handling & Uploads
46. [File Uploads with Multer](#file-uploads-with-multer)
47. [File Processing & Streaming](#file-processing--streaming)
48. [Cloud Storage Integration](#cloud-storage-integration)
49. [Image Processing & Optimization](#image-processing--optimization)

### Testing
50. [Testing Strategies & Types](#testing-strategies--types)
51. [Unit Testing with Jest/Mocha](#unit-testing-with-jestmocha)
52. [Integration Testing](#integration-testing)
53. [API Testing with Supertest](#api-testing-with-supertest)
54. [Mocking & Stubbing](#mocking--stubbing)
55. [Test Coverage & CI/CD](#test-coverage--cicd)

### Real-time Features
56. [WebSockets with Socket.io](#websockets-with-socketio)
57. [Server-Sent Events (SSE)](#server-sent-events-sse)
58. [Real-time Database Sync](#real-time-database-sync)
59. [Presence Systems](#presence-systems)

### Microservices & Architecture
60. [Microservices Architecture](#microservices-architecture)
61. [Service Communication](#service-communication)
62. [API Gateway Pattern](#api-gateway-pattern)
63. [Message Queues & Workers](#message-queues--workers)
64. [Event-Driven Architecture](#event-driven-architecture)
65. [Circuit Breaker Pattern](#circuit-breaker-pattern)

### Deployment & DevOps
66. [Environment Configuration](#environment-configuration)
67. [Docker & Containerization](#docker--containerization)
68. [Process Managers (PM2)](#process-managers-pm2)
69. [Logging Strategies](#logging-strategies)
70. [Monitoring & Alerting](#monitoring--alerting)
71. [SSL/TLS Configuration](#ssltls-configuration)
72. [CI/CD Pipeline](#cicd-pipeline)

### Advanced Topics
73. [Event Emitters & Custom Events](#event-emitters--custom-events)
74. [Child Processes & Worker Threads](#child-processes--worker-threads)
75. [Streams & Pipe Patterns](#streams--pipe-patterns)
76. [Memory Management](#memory-management)
77. [Cluster Module](#cluster-module)
78. [Debugging & Profiling](#debugging--profiling)

### Ecosystem & Tools
79. [NPM & Package Management](#npm--package-management)
80. [TypeScript with Node/Express](#typescript-with-nodeexpress)
81. [GraphQL with Express](#graphql-with-express)
82. [Webpack & Build Tools](#webpack--build-tools)
83. [Linting & Code Quality](#linting--code-quality)

### System Design & Scenarios
84. [Scalability Patterns](#scalability-patterns)
85. [High Availability Strategies](#high-availability-strategies)
86. [Caching Architectures](#caching-architectures)
87. [API Design Patterns](#api-design-patterns)
88. [Legacy System Integration](#legacy-system-integration)

---

## 1. Node.js Basics & Architecture

#### 1. What is Node.js and how does it differ from traditional server-side technologies?

**Answer:**

Node.js is a JavaScript runtime built on Chrome's V8 JavaScript engine. It allows developers to run JavaScript on the server-side, outside of a browser.

**Key differences from traditional server-side technologies:**

| Feature | Node.js | Traditional (Java, PHP, Python) |
|---------|---------|--------------------------------|
| **Language** | JavaScript | Java, PHP, Python, etc. |
| **Concurrency Model** | Event-driven, non-blocking I/O | Multi-threaded, blocking I/O |
| **Performance** | High for I/O-bound tasks | High for CPU-bound tasks |
| **Learning Curve** | Lower (if you know JavaScript) | Higher (new language) |
| **Code Execution** | Single-threaded with event loop | Multi-threaded |
| **Use Case** | Real-time apps, APIs, microservices | Enterprise apps, complex systems |

**Traditional approach (Apache with PHP):**
- Each request creates a new thread
- Threads consume memory
- Limited concurrent connections
- Blocking I/O operations

**Node.js approach:**
- Single thread handles all requests
- Event loop manages concurrency
- Non-blocking I/O operations
- High concurrent connections

**Example:**
```javascript
// Traditional blocking I/O
const data = fs.readFileSync('file.txt'); // Blocks until complete
console.log(data);

// Node.js non-blocking I/O
fs.readFile('file.txt', (err, data) => {
  console.log(data); // Called when file is read
});
// Code continues executing immediately
```

---

#### 2. Explain Node.js architecture and how it handles concurrent requests

**Answer:**

**Node.js Architecture:**

1. **V8 Engine**: Executes JavaScript code
2. **Libuv**: Handles asynchronous I/O operations
3. **Event Loop**: Manages event queue and callbacks
4. **Worker Pool**: Handles CPU-intensive tasks
5. **C++ Bindings**: Connect JavaScript to C++ libraries

**How it handles concurrent requests:**

```
Request 1 → Event Loop → Callback Queue → Response 1
Request 2 → Event Loop → Callback Queue → Response 2
Request 3 → Event Loop → Callback Queue → Response 3
```

**Process:**
1. Request arrives at Node.js server
2. Event loop accepts the request
3. If I/O operation needed, it's delegated to Libuv
4. Event loop continues processing other requests
5. When I/O completes, callback is queued
6. Event loop executes callback when ready
7. Response is sent

**Key concept:** Node.js uses a **single-threaded event loop** with **non-blocking I/O** to handle thousands of concurrent connections efficiently.

---

#### 3. What is the event-driven programming model in Node.js?

**Answer:**

Event-driven programming is a paradigm where the flow of the program is determined by events (user actions, sensor outputs, messages, etc.).

**Components:**
- **Event Emitters**: Objects that emit events
- **Event Listeners**: Functions that respond to events
- **Event Loop**: Continuously checks for events

**Example:**
```javascript
const EventEmitter = require('events');

// Create event emitter
const myEmitter = new EventEmitter();

// Register event listener
myEmitter.on('greet', (name) => {
  console.log(`Hello, ${name}!`);
});

// Emit event
myEmitter.emit('greet', 'Alice'); // Output: Hello, Alice!
```

**Node.js is event-driven because:**
- HTTP server emits 'request' events
- File system emits 'data' events
- Streams emit 'data', 'end', 'error' events
- Database connections emit events

**Benefits:**
- Efficient resource usage
- Scalable for I/O operations
- Responsive applications
- Easy to handle asynchronous operations

---

#### 4. How does Node.js handle I/O operations?

**Answer:**

Node.js handles I/O operations using **non-blocking, asynchronous** approach.

**Types of I/O operations:**
1. **File I/O** (reading/writing files)
2. **Network I/O** (HTTP requests, database calls)
3. **Database I/O** (queries, transactions)
4. **External API calls**

**Blocking vs Non-blocking:**

**Blocking I/O (traditional):**
```javascript
// PHP, Java, Python style
const data = readFile('file.txt'); // Blocks thread
processData(data); // Waits for file read
```

**Non-blocking I/O (Node.js):**
```javascript
// Node.js style
readFile('file.txt', (err, data) => {
  processData(data); // Called when file is ready
});
// Code continues executing immediately
```

**How it works:**
1. I/O request is made
2. Request is delegated to operating system
3. Node.js continues executing other code
4. When I/O completes, callback is queued
5. Event loop executes callback

**Example with HTTP request:**
```javascript
const https = require('https');

// Non-blocking HTTP request
https.get('https://api.example.com/data', (res) => {
  let data = '';
  res.on('data', (chunk) => data += chunk);
  res.on('end', () => console.log(data));
});

console.log('Request sent, continuing execution...');
// This logs immediately, doesn't wait for response
```

---

#### 5. What is non-blocking I/O and why is it important in Node.js?

**Answer:**

**Non-blocking I/O** means that I/O operations don't block the execution thread. The program continues running while waiting for I/O to complete.

**Blocking I/O:**
```javascript
// Thread is blocked until file is read
const data = fs.readFileSync('file.txt');
console.log('File read:', data);
console.log('This waits for file read');
```

**Non-blocking I/O:**
```javascript
// Thread continues immediately
fs.readFile('file.txt', (err, data) => {
  console.log('File read:', data);
});
console.log('This executes immediately');
```

**Why it's important:**

1. **Scalability**: Single thread can handle thousands of connections
2. **Performance**: No thread creation overhead
3. **Resource efficiency**: Less memory usage
4. **Responsiveness**: Application remains responsive

**Real-world analogy:**
- **Blocking**: Like waiting in line at a coffee shop (one person served at a time)
- **Non-blocking**: Like taking a number and shopping while waiting (multiple people served concurrently)

**Use case: Web server**
```javascript
const http = require('http');

const server = http.createServer((req, res) => {
  // Non-blocking database query
  db.query('SELECT * FROM users', (err, results) => {
    res.end(JSON.stringify(results));
  });
  // Server can handle other requests immediately
});

server.listen(3000);
```

---

#### 6. Explain the single-threaded nature of Node.js

**Answer:**

Node.js runs JavaScript in a **single main thread** but uses **multiple threads in the background** for I/O operations.

**What single-threaded means:**
- One thread executes JavaScript code
- One call stack
- One memory heap
- One event loop

**What happens behind the scenes:**
- **Libuv thread pool** handles I/O operations (default: 4 threads)
- **Worker threads** for CPU-intensive tasks
- **Child processes** for parallel execution

**Benefits of single-threaded model:**
1. **No context switching**: Faster execution
2. **No race conditions**: Simpler concurrency model
3. **Less memory**: No thread overhead
4. **Simpler debugging**: Single call stack

**Limitations:**
1. **CPU-bound tasks**: Block the main thread
2. **No parallel JavaScript execution**: Without worker threads

**Example showing single-threaded behavior:**
```javascript
console.log('Start');

// This blocks the main thread
for (let i = 0; i < 1000000000; i++) {
  // CPU-intensive task
}

console.log('End'); // Delayed by the loop
```

**Solution for CPU-bound tasks:**
```javascript
const { Worker } = require('worker_threads');

// Offload to worker thread
const worker = new Worker('./cpu-intensive-task.js');
```

---

#### 7. What are the key features of Node.js?

**Answer:**

**1. Non-blocking I/O**
- Asynchronous operations
- Event-driven architecture
- High concurrency

**2. Single-threaded with Event Loop**
- Efficient resource usage
- Simple concurrency model
- Scalable for I/O operations

**3. JavaScript Everywhere**
- Same language for frontend and backend
- Code sharing between client and server
- Large ecosystem

**4. NPM (Node Package Manager)**
- Largest package ecosystem
- Easy dependency management
- Community-driven packages

**5. Fast Performance**
- V8 JavaScript engine
- Just-in-time compilation
- Optimized for web applications

**6. Cross-platform**
- Runs on Windows, macOS, Linux
- Consistent behavior across platforms

**7. Built-in Modules**
- HTTP/HTTPS server
- File system operations
- Streams and buffers
- Crypto for encryption

**8. Real-time Capabilities**
- WebSocket support
- Event-driven architecture
- Perfect for chat, gaming, collaboration

**9. Microservices Friendly**
- Lightweight processes
- Easy service decomposition
- Containerization support

**10. Active Community**
- Regular updates
- Extensive documentation
- Large number of tutorials

---

#### 8. What are the advantages and disadvantages of using Node.js?

**Answer:**

**Advantages:**

1. **High Performance**
   - Non-blocking I/O
   - Event-driven architecture
   - Fast for I/O-bound applications

2. **JavaScript Everywhere**
   - Full-stack development with one language
   - Code sharing between client and server
   - Large talent pool

3. **Scalability**
   - Handles thousands of concurrent connections
   - Easy horizontal scaling
   - Microservices architecture support

4. **Rich Ecosystem**
   - NPM with 1+ million packages
   - Extensive libraries and frameworks
   - Active community support

5. **Real-time Applications**
   - Perfect for chat, gaming, collaboration tools
   - WebSocket support out of the box
   - Event-driven model

6. **Fast Development**
   - Less boilerplate code
   - Rapid prototyping
   - Easy to learn for JavaScript developers

7. **Cross-platform**
   - Runs anywhere
   - Consistent behavior
   - Easy deployment

**Disadvantages:**

1. **Not Suitable for CPU-intensive Tasks**
   - Single-threaded nature
   - Blocks event loop
   - Requires worker threads for CPU work

2. **Callback Hell**
   - Nested callbacks can be hard to manage
   - Solution: Promises, async/await

3. **Immature Core Modules**
   - Some APIs still unstable
   - Frequent breaking changes in early versions
   - Better now with LTS releases

4. **High Abstraction**
   - Can hide complexity
   - Harder to debug low-level issues
   - Dependency on third-party packages

5. **Documentation Quality Varies**
   - Some packages poorly documented
   - Reliance on community support

6. **Performance with Heavy Computation**
   - Slower than compiled languages for CPU tasks
   - Requires careful optimization

---

#### 9. How does Node.js compare to other backend technologies like Java Spring or Python Django?

**Answer:**

| Feature | Node.js | Java Spring | Python Django |
|---------|---------|-------------|---------------|
| **Language** | JavaScript | Java | Python |
| **Performance** | High (I/O) | High (CPU) | Medium |
| **Learning Curve** | Low | High | Medium |
| **Concurrency** | Event-driven | Multi-threaded | Multi-threaded |
| **Ecosystem** | Largest (NPM) | Large (Maven) | Large (PyPI) |
| **Use Case** | Real-time, APIs | Enterprise, banking | Web apps, data science |
| **Memory Usage** | Low | High | Medium |
| **Development Speed** | Fast | Slow | Fast |
| **Scalability** | Excellent | Good | Good |
| **Community** | Very active | Large | Large |

**Node.js strengths:**
- Real-time applications (chat, gaming)
- API servers and microservices
- I/O-intensive applications
- Full-stack JavaScript development

**Java Spring strengths:**
- Enterprise applications
- Banking and financial systems
- CPU-intensive processing
- Large-scale systems with complex business logic

**Python Django strengths:**
- Rapid prototyping
- Data science and ML integration
- Content management systems
- Scientific computing

**Example scenarios:**

**Choose Node.js when:**
- Building real-time chat application
- Creating REST API for mobile app
- Need high concurrency with I/O operations
- Team knows JavaScript

**Choose Java Spring when:**
- Building banking system
- Need strong type safety
- Enterprise integration required
- Complex business logic

**Choose Python Django when:**
- Building data-driven web application
- Need machine learning integration
- Rapid prototyping needed
- Data analysis required

---

#### 10. What is the difference between Node.js and JavaScript in the browser?

**Answer:**

| Feature | Node.js | Browser JavaScript |
|---------|---------|-------------------|
| **Environment** | Server-side | Client-side |
| **Global Object** | `global` | `window` |
| **DOM Access** | No | Yes |
| **File System** | Yes (fs module) | No (sandboxed) |
| **Network** | Full access | Restricted (CORS) |
| **Modules** | CommonJS/ES6 | ES6 modules |
| **Package Manager** | NPM | NPM/CDN |
| **Built-in APIs** | HTTP, FS, OS, etc. | DOM, BOM, Web APIs |
| **Security** | Full system access | Sandboxed |
| **Use Case** | Servers, tools | Web pages, apps |

**Key differences:**

**1. Global objects:**
```javascript
// Node.js
console.log(global); // Global object
console.log(__dirname); // Current directory
console.log(__filename); // Current file

// Browser
console.log(window); // Global object
console.log(document); // DOM access
```

**2. Module system:**
```javascript
// Node.js (CommonJS)
const fs = require('fs');
module.exports = myFunction;

// Browser (ES6 modules)
import { function } from './module.js';
export default myFunction;
```

**3. File system access:**
```javascript
// Node.js - can read/write files
const fs = require('fs');
fs.readFile('file.txt', (err, data) => {});

// Browser - cannot access file system directly
// Only through file input or IndexedDB
```

**4. HTTP requests:**
```javascript
// Node.js - create servers
const http = require('http');
http.createServer((req, res) => {});

// Browser - make requests
fetch('/api/data').then(res => res.json());
```

**5. Same language, different capabilities:**
- **Node.js**: System programming, servers, tools
- **Browser**: User interfaces, DOM manipulation, web apps

**Shared features:**
- JavaScript syntax and core language
- ES6+ features (async/await, promises, classes)
- JSON handling
- Regular expressions

---
---

## 2. Event Loop & Asynchronous Programming

#### 1. What is the Event Loop in Node.js?

**Answer:**

The Event Loop is a mechanism that allows Node.js to perform non-blocking I/O operations despite being single-threaded. It's the core of Node.js's asynchronous architecture.

**How it works:**
1. Node.js starts the event loop
2. Event loop checks for pending events
3. Executes callbacks for completed operations
4. Returns to step 2 (infinite loop)

**Simple analogy:**
Think of a restaurant with one waiter (event loop) and many tables (requests):
- Waiter takes orders (accepts requests)
- Gives orders to kitchen (delegates I/O)
- Serves other tables while waiting (handles other requests)
- Delivers food when ready (executes callbacks)

**Code example:**
```javascript
console.log('Start');

setTimeout(() => {
  console.log('Timeout callback');
}, 1000);

console.log('End');

// Output:
// Start
// End
// Timeout callback (after 1 second)
```

---

#### 2. Explain the phases of the Event Loop

**Answer:**

The Event Loop has 6 phases that execute in order:

**Phase 1: Timers**
- Executes `setTimeout()` and `setInterval()` callbacks
- Checks if timer thresholds have been reached

**Phase 2: Pending Callbacks**
- Executes I/O callbacks deferred from previous cycle
- Handles some system operations

**Phase 3: Idle, Prepare**
- Internal phase used by Node.js
- Prepares for the poll phase

**Phase 4: Poll**
- **Most important phase**
- Retrieves new I/O events
- Executes I/O-related callbacks
- If no callbacks, waits for events

**Phase 5: Check**
- Executes `setImmediate()` callbacks

**Phase 6: Close Callbacks**
- Executes close event callbacks
- e.g., `socket.on('close', ...)`

**Visual flow:**
```
Timers → Pending Callbacks → Idle/Prepare → Poll → Check → Close Callbacks
      ↑                                                      ↓
      └──────────────────────────────────────────────────────┘
```

---

#### 3. How does Node.js handle asynchronous operations?

**Answer:**

Node.js handles asynchronous operations through:
1. **Event Loop** - Manages execution order
2. **Worker Pool** - Handles I/O operations
3. **Callback Queue** - Stores completed operations
4. **Microtask Queue** - For promises

**Process for file read:**
```javascript
console.log('Start reading file');

fs.readFile('file.txt', (err, data) => {
  console.log('File read complete');
});

console.log('End of script');

// Output:
// Start reading file
// End of script
// File read complete
```

**What happens:**
1. `readFile` is called (asynchronous)
2. Node.js delegates to worker pool
3. Main thread continues executing
4. When file read completes, callback is queued
5. Event loop picks up callback when ready
6. Callback executes

---

#### 4. What are callbacks and what is callback hell?

**Answer:**

**Callbacks** are functions passed as arguments to other functions, to be executed later.

**Basic callback:**
```javascript
function greet(name, callback) {
  console.log(`Hello, ${name}`);
  callback();
}

greet('Alice', () => {
  console.log('Callback executed');
});
```

**Callback hell** is deeply nested callbacks that make code hard to read and maintain.

**Example of callback hell:**
```javascript
fs.readFile('file1.txt', (err, data1) => {
  if (err) throw err;
  
  fs.readFile('file2.txt', (err, data2) => {
    if (err) throw err;
    
    fs.writeFile('output.txt', data1 + data2, (err) => {
      if (err) throw err;
      
      console.log('Files merged');
      
      fs.readFile('output.txt', (err, data) => {
        if (err) throw err;
        console.log('Output:', data);
      });
    });
  });
});
```

**Solutions to callback hell:**
1. **Named functions** (extract callbacks)
2. **Promises**
3. **Async/await**
4. **Control flow libraries** (async.js)

---

#### 5. What are Promises and how do they work?

**Answer:**

**Promises** are objects representing the eventual completion (or failure) of an asynchronous operation.

**Promise states:**
- **Pending**: Initial state
- **Fulfilled**: Operation completed successfully
- **Rejected**: Operation failed

**Creating a promise:**
```javascript
const myPromise = new Promise((resolve, reject) => {
  // Async operation
  setTimeout(() => {
    const success = true;
    if (success) {
      resolve('Operation succeeded');
    } else {
      reject('Operation failed');
    }
  }, 1000);
});
```

**Using promises:**
```javascript
myPromise
  .then((result) => {
    console.log('Success:', result);
  })
  .catch((error) => {
    console.log('Error:', error);
  })
  .finally(() => {
    console.log('Operation complete');
  });
```

**Promise chaining:**
```javascript
readFile('file1.txt')
  .then(data1 => readFile('file2.txt'))
  .then(data2 => writeFile('output.txt', data2))
  .then(() => console.log('Done'))
  .catch(err => console.error('Error:', err));
```

---

#### 6. Explain async/await syntax and its benefits

**Answer:**

**async/await** is syntactic sugar over promises that makes asynchronous code look synchronous.

**Basic syntax:**
```javascript
async function fetchData() {
  try {
    const data = await someAsyncOperation();
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}
```

**Converting callback hell to async/await:**
```javascript
// Before (callback hell)
fs.readFile('file1.txt', (err, data1) => {
  if (err) throw err;
  fs.readFile('file2.txt', (err, data2) => {
    if (err) throw err;
    console.log(data1 + data2);
  });
});

// After (async/await)
async function readFiles() {
  try {
    const data1 = await fs.promises.readFile('file1.txt');
    const data2 = await fs.promises.readFile('file2.txt');
    console.log(data1 + data2);
  } catch (error) {
    console.error(error);
  }
}
```

**Benefits:**
1. **Cleaner code**: No nested callbacks
2. **Error handling**: Use try/catch
3. **Debugging**: Stack traces are better
4. **Readability**: Looks like synchronous code
5. **Control flow**: Easier to follow

**Parallel execution:**
```javascript
async function fetchAll() {
  const [data1, data2] = await Promise.all([
    fetch('/api/data1'),
    fetch('/api/data2')
  ]);
  console.log(data1, data2);
}
```

---

#### 7. What is the difference between setImmediate(), process.nextTick(), and setTimeout()?

**Answer:**

| Function | Queue | Priority | When Executed |
|----------|-------|----------|---------------|
| **process.nextTick()** | Next Tick Queue | Highest | End of current operation |
| **setImmediate()** | Check Queue | High | After I/O callbacks |
| **setTimeout(fn, 0)** | Timers Queue | Medium | Next event loop iteration |

**Execution order:**
```javascript
console.log('Start');

setTimeout(() => console.log('setTimeout'), 0);
setImmediate(() => console.log('setImmediate'));
process.nextTick(() => console.log('nextTick'));

console.log('End');

// Output:
// Start
// End
// nextTick
// setTimeout
// setImmediate
```

**Detailed explanation:**

**process.nextTick():**
- Executes at the end of the current operation
- Before the event loop continues
- Can cause starvation if overused

**setImmediate():**
- Executes in the "check" phase of event loop
- After I/O events callbacks
- Good for breaking up long operations

**setTimeout(fn, 0):**
- Minimum delay is 1ms (not actually 0)
- Executes in "timers" phase
- After nextTick and microtasks

---

#### 8. How does Node.js handle timers in the Event Loop?

**Answer:**

**Timer handling process:**
1. Timers are stored in a min-heap
2. Event loop checks timers in "timers" phase
3. Executes callbacks whose threshold has passed
4. If multiple timers ready, executes in order

**Important notes:**
- `setTimeout(fn, 0)` actually has minimum 1ms delay
- Timers can be delayed if event loop is busy
- Not guaranteed to execute at exact time

**Example:**
```javascript
const start = Date.now();

setTimeout(() => {
  console.log(`Timer 1: ${Date.now() - start}ms`);
}, 100);

// Block event loop for 200ms
while (Date.now() - start < 200) {
  // Busy wait
}

setTimeout(() => {
  console.log(`Timer 2: ${Date.now() - start}ms`);
}, 100);

// Output:
// Timer 1: ~200ms (delayed by busy loop)
// Timer 2: ~200ms (executed immediately after Timer 1)
```

**Timer precision:**
- Not suitable for high-precision timing
- Use `performance.now()` for precise measurements
- Consider `setImmediate()` for immediate execution

---

#### 9. What is the microtask queue vs macrotask queue?

**Answer:**

**Microtask Queue:**
- Higher priority than macrotask queue
- Contains: Promise callbacks, `process.nextTick()`
- Executed after each macrotask
- Must be completely empty before next macrotask

**Macrotask Queue:**
- Lower priority than microtask queue
- Contains: `setTimeout()`, `setInterval()`, `setImmediate()`, I/O callbacks
- Each iteration of event loop processes one macrotask

**Execution order:**
```javascript
console.log('Script start');

setTimeout(() => console.log('setTimeout'), 0);

Promise.resolve()
  .then(() => console.log('Promise 1'))
  .then(() => console.log('Promise 2'));

console.log('Script end');

// Output:
// Script start
// Script end
// Promise 1
// Promise 2
// setTimeout
```

**Visual flow:**
```
Macrotask → All Microtasks → Render → Next Macrotask
```

**Key insight:** Microtasks can starve the event loop if they keep adding more microtasks.

---

#### 10. How would you explain the Event Loop to a junior developer?

**Answer:**

**Simple explanation:**
"Think of Node.js as a restaurant with one very efficient waiter (the event loop)."

**The restaurant analogy:**
1. **Customers arrive** (requests come in)
2. **Waiter takes orders** (event loop accepts requests)
3. **Orders go to kitchen** (I/O operations delegated)
4. **Waiter serves other tables** (handles other requests)
5. **Food is ready** (I/O completes)
6. **Waiter delivers food** (callback executes)
7. **Repeat** (event loop continues)

**Key points:**
- **Single waiter** = Single thread
- **Kitchen staff** = Worker pool/OS
- **Order tickets** = Callbacks
- **Waiting area** = Callback queue

**Code analogy:**
```javascript
// Customer 1 orders (request 1)
console.log('Taking order 1');
setTimeout(() => console.log('Serving order 1'), 1000);

// Customer 2 orders immediately (request 2)
console.log('Taking order 2');
setTimeout(() => console.log('Serving order 2'), 500);

// Output:
// Taking order 1
// Taking order 2
// Serving order 2 (after 500ms)
// Serving order 1 (after 1000ms)
```

**Takeaway:** Node.js doesn't wait for one request to finish before starting another. It handles multiple requests concurrently through the event loop.

---

## 3. Modules & NPM

#### 1. What is the CommonJS module system?

**Answer:**

**CommonJS** is the module system used by Node.js (before ES6 modules). It's designed for server-side JavaScript.

**Key features:**
- Synchronous module loading
- `require()` to import modules
- `module.exports` or `exports` to export
- Modules are cached after first load

**Exporting:**
```javascript
// math.js
function add(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

// Export single function
module.exports = add;

// Or export multiple functions
module.exports = {
  add,
  subtract
};

// Alternative syntax
exports.add = add;
exports.subtract = subtract;
```

**Importing:**
```javascript
// Import entire module
const math = require('./math.js');
console.log(math.add(2, 3));

// Import specific functions
const { add, subtract } = require('./math.js');
console.log(add(2, 3));
```

**Module caching:**
```javascript
// First require loads and caches
const module1 = require('./module.js');

// Second require returns cached version
const module2 = require('./module.js');

// module1 === module2 (same instance)
```

---

#### 2. How does require() work in Node.js?

**Answer:**

**`require()` process:**
1. **Resolve path** - Find the module file
2. **Load file** - Read the file content
3. **Wrap module** - Wrap in function wrapper
4. **Compile** - Compile the code
5. **Execute** - Run the module code
6. **Cache** - Store in cache
7. **Return exports** - Return `module.exports`

**Step-by-step:**

**1. Path resolution:**
```javascript
require('./math');        // Relative path
require('../utils/math'); // Parent directory
require('fs');            // Core module
require('lodash');        // NPM package
```

**2. Module wrapper:**
```javascript
// What Node.js does internally
(function(exports, require, module, __filename, __dirname) {
  // Your module code here
  module.exports = {};
});
```

**3. Caching:**
- Modules are cached by absolute path
- Subsequent `require()` calls return cached version
- Can delete from cache: `delete require.cache[require.resolve('./module')]`

**Example showing wrapper variables:**
```javascript
// module.js
console.log(__filename); // /path/to/module.js
console.log(__dirname);  // /path/to
console.log(module);     // Module object
console.log(exports);    // Exports object
console.log(require);    // Require function
```

---

#### 3. What is the difference between module.exports and exports?

**Answer:**

**`module.exports`** is the actual object that gets exported.
**`exports`** is a reference to `module.exports`.

**Initial relationship:**
```javascript
// When module starts
exports = module.exports = {};
```

**Correct usage:**
```javascript
// Adding properties (works)
exports.add = (a, b) => a + b;
exports.subtract = (a, b) => a - b;

// Reassigning exports (doesn't work)
exports = { add, subtract }; // WRONG - breaks reference

// Reassigning module.exports (works)
module.exports = { add, subtract }; // CORRECT
```

**What happens:**
```javascript
// module.js
exports = { name: 'Alice' }; // Doesn't work
module.exports = { name: 'Bob' }; // Works

// app.js
const module = require('./module.js');
console.log(module); // { name: 'Bob' }
```

**Best practice:** Use `module.exports` for consistency.

**Common patterns:**
```javascript
// Export single function
module.exports = function() {};

// Export class
module.exports = class MyClass {};

// Export object
module.exports = {
  function1: () => {},
  function2: () => {}
};

// Export multiple things
exports.function1 = () => {};
exports.function2 = () => {};
```

---

#### 4. How do ES6 modules differ from CommonJS modules?

**Answer:**

| Feature | CommonJS | ES6 Modules |
|---------|----------|-------------|
| **Syntax** | `require()` / `module.exports` | `import` / `export` |
| **Loading** | Synchronous | Asynchronous |
| **Static Analysis** | Runtime | Compile-time |
| **Tree Shaking** | Limited | Better |
| **Default** | `.js` extension | `.mjs` or `"type": "module"` |
| **Node.js Support** | Always | Node.js 12+ |
| **Browser Support** | With bundler | Native |

**CommonJS:**
```javascript
// Export
module.exports = { add, subtract };
exports.add = add;

// Import
const math = require('./math.js');
const { add } = require('./math.js');
```

**ES6 Modules:**
```javascript
// Export
export function add(a, b) { return a + b; }
export default function subtract(a, b) { return a - b; }

// Import
import { add } from './math.js';
import subtract from './math.js';
import * as math from './math.js';
```

**Using ES6 modules in Node.js:**
```json
// package.json
{
  "type": "module"
}
```

```javascript
// math.mjs (or .js with "type": "module")
export function add(a, b) {
  return a + b;
}

// app.mjs
import { add } from './math.mjs';
console.log(add(2, 3));
```

**Key differences:**
- ES6 imports are hoisted (moved to top)
- ES6 imports are read-only views
- CommonJS allows dynamic `require()`
- ES6 has static structure (better optimization)

---

#### 5. What is NPM and how does package.json work?

**Answer:**

**NPM** (Node Package Manager) is:
1. **Package registry** - Repository of packages
2. **Command-line tool** - Install/manage packages
3. **Package format** - Standard for Node.js packages

**package.json** is the manifest file for Node.js projects.

**Basic structure:**
```json
{
  "name": "my-project",
  "version": "1.0.0",
  "description": "My awesome project",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "jest"
  },
  "dependencies": {
    "express": "^4.18.0",
    "lodash": "^4.17.21"
  },
  "devDependencies": {
    "jest": "^29.0.0",
    "eslint": "^8.0.0"
  },
  "engines": {
    "node": ">=14.0.0"
  }
}
```

**Creating package.json:**
```bash
# Interactive setup
npm init

# Quick setup with defaults
npm init -y
```

**Key fields:**
- **name**: Package name (kebab-case)
- **version**: Semantic version (major.minor.patch)
- **main**: Entry point file
- **scripts**: Custom npm commands
- **dependencies**: Production dependencies
- **devDependencies**: Development dependencies
- **peerDependencies**: Required by plugins
- **optionalDependencies**: Optional packages

---

#### 6. Explain semantic versioning in NPM packages

**Answer:**

**Semantic Versioning (SemVer)** is a versioning scheme: `MAJOR.MINOR.PATCH`

**Format:** `1.2.3`
- **1** (MAJOR): Breaking changes
- **2** (MINOR): New features (backward compatible)
- **3** (PATCH): Bug fixes (backward compatible)

**Version ranges in package.json:**
```json
{
  "dependencies": {
    // Exact version
    "package": "1.2.3",
    
    // Compatible with 1.2.3 (patch updates allowed)
    "package": "~1.2.3",  // 1.2.x
    
    // Compatible with 1.2.3 (minor updates allowed)
    "package": "^1.2.3",  // 1.x.x
    
    // Any version
    "package": "*",
    
    // Range
    "package": ">=1.2.3 <2.0.0",
    
    // OR condition
    "package": "1.2.3 || 2.0.0"
  }
}
```

**What caret (^) means:**
- `^1.2.3` = `>=1.2.3 <2.0.0`
- `^0.2.3` = `>=0.2.3 <0.3.0` (0.x is special)
- `^0.0.3` = `0.0.3` (exact)

**What tilde (~) means:**
- `~1.2.3` = `>=1.2.3 <1.3.0`
- `~1.2` = `>=1.2.0 <1.3.0`
- `~1` = `>=1.0.0 <2.0.0`

**Best practices:**
- Use `^` for applications (get features and fixes)
- Use exact versions for libraries (predictable)
- Use `npm ci` for CI/CD (exact versions from package-lock.json)

---

#### 7. What are global vs local packages?

**Answer:**

**Local packages:**
- Installed in `node_modules` of current project
- Accessible only within that project
- Listed in `package.json`

```bash
# Install locally (default)
npm install package-name

# Install as dev dependency
npm install package-name --save-dev

# Location: ./node_modules/package-name
```

**Global packages:**
- Installed system-wide
- Accessible from any project
- Typically CLI tools

```bash
# Install globally
npm install -g package-name

# Location varies by OS:
# macOS/Linux: /usr/local/lib/node_modules
# Windows: %AppData%\npm\node_modules
```

**When to use global:**
- Command-line tools (create-react-app, nodemon, typescript)
- Development utilities
- Tools used across multiple projects

**When to use local:**
- Project dependencies
- Libraries used in code
- Version-specific packages

**Checking installations:**
```bash
# List local packages
npm list

# List global packages
npm list -g

# List top-level only
npm list --depth=0
```

---

#### 8. What is node_modules and how does it work?

**Answer:**

**node_modules** is the directory where Node.js stores installed packages.

**Structure:**
```
node_modules/
  ├── package-a/
  │   ├── index.js
  │   ├── package.json
  │   └── node_modules/
  │       └── package-c/
  ├── package-b/
  └── .bin/ (executable scripts)
```

**How it works:**

**1. Installation:**
```bash
npm install express
```
- Creates `node_modules/express/`
- Downloads express and its dependencies
- Creates nested `node_modules` for dependencies

**2. Module resolution:**
```javascript
require('express');
```
1. Check current directory's `node_modules`
2. Check parent directory's `node_modules`
3. Continue up to root
4. Check global `node_modules`

**3. Nested dependencies:**
- Each package can have its own `node_modules`
- Can lead to duplicate packages
- npm v3+ flattens when possible

**Problems:**
- **Deep nesting**: Windows path length limits
- **Duplicate packages**: Wasted disk space
- **Installation time**: Can be slow

**Solutions:**
- Use `npm ci` for clean installs
- Use `package-lock.json` for consistency
- Consider `yarn` or `pnpm` for better performance

---

#### 9. How do you handle package dependencies?

**Answer:**

**Managing dependencies:**

**1. Installing:**
```bash
# Production dependency
npm install express

# Development dependency
npm install jest --save-dev

# Peer dependency
npm install react --save-peer

# Optional dependency
npm install fsevents --save-optional
```

**2. Updating:**
```bash
# Update specific package
npm update package-name

# Update all packages
npm update

# Update to latest (may break)
npm install package-name@latest
```

**3. Removing:**
```bash
npm uninstall package-name
```

**4. Checking:**
```bash
# Check for outdated packages
npm outdated

# Check for vulnerabilities
npm audit

# Fix vulnerabilities
npm audit fix
```

**Best practices:**

**1. Use package-lock.json:**
- Commit to version control
- Ensures consistent installations
- Use `npm ci` in CI/CD

**2. Regular updates:**
```bash
# Check weekly
npm outdated

# Update patch versions
npm update

# Review major updates carefully
```

**3. Security:**
```bash
# Regular security checks
npm audit

# Automate with GitHub Dependabot
```

**4. Dependency types:**
- **dependencies**: Required for production
- **devDependencies**: Required for development
- **peerDependencies**: Required by plugins
- **optionalDependencies**: Nice to have

---

#### 10. What is npm scripts and how do you use them?

**Answer:**

**npm scripts** are custom commands defined in `package.json` that can run Node.js scripts, shell commands, or other npm commands.

**Basic structure:**
```json
{
  "scripts": {
    "start": "node index.js",
    "test": "jest",
    "build": "webpack",
    "lint": "eslint .",
    "format": "prettier --write ."
  }
}
```

**Running scripts:**
```bash
# Run script
npm run script-name

# Shortcuts for common scripts
npm start    # npm run start
npm test     # npm run test
npm restart  # npm run restart
npm stop     # npm run stop
```

**Common scripts:**
```json
{
  "scripts": {
    "dev": "nodemon index.js",
    "build": "npm run clean && npm run compile",
    "clean": "rm -rf dist",
    "compile": "babel src -d dist",
    "test": "jest --coverage",
    "test:watch": "jest --watch",
    "lint": "eslint src/**/*.js",
    "lint:fix": "eslint src/**/*.js --fix",
    "precommit": "npm run lint && npm run test",
    "prepublishOnly": "npm run build"
  }
}
```

**Lifecycle scripts:**
- **pre** scripts: Run before (prestart, pretest)
- **post** scripts: Run after (poststart, posttest)
- **prepare**: Before publish
- **prepublishOnly**: Before publish only

**Example with lifecycle:**
```json
{
  "scripts": {
    "prestart": "echo 'Starting...'",
    "start": "node index.js",
    "poststart": "echo 'Started!'",
    "pretest": "npm run lint",
    "test": "jest",
    "posttest": "echo 'Tests completed'"
  }
}
```

**Passing arguments:**
```bash
# Pass arguments to script
npm run script-name -- --arg1 value1

# Example
npm run test -- --watchAll
```

**Environment variables:**
```bash
# Set environment variable
NODE_ENV=production npm start

# In script
"start": "NODE_ENV=production node index.js"
```

**Benefits:**
- Standardized commands across team
- Complex commands simplified
- Cross-platform compatibility
- Integration with CI/CD

---
---

## 4. File System Operations

#### 1. How do you read/write files in Node.js?

**Answer:**

Node.js provides the `fs` (file system) module for file operations.

**Reading files:**
```javascript
const fs = require('fs');

// Asynchronous read
fs.readFile('file.txt', 'utf8', (err, data) => {
  if (err) throw err;
  console.log(data);
});

// Synchronous read
try {
  const data = fs.readFileSync('file.txt', 'utf8');
  console.log(data);
} catch (err) {
  console.error(err);
}
```

**Writing files:**
```javascript
// Asynchronous write
fs.writeFile('file.txt', 'Hello World', 'utf8', (err) => {
  if (err) throw err;
  console.log('File written');
});

// Synchronous write
try {
  fs.writeFileSync('file.txt', 'Hello World', 'utf8');
  console.log('File written');
} catch (err) {
  console.error(err);
}
```

**Appending to files:**
```javascript
fs.appendFile('file.txt', '\nNew line', 'utf8', (err) => {
  if (err) throw err;
  console.log('Appended');
});
```

---

#### 2. What is the difference between synchronous and asynchronous file operations?

**Answer:**

| Feature | Synchronous | Asynchronous |
|---------|------------|--------------|
| **Blocking** | Blocks execution | Non-blocking |
| **Performance** | Slower | Faster |
| **Use Case** | Startup/config | Most operations |
| **Error Handling** | try/catch | Callback error-first |

**Synchronous (blocking):**
```javascript
console.log('Start');
const data = fs.readFileSync('large-file.txt'); // Blocks here
console.log('File read'); // Waits for file read
processData(data);
```

**Asynchronous (non-blocking):**
```javascript
console.log('Start');
fs.readFile('large-file.txt', (err, data) => {
  console.log('File read'); // Called later
  processData(data);
});
console.log('Continue execution'); // Executes immediately
```

**When to use each:**

**Use synchronous when:**
- Reading configuration files at startup
- Simple scripts where order matters
- During initialization

**Use asynchronous when:**
- Handling user requests
- Reading large files
- Multiple I/O operations
- Server applications

---

#### 3. How do you handle large files without loading them entirely into memory?

**Answer:**

Use **streams** to process files in chunks.

**Problem with readFile:**
```javascript
// Loads entire file into memory
fs.readFile('huge-file.txt', (err, data) => {
  // Memory issue with large files
});
```

**Solution with streams:**
```javascript
const readStream = fs.createReadStream('huge-file.txt', 'utf8');
let lineCount = 0;

readStream.on('data', (chunk) => {
  // Process chunk (small piece of file)
  lineCount += chunk.split('\n').length - 1;
});

readStream.on('end', () => {
  console.log(`Total lines: ${lineCount}`);
});

readStream.on('error', (err) => {
  console.error(err);
});
```

**Processing line by line:**
```javascript
const readline = require('readline');
const fs = require('fs');

const rl = readline.createInterface({
  input: fs.createReadStream('huge-file.txt'),
  crlfDelay: Infinity
});

rl.on('line', (line) => {
  // Process each line
  console.log(`Line: ${line}`);
});

rl.on('close', () => {
  console.log('File processed');
});
```

---

#### 4. What is fs.promises API?

**Answer:**

`fs.promises` provides promise-based versions of fs module functions.

**Traditional callback style:**
```javascript
fs.readFile('file.txt', 'utf8', (err, data) => {
  if (err) throw err;
  console.log(data);
});
```

**Promise-based style:**
```javascript
const fs = require('fs').promises;

async function readFile() {
  try {
    const data = await fs.readFile('file.txt', 'utf8');
    console.log(data);
  } catch (err) {
    console.error(err);
  }
}

readFile();
```

**Available methods:**
```javascript
const fs = require('fs').promises;

// Common operations
await fs.readFile('file.txt', 'utf8');
await fs.writeFile('file.txt', 'content');
await fs.appendFile('file.txt', 'more content');
await fs.unlink('file.txt'); // Delete
await fs.mkdir('folder');
await fs.readdir('folder');
await fs.stat('file.txt');
await fs.rename('old.txt', 'new.txt');
await fs.copyFile('source.txt', 'dest.txt');
```

**Benefits:**
- Cleaner code with async/await
- Better error handling with try/catch
- No callback hell
- Modern JavaScript style

---

#### 5. How do you watch for file changes?

**Answer:**

Use `fs.watch()` or `fs.watchFile()`.

**fs.watch() (recommended):**
```javascript
const fs = require('fs');

const watcher = fs.watch('file.txt', (eventType, filename) => {
  console.log(`Event: ${eventType}`);
  if (filename) {
    console.log(`File: ${filename}`);
  }
});

// Close watcher when done
setTimeout(() => {
  watcher.close();
  console.log('Stopped watching');
}, 10000);
```

**fs.watchFile() (polling-based):**
```javascript
fs.watchFile('file.txt', { interval: 1000 }, (curr, prev) => {
  console.log(`Current mtime: ${curr.mtime}`);
  console.log(`Previous mtime: ${prev.mtime}`);
  
  if (curr.mtime !== prev.mtime) {
    console.log('File changed');
  }
});

// Stop watching
fs.unwatchFile('file.txt');
```

**Differences:**

| Feature | fs.watch() | fs.watchFile() |
|---------|-----------|----------------|
| **Method** | OS events | Polling |
| **Performance** | Better | Worse |
| **Cross-platform** | Issues | Consistent |
| **Events** | 'change', 'rename' | Stat changes |

**Using chokidar (third-party, better):**
```bash
npm install chokidar
```

```javascript
const chokidar = require('chokidar');

const watcher = chokidar.watch('file.txt', {
  ignored: /(^|[\/\\])\../, // ignore dotfiles
  persistent: true
});

watcher
  .on('add', path => console.log(`File ${path} added`))
  .on('change', path => console.log(`File ${path} changed`))
  .on('unlink', path => console.log(`File ${path} removed`));
```

---

#### 6. What are the common file system operations you perform?

**Answer:**

**1. File operations:**
```javascript
// Read file
fs.readFile('file.txt', 'utf8', callback);

// Write file
fs.writeFile('file.txt', 'content', callback);

// Append to file
fs.appendFile('file.txt', 'more', callback);

// Delete file
fs.unlink('file.txt', callback);

// Rename file
fs.rename('old.txt', 'new.txt', callback);

// Copy file
fs.copyFile('source.txt', 'dest.txt', callback);

// Check if file exists
fs.access('file.txt', fs.constants.F_OK, callback);
```

**2. Directory operations:**
```javascript
// Create directory
fs.mkdir('folder', callback);

// Create nested directories
fs.mkdir('folder/subfolder', { recursive: true }, callback);

// Read directory
fs.readdir('folder', callback);

// Remove directory
fs.rmdir('folder', callback);

// Remove directory recursively
fs.rm('folder', { recursive: true }, callback);
```

**3. File info:**
```javascript
// Get file stats
fs.stat('file.txt', (err, stats) => {
  console.log(stats.isFile());      // true
  console.log(stats.isDirectory()); // false
  console.log(stats.size);          // bytes
  console.log(stats.mtime);         // modification time
});
```

**4. Path operations:**
```javascript
const path = require('path');

// Join paths
path.join('folder', 'file.txt'); // 'folder/file.txt'

// Get extension
path.extname('file.txt'); // '.txt'

// Get basename
path.basename('folder/file.txt'); // 'file.txt'

// Get directory name
path.dirname('folder/file.txt'); // 'folder'

// Resolve absolute path
path.resolve('file.txt'); // '/absolute/path/file.txt'
```

---

#### 7. How do you handle file permissions in Node.js?

**Answer:**

**Checking permissions:**
```javascript
const fs = require('fs');

// Check if file exists
fs.access('file.txt', fs.constants.F_OK, (err) => {
  console.log(err ? 'File does not exist' : 'File exists');
});

// Check read permission
fs.access('file.txt', fs.constants.R_OK, (err) => {
  console.log(err ? 'No read access' : 'Can read');
});

// Check write permission
fs.access('file.txt', fs.constants.W_OK, (err) => {
  console.log(err ? 'No write access' : 'Can write');
});

// Check execute permission
fs.access('file.txt', fs.constants.X_OK, (err) => {
  console.log(err ? 'No execute access' : 'Can execute');
});
```

**Changing permissions:**
```javascript
// Change permissions (chmod)
fs.chmod('file.txt', 0o755, (err) => {
  // 755 = rwxr-xr-x
  // Owner: read, write, execute (7)
  // Group: read, execute (5)
  // Others: read, execute (5)
});

// Octal notation:
// 0o400 = read by owner
// 0o200 = write by owner
// 0o100 = execute by owner
// 0o040 = read by group
// 0o020 = write by group
// 0o010 = execute by group
// 0o004 = read by others
// 0o002 = write by others
// 0o001 = execute by others
```

**Changing ownership:**
```javascript
// Change file owner (chown)
fs.chown('file.txt', 1000, 1000, (err) => {
  // uid = 1000, gid = 1000
});
```

**File mode constants:**
```javascript
// Common modes
fs.constants.S_IRUSR // Read by owner
fs.constants.S_IWUSR // Write by owner
fs.constants.S_IXUSR // Execute by owner
fs.constants.S_IRGRP // Read by group
fs.constants.S_IWGRP // Write by group
fs.constants.S_IXGRP // Execute by group
fs.constants.S_IROTH // Read by others
fs.constants.S_IWOTH // Write by others
fs.constants.S_IXOTH // Execute by others
```

---

#### 8. What is the difference between fs.readFile and fs.createReadStream?

**Answer:**

| Feature | fs.readFile | fs.createReadStream |
|---------|------------|-------------------|
| **Memory** | Loads entire file | Processes in chunks |
| **Performance** | Slower for large files | Faster for large files |
| **Use Case** | Small files | Large files |
| **Backpressure** | No | Automatic |
| **Event-based** | No | Yes |

**fs.readFile (entire file):**
```javascript
// Good for small files (< 100MB)
fs.readFile('small-file.txt', 'utf8', (err, data) => {
  // Entire file in memory
  console.log(data.length); // File size
});
```

**fs.createReadStream (chunks):**
```javascript
// Good for large files
const stream = fs.createReadStream('large-file.txt', 'utf8');
let totalSize = 0;

stream.on('data', (chunk) => {
  totalSize += chunk.length;
  // Process chunk by chunk
});

stream.on('end', () => {
  console.log(`Total size: ${totalSize}`);
});
```

**When to use each:**

**Use readFile when:**
- File is small (< 100MB)
- Need entire content at once
- Simple file operations
- Configuration files

**Use createReadStream when:**
- File is large (> 100MB)
- Processing line by line
- Real-time processing
- Memory efficiency needed
- Network transfers

**Example: File copy**
```javascript
// Inefficient with large files
fs.readFile('source.txt', (err, data) => {
  fs.writeFile('dest.txt', data, (err) => {});
});

// Efficient with streams
const readStream = fs.createReadStream('source.txt');
const writeStream = fs.createWriteStream('dest.txt');
readStream.pipe(writeStream);
```

---
---

## 5. Streams & Buffers

#### 1. What are Streams in Node.js and why are they useful?

**Answer:**

**Streams** are objects that let you read data from a source or write data to a destination in a continuous fashion. They process data in chunks instead of loading everything into memory.

**Why streams are useful:**

1. **Memory efficiency**: Process large files without loading into memory
2. **Time efficiency**: Start processing immediately, don't wait for entire data
3. **Composability**: Pipe multiple streams together
4. **Backpressure handling**: Automatic flow control

**Real-world analogy:**
- **Without streams**: Fill entire bathtub, then pour out (read entire file, then process)
- **With streams**: Use shower (process as water flows)

**Example: Reading large file**
```javascript
const fs = require('fs');

// Without stream (memory intensive)
fs.readFile('huge-file.txt', (err, data) => {
  // Entire file in memory
});

// With stream (memory efficient)
const stream = fs.createReadStream('huge-file.txt');
stream.on('data', (chunk) => {
  // Process small chunks
});
```

---

#### 2. Explain the four types of streams

**Answer:**

**1. Readable Streams**
- Read data from a source
- Examples: `fs.createReadStream()`, `http.IncomingMessage`

```javascript
const readable = fs.createReadStream('file.txt');

readable.on('data', (chunk) => {
  console.log(`Received ${chunk.length} bytes`);
});

readable.on('end', () => {
  console.log('No more data');
});
```

**2. Writable Streams**
- Write data to a destination
- Examples: `fs.createWriteStream()`, `http.ServerResponse`

```javascript
const writable = fs.createWriteStream('output.txt');

writable.write('Hello\n');
writable.write('World\n');
writable.end(); // Finish writing
```

**3. Duplex Streams**
- Both readable and writable
- Examples: `net.Socket`, `zlib streams`

```javascript
const { Duplex } = require('stream');

const duplex = new Duplex({
  read(size) {
    // Push data to readable side
  },
  write(chunk, encoding, callback) {
    // Process data from writable side
    callback();
  }
});
```

**4. Transform Streams**
- Type of duplex stream
- Transform data as it's written/read
- Examples: `zlib.createGzip()`, `crypto streams`

```javascript
const { Transform } = require('stream');

const upperCaseTransform = new Transform({
  transform(chunk, encoding, callback) {
    this.push(chunk.toString().toUpperCase());
    callback();
  }
});
```

---

#### 3. How do you handle backpressure in streams?

**Answer:**

**Backpressure** occurs when data is produced faster than it can be consumed. Node.js handles this automatically with streams.

**Automatic backpressure:**
```javascript
const readable = fs.createReadStream('input.txt');
const writable = fs.createWriteStream('output.txt');

// Pipe handles backpressure automatically
readable.pipe(writable);
```

**Manual backpressure handling:**
```javascript
const readable = fs.createReadStream('input.txt');
const writable = fs.createWriteStream('output.txt');

readable.on('data', (chunk) => {
  // Check if writable stream can accept more data
  if (!writable.write(chunk)) {
    // Pause readable until drain event
    readable.pause();
  }
});

writable.on('drain', () => {
  // Resume readable when writable is ready
  readable.resume();
});

readable.on('end', () => {
  writable.end();
});
```

**Signs of backpressure:**
- High memory usage
- Slow processing
- `write()` returns `false`

**Best practices:**
1. Always use `.pipe()` when possible
2. Handle `drain` events for manual control
3. Monitor memory usage
4. Use appropriate buffer sizes

---

#### 4. What is piping and how does it work?

**Answer:**

**Piping** connects a readable stream to a writable stream, automatically handling backpressure and errors.

**Basic pipe:**
```javascript
const fs = require('fs');

const readable = fs.createReadStream('input.txt');
const writable = fs.createWriteStream('output.txt');

// Pipe data from readable to writable
readable.pipe(writable);
```

**Chaining pipes:**
```javascript
const fs = require('fs');
const zlib = require('zlib');

// Read → Compress → Write
fs.createReadStream('input.txt')
  .pipe(zlib.createGzip())
  .pipe(fs.createWriteStream('input.txt.gz'));
```

**Pipe with error handling:**
```javascript
readable
  .pipe(transformStream)
  .pipe(writable)
  .on('error', (err) => {
    console.error('Pipe error:', err);
  });
```

**What `.pipe()` does:**
1. Connects streams
2. Handles backpressure automatically
3. Forwards errors
4. Cleans up when done

**Manual equivalent of pipe:**
```javascript
readable.on('data', (chunk) => {
  if (!writable.write(chunk)) {
    readable.pause();
  }
});

writable.on('drain', () => {
  readable.resume();
});

readable.on('end', () => {
  writable.end();
});
```

---

#### 5. What are Buffers and when would you use them?

**Answer:**

**Buffers** are temporary storage for binary data in Node.js. They represent fixed-size chunks of memory.

**Creating buffers:**
```javascript
// From string
const buf1 = Buffer.from('Hello');

// From array
const buf2 = Buffer.from([0x48, 0x65, 0x6c, 0x6c, 0x6f]);

// Allocate empty buffer
const buf3 = Buffer.alloc(10); // 10 bytes
const buf4 = Buffer.allocUnsafe(10); // Faster but may contain old data
```

**Buffer operations:**
```javascript
const buf = Buffer.from('Hello World');

// Get length
console.log(buf.length); // 11

// Get byte at position
console.log(buf[0]); // 72 (ASCII 'H')

// Convert to string
console.log(buf.toString()); // 'Hello World'
console.log(buf.toString('hex')); // '48656c6c6f20576f726c64'
console.log(buf.toString('base64')); // 'SGVsbG8gV29ybGQ='

// Slice buffer
const slice = buf.slice(0, 5); // 'Hello'

// Copy buffer
const copy = Buffer.alloc(5);
buf.copy(copy, 0, 0, 5); // Copy first 5 bytes
```

**When to use buffers:**

1. **Binary data processing**
```javascript
// Image processing
const imageBuffer = fs.readFileSync('image.jpg');
```

2. **Network communication**
```javascript
// Socket communication
socket.on('data', (buffer) => {
  // Process binary data
});
```

3. **Cryptography**
```javascript
const crypto = require('crypto');
const hash = crypto.createHash('sha256');
hash.update(buffer);
```

4. **File operations**
```javascript
// Reading binary files
fs.readFile('file.bin', (err, buffer) => {
  // buffer is a Buffer object
});
```

---

#### 6. How do streams help with memory efficiency?

**Answer:**

**Problem without streams:**
```javascript
// Loads 1GB file into memory
fs.readFile('1gb-file.txt', (err, data) => {
  // Uses 1GB+ of RAM
  processData(data);
});
// Can't process other requests while loading
```

**Solution with streams:**
```javascript
// Processes in 64KB chunks
const stream = fs.createReadStream('1gb-file.txt', {
  highWaterMark: 64 * 1024 // 64KB chunks
});

stream.on('data', (chunk) => {
  // Uses only 64KB of RAM at a time
  processChunk(chunk);
});
// Can handle other requests simultaneously
```

**Memory comparison:**

| Approach | Memory Usage | Processing |
|----------|-------------|------------|
| **readFile** | Entire file size | After loading complete |
| **Streams** | Chunk size | Immediately |

**Example: Processing large CSV**
```javascript
const csv = require('csv-parser');
const fs = require('fs');

// Memory efficient: processes line by line
fs.createReadStream('large.csv')
  .pipe(csv())
  .on('data', (row) => {
    // Process each row immediately
    console.log(row);
  })
  .on('end', () => {
    console.log('CSV file processed');
  });
```

**Benefits:**
- **Scalable**: Handle files of any size
- **Responsive**: Start processing immediately
- **Parallel**: Handle multiple streams
- **Stable**: No memory spikes

---

#### 7. What is the difference between stream.pipe() and event-based streaming?

**Answer:**

**stream.pipe() (declarative):**
```javascript
// Simple, automatic
readable.pipe(writable);

// Handles:
// - Backpressure automatically
// - Error forwarding
// - Cleanup on finish
```

**Event-based (imperative):**
```javascript
// More control, more code
readable.on('data', (chunk) => {
  if (!writable.write(chunk)) {
    readable.pause();
  }
});

writable.on('drain', () => {
  readable.resume();
});

readable.on('end', () => {
  writable.end();
});

readable.on('error', (err) => {
  writable.destroy(err);
});

writable.on('error', (err) => {
  readable.destroy(err);
});
```

**Comparison:**

| Feature | stream.pipe() | Event-based |
|---------|--------------|-------------|
| **Code length** | Short | Long |
| **Backpressure** | Automatic | Manual |
| **Error handling** | Automatic | Manual |
| **Control** | Limited | Full |
| **Readability** | High | Low |

**When to use pipe():**
- Simple data transfer
- Standard transformations
- When you don't need fine-grained control

**When to use event-based:**
- Custom processing logic
- Complex error handling
- Special backpressure needs
- Multiple destinations

**Example: Multiple destinations**
```javascript
// With pipe() - can't do this directly
// readable.pipe(writable1).pipe(writable2); // WRONG

// Event-based - can do this
readable.on('data', (chunk) => {
  writable1.write(chunk);
  writable2.write(chunk);
});
```

---

#### 8. How do you create custom streams?

**Answer:**

**1. Custom Readable Stream**
```javascript
const { Readable } = require('stream');

class MyReadable extends Readable {
  constructor(options) {
    super(options);
    this.data = ['Hello', 'World', 'Streams'];
    this.index = 0;
  }
  
  _read(size) {
    if (this.index < this.data.length) {
      this.push(this.data[this.index]);
      this.index++;
    } else {
      this.push(null); // No more data
    }
  }
}

const readable = new MyReadable();
readable.on('data', (chunk) => {
  console.log(chunk.toString());
});
```

**2. Custom Writable Stream**
```javascript
const { Writable } = require('stream');

class MyWritable extends Writable {
  constructor(options) {
    super(options);
    this.data = [];
  }
  
  _write(chunk, encoding, callback) {
    this.data.push(chunk.toString());
    console.log(`Received: ${chunk.toString()}`);
    callback(); // Signal ready for next chunk
  }
  
  _final(callback) {
    console.log('All data:', this.data);
    callback();
  }
}

const writable = new MyWritable();
writable.write('Hello');
writable.write('World');
writable.end();
```

**3. Custom Transform Stream**
```javascript
const { Transform } = require('stream');

class UpperCaseTransform extends Transform {
  _transform(chunk, encoding, callback) {
    const upperChunk = chunk.toString().toUpperCase();
    this.push(upperChunk);
    callback();
  }
}

const transform = new UpperCaseTransform();
process.stdin.pipe(transform).pipe(process.stdout);
```

**4. Using simplified constructor**
```javascript
const readable = new Readable({
  read(size) {
    // Custom read logic
  }
});

const writable = new Writable({
  write(chunk, encoding, callback) {
    // Custom write logic
    callback();
  }
});

const transform = new Transform({
  transform(chunk, encoding, callback) {
    // Custom transform logic
    this.push(chunk);
    callback();
  }
});
```

**Common use cases:**
- Data transformation
- Logging streams
- Custom protocols
- Data validation
- Rate limiting

---
---

## 6. Error Handling

#### 1. What are the different error types in Node.js?

**Answer:**

**1. Standard JavaScript Errors**
```javascript
// Syntax errors (parse-time)
const x = ; // SyntaxError

// Reference errors
console.log(undefinedVariable); // ReferenceError

// Type errors
null.function(); // TypeError

// Range errors
const arr = new Array(-1); // RangeError

// URI errors
decodeURIComponent('%'); // URIError

// Eval errors
eval('x ='); // EvalError
```

**2. System Errors**
- File system errors (ENOENT, EACCES)
- Network errors (ECONNREFUSED, ETIMEDOUT)
- Process errors (EAGAIN, EINTR)

```javascript
const fs = require('fs');

fs.readFile('nonexistent.txt', (err, data) => {
  if (err) {
    console.log(err.code); // 'ENOENT'
    console.log(err.message); // 'no such file or directory'
    console.log(err.syscall); // 'open'
    console.log(err.path); // 'nonexistent.txt'
  }
});
```

**3. Custom Errors**
```javascript
class ValidationError extends Error {
  constructor(message) {
    super(message);
    this.name = 'ValidationError';
    this.code = 'VALIDATION_ERROR';
  }
}

throw new ValidationError('Invalid input');
```

**4. Promise Rejections**
```javascript
new Promise((resolve, reject) => {
  reject(new Error('Promise rejected'));
});
```

**5. Async/Await Errors**
```javascript
async function fetchData() {
  throw new Error('Async error');
}
```

---

#### 2. How do you handle errors in asynchronous code?

**Answer:**

**1. Callback pattern (error-first)**
```javascript
fs.readFile('file.txt', 'utf8', (err, data) => {
  if (err) {
    // Handle error
    console.error('Error reading file:', err);
    return;
  }
  
  // Process data
  console.log(data);
});
```

**2. Promises**
```javascript
fetch('/api/data')
  .then(response => response.json())
  .then(data => {
    // Process data
  })
  .catch(err => {
    // Handle error
    console.error('Error:', err);
  })
  .finally(() => {
    // Cleanup
  });
```

**3. Async/Await**
```javascript
async function getData() {
  try {
    const response = await fetch('/api/data');
    const data = await response.json();
    return data;
  } catch (err) {
    // Handle error
    console.error('Error:', err);
    throw err; // Re-throw if needed
  }
}
```

**4. Event emitters**
```javascript
const stream = fs.createReadStream('file.txt');

stream.on('error', (err) => {
  console.error('Stream error:', err);
});

stream.on('data', (chunk) => {
  // Process data
});
```

**Best practices:**
- Always handle errors, don't ignore them
- Log errors with context
- Use appropriate error types
- Don't swallow errors silently

---

#### 3. What is the error-first callback pattern?

**Answer:**

The **error-first callback** pattern is a convention in Node.js where callbacks take an error as the first argument.

**Pattern:**
```javascript
function asyncOperation(arg1, arg2, callback) {
  // Some async operation
  if (error) {
    callback(new Error('Something went wrong'));
  } else {
    callback(null, result);
  }
}

// Usage
asyncOperation('arg1', 'arg2', (err, result) => {
  if (err) {
    // Handle error
    return;
  }
  
  // Use result
});
```

**Why error-first?**
1. **Consistency**: All Node.js core APIs use this pattern
2. **Forces error handling**: Error is always first argument
3. **Clear intent**: Easy to see if operation succeeded

**Examples in Node.js core:**
```javascript
// File system
fs.readFile('file.txt', 'utf8', (err, data) => {});

// HTTP server
http.createServer((req, res) => {}).listen(3000, (err) => {});

// Child process
exec('ls', (err, stdout, stderr) => {});

// Database
db.query('SELECT * FROM users', (err, results) => {});
```

**Creating error-first callbacks:**
```javascript
function readConfigFile(callback) {
  fs.readFile('config.json', 'utf8', (err, data) => {
    if (err) {
      callback(err);
      return;
    }
    
    try {
      const config = JSON.parse(data);
      callback(null, config);
    } catch (parseErr) {
      callback(new Error('Invalid JSON'));
    }
  });
}
```

---

#### 4. How do you handle uncaught exceptions?

**Answer:**

**1. process.on('uncaughtException')**
```javascript
process.on('uncaughtException', (err) => {
  console.error('Uncaught Exception:', err);
  
  // Perform cleanup
  closeDatabaseConnections();
  closeFileHandles();
  
  // Exit process (recommended)
  process.exit(1);
});
```

**2. process.on('unhandledRejection')**
```javascript
process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise);
  console.error('Reason:', reason);
  
  // Application specific logging/cleanup
  process.exit(1);
});
```

**3. Domain module (deprecated)**
```javascript
// Not recommended for new code
const domain = require('domain');
const d = domain.create();

d.on('error', (err) => {
  console.error('Domain caught error:', err);
});

d.run(() => {
  // Code that might throw
});
```

**Best practices:**
1. **Log the error**: Always log before exiting
2. **Clean up resources**: Close connections, files
3. **Exit the process**: Don't continue in unstable state
4. **Use monitoring**: Integrate with error tracking services

**What NOT to do:**
```javascript
// DON'T do this - process continues in bad state
process.on('uncaughtException', (err) => {
  console.log('Ignoring error:', err);
  // Process continues but may be corrupted
});
```

**Production setup:**
```javascript
// Error handling setup
function setupErrorHandling() {
  process.on('uncaughtException', (err) => {
    console.error('Uncaught Exception:', err);
    // Send to error tracking service
    errorTracker.captureException(err);
    process.exit(1);
  });
  
  process.on('unhandledRejection', (reason, promise) => {
    console.error('Unhandled Rejection:', reason);
    errorTracker.captureException(reason);
    process.exit(1);
  });
}
```

---

#### 5. What is a try-catch block and when should you use it?

**Answer:**

**try-catch** is used to handle synchronous errors.

**Basic syntax:**
```javascript
try {
  // Code that might throw
  const result = riskyOperation();
  console.log(result);
} catch (err) {
  // Handle error
  console.error('Error:', err);
} finally {
  // Always executes
  cleanup();
}
```

**When to use try-catch:**

**1. Synchronous operations**
```javascript
try {
  const data = JSON.parse(invalidJson);
} catch (err) {
  console.error('Invalid JSON:', err);
}
```

**2. With async/await**
```javascript
async function fetchData() {
  try {
    const response = await fetch('/api/data');
    const data = await response.json();
    return data;
  } catch (err) {
    console.error('Fetch error:', err);
    throw err;
  }
}
```

**When NOT to use try-catch:**

**1. Asynchronous callbacks (doesn't work)**
```javascript
// WRONG - won't catch async errors
try {
  setTimeout(() => {
    throw new Error('Async error');
  }, 1000);
} catch (err) {
  console.log('This never runs');
}
```

**2. Promise rejections (use .catch())**
```javascript
// Use .catch() instead
promise
  .then(result => {})
  .catch(err => console.error(err));
```

**Nested try-catch:**
```javascript
try {
  try {
    // Inner operation
  } catch (innerErr) {
    // Handle inner error
    throw new Error('Wrapped error', { cause: innerErr });
  }
} catch (outerErr) {
  console.error('Outer error:', outerErr);
  console.error('Cause:', outerErr.cause);
}
```

**Error types in catch:**
```javascript
try {
  // Some operation
} catch (err) {
  if (err instanceof TypeError) {
    console.error('Type error:', err);
  } else if (err instanceof RangeError) {
    console.error('Range error:', err);
  } else {
    console.error('Unknown error:', err);
  }
}
```

---

#### 6. How do you create custom error classes?

**Answer:**

**1. ES6 Class syntax**
```javascript
class AppError extends Error {
  constructor(message, statusCode = 500) {
    super(message);
    this.name = this.constructor.name;
    this.statusCode = statusCode;
    this.isOperational = true;
    
    // Capture stack trace
    Error.captureStackTrace(this, this.constructor);
  }
}

class ValidationError extends AppError {
  constructor(message, field) {
    super(message, 400);
    this.field = field;
    this.code = 'VALIDATION_ERROR';
  }
}

// Usage
throw new ValidationError('Email is required', 'email');
```

**2. Traditional prototype syntax**
```javascript
function DatabaseError(message, query) {
  Error.call(this, message);
  this.name = 'DatabaseError';
  this.query = query;
  this.code = 'DB_ERROR';
  
  Error.captureStackTrace(this, DatabaseError);
}

DatabaseError.prototype = Object.create(Error.prototype);
DatabaseError.prototype.constructor = DatabaseError;
```

**3. Factory function**
```javascript
function createError(name, defaultMessage) {
  return class CustomError extends Error {
    constructor(message = defaultMessage, ...args) {
      super(message);
      this.name = name;
      this.code = name.toUpperCase().replace(/ERROR$/, '') + '_ERROR';
      
      if (Error.captureStackTrace) {
        Error.captureStackTrace(this, CustomError);
      }
    }
  };
}

const NetworkError = createError('NetworkError', 'Network request failed');
const AuthError = createError('AuthError', 'Authentication failed');
```

**4. With additional properties**
```javascript
class APIError extends Error {
  constructor(message, options = {}) {
    super(message);
    this.name = 'APIError';
    this.status = options.status || 500;
    this.code = options.code || 'INTERNAL_ERROR';
    this.details = options.details || {};
    this.timestamp = new Date().toISOString();
    
    if (options.cause) {
      this.cause = options.cause;
    }
  }
  
  toJSON() {
    return {
      error: this.name,
      message: this.message,
      code: this.code,
      status: this.status,
      timestamp: this.timestamp,
      details: this.details
    };
  }
}
```

**Usage patterns:**
```javascript
// Throwing custom errors
if (!user) {
  throw new AuthError('User not authenticated', { userId });
}

// Catching and handling
try {
  // Some operation
} catch (err) {
  if (err instanceof ValidationError) {
    res.status(400).json({ error: err.message, field: err.field });
  } else if (err instanceof AuthError) {
    res.status(401).json({ error: err.message });
  } else {
    res.status(500).json({ error: 'Internal server error' });
  }
}
```

---

#### 7. What is the difference between operational errors and programmer errors?

**Answer:**

**Operational Errors:**
- Expected error conditions
- External factors cause them
- Should be handled gracefully
- Don't indicate bugs

**Examples:**
- File not found
- Network timeout
- Invalid user input
- Database connection lost
- Out of memory

**Handling:**
```javascript
// Operational errors should be handled
fs.readFile('config.json', (err, data) => {
  if (err) {
    if (err.code === 'ENOENT') {
      // File doesn't exist - use default config
      return useDefaultConfig();
    }
    // Other operational error
    logError(err);
    return;
  }
  // Process data
});
```

**Programmer Errors:**
- Bugs in the code
- Should not happen in production
- Indicate problems to fix
- Often unrecoverable

**Examples:**
- Calling undefined function
- Passing wrong argument types
- Syntax errors
- Logic errors
- Assertion failures

**Handling:**
```javascript
// Programmer errors should crash in development
function calculateTotal(items) {
  // Assertion for programmer error
  if (!Array.isArray(items)) {
    throw new TypeError('items must be an array');
  }
  
  return items.reduce((sum, item) => sum + item.price, 0);
}
```

**Comparison:**

| Aspect | Operational Errors | Programmer Errors |
|--------|-------------------|-------------------|
| **Cause** | External factors | Code bugs |
| **Recovery** | Often possible | Usually not |
| **Handling** | Catch and handle | Fix the code |
| **Examples** | Network issues, invalid input | Type errors, undefined vars |
| **In Production** | Expected | Should be rare |

**Best practices:**
1. **Handle operational errors** gracefully
2. **Crash on programmer errors** in development
3. **Log both types** appropriately
4. **Monitor operational errors** for patterns
5. **Fix programmer errors** immediately

---

#### 8. How do you handle promise rejections?

**Answer:**

**1. .catch() method**
```javascript
fetch('/api/data')
  .then(response => response.json())
  .then(data => {
    // Process data
  })
  .catch(err => {
    // Handle any error in the chain
    console.error('Error:', err);
  });
```

**2. Async/await with try-catch**
```javascript
async function getData() {
  try {
    const response = await fetch('/api/data');
    const data = await response.json();
    return data;
  } catch (err) {
    console.error('Error:', err);
    throw err; // Re-throw if needed
  }
}
```

**3. Promise constructor error handling**
```javascript
new Promise((resolve, reject) => {
  // Async operation
  if (error) {
    reject(new Error('Operation failed'));
  } else {
    resolve(result);
  }
});
```

**4. Handling multiple promises**
```javascript
// All promises must succeed
Promise.all([promise1, promise2])
  .then(results => {})
  .catch(err => {
    // First rejection stops all
  });

// Wait for all to settle
Promise.allSettled([promise1, promise2])
  .then(results => {
    results.forEach(result => {
      if (result.status === 'rejected') {
        console.error('Failed:', result.reason);
      }
    });
  });

// First to settle wins
Promise.race([promise1, promise2])
  .then(result => {})
  .catch(err => {});
```

**5. Global promise rejection handling**
```javascript
// Handle unhandled promise rejections
process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise);
  console.error('Reason:', reason);
  // Application specific logging/cleanup
});

// Handle rejections that were handled later
process.on('rejectionHandled', (promise) => {
  console.log('Rejection handled:', promise);
});
```

**6. Converting callbacks to promises**
```javascript
const util = require('util');
const fs = require('fs');

// Convert callback-based function to promise-based
const readFile = util.promisify(fs.readFile);

readFile('file.txt', 'utf8')
  .then(data => console.log(data))
  .catch(err => console.error(err));
```

**7. Error propagation in promise chains**
```javascript
fetch('/api/data')
  .then(response => {
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}`);
    }
    return response.json();
  })
  .then(data => {
    if (!data.valid) {
      throw new ValidationError('Invalid data');
    }
    return data;
  })
  .catch(NetworkError, err => {
    // Handle network errors specifically
    return getCachedData();
  })
  .catch(ValidationError, err => {
    // Handle validation errors
    return getDefaultData();
  })
  .catch(err => {
    // Handle all other errors
    console.error('Unexpected error:', err);
  });
```

**Best practices:**
- Always handle promise rejections
- Don't leave promises unhandled
- Use specific error types
- Log errors appropriately
- Consider retry logic for transient errors

---

## 7. Express Basics & Middleware

#### 1. What is Express.js and why is it used?

**Answer:**

**Express.js** is a minimal and flexible Node.js web application framework that provides a robust set of features for web and mobile applications.

**Why use Express:**

1. **Simplifies routing**: Easy route definition
2. **Middleware support**: Modular request processing
3. **Template engines**: Server-side rendering
4. **Static file serving**: Built-in static file server
5. **Error handling**: Centralized error management
6. **Large ecosystem**: Many plugins and middleware
7. **Performance**: Fast and lightweight

**Basic example:**
```javascript
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello World');
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});
```

---

#### 2. How does Express differ from the native Node.js HTTP module?

**Answer:**

| Feature | Native HTTP | Express |
|---------|------------|---------|
| **Routing** | Manual | Built-in |
| **Middleware** | Manual | Built-in |
| **Request parsing** | Manual | Automatic |
| **Code complexity** | High | Low |
| **Features** | Basic | Rich |

**Native HTTP module:**
```javascript
const http = require('http');

const server = http.createServer((req, res) => {
  // Manual routing
  if (req.url === '/' && req.method === 'GET') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Home');
  } else if (req.url === '/about' && req.method === 'GET') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('About');
  } else {
    res.writeHead(404);
    res.end('Not Found');
  }
});

server.listen(3000);
```

**Express:**
```javascript
const express = require('express');
const app = express();

app.get('/', (req, res) => res.send('Home'));
app.get('/about', (req, res) => res.send('About'));

app.listen(3000);
```

---

#### 3. What is middleware in Express?

**Answer:**

**Middleware** are functions that have access to the request object (req), response object (res), and the next middleware function in the application's request-response cycle.

**Middleware signature:**
```javascript
function middleware(req, res, next) {
  // Do something
  next(); // Pass control to next middleware
}
```

**Types of middleware:**

**1. Application-level middleware:**
```javascript
app.use((req, res, next) => {
  console.log('Time:', Date.now());
  next();
});
```

**2. Router-level middleware:**
```javascript
const router = express.Router();
router.use((req, res, next) => {
  console.log('Router middleware');
  next();
});
```

**3. Error-handling middleware:**
```javascript
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});
```

**4. Built-in middleware:**
```javascript
app.use(express.json());
app.use(express.static('public'));
```

**5. Third-party middleware:**
```javascript
const morgan = require('morgan');
app.use(morgan('dev'));
```

---

#### 4. How does the middleware execution order work?

**Answer:**

Middleware executes in the order it's defined. Each middleware must call `next()` to pass control to the next middleware.

**Execution flow:**
```javascript
const express = require('express');
const app = express();

// Middleware 1
app.use((req, res, next) => {
  console.log('1. First middleware');
  next();
});

// Middleware 2
app.use((req, res, next) => {
  console.log('2. Second middleware');
  next();
});

// Route handler
app.get('/', (req, res) => {
  console.log('3. Route handler');
  res.send('Response');
});

// This won't execute (after response sent)
app.use((req, res, next) => {
  console.log('4. This never runs');
  next();
});

// Output:
// 1. First middleware
// 2. Second middleware
// 3. Route handler
```

**Important rules:**
1. Order matters
2. Must call `next()` to continue
3. Can stop chain by sending response
4. Error middleware has 4 parameters

---

#### 5. What is app.use() and how is it different from app.get() or app.post()?

**Answer:**

| Feature | app.use() | app.get() / app.post() |
|---------|-----------|----------------------|
| **Purpose** | Middleware | Route handler |
| **HTTP Method** | All methods | Specific method |
| **Path matching** | Prefix match | Exact match |
| **Parameters** | (path, middleware) | (path, handler) |

**app.use() - applies to all methods:**
```javascript
// Matches all methods and paths starting with /api
app.use('/api', (req, res, next) => {
  console.log('API middleware');
  next();
});

// Matches all methods and all paths
app.use((req, res, next) => {
  console.log('Global middleware');
  next();
});
```

**app.get() / app.post() - specific methods:**
```javascript
// Only matches GET requests to /users
app.get('/users', (req, res) => {
  res.send('GET users');
});

// Only matches POST requests to /users
app.post('/users', (req, res) => {
  res.send('POST users');
});
```

**Path matching difference:**
```javascript
// app.use() - prefix match
app.use('/api', middleware);
// Matches: /api, /api/users, /api/posts, etc.

// app.get() - exact match
app.get('/api', handler);
// Matches: /api only
```

---

#### 6. How do you create a basic Express server?

**Answer:**

**Minimal server:**
```javascript
const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
```

**Complete server with middleware:**
```javascript
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json()); // Parse JSON bodies
app.use(express.urlencoded({ extended: true })); // Parse URL-encoded bodies
app.use(express.static('public')); // Serve static files

// Logging middleware
app.use((req, res, next) => {
  console.log(`${req.method} ${req.url}`);
  next();
});

// Routes
app.get('/', (req, res) => {
  res.send('Home Page');
});

app.get('/api/users', (req, res) => {
  res.json({ users: [] });
});

app.post('/api/users', (req, res) => {
  const user = req.body;
  res.status(201).json({ message: 'User created', user });
});

// 404 handler
app.use((req, res) => {
  res.status(404).send('Not Found');
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

---

#### 7. What is the purpose of express.json() and express.urlencoded()?

**Answer:**

**express.json():**
- Parses incoming requests with JSON payloads
- Makes parsed data available in `req.body`

```javascript
app.use(express.json());

app.post('/api/data', (req, res) => {
  console.log(req.body); // { name: 'John', age: 30 }
  res.json({ received: req.body });
});

// Client sends:
// Content-Type: application/json
// { "name": "John", "age": 30 }
```

**express.urlencoded():**
- Parses incoming requests with URL-encoded payloads
- Used for HTML form submissions

```javascript
app.use(express.urlencoded({ extended: true }));

app.post('/submit', (req, res) => {
  console.log(req.body); // { name: 'John', email: 'john@example.com' }
  res.send('Form received');
});

// Client sends:
// Content-Type: application/x-www-form-urlencoded
// name=John&email=john@example.com
```

**extended option:**
- `extended: true` - Uses qs library (supports nested objects)
- `extended: false` - Uses querystring library (simple)

```javascript
// With extended: true
// name[first]=John&name[last]=Doe
// → { name: { first: 'John', last: 'Doe' } }

// With extended: false
// name[first]=John&name[last]=Doe
// → { 'name[first]': 'John', 'name[last]': 'Doe' }
```

---

#### 8. How do you handle different environments (development, production) in Express?

**Answer:**

**Using environment variables:**
```javascript
const express = require('express');
const app = express();

const PORT = process.env.PORT || 3000;
const NODE_ENV = process.env.NODE_ENV || 'development';

// Environment-specific middleware
if (NODE_ENV === 'development') {
  const morgan = require('morgan');
  app.use(morgan('dev')); // Detailed logging
} else {
  app.use(morgan('combined')); // Production logging
}

// Environment-specific settings
app.set('trust proxy', NODE_ENV === 'production');

// Error handling
if (NODE_ENV === 'development') {
  app.use((err, req, res, next) => {
    res.status(500).json({
      error: err.message,
      stack: err.stack // Show stack in development
    });
  });
} else {
  app.use((err, req, res, next) => {
    res.status(500).json({
      error: 'Internal Server Error' // Hide details in production
    });
  });
}

app.listen(PORT);
```

**Using .env files:**
```bash
# .env.development
NODE_ENV=development
PORT=3000
DB_HOST=localhost
DEBUG=true

# .env.production
NODE_ENV=production
PORT=80
DB_HOST=prod-db.example.com
DEBUG=false
```

```javascript
require('dotenv').config();

const config = {
  port: process.env.PORT,
  dbHost: process.env.DB_HOST,
  debug: process.env.DEBUG === 'true'
};
```

**Configuration file approach:**
```javascript
// config/index.js
const development = {
  port: 3000,
  db: 'mongodb://localhost/dev',
  logLevel: 'debug'
};

const production = {
  port: process.env.PORT,
  db: process.env.DB_URL,
  logLevel: 'error'
};

const config = process.env.NODE_ENV === 'production' ? production : development;

module.exports = config;
```

---

## 8. Routing & HTTP Methods

#### 1. How do you define routes in Express?

**Answer:**

**Basic route definition:**
```javascript
const express = require('express');
const app = express();

// GET route
app.get('/users', (req, res) => {
  res.send('Get all users');
});

// POST route
app.post('/users', (req, res) => {
  res.send('Create user');
});

// PUT route
app.put('/users/:id', (req, res) => {
  res.send(`Update user ${req.params.id}`);
});

// DELETE route
app.delete('/users/:id', (req, res) => {
  res.send(`Delete user ${req.params.id}`);
});

// PATCH route
app.patch('/users/:id', (req, res) => {
  res.send(`Partially update user ${req.params.id}`);
});
```

**Route with multiple handlers:**
```javascript
app.get('/users', 
  authenticate,
  authorize('admin'),
  (req, res) => {
    res.send('Users list');
  }
);
```

**Route with array of handlers:**
```javascript
const handlers = [authenticate, authorize, getUsers];
app.get('/users', handlers);
```

**Chaining route handlers:**
```javascript
app.route('/users')
  .get((req, res) => res.send('Get users'))
  .post((req, res) => res.send('Create user'))
  .put((req, res) => res.send('Update user'));
```

---

#### 2. What are route parameters and how do you access them?

**Answer:**

**Route parameters** are named URL segments used to capture values.

**Defining route parameters:**
```javascript
// Single parameter
app.get('/users/:id', (req, res) => {
  const userId = req.params.id;
  res.send(`User ID: ${userId}`);
});
// GET /users/123 → userId = '123'

// Multiple parameters
app.get('/users/:userId/posts/:postId', (req, res) => {
  const { userId, postId } = req.params;
  res.send(`User ${userId}, Post ${postId}`);
});
// GET /users/123/posts/456 → userId = '123', postId = '456'

// Optional parameter
app.get('/users/:id?', (req, res) => {
  if (req.params.id) {
    res.send(`User ${req.params.id}`);
  } else {
    res.send('All users');
  }
});
```

**Parameter validation:**
```javascript
// Using regex
app.get('/users/:id(\\d+)', (req, res) => {
  // Only matches numeric IDs
  res.send(`User ${req.params.id}`);
});

// Using param middleware
app.param('id', (req, res, next, id) => {
  // Validate ID
  if (!/^\d+$/.test(id)) {
    return res.status(400).send('Invalid ID');
  }
  req.userId = id;
  next();
});

app.get('/users/:id', (req, res) => {
  res.send(`User ${req.userId}`);
});
```

---

#### 3. How do you handle query parameters?

**Answer:**

**Query parameters** are key-value pairs in the URL after `?`.

**Accessing query parameters:**
```javascript
app.get('/search', (req, res) => {
  const { q, page, limit } = req.query;
  
  res.json({
    query: q,
    page: page || 1,
    limit: limit || 10
  });
});

// GET /search?q=nodejs&page=2&limit=20
// → { query: 'nodejs', page: '2', limit: '20' }
```

**With default values:**
```javascript
app.get('/products', (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const sort = req.query.sort || 'name';
  
  res.json({ page, limit, sort });
});
```

**Array query parameters:**
```javascript
app.get('/filter', (req, res) => {
  // GET /filter?tags=nodejs&tags=express&tags=mongodb
  const tags = req.query.tags; // ['nodejs', 'express', 'mongodb']
  
  res.json({ tags });
});
```

**Nested query parameters:**
```javascript
app.get('/search', (req, res) => {
  // GET /search?filter[name]=John&filter[age]=30
  const filter = req.query.filter;
  // { name: 'John', age: '30' }
  
  res.json({ filter });
});
```

---

#### 4. What is the difference between app.all() and specific HTTP method handlers?

**Answer:**

**app.all()** matches all HTTP methods for a route.

| Feature | app.all() | app.get/post/etc() |
|---------|-----------|-------------------|
| **Methods** | All (GET, POST, PUT, etc.) | Specific method |
| **Use Case** | Common logic | Method-specific logic |

**app.all() example:**
```javascript
// Runs for all HTTP methods
app.all('/api/*', authenticate);

app.all('/admin', (req, res, next) => {
  console.log('Admin area accessed');
  next();
});

// Catch-all route
app.all('*', (req, res) => {
  res.status(404).send('Not Found');
});
```

**Specific method handlers:**
```javascript
app.get('/users', (req, res) => {
  res.send('GET users');
});

app.post('/users', (req, res) => {
  res.send('POST users');
});
```

**When to use app.all():**
- Authentication/authorization middleware
- Logging for specific routes
- CORS headers
- Catch-all routes

---

#### 5. How do you organize routes in a large application?

**Answer:**

**1. Separate route files:**
```javascript
// routes/users.js
const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  res.send('Get all users');
});

router.post('/', (req, res) => {
  res.send('Create user');
});

router.get('/:id', (req, res) => {
  res.send(`Get user ${req.params.id}`);
});

module.exports = router;
```

```javascript
// app.js
const express = require('express');
const app = express();
const usersRouter = require('./routes/users');
const postsRouter = require('./routes/posts');

app.use('/api/users', usersRouter);
app.use('/api/posts', postsRouter);
```

**2. Feature-based structure:**
```
src/
  features/
    users/
      routes.js
      controller.js
      model.js
    posts/
      routes.js
      controller.js
      model.js
  app.js
```

**3. Controller pattern:**
```javascript
// controllers/userController.js
exports.getAllUsers = (req, res) => {
  res.send('Get all users');
};

exports.createUser = (req, res) => {
  res.send('Create user');
};

// routes/users.js
const router = express.Router();
const userController = require('../controllers/userController');

router.get('/', userController.getAllUsers);
router.post('/', userController.createUser);
```

---

#### 6. What is the purpose of express.Router()?

**Answer:**

**express.Router()** creates a modular, mountable route handler.

**Benefits:**
- Modular routes
- Middleware isolation
- Reusable route modules
- Better organization

**Basic usage:**
```javascript
const express = require('express');
const router = express.Router();

// Router-level middleware
router.use((req, res, next) => {
  console.log('Router middleware');
  next();
});

// Define routes
router.get('/', (req, res) => {
  res.send('Router home');
});

router.get('/:id', (req, res) => {
  res.send(`Item ${req.params.id}`);
});

module.exports = router;
```

**Mounting router:**
```javascript
const app = express();
const apiRouter = require('./routes/api');

app.use('/api', apiRouter);
// Routes: /api/, /api/:id
```

**Nested routers:**
```javascript
// routes/api.js
const router = express.Router();
const usersRouter = require('./users');
const postsRouter = require('./posts');

router.use('/users', usersRouter);
router.use('/posts', postsRouter);

module.exports = router;

// app.js
app.use('/api', apiRouter);
// Routes: /api/users, /api/posts
```

---

#### 7. How do you handle 404 (Not Found) routes?

**Answer:**

**404 handler should be the last route:**
```javascript
const express = require('express');
const app = express();

// Regular routes
app.get('/', (req, res) => {
  res.send('Home');
});

app.get('/about', (req, res) => {
  res.send('About');
});

// 404 handler (must be last)
app.use((req, res, next) => {
  res.status(404).send('Page Not Found');
});

// Or with JSON
app.use((req, res) => {
  res.status(404).json({
    error: 'Not Found',
    message: `Cannot ${req.method} ${req.url}`
  });
});
```

**With custom 404 page:**
```javascript
app.use((req, res) => {
  res.status(404).render('404', {
    url: req.url
  });
});
```

**API-specific 404:**
```javascript
// API routes
app.use('/api', apiRouter);

// API 404
app.use('/api/*', (req, res) => {
  res.status(404).json({
    error: 'API endpoint not found'
  });
});

// General 404
app.use((req, res) => {
  res.status(404).send('Page not found');
});
```

---

#### 8. What are HTTP verbs and their idempotent/safe properties?

**Answer:**

| Method | Purpose | Idempotent | Safe |
|--------|---------|-----------|------|
| **GET** | Retrieve resource | Yes | Yes |
| **POST** | Create resource | No | No |
| **PUT** | Update/replace resource | Yes | No |
| **PATCH** | Partial update | No | No |
| **DELETE** | Delete resource | Yes | No |
| **HEAD** | Get headers only | Yes | Yes |
| **OPTIONS** | Get allowed methods | Yes | Yes |

**Idempotent:** Multiple identical requests have same effect as single request

**Safe:** Doesn't modify server state

**Examples:**
```javascript
// GET - Safe and idempotent
app.get('/users/:id', (req, res) => {
  // Just retrieves data, doesn't modify
  const user = db.findUser(req.params.id);
  res.json(user);
});

// POST - Not idempotent
app.post('/users', (req, res) => {
  // Creates new user each time
  const user = db.createUser(req.body);
  res.status(201).json(user);
});

// PUT - Idempotent
app.put('/users/:id', (req, res) => {
  // Same result if called multiple times
  const user = db.updateUser(req.params.id, req.body);
  res.json(user);
});

// DELETE - Idempotent
app.delete('/users/:id', (req, res) => {
  // First call deletes, subsequent calls do nothing
  db.deleteUser(req.params.id);
  res.status(204).send();
});
```

---

## 9. Request & Response Objects

#### 1. What are the common properties of the request object?

**Answer:**

**Common req properties:**
```javascript
app.get('/info', (req, res) => {
  console.log(req.method);        // 'GET'
  console.log(req.url);           // '/info?page=1'
  console.log(req.path);          // '/info'
  console.log(req.query);         // { page: '1' }
  console.log(req.params);        // Route parameters
  console.log(req.body);          // Request body (with middleware)
  console.log(req.headers);       // Request headers
  console.log(req.cookies);       // Cookies (with cookie-parser)
  console.log(req.ip);            // Client IP address
  console.log(req.protocol);      // 'http' or 'https'
  console.log(req.hostname);      // 'example.com'
  console.log(req.originalUrl);   // Full URL with query
  console.log(req.baseUrl);       // Base URL of router
});
```

**Request methods:**
```javascript
req.get('Content-Type');     // Get header
req.is('json');              // Check content type
req.accepts('json');         // Check accepted types
req.acceptsLanguages('en');  // Check accepted languages
```

---

#### 2. How do you access request headers, body, and cookies?

**Answer:**

**Accessing headers:**
```javascript
app.get('/headers', (req, res) => {
  // All headers
  console.log(req.headers);
  
  // Specific header
  const contentType = req.get('Content-Type');
  const userAgent = req.get('User-Agent');
  const auth = req.get('Authorization');
  
  res.json({ contentType, userAgent });
});
```

**Accessing body:**
```javascript
// Requires middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.post('/data', (req, res) => {
  console.log(req.body); // Parsed body
  
  const { name, email } = req.body;
  res.json({ received: { name, email } });
});
```

**Accessing cookies:**
```javascript
const cookieParser = require('cookie-parser');
app.use(cookieParser());

app.get('/cookies', (req, res) => {
  // All cookies
  console.log(req.cookies);
  
  // Specific cookie
  const sessionId = req.cookies.sessionId;
  
  // Signed cookies
  const userId = req.signedCookies.userId;
  
  res.json({ cookies: req.cookies });
});
```

---

#### 3. What are the common response methods?

**Answer:**

**res.send()** - Send any type of response:
```javascript
res.send('Text response');
res.send({ message: 'Object' });
res.send(Buffer.from('Buffer'));
res.send([1, 2, 3]);
```

**res.json()** - Send JSON response:
```javascript
res.json({ name: 'John', age: 30 });
res.json({ error: 'Not found' });
```

**res.render()** - Render template:
```javascript
res.render('index', { title: 'Home', user: userData });
```

**res.redirect()** - Redirect to URL:
```javascript
res.redirect('/login');
res.redirect(301, '/new-url'); // Permanent redirect
res.redirect('back'); // Go back
```

**res.sendFile()** - Send file:
```javascript
res.sendFile('/path/to/file.pdf');
res.sendFile('index.html', { root: './public' });
```

**res.download()** - Download file:
```javascript
res.download('/path/to/file.pdf');
res.download('/path/to/file.pdf', 'custom-name.pdf');
```

**res.status()** - Set status code:
```javascript
res.status(404).send('Not Found');
res.status(201).json({ created: true });
```

**res.sendStatus()** - Send status with message:
```javascript
res.sendStatus(200); // 'OK'
res.sendStatus(404); // 'Not Found'
res.sendStatus(500); // 'Internal Server Error'
```

---

#### 4. How do you set response headers?

**Answer:**

**Setting single header:**
```javascript
res.set('Content-Type', 'application/json');
res.set('X-Custom-Header', 'value');
```

**Setting multiple headers:**
```javascript
res.set({
  'Content-Type': 'text/html',
  'Content-Length': '123',
  'X-Custom-Header': 'value'
});
```

**Common headers:**
```javascript
// Content type
res.type('json'); // application/json
res.type('html'); // text/html
res.type('.pdf'); // application/pdf

// Cache control
res.set('Cache-Control', 'public, max-age=3600');

// CORS headers
res.set('Access-Control-Allow-Origin', '*');
res.set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');

// Security headers
res.set('X-Content-Type-Options', 'nosniff');
res.set('X-Frame-Options', 'DENY');
```

**Appending headers:**
```javascript
res.append('Set-Cookie', 'cookie1=value1');
res.append('Set-Cookie', 'cookie2=value2');
```

---

#### 5. What is the difference between res.send() and res.json()?

**Answer:**

| Feature | res.send() | res.json() |
|---------|-----------|-----------|
| **Content-Type** | Auto-detected | Always application/json |
| **Input** | Any type | Objects/arrays |
| **JSON conversion** | Automatic for objects | Explicit |
| **Performance** | Slightly slower | Slightly faster |

**res.send():**
```javascript
res.send('String'); // text/html
res.send({ name: 'John' }); // application/json
res.send([1, 2, 3]); // application/json
res.send(Buffer.from('data')); // application/octet-stream
```

**res.json():**
```javascript
res.json({ name: 'John' }); // Always application/json
res.json([1, 2, 3]); // Always application/json
res.json(null); // null
res.json(undefined); // undefined (not recommended)
```

**Key differences:**
```javascript
// res.send() auto-detects
res.send({ data: 'value' });
// Content-Type: application/json

// res.json() always JSON
res.json({ data: 'value' });
// Content-Type: application/json; charset=utf-8

// res.json() handles special values
res.json(null); // Sends "null"
res.send(null); // Sends empty response
```

**Best practice:** Use `res.json()` for API responses.

---

#### 6. How do you handle file downloads with Express?

**Answer:**

**Using res.download():**
```javascript
app.get('/download/:filename', (req, res) => {
  const file = `./files/${req.params.filename}`;
  res.download(file);
});

// With custom filename
app.get('/download/:id', (req, res) => {
  const file = `./files/${req.params.id}.pdf`;
  res.download(file, 'custom-name.pdf', (err) => {
    if (err) {
      res.status(404).send('File not found');
    }
  });
});
```

**Using res.sendFile():**
```javascript
const path = require('path');

app.get('/file/:name', (req, res) => {
  const file = path.join(__dirname, 'files', req.params.name);
  res.sendFile(file, (err) => {
    if (err) {
      res.status(404).send('File not found');
    }
  });
});
```

**With proper headers:**
```javascript
app.get('/download/:id', (req, res) => {
  const file = `./files/${req.params.id}.pdf`;
  
  res.set({
    'Content-Type': 'application/pdf',
    'Content-Disposition': 'attachment; filename="document.pdf"'
  });
  
  res.sendFile(path.resolve(file));
});
```

**Streaming large files:**
```javascript
const fs = require('fs');

app.get('/stream/:file', (req, res) => {
  const file = `./files/${req.params.file}`;
  const stream = fs.createReadStream(file);
  
  stream.on('error', (err) => {
    res.status(404).send('File not found');
  });
  
  stream.pipe(res);
});
```

---

#### 7. What is res.locals and when would you use it?

**Answer:**

**res.locals** is an object that contains response local variables scoped to the request. It's available only during that request/response cycle.

**Common use cases:**

**1. Passing data to templates:**
```javascript
app.use((req, res, next) => {
  res.locals.user = req.user;
  res.locals.currentYear = new Date().getFullYear();
  next();
});

app.get('/', (req, res) => {
  // user and currentYear available in template
  res.render('index');
});
```

**2. Sharing data between middleware:**
```javascript
// Middleware 1
app.use((req, res, next) => {
  res.locals.startTime = Date.now();
  next();
});

// Middleware 2
app.use((req, res, next) => {
  res.locals.requestId = generateId();
  next();
});

// Route handler
app.get('/', (req, res) => {
  console.log(res.locals.startTime);
  console.log(res.locals.requestId);
  res.send('OK');
});
```

**3. Authentication data:**
```javascript
app.use(authenticate);

function authenticate(req, res, next) {
  const token = req.headers.authorization;
  const user = verifyToken(token);
  
  res.locals.user = user;
  res.locals.isAuthenticated = !!user;
  
  next();
}

app.get('/profile', (req, res) => {
  if (!res.locals.isAuthenticated) {
    return res.redirect('/login');
  }
  res.render('profile', { user: res.locals.user });
});
```

**Difference from app.locals:**
```javascript
// app.locals - available to all requests
app.locals.siteName = 'My Site';

// res.locals - available only to current request
res.locals.user = currentUser;
```

---

## 10. Template Engines & Views

#### 1. What are template engines and why use them?

**Answer:**

**Template engines** generate HTML dynamically by combining templates with data.

**Why use template engines:**
1. **Dynamic content**: Insert data into HTML
2. **Code reuse**: Partials and layouts
3. **Logic in templates**: Conditionals, loops
4. **Separation of concerns**: Separate HTML from logic
5. **Maintainability**: Easier to update UI

**Without template engine:**
```javascript
app.get('/user', (req, res) => {
  const html = `
    <html>
      <body>
        <h1>User: ${user.name}</h1>
        <p>Email: ${user.email}</p>
      </body>
    </html>
  `;
  res.send(html);
});
```

**With template engine:**
```javascript
app.get('/user', (req, res) => {
  res.render('user', { user });
});
```

---

#### 2. How do you set up a template engine in Express?

**Answer:**

**Setting up EJS:**
```bash
npm install ejs
```

```javascript
const express = require('express');
const app = express();

// Set view engine
app.set('view engine', 'ejs');

// Set views directory (default: ./views)
app.set('views', './views');

// Render template
app.get('/', (req, res) => {
  res.render('index', { title: 'Home', user: 'John' });
});
```

**Setting up Pug:**
```bash
npm install pug
```

```javascript
app.set('view engine', 'pug');
app.set('views', './views');

app.get('/', (req, res) => {
  res.render('index', { title: 'Home' });
});
```

**Setting up Handlebars:**
```bash
npm install express-handlebars
```

```javascript
const exphbs = require('express-handlebars');

app.engine('handlebars', exphbs.engine());
app.set('view engine', 'handlebars');

app.get('/', (req, res) => {
  res.render('index', { title: 'Home' });
});
```

---

#### 3. What are the popular template engines for Express?

**Answer:**

**1. EJS (Embedded JavaScript)**
```ejs
<!-- views/index.ejs -->
<h1><%= title %></h1>
<% if (user) { %>
  <p>Welcome, <%= user.name %></p>
<% } %>
<ul>
  <% items.forEach(item => { %>
    <li><%= item %></li>
  <% }); %>
</ul>
```

**2. Pug (formerly Jade)**
```pug
// views/index.pug
h1= title
if user
  p Welcome, #{user.name}
ul
  each item in items
    li= item
```

**3. Handlebars**
```handlebars
<!-- views/index.handlebars -->
<h1>{{title}}</h1>
{{#if user}}
  <p>Welcome, {{user.name}}</p>
{{/if}}
<ul>
  {{#each items}}
    <li>{{this}}</li>
  {{/each}}
</ul>
```

**Comparison:**

| Feature | EJS | Pug | Handlebars |
|---------|-----|-----|-----------|
| **Syntax** | HTML-like | Indentation-based | HTML-like |
| **Learning Curve** | Easy | Medium | Easy |
| **Logic** | Full JavaScript | Limited | Limited |
| **Performance** | Good | Excellent | Good |

---

#### 4. How do you pass data to templates?

**Answer:**

**Passing data in render:**
```javascript
app.get('/user/:id', (req, res) => {
  const user = {
    id: req.params.id,
    name: 'John Doe',
    email: 'john@example.com',
    posts: [
      { title: 'Post 1', content: 'Content 1' },
      { title: 'Post 2', content: 'Content 2' }
    ]
  };
  
  res.render('user', {
    title: 'User Profile',
    user: user,
    currentYear: new Date().getFullYear()
  });
});
```

**Using res.locals:**
```javascript
app.use((req, res, next) => {
  res.locals.siteName = 'My Site';
  res.locals.currentYear = new Date().getFullYear();
  next();
});

app.get('/', (req, res) => {
  // siteName and currentYear automatically available
  res.render('index', { title: 'Home' });
});
```

**Using app.locals (global):**
```javascript
app.locals.siteName = 'My Site';
app.locals.version = '1.0.0';

// Available in all templates
app.get('/', (req, res) => {
  res.render('index');
});
```

---

#### 5. What are partials/layouts in template engines?

**Answer:**

**Partials** are reusable template fragments.

**EJS partials:**
```ejs
<!-- views/partials/header.ejs -->
<header>
  <h1><%= siteName %></h1>
  <nav>...</nav>
</header>

<!-- views/index.ejs -->
<%- include('partials/header') %>
<main>
  <h2><%= title %></h2>
</main>
<%- include('partials/footer') %>
```

**Pug includes:**
```pug
// views/partials/header.pug
header
  h1= siteName
  nav ...

// views/index.pug
include partials/header
main
  h2= title
include partials/footer
```

**Layouts** define page structure:

**EJS with express-ejs-layouts:**
```bash
npm install express-ejs-layouts
```

```javascript
const expressLayouts = require('express-ejs-layouts');
app.use(expressLayouts);
app.set('layout', 'layouts/main');
```

```ejs
<!-- views/layouts/main.ejs -->
<!DOCTYPE html>
<html>
<head>
  <title><%= title %></title>
</head>
<body>
  <%- include('../partials/header') %>
  <%- body %> <!-- Page content goes here -->
  <%- include('../partials/footer') %>
</body>
</html>
```

**Handlebars layouts:**
```handlebars
<!-- views/layouts/main.handlebars -->
<!DOCTYPE html>
<html>
<head>
  <title>{{title}}</title>
</head>
<body>
  {{> header}}
  {{{body}}}
  {{> footer}}
</body>
</html>
```

---

#### 6. How do you handle client-side rendering vs server-side rendering?

**Answer:**

**Server-Side Rendering (SSR):**
```javascript
// Express renders HTML on server
app.get('/users', async (req, res) => {
  const users = await User.find();
  res.render('users', { users });
});
```

**Pros:**
- Better SEO
- Faster initial page load
- Works without JavaScript

**Cons:**
- Server load
- Full page reloads
- Less interactive

**Client-Side Rendering (CSR):**
```javascript
// Express sends JSON, React renders on client
app.get('/api/users', async (req, res) => {
  const users = await User.find();
  res.json(users);
});

// Serve React app
app.use(express.static('build'));
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'build', 'index.html'));
});
```

**Pros:**
- Rich interactions
- Faster navigation
- Less server load

**Cons:**
- Slower initial load
- SEO challenges
- Requires JavaScript

**Hybrid approach (best of both):**
```javascript
// SSR for initial load
app.get('/', async (req, res) => {
  const data = await fetchData();
  res.render('index', { data, serializedData: JSON.stringify(data) });
});

// API for subsequent requests
app.get('/api/data', async (req, res) => {
  const data = await fetchData();
  res.json(data);
});
```

**Comparison:**

| Feature | SSR | CSR | Hybrid |
|---------|-----|-----|--------|
| **SEO** | Excellent | Poor | Excellent |
| **Initial Load** | Fast | Slow | Fast |
| **Interactivity** | Limited | Rich | Rich |
| **Server Load** | High | Low | Medium |
| **Complexity** | Low | Medium | High |

---
## 11. Error Handling in Express

#### 1. How do you create error handling middleware?

**Answer:**

**Error handling middleware** has 4 parameters: `(err, req, res, next)`. It must be defined after all other middleware and routes.

**Basic error handler:**
```javascript
const express = require('express');
const app = express();

// Regular routes
app.get('/', (req, res) => {
  res.send('Home');
});

// Error handler (must be last)
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});
```

**Multiple error handlers:**
```javascript
// Specific error handler
app.use((err, req, res, next) => {
  if (err instanceof ValidationError) {
    return res.status(400).json({ error: err.message });
  }
  next(err); // Pass to next error handler
});

// General error handler
app.use((err, req, res, next) => {
  res.status(500).json({ error: 'Internal Server Error' });
});
```

---

#### 2. What is the signature of error handling middleware?

**Answer:**

**Error handling middleware signature:**
```javascript
function errorHandler(err, req, res, next) {
  // err: Error object
  // req: Request object
  // res: Response object
  // next: Next function
}
```

**Key characteristics:**
1. **4 parameters** (not 3 like regular middleware)
2. **First parameter is error**
3. **Must be defined last** (after all routes)
4. **Can have multiple** error handlers

**Example with all parameters:**
```javascript
app.use((err, req, res, next) => {
  // Log error details
  console.error('Error:', {
    message: err.message,
    stack: err.stack,
    url: req.url,
    method: req.method,
    ip: req.ip,
    timestamp: new Date().toISOString()
  });
  
  // Send response
  res.status(err.status || 500).json({
    error: err.message || 'Internal Server Error',
    path: req.path
  });
});
```

---

#### 3. How do you handle different types of errors in Express?

**Answer:**

**1. Synchronous errors:**
```javascript
app.get('/sync-error', (req, res) => {
  // Synchronous error
  throw new Error('Synchronous error');
});

// Will be caught by error handler
```

**2. Asynchronous errors:**
```javascript
app.get('/async-error', async (req, res, next) => {
  try {
    const data = await someAsyncOperation();
    res.json(data);
  } catch (err) {
    next(err); // Pass to error handler
  }
});

// Or with promise
app.get('/promise-error', (req, res, next) => {
  someAsyncOperation()
    .then(data => res.json(data))
    .catch(next); // Pass error to next
});
```

**3. Route-specific error handling:**
```javascript
app.get('/user/:id', (req, res, next) => {
  const user = getUser(req.params.id);
  
  if (!user) {
    const err = new Error('User not found');
    err.status = 404;
    return next(err);
  }
  
  res.json(user);
});
```

**4. Custom error classes:**
```javascript
class AppError extends Error {
  constructor(message, statusCode) {
    super(message);
    this.statusCode = statusCode;
    this.isOperational = true;
  }
}

app.get('/admin', (req, res, next) => {
  if (!req.user.isAdmin) {
    return next(new AppError('Admin access required', 403));
  }
  res.send('Admin panel');
});
```

---

#### 4. What is the difference between synchronous and asynchronous error handling?

**Answer:**

| Feature | Synchronous | Asynchronous |
|---------|------------|--------------|
| **Error throwing** | `throw error` | `next(error)` |
| **Catch mechanism** | Automatic | Manual |
| **Example** | `throw new Error()` | `next(new Error())` |
| **In async/await** | try/catch | try/catch with next() |

**Synchronous error handling:**
```javascript
app.get('/sync', (req, res) => {
  // Thrown errors automatically caught
  if (!req.query.id) {
    throw new Error('ID required');
  }
  res.send('OK');
});

// Error handler catches it automatically
```

**Asynchronous error handling:**
```javascript
app.get('/async', async (req, res, next) => {
  try {
    const data = await fetchData();
    res.json(data);
  } catch (err) {
    // Must pass to next()
    next(err);
  }
});

// Or with promise
app.get('/promise', (req, res, next) => {
  fetchData()
    .then(data => res.json(data))
    .catch(next); // Pass error to next
});
```

**Common mistake:**
```javascript
// WRONG - error won't be caught
app.get('/wrong', async (req, res) => {
  const data = await fetchData(); // Error here
  res.json(data);
});

// CORRECT
app.get('/right', async (req, res, next) => {
  try {
    const data = await fetchData();
    res.json(data);
  } catch (err) {
    next(err);
  }
});
```

---

#### 5. How do you create custom error responses?

**Answer:**

**1. Structured error responses:**
```javascript
app.use((err, req, res, next) => {
  const status = err.status || 500;
  const response = {
    error: {
      message: err.message || 'Internal Server Error',
      code: err.code || 'INTERNAL_ERROR',
      timestamp: new Date().toISOString(),
      path: req.path
    }
  };
  
  // Add stack trace in development
  if (process.env.NODE_ENV === 'development') {
    response.error.stack = err.stack;
  }
  
  res.status(status).json(response);
});
```

**2. Error class with toJSON:**
```javascript
class APIError extends Error {
  constructor(message, status = 500, code = 'INTERNAL_ERROR') {
    super(message);
    this.status = status;
    this.code = code;
  }
  
  toJSON() {
    return {
      error: {
        message: this.message,
        code: this.code,
        status: this.status
      }
    };
  }
}

// Usage
app.use((err, req, res, next) => {
  if (err instanceof APIError) {
    return res.status(err.status).json(err.toJSON());
  }
  
  // Default error
  res.status(500).json({
    error: {
      message: 'Internal Server Error',
      code: 'INTERNAL_ERROR'
    }
  });
});
```

**3. Different formats for different content types:**
```javascript
app.use((err, req, res, next) => {
  // Check what client accepts
  const accepts = req.accepts(['json', 'html']);
  
  if (accepts === 'html') {
    // HTML error page
    res.status(err.status || 500).render('error', {
      message: err.message,
      error: process.env.NODE_ENV === 'development' ? err : {}
    });
  } else {
    // JSON error response
    res.status(err.status || 500).json({
      error: err.message || 'Internal Server Error'
    });
  }
});
```

**4. Production vs development:**
```javascript
app.use((err, req, res, next) => {
  const isProduction = process.env.NODE_ENV === 'production';
  
  const errorResponse = {
    message: isProduction ? 'Internal Server Error' : err.message,
    status: err.status || 500
  };
  
  if (!isProduction) {
    errorResponse.stack = err.stack;
    errorResponse.details = err.details;
  }
  
  res.status(errorResponse.status).json(errorResponse);
});
```

---

## 12. Static Files & Assets

#### 1. How do you serve static files in Express?

**Answer:**

**Using express.static() middleware:**
```javascript
const express = require('express');
const app = express();

// Serve files from 'public' directory
app.use(express.static('public'));

// Files will be available at:
// http://localhost:3000/image.jpg → public/image.jpg
// http://localhost:3000/css/style.css → public/css/style.css
```

**Multiple static directories:**
```javascript
app.use(express.static('public'));
app.use(express.static('uploads'));
app.use(express.static('node_modules/bootstrap/dist'));
```

**With virtual path prefix:**
```javascript
// Files served with /static prefix
app.use('/static', express.static('public'));

// Files available at:
// http://localhost:3000/static/image.jpg → public/image.jpg
// http://localhost:3000/static/css/style.css → public/css/style.css
```

---

#### 2. What is express.static() middleware?

**Answer:**

**express.static()** is built-in middleware that serves static files.

**Basic usage:**
```javascript
app.use(express.static('public'));
```

**With options:**
```javascript
app.use(express.static('public', {
  // Cache control
  maxAge: '1d', // 1 day
  setHeaders: (res, path) => {
    if (path.endsWith('.html')) {
      // No cache for HTML files
      res.setHeader('Cache-Control', 'no-cache');
    }
  }
}));
```

**What it does:**
1. Checks if file exists in directory
2. Sends file with appropriate headers
3. Handles range requests (for video/audio)
4. Sets cache headers
5. Handles directory listings (if enabled)

**Directory structure:**
```
public/
  ├── index.html
  ├── css/
  │   └── style.css
  ├── js/
  │   └── app.js
  └── images/
      └── logo.png
```

**Access:**
- `/` → public/index.html
- `/css/style.css` → public/css/style.css
- `/images/logo.png` → public/images/logo.png

---

#### 3. How do you handle caching for static assets?

**Answer:**

**1. Cache-Control headers:**
```javascript
app.use(express.static('public', {
  maxAge: '1d' // 1 day
}));
```

**2. Different cache for different file types:**
```javascript
app.use(express.static('public', {
  setHeaders: (res, path) => {
    if (path.endsWith('.html')) {
      // HTML: no cache
      res.setHeader('Cache-Control', 'no-cache');
    } else if (path.endsWith('.css') || path.endsWith('.js')) {
      // CSS/JS: cache for 1 year
      res.setHeader('Cache-Control', 'public, max-age=31536000');
    } else {
      // Images: cache for 30 days
      res.setHeader('Cache-Control', 'public, max-age=2592000');
    }
  }
}));
```

**3. Cache busting with query strings:**
```html
<!-- In template -->
<link href="/css/style.css?v=1.0.0" rel="stylesheet">
<script src="/js/app.js?v=1.0.0"></script>
```

**4. Cache busting with file hashes:**
```javascript
const fs = require('fs');
const crypto = require('crypto');

function getFileHash(filepath) {
  const content = fs.readFileSync(filepath);
  return crypto.createHash('md5').update(content).digest('hex').slice(0, 8);
}

// In template rendering
const cssHash = getFileHash('public/css/style.css');
res.render('index', { cssHash });
```

```html
<!-- In template -->
<link href="/css/style.css?v=<%= cssHash %>" rel="stylesheet">
```

**5. ETag support:**
```javascript
app.use(express.static('public', {
  etag: true, // Enable ETag (default)
  lastModified: true // Enable Last-Modified (default)
}));
```

---

#### 4. What are the security considerations when serving static files?

**Answer:**

**1. Directory traversal prevention:**
```javascript
// Express.static() prevents this by default
// But ensure you're using path.resolve
app.use(express.static(path.resolve('public')));
```

**2. File type restrictions:**
```javascript
app.use(express.static('public', {
  setHeaders: (res, path) => {
    // Block sensitive file types
    const blocked = ['.env', '.git', '.htaccess'];
    if (blocked.some(ext => path.endsWith(ext))) {
      res.status(404).end();
    }
  }
}));
```

**3. MIME type sniffing prevention:**
```javascript
app.use((req, res, next) => {
  res.setHeader('X-Content-Type-Options', 'nosniff');
  next();
});
```

**4. Directory listing prevention:**
```javascript
app.use(express.static('public', {
  index: false // Don't serve index.html automatically
}));

// Or disable directory listing
const serveIndex = require('serve-index');
app.use('/public', express.static('public'));
app.use('/public', serveIndex('public', { icons: true, view: 'details' }));
```

**5. Rate limiting for static files:**
```javascript
const rateLimit = require('express-rate-limit');

const staticLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per windowMs
});

app.use('/downloads', staticLimiter, express.static('downloads'));
```

**6. CORS for CDN:**
```javascript
app.use('/assets', (req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', 'https://cdn.example.com');
  next();
}, express.static('assets'));
```

---

#### 5. How do you serve files from multiple directories?

**Answer:**

**Multiple static directories:**
```javascript
// Serve from multiple directories
app.use(express.static('public'));
app.use(express.static('uploads'));
app.use(express.static('node_modules/bootstrap/dist'));

// Order matters - first match wins
```

**With different prefixes:**
```javascript
// Different URLs for different directories
app.use('/public', express.static('public'));
app.use('/uploads', express.static('uploads'));
app.use('/vendor', express.static('node_modules'));

// Access:
// /public/image.jpg → public/image.jpg
// /uploads/file.pdf → uploads/file.pdf
// /vendor/bootstrap/css/bootstrap.css → node_modules/bootstrap/css/bootstrap.css
```

**Conditional serving:**
```javascript
app.use('/assets', (req, res, next) => {
  // Check user permissions
  if (!req.user || !req.user.canAccessAssets) {
    return res.status(403).send('Forbidden');
  }
  next();
}, express.static('assets'));
```

**Virtual file system:**
```javascript
const serveIndex = require('serve-index');

// Serve static files with directory listing
app.use('/files', 
  express.static('uploads'),
  serveIndex('uploads', { icons: true })
);
```

**Dynamic directory selection:**
```javascript
app.use('/user-files/:userId', (req, res, next) => {
  const userId = req.params.userId;
  const userDir = `uploads/${userId}`;
  
  // Serve from user-specific directory
  express.static(userDir)(req, res, next);
});
```

---

## 13. Custom Middleware

#### 1. How do you create custom middleware?

**Answer:**

**Basic middleware function:**
```javascript
function logger(req, res, next) {
  console.log(`${req.method} ${req.url} - ${new Date().toISOString()}`);
  next(); // Pass control to next middleware
}

// Usage
app.use(logger);
```

**Middleware with options:**
```javascript
function createLogger(options = {}) {
  return function logger(req, res, next) {
    const timestamp = options.timestamp ? new Date().toISOString() : '';
    const method = options.showMethod ? req.method : '';
    const url = options.showUrl ? req.url : '';
    
    console.log(`${timestamp} ${method} ${url}`);
    next();
  };
}

// Usage with options
app.use(createLogger({ timestamp: true, showMethod: true, showUrl: true }));
```

**Async middleware:**
```javascript
async function authMiddleware(req, res, next) {
  try {
    const token = req.headers.authorization;
    const user = await verifyToken(token);
    req.user = user;
    next();
  } catch (err) {
    next(err); // Pass error to error handler
  }
}

app.use(authMiddleware);
```

---

#### 2. What are the use cases for custom middleware?

**Answer:**

**1. Logging:**
```javascript
function requestLogger(req, res, next) {
  const start = Date.now();
  
  res.on('finish', () => {
    const duration = Date.now() - start;
    console.log(`${req.method} ${req.url} ${res.statusCode} ${duration}ms`);
  });
  
  next();
}
```

**2. Authentication:**
```javascript
function authenticate(req, res, next) {
  const token = req.cookies.token || req.headers.authorization;
  
  if (!token) {
    return res.status(401).json({ error: 'Authentication required' });
  }
  
  try {
    const user = verifyToken(token);
    req.user = user;
    next();
  } catch (err) {
    res.status(401).json({ error: 'Invalid token' });
  }
}
```

**3. Rate limiting:**
```javascript
const requestCounts = new Map();

function rateLimiter(windowMs = 60000, maxRequests = 100) {
  return (req, res, next) => {
    const ip = req.ip;
    const now = Date.now();
    const windowStart = now - windowMs;
    
    // Clean old requests
    const requests = (requestCounts.get(ip) || []).filter(time => time > windowStart);
    
    if (requests.length >= maxRequests) {
      return res.status(429).json({ error: 'Too many requests' });
    }
    
    requests.push(now);
    requestCounts.set(ip, requests);
    next();
  };
}
```

**4. Request validation:**
```javascript
function validateRequest(schema) {
  return (req, res, next) => {
    const { error } = schema.validate(req.body);
    
    if (error) {
      return res.status(400).json({
        error: 'Validation failed',
        details: error.details
      });
    }
    
    next();
  };
}
```

**5. CORS headers:**
```javascript
function corsMiddleware(req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  
  if (req.method === 'OPTIONS') {
    return res.sendStatus(200);
  }
  
  next();
}
```

---

#### 3. How do you pass data between middleware?

**Answer:**

**1. Using req object:**
```javascript
// Middleware 1
app.use((req, res, next) => {
  req.requestId = generateId();
  req.startTime = Date.now();
  next();
});

// Middleware 2
app.use((req, res, next) => {
  console.log(`Request ${req.requestId} started at ${req.startTime}`);
  next();
});

// Route handler
app.get('/', (req, res) => {
  res.json({ requestId: req.requestId });
});
```

**2. Using res.locals:**
```javascript
// Middleware 1
app.use((req, res, next) => {
  res.locals.user = req.user;
  res.locals.isAuthenticated = !!req.user;
  next();
});

// Route handler
app.get('/profile', (req, res) => {
  // Access in route
  console.log(res.locals.user);
  res.render('profile');
});
```

**3. Using app.locals (global):**
```javascript
// Set once
app.locals.siteName = 'My Site';
app.locals.version = '1.0.0';

// Access anywhere
app.get('/', (req, res) => {
  res.render('index', { 
    title: app.locals.siteName,
    version: app.locals.version 
  });
});
```

**4. Using closures:**
```javascript
function createContext() {
  const context = {};
  
  return (req, res, next) => {
    req.context = context;
    next();
  };
}

app.use(createContext());
```

---

#### 4. What is the difference between application-level and router-level middleware?

**Answer:**

| Feature | Application-level | Router-level |
|---------|------------------|--------------|
| **Scope** | Entire app | Specific router |
| **Definition** | `app.use()` | `router.use()` |
| **Mounting** | App-wide | Router-specific |
| **Use Case** | Global middleware | Feature-specific middleware |

**Application-level middleware:**
```javascript
const app = express();

// Applies to all routes
app.use(express.json());
app.use(logger);
app.use(cors());

app.get('/api/users', userHandler);
app.get('/api/posts', postHandler);
```

**Router-level middleware:**
```javascript
const userRouter = express.Router();
const adminRouter = express.Router();

// Only applies to user routes
userRouter.use(authMiddleware);
userRouter.get('/', getUsers);
userRouter.post('/', createUser);

// Only applies to admin routes
adminRouter.use(authMiddleware);
adminRouter.use(adminOnlyMiddleware);
adminRouter.get('/stats', getStats);

// Mount routers
app.use('/users', userRouter);
app.use('/admin', adminRouter);
```

**Mixed usage:**
```javascript
// App-level (runs first)
app.use(logger);

// Router-level (runs for specific routes)
const apiRouter = express.Router();
apiRouter.use(authMiddleware);
apiRouter.get('/data', getData);

app.use('/api', apiRouter);
```

---

#### 5. How do you conditionally apply middleware?

**Answer:**

**1. Using if statements:**
```javascript
app.use((req, res, next) => {
  if (req.path.startsWith('/api')) {
    // Only for API routes
    console.log('API request');
  }
  next();
});
```

**2. Using path patterns:**
```javascript
// Only for /api routes
app.use('/api', apiMiddleware);

// Only for /admin routes
app.use('/admin', adminMiddleware);
```

**3. Using environment:**
```javascript
if (process.env.NODE_ENV === 'development') {
  app.use(morgan('dev'));
  app.use(errorHandlerWithStack);
} else {
  app.use(morgan('combined'));
  app.use(errorHandlerWithoutStack);
}
```

**4. Using request properties:**
```javascript
app.use((req, res, next) => {
  if (req.method === 'POST' && req.path === '/login') {
    // Special handling for login
    rateLimiterStrict(req, res, next);
  } else {
    // Normal rate limiting
    rateLimiterNormal(req, res, next);
  }
});
```

**5. Using configuration:**
```javascript
const config = {
  enableCors: true,
  enableCompression: true,
  enableLogging: false
};

if (config.enableCors) {
  app.use(cors());
}

if (config.enableCompression) {
  app.use(compression());
}

if (config.enableLogging) {
  app.use(morgan('dev'));
}
```

**6. Using middleware factory:**
```javascript
function conditionalMiddleware(condition, middleware) {
  return (req, res, next) => {
    if (condition(req)) {
      middleware(req, res, next);
    } else {
      next();
    }
  };
}

// Usage
app.use(conditionalMiddleware(
  req => req.ip === '127.0.0.1',
  (req, res, next) => {
    console.log('Local request');
    next();
  }
));
```

---

---

## 14. Third-party Middleware

#### 1. What are the essential third-party middleware packages?

**Answer:**

**Essential third-party middleware:**

1. **body-parser** - Parse request bodies
2. **cors** - Enable Cross-Origin Resource Sharing
3. **morgan** - HTTP request logging
4. **compression** - Response compression
5. **cookie-parser** - Parse cookies
6. **helmet** - Security headers
7. **express-session** - Session management
8. **passport** - Authentication
9. **multer** - File uploads
10. **express-validator** - Request validation

**Installation:**
```bash
npm install body-parser cors morgan compression cookie-parser helmet express-session passport multer express-validator
```

**Basic setup:**
```javascript
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const morgan = require('morgan');
const compression = require('compression');
const cookieParser = require('cookie-parser');
const helmet = require('helmet');

const app = express();

// Apply middleware
app.use(helmet());
app.use(cors());
app.use(compression());
app.use(morgan('dev'));
app.use(cookieParser());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.listen(3000);
```

---

#### 2. How do you use body-parser middleware?

**Answer:**

**body-parser** parses incoming request bodies.

**Basic usage:**
```javascript
const express = require('express');
const bodyParser = require('body-parser');
const app = express();

// Parse JSON bodies
app.use(bodyParser.json());

// Parse URL-encoded bodies
app.use(bodyParser.urlencoded({ extended: true }));

// Parse text bodies
app.use(bodyParser.text());

// Parse raw bodies
app.use(bodyParser.raw());

// Route using parsed body
app.post('/api/users', (req, res) => {
  console.log(req.body); // Parsed body
  res.json({ received: req.body });
});
```

**Note:** In Express 4.16+, body-parser functionality is built-in:
```javascript
// Built-in (no need to install body-parser)
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
```

**Options:**
```javascript
app.use(bodyParser.json({
  limit: '1mb',           // Max body size
  strict: true,           // Only accept arrays/objects
  type: 'application/json' // Content-Type to parse
}));

app.use(bodyParser.urlencoded({
  extended: true,         // Use qs library (supports nested)
  limit: '1mb',
  parameterLimit: 1000    // Max parameters
}));
```

---

#### 3. What is cors middleware and how do you configure it?

**Answer:**

**CORS** (Cross-Origin Resource Sharing) allows resources to be requested from another domain.

**Basic usage:**
```javascript
const cors = require('cors');
const app = express();

// Enable CORS for all routes
app.use(cors());

// Or enable for specific route
app.get('/api/data', cors(), (req, res) => {
  res.json({ data: 'value' });
});
```

**Configuration options:**
```javascript
const corsOptions = {
  origin: 'http://example.com', // Allow specific origin
  methods: ['GET', 'POST'],     // Allowed methods
  allowedHeaders: ['Content-Type', 'Authorization'],
  credentials: true,            // Allow cookies
  maxAge: 86400                 // Cache preflight (seconds)
};

app.use(cors(corsOptions));
```

**Dynamic origin:**
```javascript
const whitelist = ['http://example.com', 'http://localhost:3000'];

const corsOptions = {
  origin: function (origin, callback) {
    if (whitelist.indexOf(origin) !== -1 || !origin) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  }
};

app.use(cors(corsOptions));
```

**Preflight requests:**
```javascript
// Handle OPTIONS preflight requests
app.options('/api/data', cors()); // Enable CORS preflight

app.get('/api/data', cors(), (req, res) => {
  res.json({ data: 'value' });
});
```

---

#### 4. How do you use morgan for logging?

**Answer:**

**morgan** is HTTP request logger middleware.

**Basic usage:**
```javascript
const morgan = require('morgan');
const app = express();

// Use default format
app.use(morgan('combined'));

// Or use predefined format
app.use(morgan('dev'));     // Concise output colored by response status
app.use(morgan('common'));  // Apache common log format
app.use(morgan('tiny'));    // Minimal output
app.use(morgan('short'));   // Shorter than default
```

**Custom format:**
```javascript
// Using tokens
app.use(morgan(':method :url :status :res[content-length] - :response-time ms'));

// Custom token
morgan.token('type', function (req, res) {
  return req.headers['content-type'];
});

app.use(morgan(':method :url :status :type'));
```

**Available tokens:**
- `:method` - HTTP method
- `:url` - URL
- `:status` - Status code
- `:response-time` - Response time in ms
- `:remote-addr` - Remote address
- `:date` - Date
- `:http-version` - HTTP version
- `:referrer` - Referrer
- `:user-agent` - User agent

**Writing to file:**
```javascript
const fs = require('fs');
const path = require('path');

// Create write stream
const accessLogStream = fs.createWriteStream(
  path.join(__dirname, 'access.log'),
  { flags: 'a' }
);

// Write logs to file
app.use(morgan('combined', { stream: accessLogStream }));
```

**Conditional logging:**
```javascript
app.use(morgan('dev', {
  skip: function (req, res) {
    return res.statusCode < 400; // Skip successful requests
  }
}));
```

---

#### 5. What is compression middleware and when should you use it?

**Answer:**

**compression** compresses response bodies.

**Basic usage:**
```javascript
const compression = require('compression');
const app = express();

// Enable compression
app.use(compression());

// All responses will be compressed
app.get('/api/data', (req, res) => {
  res.json({ data: 'large dataset' }); // Will be compressed
});
```

**When to use:**
1. **Large responses** - JSON APIs, file downloads
2. **Text content** - HTML, CSS, JavaScript
3. **High traffic** - Reduce bandwidth usage
4. **Mobile users** - Faster loading on slow connections

**When NOT to use:**
1. **Already compressed** - Images, videos, PDFs
2. **Small responses** - Under 1KB
3. **Real-time data** - WebSockets, Server-Sent Events

**Configuration:**
```javascript
app.use(compression({
  level: 6,                // Compression level (0-9)
  threshold: 1024,         // Minimum size to compress (bytes)
  filter: (req, res) => {
    // Custom filter function
    if (req.headers['x-no-compression']) {
      return false;
    }
    return compression.filter(req, res);
  }
}));
```

**Compression levels:**
- `0` - No compression (fastest)
- `1` - Minimal compression
- `6` - Default (good balance)
- `9` - Maximum compression (slowest)

**Checking compression:**
```javascript
app.get('/check', (req, res) => {
  const acceptsEncoding = req.headers['accept-encoding'];
  console.log('Accepts:', acceptsEncoding); // gzip, deflate, br
  
  res.json({ 
    compressed: res.getHeader('content-encoding') // gzip
  });
});
```

---

#### 6. How do you handle cookies with cookie-parser?

**Answer:**

**cookie-parser** parses Cookie header and populates `req.cookies`.

**Basic usage:**
```javascript
const cookieParser = require('cookie-parser');
const app = express();

// Parse cookies
app.use(cookieParser());

// Read cookies
app.get('/', (req, res) => {
  console.log(req.cookies); // { sessionId: 'abc123', theme: 'dark' }
  res.send('Cookies parsed');
});

// Set cookies
app.get('/set-cookie', (req, res) => {
  res.cookie('username', 'john', { 
    maxAge: 900000, 
    httpOnly: true 
  });
  res.send('Cookie set');
});
```

**Signed cookies:**
```javascript
// With secret
app.use(cookieParser('mySecret'));

// Set signed cookie
app.get('/set-signed', (req, res) => {
  res.cookie('session', 'data', { 
    signed: true,
    httpOnly: true 
  });
  res.send('Signed cookie set');
});

// Read signed cookie
app.get('/get-signed', (req, res) => {
  console.log(req.signedCookies); // { session: 'data' }
  console.log(req.cookies);       // Unsigned cookies
  res.json({ signed: req.signedCookies });
});
```

**Cookie options:**
```javascript
res.cookie('name', 'value', {
  maxAge: 900000,           // Expiry in milliseconds
  expires: new Date('2025-12-31'), // Expiry date
  httpOnly: true,           // Not accessible via JavaScript
  secure: true,             // Only over HTTPS
  domain: '.example.com',   // Domain
  path: '/admin',           // Path
  sameSite: 'strict'        // CSRF protection
});
```

**Multiple secrets:**
```javascript
app.use(cookieParser(['secret1', 'secret2', 'secret3']));
```

**Parsing specific cookies:**
```javascript
// Parse only specific cookies
app.use(cookieParser('secret', {
  decode: function(val) {
    // Custom decoding
    return decodeURIComponent(val);
  }
}));
```

**Clearing cookies:**
```javascript
app.get('/clear', (req, res) => {
  res.clearCookie('sessionId');
  res.clearCookie('username', { path: '/admin' });
  res.send('Cookies cleared');
});
```

---
---

## 15. Middleware Order & Execution

#### 1. Why is middleware order important?

**Answer:**

**Middleware order** determines the execution sequence. Each middleware processes the request in order, and can modify it before passing to the next.

**Example showing order importance:**
```javascript
const app = express();

// WRONG ORDER - body parser after route
app.post('/users', (req, res) => {
  console.log(req.body); // undefined - body not parsed yet
  res.send('User created');
});

app.use(express.json()); // Too late!

// CORRECT ORDER - body parser before route
app.use(express.json()); // First parse body

app.post('/users', (req, res) => {
  console.log(req.body); // { name: 'John' } - body parsed
  res.json({ user: req.body });
});
```

**Common ordering patterns:**

1. **Security first:**
```javascript
app.use(helmet());        // Security headers
app.use(cors());          // CORS
```

2. **Parsing next:**
```javascript
app.use(express.json());  // JSON parsing
app.use(express.urlencoded({ extended: true })); // Form data
app.use(cookieParser());  // Cookies
```

3. **Session/authentication:**
```javascript
app.use(session());       // Sessions
app.use(passport.initialize()); // Authentication
app.use(passport.session());
```

4. **Logging:**
```javascript
app.use(morgan('dev'));   // Request logging
```

5. **Static files:**
```javascript
app.use(express.static('public')); // Static assets
```

6. **Routes:**
```javascript
app.use('/api', apiRouter); // API routes
app.use('/', webRouter);    // Web routes
```

7. **Error handling last:**
```javascript
app.use(notFoundHandler);  // 404 handler
app.use(errorHandler);     // Error handler
```

---

#### 2. What happens if you don't call next() in middleware?

**Answer:**

If you don't call `next()`, the request-response cycle stops at that middleware.

**Examples:**

**Stopping the chain (intentional):**
```javascript
// Authentication middleware
app.use((req, res, next) => {
  if (!req.user) {
    res.status(401).send('Unauthorized');
    // No next() - stops here
    return;
  }
  next(); // Only called if authenticated
});

// This never runs if not authenticated
app.get('/profile', (req, res) => {
  res.send('Profile page');
});
```

**Forgetting next() (bug):**
```javascript
// BUG: Forgot to call next()
app.use((req, res, next) => {
  console.log('Middleware 1');
  // Forgot: next();
});

// This never runs
app.get('/', (req, res) => {
  res.send('Home');
  // Request hangs - browser keeps loading
});
```

**Sending response stops chain:**
```javascript
app.use((req, res, next) => {
  if (req.path === '/health') {
    res.send('OK'); // Sends response
    // Chain stops here automatically
    return;
  }
  next(); // Continue for other paths
});
```

**Async middleware without next():**
```javascript
// Async middleware must call next() or send response
app.use(async (req, res, next) => {
  try {
    const data = await fetchData();
    req.data = data;
    next(); // Must call next()
  } catch (err) {
    next(err); // Pass error
  }
});
```

**Best practice:** Always call `next()` unless you're intentionally stopping the chain.

---

#### 3. How do you skip middleware based on conditions?

**Answer:**

**1. Using if statements:**
```javascript
app.use((req, res, next) => {
  if (req.path.startsWith('/api')) {
    // Skip for API routes
    next();
    return;
  }
  
  // Apply middleware for non-API routes
  console.log('Web request:', req.path);
  next();
});
```

**2. Using path patterns:**
```javascript
// Only apply to specific paths
app.use('/admin', adminMiddleware);
app.use('/api', apiMiddleware);

// Skip for static files
app.use(express.static('public'));

// Apply to everything else
app.use((req, res, next) => {
  console.log('Dynamic route:', req.path);
  next();
});
```

**3. Using request properties:**
```javascript
app.use((req, res, next) => {
  // Skip for OPTIONS requests (CORS preflight)
  if (req.method === 'OPTIONS') {
    next();
    return;
  }
  
  // Skip for static file requests
  if (req.path.match(/\.(jpg|png|css|js)$/)) {
    next();
    return;
  }
  
  // Apply logging for other requests
  console.log(`${req.method} ${req.path}`);
  next();
});
```

**4. Using environment:**
```javascript
// Skip in production
if (process.env.NODE_ENV !== 'production') {
  app.use(morgan('dev')); // Development logging only
}
```

**5. Using middleware factory:**
```javascript
function skipMiddleware(skipCondition, middleware) {
  return (req, res, next) => {
    if (skipCondition(req)) {
      next(); // Skip
    } else {
      middleware(req, res, next); // Apply
    }
  };
}

// Usage
app.use(skipMiddleware(
  req => req.ip === '127.0.0.1', // Skip for localhost
  (req, res, next) => {
    console.log('External request from:', req.ip);
    next();
  }
));
```

**6. Using configuration:**
```javascript
const config = {
  enableLogging: true,
  enableCompression: false,
  enableCors: true
};

if (config.enableLogging) {
  app.use(morgan('dev'));
}

if (config.enableCompression) {
  app.use(compression());
}

if (config.enableCors) {
  app.use(cors());
}
```

---

#### 4. What is the execution flow of middleware in Express?

**Answer:**

**Middleware execution flow:**

1. **Request arrives**
2. **Middleware processes in order**
3. **Route handler executes**
4. **Response sent**
5. **Post-response middleware (if any)**

**Visual flow:**
```
Request → Middleware 1 → Middleware 2 → Route Handler → Response
         (calls next())  (calls next())  (sends response)
```

**Detailed example:**
```javascript
const app = express();

// 1. First middleware
app.use((req, res, next) => {
  console.log('1. Request started');
  req.startTime = Date.now();
  next(); // Pass to next middleware
});

// 2. Second middleware
app.use((req, res, next) => {
  console.log('2. Processing request');
  next();
});

// 3. Route handler
app.get('/api/data', (req, res) => {
  console.log('3. Route handler executing');
  const duration = Date.now() - req.startTime;
  res.json({ data: 'value', duration });
});

// 4. Post-response (won't run - response already sent)
app.use((req, res, next) => {
  console.log('4. This never runs for /api/data');
  next();
});

// Output for GET /api/data:
// 1. Request started
// 2. Processing request
// 3. Route handler executing
```

**Error flow:**
```javascript
app.use((req, res, next) => {
  console.log('1. Before error');
  next(new Error('Something broke'));
});

// Skipped - error passed to error handler
app.use((req, res, next) => {
  console.log('2. This never runs');
  next();
});

// Error handler (4 parameters)
app.use((err, req, res, next) => {
  console.log('3. Error handler');
  res.status(500).send('Error: ' + err.message);
});

// Output:
// 1. Before error
// 3. Error handler
```

**Nested flow with routers:**
```javascript
const router = express.Router();

// Router middleware
router.use((req, res, next) => {
  console.log('Router middleware');
  next();
});

// Router route
router.get('/users', (req, res) => {
  console.log('Router route');
  res.send('Users');
});

// Mount router
app.use('/api', router);

// Flow for GET /api/users:
// 1. App middleware (if any)
// 2. Router middleware
// 3. Router route
```

---

#### 5. How do you handle errors in middleware chains?

**Answer:**

**1. Synchronous errors:**
```javascript
app.use((req, res, next) => {
  // Synchronous error
  throw new Error('Sync error');
  // Or: next(new Error('Sync error'));
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});
```

**2. Asynchronous errors:**
```javascript
app.use(async (req, res, next) => {
  try {
    const data = await fetchData();
    req.data = data;
    next();
  } catch (err) {
    next(err); // Pass async error
  }
});
```

**3. Error propagation:**
```javascript
// Middleware 1 - creates error
app.use((req, res, next) => {
  const err = new Error('Not found');
  err.status = 404;
  next(err); // Pass to error handler
});

// Middleware 2 - skipped
app.use((req, res, next) => {
  console.log('This never runs');
  next();
});

// Error handler
app.use((err, req, res, next) => {
  res.status(err.status || 500);
  res.json({
    error: err.message,
    stack: process.env.NODE_ENV === 'development' ? err.stack : undefined
  });
});
```

**4. Multiple error handlers:**
```javascript
// First error handler - specific errors
app.use((err, req, res, next) => {
  if (err instanceof ValidationError) {
    res.status(400).json({ error: 'Validation failed', details: err.details });
  } else {
    next(err); // Pass to next error handler
  }
});

// Second error handler - database errors
app.use((err, req, res, next) => {
  if (err.code === 'ECONNREFUSED') {
    res.status(503).json({ error: 'Database unavailable' });
  } else {
    next(err); // Pass to generic handler
  }
});

// Final error handler - catch all
app.use((err, req, res, next) => {
  console.error('Unhandled error:', err);
  res.status(500).json({ error: 'Internal server error' });
});
```

**5. Error handling in route handlers:**
```javascript
app.get('/api/data', async (req, res, next) => {
  try {
    const data = await getData();
    if (!data) {
      throw new NotFoundError('Data not found');
    }
    res.json(data);
  } catch (err) {
    next(err); // Pass to error middleware
  }
});
```

**6. Centralized error handling:**
```javascript
// Error class
class AppError extends Error {
  constructor(message, statusCode) {
    super(message);
    this.statusCode = statusCode;
    this.isOperational = true;
  }
}

// Async wrapper
const catchAsync = (fn) => {
  return (req, res, next) => {
    fn(req, res, next).catch(next);
  };
};

// Usage
app.get('/api/users/:id', catchAsync(async (req, res, next) => {
  const user = await User.findById(req.params.id);
  if (!user) {
    throw new AppError('User not found', 404);
  }
  res.json(user);
}));

// Global error handler
app.use((err, req, res, next) => {
  err.statusCode = err.statusCode || 500;
  
  if (process.env.NODE_ENV === 'development') {
    res.status(err.statusCode).json({
      error: err.message,
      stack: err.stack,
      error: err
    });
  } else {
    res.status(err.statusCode).json({
      error: err.isOperational ? err.message : 'Something went wrong'
    });
  }
});
```

---
---

## 16. Error Handling Middleware

#### 1. Where should error handling middleware be placed?

**Answer:**

**Error handling middleware should be placed last**, after all other middleware and routes.

**Correct placement:**
```javascript
const app = express();

// 1. Regular middleware
app.use(express.json());
app.use(express.static('public'));

// 2. Routes
app.get('/', (req, res) => {
  res.send('Home');
});

app.get('/api/data', (req, res) => {
  // Might throw error
  const data = getData();
  res.json(data);
});

// 3. 404 handler (after all routes)
app.use((req, res, next) => {
  res.status(404).send('Not Found');
});

// 4. Error handler (LAST - 4 parameters)
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});
```

**Why last?**
1. **Catches errors** from all previous middleware/routes
2. **Won't interfere** with normal request processing
3. **Only executes** when error occurs
4. **Final chance** to handle errors before response

**Wrong placement examples:**

**Too early (won't catch route errors):**
```javascript
// WRONG - error handler before routes
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).send('Error');
});

app.get('/api/data', (req, res) => {
  throw new Error('Route error'); // Won't be caught
});
```

**Multiple error handlers:**
```javascript
// Specific error handler
app.use('/api', (err, req, res, next) => {
  if (err instanceof APIError) {
    res.status(err.status).json({ error: err.message });
  } else {
    next(err); // Pass to next error handler
  }
});

// General error handler (last)
app.use((err, req, res, next) => {
  console.error('Unhandled error:', err);
  res.status(500).send('Internal Server Error');
});
```

**Router-level error handling:**
```javascript
const router = express.Router();

// Router error handler
router.use((err, req, res, next) => {
  console.error('Router error:', err);
  res.status(500).json({ error: 'Router error' });
});

// Mount router
app.use('/api', router);

// App-level error handler (still needed)
app.use((err, req, res, next) => {
  console.error('App error:', err);
  res.status(500).send('App error');
});
```

---

#### 2. How do you propagate errors through middleware?

**Answer:**

**Propagate errors by calling `next(err)`:**

**Basic propagation:**
```javascript
// Middleware 1 - creates error
app.use((req, res, next) => {
  const err = new Error('Something went wrong');
  next(err); // Propagate to error handler
});

// Middleware 2 - skipped when error exists
app.use((req, res, next) => {
  console.log('This never runs');
  next();
});

// Error handler - receives error
app.use((err, req, res, next) => {
  res.status(500).send(err.message);
});
```

**Async error propagation:**
```javascript
app.use(async (req, res, next) => {
  try {
    const data = await fetchData();
    req.data = data;
    next();
  } catch (err) {
    next(err); // Propagate async error
  }
});
```

**Error wrapping:**
```javascript
app.use((req, res, next) => {
  try {
    // Some operation
    processRequest(req);
    next();
  } catch (err) {
    // Wrap error with more context
    const wrappedError = new Error(`Request processing failed: ${err.message}`);
    wrappedError.originalError = err;
    next(wrappedError);
  }
});
```

**Conditional propagation:**
```javascript
app.use((req, res, next) => {
  if (!req.user) {
    // Create and propagate auth error
    const err = new Error('Unauthorized');
    err.status = 401;
    next(err);
    return;
  }
  next();
});
```

**Multiple error handlers (propagation chain):**
```javascript
// Handler 1 - specific errors
app.use((err, req, res, next) => {
  if (err instanceof ValidationError) {
    res.status(400).json({ error: err.message });
  } else {
    next(err); // Propagate to next handler
  }
});

// Handler 2 - database errors
app.use((err, req, res, next) => {
  if (err.code === 'ECONNREFUSED') {
    res.status(503).json({ error: 'Service unavailable' });
  } else {
    next(err); // Propagate further
  }
});

// Handler 3 - catch all
app.use((err, req, res, next) => {
  console.error('Uncaught error:', err);
  res.status(500).send('Internal Server Error');
});
```

**Error propagation in route handlers:**
```javascript
app.get('/api/users/:id', async (req, res, next) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) {
      // Propagate not found error
      const err = new Error('User not found');
      err.status = 404;
      return next(err);
    }
    res.json(user);
  } catch (err) {
    // Propagate any other errors
    next(err);
  }
});
```

---

#### 3. What is the difference between throwing errors and calling next(error)?

**Answer:**

| Aspect | `throw error` | `next(error)` |
|--------|--------------|--------------|
| **Control flow** | Synchronous | Asynchronous |
| **Middleware** | Stops execution | Passes to error handler |
| **Async code** | Doesn't work | Required |
| **Error type** | Any error | Express error |
| **Best for** | Sync operations | Async operations |

**Throwing errors (synchronous):**
```javascript
// Synchronous code - use throw
app.use((req, res, next) => {
  if (!req.body) {
    throw new Error('No request body'); // Synchronous throw
  }
  next();
});

// Express catches thrown errors and calls next(error)
```

**Calling next(error) (asynchronous):**
```javascript
// Asynchronous code - use next(error)
app.use(async (req, res, next) => {
  try {
    const data = await fetchData();
    req.data = data;
    next();
  } catch (err) {
    next(err); // Must use next() for async
  }
});
```

**What happens with throw in async:**
```javascript
// WRONG - throw in async won't be caught
app.use(async (req, res, next) => {
  const data = await fetchData();
  if (!data) {
    throw new Error('No data'); // Won't be caught by Express
    // Request hangs - no response sent
  }
  res.json(data);
});

// CORRECT - use next(error)
app.use(async (req, res, next) => {
  try {
    const data = await fetchData();
    if (!data) {
      next(new Error('No data')); // Correct
      return;
    }
    res.json(data);
  } catch (err) {
    next(err); // Correct
  }
});
```

**Express behavior:**
```javascript
// Express automatically converts thrown errors
app.use((req, res, next) => {
  throw new Error('Sync error');
  // Express does: next(error) automatically
});

// But not for async
app.use(async (req, res, next) => {
  throw new Error('Async error');
  // Express WON'T catch this - request hangs
});
```

**Best practice:** Use `next(error)` for consistency, especially in async code.

---

#### 4. How do you create structured error responses?

**Answer:**

**1. Custom error class:**
```javascript
class AppError extends Error {
  constructor(message, statusCode = 500, code = 'INTERNAL_ERROR') {
    super(message);
    this.statusCode = statusCode;
    this.code = code;
    this.timestamp = new Date().toISOString();
    this.isOperational = true;
    
    Error.captureStackTrace(this, this.constructor);
  }
}

class ValidationError extends AppError {
  constructor(message, field) {
    super(message, 400, 'VALIDATION_ERROR');
    this.field = field;
  }
}

class NotFoundError extends AppError {
  constructor(resource) {
    super(`${resource} not found`, 404, 'NOT_FOUND');
    this.resource = resource;
  }
}
```

**2. Structured error handler:**
```javascript
app.use((err, req, res, next) => {
  // Default values
  err.statusCode = err.statusCode || 500;
  err.code = err.code || 'INTERNAL_ERROR';
  
  // Development vs production
  const isDevelopment = process.env.NODE_ENV === 'development';
  
  const response = {
    error: {
      code: err.code,
      message: err.message,
      status: err.statusCode,
      timestamp: new Date().toISOString()
    }
  };
  
  // Add stack trace in development
  if (isDevelopment) {
    response.error.stack = err.stack;
    response.error.details = err.details;
  }
  
  // Add field for validation errors
  if (err.field) {
    response.error.field = err.field;
  }
  
  // Log error
  console.error(`[${err.code}] ${err.message}`, {
    url: req.url,
    method: req.method,
    ip: req.ip,
    timestamp: response.error.timestamp
  });
  
  res.status(err.statusCode).json(response);
});
```

**3. Usage in routes:**
```javascript
app.get('/api/users/:id', async (req, res, next) => {
  try {
    const user = await User.findById(req.params.id);
    
    if (!user) {
      throw new NotFoundError('User');
    }
    
    if (!user.isActive) {
      throw new AppError('User is inactive', 403, 'USER_INACTIVE');
    }
    
    res.json(user);
  } catch (err) {
    next(err);
  }
});

app.post('/api/users', async (req, res, next) => {
  try {
    const { email, password } = req.body;
    
    if (!email || !password) {
      throw new ValidationError('Email and password required');
    }
    
    if (!isValidEmail(email)) {
      throw new ValidationError('Invalid email format', 'email');
    }
    
    const user = await User.create({ email, password });
    res.status(201).json(user);
  } catch (err) {
    next(err);
  }
});
```

**4. API error response format:**
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid email format",
    "status": 400,
    "timestamp": "2024-01-15T10:30:00.000Z",
    "field": "email",
    "stack": "Error: Invalid email format\n    at ..." // dev only
  }
}
```

**5. HTTP status code mapping:**
```javascript
const statusCodes = {
  // 4xx Client errors
  BAD_REQUEST: 400,
  UNAUTHORIZED: 401,
  FORBIDDEN: 403,
  NOT_FOUND: 404,
  CONFLICT: 409,
  VALIDATION_ERROR: 422,
  
  // 5xx Server errors
  INTERNAL_ERROR: 500,
  SERVICE_UNAVAILABLE: 503
};
```

**6. Error logging middleware:**
```javascript
function errorLogger(err, req, res, next) {
  console.error({
    timestamp: new Date().toISOString(),
    method: req.method,
    url: req.url,
    error: err.message,
    stack: err.stack,
    code: err.code,
    status: err.statusCode
  });
  next(err);
}

app.use(errorLogger);
app.use(errorResponder);
```

---

#### 5. How do you handle different types of errors in Express?

**Answer:**

**1. Validation errors:**
```javascript
const { validationResult } = require('express-validator');

app.post('/api/users', [
  // Validation rules
  check('email').isEmail(),
  check('password').isLength({ min: 6 })
], (req, res, next) => {
  // Check for validation errors
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const err = new Error('Validation failed');
    err.status = 400;
    err.details = errors.array();
    return next(err);
  }
  
  // Process valid request
  res.json({ success: true });
});
```

**2. Database errors:**
```javascript
app.use((err, req, res, next) => {
  // MongoDB duplicate key
  if (err.code === 11000) {
    return res.status(409).json({
      error: 'Duplicate entry',
      field: Object.keys(err.keyPattern)[0]
    });
  }
  
  // MongoDB validation error
  if (err.name === 'ValidationError') {
    return res.status(400).json({
      error: 'Validation failed',
      details: Object.values(err.errors).map(e => ({
        field: e.path,
        message: e.message
      }))
    });
  }
  
  next(err);
});
```

**3. Authentication errors:**
```javascript
const passport = require('passport');

app.post('/api/login', (req, res, next) => {
  passport.authenticate('local', (err, user, info) => {
    if (err) return next(err);
    if (!user) {
      return res.status(401).json({
        error: 'Authentication failed',
        message: info.message
      });
    }
    
    // Login successful
    req.login(user, (err) => {
      if (err) return next(err);
      res.json({ user });
    });
  })(req, res, next);
});
```

**4. File upload errors:**
```javascript
const multer = require('multer');
const upload = multer({
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB
  fileFilter: (req, file, cb) => {
    if (!file.mimetype.startsWith('image/')) {
      cb(new Error('Only images allowed'), false);
    } else {
      cb(null, true);
    }
  }
});

app.post('/upload', upload.single('image'), (err, req, res, next) => {
  if (err instanceof multer.MulterError) {
    // Multer errors
    if (err.code === 'LIMIT_FILE_SIZE') {
      return res.status(400).json({ error: 'File too large' });
    }
  } else if (err) {
    // Other errors
    return res.status(400).json({ error: err.message });
  }
  
  next();
}, (req, res) => {
  res.json({ success: true, file: req.file });
});
```

**5. Rate limiting errors:**
```javascript
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // Limit each IP to 100 requests per window
  message: {
    error: 'Too many requests',
    retryAfter: '15 minutes'
  },
  standardHeaders: true, // Return rate limit info in headers
  legacyHeaders: false
});

app.use('/api/', limiter);

// Custom handler for rate limit errors
app.use((err, req, res, next) => {
  if (err instanceof rateLimit.RateLimitError) {
    return res.status(429).json({
      error: 'Rate limit exceeded',
      retryAfter: err.retryAfter
    });
  }
  next(err);
});
```

**6. Network/timeout errors:**
```javascript
app.use((err, req, res, next) => {
  // Network errors
  if (err.code === 'ECONNREFUSED') {
    return res.status(503).json({
      error: 'Service unavailable',
      message: 'Database connection failed'
    });
  }
  
  if (err.code === 'ETIMEDOUT') {
    return res.status(504).json({
      error: 'Gateway timeout',
      message: 'Request timed out'
    });
  }
  
  next(err);
});
```

**7. Centralized error handler:**
```javascript
function errorHandler(err, req, res, next) {
  // Set defaults
  err.statusCode = err.statusCode || 500;
  err.status = err.status || 'error';
  
  // Handle different environments
  if (process.env.NODE_ENV === 'development') {
    sendErrorDev(err, res);
  } else {
    // Production
    let error = { ...err };
    error.message = err.message;
    
    // Handle specific error types
    if (error.name === 'CastError') error = handleCastErrorDB(error);
    if (error.code === 11000) error = handleDuplicateFieldsDB(error);
    if (error.name === 'ValidationError') error = handleValidationErrorDB(error);
    if (error.name === 'JsonWebTokenError') error = handleJWTError();
    if (error.name === 'TokenExpiredError') error = handleJWTExpiredError();
    
    sendErrorProd(error, res);
  }
}

function handleCastErrorDB(err) {
  const message = `Invalid ${err.path}: ${err.value}`;
  return new AppError(message, 400);
}

function handleDuplicateFieldsDB(err) {
  const value = err.errmsg.match(/(["'])(\\?.)*?\1/)[0];
  const message = `Duplicate field value: ${value}. Please use another value!`;
  return new AppError(message, 400);
}

function handleValidationErrorDB(err) {
  const errors = Object.values(err.errors).map(el => el.message);
  const message = `Invalid input data. ${errors.join('. ')}`;
  return new AppError(message, 400);
}
```

---
---

## 17. Route Parameters & Query Strings

#### 1. How do you define route parameters?

**Answer:**

**Route parameters** are named URL segments that capture values at specific positions.

**Basic syntax:**
```javascript
// Single parameter
app.get('/users/:id', (req, res) => {
  const userId = req.params.id;
  res.send(`User ID: ${userId}`);
});
// GET /users/123 → userId = '123'

// Multiple parameters
app.get('/users/:userId/posts/:postId', (req, res) => {
  const { userId, postId } = req.params;
  res.send(`User ${userId}, Post ${postId}`);
});
// GET /users/123/posts/456 → userId = '123', postId = '456'

// Optional parameter
app.get('/users/:id?', (req, res) => {
  if (req.params.id) {
    res.send(`User ${req.params.id}`);
  } else {
    res.send('All users');
  }
});
// GET /users/123 → User 123
// GET /users → All users
```

**Parameter with regex:**
```javascript
// Only numeric IDs
app.get('/users/:id(\\d+)', (req, res) => {
  res.send(`User ${req.params.id}`);
});
// GET /users/123 → OK
// GET /users/abc → 404

// Specific pattern
app.get('/files/:name.:ext', (req, res) => {
  const { name, ext } = req.params;
  res.send(`File: ${name}.${ext}`);
});
// GET /files/document.pdf → File: document.pdf
```

**Wildcard parameters:**
```javascript
// Capture everything after /files/
app.get('/files/*', (req, res) => {
  const path = req.params[0]; // 'images/photo.jpg'
  res.send(`File path: ${path}`);
});
// GET /files/images/photo.jpg → File path: images/photo.jpg
```

**Parameter middleware:**
```javascript
// Validate parameter before route handler
app.param('id', (req, res, next, id) => {
  // Validate ID format
  if (!/^\d+$/.test(id)) {
    return res.status(400).send('Invalid ID format');
  }
  
  // Convert to number
  req.userId = parseInt(id, 10);
  next();
});

app.get('/users/:id', (req, res) => {
  // req.userId is already validated and converted
  res.send(`User ${req.userId}`);
});
```

---

#### 2. What is the difference between required and optional parameters?

**Answer:**

| Feature | Required Parameters | Optional Parameters |
|---------|-------------------|-------------------|
| **Syntax** | `:param` | `:param?` |
| **Presence** | Must be present | Can be omitted |
| **URL matching** | Exact segment | Optional segment |
| **req.params** | Always has value | May be undefined |

**Required parameters:**
```javascript
// Required - must be present
app.get('/users/:id', (req, res) => {
  // req.params.id is guaranteed to exist
  const userId = req.params.id;
  res.send(`User ${userId}`);
});

// Valid: GET /users/123
// Invalid: GET /users (404 - Not Found)
```

**Optional parameters:**
```javascript
// Optional - can be omitted
app.get('/users/:id?', (req, res) => {
  if (req.params.id) {
    // With ID: specific user
    res.send(`User ${req.params.id}`);
  } else {
    // Without ID: all users
    res.send('All users');
  }
});

// Both valid:
// GET /users/123 → User 123
// GET /users → All users
```

**Multiple optional parameters:**
```javascript
// Multiple optional params
app.get('/archive/:year?/:month?/:day?', (req, res) => {
  const { year, month, day } = req.params;
  
  if (year && month && day) {
    res.send(`Archive for ${year}-${month}-${day}`);
  } else if (year && month) {
    res.send(`Archive for ${year}-${month}`);
  } else if (year) {
    res.send(`Archive for ${year}`);
  } else {
    res.send('All archives');
  }
});

// All valid:
// GET /archive/2024/01/15 → 2024-01-15
// GET /archive/2024/01 → 2024-01
// GET /archive/2024 → 2024
// GET /archive → All archives
```

**Route precedence:**
```javascript
// Specific route (higher priority)
app.get('/users/new', (req, res) => {
  res.send('Create user form');
});

// Parameter route (lower priority)
app.get('/users/:id', (req, res) => {
  res.send(`User ${req.params.id}`);
});

// GET /users/new → 'Create user form' (not User new)
// GET /users/123 → 'User 123'
```

**Best practices:**
1. Use required params for mandatory identifiers
2. Use optional params for filters/settings
3. Place specific routes before parameter routes
4. Validate parameter values
5. Consider query strings for optional filters

---

#### 3. How do you validate route parameters?

**Answer:**

**1. Using regex in route definition:**
```javascript
// Numeric ID only
app.get('/users/:id(\\d+)', (req, res) => {
  res.send(`User ${req.params.id}`);
});

// UUID format
app.get('/users/:id([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})', 
  (req, res) => {
    res.send(`User ${req.params.id}`);
  }
);

// Date format (YYYY-MM-DD)
app.get('/events/:date(\\d{4}-\\d{2}-\\d{2})', (req, res) => {
  res.send(`Events for ${req.params.date}`);
});
```

**2. Using param middleware:**
```javascript
// Validate user ID
app.param('userId', (req, res, next, userId) => {
  if (!/^\d+$/.test(userId)) {
    return res.status(400).json({ error: 'Invalid user ID' });
  }
  
  // Convert and store
  req.userId = parseInt(userId, 10);
  next();
});

// Validate post ID
app.param('postId', (req, res, next, postId) => {
  if (!/^[a-zA-Z0-9]+$/.test(postId)) {
    return res.status(400).json({ error: 'Invalid post ID' });
  }
  req.postId = postId;
  next();
});

// Use validated parameters
app.get('/users/:userId/posts/:postId', (req, res) => {
  res.json({ userId: req.userId, postId: req.postId });
});
```

**3. In route handler:**
```javascript
app.get('/users/:id', (req, res, next) => {
  const userId = req.params.id;
  
  // Validate format
  if (!/^\d+$/.test(userId)) {
    return res.status(400).json({ error: 'ID must be numeric' });
  }
  
  // Validate range
  const idNum = parseInt(userId, 10);
  if (idNum < 1 || idNum > 1000000) {
    return res.status(400).json({ error: 'ID out of range' });
  }
  
  // Proceed with valid ID
  User.findById(idNum, (err, user) => {
    if (err) return next(err);
    if (!user) return res.status(404).json({ error: 'User not found' });
    res.json(user);
  });
});
```

**4. Using validation library:**
```javascript
const { param, validationResult } = require('express-validator');

app.get('/users/:id', 
  [
    param('id')
      .isInt({ min: 1 })
      .withMessage('ID must be a positive integer')
      .toInt()
  ],
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    
    // req.params.id is already converted to number
    User.findById(req.params.id, (err, user) => {
      if (err) return next(err);
      res.json(user);
    });
  }
);
```

**5. Custom validation function:**
```javascript
function validateParam(paramName, validator) {
  return (req, res, next) => {
    const value = req.params[paramName];
    
    if (!validator(value)) {
      return res.status(400).json({
        error: `Invalid ${paramName}: ${value}`,
        param: paramName,
        value: value
      });
    }
    
    next();
  };
}

// Usage
app.get('/products/:sku',
  validateParam('sku', (sku) => {
    // SKU format: ABC-12345
    return /^[A-Z]{3}-\d{5}$/.test(sku);
  }),
  (req, res) => {
    res.json({ sku: req.params.sku });
  }
);
```

**6. Type conversion and sanitization:**
```javascript
app.param('id', (req, res, next, id) => {
  // Convert to number
  const numId = parseInt(id, 10);
  
  if (isNaN(numId)) {
    return res.status(400).json({ error: 'ID must be a number' });
  }
  
  // Sanitize: ensure positive
  if (numId <= 0) {
    return res.status(400).json({ error: 'ID must be positive' });
  }
  
  req.params.id = numId; // Replace with converted value
  next();
});
```

---

#### 4. How do you handle query strings in Express?

**Answer:**

**Query strings** are key-value pairs after `?` in URL.

**Basic access:**
```javascript
app.get('/search', (req, res) => {
  const { q, page, limit } = req.query;
  
  res.json({
    query: q,
    page: page || 1,
    limit: limit || 10
  });
});

// GET /search?q=nodejs&page=2&limit=20
// → { query: 'nodejs', page: '2', limit: '20' }
```

**Type conversion:**
```javascript
app.get('/products', (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const minPrice = parseFloat(req.query.minPrice) || 0;
  const inStock = req.query.inStock === 'true';
  
  res.json({ page, limit, minPrice, inStock });
});
```

**Array parameters:**
```javascript
app.get('/filter', (req, res) => {
  // GET /filter?category=books&category=electronics&sort=price
  const categories = req.query.category; // ['books', 'electronics']
  const sort = req.query.sort; // 'price'
  
  res.json({ categories, sort });
});
```

**Nested parameters:**
```javascript
app.get('/search', (req, res) => {
  // GET /search?filter[name]=John&filter[age]=30&sort[field]=name&sort[order]=asc
  const filter = req.query.filter; // { name: 'John', age: '30' }
  const sort = req.query.sort; // { field: 'name', order: 'asc' }
  
  res.json({ filter, sort });
});
```

**Validation and sanitization:**
```javascript
const { query, validationResult } = require('express-validator');

app.get('/api/data',
  [
    query('page').optional().isInt({ min: 1 }).toInt(),
    query('limit').optional().isInt({ min: 1, max: 100 }).toInt(),
    query('sort').optional().isIn(['name', 'price', 'date']),
    query('search').optional().trim().escape()
  ],
  (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    
    const { page = 1, limit = 10, sort = 'name', search = '' } = req.query;
    
    res.json({
      page, limit, sort, search,
      message: 'Parameters validated'
    });
  }
);
```

**Pagination helper:**
```javascript
function getPaginationParams(req) {
  const page = Math.max(parseInt(req.query.page) || 1, 1);
  const limit = Math.min(Math.max(parseInt(req.query.limit) || 10, 1), 100);
  const skip = (page - 1) * limit;
  
  return { page, limit, skip };
}

app.get('/api/items', (req, res) => {
  const { page, limit, skip } = getPaginationParams(req);
  const sort = req.query.sort || '-createdAt';
  
  // Use in database query
  Item.find()
    .skip(skip)
    .limit(limit)
    .sort(sort)
    .then(items => {
      res.json({
        page,
        limit,
        items,
        hasMore: items.length === limit
      });
    });
});
```

**URL encoding/decoding:**
```javascript
app.get('/search', (req, res) => {
  // Query strings are automatically decoded
  const searchTerm = req.query.q; // Already decoded
  
  // Manual encoding/decoding if needed
  const encoded = encodeURIComponent(searchTerm);
  const decoded = decodeURIComponent(searchTerm);
  
  res.json({ searchTerm, encoded, decoded });
});

// GET /search?q=hello%20world
// → { searchTerm: 'hello world', encoded: 'hello%20world', decoded: 'hello world' }
```

---

#### 5. What is the difference between req.params and req.query?

**Answer:**

| Aspect | `req.params` | `req.query` |
|--------|-------------|------------|
| **Location** | URL path segments | URL after `?` |
| **Purpose** | Resource identifiers | Filters/options |
| **Structure** | Single values | Key-value pairs |
| **Example** | `/users/123` | `/users?page=2&limit=10` |
| **Access** | `req.params.id` | `req.query.page` |
| **Type** | Usually strings | Strings (can be arrays/objects) |
| **Validation** | Route definition | Manual validation |

**req.params (path parameters):**
```javascript
// Define in route
app.get('/users/:id/posts/:postId', (req, res) => {
  const { id, postId } = req.params;
  // id = '123', postId = '456'
  res.json({ userId: id, postId });
});

// GET /users/123/posts/456
// req.params = { id: '123', postId: '456' }
```

**req.query (query string):**
```javascript
// No definition needed
app.get('/users', (req, res) => {
  const { page, limit, sort } = req.query;
  // page = '2', limit = '10', sort = 'name'
  res.json({ page, limit, sort });
});

// GET /users?page=2&limit=10&sort=name
// req.query = { page: '2', limit: '10', sort: 'name' }
```

**Combined usage:**
```javascript
app.get('/users/:id/posts', (req, res) => {
  const userId = req.params.id;      // From path
  const { page, limit } = req.query; // From query string
  
  res.json({
    userId,
    page: page || 1,
    limit: limit || 10
  });
});

// GET /users/123/posts?page=2&limit=20
// req.params = { id: '123' }
// req.query = { page: '2', limit: '20' }
```

**When to use which:**

**Use req.params for:**
- Resource identifiers (user ID, post ID)
- Required parameters
- Hierarchical relationships
- Clean, readable URLs

**Use req.query for:**
- Optional filters (search, sort, pagination)
- Settings/options
- Temporary state
- Complex filtering

**Example: RESTful API design**
```javascript
// GET /users/123 - Get specific user (params)
app.get('/users/:id', getUser);

// GET /users?role=admin&active=true - Filter users (query)
app.get('/users', getUsers);

// GET /users/123/posts - User's posts (params)
app.get('/users/:userId/posts', getUserPosts);

// GET /users/123/posts?category=tech&sort=date - Filter posts (query)
app.get('/users/:userId/posts', getUserPosts);
```

**Best practices:**
1. Use `req.params` for resource identification
2. Use `req.query` for filtering and sorting
3. Validate both params and query
4. Convert types appropriately
5. Set reasonable defaults for query params
6. Document expected parameters

---
---

## 18. Route Organization & Modularization

#### 1. How do you modularize routes in a large application?

**Answer:**

**Modularization** involves splitting routes into separate files based on features or resources.

**Basic modularization pattern:**

**1. Separate route files:**
```javascript
// routes/users.js
const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  res.send('Get all users');
});

router.post('/', (req, res) => {
  res.send('Create user');
});

router.get('/:id', (req, res) => {
  res.send(`Get user ${req.params.id}`);
});

module.exports = router;
```

**2. Main app file:**
```javascript
// app.js
const express = require('express');
const app = express();
const usersRouter = require('./routes/users');
const postsRouter = require('./routes/posts');
const authRouter = require('./routes/auth');

// Mount routers
app.use('/api/users', usersRouter);
app.use('/api/posts', postsRouter);
app.use('/api/auth', authRouter);

app.listen(3000);
```

**3. Feature-based structure:**
```
src/
├── routes/
│   ├── users.js
│   ├── posts.js
│   ├── auth.js
│   └── index.js
├── controllers/
│   ├── userController.js
│   ├── postController.js
│   └── authController.js
├── models/
│   ├── User.js
│   └── Post.js
└── app.js
```

**4. Route index file:**
```javascript
// routes/index.js
const express = require('express');
const router = express.Router();

// Import route modules
const usersRouter = require('./users');
const postsRouter = require('./posts');
const authRouter = require('./auth');

// Mount routes
router.use('/users', usersRouter);
router.use('/posts', postsRouter);
router.use('/auth', authRouter);

module.exports = router;

// app.js
const apiRouter = require('./routes');
app.use('/api', apiRouter);
```

**5. Dynamic route loading:**
```javascript
// routes/index.js (dynamic loading)
const fs = require('fs');
const path = require('path');
const express = require('express');
const router = express.Router();

// Load all route files automatically
fs.readdirSync(__dirname)
  .filter(file => file !== 'index.js' && file.endsWith('.js'))
  .forEach(file => {
    const routeName = path.basename(file, '.js');
    const route = require(`./${file}`);
    router.use(`/${routeName}`, route);
  });

module.exports = router;
```

---

#### 2. What is the benefit of using Express Router?

**Answer:**

**Express Router** provides modular, mountable route handlers.

**Benefits:**

1. **Modularity:** Separate route logic into files
2. **Middleware isolation:** Router-specific middleware
3. **Reusability:** Use same router in multiple apps
4. **Organization:** Clean separation of concerns
5. **Testing:** Test routes independently

**Basic usage:**
```javascript
const express = require('express');
const router = express.Router();

// Router-level middleware
router.use((req, res, next) => {
  console.log('Router middleware');
  next();
});

// Define routes
router.get('/', (req, res) => {
  res.send('Router home');
});

router.get('/:id', (req, res) => {
  res.send(`Item ${req.params.id}`);
});

module.exports = router;
```

**Mounting router:**
```javascript
const app = express();
const apiRouter = require('./routes/api');

app.use('/api', apiRouter);
// Routes: /api/, /api/:id
```

**Router vs app:**

| Feature | `app` | `router` |
|---------|-------|----------|
| **Scope** | Application-wide | Modular |
| **Middleware** | Global | Router-specific |
| **Mounting** | N/A | Can be mounted |
| **Use Case** | Main app | Feature modules |

**Router-specific features:**
```javascript
const router = express.Router({ 
  caseSensitive: true,  // /Users vs /users
  strict: true          // /users vs /users/
});

// Router param middleware
router.param('id', (req, res, next, id) => {
  req.itemId = id;
  next();
});

// Router route
router.get('/:id', (req, res) => {
  res.send(`Item ${req.itemId}`);
});
```

---

#### 3. How do you handle nested routes?

**Answer:**

**Nested routes** create hierarchical URL structures.

**1. Basic nesting:**
```javascript
// Parent router
const userRouter = express.Router();

userRouter.get('/', (req, res) => {
  res.send('All users');
});

userRouter.get('/:userId', (req, res) => {
  res.send(`User ${req.params.userId}`);
});

// Child router
const postRouter = express.Router({ mergeParams: true });

postRouter.get('/', (req, res) => {
  res.send(`Posts for user ${req.params.userId}`);
});

postRouter.get('/:postId', (req, res) => {
  res.send(`Post ${req.params.postId} for user ${req.params.userId}`);
});

// Nest child under parent
userRouter.use('/:userId/posts', postRouter);

// Mount
app.use('/users', userRouter);

// Routes:
// GET /users → All users
// GET /users/123 → User 123
// GET /users/123/posts → Posts for user 123
// GET /users/123/posts/456 → Post 456 for user 123
```

**2. With `mergeParams: true`:**
```javascript
const parentRouter = express.Router();
const childRouter = express.Router({ mergeParams: true });

parentRouter.param('userId', (req, res, next, userId) => {
  req.user = { id: userId };
  next();
});

childRouter.get('/', (req, res) => {
  // Can access parent params
  res.send(`User: ${req.user.id}`);
});

parentRouter.use('/:userId/child', childRouter);
```

**3. Multiple levels:**
```javascript
// Level 1: Users
const userRouter = express.Router();
userRouter.get('/:userId', getUser);

// Level 2: Posts
const postRouter = express.Router({ mergeParams: true });
postRouter.get('/:postId', getPost);

// Level 3: Comments
const commentRouter = express.Router({ mergeParams: true });
commentRouter.get('/:commentId', getComment);

// Nest them
postRouter.use('/:postId/comments', commentRouter);
userRouter.use('/:userId/posts', postRouter);
app.use('/users', userRouter);

// Route: GET /users/123/posts/456/comments/789
// Params: { userId: '123', postId: '456', commentId: '789' }
```

**4. File-based nesting:**
```javascript
// routes/users/posts/comments.js
const express = require('express');
const router = express.Router({ mergeParams: true });

router.get('/', (req, res) => {
  res.send(`Comments for post ${req.params.postId} of user ${req.params.userId}`);
});

module.exports = router;

// routes/users/posts.js
const express = require('express');
const router = express.Router({ mergeParams: true });
const commentsRouter = require('./comments');

router.use('/:postId/comments', commentsRouter);

module.exports = router;

// routes/users.js
const express = require('express');
const router = express.Router();
const postsRouter = require('./posts');

router.use('/:userId/posts', postsRouter);

module.exports = router;
```

---

#### 4. How do you manage route prefixes?

**Answer:**

**Route prefixes** group related routes under a common path.

**1. Using `app.use()`:**
```javascript
// All routes under /api
app.use('/api', apiRouter);

// All routes under /admin
app.use('/admin', adminRouter);

// All routes under /v1
app.use('/api/v1', v1Router);
```

**2. Router prefixes:**
```javascript
const apiRouter = express.Router();

// Prefix within router
apiRouter.use('/users', userRouter);   // /api/users
apiRouter.use('/posts', postRouter);   // /api/posts
apiRouter.use('/auth', authRouter);    // /api/auth

app.use('/api', apiRouter);
```

**3. Nested prefixes:**
```javascript
const v1Router = express.Router();
const v2Router = express.Router();

// Version 1 routes
v1Router.use('/users', userRouterV1);  // /api/v1/users
v1Router.use('/posts', postRouterV1);  // /api/v1/posts

// Version 2 routes
v2Router.use('/users', userRouterV2);  // /api/v2/users
v2Router.use('/posts', postRouterV2);  // /api/v2/posts

// Mount versions
app.use('/api/v1', v1Router);
app.use('/api/v2', v2Router);
```

**4. Dynamic prefixes:**
```javascript
function createPrefixedRouter(prefix) {
  const router = express.Router();
  
  // Add prefix-specific middleware
  router.use((req, res, next) => {
    console.log(`Request to ${prefix}`);
    next();
  });
  
  return router;
}

const adminRouter = createPrefixedRouter('/admin');
const apiRouter = createPrefixedRouter('/api');

app.use('/admin', adminRouter);
app.use('/api', apiRouter);
```

**5. Environment-based prefixes:**
```javascript
const prefix = process.env.API_PREFIX || '/api';

app.use(prefix, apiRouter);

// Development: /api
// Production: /api/v1
// Custom: /myapi
```

**6. Removing prefixes:**
```javascript
// Sometimes you want to mount without prefix
const router = express.Router();

router.get('/users', (req, res) => {
  res.send('Users');
});

// Mount at root
app.use(router);  // GET /users

// Or with prefix
app.use('/api', router);  // GET /api/users
```

---

#### 5. What are the best practices for route organization?

**Answer:**

**1. Feature-based organization:**
```
routes/
├── auth/
│   ├── login.js
│   ├── register.js
│   └── logout.js
├── users/
│   ├── profile.js
│   ├── settings.js
│   └── admin.js
├── posts/
│   ├── create.js
│   ├── list.js
│   └── comments.js
└── index.js
```

**2. Use controllers:**
```javascript
// routes/users.js
const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

router.get('/', userController.getAllUsers);
router.post('/', userController.createUser);
router.get('/:id', userController.getUser);
router.put('/:id', userController.updateUser);
router.delete('/:id', userController.deleteUser);

module.exports = router;
```

**3. Consistent naming:**
```javascript
// Good
GET    /users          // List users
POST   /users          // Create user
GET    /users/:id      // Get user
PUT    /users/:id      // Update user
DELETE /users/:id      // Delete user

GET    /users/:id/posts    // User's posts
POST   /users/:id/posts    // Create post for user
```

**4. Version your API:**
```javascript
app.use('/api/v1', v1Router);
app.use('/api/v2', v2Router);
app.use('/api/latest', latestRouter);
```

**5. Use middleware appropriately:**
```javascript
// Global middleware (app-level)
app.use(helmet());
app.use(cors());
app.use(express.json());

// Route-specific middleware
apiRouter.use(authenticate);
adminRouter.use(authenticate, authorize('admin'));

// Route handler middleware
router.get('/secret', authenticate, authorize('admin'), getSecret);
```

**6. Error handling:**
```javascript
// Route-level error handling
router.use((err, req, res, next) => {
  // Route-specific error handling
  next(err); // Pass to app-level handler
});

// App-level error handling (last)
app.use((err, req, res, next) => {
  // Global error handling
  res.status(500).json({ error: err.message });
});
```

**7. Documentation:**
```javascript
/**
 * @route GET /api/users
 * @desc Get all users
 * @access Public
 */
router.get('/', userController.getAllUsers);

/**
 * @route POST /api/users
 * @desc Create a user
 * @access Private/Admin
 */
router.post('/', authenticate, authorize('admin'), userController.createUser);
```

**8. Testing organization:**
```javascript
// tests/routes/users.test.js
describe('User Routes', () => {
  describe('GET /api/users', () => {
    it('should return all users', async () => {
      const res = await request(app).get('/api/users');
      expect(res.status).toBe(200);
    });
  });
});
```

**9. Keep routes focused:**
```javascript
// Good: Each route file handles one resource
// routes/users.js - user-related routes
// routes/posts.js - post-related routes

// Bad: One file with all routes
// routes/index.js - users, posts, auth, etc.
```

**10. Use route helpers:**
```javascript
// utils/routeHelpers.js
function paginate(model) {
  return async (req, res, next) => {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const skip = (page - 1) * limit;
    
    req.pagination = { page, limit, skip };
    next();
  };
}

// Usage
router.get('/', paginate(User), userController.getUsers);
```

---
---

## 19. RESTful API Design

#### 1. What are RESTful principles?

**Answer:**

**REST** (Representational State Transfer) is an architectural style with these principles:

**1. Client-Server Architecture:**
- Separation of concerns
- Client handles UI, server handles data
- Independent evolution

**2. Statelessness:**
- Each request contains all needed information
- No server-side session state
- Scalability benefits

**3. Cacheability:**
- Responses must define cacheability
- Improves performance
- Reduces server load

**4. Uniform Interface:**
- Resource identification (URI)
- Resource manipulation through representations
- Self-descriptive messages
- HATEOAS (Hypermedia as the Engine of Application State)

**5. Layered System:**
- Client doesn't know if connected to end server
- Intermediary servers improve scalability
- Load balancing, security layers

**6. Code on Demand (optional):**
- Server can extend client functionality
- Send executable code (JavaScript)

**REST constraints in practice:**

**Resource-based:**
```
/users          # Collection of users
/users/123      # Specific user
/users/123/posts # User's posts
```

**HTTP methods:**
```
GET     /users          # Retrieve all users
POST    /users          # Create new user
GET     /users/123      # Retrieve user 123
PUT     /users/123      # Replace user 123
PATCH   /users/123      # Update user 123 partially
DELETE  /users/123      # Delete user 123
```

**Stateless example:**
```javascript
// Stateless - each request has token
app.get('/api/data', authenticateToken, (req, res) => {
  // Token in header, not session
  res.json({ data: 'value' });
});

// Stateful (not RESTful) - uses session
app.get('/api/data', (req, res) => {
  if (!req.session.userId) { // Server stores state
    return res.status(401).send('Unauthorized');
  }
  res.json({ data: 'value' });
});
```

---

#### 2. How do you design RESTful endpoints?

**Answer:**

**RESTful endpoint design guidelines:**

**1. Use nouns, not verbs:**
```javascript
// Good (nouns)
GET    /users
POST   /users
GET    /users/:id
PUT    /users/:id
DELETE /users/:id

// Bad (verbs)
GET    /getUsers
POST   /createUser
GET    /getUser/:id
POST   /updateUser/:id
POST   /deleteUser/:id
```

**2. Use plural nouns for collections:**
```javascript
// Good
/users          # Collection of users
/posts          # Collection of posts
/comments       # Collection of comments

// Avoid
/user
/post
/comment
```

**3. Nested resources for relationships:**
```javascript
// User's posts
GET    /users/:userId/posts          # All posts by user
POST   /users/:userId/posts          # Create post for user
GET    /users/:userId/posts/:postId  # Specific post by user

// Post's comments
GET    /posts/:postId/comments       # All comments on post
POST   /posts/:postId/comments       # Add comment to post
GET    /posts/:postId/comments/:commentId # Specific comment
```

**4. Use HTTP methods correctly:**
```javascript
// CRUD operations
CREATE  → POST   /resources
READ    → GET    /resources or /resources/:id
UPDATE  → PUT    /resources/:id (replace)
UPDATE  → PATCH  /resources/:id (partial)
DELETE  → DELETE /resources/:id

// Non-CRUD operations
GET     /users/:id/followers   # Get followers
POST    /users/:id/follow      # Follow user
DELETE  /users/:id/follow      # Unfollow user
```

**5. Filter, sort, paginate with query params:**
```javascript
// Filtering
GET /users?role=admin&active=true
GET /posts?category=tech&author=john

// Sorting
GET /users?sort=name&order=asc
GET /posts?sort=-createdAt  # descending

// Pagination
GET /users?page=2&limit=20
GET /posts?offset=50&limit=25

// Search
GET /users?q=john
GET /posts?search=nodejs
```

**6. Version your API:**
```javascript
// URL versioning
GET /api/v1/users
GET /api/v2/users

// Header versioning
GET /api/users
Headers: Accept: application/vnd.myapi.v1+json
```

**Complete example:**
```javascript
// User resource
GET     /api/v1/users                 # List users
POST    /api/v1/users                 # Create user
GET     /api/v1/users/:id             # Get user
PUT     /api/v1/users/:id             # Update user
PATCH   /api/v1/users/:id             # Partial update
DELETE  /api/v1/users/:id             # Delete user

// Nested: User's posts
GET     /api/v1/users/:id/posts       # User's posts
POST    /api/v1/users/:id/posts       # Create post for user

// Actions
POST    /api/v1/users/:id/follow      # Follow user
DELETE  /api/v1/users/:id/follow      # Unfollow user
GET     /api/v1/users/:id/followers   # Get followers
GET     /api/v1/users/:id/following   # Get following
```

---

#### 3. What are the best practices for REST API design?

**Answer:**

**1. Use proper HTTP status codes:**
```javascript
// 2xx Success
200 OK                    // Successful GET, PUT, PATCH
201 Created               // Successful POST
204 No Content            // Successful DELETE

// 3xx Redirection
301 Moved Permanently     // Resource moved
304 Not Modified          // Cached version valid

// 4xx Client errors
400 Bad Request           // Invalid request
401 Unauthorized          // Authentication needed
403 Forbidden             // Authenticated but no permission
404 Not Found             // Resource doesn't exist
409 Conflict              // Resource conflict
422 Unprocessable Entity  // Validation failed

// 5xx Server errors
500 Internal Server Error // Generic server error
503 Service Unavailable   // Maintenance or overload
```

**2. Consistent response format:**
```javascript
// Success response
{
  "data": {
    "id": 123,
    "name": "John",
    "email": "john@example.com"
  },
  "meta": {
    "timestamp": "2024-01-15T10:30:00Z"
  }
}

// List response
{
  "data": [
    { "id": 1, "name": "John" },
    { "id": 2, "name": "Jane" }
  ],
  "meta": {
    "total": 2,
    "page": 1,
    "limit": 10
  },
  "links": {
    "self": "/api/users?page=1",
    "next": "/api/users?page=2",
    "prev": null
  }
}

// Error response
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Email is required",
    "details": [
      { "field": "email", "message": "Email is required" }
    ]
  },
  "meta": {
    "timestamp": "2024-01-15T10:30:00Z"
  }
}
```

**3. Use proper HTTP headers:**
```javascript
// Content negotiation
Accept: application/json
Content-Type: application/json

// Caching
Cache-Control: public, max-age=3600
ETag: "abc123"
Last-Modified: Wed, 15 Jan 2024 10:30:00 GMT

// Rate limiting
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 99
X-RateLimit-Reset: 1609459200

// Pagination
Link: </api/users?page=2>; rel="next",
      </api/users?page=5>; rel="last"
```

**4. Implement filtering, sorting, pagination:**
```javascript
// Query parameters
GET /api/users?page=2&limit=20&sort=name&order=asc&role=admin

// Response includes metadata
{
  "data": [...],
  "meta": {
    "total": 150,
    "page": 2,
    "limit": 20,
    "pages": 8
  },
  "links": {
    "first": "/api/users?page=1",
    "prev": "/api/users?page=1",
    "self": "/api/users?page=2",
    "next": "/api/users?page=3",
    "last": "/api/users?page=8"
  }
}
```

**5. Security best practices:**
```javascript
// Use HTTPS
app.use(helmet()); // Security headers

// Authentication
app.use(passport.initialize());

// Rate limiting
app.use(rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100
}));

// Input validation
app.use(expressValidator());

// CORS
app.use(cors({
  origin: ['https://example.com'],
  credentials: true
}));
```

**6. Documentation:**
```javascript
// OpenAPI/Swagger example
/**
 * @swagger
 * /api/users:
 *   get:
 *     summary: Get all users
 *     tags: [Users]
 *     parameters:
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *         description: Page number
 *     responses:
 *       200:
 *         description: List of users
 */
app.get('/api/users', userController.getUsers);
```

**7. Performance optimization:**
```javascript
// Compression
app.use(compression());

// Caching
app.get('/api/users', cacheMiddleware, userController.getUsers);

// Database optimization
// - Use indexes
// - Implement pagination
// - Select only needed fields

// Response compression
res.json({ data }); // Automatically compressed if >1KB
```

---

#### 4. How do you handle CRUD operations in REST?

**Answer:**

**CRUD** (Create, Read, Update, Delete) mapped to HTTP methods:

**1. Create (POST):**
```javascript
// Create new resource
app.post('/api/users', (req, res) => {
  const user = req.body;
  
  // Validate input
  if (!user.name || !user.email) {
    return res.status(400).json({ error: 'Name and email required' });
  }
  
  // Create in database
  User.create(user, (err, newUser) => {
    if (err) {
      return res.status(500).json({ error: 'Database error' });
    }
    
    // Return created resource with 201 status
    res.status(201).json({
      data: newUser,
      links: {
        self: `/api/users/${newUser.id}`
      }
    });
  });
});
```

**2. Read (GET):**
```javascript
// Get all resources
app.get('/api/users', (req, res) => {
  const { page = 1, limit = 10 } = req.query;
  const skip = (page - 1) * limit;
  
  User.find()
    .skip(skip)
    .limit(limit)
    .exec((err, users) => {
      if (err) {
        return res.status(500).json({ error: 'Database error' });
      }
      
      User.countDocuments((err, total) => {
        res.json({
          data: users,
          meta: {
            total,
            page: parseInt(page),
            limit: parseInt(limit),
            pages: Math.ceil(total / limit)
          }
        });
      });
    });
});

// Get single resource
app.get('/api/users/:id', (req, res) => {
  User.findById(req.params.id, (err, user) => {
    if (err) {
      return res.status(500).json({ error: 'Database error' });
    }
    
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json({ data: user });
  });
});
```

**3. Update (PUT/PATCH):**
```javascript
// PUT - Replace entire resource
app.put('/api/users/:id', (req, res) => {
  const updates = req.body;
  
  User.findByIdAndUpdate(
    req.params.id,
    updates,
    { new: true, runValidators: true }, // Return updated, validate
    (err, user) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      
      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }
      
      res.json({ data: user });
    }
  );
});

// PATCH - Partial update
app.patch('/api/users/:id', (req, res) => {
  const updates = req.body;
  
  // Only allow specific fields
  const allowedUpdates = ['name', 'email', 'age'];
  const isValidUpdate = Object.keys(updates).every(key => 
    allowedUpdates.includes(key)
  );
  
  if (!isValidUpdate) {
    return res.status(400).json({ error: 'Invalid updates' });
  }
  
  User.findByIdAndUpdate(
    req.params.id,
    updates,
    { new: true, runValidators: true },
    (err, user) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      
      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }
      
      res.json({ data: user });
    }
  );
});
```

**4. Delete (DELETE):**
```javascript
app.delete('/api/users/:id', (req, res) => {
  User.findByIdAndDelete(req.params.id, (err, user) => {
    if (err) {
      return res.status(500).json({ error: 'Database error' });
    }
    
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    // 204 No Content - successful deletion
    res.status(204).send();
  });
});
```

**Complete CRUD controller:**
```javascript
// controllers/userController.js
exports.createUser = async (req, res) => {
  try {
    const user = await User.create(req.body);
    res.status(201).json({ data: user });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

exports.getUsers = async (req, res) => {
  try {
    const users = await User.find();
    res.json({ data: users });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
};

exports.getUser = async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.json({ data: user });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
};

exports.updateUser = async (req, res) => {
  try {
    const user = await User.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true, runValidators: true }
    );
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.json({ data: user });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

exports.deleteUser = async (req, res) => {
  try {
    const user = await User.findByIdAndDelete(req.params.id);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.status(204).send();
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
};
```

---

#### 5. What is HATEOAS and when should you use it?

**Answer:**

**HATEOAS** (Hypermedia as the Engine of Application State) means responses include links to related resources.

**Basic HATEOAS example:**
```javascript
// GET /api/users/123
{
  "data": {
    "id": 123,
    "name": "John Doe",
    "email": "john@example.com"
  },
  "links": {
    "self": { "href": "/api/users/123" },
    "posts": { "href": "/api/users/123/posts" },
    "followers": { "href": "/api/users/123/followers" },
    "following": { "href": "/api/users/123/following" }
  }
}
```

**Advanced HATEOAS with actions:**
```javascript
// GET /api/users/123
{
  "data": {
    "id": 123,
    "name": "John",
    "role": "user",
    "status": "active"
  },
  "links": [
    {
      "rel": "self",
      "href": "/api/users/123",
      "method": "GET"
    },
    {
      "rel": "update",
      "href": "/api/users/123",
      "method": "PUT",
      "title": "Update user"
    },
    {
      "rel": "delete",
      "href": "/api/users/123",
      "method": "DELETE",
      "title": "Delete user"
    },
    {
      "rel": "posts",
      "href": "/api/users/123/posts",
      "method": "GET",
      "title": "User's posts"
    }
  ]
}
```

**When to use HATEOAS:**

**1. Discoverable APIs:**
```javascript
// Root endpoint reveals all available resources
// GET /api
{
  "links": [
    {
      "rel": "users",
      "href": "/api/users",
      "method": "GET",
      "title": "List users"
    },
    {
      "rel": "posts",
      "href": "/api/posts",
      "method": "GET",
      "title": "List posts"
    },
    {
      "rel": "login",
      "href": "/api/auth/login",
      "method": "POST",
      "title": "Login"
    }
  ]
}
```

**2. State transitions:**
```javascript
// Order workflow
// GET /api/orders/456
{
  "data": {
    "id": 456,
    "status": "pending",
    "total": 99.99
  },
  "links": [
    {
      "rel": "cancel",
      "href": "/api/orders/456/cancel",
      "method": "POST",
      "condition": "status === 'pending'"
    },
    {
      "rel": "pay",
      "href": "/api/orders/456/pay",
      "method": "POST",
      "condition": "status === 'pending'"
    },
    {
      "rel": "ship",
      "href": "/api/orders/456/ship",
      "method": "POST",
      "condition": "status === 'paid'"
    }
  ]
}
```

**3. Pagination with HATEOAS:**
```javascript
// GET /api/users?page=2
{
  "data": [...],
  "meta": {
    "page": 2,
    "limit": 10,
    "total": 150
  },
  "links": {
    "first": { "href": "/api/users?page=1" },
    "prev": { "href": "/api/users?page=1" },
    "self": { "href": "/api/users?page=2" },
    "next": { "href": "/api/users?page=3" },
    "last": { "href": "/api/users?page=15" }
  }
}
```

**Implementation in Express:**
```javascript
// HATEOAS middleware
function addLinks(req, res, next) {
  const originalJson = res.json;
  
  res.json = function(data) {
    // Add links based on route and data
    const links = generateLinks(req, data);
    
    if (Array.isArray(data)) {
      data = { data, links };
    } else if (data && typeof data === 'object') {
      data.links = links;
    }
    
    originalJson.call(this, data);
  };
  
  next();
}

function generateLinks(req, data) {
  const baseUrl = `${req.protocol}://${req.get('host')}`;
  const path = req.path;
  const id = req.params.id;
  
  const links = {
    self: { href: `${baseUrl}${path}` }
  };
  
  // Add resource-specific links
  if (path === '/api/users' && !id) {
    // Collection
    links.create = { href: `${baseUrl}${path}`, method: 'POST' };
  } else if (path.match(/^\/api\/users\/\d+$/)) {
    // Single resource
    links.update = { href: `${baseUrl}${path}`, method: 'PUT' };
    links.delete = { href: `${baseUrl}${path}`, method: 'DELETE' };
    links.posts = { href: `${baseUrl}${path}/posts`, method: 'GET' };
  }
  
  return links;
}

// Usage
app.get('/api/users/:id', addLinks, userController.getUser);
```

**Benefits of HATEOAS:**
1. **Discoverability**: Clients can navigate API without documentation
2. **Decoupling**: Server controls URLs, clients follow links
3. **Evolution**: Can change URLs without breaking clients
4. **State management**: Links show available actions based on state

**When NOT to use HATEOAS:**
1. **Simple APIs**: Internal or small-scale APIs
2. **Performance-critical**: Extra links add overhead
3. **Mobile apps**: Often prefer predefined endpoints
4. **GraphQL APIs**: Use GraphQL introspection instead

**Best practice**: Use HATEOAS for public APIs where discoverability is important.

---
---

## 20. API Versioning Strategies

#### 1. Why is API versioning important?

**Answer:**

**API versioning** is crucial for maintaining backward compatibility while evolving APIs.

**Reasons for versioning:**

**1. Breaking changes:**
- Changing response structure
- Removing or renaming fields
- Changing authentication methods
- Modifying business logic

**2. Client compatibility:**
- Mobile apps with different release cycles
- Third-party integrations
- Legacy systems

**3. Gradual migration:**
- Give clients time to upgrade
- Run multiple versions simultaneously
- Deprecate old versions gracefully

**4. Innovation:**
- Experiment with new features
- A/B testing different approaches
- Major architectural changes

**Example without versioning (problem):**
```javascript
// Version 1 (initial)
app.get('/api/users', (req, res) => {
  res.json([
    { id: 1, name: 'John', email: 'john@example.com' }
  ]);
});

// Version 2 (breaking change - added field)
app.get('/api/users', (req, res) => {
  res.json([
    { 
      id: 1, 
      name: 'John', 
      email: 'john@example.com',
      createdAt: '2024-01-15'  // NEW FIELD
    }
  ]);
});
// BREAKS existing clients expecting old structure
```

**Example with versioning (solution):**
```javascript
// Version 1 (stable)
app.get('/api/v1/users', (req, res) => {
  res.json([
    { id: 1, name: 'John', email: 'john@example.com' }
  ]);
});

// Version 2 (new features)
app.get('/api/v2/users', (req, res) => {
  res.json([
    { 
      id: 1, 
      name: 'John', 
      email: 'john@example.com',
      createdAt: '2024-01-15',
      profileUrl: '/users/1'  // NEW FEATURES
    }
  ]);
});
// Both versions coexist
```

---

#### 2. What are the different API versioning strategies?

**Answer:**

**1. URL Path Versioning:**
```javascript
// Most common approach
app.use('/api/v1', v1Router);
app.use('/api/v2', v2Router);
app.use('/api/latest', latestRouter);

// Example URLs
GET /api/v1/users
GET /api/v2/users
GET /api/v3/users
```

**2. Query Parameter Versioning:**
```javascript
// Version in query string
app.get('/api/users', (req, res) => {
  const version = req.query.v || '1';
  
  if (version === '1') {
    res.json(v1Response());
  } else if (version === '2') {
    res.json(v2Response());
  }
});

// Example URLs
GET /api/users?v=1
GET /api/users?v=2
GET /api/users  // defaults to v1
```

**3. Header Versioning:**
```javascript
// Custom header
app.get('/api/users', (req, res) => {
  const version = req.headers['x-api-version'] || '1';
  
  if (version === '1') return v1Response();
  if (version === '2') return v2Response();
});

// Accept header (content negotiation)
app.get('/api/users', (req, res) => {
  const accept = req.headers.accept;
  
  if (accept.includes('application/vnd.myapi.v1+json')) {
    res.json(v1Response());
  } else if (accept.includes('application/vnd.myapi.v2+json')) {
    res.json(v2Response());
  } else {
    res.json(defaultResponse());
  }
});
```

**4. Media Type Versioning:**
```javascript
// Content-Type based
app.post('/api/users', (req, res) => {
  const contentType = req.headers['content-type'];
  
  if (contentType === 'application/vnd.myapi.v1+json') {
    // Process v1 format
  } else if (contentType === 'application/vnd.myapi.v2+json') {
    // Process v2 format
  }
});
```

**5. Hostname Versioning:**
```javascript
// Different subdomains
app.get('/api/users', (req, res) => {
  const hostname = req.hostname;
  
  if (hostname === 'v1.api.example.com') {
    res.json(v1Response());
  } else if (hostname === 'v2.api.example.com') {
    res.json(v2Response());
  } else if (hostname === 'api.example.com') {
    res.json(latestResponse());
  }
});

// Example URLs
GET https://v1.api.example.com/users
GET https://v2.api.example.com/users
GET https://api.example.com/users  // latest
```

**Comparison:**

| Strategy | Pros | Cons |
|----------|------|------|
| **URL Path** | Simple, visible, cacheable | URL changes, not RESTful |
| **Query Param** | Simple, flexible | Not RESTful, caching issues |
| **Header** | Clean URLs, RESTful | Less discoverable |
| **Media Type** | RESTful, precise | Complex, less common |
| **Hostname** | Clean separation | DNS management, SSL certs |

---

#### 3. How do you implement versioning in Express?

**Answer:**

**1. Route-based versioning:**
```javascript
// routes/v1/users.js
const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  res.json({ version: 'v1', users: [] });
});

module.exports = router;

// routes/v2/users.js
const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  res.json({ 
    version: 'v2', 
    data: { users: [] },
    links: { self: '/v2/users' }
  });
});

module.exports = router;

// app.js
const v1Users = require('./routes/v1/users');
const v2Users = require('./routes/v2/users');

app.use('/api/v1/users', v1Users);
app.use('/api/v2/users', v2Users);
```

**2. Directory structure:**
```
routes/
├── v1/
│   ├── users.js
│   ├── posts.js
│   └── index.js
├── v2/
│   ├── users.js
│   ├── posts.js
│   └── index.js
└── index.js
```

**3. Version middleware:**
```javascript
// middleware/version.js
function versionRouter(versions) {
  return (req, res, next) => {
    // Extract version from URL
    const match = req.path.match(/^\/api\/(v\d+)\//);
    const version = match ? match[1] : 'v1';
    
    // Store version in request
    req.apiVersion = version;
    next();
  };
}

// Usage
app.use(versionRouter());

app.get('/api/:version/users', (req, res) => {
  if (req.apiVersion === 'v1') {
    res.json(v1Users());
  } else if (req.apiVersion === 'v2') {
    res.json(v2Users());
  }
});
```

**4. Dynamic version loading:**
```javascript
// Load all versions dynamically
const fs = require('fs');
const path = require('path');

fs.readdirSync('./routes')
  .filter(dir => dir.startsWith('v'))
  .forEach(version => {
    const versionRouter = require(`./routes/${version}`);
    app.use(`/api/${version}`, versionRouter);
  });
```

**5. Version-aware controllers:**
```javascript
// controllers/userController.js
exports.getUsers = (req, res) => {
  const version = req.apiVersion || 'v1';
  
  const responses = {
    v1: () => ({
      users: [
        { id: 1, name: 'John' }
      ]
    }),
    v2: () => ({
      data: {
        users: [
          { id: 1, name: 'John', type: 'user' }
        ]
      },
      meta: { version: 'v2' }
    })
  };
  
  res.json(responses[version]());
};
```

**6. Complete implementation:**
```javascript
// routes/index.js
const express = require('express');
const router = express.Router();

// Version routers
const v1Router = require('./v1');
const v2Router = require('./v2');
const latestRouter = require('./v2'); // Latest is v2

// Mount versions
router.use('/v1', v1Router);
router.use('/v2', v2Router);
router.use('/latest', latestRouter);

// Default to latest
router.use('/', latestRouter);

module.exports = router;

// app.js
const apiRouter = require('./routes');
app.use('/api', apiRouter);
```

---

#### 4. What are the pros and cons of URL vs header versioning?

**Answer:**

**URL Versioning (Path or Query):**

**Pros:**
1. **Simple**: Easy to understand and implement
2. **Visible**: Version is clear in URL
3. **Cacheable**: Different versions cache separately
4. **Bookmarkable**: URLs can be saved/shared
5. **Browser testable**: Works in browser address bar
6. **Logging**: Version visible in access logs

**Cons:**
1. **Not RESTful**: URLs should identify resources, not versions
2. **URL pollution**: Version info in every URL
3. **Breaking URLs**: Changing version breaks existing links
4. **Client updates**: Clients must update URLs
5. **Less elegant**: Aesthetic concern for some APIs

**Examples:**
```javascript
// Path versioning
GET /api/v1/users
GET /api/v2/users

// Query versioning
GET /api/users?v=1
GET /api/users?v=2
```

**Header Versioning:**

**Pros:**
1. **RESTful**: Clean URLs identify resources only
2. **Clean URLs**: No version clutter in URLs
3. **Flexible**: Can use Accept, Custom, or Content-Type headers
4. **Content negotiation**: Can request specific formats
5. **Backward compatible**: Default version for missing header

**Cons:**
1. **Less discoverable**: Version not visible in URL
2. **Browser testing**: Requires tools (Postman, curl)
3. **Caching complexity**: Same URL, different versions
4. **Bookmarking issues**: Saved URLs lose version context
5. **Implementation complexity**: More code to handle headers

**Examples:**
```javascript
// Custom header
GET /api/users
Headers: X-API-Version: 2

// Accept header
GET /api/users
Headers: Accept: application/vnd.myapi.v2+json

// Content-Type for POST
POST /api/users
Headers: Content-Type: application/vnd.myapi.v2+json
Body: {...}
```

**Comparison table:**

| Aspect | URL Versioning | Header Versioning |
|--------|---------------|------------------|
| **RESTfulness** | Low | High |
| **Visibility** | High | Low |
| **Caching** | Easy | Complex |
| **Browser testing** | Easy | Requires tools |
| **Implementation** | Simple | Complex |
| **URL cleanliness** | Poor | Excellent |
| **Backward compat** | Poor | Good |
| **Industry usage** | Common | Growing |

**Hybrid approach:**
```javascript
// Support both URL and header
app.get('/api/:version?/users', (req, res) => {
  // Check URL first, then header, then default
  const version = req.params.version || 
                  req.headers['x-api-version'] || 
                  'v1';
  
  if (version === 'v1') return v1Response();
  if (version === 'v2') return v2Response();
});

// Both work:
// GET /api/v1/users
// GET /api/users (with X-API-Version: 1 header)
```

**Recommendation:**
- **Public APIs**: Use URL versioning for simplicity
- **Internal APIs**: Consider header versioning for cleanliness
- **REST purists**: Use Accept header versioning
- **Practical approach**: Support both for flexibility

---

#### 5. How do you handle breaking changes in APIs?

**Answer:**

**Breaking changes** require careful management to avoid disrupting clients.

**1. Identify breaking changes:**
```javascript
// Breaking changes:
- Removing or renaming fields
- Changing field types (string → number)
- Changing required fields
- Changing authentication
- Removing endpoints
- Changing response structure

// Non-breaking changes:
- Adding new fields
- Adding new endpoints
- Adding optional parameters
- Adding new error codes
- Performance improvements
```

**2. Versioning strategy:**
```javascript
// Keep old version active
app.use('/api/v1', v1Router); // Old, stable
app.use('/api/v2', v2Router); // New, with breaking changes

// Support both for transition period
// Timeline: 6-12 months for migration
```

**3. Deprecation headers:**
```javascript
// Add deprecation warnings
app.get('/api/v1/users', (req, res) => {
  res.set({
    'Deprecation': 'true',
    'Sunset': new Date(Date.now() + 180 * 24 * 60 * 60 * 1000).toUTCString(),
    'Link': '</api/v2/users>; rel="successor-version"'
  });
  
  res.json(v1Response());
});
```

**4. Documentation:**
```javascript
// API documentation should show:
- What changed in new version
- Migration guide
- Deprecation timeline
- Examples of old vs new
```

**5. Communication plan:**
```javascript
// Notify users:
- Email announcements
- API changelog
- Dashboard notifications
- Social media updates
- In-app messages for known clients
```

**6. Migration tools:**
```javascript
// Provide migration helpers
app.get('/api/migrate/v1-to-v2', (req, res) => {
  // Convert v1 response to v2 format
  const v1Data = getV1Data();
  const v2Data = migrateV1ToV2(v1Data);
  res.json(v2Data);
});

// Or client libraries
const api = require('myapi-sdk');
api.migrateV1ToV2(oldData);
```

**7. Monitoring:**
```javascript
// Track usage of old version
app.use('/api/v1', (req, res, next) => {
  logDeprecatedUsage(req);
  next();
});

// Alert when usage drops
function monitorMigration() {
  const v1Usage = getV1Usage();
  const v2Usage = getV2Usage();
  
  if (v1Usage < 0.1 && v2Usage > 0.9) {
    // Ready to sunset v1
    scheduleSunset();
  }
}
```

**8. Graceful sunset:**
```javascript
// Phase 1: Warning (6 months)
app.use('/api/v1', addDeprecationHeaders);

// Phase 2: Rate limiting (3 months)
app.use('/api/v1', rateLimit({ max: 100 }));

// Phase 3: Return 410 Gone
app.use('/api/v1', (req, res) => {
  res.status(410).json({
    error: 'API v1 is no longer available',
    message: 'Please migrate to v2',
    migrationGuide: 'https://docs.example.com/migrate'
  });
});

// Phase 4: Remove code (after sunset)
// Delete v1 routes
```

**9. Backward compatibility layer:**
```javascript
// Support old clients with adapters
app.get('/api/v2/users', (req, res) => {
  const data = getV2Data();
  
  // Check if client wants v1 format
  if (req.headers.accept.includes('application/vnd.myapi.v1+json')) {
    // Convert v2 to v1 format
    const v1Data = convertV2ToV1(data);
    res.json(v1Data);
  } else {
    res.json(data);
  }
});
```

**10. Testing strategy:**
```javascript
// Test both versions
describe('API v1', () => {
  it('should return v1 format', () => {
    const res = await request(app).get('/api/v1/users');
    expect(res.body).toHaveProperty('users');
  });
});

describe('API v2', () => {
  it('should return v2 format', () => {
    const res = await request(app).get('/api/v2/users');
    expect(res.body).toHaveProperty('data.users');
  });
});

// Test migration
describe('Migration', () => {
  it('should convert v1 to v2 format', () => {
    const v1Data = { users: [...] };
    const v2Data = migrateV1ToV2(v1Data);
    expect(v2Data).toHaveProperty('data.users');
  });
});
```

**Best practices:**
1. **Plan ahead**: Design APIs with evolution in mind
2. **Document changes**: Clear changelogs and migration guides
3. **Communicate early**: Notify users well in advance
4. **Provide tools**: Migration scripts, SDK updates
5. **Monitor usage**: Track adoption of new version
6. **Be patient**: Allow sufficient migration time
7. **Learn from mistakes**: Improve API design based on changes

---
---

## 21. HTTP Status Codes & Headers

#### 1. What are the different categories of HTTP status codes?

**Answer:**

**HTTP status codes** are grouped into 5 categories:

**1xx Informational (100-199):**
- **100 Continue**: Client should continue request
- **101 Switching Protocols**: Server switching protocols
- **102 Processing**: Server processing request (WebDAV)

**2xx Success (200-299):**
- **200 OK**: Request succeeded
- **201 Created**: Resource created successfully
- **202 Accepted**: Request accepted for processing
- **204 No Content**: Success but no response body

**3xx Redirection (300-399):**
- **301 Moved Permanently**: Resource moved permanently
- **302 Found**: Resource temporarily moved
- **304 Not Modified**: Cached version still valid
- **307 Temporary Redirect**: Temporary redirect (preserves method)

**4xx Client Errors (400-499):**
- **400 Bad Request**: Malformed request
- **401 Unauthorized**: Authentication required
- **403 Forbidden**: Authenticated but no permission
- **404 Not Found**: Resource doesn't exist
- **409 Conflict**: Resource conflict
- **422 Unprocessable Entity**: Validation failed

**5xx Server Errors (500-599):**
- **500 Internal Server Error**: Generic server error
- **501 Not Implemented**: Method not implemented
- **502 Bad Gateway**: Invalid response from upstream
- **503 Service Unavailable**: Server overloaded/maintenance
- **504 Gateway Timeout**: Upstream server timeout

**Common status codes in REST APIs:**
```javascript
// Success
200 OK                    // GET, PUT, PATCH success
201 Created               // POST success
204 No Content            // DELETE success

// Client errors
400 Bad Request           // Invalid input
401 Unauthorized          // Missing/invalid auth
403 Forbidden             // No permission
404 Not Found             // Resource doesn't exist
409 Conflict              // Resource conflict
422 Unprocessable Entity  // Validation failed

// Server errors
500 Internal Server Error // Generic server error
503 Service Unavailable   // Maintenance/overload
```

---

#### 2. When should you use 200 vs 201 vs 204?

**Answer:**

**200 OK** - Generic success:
```javascript
// GET, PUT, PATCH success with response body
app.get('/api/users/:id', (req, res) => {
  const user = getUser(req.params.id);
  res.status(200).json(user); // 200 with data
});

app.put('/api/users/:id', (req, res) => {
  const updatedUser = updateUser(req.params.id, req.body);
  res.status(200).json(updatedUser); // 200 with updated data
});
```

**201 Created** - Resource created:
```javascript
// POST success, resource created
app.post('/api/users', (req, res) => {
  const newUser = createUser(req.body);
  
  // 201 with Location header
  res.status(201)
    .set('Location', `/api/users/${newUser.id}`)
    .json(newUser);
});

// Also for other creation operations
app.post('/api/posts', (req, res) => {
  const post = createPost(req.body);
  res.status(201).json(post);
});
```

**204 No Content** - Success, no response body:
```javascript
// DELETE success, no content to return
app.delete('/api/users/:id', (req, res) => {
  deleteUser(req.params.id);
  res.status(204).send(); // No body
});

// PUT/PATCH that doesn't return data
app.put('/api/users/:id/status', (req, res) => {
  updateStatus(req.params.id, req.body.status);
  res.status(204).send(); // Just success confirmation
});

// OPTIONS requests
app.options('/api/users', (req, res) => {
  res.set('Allow', 'GET, POST, OPTIONS');
  res.status(204).send();
});
```

**Comparison:**

| Code | When to Use | Response Body | Headers |
|------|------------|--------------|---------|
| **200** | GET, PUT, PATCH success | Yes | Optional |
| **201** | POST success (creation) | Yes | Location recommended |
| **204** | DELETE, OPTIONS, updates | No | Optional |

**Best practices:**
- Use **201** for successful resource creation
- Use **204** for successful deletions
- Use **200** for other successful operations
- Include `Location` header with **201** responses
- Don't include body with **204** responses

---

#### 3. How do you handle error status codes (400, 401, 403, 404, 500)?

**Answer:**

**400 Bad Request** - Client error:
```javascript
app.post('/api/users', (req, res) => {
  const { name, email } = req.body;
  
  if (!name || !email) {
    return res.status(400).json({
      error: 'Bad Request',
      message: 'Name and email are required'
    });
  }
  
  if (!isValidEmail(email)) {
    return res.status(400).json({
      error: 'Bad Request',
      message: 'Invalid email format'
    });
  }
  
  // Process valid request
  res.status(201).json({ id: 1, name, email });
});
```

**401 Unauthorized** - Authentication required:
```javascript
// Middleware for authentication
function authenticate(req, res, next) {
  const token = req.headers.authorization;
  
  if (!token) {
    return res.status(401).json({
      error: 'Unauthorized',
      message: 'Authentication required',
      wwwAuthenticate: 'Bearer realm="API"'
    });
  }
  
  try {
    const user = verifyToken(token);
    req.user = user;
    next();
  } catch (err) {
    res.status(401).json({
      error: 'Unauthorized',
      message: 'Invalid token'
    });
  }
}

// Protected route
app.get('/api/profile', authenticate, (req, res) => {
  res.json({ user: req.user });
});
```

**403 Forbidden** - No permission:
```javascript
// Authorization middleware
function authorize(role) {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ error: 'Unauthorized' });
    }
    
    if (req.user.role !== role) {
      return res.status(403).json({
        error: 'Forbidden',
        message: `Requires ${role} role`
      });
    }
    
    next();
  };
}

// Admin-only route
app.get('/api/admin/stats', 
  authenticate, 
  authorize('admin'),
  (req, res) => {
    res.json({ stats: 'admin data' });
  }
);
```

**404 Not Found** - Resource doesn't exist:
```javascript
// Specific resource not found
app.get('/api/users/:id', (req, res) => {
  const user = getUser(req.params.id);
  
  if (!user) {
    return res.status(404).json({
      error: 'Not Found',
      message: `User ${req.params.id} not found`
    });
  }
  
  res.json(user);
});

// Catch-all 404 handler
app.use('/api/*', (req, res) => {
  res.status(404).json({
    error: 'Not Found',
    message: `Cannot ${req.method} ${req.originalUrl}`
  });
});

// General 404
app.use((req, res) => {
  res.status(404).send('Page not found');
});
```

**500 Internal Server Error** - Server error:
```javascript
// Database error
app.get('/api/users', async (req, res) => {
  try {
    const users = await User.find();
    res.json(users);
  } catch (err) {
    console.error('Database error:', err);
    
    res.status(500).json({
      error: 'Internal Server Error',
      message: 'Something went wrong',
      // Only in development
      ...(process.env.NODE_ENV === 'development' && { stack: err.stack })
    });
  }
});

// Global error handler
app.use((err, req, res, next) => {
  console.error('Unhandled error:', err);
  
  res.status(500).json({
    error: 'Internal Server Error',
    message: 'An unexpected error occurred'
  });
});
```

**Error handling best practices:**
1. **Be specific**: Use appropriate status codes
2. **Include messages**: Helpful error messages
3. **Log errors**: Server-side logging
4. **Hide details**: Don't expose stack traces in production
5. **Consistent format**: Standard error response structure

---

#### 4. What are important HTTP headers for APIs?

**Answer:**

**Request headers (client → server):**

**1. Authentication:**
```javascript
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
Authorization: Basic dXNlcjpwYXNzd29yZA==
```

**2. Content negotiation:**
```javascript
Accept: application/json
Accept: application/xml
Accept: text/html
Accept: application/vnd.myapi.v1+json
```

**3. Content type:**
```javascript
Content-Type: application/json
Content-Type: application/x-www-form-urlencoded
Content-Type: multipart/form-data
```

**4. Caching:**
```javascript
If-None-Match: "abc123"
If-Modified-Since: Wed, 15 Jan 2024 10:30:00 GMT
```

**5. CORS:**
```javascript
Origin: https://example.com
Access-Control-Request-Method: POST
Access-Control-Request-Headers: Content-Type
```

**Response headers (server → client):**

**1. Content type:**
```javascript
Content-Type: application/json; charset=utf-8
Content-Type: text/html; charset=utf-8
```

**2. Caching:**
```javascript
Cache-Control: public, max-age=3600
Cache-Control: no-cache, no-store, must-revalidate
ETag: "abc123"
Last-Modified: Wed, 15 Jan 2024 10:30:00 GMT
```

**3. CORS:**
```javascript
Access-Control-Allow-Origin: *
Access-Control-Allow-Origin: https://example.com
Access-Control-Allow-Methods: GET, POST, PUT, DELETE
Access-Control-Allow-Headers: Content-Type, Authorization
Access-Control-Allow-Credentials: true
Access-Control-Max-Age: 86400
```

**4. Security:**
```javascript
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
X-XSS-Protection: 1; mode=block
Content-Security-Policy: default-src 'self'
```

**5. Rate limiting:**
```javascript
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 99
X-RateLimit-Reset: 1609459200
Retry-After: 3600
```

**6. Pagination:**
```javascript
Link: </api/users?page=2>; rel="next",
      </api/users?page=5>; rel="last"
X-Total-Count: 150
X-Page: 2
X-Per-Page: 20
```

**7. Deprecation:**
```javascript
Deprecation: true
Sunset: Wed, 15 Jul 2024 10:30:00 GMT
Link: </api/v2/users>; rel="successor-version"
```

---

#### 5. How do you set custom headers in Express?

**Answer:**

**Setting single header:**
```javascript
res.set('X-Custom-Header', 'value');
res.header('X-Another-Header', 'another-value');
```

**Setting multiple headers:**
```javascript
res.set({
  'X-Custom-Header': 'value1',
  'X-Another-Header': 'value2',
  'Content-Type': 'application/json'
});
```

**Common custom headers:**

**1. API version:**
```javascript
app.use((req, res, next) => {
  res.set('X-API-Version', '1.0.0');
  next();
});
```

**2. Request ID for tracing:**
```javascript
app.use((req, res, next) => {
  const requestId = generateId();
  req.requestId = requestId;
  res.set('X-Request-ID', requestId);
  next();
});
```

**3. Response time:**
```javascript
app.use((req, res, next) => {
  const start = Date.now();
  
  res.on('finish', () => {
    const duration = Date.now() - start;
    res.set('X-Response-Time', `${duration}ms`);
  });
  
  next();
});
```

**4. Pagination headers:**
```javascript
app.get('/api/users', (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const total = 150;
  
  // Set pagination headers
  res.set({
    'X-Total-Count': total,
    'X-Page': page,
    'X-Per-Page': limit,
    'X-Total-Pages': Math.ceil(total / limit)
  });
  
  res.json(users);
});
```

**5. CORS headers:**
```javascript
app.use((req, res, next) => {
  res.set({
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    'Access-Control-Max-Age': '86400'
  });
  
  if (req.method === 'OPTIONS') {
    return res.status(204).send();
  }
  
  next();
});
```

**6. Security headers:**
```javascript
const helmet = require('helmet');
app.use(helmet());

// Or custom security headers
app.use((req, res, next) => {
  res.set({
    'X-Content-Type-Options': 'nosniff',
    'X-Frame-Options': 'DENY',
    'X-XSS-Protection': '1; mode=block',
    'Strict-Transport-Security': 'max-age=31536000; includeSubDomains'
  });
  next();
});
```

**7. Cache headers:**
```javascript
app.get('/api/static-data', (req, res) => {
  // Cache for 1 hour
  res.set('Cache-Control', 'public, max-age=3600');
  res.json({ data: 'static value' });
});

app.get('/api/dynamic-data', (req, res) => {
  // Don't cache
  res.set('Cache-Control', 'no-cache, no-store, must-revalidate');
  res.json({ data: 'dynamic value' });
});
```

**8. Appending headers:**
```javascript
// Append to existing header
res.append('Set-Cookie', 'sessionId=abc123');
res.append('Set-Cookie', 'theme=dark');

// Remove header
res.removeHeader('X-Powered-By');
```

**Best practices:**
1. **Use standard headers** when possible
2. **Prefix custom headers** with `X-`
3. **Document custom headers** in API docs
4. **Be consistent** across endpoints
5. **Consider CORS** for custom headers

---
---

## 22. Authentication Fundamentals

#### 1. What is the difference between authentication and authorization?

**Answer:**

**Authentication** verifies identity (WHO you are):
- Confirms user is who they claim to be
- Examples: Login with username/password, OAuth, biometrics
- Answers: "Is this user valid?"

**Authorization** verifies permissions (WHAT you can do):
- Determines what authenticated user can access
- Examples: Role-based access, permissions, scopes
- Answers: "Can this user perform this action?"

**Visual comparison:**
```
Authentication → Authorization
    ↓                ↓
  "Who are you?" → "What can you do?"
```

**Code example:**
```javascript
// Authentication - verify identity
function authenticate(req, res, next) {
  const token = req.headers.authorization;
  
  if (!token) {
    return res.status(401).json({ error: 'Authentication required' });
  }
  
  try {
    const user = verifyToken(token); // Verify identity
    req.user = user; // User is now authenticated
    next();
  } catch (err) {
    res.status(401).json({ error: 'Invalid credentials' });
  }
}

// Authorization - check permissions
function authorize(requiredRole) {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ error: 'Authentication required' });
    }
    
    if (req.user.role !== requiredRole) {
      return res.status(403).json({ 
        error: 'Forbidden',
        message: `Requires ${requiredRole} role` 
      });
    }
    
    next(); // User is authorized
  };
}

// Usage
app.get('/api/admin/dashboard', 
  authenticate,  // First: verify identity
  authorize('admin'),  // Then: check permissions
  (req, res) => {
    res.json({ data: 'Admin dashboard' });
  }
);
```

**Real-world analogy:**
- **Authentication**: Showing ID to enter building (proving identity)
- **Authorization**: Having keycard for specific floors (access rights)

**Common patterns:**
1. **Authentication first, then authorization**
2. **401 Unauthorized** = Authentication failed
3. **403 Forbidden** = Authorization failed (authenticated but no permission)

---

#### 2. What are the common authentication methods?

**Answer:**

**1. Password-based:**
```javascript
// Basic username/password
app.post('/api/login', (req, res) => {
  const { username, password } = req.body;
  
  // Verify credentials
  const user = users.find(u => 
    u.username === username && 
    verifyPassword(password, u.passwordHash)
  );
  
  if (!user) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }
  
  // Create session or token
  const token = createToken(user);
  res.json({ token });
});
```

**2. Token-based (JWT):**
```javascript
// JSON Web Tokens
const jwt = require('jsonwebtoken');

app.post('/api/login', (req, res) => {
  const { email, password } = req.body;
  const user = authenticateUser(email, password);
  
  // Create JWT
  const token = jwt.sign(
    { userId: user.id, role: user.role },
    process.env.JWT_SECRET,
    { expiresIn: '1h' }
  );
  
  res.json({ token });
});
```

**3. Session-based:**
```javascript
const session = require('express-session');

app.use(session({
  secret: 'your-secret-key',
  resave: false,
  saveUninitialized: false
}));

app.post('/api/login', (req, res) => {
  const { username, password } = req.body;
  const user = authenticateUser(username, password);
  
  // Store in session
  req.session.userId = user.id;
  req.session.role = user.role;
  
  res.json({ message: 'Logged in' });
});
```

**4. OAuth 2.0 / OpenID Connect:**
```javascript
// Third-party authentication (Google, Facebook, etc.)
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;

passport.use(new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: '/api/auth/google/callback'
  },
  (accessToken, refreshToken, profile, done) => {
    // Find or create user from profile
    const user = findOrCreateUser(profile);
    done(null, user);
  }
));

app.get('/api/auth/google', passport.authenticate('google', {
  scope: ['profile', 'email']
}));

app.get('/api/auth/google/callback',
  passport.authenticate('google', { failureRedirect: '/login' }),
  (req, res) => {
    res.redirect('/dashboard');
  }
);
```

**5. API Keys:**
```javascript
// Simple API key authentication
function apiKeyAuth(req, res, next) {
  const apiKey = req.headers['x-api-key'];
  
  if (!apiKey) {
    return res.status(401).json({ error: 'API key required' });
  }
  
  const client = validateApiKey(apiKey);
  if (!client) {
    return res.status(401).json({ error: 'Invalid API key' });
  }
  
  req.client = client;
  next();
}

app.use('/api', apiKeyAuth);
```

**6. Multi-factor Authentication (MFA):**
```javascript
// Two-step authentication
app.post('/api/login', (req, res) => {
  const { username, password } = req.body;
  const user = authenticateUser(username, password);
  
  if (user.mfaEnabled) {
    // Send OTP via email/SMS
    const otp = generateOTP();
    sendOTP(user.email, otp);
    
    // Store temporary session for MFA
    req.session.mfaPending = {
      userId: user.id,
      otp: otp
    };
    
    return res.json({ requiresMFA: true });
  }
  
  // Regular login
  const token = createToken(user);
  res.json({ token });
});

app.post('/api/verify-mfa', (req, res) => {
  const { otp } = req.body;
  
  if (!req.session.mfaPending) {
    return res.status(400).json({ error: 'No MFA pending' });
  }
  
  if (req.session.mfaPending.otp !== otp) {
    return res.status(401).json({ error: 'Invalid OTP' });
  }
  
  // MFA successful
  const user = getUser(req.session.mfaPending.userId);
  const token = createToken(user);
  
  delete req.session.mfaPending;
  res.json({ token });
});
```

**Comparison:**

| Method | Use Case | Complexity | Stateless |
|--------|----------|------------|-----------|
| **Password** | Simple apps | Low | No |
| **JWT** | APIs, SPAs | Medium | Yes |
| **Session** | Traditional web apps | Medium | No |
| **OAuth** | Third-party login | High | Depends |
| **API Keys** | Server-to-server | Low | Yes |
| **MFA** | High security | High | Depends |

---

#### 3. How does session-based authentication work?

**Answer:**

**Session-based authentication** uses server-side sessions to track authenticated users.

**How it works:**
1. **User logs in** with credentials
2. **Server creates session** with unique ID
3. **Session ID sent to client** as cookie
4. **Client sends cookie** with each request
5. **Server validates session** on each request

**Implementation:**
```javascript
const express = require('express');
const session = require('express-session');
const app = express();

// Configure session middleware
app.use(session({
  secret: 'your-secret-key', // Sign session ID cookie
  resave: false,             // Don't save session if unmodified
  saveUninitialized: false,  // Don't create session until something stored
  cookie: {
    secure: process.env.NODE_ENV === 'production', // HTTPS only in production
    httpOnly: true,    // Not accessible via JavaScript
    maxAge: 24 * 60 * 60 * 1000 // 24 hours
  }
}));

// Login route
app.post('/api/login', (req, res) => {
  const { username, password } = req.body;
  
  // Verify credentials
  const user = authenticateUser(username, password);
  if (!user) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }
  
  // Store user info in session
  req.session.userId = user.id;
  req.session.username = user.username;
  req.session.role = user.role;
  req.session.loggedInAt = new Date();
  
  res.json({ message: 'Logged in successfully' });
});

// Protected route
app.get('/api/profile', (req, res) => {
  // Check if user is authenticated
  if (!req.session.userId) {
    return res.status(401).json({ error: 'Not authenticated' });
  }
  
  // Get user data (could fetch from DB)
  res.json({
    userId: req.session.userId,
    username: req.session.username,
    role: req.session.role,
    loggedInAt: req.session.loggedInAt
  });
});

// Logout route
app.post('/api/logout', (req, res) => {
  // Destroy session
  req.session.destroy((err) => {
    if (err) {
      return res.status(500).json({ error: 'Logout failed' });
    }
    
    // Clear session cookie
    res.clearCookie('connect.sid');
    res.json({ message: 'Logged out successfully' });
  });
});
```

**Session store options:**

**1. Memory store (default - not for production):**
```javascript
// In-memory - sessions lost on server restart
app.use(session({
  secret: 'secret',
  resave: false,
  saveUninitialized: false
}));
```

**2. Redis store (recommended for production):**
```javascript
const RedisStore = require('connect-redis')(session);
const redis = require('redis');

const redisClient = redis.createClient({
  host: 'localhost',
  port: 6379
});

app.use(session({
  store: new RedisStore({ client: redisClient }),
  secret: 'secret',
  resave: false,
  saveUninitialized: false
}));
```

**3. MongoDB store:**
```javascript
const MongoStore = require('connect-mongo');

app.use(session({
  store: MongoStore.create({
    mongoUrl: 'mongodb://localhost/sessions',
    ttl: 24 * 60 * 60 // 24 hours
  }),
  secret: 'secret',
  resave: false,
  saveUninitialized: false
}));
```

**Session flow:**
```
1. Client → POST /login (credentials)
2. Server → Creates session, sets cookie
3. Client → GET /profile (with session cookie)
4. Server → Validates session, returns data
5. Client → POST /logout
6. Server → Destroys session, clears cookie
```

**Advantages:**
- Simple to implement
- Server controls sessions
- Easy to invalidate sessions
- Works well with server-rendered apps

**Disadvantages:**
- Not scalable by default (need external store)
- Not stateless (server stores session data)
- CORS/cookie issues with mobile/SPA
- Session fixation attacks

---

#### 4. How does token-based authentication work?

**Answer:**

**Token-based authentication** uses self-contained tokens (like JWT) that clients send with each request.

**How it works:**
1. **User logs in** with credentials
2. **Server creates token** with user data and signature
3. **Token sent to client** (usually in response body)
4. **Client stores token** (localStorage, cookies, etc.)
5. **Client sends token** with each request (usually in Authorization header)
6. **Server validates token** on each request

**Implementation:**
```javascript
const jwt = require('jsonwebtoken');

// Login - create token
app.post('/api/login', (req, res) => {
  const { email, password } = req.body;
  
  // Verify credentials
  const user = authenticateUser(email, password);
  if (!user) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }
  
  // Create JWT token
  const token = jwt.sign(
    {
      userId: user.id,
      email: user.email,
      role: user.role
    },
    process.env.JWT_SECRET,
    { expiresIn: '1h' } // Token expires in 1 hour
  );
  
  // Optionally set as cookie
  res.cookie('token', token, {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    maxAge: 60 * 60 * 1000 // 1 hour
  });
  
  res.json({ 
    token, // Also send in response for client storage
    user: {
      id: user.id,
      email: user.email,
      role: user.role
    }
  });
});

// Authentication middleware
function authenticateToken(req, res, next) {
  // Get token from header or cookie
  const token = req.headers.authorization?.split(' ')[1] || 
                req.cookies.token;
  
  if (!token) {
    return res.status(401).json({ error: 'Access token required' });
  }
  
  try {
    // Verify and decode token
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded; // Attach user data to request
    next();
  } catch (err) {
    if (err.name === 'TokenExpiredError') {
      return res.status(401).json({ 
        error: 'Token expired',
        code: 'TOKEN_EXPIRED'
      });
    }
    
    return res.status(401).json({ 
      error: 'Invalid token',
      code: 'INVALID_TOKEN'
    });
  }
}

// Protected route
app.get('/api/profile', authenticateToken, (req, res) => {
  // User data is already in req.user from token
  res.json({
    user: req.user,
    message: 'Protected data'
  });
});

// Logout (client-side - just discard token)
app.post('/api/logout', (req, res) => {
  // Clear cookie if using cookie storage
  res.clearCookie('token');
  
  res.json({ message: 'Logged out successfully' });
  // Note: Token is still valid until expiration
  // For immediate invalidation, need token blacklist
});
```

**Token storage options:**

**1. LocalStorage (SPAs):**
```javascript
// Client-side (React example)
const login = async (credentials) => {
  const response = await fetch('/api/login', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(credentials)
  });
  
  const data = await response.json();
  localStorage.setItem('token', data.token); // Store token
  
  // Use in requests
  const profileResponse = await fetch('/api/profile', {
    headers: {
      'Authorization': `Bearer ${localStorage.getItem('token')}`
    }
  });
};
```

**2. Cookies (httpOnly for security):**
```javascript
// Server sets httpOnly cookie
res.cookie('token', token, {
  httpOnly: true,    // Not accessible via JavaScript
  secure: true,      // HTTPS only
  sameSite: 'strict' // CSRF protection
});

// Browser automatically sends cookie
// No client-side code needed for token handling
```

**3. Authorization header:**
```javascript
// Client sends token in header
fetch('/api/protected', {
  headers: {
    'Authorization': `Bearer ${token}`
  }
});
```

**Advantages:**
- Stateless (server doesn't store session data)
- Scalable (no session storage needed)
- Works well with APIs and SPAs
- Can contain user data (reduces DB queries)
- Easy to implement with microservices

**Disadvantages:**
- Token size larger than session ID
- Cannot easily invalidate tokens (need blacklist)
- Security concerns with client-side storage
- Token expiration management needed

---

#### 5. What is the difference between stateful and stateless authentication?

**Answer:**

**Stateful authentication** (Sessions):
- Server stores authentication state
- Client sends session identifier
- Server validates against stored session
- Example: Traditional session-based auth

**Stateless authentication** (Tokens):
- No server-side state
- Token contains all needed information
- Server validates token signature
- Example: JWT-based auth

**Comparison:**

| Aspect | Stateful (Sessions) | Stateless (Tokens) |
|--------|-------------------|-------------------|
| **Server storage** | Required (session store) | Not required |
| **Scalability** | Needs shared session store | Easy to scale |
| **Performance** | DB/Redis lookup each request | Token verification only |
| **Token size** | Small session ID | Larger (contains data) |
| **Invalidation** | Easy (delete session) | Hard (need blacklist) |
| **Mobile/SPA** | Cookie issues | Works well |
| **Microservices** | Complex (shared session) | Easy (self-contained) |

**Stateful example (Sessions):**
```javascript
// Server stores session data
app.use(session({
  store: new RedisStore({ client: redisClient }),
  secret: 'secret'
}));

app.post('/login', (req, res) => {
  // Store in server-side session
  req.session.userId = user.id;
  req.session.role = user.role;
  
  // Send only session ID to client
  res.json({ message: 'Logged in' });
  // Cookie: connect.sid=abc123
});

app.get('/profile', (req, res) => {
  // Server looks up session
  if (!req.session.userId) {
    return res.status(401).send('Unauthorized');
  }
  
  // May need DB lookup for user data
  const user = getUserFromDB(req.session.userId);
  res.json(user);
});
```

**Stateless example (JWT):**
```javascript
app.post('/login', (req, res) => {
  // Create self-contained token
  const token = jwt.sign(
    { userId: user.id, role: user.role },
    'secret',
    { expiresIn: '1h' }
  );
  
  // Send full token to client
  res.json({ token });
  // Token contains: header.payload.signature
});

app.get('/profile', authenticateToken, (req, res) => {
  // User data from token, no DB lookup needed
  res.json({ user: req.user });
  // req.user = { userId: 123, role: 'user' }
});

function authenticateToken(req, res, next) {
  const token = req.headers.authorization?.split(' ')[1];
  const decoded = jwt.verify(token, 'secret'); // Verify signature
  req.user = decoded; // Attach user data
  next();
}
```

**Hybrid approach:**
```javascript
// Stateless tokens with optional blacklist for invalidation
const tokenBlacklist = new Set();

app.post('/logout', (req, res) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (token) {
    // Add to blacklist (store in Redis for scalability)
    tokenBlacklist.add(token);
    
    // Set expiration for blacklist entry (match token expiry)
    setTimeout(() => {
      tokenBlacklist.delete(token);
    }, 60 * 60 * 1000); // 1 hour
  }
  
  res.json({ message: 'Logged out' });
});

function authenticateToken(req, res, next) {
  const token = req.headers.authorization?.split(' ')[1];
  
  // Check blacklist first
  if (tokenBlacklist.has(token)) {
    return res.status(401).json({ error: 'Token revoked' });
  }
  
  // Then verify token
  const decoded = jwt.verify(token, 'secret');
  req.user = decoded;
  next();
}
```

**Choosing between stateful and stateless:**

**Choose stateful when:**
- Need immediate session invalidation
- Working with traditional web apps
- Have control over client (cookies work)
- Using server-side rendering

**Choose stateless when:**
- Building APIs for mobile/SPA clients
- Need horizontal scalability
- Working with microservices
- Want to reduce database load

**Modern trend**: Stateless JWT for APIs, with refresh tokens for better security.

---
---

## 23. JWT (JSON Web Tokens)

#### 1. What is JWT and how does it work?

**Answer:**

**JWT** (JSON Web Token) is a compact, URL-safe token format for securely transmitting information between parties.

**How JWT works:**
1. **Client authenticates** with credentials
2. **Server creates JWT** with user data and signs it
3. **JWT sent to client** (in response)
4. **Client stores JWT** and sends with requests
5. **Server verifies JWT** signature and extracts data

**JWT structure:** `header.payload.signature`

**Example JWT:**
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.        # Header (base64 encoded)
eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.  # Payload
SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c  # Signature
```

**Basic JWT flow:**
```javascript
const jwt = require('jsonwebtoken');

// 1. Create JWT on login
app.post('/api/login', (req, res) => {
  const { email, password } = req.body;
  const user = authenticateUser(email, password);
  
  // Create JWT with user data
  const token = jwt.sign(
    {
      userId: user.id,
      email: user.email,
      role: user.role
    },
    process.env.JWT_SECRET,
    { expiresIn: '15m' } // Short-lived access token
  );
  
  res.json({ token });
});

// 2. Verify JWT on protected routes
function authenticateJWT(req, res, next) {
  const authHeader = req.headers.authorization;
  
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ error: 'No token provided' });
  }
  
  const token = authHeader.split(' ')[1];
  
  try {
    // Verify signature and decode
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded; // Attach user data to request
    next();
  } catch (err) {
    if (err.name === 'TokenExpiredError') {
      return res.status(401).json({ error: 'Token expired' });
    }
    return res.status(403).json({ error: 'Invalid token' });
  }
}

// 3. Use in protected route
app.get('/api/profile', authenticateJWT, (req, res) => {
  // User data from JWT, no DB query needed
  res.json({ user: req.user });
});
```

**JWT advantages:**
- **Stateless**: No server-side storage needed
- **Self-contained**: User data in token
- **Verifiable**: Signature ensures integrity
- **Standardized**: RFC 7519 standard
- **Flexible**: Can contain any JSON data

---

#### 2. What are the parts of a JWT?

**Answer:**

**JWT has 3 parts separated by dots:** `header.payload.signature`

**1. Header:**
```json
{
  "alg": "HS256",     // Algorithm (HMAC SHA-256)
  "typ": "JWT"        // Type (JWT)
}
// Base64Url encoded: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9
```

**2. Payload (claims):**
```json
{
  "sub": "1234567890",        // Subject (user ID) - registered claim
  "name": "John Doe",         // Custom claim
  "admin": true,              // Custom claim
  "iat": 1516239022,          // Issued at - registered claim
  "exp": 1516239022           // Expiration - registered claim
}
// Base64Url encoded: eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ
```

**3. Signature:**
```javascript
// Created by signing header + payload with secret
HMACSHA256(
  base64UrlEncode(header) + "." + base64UrlEncode(payload),
  secret
)
// Result: SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
```

**Registered claims (standard fields):**
- `iss` (issuer): Who issued the token
- `sub` (subject): Who the token is about
- `aud` (audience): Who the token is for
- `exp` (expiration): When token expires (timestamp)
- `nbf` (not before): Token not valid before (timestamp)
- `iat` (issued at): When token was issued (timestamp)
- `jti` (JWT ID): Unique identifier for token

**Public claims:** Custom claims that should be registered in IANA registry

**Private claims:** Custom claims for specific use

**Example with all parts:**
```javascript
const jwt = require('jsonwebtoken');

// Create JWT with various claims
const token = jwt.sign(
  {
    // Registered claims
    iss: 'my-api-server',
    sub: 'user-123',
    aud: 'api-client',
    exp: Math.floor(Date.now() / 1000) + (60 * 15), // 15 minutes
    iat: Math.floor(Date.now() / 1000),
    jti: 'unique-token-id',
    
    // Public claims (if registered)
    // Private claims
    userId: 123,
    email: 'john@example.com',
    roles: ['user', 'editor'],
    permissions: ['read:profile', 'write:posts']
  },
  process.env.JWT_SECRET,
  { algorithm: 'HS256' }
);

console.log('JWT parts:');
const parts = token.split('.');
console.log('Header:', Buffer.from(parts[0], 'base64').toString());
console.log('Payload:', Buffer.from(parts[1], 'base64').toString());
console.log('Signature:', parts[2]);
```

**Decoding JWT (without verification):**
```javascript
// Decode to see payload (doesn't verify signature)
function decodeJWT(token) {
  const parts = token.split('.');
  
  if (parts.length !== 3) {
    throw new Error('Invalid JWT format');
  }
  
  const header = JSON.parse(Buffer.from(parts[0], 'base64').toString());
  const payload = JSON.parse(Buffer.from(parts[1], 'base64').toString());
  
  return { header, payload };
}

// Usage
const token = 'eyJhbGciOiJIUzI1NiIs...';
const decoded = decodeJWT(token);
console.log('Header:', decoded.header);
console.log('Payload:', decoded.payload);
// WARNING: This doesn't verify the signature!
```

**Verifying JWT (with signature check):**
```javascript
// Proper verification
function verifyJWT(token, secret) {
  try {
    const decoded = jwt.verify(token, secret);
    return { valid: true, payload: decoded };
  } catch (err) {
    return { 
      valid: false, 
      error: err.message,
      expired: err.name === 'TokenExpiredError'
    };
  }
}
```

---

#### 3. How do you implement JWT authentication in Express?

**Answer:**

**Complete JWT authentication implementation:**

**1. Setup and dependencies:**
```javascript
const express = require('express');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const app = express();

app.use(express.json());

// In production, use environment variables
const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key';
const JWT_REFRESH_SECRET = process.env.JWT_REFRESH_SECRET || 'your-refresh-secret';
```

**2. User model (simplified):**
```javascript
// In-memory user store for example
const users = [
  {
    id: 1,
    email: 'john@example.com',
    passwordHash: '$2b$10$...', // bcrypt hash
    role: 'user',
    refreshToken: null
  }
];

// Helper to find user
function findUserByEmail(email) {
  return users.find(user => user.email === email);
}
```

**3. Registration endpoint:**
```javascript
app.post('/api/register', async (req, res) => {
  const { email, password } = req.body;
  
  // Validate input
  if (!email || !password) {
    return res.status(400).json({ error: 'Email and password required' });
  }
  
  // Check if user exists
  if (findUserByEmail(email)) {
    return res.status(409).json({ error: 'User already exists' });
  }
  
  try {
    // Hash password
    const passwordHash = await bcrypt.hash(password, 10);
    
    // Create user
    const user = {
      id: users.length + 1,
      email,
      passwordHash,
      role: 'user',
      refreshToken: null,
      createdAt: new Date()
    };
    
    users.push(user);
    
    // Create tokens
    const accessToken = generateAccessToken(user);
    const refreshToken = generateRefreshToken(user);
    
    // Store refresh token (in DB in real app)
    user.refreshToken = refreshToken;
    
    res.status(201).json({
      message: 'User registered successfully',
      accessToken,
      refreshToken,
      user: {
        id: user.id,
        email: user.email,
        role: user.role
      }
    });
  } catch (err) {
    res.status(500).json({ error: 'Registration failed' });
  }
});
```

**4. Login endpoint:**
```javascript
app.post('/api/login', async (req, res) => {
  const { email, password } = req.body;
  
  // Find user
  const user = findUserByEmail(email);
  if (!user) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }
  
  // Verify password
  const validPassword = await bcrypt.compare(password, user.passwordHash);
  if (!validPassword) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }
  
  // Generate tokens
  const accessToken = generateAccessToken(user);
  const refreshToken = generateRefreshToken(user);
  
  // Store refresh token
  user.refreshToken = refreshToken;
  
  res.json({
    accessToken,
    refreshToken,
    user: {
      id: user.id,
      email: user.email,
      role: user.role
    }
  });
});
```

**5. Token generation helpers:**
```javascript
function generateAccessToken(user) {
  return jwt.sign(
    {
      userId: user.id,
      email: user.email,
      role: user.role
    },
    JWT_SECRET,
    { expiresIn: '15m' } // Short-lived
  );
}

function generateRefreshToken(user) {
  return jwt.sign(
    {
      userId: user.id,
      type: 'refresh'
    },
    JWT_REFRESH_SECRET,
    { expiresIn: '7d' } // Long-lived
  );
}
```

**6. Authentication middleware:**
```javascript
function authenticateToken(req, res, next) {
  const authHeader = req.headers.authorization;
  const token = authHeader && authHeader.split(' ')[1];
  
  if (!token) {
    return res.status(401).json({ error: 'Access token required' });
  }
  
  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) {
      if (err.name === 'TokenExpiredError') {
        return res.status(401).json({ 
          error: 'Token expired',
          code: 'TOKEN_EXPIRED'
        });
      }
      return res.status(403).json({ error: 'Invalid token' });
    }
    
    req.user = user;
    next();
  });
}
```

**7. Protected routes:**
```javascript
// Get current user profile
app.get('/api/profile', authenticateToken, (req, res) => {
  res.json({
    user: req.user,
    message: 'Protected profile data'
  });
});

// Admin-only route
app.get('/api/admin', authenticateToken, (req, res) => {
  if (req.user.role !== 'admin') {
    return res.status(403).json({ error: 'Admin access required' });
  }
  
  res.json({ message: 'Admin dashboard' });
});
```

**8. Token refresh endpoint:**
```javascript
app.post('/api/refresh', (req, res) => {
  const { refreshToken } = req.body;
  
  if (!refreshToken) {
    return res.status(400).json({ error: 'Refresh token required' });
  }
  
  // Verify refresh token
  jwt.verify(refreshToken, JWT_REFRESH_SECRET, (err, decoded) => {
    if (err) {
      return res.status(403).json({ error: 'Invalid refresh token' });
    }
    
    // Check if token type is refresh
    if (decoded.type !== 'refresh') {
      return res.status(403).json({ error: 'Invalid token type' });
    }
    
    // Find user
    const user = users.find(u => u.id === decoded.userId);
    if (!user || user.refreshToken !== refreshToken) {
      return res.status(403).json({ error: 'Invalid refresh token' });
    }
    
    // Generate new access token
    const newAccessToken = generateAccessToken(user);
    
    res.json({
      accessToken: newAccessToken
    });
  });
});
```

**9. Logout endpoint:**
```javascript
app.post('/api/logout', authenticateToken, (req, res) => {
  // Find user and clear refresh token
  const user = users.find(u => u.id === req.user.userId);
  if (user) {
    user.refreshToken = null;
  }
  
  res.json({ message: 'Logged out successfully' });
});
```

**10. Error handling middleware:**
```javascript
app.use((err, req, res, next) => {
  if (err.name === 'JsonWebTokenError') {
    return res.status(401).json({ error: 'Invalid token' });
  }
  
  if (err.name === 'TokenExpiredError') {
    return res.status(401).json({ error: 'Token expired' });
  }
  
  console.error(err);
  res.status(500).json({ error: 'Internal server error' });
});
```

---

#### 4. What are access tokens vs refresh tokens?

**Answer:**

**Access Token:**
- Short-lived (minutes/hours)
- Used for API access
- Contains user claims
- Sent with every request
- Stored in memory or secure storage

**Refresh Token:**
- Long-lived (days/weeks/months)
- Used to get new access tokens
- Minimal claims (user ID, type)
- Stored securely (httpOnly cookie, secure storage)
- Not sent with regular requests

**Comparison:**

| Aspect | Access Token | Refresh Token |
|--------|-------------|--------------|
| **Lifetime** | Short (15min-1h) | Long (7d-30d) |
| **Purpose** | API access | Get new access tokens |
| **Claims** | Full user data | Minimal (user ID) |
| **Storage** | Memory, localStorage | httpOnly cookie, secure storage |
| **Frequency** | Every request | Only for refresh |
| **Security risk** | Medium (short-lived) | High (long-lived) |

**Implementation:**
```javascript
// Generate tokens with different lifetimes
function generateTokens(user) {
  // Access token - short-lived
  const accessToken = jwt.sign(
    {
      userId: user.id,
      email: user.email,
      role: user.role
    },
    process.env.ACCESS_TOKEN_SECRET,
    { expiresIn: '15m' } // 15 minutes
  );
  
  // Refresh token - long-lived
  const refreshToken = jwt.sign(
    {
      userId: user.id,
      type: 'refresh' // Identify as refresh token
    },
    process.env.REFRESH_TOKEN_SECRET,
    { expiresIn: '7d' } // 7 days
  );
  
  return { accessToken, refreshToken };
}

// Store refresh token securely (server-side)
async function storeRefreshToken(userId, refreshToken) {
  // Store in database with user association
  await db.refreshTokens.create({
    userId,
    token: refreshToken,
    expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000)
  });
}

// Refresh token endpoint
app.post('/api/refresh', async (req, res) => {
  const { refreshToken } = req.body;
  
  if (!refreshToken) {
    return res.status(400).json({ error: 'Refresh token required' });
  }
  
  try {
    // Verify refresh token
    const decoded = jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET);
    
    // Check if it's a refresh token
    if (decoded.type !== 'refresh') {
      return res.status(403).json({ error: 'Invalid token type' });
    }
    
    // Check if token exists in database (not revoked)
    const storedToken = await db.refreshTokens.findOne({
      where: { 
        token: refreshToken,
        userId: decoded.userId,
        revoked: false
      }
    });
    
    if (!storedToken) {
      return res.status(403).json({ error: 'Token revoked or not found' });
    }
    
    // Get user
    const user = await db.users.findByPk(decoded.userId);
    if (!user) {
      return res.status(403).json({ error: 'User not found' });
    }
    
    // Generate new access token
    const newAccessToken = jwt.sign(
      {
        userId: user.id,
        email: user.email,
        role: user.role
      },
      process.env.ACCESS_TOKEN_SECRET,
      { expiresIn: '15m' }
    );
    
    res.json({ accessToken: newAccessToken });
  } catch (err) {
    if (err.name === 'TokenExpiredError') {
      // Clean up expired token
      await db.refreshTokens.destroy({
        where: { token: refreshToken }
      });
      
      return res.status(403).json({ 
        error: 'Refresh token expired',
        code: 'REFRESH_TOKEN_EXPIRED'
      });
    }
    
    res.status(403).json({ error: 'Invalid refresh token' });
  }
});
```

**Token flow:**
```
1. Login → Returns {accessToken, refreshToken}
2. API request → Header: Bearer {accessToken}
3. Token expires → 401 with TOKEN_EXPIRED
4. Client calls /refresh with refreshToken
5. Server returns new accessToken
6. Repeat from step 2
```

**Security benefits:**
1. **Short access tokens**: Less exposure if stolen
2. **Refresh token rotation**: Can revoke compromised tokens
3. **Reduced DB queries**: Validate access token without DB
4. **Graceful expiration**: User stays logged in with refresh

---

#### 5. How do you handle token expiration and refresh?

**Answer:**

**1. Client-side token management:**
```javascript
// Client-side interceptor (Axios example)
import axios from 'axios';

let refreshTokenPromise = null;

const api = axios.create({
  baseURL: '/api'
});

// Request interceptor to add token
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('accessToken');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

// Response interceptor to handle token refresh
api.interceptors.response.use(
  (response) => response,
  async (error) => {
    const originalRequest = error.config;
    
    // If 401 and token expired, try to refresh
    if (error.response?.status === 401 && 
        error.response?.data?.code === 'TOKEN_EXPIRED' &&
        !originalRequest._retry) {
      
      originalRequest._retry = true;
      
      // Prevent multiple refresh calls
      if (!refreshTokenPromise) {
        refreshTokenPromise = refreshAccessToken()
          .finally(() => {
            refreshTokenPromise = null;
          });
      }
      
      try {
        await refreshTokenPromise;
        
        // Retry original request with new token
        const newToken = localStorage.getItem('accessToken');
        originalRequest.headers.Authorization = `Bearer ${newToken}`;
        return api(originalRequest);
      } catch (refreshError) {
        // Refresh failed - redirect to login
        localStorage.removeItem('accessToken');
        localStorage.removeItem('refreshToken');
        window.location.href = '/login';
        return Promise.reject(refreshError);
      }
    }
    
    return Promise.reject(error);
  }
);

async function refreshAccessToken() {
  const refreshToken = localStorage.getItem('refreshToken');
  
  if (!refreshToken) {
    throw new Error('No refresh token available');
  }
  
  try {
    const response = await axios.post('/api/refresh', {
      refreshToken
    });
    
    const { accessToken } = response.data;
    localStorage.setItem('accessToken', accessToken);
    return accessToken;
  } catch (err) {
    // Clear tokens on refresh failure
    localStorage.removeItem('accessToken');
    localStorage.removeItem('refreshToken');
    throw err;
  }
}
```

**2. Server-side token refresh:**
```javascript
// Token refresh endpoint with rotation
app.post('/api/refresh', async (req, res) => {
  const { refreshToken } = req.body;
  
  if (!refreshToken) {
    return res.status(400).json({ error: 'Refresh token required' });
  }
  
  try {
    // Verify refresh token
    const decoded = jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET);
    
    // Check token type
    if (decoded.type !== 'refresh') {
      return res.status(403).json({ error: 'Invalid token type' });
    }
    
    // Find token in database
    const tokenRecord = await RefreshToken.findOne({
      where: {
        token: refreshToken,
        userId: decoded.userId,
        revoked: false,
        expiresAt: { [Op.gt]: new Date() }
      }
    });
    
    if (!tokenRecord) {
      return res.status(403).json({ error: 'Invalid or expired refresh token' });
    }
    
    // Get user
    const user = await User.findByPk(decoded.userId);
    if (!user) {
      return res.status(403).json({ error: 'User not found' });
    }
    
    // Generate new access token
    const newAccessToken = jwt.sign(
      {
        userId: user.id,
        email: user.email,
        role: user.role
      },
      process.env.ACCESS_TOKEN_SECRET,
      { expiresIn: '15m' }
    );
    
    // Generate new refresh token (rotation)
    const newRefreshToken = jwt.sign(
      {
        userId: user.id,
        type: 'refresh'
      },
      process.env.REFRESH_TOKEN_SECRET,
      { expiresIn: '7d' }
    );
    
    // Revoke old refresh token
    tokenRecord.revoked = true;
    tokenRecord.revokedAt = new Date();
    await tokenRecord.save();
    
    // Store new refresh token
    await RefreshToken.create({
      userId: user.id,
      token: newRefreshToken,
      expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000)
    });
    
    res.json({
      accessToken: newAccessToken,
      refreshToken: newRefreshToken
    });
  } catch (err) {
    if (err.name === 'TokenExpiredError') {
      // Clean up expired token
      await RefreshToken.destroy({
        where: { token: refreshToken }
      });
      
      return res.status(403).json({ 
        error: 'Refresh token expired',
        code: 'REFRESH_TOKEN_EXPIRED'
      });
    }
    
    res.status(403).json({ error: 'Invalid refresh token' });
  }
});
```

**3. Automatic token refresh before expiration:**
```javascript
// Proactive refresh (client-side)
function setupTokenRefresh() {
  const checkInterval = 60 * 1000; // Check every minute
  
  setInterval(async () => {
    const accessToken = localStorage.getItem('accessToken');
    
    if (!accessToken) return;
    
    try {
      // Decode token to check expiration
      const decoded = jwt.decode(accessToken);
      if (!decoded || !decoded.exp) return;
      
      // If token expires in less than 5 minutes, refresh
      const expiresIn = decoded.exp * 1000 - Date.now();
      if (expiresIn < 5 * 60 * 1000 && expiresIn > 0) {
        await refreshAccessToken();
        console.log('Token refreshed proactively');
      }
    } catch (err) {
      console.error('Token refresh check failed:', err);
    }
  }, checkInterval);
}

// Start on app initialization
setupTokenRefresh();
```

**4. Handling concurrent requests during refresh:**
```javascript
// Singleton refresh handler
class TokenRefreshHandler {
  constructor() {
    this.refreshPromise = null;
    this.subscribers = [];
  }
  
  async refresh() {
    // If already refreshing, return existing promise
    if (this.refreshPromise) {
      return this.refreshPromise;
    }
    
    this.refreshPromise = this.performRefresh();
    
    // Clear promise when done
    this.refreshPromise.finally(() => {
      this.refreshPromise = null;
    });
    
    return this.refreshPromise;
  }
  
  async performRefresh() {
    try {
      const refreshToken = localStorage.getItem('refreshToken');
      const response = await axios.post('/api/refresh', { refreshToken });
      
      const { accessToken, refreshToken: newRefreshToken } = response.data;
      
      // Update tokens
      localStorage.setItem('accessToken', accessToken);
      if (newRefreshToken) {
        localStorage.setItem('refreshToken', newRefreshToken);
      }
      
      // Notify subscribers
      this.subscribers.forEach(callback => callback(accessToken));
      this.subscribers = [];
      
      return accessToken;
    } catch (err) {
      // Notify subscribers of failure
      this.subscribers.forEach(callback => callback(null, err));
      this.subscribers = [];
      throw err;
    }
  }
  
  subscribe(callback) {
    this.subscribers.push(callback);
  }
}

// Usage in request interceptor
const tokenHandler = new TokenRefreshHandler();

api.interceptors.response.use(
  response => response,
  async error => {
    if (error.response?.status === 401 && 
        error.response?.data?.code === 'TOKEN_EXPIRED') {
      
      return new Promise((resolve, reject) => {
        tokenHandler.subscribe((newToken, refreshError) => {
          if (refreshError) {
            reject(refreshError);
            return;
          }
          
          // Retry with new token
          error.config.headers.Authorization = `Bearer ${newToken}`;
          resolve(axios(error.config));
        });
        
        tokenHandler.refresh();
      });
    }
    
    return Promise.reject(error);
  }
);
```

**5. Token expiration in middleware:**
```javascript
// Middleware to check token expiration
function checkTokenExpiration(req, res, next) {
  const token = req.headers.authorization?.split(' ')[1];
  
  if (!token) {
    return next();
  }
  
  try {
    // Decode without verification to check expiration
    const decoded = jwt.decode(token);
    
    if (decoded && decoded.exp) {
      const expiresIn = decoded.exp * 1000 - Date.now();
      
      // Add header with time remaining
      res.set('X-Token-Expires-In', Math.max(0, expiresIn));
      
      // Warn if expiring soon
      if (expiresIn < 5 * 60 * 1000 && expiresIn > 0) {
        res.set('X-Token-Expiring-Soon', 'true');
      }
    }
  } catch (err) {
    // Ignore decode errors
  }
  
  next();
}

app.use(checkTokenExpiration);
```

**Best practices:**
1. **Short access tokens**: 15-60 minutes
2. **Long refresh tokens**: 7-30 days
3. **Token rotation**: Issue new refresh token on refresh
4. **Secure storage**: httpOnly cookies for refresh tokens
5. **Proactive refresh**: Refresh before expiration
6. **Concurrent handling**: Prevent multiple refresh calls
7. **Cleanup**: Remove expired/revoked tokens

---
---

## 24. Session-based Authentication

#### 1. How do you implement session-based authentication in Express?

**Answer:**

**Session-based authentication** uses server-side sessions to track authenticated users.

**Complete implementation:**

**1. Basic setup with express-session:**
```javascript
const express = require('express');
const session = require('express-session');
const app = express();

// Middleware to parse request bodies
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Session middleware
app.use(session({
  secret: 'your-secret-key-here', // Required: signs session ID cookie
  resave: false,                  // Don't save session if unmodified
  saveUninitialized: false,       // Don't create session until something stored
  cookie: {
    secure: process.env.NODE_ENV === 'production', // HTTPS in production
    httpOnly: true,     // Not accessible via JavaScript (security)
    maxAge: 24 * 60 * 60 * 1000, // 24 hours
    sameSite: 'strict'  // CSRF protection
  }
}));
```

**2. User model (simplified):**
```javascript
// In-memory user store for example
const users = [
  {
    id: 1,
    username: 'john',
    password: 'password123', // In real app, use hashed passwords
    email: 'john@example.com',
    role: 'user'
  }
];

// Helper functions
function findUserByUsername(username) {
  return users.find(user => user.username === username);
}

function findUserById(id) {
  return users.find(user => user.id === id);
}
```

**3. Registration endpoint:**
```javascript
app.post('/api/register', (req, res) => {
  const { username, email, password } = req.body;
  
  // Validation
  if (!username || !email || !password) {
    return res.status(400).json({ error: 'All fields are required' });
  }
  
  // Check if user exists
  if (findUserByUsername(username)) {
    return res.status(409).json({ error: 'Username already exists' });
  }
  
  // Create new user
  const newUser = {
    id: users.length + 1,
    username,
    email,
    password, // In real app: hash password
    role: 'user',
    createdAt: new Date()
  };
  
  users.push(newUser);
  
  // Auto-login after registration
  req.session.userId = newUser.id;
  req.session.username = newUser.username;
  req.session.role = newUser.role;
  
  res.status(201).json({
    message: 'User registered successfully',
    user: {
      id: newUser.id,
      username: newUser.username,
      email: newUser.email,
      role: newUser.role
    }
  });
});
```

**4. Login endpoint:**
```javascript
app.post('/api/login', (req, res) => {
  const { username, password } = req.body;
  
  // Find user
  const user = findUserByUsername(username);
  if (!user) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }
  
  // Verify password (in real app: compare hashed passwords)
  if (user.password !== password) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }
  
  // Store user info in session
  req.session.userId = user.id;
  req.session.username = user.username;
  req.session.email = user.email;
  req.session.role = user.role;
  req.session.loggedInAt = new Date();
  
  // Optional: Regenerate session ID to prevent fixation
  req.session.regenerate((err) => {
    if (err) {
      console.error('Session regeneration error:', err);
    }
    
    res.json({
      message: 'Logged in successfully',
      user: {
        id: user.id,
        username: user.username,
        email: user.email,
        role: user.role
      }
    });
  });
});
```

**5. Authentication middleware:**
```javascript
// Middleware to check if user is authenticated
function requireAuth(req, res, next) {
  if (!req.session.userId) {
    return res.status(401).json({ 
      error: 'Unauthorized',
      message: 'Please log in to access this resource'
    });
  }
  
  // Optional: Verify user still exists
  const user = findUserById(req.session.userId);
  if (!user) {
    // User was deleted but session still exists
    req.session.destroy();
    return res.status(401).json({ error: 'User no longer exists' });
  }
  
  // Attach user to request for convenience
  req.user = user;
  next();
}

// Middleware to check if user is guest (not authenticated)
function requireGuest(req, res, next) {
  if (req.session.userId) {
    return res.status(403).json({ 
      error: 'Forbidden',
      message: 'You are already logged in'
    });
  }
  next();
}
```

**6. Protected routes:**
```javascript
// Get current user profile
app.get('/api/profile', requireAuth, (req, res) => {
  res.json({
    user: {
      id: req.session.userId,
      username: req.session.username,
      email: req.session.email,
      role: req.session.role,
      loggedInAt: req.session.loggedInAt
    },
    sessionId: req.session.id
  });
});

// Update profile
app.put('/api/profile', requireAuth, (req, res) => {
  const { email } = req.body;
  
  // Update user in database (simplified)
  const user = findUserById(req.session.userId);
  if (email) {
    user.email = email;
    req.session.email = email; // Update session too
  }
  
  res.json({
    message: 'Profile updated',
    user: {
      id: user.id,
      username: user.username,
      email: user.email,
      role: user.role
    }
  });
});
```

**7. Logout endpoint:**
```javascript
app.post('/api/logout', (req, res) => {
  // Destroy session
  req.session.destroy((err) => {
    if (err) {
      console.error('Logout error:', err);
      return res.status(500).json({ error: 'Logout failed' });
    }
    
    // Clear session cookie
    res.clearCookie('connect.sid');
    
    res.json({ message: 'Logged out successfully' });
  });
});
```

**8. Session info endpoint:**
```javascript
app.get('/api/session-info', (req, res) => {
  res.json({
    sessionId: req.session.id,
    userId: req.session.userId,
    cookie: req.session.cookie,
    // Don't expose sensitive session data
    authenticated: !!req.session.userId
  });
});
```

**9. Admin-only routes with authorization:**
```javascript
// Authorization middleware
function requireRole(role) {
  return (req, res, next) => {
    if (!req.session.userId) {
      return res.status(401).json({ error: 'Unauthorized' });
    }
    
    if (req.session.role !== role) {
      return res.status(403).json({ 
        error: 'Forbidden',
        message: `Requires ${role} role`
      });
    }
    
    next();
  };
}

// Admin dashboard
app.get('/api/admin/dashboard', 
  requireAuth, 
  requireRole('admin'),
  (req, res) => {
    res.json({
      message: 'Admin dashboard',
      stats: {
        totalUsers: users.length,
        activeSessions: 'N/A' // Would need session store query
      }
    });
  }
);
```

**10. CSRF protection (for forms):**
```javascript
// Generate CSRF token
app.get('/api/csrf-token', (req, res) => {
  // Store in session
  req.session.csrfToken = require('crypto').randomBytes(32).toString('hex');
  
  res.json({ csrfToken: req.session.csrfToken });
});

// Validate CSRF token middleware
function validateCsrf(req, res, next) {
  // Skip for GET, HEAD, OPTIONS
  if (['GET', 'HEAD', 'OPTIONS'].includes(req.method)) {
    return next();
  }
  
  const token = req.headers['x-csrf-token'] || req.body._csrf;
  
  if (!token || token !== req.session.csrfToken) {
    return res.status(403).json({ error: 'Invalid CSRF token' });
  }
  
  // Generate new token for next request
  req.session.csrfToken = require('crypto').randomBytes(32).toString('hex');
  next();
}

app.use(validateCsrf);
```

---

#### 2. What is express-session and how do you configure it?

**Answer:**

**express-session** is middleware for session management in Express.

**Basic configuration:**
```javascript
const session = require('express-session');

app.use(session({
  // Required: secret to sign session ID cookie
  secret: process.env.SESSION_SECRET || 'your-secret-key',
  
  // Forces session to be saved back to session store
  resave: false,
  
  // Forces a session that is "uninitialized" to be saved to store
  saveUninitialized: false,
  
  // Cookie settings
  cookie: {
    secure: process.env.NODE_ENV === 'production', // HTTPS only in production
    httpOnly: true,    // Not accessible via JavaScript
    maxAge: 24 * 60 * 60 * 1000, // 24 hours
    sameSite: 'strict' // CSRF protection
  },
  
  // Session store (default: MemoryStore - not for production)
  store: sessionStore,
  
  // Generate custom session ID
  genid: (req) => {
    return require('crypto').randomBytes(16).toString('hex');
  },
  
  // Called when session is created
  rolling: false, // Reset maxAge on every response
  
  // Session expiration (ms)
  expires: new Date(Date.now() + (24 * 60 * 60 * 1000))
}));
```

**Configuration options explained:**

**1. `secret` (required):**
```javascript
secret: 'your-secret-key-here'
// Or from environment variable
secret: process.env.SESSION_SECRET
// Or multiple secrets for rotation
secret: ['current-secret', 'previous-secret']
```

**2. `resave` (recommended: false):**
```javascript
resave: false // Don't save if session wasn't modified
resave: true  // Save on every request (can cause race conditions)
```

**3. `saveUninitialized` (recommended: false):**
```javascript
saveUninitialized: false // Don't save empty sessions
saveUninitialized: true  // Save all sessions (privacy concern)
```

**4. `cookie` settings:**
```javascript
cookie: {
  // Security
  secure: true,                 // HTTPS only
  httpOnly: true,              // No JavaScript access
  sameSite: 'strict',          // CSRF protection
  
  // Expiration
  maxAge: 24 * 60 * 60 * 1000, // 24 hours in milliseconds
  expires: new Date('2024-12-31'), // Specific date
  
  // Domain/path
  domain: '.example.com',      // Available on subdomains
  path: '/admin'               // Only for specific path
}
```

**5. `store` (for production):**
```javascript
// MemoryStore (default - NOT for production)
// Data lost on server restart, memory leaks

// Redis store (recommended)
const RedisStore = require('connect-redis')(session);
const redis = require('redis');

const redisClient = redis.createClient({
  host: 'localhost',
  port: 6379,
  password: process.env.REDIS_PASSWORD
});

store: new RedisStore({ client: redisClient })

// MongoDB store
const MongoStore = require('connect-mongo');

store: MongoStore.create({
  mongoUrl: 'mongodb://localhost/sessions',
  ttl: 14 * 24 * 60 * 60 // 14 days
})
```

**6. Advanced options:**
```javascript
// Custom session ID generation
genid: function(req) {
  return require('crypto').randomBytes(16).toString('hex');
},

// Reset maxAge on every response
rolling: true,

// Force session expiration
cookie: {
  expires: new Date(Date.now() + (30 * 60 * 1000)) // 30 minutes
},

// Proxy trust (if behind reverse proxy)
proxy: true,
name: 'myapp.sid', // Custom cookie name

// Unset/destroy behavior
unset: 'destroy', // Destroy session when unset
unset: 'keep',    // Keep session but remove property
```

**Production configuration example:**
```javascript
const session = require('express-session');
const RedisStore = require('connect-redis')(session);
const redis = require('redis');

// Create Redis client
const redisClient = redis.createClient({
  url: process.env.REDIS_URL || 'redis://localhost:6379',
  password: process.env.REDIS_PASSWORD,
  legacyMode: false
});

redisClient.connect().catch(console.error);

app.use(session({
  store: new RedisStore({ 
    client: redisClient,
    prefix: 'session:', // Redis key prefix
    ttl: 24 * 60 * 60 // 24 hours in seconds
  }),
  secret: process.env.SESSION_SECRET,
  resave: false,
  saveUninitialized: false,
  cookie: {
    secure: process.env.NODE_ENV === 'production',
    httpOnly: true,
    maxAge: 24 * 60 * 60 * 1000,
    sameSite: 'lax' // 'strict' breaks OAuth redirects
  },
  name: 'app.sid', // Custom cookie name
  rolling: true, // Reset expiration on activity
  unset: 'destroy' // Destroy session when unset
}));
```

**Session store methods:**
```javascript
// All stores implement these methods:
store.get(sid, callback)      // Get session by ID
store.set(sid, session, callback) // Save session
store.destroy(sid, callback)  // Destroy session
store.all(callback)           // Get all sessions (if supported)
store.clear(callback)         // Clear all sessions
store.length(callback)        // Count sessions
store.touch(sid, session, callback) // Update expiration
```

---

#### 3. How do you choose a session store (memory, Redis, database)?

**Answer:**

**1. MemoryStore (default - development only):**
```javascript
// Default - no configuration needed
app.use(session({
  secret: 'secret',
  resave: false,
  saveUninitialized: false
}));
```

**Pros:**
- Zero configuration
- Fast (in-memory)
- Good for development

**Cons:**
- **Not persistent** - sessions lost on server restart
- **Memory leaks** - old sessions not automatically cleaned
- **Not scalable** - can't share across multiple servers
- **Security risk** - sessions in application memory

**When to use:** Development, testing, prototyping

**2. Redis Store (recommended for production):**
```javascript
const RedisStore = require('connect-redis')(session);
const redis = require('redis');

const redisClient = redis.createClient({
  host: 'localhost',
  port: 6379
});

app.use(session({
  store: new RedisStore({ client: redisClient }),
  secret: 'secret',
  resave: false,
  saveUninitialized: false
}));
```

**Pros:**
- **Fast** - in-memory data store
- **Persistent** - optional persistence to disk
- **Scalable** - shared across multiple servers
- **Automatic expiration** - TTL support
- **High performance** - optimized for session storage

**Cons:**
- Requires Redis installation/maintenance
- Additional infrastructure cost
- Network latency (if remote Redis)

**When to use:** Production applications, high-traffic sites, microservices

**3. MongoDB Store:**
```javascript
const MongoStore = require('connect-mongo');

app.use(session({
  store: MongoStore.create({
    mongoUrl: 'mongodb://localhost/sessions',
    collectionName: 'sessions',
    ttl: 14 * 24 * 60 * 60 // 14 days
  }),
  secret: 'secret',
  resave: false,
  saveUninitialized: false
}));
```

**Pros:**
- **Familiar** if already using MongoDB
- **Queryable** - can query session data
- **Persistent** - durable storage
- **Integrated** - same database as application data

**Cons:**
- **Slower** than Redis (disk vs memory)
- **Not optimized** for session patterns
- **Database load** - adds to main DB workload

**When to use:** Small to medium apps already using MongoDB

**4. PostgreSQL/MySQL Store:**
```javascript
const pgSession = require('connect-pg-simple')(session);
const { Pool } = require('pg');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL
});

app.use(session({
  store: new pgSession({
    pool: pool,
    tableName: 'user_sessions'
  }),
  secret: 'secret',
  resave: false,
  saveUninitialized: false
}));
```

**Pros:**
- **Transactional** - ACID compliance
- **Backup included** - part of database backups
- **Familiar** - if using relational DB
- **Queryable** - SQL queries on session data

**Cons:**
- **Slowest option** - disk-based with joins
- **Table bloat** - sessions table grows quickly
- **Cleanup needed** - manual cleanup of expired sessions

**When to use:** When relational DB is required, low session count

**5. Custom Store:**
```javascript
// Implement session.Store interface
class CustomStore extends session.Store {
  constructor() {
    super();
    this.sessions = new Map();
  }
  
  get(sid, callback) {
    callback(null, this.sessions.get(sid));
  }
  
  set(sid, session, callback) {
    this.sessions.set(sid, session);
    callback(null);
  }
  
  destroy(sid, callback) {
    this.sessions.delete(sid);
    callback(null);
  }
}

app.use(session({
  store: new CustomStore(),
  secret: 'secret',
  resave: false,
  saveUninitialized: false
}));
```

**Comparison table:**

| Store | Speed | Persistence | Scalability | Setup Complexity | Best For |
|-------|-------|------------|-------------|------------------|----------|
| **Memory** | Fastest | No | None | None | Development |
| **Redis** | Very Fast | Yes | Excellent | Medium | Production |
| **MongoDB** | Medium | Yes | Good | Low | MongoDB apps |
| **PostgreSQL** | Slow | Yes | Good | Medium | RDBMS apps |
| **Custom** | Varies | Varies | Varies | High | Special needs |

**Choosing criteria:**

1. **Performance needs**: Redis for high performance
2. **Existing infrastructure**: Use what you already have
3. **Scalability requirements**: Redis for horizontal scaling
4. **Persistence needs**: All except MemoryStore
5. **Budget**: MemoryStore free, Redis has hosting costs
6. **Team expertise**: Choose familiar technology

**Recommendation:**
- **Development**: MemoryStore
- **Production**: Redis (preferred) or database store
- **Small projects**: Same database as app
- **Enterprise**: Redis cluster

---

#### 4. What are the advantages and disadvantages of session-based auth?

**Answer:**

**Advantages:**

**1. Server control:**
```javascript
// Immediate session invalidation
app.post('/api/logout', (req, res) => {
  req.session.destroy((err) => {
    // Session immediately destroyed
    res.json({ message: 'Logged out' });
  });
});

// Force logout all sessions for a user
app.post('/api/admin/force-logout/:userId', (req, res) => {
  const userId = req.params.userId;
  
  // Query session store and destroy all sessions for user
  sessionStore.all((err, sessions) => {
    Object.entries(sessions).forEach(([sid, session]) => {
      if (session.userId === userId) {
        sessionStore.destroy(sid);
      }
    });
  });
  
  res.json({ message: 'All sessions terminated' });
});
```

**2. No token size limits:**
```javascript
// Store large user data in session
req.session.userPreferences = {
  theme: 'dark',
  language: 'en',
  notifications: true,
  // ... many more properties
  // No size constraints like JWT
};

// Store complex objects
req.session.cart = {
  items: [
    { id: 1, name: 'Product', quantity: 2, price: 29.99 },
    // ... many items
  ],
  discount: { code: 'SAVE10', amount: 5.00 },
  shipping: { method: 'express', cost: 9.99 }
};
```

**3. Built-in expiration management:**
```javascript
// Automatic cleanup by session store
app.use(session({
  cookie: {
    maxAge: 24 * 60 * 60 * 1000 // Auto-expires in 24h
  },
  // Redis auto-deletes expired sessions
  store: new RedisStore({ ttl: 86400 })
}));

// Rolling expiration
app.use(session({
  rolling: true, // Reset maxAge on every request
  cookie: { maxAge: 30 * 60 * 1000 } // 30 minutes from last activity
}));
```

**4. Native browser support:**
```javascript
// Cookies work everywhere
app.use(session({
  cookie: {
    // No client-side code needed
    // Browser automatically sends cookie
  }
}));

// Works with:
// - All browsers
// - Mobile browsers
// - Legacy systems
// - No JavaScript required
```

**5. CSRF protection built-in:**
```javascript
// SameSite cookies prevent CSRF
app.use(session({
  cookie: {
    sameSite: 'strict' // Blocks cross-site requests
  }
}));

// Additional CSRF tokens easy to implement
req.session.csrfToken = generateToken();
```

**Disadvantages:**

**1. Scalability challenges:**
```javascript
// MemoryStore doesn't scale
app.use(session({
  // Sessions stored in server memory
  // Won't work with multiple servers
}));

// Need shared session store
const RedisStore = require('connect-redis')(session);
// Additional infrastructure required
```

**2. CORS/cookie issues with APIs:**
```javascript
// Cookies not sent cross-origin by default
app.use(cors({
  origin: 'https://frontend.example.com',
  credentials: true // Must explicitly enable
}));

// Client must include credentials
fetch('https://api.example.com/data', {
  credentials: 'include' // Required for cookies
});

// Mobile/SPA challenges
// - Cookie handling complex
// - Same-origin restrictions
```

**3. Overhead per request:**
```javascript
// Session store lookup on every request
function sessionMiddleware(req, res, next) {
  // 1. Parse cookie
  // 2. Lookup session in store
  // 3. Deserialize session data
  // 4. Attach to req.session
  // This happens for EVERY request
}

// Compared to JWT:
// 1. Parse header
// 2. Verify signature (crypto operation)
// 3. No store lookup
```

**4. Memory usage:**
```javascript
// Each session stores data server-side
req.session.userData = largeObject; // Stored in Redis/DB

// Many concurrent users = high memory/storage
// Session data persists until expiration
// Need cleanup of expired sessions
```

**5. Security concerns:**
```javascript
// Session fixation attacks
app.post('/api/login', (req, res) => {
  // Attacker sets session ID before login
  // Need to regenerate after login
  req.session.regenerate((err) => {
    // New session ID after auth
  });
});

// Session hijacking
// If session ID stolen, attacker has access
// No way to invalidate individual tokens like JWT
```

**Comparison with token-based auth:**

| Aspect | Session-based | Token-based (JWT) |
|--------|--------------|------------------|
| **State** | Stateful (server stores) | Stateless |
| **Scalability** | Needs shared store | Easy scaling |
| **Mobile/SPA** | Cookie challenges | Works well |
| **Invalidation** | Easy (destroy session) | Hard (need blacklist) |
| **Data size** | Unlimited server-side | Limited (token size) |
| **Performance** | Store lookup each request | Crypto verification |
| **Security** | Session fixation/hijacking | Token theft/revocation |

**When to choose session-based auth:**

1. **Traditional web apps** with server-side rendering
2. **Need immediate invalidation** (admin force logout)
3. **Storing large user data** (shopping carts, preferences)
4. **Working with cookies** is acceptable
5. **Have infrastructure** for session store (Redis)

**When to avoid session-based auth:**

1. **API-first applications**
2. **Mobile apps** or SPAs with separate domains
3. **Microservices architecture**
4. **Need stateless scalability**
5. **Limited infrastructure** for session store

---

#### 5. How do you handle session expiration?

**Answer:**

**1. Cookie-based expiration:**
```javascript
app.use(session({
  cookie: {
    maxAge: 30 * 60 * 1000, // 30 minutes in milliseconds
    expires: new Date(Date.now() + (30 * 60 * 1000)) // Specific date
  }
}));

// Browser automatically removes expired cookies
// Server rejects requests with expired session cookies
```

**2. Rolling sessions (activity-based):**
```javascript
app.use(session({
  rolling: true, // Reset maxAge on every request
  cookie: {
    maxAge: 30 * 60 * 1000 // 30 minutes from last activity
  }
}));

// Session stays active as long as user is active
// Expires after 30 minutes of inactivity
```

**3. Absolute expiration (fixed time):**
```javascript
app.use(session({
  rolling: false, // Fixed expiration time
  cookie: {
    maxAge: 24 * 60 * 60 * 1000 // 24 hours from creation
  }
}));

// Session expires 24 hours after login
// Regardless of user activity
```

**4. Server-side TTL (session store):**
```javascript
// Redis store with TTL
const RedisStore = require('connect-redis')(session);

app.use(session({
  store: new RedisStore({
    client: redisClient,
    ttl: 86400 // 24 hours in seconds (Redis TTL)
  }),
  cookie: {
    maxAge: 24 * 60 * 60 * 1000 // Match cookie to Redis TTL
  }
}));

// Redis automatically deletes expired sessions
```

**5. Manual session expiration:**
```javascript
// Set expiration in session data
app.post('/api/login', (req, res) => {
  req.session.userId = user.id;
  req.session.expiresAt = Date.now() + (30 * 60 * 1000); // 30 minutes
  
  res.json({ message: 'Logged in' });
});

// Middleware to check manual expiration
function checkSessionExpiration(req, res, next) {
  if (req.session.expiresAt && Date.now() > req.session.expiresAt) {
    req.session.destroy();
    return res.status(401).json({ error: 'Session expired' });
  }
  next();
}

app.use(checkSessionExpiration);
```

**6. Session timeout warning:**
```javascript
// Track last activity
app.use((req, res, next) => {
  if (req.session.userId) {
    req.session.lastActivity = Date.now();
  }
  next();
});

// Calculate time remaining
app.get('/api/session/time-remaining', (req, res) => {
  if (!req.session.userId) {
    return res.json({ active: false });
  }
  
  const maxAge = req.session.cookie.maxAge;
  const createdAt = req.session.createdAt || Date.now();
  const expiresAt = createdAt + maxAge;
  const timeRemaining = expiresAt - Date.now();
  
  res.json({
    active: true,
    timeRemaining,
    expiresAt: new Date(expiresAt),
    warning: timeRemaining < 5 * 60 * 1000 // 5 minutes
  });
});

// Client-side warning
setInterval(async () => {
  const response = await fetch('/api/session/time-remaining');
  const data = await response.json();
  
  if (data.warning) {
    showWarning('Your session will expire in 5 minutes');
  }
}, 60 * 1000); // Check every minute
```

**7. Auto-extend sessions:**
```javascript
// Extend session on specific activities
app.post('/api/important-action', (req, res) => {
  // Important action - extend session
  if (req.session.userId) {
    req.session.cookie.maxAge = 30 * 60 * 1000; // Reset to 30 minutes
    req.session.touch(); // Update session store
  }
  
  // Perform action
  res.json({ message: 'Action completed, session extended' });
});
```

**8. Different expiration for "remember me":**
```javascript
app.post('/api/login', (req, res) => {
  const { username, password, rememberMe } = req.body;
  
  // Authenticate user...
  
  if (rememberMe) {
    // Long session for "remember me"
    req.session.cookie.maxAge = 30 * 24 * 60 * 60 * 1000; // 30 days
  } else {
    // Short session for normal login
    req.session.cookie.maxAge = 30 * 60 * 1000; // 30 minutes
  }
  
  req.session.userId = user.id;
  res.json({ message: 'Logged in' });
});
```

**9. Cleanup expired sessions:**
```javascript
// Regular cleanup job (for database stores)
setInterval(async () => {
  try {
    // Delete sessions older than maxAge
    const cutoff = new Date(Date.now() - (24 * 60 * 60 * 1000));
    
    await Session.deleteMany({
      expires: { $lt: cutoff }
    });
    
    console.log('Cleaned up expired sessions');
  } catch (err) {
    console.error('Session cleanup error:', err);
  }
}, 60 * 60 * 1000); // Run every hour
```

**10. Graceful expiration handling:**
```javascript
// Middleware to handle expired sessions gracefully
app.use((req, res, next) => {
  const originalJson = res.json;
  
  res.json = function(data) {
    // Check if session is about to expire
    if (req.session.userId) {
      const maxAge = req.session.cookie.maxAge;
      const timeRemaining = (req.session.cookie.expires || 
                            new Date(Date.now() + maxAge)) - Date.now();
      
      // Add warning header if less than 5 minutes
      if (timeRemaining < 5 * 60 * 1000) {
        res.set('X-Session-Expiring-Soon', 'true');
        res.set('X-Session-Time-Remaining', timeRemaining.toString());
      }
    }
    
    originalJson.call(this, data);
  };
  
  next();
});

// Client can check headers and show warning
fetch('/api/data')
  .then(response => {
    if (response.headers.get('X-Session-Expiring-Soon')) {
      showSessionWarning();
    }
  });
```

**Best practices:**
1. **Use appropriate maxAge**: 30 minutes for sensitive, 24 hours for less sensitive
2. **Implement rolling sessions** for better UX
3. **Match cookie and store TTL**
4. **Provide session warnings** before expiration
5. **Clean up expired sessions** regularly
6. **Consider "remember me"** with longer expiration
7. **Handle expiration gracefully** (redirect to login)
8. **Log expiration events** for monitoring

---
---

## 25. OAuth & Social Login

#### 1. What is OAuth and how does it work?

**Answer:**

**OAuth** (Open Authorization) is an authorization framework that allows third-party applications to access user data without exposing passwords.

**OAuth 2.0 flow (Authorization Code Grant):**

**1. User clicks "Login with Google"** on your app
**2. App redirects to Google** with:
   - `client_id` (your app ID)
   - `redirect_uri` (callback URL)
   - `scope` (requested permissions)
   - `state` (CSRF protection)

**3. User authenticates with Google** and approves permissions
**4. Google redirects back to your app** with `code`
**5. App exchanges code for tokens** (server-side):
   - `code` + `client_secret` → access token
**6. App uses access token** to call Google APIs
**7. App gets user data** (profile, email, etc.)

**Visual flow:**
```
User → Your App → Google → User → Google → Your App → Google API → Your App
        (click)   (auth)   (approve) (code)   (token)    (data)      (login)
```

**OAuth roles:**
- **Resource Owner**: User (owns the data)
- **Client**: Your application (wants access)
- **Authorization Server**: Google/Facebook (issues tokens)
- **Resource Server**: Google/Facebook APIs (has user data)

**OAuth grant types:**
1. **Authorization Code**: Web apps (most secure)
2. **Implicit**: SPAs (deprecated in OAuth 2.1)
3. **Password**: Trusted apps (not recommended)
4. **Client Credentials**: Server-to-server
5. **Device Code**: TVs/devices without browser
6. **Refresh Token**: Get new access tokens

---

#### 2. How do you implement social login (Google, Facebook, GitHub)?

**Answer:**

**Using Passport.js (recommended):**

**1. Install dependencies:**
```bash
npm install passport passport-google-oauth20 passport-facebook passport-github2
```

**2. Google OAuth implementation:**
```javascript
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;

// Configure Google strategy
passport.use(new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: '/api/auth/google/callback',
    scope: ['profile', 'email'] // Requested permissions
  },
  async (accessToken, refreshToken, profile, done) => {
    try {
      // Find or create user in your database
      let user = await User.findOne({ googleId: profile.id });
      
      if (!user) {
        user = await User.create({
          googleId: profile.id,
          email: profile.emails[0].value,
          name: profile.displayName,
          avatar: profile.photos[0].value,
          provider: 'google'
        });
      }
      
      return done(null, user);
    } catch (err) {
      return done(err, null);
    }
  }
));

// Serialize/deserialize user
passport.serializeUser((user, done) => {
  done(null, user.id);
});

passport.deserializeUser(async (id, done) => {
  try {
    const user = await User.findById(id);
    done(null, user);
  } catch (err) {
    done(err, null);
  }
});

// Initialize passport
app.use(passport.initialize());
app.use(passport.session());

// Routes
app.get('/api/auth/google',
  passport.authenticate('google', { scope: ['profile', 'email'] })
);

app.get('/api/auth/google/callback',
  passport.authenticate('google', { failureRedirect: '/login' }),
  (req, res) => {
    // Successful authentication
    res.redirect('/dashboard');
  }
);
```

**3. Facebook OAuth implementation:**
```javascript
const FacebookStrategy = require('passport-facebook').Strategy;

passport.use(new FacebookStrategy({
    clientID: process.env.FACEBOOK_APP_ID,
    clientSecret: process.env.FACEBOOK_APP_SECRET,
    callbackURL: '/api/auth/facebook/callback',
    profileFields: ['id', 'displayName', 'photos', 'email']
  },
  async (accessToken, refreshToken, profile, done) => {
    try {
      let user = await User.findOne({ facebookId: profile.id });
      
      if (!user) {
        user = await User.create({
          facebookId: profile.id,
          email: profile.emails?.[0]?.value,
          name: profile.displayName,
          avatar: profile.photos?.[0]?.value,
          provider: 'facebook'
        });
      }
      
      return done(null, user);
    } catch (err) {
      return done(err, null);
    }
  }
));

app.get('/api/auth/facebook',
  passport.authenticate('facebook', { scope: ['email'] })
);

app.get('/api/auth/facebook/callback',
  passport.authenticate('facebook', { failureRedirect: '/login' }),
  (req, res) => {
    res.redirect('/dashboard');
  }
);
```

**4. GitHub OAuth implementation:**
```javascript
const GitHubStrategy = require('passport-github2').Strategy;

passport.use(new GitHubStrategy({
    clientID: process.env.GITHUB_CLIENT_ID,
    clientSecret: process.env.GITHUB_CLIENT_SECRET,
    callbackURL: '/api/auth/github/callback',
    scope: ['user:email'] // Request email scope
  },
  async (accessToken, refreshToken, profile, done) => {
    try {
      let user = await User.findOne({ githubId: profile.id });
      
      if (!user) {
        // GitHub emails might be in profile.emails array
        const email = profile.emails?.[0]?.value || 
                     `${profile.username}@users.noreply.github.com`;
        
        user = await User.create({
          githubId: profile.id,
          email: email,
          name: profile.displayName || profile.username,
          avatar: profile.photos?.[0]?.value,
          username: profile.username,
          provider: 'github'
        });
      }
      
      return done(null, user);
    } catch (err) {
      return done(err, null);
    }
  }
));

app.get('/api/auth/github',
  passport.authenticate('github', { scope: ['user:email'] })
);

app.get('/api/auth/github/callback',
  passport.authenticate('github', { failureRedirect: '/login' }),
  (req, res) => {
    res.redirect('/dashboard');
  }
);
```

**5. Unified social login handler:**
```javascript
// Route to handle multiple providers
app.get('/api/auth/:provider', (req, res, next) => {
  const { provider } = req.params;
  const { redirect } = req.query;
  
  // Store redirect URL in session
  if (redirect) {
    req.session.redirectTo = redirect;
  }
  
  // Dynamically call the right strategy
  const strategies = {
    google: passport.authenticate('google', { scope: ['profile', 'email'] }),
    facebook: passport.authenticate('facebook', { scope: ['email'] }),
    github: passport.authenticate('github', { scope: ['user:email'] })
  };
  
  if (strategies[provider]) {
    return strategies[provider](req, res, next);
  }
  
  res.status(400).json({ error: 'Invalid provider' });
});

// Unified callback handler
app.get('/api/auth/:provider/callback',
  (req, res, next) => {
    const { provider } = req.params;
    
    const strategies = {
      google: passport.authenticate('google', { failureRedirect: '/login' }),
      facebook: passport.authenticate('facebook', { failureRedirect: '/login' }),
      github: passport.authenticate('github', { failureRedirect: '/login' })
    };
    
    if (strategies[provider]) {
      return strategies[provider](req, res, next);
    }
    
    res.redirect('/login');
  },
  (req, res) => {
    // Successful authentication
    const redirectTo = req.session.redirectTo || '/dashboard';
    delete req.session.redirectTo;
    
    // Create JWT token for API access
    const token = jwt.sign(
      { userId: req.user.id, email: req.user.email },
      process.env.JWT_SECRET,
      { expiresIn: '24h' }
    );
    
    // Set token as cookie or return in response
    res.cookie('token', token, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production'
    });
    
    res.redirect(redirectTo);
  }
);
```

**6. Manual OAuth (without Passport):**
```javascript
const axios = require('axios');

app.get('/api/auth/google/manual', (req, res) => {
  const params = new URLSearchParams({
    client_id: process.env.GOOGLE_CLIENT_ID,
    redirect_uri: 'http://localhost:3000/api/auth/google/callback/manual',
    response_type: 'code',
    scope: 'openid email profile',
    access_type: 'offline', // Get refresh token
    prompt: 'consent' // Force consent screen
  });
  
  const authUrl = `https://accounts.google.com/o/oauth2/v2/auth?${params}`;
  res.redirect(authUrl);
});

app.get('/api/auth/google/callback/manual', async (req, res) => {
  const { code } = req.query;
  
  try {
    // Exchange code for tokens
    const tokenResponse = await axios.post('https://oauth2.googleapis.com/token', {
      code,
      client_id: process.env.GOOGLE_CLIENT_ID,
      client_secret: process.env.GOOGLE_CLIENT_SECRET,
      redirect_uri: 'http://localhost:3000/api/auth/google/callback/manual',
      grant_type: 'authorization_code'
    });
    
    const { access_token, id_token } = tokenResponse.data;
    
    // Get user info
    const userResponse = await axios.get('https://www.googleapis.com/oauth2/v3/userinfo', {
      headers: { Authorization: `Bearer ${access_token}` }
    });
    
    const userData = userResponse.data;
    
    // Find or create user
    let user = await User.findOne({ googleId: userData.sub });
    if (!user) {
      user = await User.create({
        googleId: userData.sub,
        email: userData.email,
        name: userData.name,
        avatar: userData.picture,
        provider: 'google'
      });
    }
    
    // Create session or JWT
    req.session.userId = user.id;
    
    res.redirect('/dashboard');
  } catch (err) {
    console.error('OAuth error:', err.response?.data || err.message);
    res.redirect('/login?error=oauth_failed');
  }
});
```

---

#### 3. What is the difference between OAuth 1.0 and OAuth 2.0?

**Answer:**

**OAuth 1.0 (2010):**
- **Complex**: Requires cryptographic signatures
- **All requests signed** with consumer secret and token secret
- **No expiration** for access tokens
- **Not widely used** today

**OAuth 2.0 (2012):**
- **Simpler**: Uses HTTPS/TLS instead of signatures
- **Bearer tokens** (like JWT)
- **Token expiration** with refresh tokens
- **Multiple grant types** for different use cases
- **Industry standard** (used by Google, Facebook, etc.)

**Key differences:**

| Aspect | OAuth 1.0 | OAuth 2.0 |
|--------|-----------|-----------|
| **Security** | Cryptographic signatures | HTTPS/TLS |
| **Complexity** | High | Low |
| **Tokens** | Long-lived, no expiration | Short-lived with refresh |
| **Performance** | Slower (sign each request) | Faster (bearer token) |
| **Adoption** | Limited | Widespread |
| **Mobile** | Not designed for | Designed for |

**OAuth 1.0a (security fix):**
- Added protection against session fixation
- Still uses signatures

**OAuth 2.1 (current best practices):**
- Removes implicit grant (insecure)
- Requires PKCE for public clients
- Requires redirect URI validation
- Better security defaults

**Example: OAuth 1.0 signature (complex):**
```javascript
// OAuth 1.0 requires signing every request
function signRequest(method, url, params, consumerSecret, tokenSecret) {
  // 1. Collect all parameters
  // 2. Normalize parameters
  // 3. Create signature base string
  // 4. Generate signature (HMAC-SHA1)
  // 5. Add signature to request
  return signature;
}

// Header includes complex signature
Authorization: OAuth oauth_consumer_key="...",
               oauth_nonce="...",
               oauth_signature="...",
               oauth_signature_method="HMAC-SHA1",
               oauth_timestamp="...",
               oauth_token="...",
               oauth_version="1.0"
```

**Example: OAuth 2.0 (simple):**
```javascript
// OAuth 2.0 uses bearer token
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...

// Or in query string (less secure)
GET /api/data?access_token=eyJhbGciOiJIUzI1NiIs...
```

**Migration from 1.0 to 2.0:**
- Most providers dropped 1.0 support
- Twitter migrated from 1.0a to 2.0 in 2022
- New apps should use OAuth 2.0/2.1

---

#### 4. How do you handle OAuth callbacks in Express?

**Answer:**

**OAuth callback handling involves:**
1. **Receiving authorization code**
2. **Exchanging code for tokens**
3. **Fetching user profile**
4. **Creating/updating local user**
5. **Creating session/JWT**
6. **Redirecting to app**

**Basic callback handler:**
```javascript
app.get('/api/auth/:provider/callback', async (req, res) => {
  const { provider } = req.params;
  const { code, state, error } = req.query;
  
  // Check for errors
  if (error) {
    console.error('OAuth error:', error);
    return res.redirect('/login?error=' + error);
  }
  
  // Validate state parameter (CSRF protection)
  if (!validateState(state, req.session.oauthState)) {
    return res.redirect('/login?error=invalid_state');
  }
  
  try {
    // Provider-specific configuration
    const providers = {
      google: {
        tokenUrl: 'https://oauth2.googleapis.com/token',
        userInfoUrl: 'https://www.googleapis.com/oauth2/v3/userinfo',
        clientId: process.env.GOOGLE_CLIENT_ID,
        clientSecret: process.env.GOOGLE_CLIENT_SECRET,
        redirectUri: 'http://localhost:3000/api/auth/google/callback'
      },
      facebook: {
        tokenUrl: 'https://graph.facebook.com/v12.0/oauth/access_token',
        userInfoUrl: 'https://graph.facebook.com/v12.0/me',
        clientId: process.env.FACEBOOK_APP_ID,
        clientSecret: process.env.FACEBOOK_APP_SECRET,
        redirectUri: 'http://localhost:3000/api/auth/facebook/callback',
        fields: 'id,name,email,picture'
      }
    };
    
    const config = providers[provider];
    if (!config) {
      return res.redirect('/login?error=invalid_provider');
    }
    
    // 1. Exchange code for access token
    const tokenResponse = await axios.post(config.tokenUrl, {
      code,
      client_id: config.clientId,
      client_secret: config.clientSecret,
      redirect_uri: config.redirectUri,
      grant_type: 'authorization_code'
    });
    
    const { access_token, refresh_token, id_token } = tokenResponse.data;
    
    // 2. Get user profile
    let userInfo;
    if (provider === 'google' && id_token) {
      // Decode JWT ID token (Google specific)
      const decoded = jwt.decode(id_token);
      userInfo = {
        id: decoded.sub,
        email: decoded.email,
        name: decoded.name,
        picture: decoded.picture
      };
    } else {
      // Fetch from user info endpoint
      const userResponse = await axios.get(config.userInfoUrl, {
        headers: { Authorization: `Bearer ${access_token}` },
        params: provider === 'facebook' ? { fields: config.fields } : {}
      });
      userInfo = userResponse.data;
    }
    
    // 3. Find or create user
    const user = await findOrCreateUser(provider, userInfo);
    
    // 4. Create session
    req.session.userId = user.id;
    req.session.provider = provider;
    
    // 5. Store tokens if needed (for API access)
    if (refresh_token) {
      await storeRefreshToken(user.id, provider, refresh_token);
    }
    
    // 6. Redirect to original URL or dashboard
    const redirectTo = req.session.returnTo || '/dashboard';
    delete req.session.returnTo;
    
    res.redirect(redirectTo);
    
  } catch (err) {
    console.error('OAuth callback error:', err.response?.data || err.message);
    res.redirect('/login?error=oauth_failed');
  }
});
```

**State parameter (CSRF protection):**
```javascript
// Generate and store state
app.get('/api/auth/:provider', (req, res) => {
  const { provider } = req.params;
  const { returnTo } = req.query;
  
  // Generate random state
  const state = require('crypto').randomBytes(16).toString('hex');
  
  // Store in session
  req.session.oauthState = state;
  
  // Store return URL
  if (returnTo) {
    req.session.returnTo = returnTo;
  }
  
  // Build OAuth URL with state
  const authUrl = buildAuthUrl(provider, state);
  res.redirect(authUrl);
});

// Validate state in callback
function validateState(receivedState, storedState) {
  if (!receivedState || !storedState) {
    return false;
  }
  
  // Constant-time comparison to prevent timing attacks
  return crypto.timingSafeEqual(
    Buffer.from(receivedState),
    Buffer.from(storedState)
  );
}
```

**PKCE (Proof Key for Code Exchange) for mobile/SPA:**
```javascript
// Generate code verifier and challenge
function generatePKCE() {
  const codeVerifier = crypto.randomBytes(32).toString('base64url');
  const codeChallenge = crypto
    .createHash('sha256')
    .update(codeVerifier)
    .digest('base64url');
  
  return { codeVerifier, codeChallenge };
}

// Add PKCE to auth request
app.get('/api/auth/:provider/pkce', (req, res) => {
  const { codeVerifier, codeChallenge } = generatePKCE();
  
  // Store code verifier in session
  req.session.codeVerifier = codeVerifier;
  
  // Include code_challenge in OAuth URL
  const authUrl = buildAuthUrl(provider, state, codeChallenge);
  res.redirect(authUrl);
});

// Include code_verifier in token exchange
app.get('/api/auth/:provider/callback/pkce', async (req, res) => {
  const { code } = req.query;
  const codeVerifier = req.session.codeVerifier;
  
  const tokenResponse = await axios.post(tokenUrl, {
    code,
    client_id: clientId,
    client_secret: clientSecret,
    redirect_uri: redirectUri,
    grant_type: 'authorization_code',
    code_verifier: codeVerifier // PKCE parameter
  });
});
```

**Error handling:**
```javascript
// Error handling middleware for OAuth
app.use('/api/auth/:provider/callback', (err, req, res, next) => {
  console.error('OAuth middleware error:', err);
  
  // Different error types
  if (err.name === 'TokenError') {
    return res.redirect('/login?error=token_error');
  }
  
  if (err.name === 'ProfileError') {
    return res.redirect('/login?error=profile_error');
  }
  
  if (err.response?.status === 400) {
    const error = err.response.data.error;
    if (error === 'invalid_grant') {
      return res.redirect('/login?error=expired_code');
    }
  }
  
  // Generic error
  res.redirect('/login?error=oauth_failed');
});
```

**Multiple callback strategies:**
```javascript
// Strategy 1: Session-based (traditional web)
function handleCallbackSession(req, res, user) {
  req.session.userId = user.id;
  res.redirect('/dashboard');
}

// Strategy 2: JWT token (SPA/API)
function handleCallbackJWT(req, res, user) {
  const token = jwt.sign(
    { userId: user.id },
    process.env.JWT_SECRET,
    { expiresIn: '24h' }
  );
  
  // Return token in response
  res.json({ token, user });
}

// Strategy 3: Cookie-based
function handleCallbackCookie(req, res, user) {
  const token = jwt.sign(
    { userId: user.id },
    process.env.JWT_SECRET,
    { expiresIn: '24h' }
  );
  
  res.cookie('token', token, {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    sameSite: 'lax'
  });
  
  res.redirect('/dashboard');
}

// Strategy 4: Query parameter (for mobile deep linking)
function handleCallbackDeepLink(req, res, user) {
  const token = jwt.sign(
    { userId: user.id },
    process.env.JWT_SECRET,
    { expiresIn: '24h' }
  );
  
  // Redirect to app with token
  const appUrl = `myapp://auth/callback?token=${encodeURIComponent(token)}`;
  res.redirect(appUrl);
}
```

---

#### 5. What are the security considerations for OAuth?

**Answer:**

**1. CSRF protection with state parameter:**
```javascript
// Generate and validate state
const state = crypto.randomBytes(16).toString('hex');
req.session.oauthState = state;

// Include in OAuth URL
const authUrl = `https://provider.com/oauth?state=${state}`;

// Validate in callback
if (req.query.state !== req.session.oauthState) {
  return res.status(400).json({ error: 'Invalid state parameter' });
}
```

**2. Redirect URI validation:**
```javascript
// Register exact redirect URIs with provider
const allowedRedirectUris = [
  'https://app.example.com/callback',
  'http://localhost:3000/callback'
];

// Validate in your code
function validateRedirectUri(uri) {
  return allowedRedirectUris.includes(uri);
}

// Use full URIs, not relative paths
const redirectUri = 'https://app.example.com/api/auth/callback';
```

**3. PKCE for public clients (SPA, mobile):**
```javascript
// Generate code verifier and challenge
const codeVerifier = crypto.randomBytes(32).toString('base64url');
const codeChallenge = crypto
  .createHash('sha256')
  .update(codeVerifier)
  .digest('base64url');

// Include in authorization request
const authUrl = `https://provider.com/oauth?code_challenge=${codeChallenge}`;

// Include in token exchange
const tokenResponse = await exchangeCode(code, codeVerifier);
```

**4. Secure token storage:**
```javascript
// Server-side: Store securely
await storeToken(userId, {
  accessToken: encryptedAccessToken,
  refreshToken: encryptedRefreshToken,
  expiresAt: Date.now() + 3600 * 1000
});

// Client-side: Use httpOnly cookies
res.cookie('token', accessToken, {
  httpOnly: true,    // Not accessible via JavaScript
  secure: true,      // HTTPS only
  sameSite: 'strict' // CSRF protection
});

// Avoid localStorage for tokens (XSS vulnerable)
// localStorage.setItem('token', token); // UNSAFE
```

**5. Scope minimization:**
```javascript
// Request only needed permissions
const scopes = {
  basic: ['openid', 'email', 'profile'],
  extra: ['https://www.googleapis.com/auth/calendar.readonly']
};

// Use minimal scopes
app.get('/api/auth/google', (req, res) => {
  const scope = scopes.basic.join(' ');
  res.redirect(`/oauth?scope=${encodeURIComponent(scope)}`);
});
```

**6. Token validation and verification:**
```javascript
// Verify ID tokens (JWT)
async function verifyIdToken(idToken) {
  try {
    // Get provider's public keys
    const keys = await getProviderPublicKeys();
    
    // Verify signature and claims
    const decoded = jwt.verify(idToken, keys, {
      algorithms: ['RS256'],
      issuer: 'https://accounts.google.com',
      audience: process.env.GOOGLE_CLIENT_ID
    });
    
    // Check expiration
    if (decoded.exp * 1000 < Date.now()) {
      throw new Error('Token expired');
    }
    
    return decoded;
  } catch (err) {
    throw new Error('Invalid token: ' + err.message);
  }
}
```

**7. Refresh token security:**
```javascript
// Store refresh tokens securely
await storeRefreshToken({
  userId: user.id,
  token: encryptedRefreshToken,
  clientId: 'web-app',
  issuedAt: new Date(),
  expiresAt: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000), // 30 days
  revoked: false
});

// Rotate refresh tokens
app.post('/api/auth/refresh', async (req, res) => {
  const { refreshToken } = req.body;
  
  // Verify and revoke old token
  const oldToken = await verifyAndRevokeRefreshToken(refreshToken);
  
  // Issue new tokens
  const newAccessToken = generateAccessToken(oldToken.userId);
  const newRefreshToken = generateRefreshToken(oldToken.userId);
  
  // Store new refresh token
  await storeRefreshToken(newRefreshToken);
  
  res.json({
    accessToken: newAccessToken,
    refreshToken: newRefreshToken
  });
});
```

**8. Logging and monitoring:**
```javascript
// Log OAuth events
function logOAuthEvent(event, userId, metadata = {}) {
  console.log({
    timestamp: new Date().toISOString(),
    event,
    userId,
    ip: req.ip,
    userAgent: req.headers['user-agent'],
    ...metadata
  });
  
  // Send to security monitoring
  securityMonitor.trackOAuthEvent(event, userId, metadata);
}

// Usage
logOAuthEvent('oauth_login_success', user.id, {
  provider: 'google',
  scope: req.query.scope
});

logOAuthEvent('oauth_login_failed', null, {
  provider: 'google',
  error: 'invalid_token',
  ip: req.ip
});
```

**9. Rate limiting:**
```javascript
// Limit OAuth attempts
const rateLimit = require('express-rate-limit');

const oauthLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 10, // 10 attempts per window
  message: { error: 'Too many OAuth attempts' },
  keyGenerator: (req) => req.ip + req.params.provider
});

app.use('/api/auth/:provider/callback', oauthLimiter);
```

**10. Security headers:**
```javascript
// Add security headers to OAuth pages
app.use('/auth/*', helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'", "'unsafe-inline'"], // Allow inline for OAuth
      styleSrc: ["'self'", "'unsafe-inline'"],
      imgSrc: ["'self'", "data:", "https:"], // Allow provider images
      connectSrc: ["'self'", "https://accounts.google.com"]
    }
  }
}));
```

**11. Provider-specific considerations:**

**Google:**
- Use `prompt=consent` for first-time users
- Validate `hd` parameter for G Suite domains
- Check `email_verified` claim

**Facebook:**
- Use App Secret Proof for server-side calls
- Validate app ID in response
- Handle declined permissions gracefully

**GitHub:**
- Request `user:email` scope for primary email
- Handle organization/team access
- Check email visibility settings

**12. Regular security audits:**
```javascript
// Audit OAuth implementations
async function auditOAuthSecurity() {
  const checks = [
    checkStateParameterUsage(),
    checkRedirectUriValidation(),
    checkTokenStorageSecurity(),
    checkScopeValidation(),
    checkErrorHandling()
  ];
  
  const results = await Promise.all(checks);
  return results.every(r => r.passed);
}

// Monitor for suspicious activity
securityMonitor.on('suspicious_oauth', (event) => {
  // Multiple failed attempts
  // Unusual IP locations
  // Unexpected scope requests
  // Token theft patterns
  
  alertSecurityTeam(event);
  optionallyBlockUser(event.userId);
});
```

**Best practices summary:**
1. **Always use state parameter** for CSRF protection
2. **Validate redirect URIs** strictly
3. **Use PKCE** for public clients
4. **Store tokens securely** (server-side preferred)
5. **Request minimal scopes**
6. **Verify tokens** before trusting them
7. **Implement refresh token rotation**
8. **Log and monitor** OAuth events
9. **Rate limit** OAuth endpoints
10. **Regular security audits**

---
---

## 26. Role-based Access Control (RBAC)

#### 1. What is RBAC and how does it work?

**Answer:**

**RBAC** (Role-based Access Control) is an authorization model where permissions are assigned to roles, and users are assigned to roles.

**RBAC components:**
1. **Users**: People or systems
2. **Roles**: Job functions (admin, editor, viewer)
3. **Permissions**: Actions (create, read, update, delete)
4. **Resources**: Objects to protect (articles, users, settings)

**RBAC flow:**
```
User → Assigned to → Role → Has → Permissions → On → Resources
```

**Basic RBAC example:**
```javascript
// Users have roles
const users = [
  { id: 1, name: 'Alice', roles: ['admin'] },
  { id: 2, name: 'Bob', roles: ['editor'] },
  { id: 3, name: 'Charlie', roles: ['viewer'] }
];

// Roles have permissions
const roles = {
  admin: ['create', 'read', 'update', 'delete', 'manage_users'],
  editor: ['create', 'read', 'update'],
  viewer: ['read']
};

// Check if user has permission
function hasPermission(userId, permission) {
  const user = users.find(u => u.id === userId);
  if (!user) return false;
  
  // Check all user's roles
  return user.roles.some(role => 
    roles[role]?.includes(permission)
  );
}

// Usage
console.log(hasPermission(1, 'manage_users')); // true (admin)
console.log(hasPermission(2, 'delete'));       // false (editor can't delete)
console.log(hasPermission(3, 'read'));         // true (viewer can read)
```

**RBAC vs other models:**

**1. RBAC (Role-based):**
- Permissions → Roles → Users
- Good for: Organizations with clear job functions
- Example: Admin, Manager, Employee

**2. ABAC (Attribute-based):**
- Rules based on attributes (time, location, department)
- Good for: Complex, dynamic policies
- Example: "Managers in Finance can approve expenses > $5000"

**3. DAC (Discretionary):**
- Resource owners control access
- Good for: File systems, personal data
- Example: Unix file permissions

**4. MAC (Mandatory):**
- System-wide policies (military, government)
- Good for: High-security environments
- Example: Top Secret, Secret, Confidential

**RBAC levels:**

**1. Flat RBAC:**
- Users → Roles
- Simple, common implementation

**2. Hierarchical RBAC:**
- Roles inherit from parent roles
- Example: Senior Editor inherits from Editor

**3. Constrained RBAC:**
- Separation of duties
- Example: Can't be both Approver and Requester

**4. Symmetric RBAC:**
- Role-permission review
- Audit who can do what

**RBAC benefits:**
- **Simplified management**: Assign roles, not individual permissions
- **Least privilege**: Users get only needed permissions
- **Auditability**: Easy to see who can do what
- **Scalability**: Add users without redefining permissions
- **Compliance**: Meets regulatory requirements

---

#### 2. How do you implement role-based permissions in Express?

**Answer:**

**Complete RBAC implementation in Express:**

**1. Database models:**
```javascript
// models/User.js
const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  roles: [{ type: String, ref: 'Role' }], // Array of role IDs
  isActive: { type: Boolean, default: true }
}, { timestamps: true });

module.exports = mongoose.model('User', userSchema);

// models/Role.js
const roleSchema = new mongoose.Schema({
  name: { type: String, required: true, unique: true }, // 'admin', 'editor'
  description: String,
  permissions: [{ type: String }] // ['users.create', 'posts.delete']
}, { timestamps: true });

module.exports = mongoose.model('Role', roleSchema);

// models/Permission.js (optional - for dynamic permissions)
const permissionSchema = new mongoose.Schema({
  resource: { type: String, required: true }, // 'users', 'posts'
  action: { type: String, required: true },   // 'create', 'read', 'update', 'delete'
  description: String
}, { timestamps: true });

module.exports = mongoose.model('Permission', permissionSchema);
```

**2. Seed initial roles and permissions:**
```javascript
// scripts/seedRoles.js
async function seedRoles() {
  const roles = [
    {
      name: 'admin',
      description: 'Full system access',
      permissions: [
        'users.create', 'users.read', 'users.update', 'users.delete',
        'posts.create', 'posts.read', 'posts.update', 'posts.delete',
        'settings.manage'
      ]
    },
    {
      name: 'editor',
      description: 'Can create and edit content',
      permissions: [
        'posts.create', 'posts.read', 'posts.update',
        'comments.create', 'comments.read', 'comments.update'
      ]
    },
    {
      name: 'viewer',
      description: 'Can view content only',
      permissions: [
        'posts.read',
        'comments.read'
      ]
    }
  ];
  
  for (const roleData of roles) {
    await Role.findOneAndUpdate(
      { name: roleData.name },
      roleData,
      { upsert: true, new: true }
    );
  }
  
  console.log('Roles seeded successfully');
}
```

**3. Authentication middleware:**
```javascript
// middleware/auth.js
const jwt = require('jsonwebtoken');

async function authenticate(req, res, next) {
  try {
    const token = req.headers.authorization?.split(' ')[1];
    
    if (!token) {
      return res.status(401).json({ error: 'Authentication required' });
    }
    
    // Verify token
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    
    // Get user with populated roles
    const user = await User.findById(decoded.userId)
      .populate('roles')
      .select('-password');
    
    if (!user || !user.isActive) {
      return res.status(401).json({ error: 'User not found or inactive' });
    }
    
    // Attach user to request
    req.user = user;
    next();
  } catch (err) {
    if (err.name === 'TokenExpiredError') {
      return res.status(401).json({ error: 'Token expired' });
    }
    return res.status(401).json({ error: 'Invalid token' });
  }
}
```

**4. Authorization middleware:**
```javascript
// middleware/rbac.js
function hasPermission(requiredPermission) {
  return async (req, res, next) => {
    try {
      // User must be authenticated first
      if (!req.user) {
        return res.status(401).json({ error: 'Authentication required' });
      }
      
      // Get all permissions from user's roles
      const userPermissions = new Set();
      
      for (const role of req.user.roles) {
        if (role.permissions) {
          role.permissions.forEach(perm => userPermissions.add(perm));
        }
      }
      
      // Check if user has required permission
      if (userPermissions.has(requiredPermission)) {
        return next();
      }
      
      // Check for wildcard permissions
      const [resource, action] = requiredPermission.split('.');
      const wildcardPermission = `${resource}.*`;
      
      if (userPermissions.has(wildcardPermission)) {
        return next();
      }
      
      // Global admin permission
      if (userPermissions.has('*')) {
        return next();
      }
      
      // Permission denied
      return res.status(403).json({
        error: 'Forbidden',
        message: `Requires permission: ${requiredPermission}`,
        userPermissions: Array.from(userPermissions)
      });
      
    } catch (err) {
      console.error('RBAC error:', err);
      return res.status(500).json({ error: 'Authorization error' });
    }
  };
}

// Role-based middleware (simpler)
function hasRole(requiredRole) {
  return async (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ error: 'Authentication required' });
    }
    
    const userRoles = req.user.roles.map(role => role.name);
    
    if (userRoles.includes(requiredRole)) {
      return next();
    }
    
    res.status(403).json({
      error: 'Forbidden',
      message: `Requires role: ${requiredRole}`,
      userRoles
    });
  };
}
```

**5. Route implementation:**
```javascript
// routes/users.js
const express = require('express');
const router = express.Router();
const { authenticate, hasPermission, hasRole } = require('../middleware');

// Get all users (admin only)
router.get('/',
  authenticate,
  hasPermission('users.read'),
  async (req, res) => {
    const users = await User.find().select('-password');
    res.json(users);
  }
);

// Get specific user (admin or self)
router.get('/:id',
  authenticate,
  async (req, res) => {
    // Allow if admin or viewing own profile
    const userPermissions = getUserPermissions(req.user);
    const isAdmin = userPermissions.has('users.read');
    const isSelf = req.user.id === req.params.id;
    
    if (!isAdmin && !isSelf) {
      return res.status(403).json({ error: 'Forbidden' });
    }
    
    const user = await User.findById(req.params.id).select('-password');
    res.json(user);
  }
);

// Create user (admin only)
router.post('/',
  authenticate,
  hasRole('admin'), // Alternative: hasPermission('users.create')
  async (req, res) => {
    const user = await User.create(req.body);
    res.status(201).json(user);
  }
);

// Update user (admin or self with limitations)
router.put('/:id',
  authenticate,
  async (req, res) => {
    const userId = req.params.id;
    const updates = req.body;
    const userPermissions = getUserPermissions(req.user);
    
    // Check if user can update
    const canUpdate = userPermissions.has('users.update') || 
                     (req.user.id === userId && !updates.roles);
    
    if (!canUpdate) {
      return res.status(403).json({ error: 'Forbidden' });
    }
    
    // Prevent non-admins from changing roles
    if (!userPermissions.has('users.update') && updates.roles) {
      delete updates.roles;
    }
    
    const user = await User.findByIdAndUpdate(userId, updates, { new: true });
    res.json(user);
  }
);

// Delete user (admin only)
router.delete('/:id',
  authenticate,
  hasPermission('users.delete'),
  async (req, res) => {
    await User.findByIdAndDelete(req.params.id);
    res.status(204).send();
  }
);

// Assign role to user (admin only)
router.post('/:id/roles',
  authenticate,
  hasPermission('users.manage_roles'),
  async (req, res) => {
    const { roleId } = req.body;
    
    // Add role to user
    await User.findByIdAndUpdate(
      req.params.id,
      { $addToSet: { roles: roleId } }
    );
    
    res.json({ message: 'Role assigned' });
  }
);

// Remove role from user (admin only)
router.delete('/:id/roles/:roleId',
  authenticate,
  hasPermission('users.manage_roles'),
  async (req, res) => {
    await User.findByIdAndUpdate(
      req.params.id,
      { $pull: { roles: req.params.roleId } }
    );
    
    res.json({ message: 'Role removed' });
  }
);
```

**6. Helper functions:**
```javascript
// utils/rbacHelpers.js
async function getUserPermissions(user) {
  const permissions = new Set();
  
  // If user is populated with roles
  if (user.roles && user.roles.length > 0) {
    for (const role of user.roles) {
      if (role.permissions) {
        role.permissions.forEach(perm => permissions.add(perm));
      }
    }
  } else {
    // Fetch roles if not populated
    const userWithRoles = await User.findById(user.id).populate('roles');
    for (const role of userWithRoles.roles) {
      if (role.permissions) {
        role.permissions.forEach(perm => permissions.add(perm));
      }
    }
  }
  
  return permissions;
}

function checkPermission(userPermissions, requiredPermission) {
  // Exact match
  if (userPermissions.has(requiredPermission)) {
    return true;
  }
  
  // Wildcard match
  const [resource, action] = requiredPermission.split('.');
  if (userPermissions.has(`${resource}.*`)) {
    return true;
  }
  
  // Global admin
  if (userPermissions.has('*')) {
    return true;
  }
  
  return false;
}

// Get all users with a specific permission
async function getUsersWithPermission(permission) {
  const roles = await Role.find({
    permissions: permission
  });
  
  const roleIds = roles.map(role => role._id);
  
  const users = await User.find({
    roles: { $in: roleIds }
  });
  
  return users;
}
```

**7. Testing RBAC:**
```javascript
// tests/rbac.test.js
describe('RBAC System', () => {
  let adminToken, editorToken, viewerToken;
  
  before(async () => {
    // Create test users
    const admin = await User.create({ email: 'admin@test.com', roles: ['admin'] });
    const editor = await User.create({ email: 'editor@test.com', roles: ['editor'] });
    const viewer = await User.create({ email: 'viewer@test.com', roles: ['viewer'] });
    
    // Get tokens
    adminToken = createToken(admin);
    editorToken = createToken(editor);
    viewerToken = createToken(viewer);
  });
  
  it('should allow admin to create users', async () => {
    const res = await request(app)
      .post('/api/users')
      .set('Authorization', `Bearer ${adminToken}`)
      .send({ email: 'new@test.com' });
    
    expect(res.status).toBe(201);
  });
  
  it('should deny editor from creating users', async () => {
    const res = await request(app)
      .post('/api/users')
      .set('Authorization', `Bearer ${editorToken}`)
      .send({ email: 'new2@test.com' });
    
    expect(res.status).toBe(403);
  });
  
  it('should allow viewer to read posts', async () => {
    const res = await request(app)
      .get('/api/posts')
      .set('Authorization', `Bearer ${viewerToken}`);
    
    expect(res.status).toBe(200);
  });
  
  it('should deny viewer from creating posts', async () => {
    const res = await request(app)
      .post('/api/posts')
      .set('Authorization', `Bearer ${viewerToken}`)
      .send({ title: 'New Post' });
    
    expect(res.status).toBe(403);
  });
});
```

**Best practices:**
1. **Start simple**: Basic roles first, add complexity later
2. **Use permission strings**: `resource.action` format
3. **Cache permissions**: Store in session/JWT to reduce DB queries
4. **Audit regularly**: Review who has what permissions
5. **Test thoroughly**: Test all permission combinations
6. **Document policies**: Document role-permission mappings
7. **Implement logging**: Log permission denials for security monitoring

---
---

#### 3. What is the difference between roles and permissions?

**Answer:**

**Roles** are collections of permissions assigned to users based on their job function.

**Permissions** are individual rights to perform specific actions on specific resources.

**Analogy:**
- **Roles** = Job titles (Manager, Developer, HR)
- **Permissions** = Keys to rooms (Office, Server Room, HR Files)

**Example:**
```javascript
// Permissions (individual rights)
const permissions = {
  // Resource: users
  'users.create': 'Create new users',
  'users.read':   'View user profiles',
  'users.update': 'Edit user information',
  'users.delete': 'Delete users',
  
  // Resource: posts
  'posts.create': 'Create new posts',
  'posts.read':   'View posts',
  'posts.update': 'Edit posts',
  'posts.delete': 'Delete posts',
  
  // Resource: settings
  'settings.manage': 'Manage system settings'
};

// Roles (collections of permissions)
const roles = {
  admin: [
    'users.create', 'users.read', 'users.update', 'users.delete',
    'posts.create', 'posts.read', 'posts.update', 'posts.delete',
    'settings.manage'
  ],
  
  editor: [
    'posts.create', 'posts.read', 'posts.update',
    'users.read'  // Can view users but not modify
  ],
  
  viewer: [
    'posts.read',
    'users.read'
  ]
};

// Users (assigned roles)
const users = [
  { id: 1, name: 'Admin User', roles: ['admin'] },
  { id: 2, name: 'Content Editor', roles: ['editor'] },
  { id: 3, name: 'Regular User', roles: ['viewer'] }
];
```

**Key differences:**

| Aspect | Roles | Permissions |
|--------|-------|------------|
| **Purpose** | Group permissions | Define specific actions |
| **Granularity** | Coarse-grained | Fine-grained |
| **Assignment** | Assigned to users | Assigned to roles |
| **Change frequency** | Infrequent | More frequent |
| **Number** | Few (5-10) | Many (dozens/hundreds) |
| **Examples** | Admin, Editor, Viewer | users.create, posts.delete |

**When to use roles vs permissions:**

**Use roles when:**
- You have clear job functions
- Permission sets are stable
- User base is large
- Need simple management

**Use direct permissions when:**
- Fine-grained control needed
- Dynamic permission assignment
- Small user base
- Complex business rules

**Hybrid approach (recommended):**
```javascript
// Users have roles AND can have extra permissions
const userSchema = new mongoose.Schema({
  email: String,
  roles: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Role' }],
  extraPermissions: [String], // Additional permissions beyond roles
  deniedPermissions: [String]  // Permissions explicitly denied
});

// Check access considering both
async function can(userId, permission) {
  const user = await User.findById(userId)
    .populate('roles');
  
  // Check denied permissions first
  if (user.deniedPermissions.includes(permission)) {
    return false;
  }
  
  // Check extra permissions
  if (user.extraPermissions.includes(permission)) {
    return true;
  }
  
  // Check role permissions
  for (const role of user.roles) {
    if (role.permissions.includes(permission)) {
      return true;
    }
  }
  
  return false;
}
```

**Role inheritance:**
```javascript
// Hierarchical roles
const roleHierarchy = {
  'super_admin': ['admin', 'editor', 'viewer'],
  'admin': ['editor', 'viewer'],
  'editor': ['viewer'],
  'viewer': []
};

// Get all inherited permissions
function getInheritedPermissions(roleName) {
  const allPermissions = new Set();
  const queue = [roleName];
  
  while (queue.length > 0) {
    const currentRole = queue.shift();
    
    // Add current role's permissions
    if (roles[currentRole]) {
      roles[currentRole].forEach(perm => allPermissions.add(perm));
    }
    
    // Add child roles
    if (roleHierarchy[currentRole]) {
      queue.push(...roleHierarchy[currentRole]);
    }
  }
  
  return Array.from(allPermissions);
}

// Example: Admin inherits from editor and viewer
console.log(getInheritedPermissions('admin'));
// ['posts.create', 'posts.read', 'posts.update', 'posts.delete',
//  'users.create', 'users.read', 'users.update', 'users.delete',
//  'settings.manage', 'posts.read', 'users.read']
```

**Best practices:**
1. **Define permissions first**, then roles
2. **Use consistent naming**: `resource.action`
3. **Document permission meanings**
4. **Regularly audit** role-permission assignments
5. **Consider future needs** when designing
6. **Test permission combinations**

---

#### 4. How do you create middleware for role-based authorization?

**Answer:**

**1. Basic role middleware:**
```javascript
// middleware/roles.js
function requireRole(roleName) {
  return async (req, res, next) => {
    try {
      // Ensure user is authenticated
      if (!req.user) {
        return res.status(401).json({ error: 'Authentication required' });
      }
      
      // Get user with populated roles
      const user = await User.findById(req.user.id).populate('roles');
      
      // Check if user has the required role
      const hasRole = user.roles.some(role => role.name === roleName);
      
      if (hasRole) {
        return next();
      }
      
      // Role not found
      res.status(403).json({
        error: 'Forbidden',
        message: `Requires role: ${roleName}`,
        userRoles: user.roles.map(r => r.name)
      });
      
    } catch (err) {
      console.error('Role middleware error:', err);
      res.status(500).json({ error: 'Authorization error' });
    }
  };
}

// Usage
app.get('/api/admin/dashboard',
  authenticate,
  requireRole('admin'),
  (req, res) => {
    res.json({ message: 'Admin dashboard' });
  }
);
```

**2. Multiple roles middleware:**
```javascript
function requireAnyRole(roleNames) {
  return async (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ error: 'Authentication required' });
    }
    
    const user = await User.findById(req.user.id).populate('roles');
    const userRoleNames = user.roles.map(role => role.name);
    
    // Check if user has ANY of the required roles
    const hasAnyRole = roleNames.some(roleName => 
      userRoleNames.includes(roleName)
    );
    
    if (hasAnyRole) {
      return next();
    }
    
    res.status(403).json({
      error: 'Forbidden',
      message: `Requires one of: ${roleNames.join(', ')}`,
      userRoles: userRoleNames
    });
  };
}

// Usage
app.get('/api/content/manage',
  authenticate,
  requireAnyRole(['admin', 'editor', 'moderator']),
  (req, res) => {
    res.json({ message: 'Content management' });
  }
);
```

**3. All roles middleware:**
```javascript
function requireAllRoles(roleNames) {
  return async (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ error: 'Authentication required' });
    }
    
    const user = await User.findById(req.user.id).populate('roles');
    const userRoleNames = user.roles.map(role => role.name);
    
    // Check if user has ALL required roles
    const hasAllRoles = roleNames.every(roleName => 
      userRoleNames.includes(roleName)
    );
    
    if (hasAllRoles) {
      return next();
    }
    
    const missingRoles = roleNames.filter(
      roleName => !userRoleNames.includes(roleName)
    );
    
    res.status(403).json({
      error: 'Forbidden',
      message: `Missing roles: ${missingRoles.join(', ')}`,
      userRoles: userRoleNames
    });
  };
}

// Usage (user must be both admin AND finance)
app.get('/api/finance/reports',
  authenticate,
  requireAllRoles(['admin', 'finance']),
  (req, res) => {
    res.json({ message: 'Financial reports' });
  }
);
```

**4. Permission-based middleware:**
```javascript
function requirePermission(permission) {
  return async (req, res, next) => {
    try {
      if (!req.user) {
        return res.status(401).json({ error: 'Authentication required' });
      }
      
      // Get user with populated roles
      const user = await User.findById(req.user.id)
        .populate('roles')
        .populate('extraPermissions');
      
      // Collect all permissions
      const allPermissions = new Set();
      
      // From roles
      user.roles.forEach(role => {
        if (role.permissions) {
          role.permissions.forEach(perm => allPermissions.add(perm));
        }
      });
      
      // Extra permissions
      if (user.extraPermissions) {
        user.extraPermissions.forEach(perm => allPermissions.add(perm));
      }
      
      // Check permission
      if (allPermissions.has(permission)) {
        return next();
      }
      
      // Check wildcard permissions
      const [resource, action] = permission.split('.');
      const wildcardPermission = `${resource}.*`;
      
      if (allPermissions.has(wildcardPermission)) {
        return next();
      }
      
      // Global admin permission
      if (allPermissions.has('*')) {
        return next();
      }
      
      res.status(403).json({
        error: 'Forbidden',
        message: `Requires permission: ${permission}`,
        userPermissions: Array.from(allPermissions)
      });
      
    } catch (err) {
      console.error('Permission middleware error:', err);
      res.status(500).json({ error: 'Authorization error' });
    }
  };
}

// Usage
app.delete('/api/users/:id',
  authenticate,
  requirePermission('users.delete'),
  async (req, res) => {
    await User.findByIdAndDelete(req.params.id);
    res.status(204).send();
  }
);
```

**5. Resource-specific middleware:**
```javascript
function requireResourcePermission(resource, action) {
  return async (req, res, next) => {
    const permission = `${resource}.${action}`;
    
    // Get resource ID from request
    const resourceId = req.params.id || req.body.id;
    
    try {
      if (!req.user) {
        return res.status(401).json({ error: 'Authentication required' });
      }
      
      // Check general permission first
      const user = await User.findById(req.user.id).populate('roles');
      const userPermissions = getUserPermissions(user);
      
      if (checkPermission(userPermissions, permission)) {
        return next();
      }
      
      // Check resource-specific permissions
      if (resourceId) {
        const resourceSpecificPermission = `${permission}:${resourceId}`;
        if (userPermissions.has(resourceSpecificPermission)) {
          return next();
        }
      }
      
      res.status(403).json({
        error: 'Forbidden',
        message: `Cannot ${action} ${resource}`,
        resourceId
      });
      
    } catch (err) {
      console.error('Resource permission error:', err);
      res.status(500).json({ error: 'Authorization error' });
    }
  };
}

// Usage
app.put('/api/posts/:id',
  authenticate,
  requireResourcePermission('posts', 'update'),
  async (req, res) => {
    const post = await Post.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    );
    res.json(post);
  }
);
```

**6. Cached permissions middleware:**
```javascript
// Store permissions in JWT or session to reduce DB queries
function requirePermissionCached(permission) {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ error: 'Authentication required' });
    }
    
    // Permissions stored in JWT
    const userPermissions = req.user.permissions || [];
    
    if (userPermissions.includes(permission)) {
      return next();
    }
    
    // Check wildcards
    const [resource, action] = permission.split('.');
    if (userPermissions.includes(`${resource}.*`)) {
      return next();
    }
    
    if (userPermissions.includes('*')) {
      return next();
    }
    
    // Fall back to database check
    return requirePermission(permission)(req, res, next);
  };
}

// Include permissions in JWT
function createAuthToken(user) {
  const permissions = await getUserPermissions(user);
  
  return jwt.sign(
    {
      userId: user.id,
      email: user.email,
      permissions: Array.from(permissions),
      roles: user.roles.map(role => role.name)
    },
    process.env.JWT_SECRET,
    { expiresIn: '1h' }
  );
}
```

**7. Combined middleware:**
```javascript
// Chain multiple authorization checks
function authorize(options = {}) {
  const middlewares = [];
  
  // Add authentication
  middlewares.push(authenticate);
  
  // Add role requirements
  if (options.roles) {
    if (Array.isArray(options.roles)) {
      middlewares.push(requireAnyRole(options.roles));
    } else {
      middlewares.push(requireRole(options.roles));
    }
  }
  
  // Add permission requirements
  if (options.permissions) {
    if (Array.isArray(options.permissions)) {
      // Require all permissions
      options.permissions.forEach(perm => {
        middlewares.push(requirePermission(perm));
      });
    } else {
      middlewares.push(requirePermission(options.permissions));
    }
  }
  
  // Add resource ownership check
  if (options.ownerField) {
    middlewares.push(requireOwnership(options.ownerField));
  }
  
  return middlewares;
}

// Usage
app.get('/api/posts/:id',
  ...authorize({
    permissions: 'posts.read',
    ownerField: 'authorId' // Additional check
  }),
  async (req, res) => {
    const post = await Post.findById(req.params.id);
    res.json(post);
  }
);

app.put('/api/posts/:id',
  ...authorize({
    roles: ['admin', 'editor'],
    permissions: 'posts.update'
  }),
  async (req, res) => {
    const post = await Post.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    );
    res.json(post);
  }
);
```

**8. Error handling middleware:**
```javascript
// Global authorization error handler
app.use((err, req, res, next) => {
  if (err.name === 'AuthorizationError') {
    return res.status(403).json({
      error: 'Forbidden',
      message: err.message,
      code: err.code
    });
  }
  
  if (err.name === 'AuthenticationError') {
    return res.status(401).json({
      error: 'Unauthorized',
      message: err.message
    });
  }
  
  next(err);
});

// Custom error classes
class AuthorizationError extends Error {
  constructor(message, code = 'FORBIDDEN') {
    super(message);
    this.name = 'AuthorizationError';
    this.code = code;
  }
}

class AuthenticationError extends Error {
  constructor(message) {
    super(message);
    this.name = 'AuthenticationError';
  }
}

// Usage in middleware
function requireAdmin(req, res, next) {
  if (!req.user.roles.includes('admin')) {
    throw new AuthorizationError('Admin access required', 'ADMIN_REQUIRED');
  }
  next();
}
```

**Best practices for authorization middleware:**
1. **Fail closed**: Deny by default
2. **Clear error messages**: Explain why access denied
3. **Log authorization failures**: For security monitoring
4. **Cache permissions**: Reduce database load
5. **Test thoroughly**: All role/permission combinations
6. **Keep it simple**: Avoid over-engineering
7. **Document requirements**: What each route requires

---
---

#### 5. How do you handle hierarchical permissions?

**Answer:**

**Hierarchical permissions** allow permissions to inherit from parent roles or resources.

**1. Role hierarchy:**
```javascript
// Define role inheritance
const roleHierarchy = {
  'super_admin': ['admin', 'moderator', 'user'],
  'admin': ['moderator', 'user'],
  'moderator': ['user'],
  'user': []
};

// Get all inherited roles
function getInheritedRoles(roleName) {
  const allRoles = new Set([roleName]);
  const queue = [roleName];
  
  while (queue.length > 0) {
    const currentRole = queue.shift();
    const childRoles = roleHierarchy[currentRole] || [];
    
    childRoles.forEach(childRole => {
      if (!allRoles.has(childRole)) {
        allRoles.add(childRole);
        queue.push(childRole);
      }
    });
  }
  
  return Array.from(allRoles);
}

// Get all permissions from inherited roles
async function getInheritedPermissions(roleName) {
  const inheritedRoles = getInheritedRoles(roleName);
  const allPermissions = new Set();
  
  // Get permissions from all inherited roles
  for (const role of inheritedRoles) {
    const roleDoc = await Role.findOne({ name: role });
    if (roleDoc && roleDoc.permissions) {
      roleDoc.permissions.forEach(perm => allPermissions.add(perm));
    }
  }
  
  return Array.from(allPermissions);
}

// Example
const adminPermissions = await getInheritedPermissions('admin');
// Includes: admin permissions + moderator permissions + user permissions
```

**2. Permission hierarchy (resource-based):**
```javascript
// Define resource hierarchy
const resourceHierarchy = {
  'organization': ['department', 'team', 'user'],
  'department': ['team', 'user'],
  'team': ['user'],
  'user': []
};

// Check if user has permission on resource or parent
async function hasHierarchicalPermission(userId, resourceType, resourceId, action) {
  const user = await User.findById(userId).populate('roles');
  const userPermissions = getUserPermissions(user);
  
  // Check direct permission
  const directPermission = `${resourceType}.${action}`;
  if (userPermissions.has(directPermission)) {
    return true;
  }
  
  // Check parent resources
  const parentTypes = getParentResources(resourceType);
  
  for (const parentType of parentTypes) {
    const parentPermission = `${parentType}.${action}`;
    
    if (userPermissions.has(parentPermission)) {
      // Check if user has access to this specific parent resource
      const hasAccess = await checkResourceAccess(
        userId,
        parentType,
        resourceId,
        resourceType
      );
      
      if (hasAccess) {
        return true;
      }
    }
  }
  
  return false;
}

// Get parent resource types
function getParentResources(resourceType) {
  const parents = [];
  
  for (const [parent, children] of Object.entries(resourceHierarchy)) {
    if (children.includes(resourceType)) {
      parents.push(parent);
    }
  }
  
  return parents;
}
```

**3. Organization hierarchy example:**
```javascript
// Models
const organizationSchema = new mongoose.Schema({
  name: String,
  parent: { type: mongoose.Schema.Types.ObjectId, ref: 'Organization' }
});

const userSchema = new mongoose.Schema({
  email: String,
  organization: { type: mongoose.Schema.Types.ObjectId, ref: 'Organization' },
  roles: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Role' }]
});

// Check if user can access resource in organization hierarchy
async function canAccessResource(userId, resourceId, resourceType) {
  const user = await User.findById(userId).populate('organization');
  const resource = await mongoose.model(resourceType).findById(resourceId)
    .populate('organization');
  
  if (!user.organization || !resource.organization) {
    return false;
  }
  
  // Check if user's organization is ancestor of resource's organization
  return isAncestor(user.organization, resource.organization);
}

// Check if org1 is ancestor of org2
async function isAncestor(org1Id, org2Id) {
  if (org1Id.equals(org2Id)) {
    return true;
  }
  
  let current = await Organization.findById(org2Id);
  
  while (current && current.parent) {
    if (current.parent.equals(org1Id)) {
      return true;
    }
    current = await Organization.findById(current.parent);
  }
  
  return false;
}
```

**4. Team-based hierarchy:**
```javascript
// Team membership with roles
const teamMemberSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  team: { type: mongoose.Schema.Types.ObjectId, ref: 'Team' },
  role: { type: String, enum: ['owner', 'admin', 'member', 'guest'] },
  permissions: [String] // Team-specific permissions
});

// Check team hierarchy permission
async function hasTeamPermission(userId, teamId, permission) {
  // Get team membership
  const membership = await TeamMember.findOne({
    user: userId,
    team: teamId
  });
  
  if (!membership) {
    return false;
  }
  
  // Check team-specific permissions
  if (membership.permissions.includes(permission)) {
    return true;
  }
  
  // Check role-based permissions
  const rolePermissions = {
    owner: ['team.manage', 'team.delete', 'team.invite', 'team.kick'],
    admin: ['team.manage', 'team.invite', 'team.kick'],
    member: ['team.view', 'team.post'],
    guest: ['team.view']
  };
  
  if (rolePermissions[membership.role]?.includes(permission)) {
    return true;
  }
  
  // Check inherited permissions from parent teams
  const team = await Team.findById(teamId).populate('parent');
  if (team.parent) {
    return hasTeamPermission(userId, team.parent._id, permission);
  }
  
  return false;
}
```

**5. Document hierarchy (folders/files):**
```javascript
// Document/folder structure
const documentSchema = new mongoose.Schema({
  name: String,
  type: { type: String, enum: ['folder', 'file'] },
  parent: { type: mongoose.Schema.Types.ObjectId, ref: 'Document' },
  permissions: [{
    user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
    level: { type: String, enum: ['read', 'write', 'admin'] }
  }]
});

// Check document permission with inheritance
async function hasDocumentPermission(userId, documentId, level) {
  const document = await Document.findById(documentId);
  
  // Check direct permission
  const directPermission = document.permissions.find(
    p => p.user.equals(userId) && p.level === level
  );
  
  if (directPermission) {
    return true;
  }
  
  // Check inherited permissions from parent
  if (document.parent) {
    return hasDocumentPermission(userId, document.parent, level);
  }
  
  // Check default permissions
  const defaultPermissions = {
    'read': ['read', 'write', 'admin'],
    'write': ['write', 'admin'],
    'admin': ['admin']
  };
  
  const userDefault = await UserDefaultPermission.findOne({
    user: userId,
    documentType: document.type
  });
  
  if (userDefault && defaultPermissions[userDefault.level]?.includes(level)) {
    return true;
  }
  
  return false;
}
```

**6. Hierarchical RBAC middleware:**
```javascript
function requireHierarchicalPermission(resourceType, action) {
  return async (req, res, next) => {
    try {
      const userId = req.user.id;
      const resourceId = req.params.id;
      
      // Get user's organization/team context
      const user = await User.findById(userId)
        .populate('organization')
        .populate('teams');
      
      // Get resource
      const Resource = mongoose.model(resourceType);
      const resource = await Resource.findById(resourceId)
        .populate('organization')
        .populate('parent');
      
      if (!resource) {
        return res.status(404).json({ error: 'Resource not found' });
      }
      
      // Check hierarchical permission
      let hasPermission = false;
      
      // 1. Check direct permission
      const directPermission = `${resourceType}.${action}`;
      if (await hasDirectPermission(userId, directPermission)) {
        hasPermission = true;
      }
      
      // 2. Check organization hierarchy
      if (!hasPermission && resource.organization) {
        if (user.organization && 
            await isAncestor(user.organization._id, resource.organization._id)) {
          
          const orgPermission = `organization.${action}`;
          if (await hasDirectPermission(userId, orgPermission)) {
            hasPermission = true;
          }
        }
      }
      
      // 3. Check team hierarchy
      if (!hasPermission && resource.team) {
        for (const team of user.teams) {
          if (await isTeamAncestor(team._id, resource.team._id)) {
            const teamPermission = `team.${action}`;
            if (await hasDirectPermission(userId, teamPermission)) {
              hasPermission = true;
              break;
            }
          }
        }
      }
      
      if (hasPermission) {
        return next();
      }
      
      res.status(403).json({
        error: 'Forbidden',
        message: `Cannot ${action} ${resourceType}`,
        resourceId,
        resourceType
      });
      
    } catch (err) {
      console.error('Hierarchical permission error:', err);
      res.status(500).json({ error: 'Authorization error' });
    }
  };
}
```

**7. Caching hierarchical permissions:**
```javascript
// Cache hierarchy results
const hierarchyCache = new Map();

async function getCachedHierarchy(userId, resourceType) {
  const cacheKey = `${userId}:${resourceType}`;
  
  if (hierarchyCache.has(cacheKey)) {
    return hierarchyCache.get(cacheKey);
  }
  
  // Calculate hierarchy
  const hierarchy = await calculateHierarchy(userId, resourceType);
  
  // Cache for 5 minutes
  hierarchyCache.set(cacheKey, hierarchy);
  setTimeout(() => {
    hierarchyCache.delete(cacheKey);
  }, 5 * 60 * 1000);
  
  return hierarchy;
}

// Precompute user's access tree
async function precomputeUserAccess(userId) {
  const user = await User.findById(userId)
    .populate('roles')
    .populate('organization')
    .populate('teams');
  
  const accessTree = {
    permissions: new Set(),
    organizations: new Set(),
    teams: new Set(),
    resources: {}
  };
  
  // Add role permissions
  for (const role of user.roles) {
    if (role.permissions) {
      role.permissions.forEach(perm => accessTree.permissions.add(perm));
    }
  }
  
  // Add organization access
  if (user.organization) {
    accessTree.organizations.add(user.organization._id.toString());
    
    // Add child organizations
    const childOrgs = await getChildOrganizations(user.organization._id);
    childOrgs.forEach(org => {
      accessTree.organizations.add(org._id.toString());
    });
  }
  
  // Add team access
  for (const team of user.teams) {
    accessTree.teams.add(team._id.toString());
    
    // Add child teams
    const childTeams = await getChildTeams(team._id);
    childTeams.forEach(childTeam => {
      accessTree.teams.add(childTeam._id.toString());
    });
  }
  
  // Store in user session or cache
  req.session.accessTree = accessTree;
  
  return accessTree;
}
```

**8. Testing hierarchical permissions:**
```javascript
describe('Hierarchical Permissions', () => {
  let orgAdmin, deptManager, teamLead, regularUser;
  let organization, department, team;
  
  before(async () => {
    // Create hierarchy
    organization = await Organization.create({ name: 'Company' });
    department = await Organization.create({ 
      name: 'Engineering', 
      parent: organization._id 
    });
    team = await Organization.create({ 
      name: 'Backend', 
      parent: department._id 
    });
    
    // Create users
    orgAdmin = await User.create({
      email: 'admin@company.com',
      organization: organization._id,
      roles: ['org_admin']
    });
    
    deptManager = await User.create({
      email: 'manager@engineering.com',
      organization: department._id,
      roles: ['dept_manager']
    });
    
    teamLead = await User.create({
      email: 'lead@backend.com',
      organization: team._id,
      roles: ['team_lead']
    });
    
    regularUser = await User.create({
      email: 'user@backend.com',
      organization: team._id,
      roles: ['user']
    });
  });
  
  it('should allow org admin to access all levels', async () => {
    const canAccessTeam = await canAccessResource(
      orgAdmin._id,
      team._id,
      'Organization'
    );
    expect(canAccessTeam).toBe(true);
  });
  
  it('should allow dept manager to access department and team', async () => {
    const canAccessDept = await canAccessResource(
      deptManager._id,
      department._id,
      'Organization'
    );
    expect(canAccessDept).toBe(true);
    
    const canAccessTeam = await canAccessResource(
      deptManager._id,
      team._id,
      'Organization'
    );
    expect(canAccessTeam).toBe(true);
  });
  
  it('should not allow team lead to access department', async () => {
    const canAccessDept = await canAccessResource(
      teamLead._id,
      department._id,
      'Organization'
    );
    expect(canAccessDept).toBe(false);
  });
});
```

**Best practices for hierarchical permissions:**
1. **Keep hierarchy shallow**: Deep hierarchies are complex
2. **Document hierarchy rules**: Clear inheritance rules
3. **Cache hierarchy results**: Performance optimization
4. **Test all levels**: Test each hierarchy level
5. **Consider circular references**: Prevent infinite loops
6. **Implement audit trails**: Track permission inheritance
7. **Provide visualization tools**: Help understand hierarchy
8. **Limit hierarchy depth**: Practical limits (3-5 levels)

---
---

## 27. MongoDB with Mongoose

#### 1. How do you connect to MongoDB in Node.js?

**Answer:**

**Using native MongoDB driver:**
```javascript
const { MongoClient } = require('mongodb');

async function connectWithNativeDriver() {
  const uri = 'mongodb://localhost:27017';
  const client = new MongoClient(uri);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const database = client.db('mydatabase');
    const collection = database.collection('users');
    
    // Perform operations
    const result = await collection.insertOne({ name: 'John', age: 30 });
    console.log('Inserted document:', result.insertedId);
    
  } finally {
    await client.close();
  }
}
```

**Using Mongoose (recommended):**
```javascript
const mongoose = require('mongoose');

// Basic connection
mongoose.connect('mongodb://localhost:27017/mydatabase')
  .then(() => console.log('Connected to MongoDB'))
  .catch(err => console.error('Connection error:', err));

// With options
mongoose.connect('mongodb://localhost:27017/mydatabase', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  serverSelectionTimeoutMS: 5000, // Timeout after 5s
  socketTimeoutMS: 45000, // Close sockets after 45s inactivity
  family: 4 // Use IPv4, skip trying IPv6
});

// Connection events
mongoose.connection.on('connected', () => {
  console.log('Mongoose connected to MongoDB');
});

mongoose.connection.on('error', (err) => {
  console.error('Mongoose connection error:', err);
});

mongoose.connection.on('disconnected', () => {
  console.log('Mongoose disconnected');
});

// Graceful shutdown
process.on('SIGINT', async () => {
  await mongoose.connection.close();
  console.log('Mongoose connection closed through app termination');
  process.exit(0);
});
```

**Connection pooling:**
```javascript
// Configure connection pool
mongoose.connect('mongodb://localhost:27017/mydatabase', {
  poolSize: 10, // Maintain up to 10 socket connections
  maxPoolSize: 50, // Maximum pool size
  minPoolSize: 5, // Minimum pool size
  maxIdleTimeMS: 10000, // Close idle connections after 10s
  waitQueueTimeoutMS: 5000 // Timeout for connection acquisition
});
```

**Multiple connections:**
```javascript
// Create separate connections
const mainConnection = mongoose.createConnection(
  'mongodb://localhost:27017/maindb',
  { useNewUrlParser: true, useUnifiedTopology: true }
);

const analyticsConnection = mongoose.createConnection(
  'mongodb://localhost:27017/analyticsdb',
  { useNewUrlParser: true, useUnifiedTopology: true }
);

// Use different connections for different models
const User = mainConnection.model('User', userSchema);
const Analytics = analyticsConnection.model('Analytics', analyticsSchema);
```

**Replica set connection:**
```javascript
// Connect to replica set
mongoose.connect('mongodb://host1:27017,host2:27017,host3:27017/mydatabase?replicaSet=myReplicaSet', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  readPreference: 'secondaryPreferred', // Read from secondary when possible
  retryWrites: true,
  w: 'majority' // Write concern
});
```

**Authentication:**
```javascript
// With username/password
mongoose.connect('mongodb://username:password@localhost:27017/mydatabase', {
  authSource: 'admin' // Authentication database
});

// With options object
mongoose.connect('mongodb://localhost:27017/mydatabase', {
  auth: {
    username: 'myuser',
    password: 'mypassword'
  },
  authSource: 'admin'
});
```

**Environment-based configuration:**
```javascript
// config/database.js
const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    const conn = await mongoose.connect(process.env.MONGODB_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
      useCreateIndex: true,
      useFindAndModify: false
    });
    
    console.log(`MongoDB Connected: ${conn.connection.host}`);
    return conn;
  } catch (error) {
    console.error(`Error: ${error.message}`);
    process.exit(1);
  }
};

module.exports = connectDB;

// app.js
const connectDB = require('./config/database');
connectDB();
```

**Connection status helpers:**
```javascript
// Check connection state
function getConnectionStatus() {
  const states = {
    0: 'disconnected',
    1: 'connected',
    2: 'connecting',
    3: 'disconnecting',
    99: 'uninitialized'
  };
  
  return {
    state: states[mongoose.connection.readyState],
    host: mongoose.connection.host,
    port: mongoose.connection.port,
    name: mongoose.connection.name,
    models: Object.keys(mongoose.connection.models)
  };
}

// Health check endpoint
app.get('/health', (req, res) => {
  const status = getConnectionStatus();
  
  if (status.state === 'connected') {
    res.json({ 
      status: 'healthy',
      database: 'connected',
      ...status
    });
  } else {
    res.status(503).json({
      status: 'unhealthy',
      database: status.state,
      ...status
    });
  }
});
```

**Best practices:**
1. **Use environment variables** for connection strings
2. **Enable connection pooling** for performance
3. **Handle connection errors** gracefully
4. **Monitor connection state**
5. **Use Mongoose for ODM features**
6. **Implement retry logic** for production
7. **Close connections** on app shutdown

---

#### 2. What is Mongoose and why use it?

**Answer:**

**Mongoose** is an ODM (Object Document Mapper) for MongoDB and Node.js.

**Why use Mongoose:**

**1. Schema definition:**
```javascript
// Without Mongoose (raw MongoDB)
const user = {
  name: 'John',
  email: 'john@example.com',
  age: 30
};
// No validation, no structure

// With Mongoose
const userSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  age: { type: Number, min: 18, max: 100 }
});

const User = mongoose.model('User', userSchema);
// Automatic validation, structure enforcement
```

**2. Data validation:**
```javascript
const productSchema = new mongoose.Schema({
  name: { 
    type: String, 
    required: [true, 'Product name is required'],
    trim: true,
    minlength: [3, 'Name must be at least 3 characters'],
    maxlength: [100, 'Name cannot exceed 100 characters']
  },
  price: {
    type: Number,
    required: true,
    min: [0, 'Price cannot be negative'],
    validate: {
      validator: Number.isInteger,
      message: 'Price must be an integer'
    }
  },
  category: {
    type: String,
    enum: ['electronics', 'clothing', 'books', 'other']
  }
});

// Automatic validation on save
const product = new Product({ name: 'Laptop', price: -100 });
await product.save(); // Throws validation error
```

**3. Middleware/hooks:**
```javascript
userSchema.pre('save', function(next) {
  if (this.isModified('password')) {
    this.password = hashPassword(this.password);
  }
  next();
});

userSchema.post('save', function(doc) {
  console.log(`User ${doc.email} was saved`);
});

userSchema.pre('remove', function(next) {
  // Clean up related data
  next();
});
```

**4. Query building:**
```javascript
// Without Mongoose
db.collection('users').find({ 
  age: { $gt: 18 },
  status: 'active'
}).sort({ createdAt: -1 }).limit(10);

// With Mongoose
User.find({ age: { $gt: 18 }, status: 'active' })
  .sort('-createdAt')
  .limit(10)
  .select('name email age')
  .lean(); // Returns plain JavaScript objects
```

**5. Population (relationships):**
```javascript
// Define relationships
const authorSchema = new mongoose.Schema({
  name: String,
  books: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Book' }]
});

const bookSchema = new mongoose.Schema({
  title: String,
  author: { type: mongoose.Schema.Types.ObjectId, ref: 'Author' }
});

// Populate related data
const book = await Book.findById(bookId).populate('author');
// book.author now contains author document
```

**6. Instance methods:**
```javascript
userSchema.methods.getFullName = function() {
  return `${this.firstName} ${this.lastName}`;
};

userSchema.methods.isAdult = function() {
  return this.age >= 18;
};

// Usage
const user = await User.findById(userId);
console.log(user.getFullName());
console.log(user.isAdult());
```

**7. Static methods:**
```javascript
userSchema.statics.findByEmail = function(email) {
  return this.findOne({ email });
};

userSchema.statics.findAdults = function() {
  return this.find({ age: { $gte: 18 } });
};

// Usage
const user = await User.findByEmail('john@example.com');
const adults = await User.findAdults();
```

**8. Virtual properties:**
```javascript
userSchema.virtual('fullName').get(function() {
  return `${this.firstName} ${this.lastName}`;
});

userSchema.virtual('profileUrl').get(function() {
  return `/users/${this.username}`;
});

// Usage
const user = await User.findById(userId);
console.log(user.fullName); // Computed property
console.log(user.profileUrl);
```

**9. Plugins (reusable functionality):**
```javascript
// Create a plugin
function timestampPlugin(schema) {
  schema.add({
    createdAt: { type: Date, default: Date.now },
    updatedAt: { type: Date, default: Date.now }
  });
  
  schema.pre('save', function(next) {
    this.updatedAt = Date.now();
    next();
  });
}

// Use the plugin
userSchema.plugin(timestampPlugin);
productSchema.plugin(timestampPlugin);
```

**10. Type casting:**
```javascript
// Automatic type conversion
const user = new User({
  name: 'John',
  age: '30', // String gets converted to Number
  createdAt: '2024-01-15' // String gets converted to Date
});

await user.save();
// age is stored as Number 30
// createdAt is stored as Date object
```

**Mongoose vs native driver comparison:**

| Feature | Native MongoDB Driver | Mongoose |
|---------|----------------------|----------|
| **Schema** | No built-in schemas | Strong schema support |
| **Validation** | Manual validation | Built-in validation |
| **Relationships** | Manual references | Population support |
| **Middleware** | Not available | Pre/post hooks |
| **Type casting** | Manual | Automatic |
| **Query building** | Raw queries | Chainable API |
| **Performance** | Faster | Slightly slower |
| **Learning curve** | Steeper | Easier |

**When to use Mongoose:**
- Building applications with complex data models
- Need data validation and structure
- Working with relationships between collections
- Want to use middleware/hooks
- Prefer declarative schema definitions

**When to use native driver:**
- Need maximum performance
- Working with unstructured data
- Simple CRUD operations
- Already familiar with MongoDB query language
- Don't need schema validation

**Common Mongoose plugins:**
- `mongoose-unique-validator`: Better unique validation
- `mongoose-paginate-v2`: Pagination support
- `mongoose-autopopulate`: Auto-populate references
- `mongoose-beautiful-unique-validation`: Human-readable unique errors
- `mongoose-timestamp`: Automatic timestamps

---
---

#### 3. How do you define Mongoose schemas and models?

**Answer:**

**Schema definition:**
```javascript
const mongoose = require('mongoose');
const { Schema } = mongoose;

// Basic schema
const userSchema = new Schema({
  // String type with validation
  name: {
    type: String,
    required: [true, 'Name is required'],
    trim: true,
    minlength: [2, 'Name must be at least 2 characters'],
    maxlength: [50, 'Name cannot exceed 50 characters']
  },
  
  // Number type with validation
  age: {
    type: Number,
    min: [0, 'Age cannot be negative'],
    max: [150, 'Age cannot exceed 150'],
    default: 18
  },
  
  // Date type
  birthDate: {
    type: Date,
    validate: {
      validator: function(v) {
        return v < new Date(); // Must be in the past
      },
      message: 'Birth date must be in the past'
    }
  },
  
  // Boolean type
  isActive: {
    type: Boolean,
    default: true
  },
  
  // Array type
  hobbies: [String], // Array of strings
  
  // Object type
  address: {
    street: String,
    city: String,
    country: {
      type: String,
      default: 'USA'
    },
    zipCode: String
  },
  
  // Mixed type (any data)
  metadata: Schema.Types.Mixed,
  
  // ObjectId reference
  department: {
    type: Schema.Types.ObjectId,
    ref: 'Department' // Reference to another model
  },
  
  // Enum type
  role: {
    type: String,
    enum: ['user', 'editor', 'admin'],
    default: 'user'
  },
  
  // Unique field
  email: {
    type: String,
    required: true,
    unique: true,
    lowercase: true,
    match: [/^\S+@\S+\.\S+$/, 'Please enter a valid email']
  },
  
  // Custom getter/setter
  salary: {
    type: Number,
    get: v => Math.round(v), // Getter: round when reading
    set: v => Math.round(v)  // Setter: round when setting
  },
  
  // Indexed field
  username: {
    type: String,
    unique: true,
    index: true // Create database index
  },
  
  // Virtual field (not stored in DB)
  fullName: {
    type: String,
    get: function() {
      return `${this.firstName} ${this.lastName}`;
    }
  }
}, {
  // Schema options
  timestamps: true, // Adds createdAt and updatedAt
  toJSON: { virtuals: true, getters: true },
  toObject: { virtuals: true, getters: true }
});
```

**Model creation:**
```javascript
// Create model from schema
const User = mongoose.model('User', userSchema);

// Or with custom collection name
const User = mongoose.model('User', userSchema, 'users_collection');

// Export for use in other files
module.exports = User;
```

**Schema options:**
```javascript
const options = {
  // Timestamps
  timestamps: {
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    currentTime: () => Math.floor(Date.now() / 1000) // Unix timestamp
  },
  
  // Collection name
  collection: 'custom_users',
  
  // Auto-create indexes
  autoIndex: true,
  
  // Version key
  versionKey: '__v',
  
  // Minimize (remove empty objects)
  minimize: false,
  
  // ID virtual
  id: true,
  
  // ToJSON/ToObject options
  toJSON: {
    virtuals: true,
    transform: function(doc, ret) {
      delete ret.password; // Remove password from JSON
      delete ret.__v;      // Remove version key
      return ret;
    }
  },
  
  toObject: {
    virtuals: true
  },
  
  // Strict mode (only save fields defined in schema)
  strict: true,
  
  // Collation (string comparison rules)
  collation: { locale: 'en', strength: 2 }
};

const userSchema = new Schema({
  name: String,
  email: String
}, options);
```

**Virtual properties:**
```javascript
// Virtual getter
userSchema.virtual('fullName').get(function() {
  return `${this.firstName} ${this.lastName}`;
});

// Virtual setter
userSchema.virtual('fullName').set(function(name) {
  const [firstName, lastName] = name.split(' ');
  this.firstName = firstName;
  this.lastName = lastName;
});

// Virtual with options
userSchema.virtual('profileUrl').get(function() {
  return `/users/${this._id}`;
});

// Virtual that requires population
userSchema.virtual('posts', {
  ref: 'Post', // The model to use
  localField: '_id', // Find posts where `author`
  foreignField: 'author', // is equal to `_id`
  justOne: false // Get an array
});
```

**Instance methods:**
```javascript
// Add instance methods
userSchema.methods.getAge = function() {
  const ageDifMs = Date.now() - this.birthDate.getTime();
  const ageDate = new Date(ageDifMs);
  return Math.abs(ageDate.getUTCFullYear() - 1970);
};

userSchema.methods.activate = function() {
  this.isActive = true;
  return this.save();
};

userSchema.methods.toJSON = function() {
  const obj = this.toObject();
  delete obj.password;
  delete obj.__v;
  return obj;
};

// Usage
const user = await User.findById(userId);
console.log(user.getAge());
await user.activate();
```

**Static methods:**
```javascript
// Add static methods
userSchema.statics.findByEmail = function(email) {
  return this.findOne({ email: email.toLowerCase() });
};

userSchema.statics.findActive = function() {
  return this.find({ isActive: true });
};

userSchema.statics.paginate = async function(query, options) {
  const { page = 1, limit = 10, sort = '-createdAt' } = options;
  const skip = (page - 1) * limit;
  
  const [docs, total] = await Promise.all([
    this.find(query)
      .sort(sort)
      .skip(skip)
      .limit(limit),
    this.countDocuments(query)
  ]);
  
  return {
    docs,
    total,
    page,
    pages: Math.ceil(total / limit),
    limit
  };
};

// Usage
const user = await User.findByEmail('john@example.com');
const activeUsers = await User.findActive();
const paginated = await User.paginate(
  { isActive: true },
  { page: 2, limit: 20 }
);
```

**Query helpers:**
```javascript
// Add query helpers
userSchema.query.byName = function(name) {
  return this.where({ name: new RegExp(name, 'i') });
};

userSchema.query.active = function() {
  return this.where({ isActive: true });
};

userSchema.query.olderThan = function(age) {
  return this.where('age').gt(age);
};

// Usage
const users = await User.find()
  .byName('john')
  .active()
  .olderThan(18);
```

**Indexes:**
```javascript
// Single field index
userSchema.index({ email: 1 }); // Ascending
userSchema.index({ createdAt: -1 }); // Descending

// Compound index
userSchema.index({ isActive: 1, createdAt: -1 });

// Unique index
userSchema.index({ email: 1 }, { unique: true });

// Sparse index (only index documents with the field)
userSchema.index({ phone: 1 }, { sparse: true });

// Text index for search
userSchema.index({ name: 'text', bio: 'text' });

// 2dsphere index for geospatial
userSchema.index({ location: '2dsphere' });

// Partial index (only index documents matching filter)
userSchema.index(
  { email: 1 },
  { 
    partialFilterExpression: { 
      email: { $exists: true } 
    }
  }
);

// Background index creation
userSchema.index({ name: 1 }, { background: true });
```

**Plugins:**
```javascript
// Create a reusable plugin
function softDeletePlugin(schema) {
  schema.add({
    deleted: {
      type: Boolean,
      default: false,
      index: true
    },
    deletedAt: Date
  });
  
  // Override find to exclude deleted documents
  schema.pre(/^find/, function(next) {
    if (!this.getQuery().deleted) {
      this.where({ deleted: false });
    }
    next();
  });
  
  // Soft delete method
  schema.methods.softDelete = function() {
    this.deleted = true;
    this.deletedAt = new Date();
    return this.save();
  };
  
  // Restore method
  schema.methods.restore = function() {
    this.deleted = false;
    this.deletedAt = undefined;
    return this.save();
  };
  
  // Static method to find deleted
  schema.statics.findDeleted = function() {
    return this.find({ deleted: true });
  };
}

// Use the plugin
userSchema.plugin(softDeletePlugin);
postSchema.plugin(softDeletePlugin);
```

**Discriminators (inheritance):**
```javascript
// Base schema
const options = { discriminatorKey: 'kind' };
const eventSchema = new Schema({
  title: String,
  date: Date
}, options);

const Event = mongoose.model('Event', eventSchema);

// Discriminator schemas
const concertSchema = new Schema({
  artist: String,
  venue: String,
  ticketPrice: Number
});

const conferenceSchema = new Schema({
  topic: String,
  speakers: [String],
  location: String
});

// Create discriminators
const Concert = Event.discriminator('Concert', concertSchema);
const Conference = Event.discriminator('Conference', conferenceSchema);

// Usage
const concert = new Concert({
  title: 'Rock Festival',
  date: new Date('2024-06-15'),
  artist: 'The Band',
  venue: 'Stadium'
});

await concert.save();
// Stored with kind: 'Concert'
```

**Schema best practices:**
1. **Define all fields** explicitly
2. **Use appropriate data types**
3. **Add validation** for important fields
4. **Create indexes** for frequently queried fields
5. **Use plugins** for reusable functionality
6. **Add timestamps** for auditing
7. **Define virtuals** for computed properties
8. **Add instance/static methods** for business logic
9. **Use discriminators** for inheritance
10. **Test schemas** thoroughly

---
---

#### 4. What are Mongoose middleware (pre/post hooks)?

**Answer:**

**Mongoose middleware** are functions that run before or after certain operations.

**Types of middleware:**
1. **Document middleware**: `validate`, `save`, `remove`
2. **Query middleware**: `find`, `findOne`, `update`, `delete`
3. **Aggregate middleware**: `aggregate`
4. **Model middleware**: `insertMany`

**Document middleware:**
```javascript
const userSchema = new Schema({
  name: String,
  email: String,
  password: String,
  createdAt: Date,
  updatedAt: Date
});

// PRE save (runs before saving)
userSchema.pre('save', function(next) {
  // 'this' refers to the document being saved
  
  // Hash password if modified
  if (this.isModified('password')) {
    this.password = hashPassword(this.password);
  }
  
  // Set timestamps
  if (this.isNew) {
    this.createdAt = new Date();
  }
  this.updatedAt = new Date();
  
  next(); // Continue with save
});

// POST save (runs after saving)
userSchema.post('save', function(doc, next) {
  // 'doc' is the saved document
  
  // Send welcome email
  sendWelcomeEmail(doc.email);
  
  // Log the save
  console.log(`User ${doc.email} was saved`);
  
  next();
});

// PRE validate (runs before validation)
userSchema.pre('validate', function(next) {
  // Clean up data before validation
  if (this.name) {
    this.name = this.name.trim();
  }
  
  next();
});

// POST validate (runs after validation)
userSchema.post('validate', function(doc, next) {
  console.log(`${doc.name} passed validation`);
  next();
});

// PRE remove (runs before removing)
userSchema.pre('remove', function(next) {
  // 'this' refers to document being removed
  
  // Clean up related data
  return Post.deleteMany({ author: this._id })
    .then(() => next())
    .catch(next);
});

// POST remove (runs after removing)
userSchema.post('remove', function(doc, next) {
  console.log(`User ${doc.email} was removed`);
  next();
});
```

**Query middleware:**
```javascript
// PRE find (runs before find queries)
userSchema.pre('find', function(next) {
  // 'this' refers to the query object
  
  // Only find active users by default
  if (!this.getQuery().deleted) {
    this.where({ isActive: true });
  }
  
  next();
});

// POST find (runs after find queries)
userSchema.post('find', function(docs, next) {
  // 'docs' is array of found documents
  
  // Log query results
  console.log(`Found ${docs.length} users`);
  
  // Add virtual property to each document
  docs.forEach(doc => {
    doc.wasFound = true;
  });
  
  next();
});

// PRE findOne (runs before findOne)
userSchema.pre('findOne', function(next) {
  // Add default sorting
  if (!this.options.sort) {
    this.sort({ createdAt: -1 });
  }
  
  next();
});

// POST findOne (runs after findOne)
userSchema.post('findOne', function(doc, next) {
  if (doc) {
    console.log(`Found user: ${doc.email}`);
  }
  next();
});

// PRE update (runs before update queries)
userSchema.pre('update', function(next) {
  // 'this' refers to the query object
  
  // Add updatedAt timestamp
  this.set({ updatedAt: new Date() });
  
  next();
});

// POST update (runs after update queries)
userSchema.post('update', function(result, next) {
  // 'result' is the update result object
  console.log(`Updated ${result.nModified} documents`);
  next();
});

// PRE delete (runs before delete queries)
userSchema.pre('delete', function(next) {
  // Log deletion attempts
  console.log('Attempting to delete users:', this.getQuery());
  next();
});

// POST delete (runs after delete queries)
userSchema.post('delete', function(result, next) {
  console.log(`Deleted ${result.deletedCount} users`);
  next();
});
```

**Aggregate middleware:**
```javascript
// PRE aggregate (runs before aggregation)
userSchema.pre('aggregate', function(next) {
  // 'this' refers to the aggregation object
  
  // Add default match stage for active users
  this.pipeline().unshift({
    $match: { isActive: true }
  });
  
  next();
});

// POST aggregate (runs after aggregation)
userSchema.post('aggregate', function(result, next) {
  console.log(`Aggregation returned ${result.length} results`);
  next();
});
```

**Model middleware:**
```javascript
// PRE insertMany (runs before insertMany)
userSchema.pre('insertMany', function(next, docs) {
  // 'docs' is array of documents to insert
  
  // Add timestamps to each document
  const now = new Date();
  docs.forEach(doc => {
    doc.createdAt = now;
    doc.updatedAt = now;
  });
  
  next();
});

// POST insertMany (runs after insertMany)
userSchema.post('insertMany', function(docs, next) {
  console.log(`Inserted ${docs.length} users`);
  next();
});
```

**Async middleware:**
```javascript
// Async middleware with async/await
userSchema.pre('save', async function(next) {
  try {
    // Check if email is unique
    const existingUser = await this.constructor.findOne({
      email: this.email,
      _id: { $ne: this._id } // Exclude current document
    });
    
    if (existingUser) {
      throw new Error('Email already exists');
    }
    
    // Generate API key
    if (this.isNew) {
      this.apiKey = generateApiKey();
    }
    
    next();
  } catch (err) {
    next(err);
  }
});

// Async middleware with promises
userSchema.pre('save', function() {
  return new Promise((resolve, reject) => {
    // Async operation
    someAsyncOperation()
      .then(() => resolve())
      .catch(reject);
  });
});
```

**Error handling in middleware:**
```javascript
// Error handling
userSchema.pre('save', function(next) {
  try {
    // Some validation
    if (!this.email.includes('@')) {
      throw new Error('Invalid email format');
    }
    
    next();
  } catch (err) {
    next(err); // Pass error to Mongoose
  }
});

// Or pass error directly
userSchema.pre('save', function(next) {
  if (this.age < 0) {
    return next(new Error('Age cannot be negative'));
  }
  next();
});
```

**Conditional middleware:**
```javascript
// Run middleware only for certain operations
userSchema.pre('save', function(next) {
  // Only run if password was modified
  if (!this.isModified('password')) {
    return next();
  }
  
  // Hash password
  this.password = hashPassword(this.password);
  next();
});

// Run middleware based on document state
userSchema.pre('save', function(next) {
  // Only for new documents
  if (this.isNew) {
    this.createdAt = new Date();
  }
  
  // Always update updatedAt
  this.updatedAt = new Date();
  
  next();
});
```

**Multiple middleware functions:**
```javascript
// Multiple pre-save middleware
userSchema.pre('save', function(next) {
  console.log('Middleware 1: Starting save');
  next();
});

userSchema.pre('save', function(next) {
  console.log('Middleware 2: Validating data');
  next();
});

userSchema.pre('save', function(next) {
  console.log('Middleware 3: Processing data');
  next();
});

userSchema.post('save', function(doc, next) {
  console.log('Middleware 4: Post-save operations');
  next();
});

// Execution order:
// 1. Middleware 1
// 2. Middleware 2  
// 3. Middleware 3
// 4. Save operation
// 5. Middleware 4
```

**Middleware for specific paths:**
```javascript
// Middleware that only runs when specific fields change
userSchema.pre('save', function(next) {
  // Check if specific fields were modified
  const modifiedPaths = this.modifiedPaths();
  
  if (modifiedPaths.includes('email')) {
    console.log('Email was changed, sending verification');
    sendVerificationEmail(this.email);
  }
  
  if (modifiedPaths.includes('password')) {
    console.log('Password was changed, invalidating sessions');
    invalidateUserSessions(this._id);
  }
  
  next();
});
```

**Middleware with options:**
```javascript
// Custom middleware with options
function timestampMiddleware(schema, options) {
  const createdAt = options.createdAt || 'createdAt';
  const updatedAt = options.updatedAt || 'updatedAt';
  
  schema.add({
    [createdAt]: { type: Date, default: Date.now },
    [updatedAt]: { type: Date, default: Date.now }
  });
  
  schema.pre('save', function(next) {
    if (this.isNew) {
      this[createdAt] = new Date();
    }
    this[updatedAt] = new Date();
    next();
  });
  
  schema.pre('update', function(next) {
    this.set({ [updatedAt]: new Date() });
    next();
  });
}

// Use with options
userSchema.plugin(timestampMiddleware, {
  createdAt: 'created_at',
  updatedAt: 'updated_at'
});
```

**Common middleware patterns:**

**1. Password hashing:**
```javascript
userSchema.pre('save', async function(next) {
  if (!this.isModified('password')) return next();
  
  try {
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt);
    next();
  } catch (err) {
    next(err);
  }
});
```

**2. Slug generation:**
```javascript
postSchema.pre('save', function(next) {
  if (!this.isModified('title')) return next();
  
  this.slug = this.title
    .toLowerCase()
    .replace(/[^\w\s]/g, '')
    .replace(/\s+/g, '-');
  
  next();
});
```

**3. Audit logging:**
```javascript
userSchema.post('save', function(doc, next) {
  AuditLog.create({
    action: 'user_save',
    userId: doc._id,
    data: doc.toObject(),
    timestamp: new Date()
  });
  next();
});
```

**4. Data cleanup:**
```javascript
userSchema.pre('save', function(next) {
  // Trim strings
  if (this.name) this.name = this.name.trim();
  if (this.email) this.email = this.email.trim().toLowerCase();
  
  // Remove empty arrays
  if (this.tags && this.tags.length === 0) {
    this.tags = undefined;
  }
  
  next();
});
```

**5. Cascade delete:**
```javascript
userSchema.pre('remove', async function(next) {
  // Delete related posts
  await Post.deleteMany({ author: this._id });
  
  // Delete related comments
  await Comment.deleteMany({ user: this._id });
  
  // Delete related files
  await File.deleteMany({ owner: this._id });
  
  next();
});
```

**Middleware best practices:**
1. **Keep middleware focused** on single responsibility
2. **Handle errors properly** in async middleware
3. **Use `isModified()`** to avoid unnecessary operations
4. **Be careful with `this` context** (differs by middleware type)
5. **Test middleware thoroughly**
6. **Document middleware behavior**
7. **Avoid infinite loops** (don't modify document in post-save that triggers another save)
8. **Consider performance** of middleware operations

---
---

## 28. SQL Databases (MySQL, PostgreSQL)

#### 1. How do you connect to SQL databases in Node.js?

**Answer:**

**Using mysql2 (MySQL):**
```javascript
const mysql = require('mysql2');

// Create connection
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'password',
  database: 'mydatabase',
  port: 3306,
  charset: 'utf8mb4',
  timezone: 'local'
});

// Connect
connection.connect((err) => {
  if (err) {
    console.error('Connection error:', err);
    return;
  }
  console.log('Connected to MySQL');
});

// Execute query
connection.query('SELECT * FROM users', (err, results) => {
  if (err) throw err;
  console.log(results);
});

// Close connection
connection.end();
```

**Using pg (PostgreSQL):**
```javascript
const { Client } = require('pg');

// Create client
const client = new Client({
  host: 'localhost',
  port: 5432,
  database: 'mydatabase',
  user: 'postgres',
  password: 'password',
  ssl: {
    rejectUnauthorized: false // For development only
  }
});

// Connect
client.connect()
  .then(() => console.log('Connected to PostgreSQL'))
  .catch(err => console.error('Connection error:', err));

// Execute query
client.query('SELECT * FROM users')
  .then(result => console.log(result.rows))
  .catch(err => console.error('Query error:', err));

// Close connection
client.end();
```

**Using connection pools:**
```javascript
// MySQL pool
const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'password',
  database: 'mydatabase',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  enableKeepAlive: true,
  keepAliveInitialDelay: 0
});

// PostgreSQL pool
const { Pool } = require('pg');

const pool = new Pool({
  host: 'localhost',
  port: 5432,
  database: 'mydatabase',
  user: 'postgres',
  password: 'password',
  max: 20, // Maximum number of clients in pool
  idleTimeoutMillis: 30000, // Close idle clients after 30s
  connectionTimeoutMillis: 2000 // Return error after 2s if no connection
});
```

**Using environment variables:**
```javascript
// config/database.js
require('dotenv').config();

const mysqlConfig = {
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 3306,
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'mydatabase',
  charset: 'utf8mb4'
};

const pgConfig = {
  host: process.env.PG_HOST || 'localhost',
  port: process.env.PG_PORT || 5432,
  user: process.env.PG_USER || 'postgres',
  password: process.env.PG_PASSWORD || '',
  database: process.env.PG_DATABASE || 'mydatabase',
  ssl: process.env.NODE_ENV === 'production' 
    ? { rejectUnauthorized: true }
    : false
};

module.exports = { mysqlConfig, pgConfig };
```

**Connection with SSL (production):**
```javascript
// MySQL with SSL
const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  ssl: {
    ca: fs.readFileSync('/path/to/ca.pem'),
    key: fs.readFileSync('/path/to/client-key.pem'),
    cert: fs.readFileSync('/path/to/client-cert.pem')
  }
});

// PostgreSQL with SSL
const { Client } = require('pg');

const client = new Client({
  connectionString: process.env.DATABASE_URL,
  ssl: {
    rejectUnauthorized: true,
    ca: fs.readFileSync('/path/to/ca-certificate.crt').toString()
  }
});
```

**Connection events:**
```javascript
const connection = mysql.createConnection(config);

connection.on('connect', () => {
  console.log('Database connected');
});

connection.on('error', (err) => {
  console.error('Database error:', err);
  
  if (err.code === 'PROTOCOL_CONNECTION_LOST') {
    console.log('Connection lost, attempting to reconnect...');
    handleDisconnect();
  }
});

connection.on('end', () => {
  console.log('Connection ended');
});

function handleDisconnect() {
  connection = mysql.createConnection(config);
  
  connection.connect((err) => {
    if (err) {
      setTimeout(handleDisconnect, 2000);
    }
  });
  
  connection.on('error', (err) => {
    if (err.code === 'PROTOCOL_CONNECTION_LOST') {
      handleDisconnect();
    } else {
      throw err;
    }
  });
}
```

**Using connection URI:**
```javascript
// MySQL connection string
const connection = mysql.createConnection(
  'mysql://user:password@localhost:3306/database'
);

// PostgreSQL connection string
const client = new Client(
  'postgresql://user:password@localhost:5432/database'
);

// With options in URI
const connection = mysql.createConnection(
  'mysql://user:password@localhost:3306/database?charset=utf8mb4&timezone=local'
);
```

**Best practices:**
1. **Use connection pools** for web applications
2. **Store credentials** in environment variables
3. **Enable SSL** in production
4. **Handle connection errors** gracefully
5. **Set appropriate timeouts**
6. **Use UTF-8 encoding** (utf8mb4 for MySQL)
7. **Close connections** when done

---

#### 2. What are the popular SQL libraries for Node.js?

**Answer:**

**1. mysql / mysql2 (MySQL):**
```javascript
// mysql2 (recommended - faster, Promise support)
const mysql = require('mysql2');

// Features:
// - Promise and callback APIs
// - Connection pooling
// - Prepared statements
// - SSL support
// - Compression
// - Named placeholders

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  database: 'test'
});

// Promise API
pool.promise()
  .execute('SELECT * FROM users WHERE id = ?', [1])
  .then(([rows]) => console.log(rows));

// Callback API
pool.query('SELECT * FROM users', (err, results) => {
  console.log(results);
});
```

**2. pg / node-postgres (PostgreSQL):**
```javascript
const { Pool } = require('pg');

// Features:
// - Connection pooling
// - Prepared statements
// - SSL support
// - Native async/await
// - JSON/JSONB support
// - Listen/Notify

const pool = new Pool({
  host: 'localhost',
  database: 'test'
});

// Async/await
const result = await pool.query('SELECT * FROM users');
console.log(result.rows);

// Prepared statement
const result = await pool.query(
  'SELECT * FROM users WHERE id = $1',
  [1]
);
```

**3. sqlite3 (SQLite):**
```javascript
const sqlite3 = require('sqlite3').verbose();

// Features:
// - File-based database
// - No server required
// - Good for development/testing
// - Embedded applications

const db = new sqlite3.Database('./database.db');

db.serialize(() => {
  db.run('CREATE TABLE users (id INT, name TEXT)');
  
  const stmt = db.prepare('INSERT INTO users VALUES (?, ?)');
  stmt.run(1, 'John');
  stmt.finalize();
  
  db.each('SELECT * FROM users', (err, row) => {
    console.log(row);
  });
});

db.close();
```

**4. tedious (Microsoft SQL Server):**
```javascript
const Connection = require('tedious').Connection;

// Features:
// - Microsoft SQL Server support
// - Connection pooling
// - Stored procedures
// - Bulk insert

const config = {
  server: 'localhost',
  authentication: {
    type: 'default',
    options: {
      userName: 'sa',
      password: 'password'
    }
  },
  options: {
    database: 'master',
    encrypt: true
  }
};

const connection = new Connection(config);
connection.connect();
```

**5. oracledb (Oracle Database):**
```javascript
const oracledb = require('oracledb');

// Features:
// - Oracle Database support
// - Connection pooling
// - PL/SQL support
// - Result set streaming

await oracledb.createPool({
  user: 'system',
  password: 'password',
  connectString: 'localhost/XE',
  poolMin: 2,
  poolMax: 10
});

const connection = await oracledb.getConnection();
const result = await connection.execute(
  'SELECT * FROM employees WHERE department_id = :dept_id',
  [50]
);
```

**6. knex (Query Builder):**
```javascript
const knex = require('knex');

// Features:
// - Unified query builder for multiple databases
// - Migrations
// - Transactions
// - Connection pooling

const db = knex({
  client: 'mysql2',
  connection: {
    host: '127.0.0.1',
    user: 'root',
    password: '',
    database: 'test'
  },
  pool: { min: 0, max: 10 }
});

// Query building
const users = await db('users')
  .select('id', 'name')
  .where('age', '>', 18)
  .orderBy('name', 'asc')
  .limit(10);
```

**7. Sequelize (ORM):**
```javascript
const { Sequelize } = require('sequelize');

// Features:
// - ORM for multiple databases
// - Models and associations
// - Migrations
// - Transactions
// - Hooks/validations

const sequelize = new Sequelize('database', 'username', 'password', {
  host: 'localhost',
  dialect: 'mysql', // or 'postgres', 'sqlite', 'mssql'
  pool: {
    max: 5,
    min: 0,
    acquire: 30000,
    idle: 10000
  }
});

// Define model
const User = sequelize.define('User', {
  name: { type: DataTypes.STRING },
  email: { type: DataTypes.STRING, unique: true }
});

// Use model
const users = await User.findAll();
```

**8. TypeORM (TypeScript ORM):**
```javascript
import { createConnection } from 'typeorm';

// Features:
- TypeScript support
- Decorator-based models
- Multiple database support
- Migrations
- Query builder

createConnection({
  type: 'mysql',
  host: 'localhost',
  port: 3306,
  username: 'root',
  password: '',
  database: 'test',
  entities: [User, Post],
  synchronize: true // Auto-create tables (development only)
});

@Entity()
export class User {
  @PrimaryGeneratedColumn()
  id: number;
  
  @Column()
  name: string;
}
```

**Comparison:**

| Library | Database | Type | Best For |
|---------|----------|------|----------|
| **mysql2** | MySQL | Driver | Raw queries, performance |
| **pg** | PostgreSQL | Driver | Raw queries, async/await |
| **sqlite3** | SQLite | Driver | Embedded apps, testing |
| **knex** | Multiple | Query Builder | Unified API, migrations |
| **Sequelize** | Multiple | ORM | Complex models, relationships |
| **TypeORM** | Multiple | ORM | TypeScript projects |
| **tedious** | SQL Server | Driver | Microsoft ecosystem |
| **oracledb** | Oracle | Driver | Enterprise applications |

**Choosing a library:**

1. **For raw queries**: Use native driver (mysql2, pg)
2. **For query building**: Use knex
3. **For ORM features**: Use Sequelize or TypeORM
4. **For TypeScript**: Use TypeORM
5. **For simple apps**: Use sqlite3
6. **For enterprise**: Use database-specific driver

**Popularity (npm downloads/month):**
1. mysql2 (~10M)
2. pg (~8M)
3. sqlite3 (~5M)
4. knex (~4M)
5. Sequelize (~3M)
6. TypeORM (~2M)

---

#### 3. How do you handle database connections and pooling?

**Answer:**

**Connection pooling** maintains a cache of database connections for reuse.

**Why use connection pooling:**
1. **Performance**: Reusing connections is faster than creating new ones
2. **Resource management**: Limits concurrent connections
3. **Stability**: Prevents connection overload
4. **Connection reuse**: Avoids TCP handshake overhead

**MySQL pooling with mysql2:**
```javascript
const mysql = require('mysql2');

// Create pool
const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'password',
  database: 'mydb',
  waitForConnections: true, // Wait for connection if pool full
  connectionLimit: 10,      // Maximum connections in pool
  queueLimit: 0,           // Unlimited queue for waiting connections
  maxIdle: 10,             // Max idle connections (mysql2 specific)
  idleTimeout: 60000,      // Idle connections timeout (ms)
  enableKeepAlive: true,   // Send keep-alive packets
  keepAliveInitialDelay: 0
});

// Get connection from pool
pool.getConnection((err, connection) => {
  if (err) {
    console.error('Error getting connection:', err);
    return;
  }
  
  // Use connection
  connection.query('SELECT * FROM users', (err, results) => {
    // Release connection back to pool
    connection.release();
    
    if (err) {
      console.error('Query error:', err);
      return;
    }
    
    console.log(results);
  });
});

// Direct pool query (auto-manages connection)
pool.query('SELECT * FROM users', (err, results) => {
  console.log(results);
});

// Promise API
const promisePool = pool.promise();

async function getUsers() {
  const [rows] = await promisePool.query('SELECT * FROM users');
  return rows;
}
```

**PostgreSQL pooling with pg:**
```javascript
const { Pool } = require('pg');

// Create pool
const pool = new Pool({
  host: 'localhost',
  port: 5432,
  database: 'mydb',
  user: 'postgres',
  password: 'password',
  max: 20,                    // Maximum number of clients
  min: 4,                     // Minimum number of clients
  idleTimeoutMillis: 30000,   // Close idle clients after 30s
  connectionTimeoutMillis: 2000, // Return error after 2s if no connection
  allowExitOnIdle: false      // Don't allow process exit while clients are idle
});

// Use pool
async function queryDatabase() {
  const client = await pool.connect();
  
  try {
    const result = await client.query('SELECT * FROM users');
    return result.rows;
  } finally {
    client.release(); // Always release connection
  }
}

// Or use pool.query (auto-manages connection)
const result = await pool.query('SELECT * FROM users');
console.log(result.rows);
```

**Pool events and monitoring:**
```javascript
// MySQL pool events
pool.on('acquire', (connection) => {
  console.log('Connection %d acquired', connection.threadId);
});

pool.on('release', (connection) => {
  console.log('Connection %d released', connection.threadId);
});

pool.on('enqueue', () => {
  console.log('Waiting for available connection slot');
});

// PostgreSQL pool events
pool.on('connect', (client) => {
  console.log('Client connected');
});

pool.on('remove', (client) => {
  console.log('Client removed from pool');
});

pool.on('error', (err, client) => {
  console.error('Unexpected error on idle client', err);
});

// Monitor pool status
function getPoolStats() {
  return {
    total: pool.totalCount,
    idle: pool.idleCount,
    waiting: pool.waitingCount,
    // MySQL specific
    // connectionCount: pool._allConnections.length,
    // freeConnections: pool._freeConnections.length
  };
}

// Health check
async function checkPoolHealth() {
  try {
    const result = await pool.query('SELECT 1 as health');
    return result.rows[0].health === 1;
  } catch (err) {
    return false;
  }
}
```

**Connection retry logic:**
```javascript
async function connectWithRetry(pool, maxRetries = 3, delay = 1000) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      const client = await pool.connect();
      console.log('Connected successfully');
      return client;
    } catch (err) {
      console.error(`Connection attempt ${i + 1} failed:`, err.message);
      
      if (i < maxRetries - 1) {
        console.log(`Retrying in ${delay}ms...`);
        await new Promise(resolve => setTimeout(resolve, delay));
        delay *= 2; // Exponential backoff
      }
    }
  }
  
  throw new Error('Failed to connect after retries');
}
```

**Pool configuration best practices:**
```javascript
const poolConfig = {
  // Connection limits
  max: 20,           // Match database max_connections setting
  min: 5,            // Keep some connections ready
  
  // Timeouts
  idleTimeoutMillis: 30000,     // Close idle connections
  connectionTimeoutMillis: 2000, // Fail fast if no connection
  
  // Application needs
  maxUses: 7500,     // Recycle connections after N uses (PostgreSQL)
  
  // Based on workload
  // Web apps: 10-20 connections
  // Background jobs: 5-10 connections
  // Microservices: 2-5 connections per service
};

// Calculate based on concurrency
function calculatePoolSize() {
  const concurrentRequests = 100; // Expected concurrent requests
  const avgQueryTime = 0.1;       // Average query time in seconds
  const targetUtilization = 0.7;  // 70% utilization target
  
  const poolSize = Math.ceil(
    (concurrentRequests * avgQueryTime) / targetUtilization
  );
  
  return Math.min(poolSize, 100); // Cap at database limit
}
```

**Graceful shutdown:**
```javascript
// Handle application shutdown
async function shutdown() {
  console.log('Starting graceful shutdown...');
  
  // Stop accepting new connections
  pool.end((err) => {
    if (err) {
      console.error('Error closing pool:', err);
      process.exit(1);
    }
    
    console.log('Pool closed successfully');
    process.exit(0);
  });
  
  // Or with async/await (PostgreSQL)
  await pool.end();
}

// Handle signals
process.on('SIGTERM', shutdown);
process.on('SIGINT', shutdown);

// Handle uncaught exceptions
process.on('uncaughtException', async (err) => {
  console.error('Uncaught exception:', err);
  await shutdown();
});
```

**Connection validation:**
```javascript
// Validate connections before use
const pool = mysql.createPool({
  // ... other config
  enableKeepAlive: true,
  keepAliveInitialDelay: 0,
  
  // Validate connection
  validateConnection: (connection) => {
    return connection.query('SELECT 1')
      .then(() => true)
      .catch(() => false);
  }
});

// Or periodic validation
setInterval(() => {
  pool.query('SELECT 1', (err) => {
    if (err) {
      console.error('Pool health check failed:', err);
    }
  });
}, 30000); // Every 30 seconds
```

**Multiple pools for different workloads:**
```javascript
// Read/write separation
const readPool = new Pool({
  connectionString: process.env.READ_DB_URL,
  max: 10
});

const writePool = new Pool({
  connectionString: process.env.WRITE_DB_URL,
  max: 5
});

// Usage based on operation type
async function getUsers() {
  return readPool.query('SELECT * FROM users');
}

async function createUser(user) {
  return writePool.query(
    'INSERT INTO users (name, email) VALUES ($1, $2)',
    [user.name, user.email]
  );
}
```

**Best practices:**
1. **Size pool appropriately**: Not too small (waiting), not too large (resource waste)
2. **Monitor pool metrics**: Connections, wait times, errors
3. **Implement retry logic**: For transient failures
4. **Graceful shutdown**: Close connections properly
5. **Validate connections**: Periodic health checks
6. **Separate pools**: For different workloads if needed
7. **Use environment variables**: For configuration
8. **Log connection events**: For debugging

---
---

#### 4. How do you write parameterized queries to prevent SQL injection?

**Answer:**

**SQL injection** occurs when user input is directly concatenated into SQL queries, allowing attackers to execute arbitrary SQL code.

**Vulnerable code (DO NOT USE):**
```javascript
// ❌ DANGER: SQL injection vulnerability
const userId = req.params.id;
const query = `SELECT * FROM users WHERE id = ${userId}`;
// If userId = "1 OR 1=1", query becomes: SELECT * FROM users WHERE id = 1 OR 1=1
// Returns ALL users!

// ❌ Another example
const name = req.body.name;
const query = `SELECT * FROM users WHERE name = '${name}'`;
// If name = "admin' --", query becomes: SELECT * FROM users WHERE name = 'admin' --'
// -- comments out rest of query
```

**Parameterized queries (SAFE):**

**MySQL with mysql2:**
```javascript
const mysql = require('mysql2');

// Using placeholders (?)
const query = 'SELECT * FROM users WHERE id = ? AND status = ?';
const values = [userId, 'active'];

connection.query(query, values, (err, results) => {
  // Safe from SQL injection
});

// Named placeholders
const query = 'SELECT * FROM users WHERE id = :id AND status = :status';
const values = { id: userId, status: 'active' };

connection.execute(query, values, (err, results) => {
  // Safe
});

// Prepared statements (most secure)
const statement = 'SELECT * FROM users WHERE email = ? AND password = ?';
const prepared = connection.prepare(statement);

prepared.execute([email, password], (err, results) => {
  // Reusable prepared statement
});
```

**PostgreSQL with pg:**
```javascript
const { Pool } = require('pg');
const pool = new Pool();

// Positional parameters ($1, $2, etc.)
const query = 'SELECT * FROM users WHERE id = $1 AND status = $2';
const values = [userId, 'active'];

const result = await pool.query(query, values);
// Safe

// Named parameters (with pg-promise or other libraries)
const query = 'SELECT * FROM users WHERE id = ${id} AND status = ${status}';
const values = { id: userId, status: 'active' };

// Using pg-promise
const result = await db.any(query, values);
```

**Knex query builder:**
```javascript
const knex = require('knex');

// Automatic parameterization
const users = await knex('users')
  .where('id', userId)
  .andWhere('status', 'active')
  .select('*');

// Raw query with parameters
const users = await knex.raw(
  'SELECT * FROM users WHERE id = ? AND status = ?',
  [userId, 'active']
);

// Object notation
const users = await knex('users')
  .where({
    id: userId,
    status: 'active'
  });
```

**Sequelize ORM:**
```javascript
const { Op } = require('sequelize');

// Automatic parameterization
const users = await User.findAll({
  where: {
    id: userId,
    status: 'active'
  }
});

// Raw query with replacements
const users = await sequelize.query(
  'SELECT * FROM users WHERE id = :id AND status = :status',
  {
    replacements: { id: userId, status: 'active' },
    type: sequelize.QueryTypes.SELECT
  }
);

// Using operators (also safe)
const users = await User.findAll({
  where: {
    age: {
      [Op.gt]: 18
    }
  }
});
```

**Dynamic queries safely:**
```javascript
// ❌ UNSAFE: String concatenation
let query = 'SELECT * FROM users WHERE 1=1';
if (name) query += ` AND name = '${name}'`;
if (age) query += ` AND age = ${age}`;

// ✅ SAFE: Build query with parameters
const conditions = [];
const values = [];

if (name) {
  conditions.push('name = ?');
  values.push(name);
}

if (age) {
  conditions.push('age = ?');
  values.push(age);
}

let query = 'SELECT * FROM users';
if (conditions.length > 0) {
  query += ' WHERE ' + conditions.join(' AND ');
}

connection.query(query, values, (err, results) => {
  // Safe
});

// ✅ SAFE: Using query builder
const query = knex('users').select('*');

if (name) {
  query.where('name', name);
}

if (age) {
  query.where('age', age);
}

const users = await query;
```

**IN clause safely:**
```javascript
// ❌ UNSAFE
const ids = [1, 2, 3];
const query = `SELECT * FROM users WHERE id IN (${ids.join(',')})`;

// ✅ SAFE: MySQL
const ids = [1, 2, 3];
const placeholders = ids.map(() => '?').join(',');
const query = `SELECT * FROM users WHERE id IN (${placeholders})`;
connection.query(query, ids, (err, results) => {});

// ✅ SAFE: PostgreSQL
const ids = [1, 2, 3];
const query = 'SELECT * FROM users WHERE id = ANY($1)';
const result = await pool.query(query, [ids]);

// ✅ SAFE: Knex
const users = await knex('users')
  .whereIn('id', ids);

// ✅ SAFE: Sequelize
const users = await User.findAll({
  where: {
    id: {
      [Op.in]: ids
    }
  }
});
```

**LIKE queries safely:**
```javascript
// ❌ UNSAFE
const search = req.query.search;
const query = `SELECT * FROM users WHERE name LIKE '%${search}%'`;

// ✅ SAFE: MySQL/PostgreSQL
const search = req.query.search;
const query = 'SELECT * FROM users WHERE name LIKE ?';
const values = [`%${search}%`];
connection.query(query, values, (err, results) => {});

// ✅ SAFE: Knex
const users = await knex('users')
  .where('name', 'like', `%${search}%`);

// ✅ SAFE: Sequelize
const users = await User.findAll({
  where: {
    name: {
      [Op.like]: `%${search}%`
    }
  }
});
```

**Stored procedures safely:**
```javascript
// MySQL
const query = 'CALL get_user_by_email(?)';
connection.query(query, [email], (err, results) => {});

// PostgreSQL
const query = 'SELECT * FROM get_user_by_email($1)';
const result = await pool.query(query, [email]);

// SQL Server (tedious)
const request = new Request('sp_get_user', (err, rowCount) => {});
request.addParameter('email', TYPES.VarChar, email);
connection.callProcedure(request);
```

**Best practices to prevent SQL injection:**
1. **Always use parameterized queries** - Never concatenate user input
2. **Use ORM/query builders** - They handle parameterization automatically
3. **Validate and sanitize input** - Even with parameterized queries
4. **Use stored procedures** - When appropriate
5. **Limit database permissions** - Application user should have minimal privileges
6. **Use prepared statements** - For frequently executed queries
7. **Escape special characters** - If you must concatenate (last resort)
8. **Regular security audits** - Check for injection vulnerabilities

**Input validation example:**
```javascript
function validateUserId(userId) {
  // Check if it's a valid integer
  if (!/^\d+$/.test(userId)) {
    throw new Error('Invalid user ID');
  }
  
  // Check bounds
  const id = parseInt(userId, 10);
  if (id < 1 || id > 1000000) {
    throw new Error('User ID out of range');
  }
  
  return id;
}

// Use validated input
const safeUserId = validateUserId(req.params.id);
const query = 'SELECT * FROM users WHERE id = ?';
connection.query(query, [safeUserId], (err, results) => {});
```

**Security headers:**
```javascript
// Set security headers in Express
app.use((req, res, next) => {
  // Prevent MIME type sniffing
  res.set('X-Content-Type-Options', 'nosniff');
  
  // Prevent clickjacking
  res.set('X-Frame-Options', 'DENY');
  
  // Enable XSS protection
  res.set('X-XSS-Protection', '1; mode=block');
  
  // Content Security Policy
  res.set('Content-Security-Policy', "default-src 'self'");
  
  next();
});
```

**Monitoring and logging:**
```javascript
// Log suspicious queries
app.use((req, res, next) => {
  const originalUrl = req.originalUrl;
  const userAgent = req.get('User-Agent');
  
  // Check for SQL injection patterns
  const sqlInjectionPatterns = [
    /(\%27)|(\')|(\-\-)|(\%23)|(#)/i,
    /((\%3D)|(=))[^\n]*((\%27)|(\')|(\-\-)|(\%3B)|(;))/i,
    /\w*((\%27)|(\'))((\%6F)|o|(\%4F))((\%72)|r|(\%52))/i,
    /((\%27)|(\'))union/i
  ];
  
  const hasInjection = sqlInjectionPatterns.some(pattern => 
    pattern.test(originalUrl) || pattern.test(userAgent)
  );
  
  if (hasInjection) {
    console.warn('Possible SQL injection attempt:', {
      ip: req.ip,
      url: originalUrl,
      userAgent,
      timestamp: new Date().toISOString()
    });
    
    // Optionally block the request
    // return res.status(400).send('Invalid request');
  }
  
  next();
});
```

**Testing for SQL injection:**
```javascript
// Unit test for safe queries
describe('SQL Injection Protection', () => {
  it('should prevent SQL injection in user queries', async () => {
    const maliciousInput = "1' OR '1'='1";
    
    // This should return empty or throw error, not all users
    const users = await User.findAll({
      where: { id: maliciousInput }
    });
    
    // Verify no injection occurred
    expect(users.length).toBe(0);
  });
  
  it('should safely handle special characters', async () => {
    const inputWithSpecialChars = "O'Brien; DROP TABLE users; --";
    
    // Should create user with exact name
    const user = await User.create({
      name: inputWithSpecialChars,
      email: 'test@example.com'
    });
    
    expect(user.name).toBe(inputWithSpecialChars);
  });
});
```

**Remember:** Parameterized queries separate SQL code from data, preventing injection regardless of the data content.

---
---

#### 5. What are transactions and how do you implement them?

**Answer:**

**Transactions** are sequences of database operations that are executed as a single unit of work. They follow ACID properties:

**ACID properties:**
- **Atomicity**: All operations succeed or all fail
- **Consistency**: Database remains in valid state
- **Isolation**: Transactions don't interfere with each other
- **Durability**: Committed changes persist

**When to use transactions:**
1. **Financial operations** (transfers, payments)
2. **Inventory management** (stock updates)
3. **Order processing** (create order + update inventory)
4. **User registration** (create user + send welcome email)
5. **Batch operations** (multiple related updates)

**MySQL transactions with mysql2:**
```javascript
const mysql = require('mysql2');
const connection = await mysql.createConnection(config);

// Basic transaction
try {
  await connection.beginTransaction();
  
  // Operation 1: Deduct from account A
  await connection.execute(
    'UPDATE accounts SET balance = balance - ? WHERE id = ?',
    [amount, fromAccountId]
  );
  
  // Operation 2: Add to account B
  await connection.execute(
    'UPDATE accounts SET balance = balance + ? WHERE id = ?',
    [amount, toAccountId]
  );
  
  // Operation 3: Record transaction
  await connection.execute(
    'INSERT INTO transactions (from_account, to_account, amount) VALUES (?, ?, ?)',
    [fromAccountId, toAccountId, amount]
  );
  
  await connection.commit();
  console.log('Transaction committed successfully');
  
} catch (err) {
  await connection.rollback();
  console.error('Transaction rolled back:', err);
  throw err;
} finally {
  connection.end();
}
```

**PostgreSQL transactions with pg:**
```javascript
const { Pool } = require('pg');
const pool = new Pool();

// Using async/await
const client = await pool.connect();

try {
  await client.query('BEGIN');
  
  // Operation 1
  await client.query(
    'UPDATE accounts SET balance = balance - $1 WHERE id = $2',
    [amount, fromAccountId]
  );
  
  // Operation 2
  await client.query(
    'UPDATE accounts SET balance = balance + $1 WHERE id = $2',
    [amount, toAccountId]
  );
  
  // Operation 3
  await client.query(
    'INSERT INTO transactions (from_account, to_account, amount) VALUES ($1, $2, $3)',
    [fromAccountId, toAccountId, amount]
  );
  
  await client.query('COMMIT');
  console.log('Transaction committed');
  
} catch (err) {
  await client.query('ROLLBACK');
  console.error('Transaction rolled back:', err);
  throw err;
} finally {
  client.release();
}
```

**Knex transactions:**
```javascript
const knex = require('knex');

// Using transaction callback
await knex.transaction(async (trx) => {
  // Operation 1
  await trx('accounts')
    .where('id', fromAccountId)
    .decrement('balance', amount);
  
  // Operation 2
  await trx('accounts')
    .where('id', toAccountId)
    .increment('balance', amount);
  
  // Operation 3
  await trx('transactions').insert({
    from_account: fromAccountId,
    to_account: toAccountId,
    amount: amount,
    created_at: new Date()
  });
  
  // Transaction auto-commits if no error thrown
  // Auto-rollback if error thrown
});

// Manual transaction control
const trx = await knex.transaction();

try {
  await trx('users').insert({ name: 'John' });
  await trx('profiles').insert({ user_id: 1, bio: 'Hello' });
  
  await trx.commit();
} catch (err) {
  await trx.rollback();
  throw err;
}
```

**Sequelize transactions:**
```javascript
const { Sequelize } = require('sequelize');
const sequelize = new Sequelize(config);

// Using managed transaction
const result = await sequelize.transaction(async (t) => {
  // Operation 1
  const user = await User.create({
    name: 'John',
    email: 'john@example.com'
  }, { transaction: t });
  
  // Operation 2
  const profile = await Profile.create({
    userId: user.id,
    bio: 'Hello world'
  }, { transaction: t });
  
  // Operation 3
  await Log.create({
    action: 'user_created',
    userId: user.id
  }, { transaction: t });
  
  return { user, profile };
});

// Manual transaction
const t = await sequelize.transaction();

try {
  const user = await User.create({
    name: 'John',
    email: 'john@example.com'
  }, { transaction: t });
  
  await t.commit();
  return user;
} catch (err) {
  await t.rollback();
  throw err;
}
```

**Transaction isolation levels:**
```javascript
// MySQL isolation levels
await connection.query('SET TRANSACTION ISOLATION LEVEL READ COMMITTED');
await connection.beginTransaction();

// PostgreSQL isolation levels
await client.query('BEGIN ISOLATION LEVEL SERIALIZABLE');

// Common isolation levels:
// 1. READ UNCOMMITTED: Can read uncommitted changes (dirty reads)
// 2. READ COMMITTED: Only read committed changes (default for PostgreSQL)
// 3. REPEATABLE READ: Consistent reads within transaction (default for MySQL)
// 4. SERIALIZABLE: Highest isolation, prevents phantom reads

// Setting in knex
await knex.transaction({ isolationLevel: 'serializable' }, async (trx) => {
  // ...
});

// Setting in Sequelize
const t = await sequelize.transaction({
  isolationLevel: Sequelize.Transaction.SERIALIZABLE
});
```

**Nested transactions (savepoints):**
```javascript
// MySQL savepoints
await connection.beginTransaction();

try {
  // Operation 1
  await connection.execute('INSERT INTO users (name) VALUES (?)', ['John']);
  
  // Create savepoint
  await connection.execute('SAVEPOINT sp1');
  
  try {
    // Operation 2 (might fail)
    await connection.execute('INSERT INTO invalid_table (col) VALUES (?)', [1]);
  } catch (err) {
    // Rollback to savepoint (undo operation 2 only)
    await connection.execute('ROLLBACK TO SAVEPOINT sp1');
    console.log('Rolled back to savepoint, continuing transaction');
  }
  
  // Operation 3 (still executes)
  await connection.execute('INSERT INTO logs (action) VALUES (?)', ['completed']);
  
  await connection.commit();
} catch (err) {
  await connection.rollback();
  throw err;
}

// PostgreSQL savepoints
await client.query('BEGIN');
await client.query('SAVEPOINT my_savepoint');

try {
  await client.query('INSERT INTO users (name) VALUES ($1)', ['John']);
  await client.query('RELEASE SAVEPOINT my_savepoint');
} catch (err) {
  await client.query('ROLLBACK TO SAVEPOINT my_savepoint');
}
```

**Distributed transactions (multiple databases):**
```javascript
// Two-phase commit pattern
async function distributedTransaction() {
  const db1 = await connectToDB1();
  const db2 = await connectToDB2();
  
  try {
    // Phase 1: Prepare
    await db1.beginTransaction();
    await db2.beginTransaction();
    
    await db1.execute('UPDATE account1 SET balance = balance - ?', [amount]);
    await db2.execute('UPDATE account2 SET balance = balance + ?', [amount]);
    
    // Phase 2: Commit (if both prepared successfully)
    await db1.commit();
    await db2.commit();
    
  } catch (err) {
    // Rollback both on any error
    await db1.rollback().catch(() => {});
    await db2.rollback().catch(() => {});
    throw err;
  }
}
```

**Transaction timeout and retry:**
```javascript
async function executeWithRetry(operation, maxRetries = 3) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await operation();
    } catch (err) {
      // Check if it's a retryable error
      const isRetryable = 
        err.code === 'ER_LOCK_DEADLOCK' || // MySQL deadlock
        err.code === '40P01' || // PostgreSQL deadlock
        err.code === '40001';   // Serialization failure
      
      if (!isRetryable || i === maxRetries - 1) {
        throw err;
      }
      
      console.log(`Retry ${i + 1} after error:`, err.message);
      await new Promise(resolve => setTimeout(resolve, 100 * Math.pow(2, i)));
    }
  }
}

// Usage
await executeWithRetry(async () => {
  return await knex.transaction(async (trx) => {
    // Transaction operations
  });
});
```

**Transaction best practices:**
1. **Keep transactions short** - Minimize lock duration
2. **Handle errors properly** - Always rollback on error
3. **Use appropriate isolation level** - Balance consistency vs performance
4. **Avoid long-running transactions** - Can cause blocking
5. **Test with concurrent access** - Check for deadlocks
6. **Monitor transaction metrics** - Duration, rollback rate
7. **Use retry logic** - For transient failures
8. **Consider savepoints** - For partial rollbacks

**Common transaction patterns:**

**1. Money transfer:**
```javascript
async function transferMoney(fromAccountId, toAccountId, amount) {
  return await knex.transaction(async (trx) => {
    // Check sufficient balance
    const fromAccount = await trx('accounts')
      .where('id', fromAccountId)
      .forUpdate() // Lock row for update
      .first();
    
    if (fromAccount.balance < amount) {
      throw new Error('Insufficient balance');
    }
    
    // Perform transfer
    await trx('accounts')
      .where('id', fromAccountId)
      .decrement('balance', amount);
    
    await trx('accounts')
      .where('id', toAccountId)
      .increment('balance', amount);
    
    // Record transaction
    await trx('transactions').insert({
      from_account: fromAccountId,
      to_account: toAccountId,
      amount: amount,
      status: 'completed',
      created_at: new Date()
    });
  });
}
```

**2. Order creation:**
```javascript
async function createOrder(userId, items) {
  return await sequelize.transaction(async (t) => {
    // Create order
    const order = await Order.create({
      userId: userId,
      status: 'pending',
      total: 0
    }, { transaction: t });
    
    let total = 0;
    
    // Add order items and update inventory
    for (const item of items) {
      // Check and reserve inventory
      const product = await Product.findOne({
        where: { id: item.productId },
        lock: t.LOCK.UPDATE,
        transaction: t
      });
      
      if (product.stock < item.quantity) {
        throw new Error(`Insufficient stock for product ${product.name}`);
      }
      
      // Update inventory
      product.stock -= item.quantity;
      await product.save({ transaction: t });
      
      // Add order item
      const itemTotal = product.price * item.quantity;
      total += itemTotal;
      
      await OrderItem.create({
        orderId: order.id,
        productId: item.productId,
        quantity: item.quantity,
        price: product.price,
        total: itemTotal
      }, { transaction: t });
    }
    
    // Update order total
    order.total = total;
    await order.save({ transaction: t });
    
    return order;
  });
}
```

**3. User registration with email:**
```javascript
async function registerUser(userData) {
  const trx = await knex.transaction();
  
  try {
    // Create user
    const [userId] = await trx('users').insert({
      email: userData.email,
      password_hash: hashPassword(userData.password),
      created_at: new Date()
    });
    
    // Create profile
    await trx('profiles').insert({
      user_id: userId,
      name: userData.name,
      bio: userData.bio || ''
    });
    
    // Send welcome email (outside transaction for reliability)
    trx.afterCommit(async () => {
      try {
        await sendWelcomeEmail(userData.email);
      } catch (emailErr) {
        console.error('Failed to send welcome email:', emailErr);
        // Don't rollback transaction for email failure
      }
    });
    
    await trx.commit();
    return userId;
    
  } catch (err) {
    await trx.rollback();
    throw err;
  }
}
```

**Transaction monitoring:**
```javascript
// Monitor transaction performance
app.use(async (req, res, next) => {
  const start = Date.now();
  let transactionActive = false;
  
  try {
    // Wrap request in transaction if needed
    if (req.method === 'POST' || req.method === 'PUT' || req.method === 'DELETE') {
      transactionActive = true;
      req.transaction = await sequelize.transaction();
    }
    
    await next();
    
    if (transactionActive && req.transaction) {
      await req.transaction.commit();
    }
    
  } catch (err) {
    if (transactionActive && req.transaction) {
      await req.transaction.rollback();
    }
    throw err;
    
  } finally {
    const duration = Date.now() - start;
    
    if (transactionActive) {
      console.log(`Transaction duration: ${duration}ms`, {
        method: req.method,
        url: req.url,
        duration: duration
      });
      
      if (duration > 1000) {
        console.warn('Long transaction detected:', { duration, url: req.url });
      }
    }
  }
});
```

**Remember:** Transactions ensure data integrity by grouping related operations that must succeed or fail together.

---
---

#### 6. How do you handle database migrations?

**Answer:**

**Database migrations** are version-controlled scripts that manage database schema changes over time.

**Why use migrations:**
1. **Version control** for database schema
2. **Consistent environments** (dev, staging, production)
3. **Rollback capability** for failed changes
4. **Collaboration** among team members
5. **Automated deployment** with application

**Migration tools:**
1. **Knex.js** - SQL-based migrations
2. **Sequelize CLI** - ORM-based migrations
3. **TypeORM** - TypeScript migrations
4. **db-migrate** - Database-agnostic
5. **Flyway** - Java-based (for Node.js via API)
6. **Liquibase** - XML/JSON-based

**Knex migrations:**

**1. Setup:**
```bash
# Install knex globally or locally
npm install knex --save
npm install knex-cli -g

# Initialize knex
knex init
# Creates knexfile.js
```

**2. knexfile.js configuration:**
```javascript
// knexfile.js
module.exports = {
  development: {
    client: 'mysql2',
    connection: {
      host: '127.0.0.1',
      user: 'root',
      password: '',
      database: 'myapp_dev'
    },
    migrations: {
      directory: './migrations',
      tableName: 'knex_migrations'
    },
    seeds: {
      directory: './seeds'
    }
  },
  
  staging: {
    client: 'postgresql',
    connection: {
      host: process.env.DB_HOST,
      database: process.env.DB_NAME,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations: {
      tableName: 'knex_migrations'
    }
  },
  
  production: {
    client: 'postgresql',
    connection: {
      connectionString: process.env.DATABASE_URL,
      ssl: { rejectUnauthorized: false }
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations: {
      tableName: 'knex_migrations'
    }
  }
};
```

**3. Create migration:**
```bash
# Create migration file
knex migrate:make create_users_table
# Creates: migrations/20240115120000_create_users_table.js
```

**4. Migration file:**
```javascript
// migrations/20240115120000_create_users_table.js
exports.up = function(knex) {
  return knex.schema.createTable('users', (table) => {
    table.increments('id').primary();
    table.string('email', 255).notNullable().unique();
    table.string('password_hash', 255).notNullable();
    table.string('name', 100);
    table.enum('role', ['user', 'admin', 'moderator']).defaultTo('user');
    table.boolean('is_active').defaultTo(true);
    table.timestamp('created_at').defaultTo(knex.fn.now());
    table.timestamp('updated_at').defaultTo(knex.fn.now());
    
    // Indexes
    table.index('email');
    table.index('role');
    table.index('created_at');
  });
};

exports.down = function(knex) {
  return knex.schema.dropTable('users');
};
```

**5. Run migrations:**
```bash
# Run all pending migrations
knex migrate:latest

# Rollback last migration
knex migrate:rollback

# Rollback all migrations
knex migrate:rollback --all

# Check migration status
knex migrate:status

# Create specific migration
knex migrate:up 20240115120000_create_users_table.js
knex migrate:down 20240115120000_create_users_table.js
```

**6. Complex migration example:**
```javascript
// migrations/20240115120001_add_user_profile.js
exports.up = async function(knex) {
  // Create profiles table
  await knex.schema.createTable('profiles', (table) => {
    table.increments('id').primary();
    table.integer('user_id').unsigned().notNullable();
    table.text('bio');
    table.string('avatar_url', 500);
    table.json('settings');
    table.timestamps(true, true);
    
    // Foreign key
    table.foreign('user_id')
      .references('id')
      .inTable('users')
      .onDelete('CASCADE');
    
    // Unique constraint
    table.unique('user_id');
  });
  
  // Add column to users table
  await knex.schema.table('users', (table) => {
    table.string('phone', 20).after('name');
    table.boolean('email_verified').defaultTo(false);
  });
  
  // Create index
  await knex.schema.raw('CREATE INDEX idx_users_phone ON users(phone)');
  
  // Insert initial data
  await knex('profiles').insert([
    { user_id: 1, bio: 'First user' },
    { user_id: 2, bio: 'Second user' }
  ]);
};

exports.down = async function(knex) {
  // Drop index
  await knex.schema.raw('DROP INDEX idx_users_phone ON users');
  
  // Remove columns
  await knex.schema.table('users', (table) => {
    table.dropColumn('phone');
    table.dropColumn('email_verified');
  });
  
  // Drop table
  await knex.schema.dropTable('profiles');
};
```

**Sequelize migrations:**

**1. Setup:**
```bash
# Install Sequelize CLI
npm install --save sequelize
npm install --save-dev sequelize-cli

# Initialize
npx sequelize-cli init
# Creates: config/, models/, migrations/, seeders/
```

**2. Configuration:**
```javascript
// config/config.json
{
  "development": {
    "username": "root",
    "password": null,
    "database": "database_development",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
  "test": {
    "username": "root",
    "password": null,
    "database": "database_test",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
  "production": {
    "username": "root",
    "password": null,
    "database": "database_production",
    "host": "127.0.0.1",
    "dialect": "mysql"
  }
}
```

**3. Create migration:**
```bash
# Generate migration
npx sequelize-cli migration:generate --name create-users

# Create model with migration
npx sequelize-cli model:generate --name User --attributes firstName:string,lastName:string,email:string
```

**4. Migration file:**
```javascript
// migrations/20240115120000-create-users.js
'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Users', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      firstName: {
        type: Sequelize.STRING,
        allowNull: false
      },
      lastName: {
        type: Sequelize.STRING,
        allowNull: false
      },
      email: {
        type: Sequelize.STRING,
        allowNull: false,
        unique: true
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP')
      }
    });
    
    // Add index
    await queryInterface.addIndex('Users', ['email']);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('Users');
  }
};
```

**5. Run migrations:**
```bash
# Run all migrations
npx sequelize-cli db:migrate

# Undo last migration
npx sequelize-cli db:migrate:undo

# Undo all migrations
npx sequelize-cli db:migrate:undo:all

# Run specific migration
npx sequelize-cli db:migrate --to 20240115120000-create-users.js
```

**6. Data migration example:**
```javascript
// migrations/20240115120001-add-user-roles.js
'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    // Add column
    await queryInterface.addColumn('Users', 'role', {
      type: Sequelize.ENUM('user', 'admin', 'moderator'),
      defaultValue: 'user',
      allowNull: false
    });
    
    // Update existing records
    await queryInterface.sequelize.query(`
      UPDATE Users 
      SET role = 'admin' 
      WHERE email LIKE '%@admin.com'
    `);
    
    // Create new table
    await queryInterface.createTable('UserProfiles', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      userId: {
        type: Sequelize.INTEGER,
        references: {
          model: 'Users',
          key: 'id'
        },
        onDelete: 'CASCADE'
      },
      bio: Sequelize.TEXT,
      createdAt: Sequelize.DATE,
      updatedAt: Sequelize.DATE
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('UserProfiles');
    await queryInterface.removeColumn('Users', 'role');
  }
};
```

**TypeORM migrations:**

**1. Setup:**
```typescript
// package.json scripts
{
  "scripts": {
    "typeorm": "typeorm-ts-node-commonjs",
    "migration:generate": "npm run typeorm migration:generate",
    "migration:run": "npm run typeorm migration:run",
    "migration:revert": "npm run typeorm migration:revert"
  }
}
```

**2. Configuration:**
```typescript
// ormconfig.json
{
  "type": "mysql",
  "host": "localhost",
  "port": 3306,
  "username": "root",
  "password": "",
  "database": "test",
  "synchronize": false, // IMPORTANT: false for production
  "logging": true,
  "entities": ["src/entity/**/*.ts"],
  "migrations": ["src/migration/**/*.ts"],
  "subscribers": ["src/subscriber/**/*.ts"],
  "cli": {
    "entitiesDir": "src/entity",
    "migrationsDir": "src/migration",
    "subscribersDir": "src/subscriber"
  }
}
```

**3. Generate migration from entity changes:**
```bash
# Generate migration based on entity changes
npm run migration:generate -- -n CreateUserTable
```

**4. Migration file:**
```typescript
// src/migration/1641234567890-CreateUserTable.ts
import { MigrationInterface, QueryRunner } from "typeorm";

export class CreateUserTable1641234567890 implements MigrationInterface {
  name = 'CreateUserTable1641234567890'

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      CREATE TABLE \`user\` (
        \`id\` int NOT NULL AUTO_INCREMENT,
        \`email\` varchar(255) NOT NULL,
        \`password\` varchar(255) NOT NULL,
        \`name\` varchar(100) NULL,
        \`createdAt\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
        \`updatedAt\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
        PRIMARY KEY (\`id\`),
        UNIQUE INDEX \`IDX_e12875dfb3b1d92d7d7c5377e2\` (\`email\`)
      ) ENGINE=InnoDB
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`DROP TABLE \`user\``);
  }
}
```

**5. Manual migration:**
```typescript
// src/migration/1641234567891-AddUserRole.ts
import { MigrationInterface, QueryRunner } from "typeorm";

export class AddUserRole1641234567891 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    // Add column
    await queryRunner.query(`
      ALTER TABLE \`user\`
      ADD \`role\` enum('user', 'admin', 'moderator') NOT NULL DEFAULT 'user'
    `);
    
    // Add index
    await queryRunner.query(`
      CREATE INDEX \`IDX_user_role\` ON \`user\`(\`role\`)
    `);
    
    // Update existing data
    await queryRunner.query(`
      UPDATE \`user\`
      SET \`role\` = 'admin'
      WHERE \`email\` LIKE '%@admin.com'
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`DROP INDEX \`IDX_user_role\` ON \`user\``);
    await queryRunner.query(`ALTER TABLE \`user\` DROP COLUMN \`role\``);
  }
}
```

**Migration best practices:**

**1. Keep migrations small and focused:**
```javascript
// ❌ BAD: Too many changes in one migration
exports.up = function(knex) {
  // Creates 5 tables, modifies 3, adds 10 columns
};

// ✅ GOOD: One logical change per migration
// Migration 1: Create users table
// Migration 2: Add email_verified column
// Migration 3: Create profiles table
// Migration 4: Add foreign key constraint
```

**2. Make migrations reversible:**
```javascript
// Always provide down function
exports.down = function(knex) {
  // Should perfectly undo what up() did
  return knex.schema.dropTable('users');
};
```

**3. Use raw SQL for complex operations:**
```javascript
exports.up = function(knex) {
  return knex.schema.raw(`
    CREATE OR REPLACE VIEW active_users AS
    SELECT * FROM users 
    WHERE is_active = true 
    AND deleted_at IS NULL
  `);
};

exports.down = function(knex) {
  return knex.schema.raw('DROP VIEW IF EXISTS active_users');
};
```

**4. Handle data migrations carefully:**
```javascript
exports.up = async function(knex) {
  // Backup data before destructive changes
  await knex.raw(`
    CREATE TABLE users_backup AS 
    SELECT * FROM users
  `);
  
  // Perform migration
  await knex.schema.table('users', (table) => {
    table.dropColumn('old_column');
  });
  
  // Verify data integrity
  const count = await knex('users').count('* as total').first();
  console.log(`Migrated ${count.total} users`);
};

exports.down = async function(knex) {
  // Restore from backup
  await knex.raw(`
    INSERT INTO users SELECT * FROM users_backup
  `);
  
  await knex.schema.dropTable('users_backup');
};
```

**5. Test migrations:**
```javascript
// test/migrations.test.js
const knex = require('knex');
const path = require('path');

describe('Migrations', () => {
  let testDb;
  
  beforeAll(async () => {
    testDb = knex({
      client: 'sqlite3',
      connection: ':memory:',
      useNullAsDefault: true
    });
    
    // Run all migrations
    await testDb.migrate.latest({
      directory: path.join(__dirname, '../migrations')
    });
  });
  
  afterAll(async () => {
    await testDb.destroy();
  });
  
  test('should create users table', async () => {
    const hasTable = await testDb.schema.hasTable('users');
    expect(hasTable).toBe(true);
  });
  
  test('should rollback successfully', async () => {
    await testDb.migrate.rollback();
    const hasTable = await testDb.schema.hasTable('users');
    expect(hasTable).toBe(false);
    
    // Run migrations again for other tests
    await testDb.migrate.latest();
  });
});
```

**6. Production deployment strategy:**
```bash
# Deployment script
#!/bin/bash
set -e

echo "Starting database migration..."

# Backup database before migration
echo "Creating backup..."
pg_dump $DATABASE_URL > backup_$(date +%Y%m%d_%H%M%S).sql

# Run migrations
echo "Running migrations..."
npm run knex migrate:latest -- --env production

# Verify migration
echo "Verifying migration..."
npm run knex migrate:status -- --env production

# Run seed data if needed
echo "Seeding data..."
npm run knex seed:run -- --env production

echo "Migration completed successfully!"
```

**7. Zero-downtime migrations:**
```javascript
// Strategy for adding columns
exports.up = async function(knex) {
  // Step 1: Add nullable column
  await knex.schema.table('users', (table) => {
    table.string('new_column').nullable();
  });
  
  // Step 2: Backfill data (in background job)
  // Step 3: Make column NOT NULL (in separate migration)
};

// Strategy for renaming columns
exports.up = async function(knex) {
  // Step 1: Add new column
  await knex.schema.table('users', (table) => {
    table.string('new_name').nullable();
  });
  
  // Step 2: Copy data
  await knex('users').update({
    new_name: knex.raw('old_name')
  });
  
  // Step 3: Update application code
  // Step 4: Drop old column (in separate migration)
};
```

**8. Migration tracking table:**
```sql
-- knex_migrations table structure
CREATE TABLE knex_migrations (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  batch INT NOT NULL,
  migration_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sequelize SequelizeMeta table
CREATE TABLE SequelizeMeta (
  name VARCHAR(255) NOT NULL PRIMARY KEY
);
```

**Common migration patterns:**

**1. Adding indexes:**
```javascript
exports.up = function(knex) {
  return knex.schema.table('users', (table) => {
    table.index('email');
    table.index(['last_name', 'first_name']);
    table.unique('username');
  });
};
```

**2. Changing column types:**
```javascript
exports.up = function(knex) {
  return knex.schema.table('products', (table) => {
    // MySQL specific
    table.decimal('price', 10, 2).alter();
    
    // PostgreSQL specific
    // table.specificType('price', 'DECIMAL(10,2)').alter();
  });
};
```

**3. Creating foreign keys:**
```javascript
exports.up = function(knex) {
  return knex.schema.table('posts', (table) => {
    table.integer('author_id').unsigned();
    table.foreign('author_id')
      .references('id')
      .inTable('users')
      .onDelete('CASCADE')
      .onUpdate('CASCADE');
  });
};
```

**4. Data transformation:**
```javascript
exports.up = async function(knex) {
  // Transform data
  await knex('users')
    .where('status', 'active')
    .update({
      is_active: true,
      updated_at: knex.fn.now()
    });
  
  await knex('users')
    .where('status', 'inactive')
    .update({
      is_active: false,
      updated_at: knex.fn.now()
    });
  
  // Remove old column
  return knex.schema.table('users', (table) => {
    table.dropColumn('status');
  });
};
```

**Migration tools comparison:**

| Feature | Knex | Sequelize | TypeORM |
|---------|------|-----------|---------|
| **SQL control** | High | Medium | Medium |
| **ORM integration** | No | Yes | Yes |
| **TypeScript** | Partial | Partial | Excellent |
| **Multiple DBs** | Yes | Yes | Yes |
| **Auto-generate** | No | Yes | Yes |
| **Seeding** | Yes | Yes | Yes |
| **Learning curve** | Low | Medium | High |

**Remember:** Migrations should be treated as code - version controlled, tested, and deployed systematically.

---
---

## 29. Database Connections & Pooling

#### 1. What is connection pooling and why is it important?

**Answer:**

**Connection pooling** is a technique where database connections are created in advance and maintained in a pool for reuse by multiple clients.

**Why connection pooling is important:**

**1. Performance improvement:**
```javascript
// Without pooling (slow):
// 1. TCP handshake
// 2. Authentication
// 3. Create connection
// 4. Execute query
// 5. Close connection
// → Repeat for every request

// With pooling (fast):
// 1. Get connection from pool (reuse existing)
// 2. Execute query
// 3. Return connection to pool
// → Connection stays alive for reuse
```

**2. Resource management:**
```javascript
// Problem: Too many connections
// Each request creates new connection
// Database hits max_connections limit
// New requests fail with "Too many connections"

// Solution: Connection pool
// Limits concurrent connections
// Queues excess requests
// Prevents database overload
```

**3. Connection reuse benefits:**
- **Reduced latency**: No TCP/SSL handshake for each query
- **Lower CPU usage**: Less connection setup overhead
- **Memory efficiency**: Shared connection state
- **Better throughput**: More queries per second

**4. Connection lifecycle management:**
```javascript
// Pool manages:
// - Connection creation
// - Connection validation
// - Idle timeout
// - Error recovery
// - Graceful shutdown
```

**Real-world analogy:**
- **Without pool**: Taxi stand - call taxi, wait for arrival, ride, pay, taxi leaves
- **With pool**: Taxi queue - taxis waiting, get in immediately, ride, return to queue

**Impact on web applications:**
```javascript
// Web server handling 1000 requests/second
// Without pool: 1000 new connections/second → Database overload
// With pool (10 connections): 10 connections handle all requests
// → 100x reduction in connection overhead
```

**Connection pooling in different databases:**

**MySQL:**
```javascript
// Default max_connections: 151
// Typical pool size: 10-100 connections
// Each connection: ~256KB memory
```

**PostgreSQL:**
```javascript
// Default max_connections: 100
// Typical pool size: 10-50 connections
// Each connection: ~2MB memory
```

**Connection states in pool:**
1. **Active**: Currently executing query
2. **Idle**: Available for use
3. **Creating**: Being established
4. **Closing**: Being terminated
5. **Failed**: Error state, needs cleanup

**Pool metrics to monitor:**
- **Active connections**: Currently in use
- **Idle connections**: Available for use
- **Wait time**: Time requests wait for connection
- **Connection rate**: New connections per second
- **Error rate**: Failed connections/queries

**When NOT to use pooling:**
1. **CLI tools**: One-off scripts
2. **Batch jobs**: Long-running, sequential queries
3. **Infrequent requests**: Less than 1 request/minute
4. **Memory-constrained environments**: Each connection uses memory

**Best practices:**
1. **Size pool appropriately**: Based on concurrent requests
2. **Monitor pool metrics**: For optimization
3. **Implement retry logic**: For transient failures
4. **Graceful degradation**: Handle pool exhaustion
5. **Connection validation**: Periodic health checks

---
---

#### 2. How do you configure connection pools?

**Answer:**

**MySQL pool configuration with mysql2:**
```javascript
const mysql = require('mysql2');

const pool = mysql.createPool({
  // Connection details
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 3306,
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'myapp',
  
  // Pool configuration
  connectionLimit: 10,           // Maximum connections in pool
  queueLimit: 0,                // Unlimited queue for waiting connections
  waitForConnections: true,     // Wait for connection if pool full
  
  // Connection lifecycle
  maxIdle: 10,                  // Maximum idle connections (mysql2 specific)
  idleTimeout: 60000,           // Close idle connections after 60s
  enableKeepAlive: true,        // Send keep-alive packets
  keepAliveInitialDelay: 0,     // Start keep-alive immediately
  
  // Timeouts
  connectTimeout: 10000,        // Connection timeout (10 seconds)
  
  // SSL/TLS
  ssl: process.env.NODE_ENV === 'production' 
    ? { rejectUnauthorized: true }
    : undefined,
  
  // Character set
  charset: 'utf8mb4',           // Support emojis and special characters
  
  // Timezone
  timezone: 'Z',                // UTC
  
  // Debug
  debug: process.env.NODE_ENV === 'development',
  
  // Multiple statements (be careful!)
  multipleStatements: false,
  
  // Connection validation
  validateConnection: (connection) => {
    return connection.query('SELECT 1')
      .then(() => true)
      .catch(() => false);
  }
});
```

**PostgreSQL pool configuration with pg:**
```javascript
const { Pool } = require('pg');

const pool = new Pool({
  // Connection details
  host: process.env.PG_HOST || 'localhost',
  port: process.env.PG_PORT || 5432,
  database: process.env.PG_DATABASE || 'myapp',
  user: process.env.PG_USER || 'postgres',
  password: process.env.PG_PASSWORD || '',
  
  // Pool configuration
  max: 20,                      // Maximum number of clients
  min: 4,                       // Minimum number of clients (pg-pool extension)
  idleTimeoutMillis: 30000,     // Close idle clients after 30s
  connectionTimeoutMillis: 2000, // Return error after 2s if no connection
  allowExitOnIdle: false,       // Don't allow process exit while clients are idle
  
  // Query timeout
  statement_timeout: 10000,     // Query timeout (10 seconds)
  
  // SSL/TLS
  ssl: process.env.NODE_ENV === 'production' 
    ? { 
        rejectUnauthorized: true,
        ca: fs.readFileSync('/path/to/ca-certificate.crt').toString()
      }
    : false,
  
  // Application name
  application_name: 'myapp-api',
  
  // Connection parameters
  options: '-c search_path=public',
  
  // Max connection lifetime
  maxUses: 7500,                // Close and recreate connection after N uses
  
  // Logging
  log: (msg, level) => {
    if (level === 'error') {
      console.error('Pool error:', msg);
    }
  }
});
```

**Knex pool configuration:**
```javascript
const knex = require('knex')({
  client: 'mysql2',
  connection: {
    host: '127.0.0.1',
    user: 'root',
    password: '',
    database: 'myapp'
  },
  pool: {
    // Pool configuration
    min: 2,
    max: 10,
    
    // Connection lifecycle
    idleTimeoutMillis: 30000,
    acquireTimeoutMillis: 30000,
    
    // Create/validate/destroy hooks
    createTimeoutMillis: 30000,
    createRetryIntervalMillis: 200,
    
    // Validation
    validate: (resource) => {
      return resource.query('SELECT 1')
        .then(() => true)
        .catch(() => false);
    },
    
    // Destroy hooks
    destroy: (client) => {
      client.end();
    },
    
    // After create hook
    afterCreate: (conn, done) => {
      // Set session variables
      conn.query('SET time_zone = "+00:00";', (err) => {
        done(err, conn);
      });
    }
  },
  
  // Debug
  debug: process.env.NODE_ENV === 'development',
  
  // Logging
  log: {
    warn(message) {
      console.warn('Knex warning:', message);
    },
    error(message) {
      console.error('Knex error:', message);
    },
    deprecate(message) {
      console.warn('Knex deprecation:', message);
    },
    debug(message) {
      console.debug('Knex debug:', message);
    }
  }
});
```

**Sequelize pool configuration:**
```javascript
const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('database', 'username', 'password', {
  host: 'localhost',
  dialect: 'mysql',
  
  pool: {
    max: 5,
    min: 0,
    acquire: 30000,
    idle: 10000,
    
    // Connection validation
    validate: (connection) => {
      return connection.query('SELECT 1')
        .then(() => true)
        .catch(() => false);
    },
    
    // Eviction policy
    evict: 1000, // Remove idle connections after 1s (if min > 0)
    
    // Max connection uses
    maxUses: 1000
  },
  
  // Retry configuration
  retry: {
    max: 3,
    match: [
      /SequelizeConnectionError/,
      /SequelizeConnectionRefusedError/,
      /SequelizeHostNotFoundError/,
      /SequelizeHostNotReachableError/,
      /SequelizeInvalidConnectionError/,
      /SequelizeConnectionTimedOutError/
    ],
    backoffBase: 100,
    backoffExponent: 1.1
  },
  
  // Transaction configuration
  transactionType: Sequelize.Transaction.TYPES.DEFERRED,
  isolationLevel: Sequelize.Transaction.ISOLATION_LEVELS.REPEATABLE_READ
});
```

**Environment-based configuration:**
```javascript
// config/database.js
function getPoolConfig() {
  const baseConfig = {
    // Common settings
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    charset: 'utf8mb4'
  };
  
  const environment = process.env.NODE_ENV || 'development';
  
  const poolConfigs = {
    development: {
      ...baseConfig,
      connectionLimit: 5,
      idleTimeout: 60000,
      debug: true
    },
    
    test: {
      ...baseConfig,
      connectionLimit: 2,
      idleTimeout: 30000,
      debug: false
    },
    
    staging: {
      ...baseConfig,
      connectionLimit: 10,
      idleTimeout: 30000,
      enableKeepAlive: true,
      ssl: { rejectUnauthorized: false }
    },
    
    production: {
      ...baseConfig,
      connectionLimit: 20,
      idleTimeout: 60000,
      enableKeepAlive: true,
      ssl: { rejectUnauthorized: true },
      connectTimeout: 10000,
      acquireTimeout: 10000
    }
  };
  
  return poolConfigs[environment] || poolConfigs.development;
}

module.exports = getPoolConfig();
```

**Dynamic pool configuration based on metrics:**
```javascript
class AdaptivePool {
  constructor(baseConfig) {
    this.pool = mysql.createPool(baseConfig);
    this.metrics = {
      waitTime: 0,
      activeConnections: 0,
      queueLength: 0
    };
    
    // Monitor and adjust pool size
    setInterval(() => this.adjustPoolSize(), 60000); // Every minute
  }
  
  adjustPoolSize() {
    const { waitTime, activeConnections, queueLength } = this.metrics;
    
    let newSize = this.pool.config.connectionLimit;
    
    // Increase pool size if high wait time
    if (waitTime > 100 && activeConnections === this.pool.config.connectionLimit) {
      newSize = Math.min(newSize * 1.5, 100); // Increase by 50%, max 100
    }
    
    // Decrease pool size if mostly idle
    if (activeConnections < this.pool.config.connectionLimit * 0.3) {
      newSize = Math.max(newSize * 0.8, 2); // Decrease by 20%, min 2
    }
    
    if (newSize !== this.pool.config.connectionLimit) {
      console.log(`Adjusting pool size from ${this.pool.config.connectionLimit} to ${newSize}`);
      this.pool.config.connectionLimit = newSize;
    }
  }
  
  async query(sql, params) {
    const start = Date.now();
    
    // Record wait time
    const connection = await this.pool.getConnection();
    this.metrics.waitTime = Date.now() - start;
    this.metrics.activeConnections++;
    
    try {
      const result = await connection.query(sql, params);
      return result;
    } finally {
      connection.release();
      this.metrics.activeConnections--;
    }
  }
}
```

**Pool configuration for different workloads:**

**Web application (high concurrency):**
```javascript
const webAppPool = {
  connectionLimit: 20,      // Handle concurrent requests
  idleTimeout: 30000,       // Moderate idle timeout
  queueLimit: 100,          // Queue excess requests
  enableKeepAlive: true     // Maintain connections
};
```

**Background job processor:**
```javascript
const jobProcessorPool = {
  connectionLimit: 5,       // Fewer concurrent jobs
  idleTimeout: 60000,       // Longer idle timeout
  queueLimit: 0,            // No queue (fail fast)
  enableKeepAlive: false    // Jobs are bursty
};
```

**Microservice (low traffic):**
```javascript
const microservicePool = {
  connectionLimit: 3,       // Minimal connections
  idleTimeout: 120000,      // Long idle timeout
  queueLimit: 10,           // Small queue
  enableKeepAlive: true     // Keep connections alive
};
```

**Read replica pool (read-heavy):**
```javascript
const readReplicaPool = {
  connectionLimit: 30,      // Many read connections
  idleTimeout: 30000,       // Moderate idle
  queueLimit: 50,           // Queue reads
  enableKeepAlive: true,    // Maintain connections
  // MySQL specific: route to read replica
  host: process.env.READ_REPLICA_HOST
};
```

**Write pool (write operations):**
```javascript
const writePool = {
  connectionLimit: 10,      // Fewer write connections
  idleTimeout: 60000,       // Longer idle
  queueLimit: 0,            // No queue for writes
  enableKeepAlive: true,    // Maintain connections
  // MySQL specific: route to primary
  host: process.env.PRIMARY_HOST
};
```

**Configuration validation:**
```javascript
function validatePoolConfig(config) {
  const errors = [];
  
  // Check required fields
  if (!config.host) errors.push('host is required');
  if (!config.database) errors.push('database is required');
  
  // Validate numeric fields
  if (config.connectionLimit && (config.connectionLimit < 1 || config.connectionLimit > 1000)) {
    errors.push('connectionLimit must be between 1 and 1000');
  }
  
  if (config.idleTimeout && config.idleTimeout < 1000) {
    errors.push('idleTimeout must be at least 1000ms');
  }
  
  // Validate SSL configuration
  if (config.ssl && typeof config.ssl !== 'object') {
    errors.push('ssl must be an object');
  }
  
  if (errors.length > 0) {
    throw new Error(`Invalid pool configuration: ${errors.join(', ')}`);
  }
  
  return config;
}

// Usage
const validatedConfig = validatePoolConfig(poolConfig);
const pool = mysql.createPool(validatedConfig);
```

**Best practices for pool configuration:**
1. **Start with defaults**: Then tune based on metrics
2. **Monitor actively**: Watch connection wait times
3. **Test under load**: Simulate production traffic
4. **Document settings**: Explain why each value was chosen
5. **Review regularly**: Adjust as application evolves
6. **Consider database limits**: Don't exceed max_connections
7. **Use environment variables**: For different environments
8. **Implement health checks**: Validate pool is working

---
---

#### 3. What are the common connection pool settings?

**Answer:**

**Core pool settings:**

**1. Size limits:**
```javascript
const poolSettings = {
  // Maximum connections in pool
  max: 20,                    // pg, generic
  connectionLimit: 10,        // mysql2
  poolMax: 15,               // oracledb
  
  // Minimum connections to maintain
  min: 5,                    // pg (with pg-pool), knex
  poolMin: 2,                // oracledb
  
  // Maximum waiting requests
  queueLimit: 100,           // mysql2
  maxWaitingClients: 50,     // generic
};
```

**2. Timeout settings:**
```javascript
const timeoutSettings = {
  // Connection acquisition timeout
  acquireTimeoutMillis: 30000,  // knex
  connectionTimeoutMillis: 2000, // pg
  
  // Idle connection timeout
  idleTimeoutMillis: 30000,     // pg, knex
  idleTimeout: 60000,          // mysql2 (ms)
  
  // Connection creation timeout
  createTimeoutMillis: 30000,   // knex
  connectTimeout: 10000,       // mysql2 (ms)
  
  // Query/statement timeout
  statement_timeout: 10000,    // pg (ms)
  queryTimeout: 30000,         // generic
};
```

**3. Lifecycle settings:**
```javascript
const lifecycleSettings = {
  // Maximum uses before recycling
  maxUses: 7500,              // pg
  maxUsesPerConnection: 1000, // sequelize
  
  // Keep-alive settings
  enableKeepAlive: true,      // mysql2
  keepAliveInitialDelay: 0,   // mysql2 (ms)
  
  // Validation frequency
  validationInterval: 30000,  // generic (ms)
  
  // Destroy behavior
  destroyTimeoutMillis: 5000, // knex
};
```

**4. Behavior settings:**
```javascript
const behaviorSettings = {
  // Wait for connection if pool full
  waitForConnections: true,   // mysql2
  
  // Allow process exit while idle
  allowExitOnIdle: false,     // pg
  
  // Logging level
  log: console.log,           // pg
  debug: false,               // mysql2
  
  // Error handling
  propagateCreateError: true, // knex
};
```

**MySQL-specific settings:**
```javascript
const mysqlSettings = {
  // Character set
  charset: 'utf8mb4',
  
  // Timezone
  timezone: 'Z',              // UTC
  timezone: 'local',          // Server local time
  
  // Multiple statements
  multipleStatements: false,  // Security risk if true
  
  // Decimal numbers
  decimalNumbers: true,
  
  // Date strings
  dateStrings: false,
  
  // Support big numbers
  supportBigNumbers: true,
  bigNumberStrings: true,
  
  // Named placeholders
  namedPlaceholders: true,
  
  // Type casting
  typeCast: function(field, next) {
    if (field.type === 'TINY' && field.length === 1) {
      return field.string() === '1'; // Convert to boolean
    }
    return next();
  }
};
```

**PostgreSQL-specific settings:**
```javascript
const pgSettings = {
  // Application name
  application_name: 'myapp-api',
  
  // Search path
  options: '-c search_path=public,extensions',
  
  // Connection parameters
  connectionString: process.env.DATABASE_URL,
  
  // Statement timeout
  statement_timeout: 10000,
  
  // Lock timeout
  lock_timeout: 5000,
  
  // Idle session timeout
  idle_in_transaction_session_timeout: 60000,
  
  // Default transaction isolation
  default_transaction_isolation: 'read committed',
  
  // Timezone
  timezone: 'UTC',
};
```

**SSL/TLS settings:**
```javascript
const sslSettings = {
  // Basic SSL
  ssl: true,
  
  // With certificate verification
  ssl: {
    rejectUnauthorized: true,
    ca: fs.readFileSync('ca-certificate.crt').toString(),
    key: fs.readFileSync('client-key.pem').toString(),
    cert: fs.readFileSync('client-cert.pem').toString()
  },
  
  // MySQL specific
  ssl: {
    ca: fs.readFileSync('ca.pem'),
    cert: fs.readFileSync('client-cert.pem'),
    key: fs.readFileSync('client-key.pem')
  },
  
  // Require SSL
  sslmode: 'require',        // PostgreSQL
};
```

**Connection validation settings:**
```javascript
const validationSettings = {
  // Validation query
  validate: (connection) => {
    return connection.query('SELECT 1')
      .then(() => true)
      .catch(() => false);
  },
  
  // MySQL validation
  validateConnection: (connection) => {
    return connection.ping();
  },
  
  // Validation interval
  validationInterval: 30000,
  
  // Test on borrow
  testOnBorrow: true,
  
  // Test on return
  testOnReturn: false,
  
  // Test while idle
  testWhileIdle: true,
};
```

**Event handlers:**
```javascript
const eventHandlers = {
  // Connection events
  on('connect', (client) => {
    console.log('Client connected');
  }),
  
  on('acquire', (connection) => {
    console.log('Connection acquired');
  }),
  
  on('release', (connection) => {
    console.log('Connection released');
  }),
  
  on('remove', (client) => {
    console.log('Client removed from pool');
  }),
  
  // Error events
  on('error', (err, client) => {
    console.error('Unexpected error on idle client', err);
  }),
  
  // Pool events
  on('enqueue', () => {
    console.log('Waiting for available connection');
  }),
};
```

**Recommended settings by use case:**

**Development environment:**
```javascript
const devSettings = {
  max: 5,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
  ssl: false,
  debug: true
};
```

**Production web application:**
```javascript
const productionWebSettings = {
  max: 20,
  min: 5,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 5000,
  ssl: { rejectUnauthorized: true },
  enableKeepAlive: true,
  maxUses: 7500
};
```

**Background worker:**
```javascript
const workerSettings = {
  max: 3,
  idleTimeoutMillis: 60000,
  connectionTimeoutMillis: 10000,
  queueLimit: 0,
  enableKeepAlive: false
};
```

**Read-heavy application:**
```javascript
const readHeavySettings = {
  max: 30,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
  queueLimit: 100,
  enableKeepAlive: true
};
```

**Write-heavy application:**
```javascript
const writeHeavySettings = {
  max: 10,
  idleTimeoutMillis: 60000,
  connectionTimeoutMillis: 5000,
  queueLimit: 0,
  enableKeepAlive: true
};
```

**Settings that affect performance:**

**1. Pool size:**
```javascript
// Too small: Connection wait time increases
{ max: 2 } // ❌ Bottleneck with concurrent requests

// Too large: Database resource waste
{ max: 100 } // ❌ Each connection uses memory/CPU

// Just right: Based on concurrency
{ max: 20 } // ✅ For typical web app
```

**2. Timeouts:**
```javascript
// Too short: Premature failures
{ idleTimeoutMillis: 5000 } // ❌ Connections close too quickly

// Too long: Resource waste
{ idleTimeoutMillis: 300000 } // ❌ Idle connections linger

// Balanced: Match usage patterns
{ idleTimeoutMillis: 30000 } // ✅ 30 seconds idle timeout
```

**3. Validation:**
```javascript
// Too frequent: Performance overhead
{ validationInterval: 5000 } // ❌ Validate every 5 seconds

// Too infrequent: Stale connections
{ validationInterval: 300000 } // ❌ Validate every 5 minutes

// Reasonable: Balance overhead and freshness
{ validationInterval: 30000 } // ✅ Validate every 30 seconds
```

**Monitoring important settings:**
```javascript
// Track these metrics
const metrics = {
  // Pool utilization
  activeConnections: pool.totalCount - pool.idleCount,
  poolUtilization: (pool.totalCount - pool.idleCount) / pool.totalCount,
  
  // Wait times
  averageWaitTime: calculateAverageWaitTime(),
  maxWaitTime: getMaxWaitTime(),
  
  // Errors
  connectionErrors: getErrorCount('connection'),
  timeoutErrors: getErrorCount('timeout'),
  
  // Throughput
  queriesPerSecond: calculateQPS(),
  connectionsPerSecond: calculateCPS(),
};
```

**Tuning guidelines:**
1. **Start conservative**: Small pool, moderate timeouts
2. **Monitor under load**: Watch for wait times and errors
3. **Adjust incrementally**: Change one setting at a time
4. **Test thoroughly**: Verify changes don't break anything
5. **Document changes**: Record what worked and why

**Common pitfalls:**
```javascript
// ❌ No connection limit (can exhaust database)
{ max: undefined }

// ❌ No idle timeout (connections never close)
{ idleTimeoutMillis: 0 }

// ❌ No SSL in production
{ ssl: false } // In production!

// ❌ No validation (stale connections)
{ validate: undefined }

// ❌ Too short acquisition timeout
{ acquireTimeoutMillis: 100 } // Fails under load

// ✅ Good defaults
{
  max: 20,
  idleTimeoutMillis: 30000,
  acquireTimeoutMillis: 30000,
  ssl: process.env.NODE_ENV === 'production',
  validate: (conn) => conn.query('SELECT 1')
}
```

**Remember:** Pool settings should be tuned based on your specific workload, database capabilities, and performance requirements.

---
---

#### 4. How do you handle connection errors and retries?

**Answer:**

**Connection errors** can occur due to network issues, database restarts, or resource constraints. Proper error handling and retry logic are essential for resilience.

**Common connection errors:**

**MySQL errors:**
```javascript
const mysqlErrors = {
  // Connection errors
  'ECONNREFUSED': 'Connection refused',
  'ETIMEDOUT': 'Connection timeout',
  'PROTOCOL_CONNECTION_LOST': 'Connection lost',
  'ER_CON_COUNT_ERROR': 'Too many connections',
  'ER_ACCESS_DENIED_ERROR': 'Access denied',
  
  // Query errors
  'ER_LOCK_DEADLOCK': 'Deadlock found',
  'ER_LOCK_WAIT_TIMEOUT': 'Lock wait timeout',
  'ER_QUERY_INTERRUPTED': 'Query interrupted'
};
```

**PostgreSQL errors:**
```javascript
const pgErrors = {
  // Connection errors
  'ECONNREFUSED': 'Connection refused',
  'ETIMEDOUT': 'Connection timeout',
  '57P01': 'Admin shutdown',
  '57P02': 'Crash shutdown',
  '57P03': 'Cannot connect now',
  
  // Query errors
  '40P01': 'Deadlock detected',
  '55P03': 'Lock not available',
  '57014': 'Query canceled'
};
```

**Basic error handling:**
```javascript
const pool = mysql.createPool(config);

pool.getConnection((err, connection) => {
  if (err) {
    // Handle connection error
    console.error('Connection error:', err.code, err.message);
    
    if (err.code === 'ECONNREFUSED') {
      // Database is down
      return res.status(503).json({ error: 'Database unavailable' });
    }
    
    if (err.code === 'ER_CON_COUNT_ERROR') {
      // Too many connections
      return res.status(503).json({ error: 'Database overloaded' });
    }
    
    // Generic error
    return res.status(500).json({ error: 'Database error' });
  }
  
  // Use connection
  connection.query('SELECT * FROM users', (queryErr, results) => {
    connection.release();
    
    if (queryErr) {
      console.error('Query error:', queryErr);
      return res.status(500).json({ error: 'Query failed' });
    }
    
    res.json(results);
  });
});
```

**Retry logic patterns:**

**1. Simple retry with exponential backoff:**
```javascript
async function queryWithRetry(sql, params, maxRetries = 3) {
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      const [rows] = await pool.promise().query(sql, params);
      return rows;
    } catch (err) {
      // Check if error is retryable
      const isRetryable = isRetryableError(err);
      
      if (!isRetryable || attempt === maxRetries) {
        throw err;
      }
      
      // Calculate delay with exponential backoff
      const delay = Math.min(1000 * Math.pow(2, attempt - 1), 10000);
      console.log(`Retry ${attempt}/${maxRetries} in ${delay}ms:`, err.message);
      
      await new Promise(resolve => setTimeout(resolve, delay));
    }
  }
}

function isRetryableError(err) {
  const retryableCodes = [
    'ECONNREFUSED', 'ETIMEDOUT', 'PROTOCOL_CONNECTION_LOST',
    'ER_LOCK_DEADLOCK', 'ER_LOCK_WAIT_TIMEOUT',
    '57P01', '57P02', '57P03', '40P01'
  ];
  
  return retryableCodes.includes(err.code);
}
```

**2. Circuit breaker pattern:**
```javascript
class CircuitBreaker {
  constructor(threshold = 5, timeout = 60000) {
    this.failureCount = 0;
    this.threshold = threshold;
    this.timeout = timeout;
    this.state = 'CLOSED'; // CLOSED, OPEN, HALF_OPEN
    this.nextAttempt = 0;
  }
  
  async execute(operation) {
    const now = Date.now();
    
    if (this.state === 'OPEN' && now < this.nextAttempt) {
      throw new Error('Circuit breaker is OPEN');
    }
    
    try {
      const result = await operation();
      
      // Success - reset failure count
      if (this.state === 'HALF_OPEN') {
        this.state = 'CLOSED';
      }
      this.failureCount = 0;
      
      return result;
    } catch (err) {
      this.failureCount++;
      
      if (this.failureCount >= this.threshold) {
        this.state = 'OPEN';
        this.nextAttempt = now + this.timeout;
        
        // Schedule half-open state
        setTimeout(() => {
          this.state = 'HALF_OPEN';
        }, this.timeout);
      }
      
      throw err;
    }
  }
}

// Usage
const breaker = new CircuitBreaker();
const result = await breaker.execute(() => 
  pool.query('SELECT * FROM users')
);
```

**3. Connection pool with built-in retry:**
```javascript
class ResilientPool {
  constructor(config, retryConfig = {}) {
    this.pool = mysql.createPool(config);
    this.retryConfig = {
      maxRetries: 3,
      initialDelay: 100,
      maxDelay: 10000,
      ...retryConfig
    };
  }
  
  async query(sql, params) {
    let lastError;
    
    for (let i = 0; i <= this.retryConfig.maxRetries; i++) {
      try {
        const [rows] = await this.pool.promise().query(sql, params);
        return rows;
      } catch (err) {
        lastError = err;
        
        if (i === this.retryConfig.maxRetries) {
          break;
        }
        
        if (!this.shouldRetry(err)) {
          break;
        }
        
        const delay = this.calculateDelay(i);
        console.log(`Query failed, retrying in ${delay}ms:`, err.message);
        await new Promise(resolve => setTimeout(resolve, delay));
      }
    }
    
    throw lastError;
  }
  
  shouldRetry(err) {
    const retryable = [
      'PROTOCOL_CONNECTION_LOST',
      'ER_LOCK_DEADLOCK',
      'ER_LOCK_WAIT_TIMEOUT',
      'ECONNREFUSED',
      'ETIMEDOUT'
    ];
    
    return retryable.includes(err.code);
  }
  
  calculateDelay(attempt) {
    const { initialDelay, maxDelay } = this.retryConfig;
    const delay = initialDelay * Math.pow(2, attempt);
    return Math.min(delay, maxDelay);
  }
}
```

**4. Health check and reconnection:**
```javascript
class HealthyPool {
  constructor(config) {
    this.config = config;
    this.pool = null;
    this.healthy = false;
    this.reconnectAttempts = 0;
    
    this.initialize();
    this.startHealthChecks();
  }
  
  initialize() {
    this.pool = mysql.createPool(this.config);
    
    // Connection events
    this.pool.on('connection', (connection) => {
      console.log('New connection established');
    });
    
    this.pool.on('error', (err) => {
      console.error('Pool error:', err);
      this.healthy = false;
      this.scheduleReconnect();
    });
  }
  
  startHealthChecks() {
    setInterval(async () => {
      try {
        await this.pool.promise().query('SELECT 1');
        this.healthy = true;
        this.reconnectAttempts = 0;
      } catch (err) {
        console.error('Health check failed:', err.message);
        this.healthy = false;
      }
    }, 30000); // Every 30 seconds
  }
  
  scheduleReconnect() {
    if (this.reconnectAttempts >= 5) {
      console.error('Max reconnection attempts reached');
      return;
    }
    
    const delay = Math.min(1000 * Math.pow(2, this.reconnectAttempts), 30000);
    this.reconnectAttempts++;
    
    console.log(`Scheduling reconnect in ${delay}ms (attempt ${this.reconnectAttempts})`);
    
    setTimeout(() => {
      console.log('Attempting to reconnect...');
      this.pool.end(() => {
        this.initialize();
      });
    }, delay);
  }
  
  async query(sql, params) {
    if (!this.healthy) {
      throw new Error('Pool is not healthy');
    }
    
    return await this.pool.promise().query(sql, params);
  }
}
```

**5. Error classification and handling:**
```javascript
class ErrorHandler {
  static classifyError(err) {
    // Connection errors
    if (err.code === 'ECONNREFUSED' || err.code === 'ETIMEDOUT') {
      return {
        type: 'CONNECTION',
        severity: 'HIGH',
        retryable: true,
        action: 'RETRY_WITH_BACKOFF'
      };
    }
    
    // Authentication errors
    if (err.code === 'ER_ACCESS_DENIED_ERROR') {
      return {
        type: 'AUTHENTICATION',
        severity: 'HIGH',
        retryable: false,
        action: 'CHECK_CREDENTIALS'
      };
    }
    
    // Resource errors
    if (err.code === 'ER_CON_COUNT_ERROR') {
      return {
        type: 'RESOURCE',
        severity: 'MEDIUM',
        retryable: true,
        action: 'WAIT_AND_RETRY'
      };
    }
    
    // Deadlock errors
    if (err.code === 'ER_LOCK_DEADLOCK') {
      return {
        type: 'CONCURRENCY',
        severity: 'LOW',
        retryable: true,
        action: 'RETRY_IMMEDIATELY'
      };
    }
    
    // Default
    return {
      type: 'UNKNOWN',
      severity: 'MEDIUM',
      retryable: false,
      action: 'LOG_AND_ALERT'
    };
  }
  
  static handleError(err, context) {
    const classification = this.classifyError(err);
    
    console.error('Database error:', {
      code: err.code,
      message: err.message,
      classification,
      context,
      timestamp: new Date().toISOString()
    });
    
    // Take action based on classification
    switch (classification.action) {
      case 'RETRY_WITH_BACKOFF':
        return { shouldRetry: true, delay: 1000 };
        
      case 'RETRY_IMMEDIATELY':
        return { shouldRetry: true, delay: 0 };
        
      case 'WAIT_AND_RETRY':
        return { shouldRetry: true, delay: 5000 };
        
      case 'CHECK_CREDENTIALS':
        // Alert admin
        sendAlert('Database authentication failed');
        return { shouldRetry: false };
        
      case 'LOG_AND_ALERT':
        sendAlert(`Database error: ${err.code}`);
        return { shouldRetry: false };
        
      default:
        return { shouldRetry: false };
    }
  }
}

// Usage
try {
  await pool.query('SELECT * FROM users');
} catch (err) {
  const handling = ErrorHandler.handleError(err, { query: 'getUsers' });
  
  if (handling.shouldRetry) {
    await new Promise(resolve => setTimeout(resolve, handling.delay));
    // Retry logic...
  }
}
```

**6. Graceful degradation:**
```javascript
async function getUsersWithFallback() {
  try {
    // Try primary database
    return await primaryPool.query('SELECT * FROM users');
  } catch (primaryErr) {
    console.error('Primary database failed:', primaryErr.message);
    
    // Check if error is retryable on primary
    if (isRetryableError(primaryErr)) {
      try {
        // Retry primary with backoff
        await new Promise(resolve => setTimeout(resolve, 1000));
        return await primaryPool.query('SELECT * FROM users');
      } catch (retryErr) {
        console.error('Primary retry failed:', retryErr.message);
      }
    }
    
    // Fall back to replica
    try {
      console.log('Falling back to read replica');
      return await replicaPool.query('SELECT * FROM users');
    } catch (replicaErr) {
      console.error('Replica also failed:', replicaErr.message);
      
      // Final fallback: cached data
      console.log('Using cached data');
      return getCachedUsers();
    }
  }
}
```

**7. Monitoring and alerting:**
```javascript
class ConnectionMonitor {
  constructor() {
    this.metrics = {
      totalErrors: 0,
      errorByType: {},
      lastError: null,
      errorRate: 0
    };
    
    this.alerts = [];
  }
  
  recordError(err, context) {
    this.metrics.totalErrors++;
    
    // Track by error type
    const errorType = err.code || 'UNKNOWN';
    this.metrics.errorByType[errorType] = 
      (this.metrics.errorByType[errorType] || 0) + 1;
    
    this.metrics.lastError = {
      type: errorType,
      message: err.message,
      context,
      timestamp: new Date()
    };
    
    // Calculate error rate (last 5 minutes)
    this.calculateErrorRate();
    
    // Check for alert conditions
    this.checkAlerts(err);
  }
  
  calculateErrorRate() {
    // Implementation would track errors over time window
    // For simplicity, using a mock
    this.metrics.errorRate = this.metrics.totalErrors / 100;
  }
  
  checkAlerts(err) {
    // Alert on high error rate
    if (this.metrics.errorRate > 0.1) { // 10% error rate
      this.triggerAlert('HIGH_ERROR_RATE', {
        rate: this.metrics.errorRate,
        errors: this.metrics.totalErrors
      });
    }
    
    // Alert on specific critical errors
    const criticalErrors = ['ECONNREFUSED', 'ER_ACCESS_DENIED_ERROR'];
    if (criticalErrors.includes(err.code)) {
      this.triggerAlert('CRITICAL_ERROR', {
        code: err.code,
        message: err.message
      });
    }
  }
  
  triggerAlert(type, data) {
    const alert = {
      type,
      data,
      timestamp: new Date(),
      resolved: false
    };
    
    this.alerts.push(alert);
    
    // Send alert (email, Slack, etc.)
    sendAlert(alert);
  }
  
  getMetrics() {
    return {
      ...this.metrics,
      alerts: this.alerts.filter(a => !a.resolved)
    };
  }
}
```

**Best practices for error handling:**
1. **Classify errors**: Differentiate between retryable and non-retryable
2. **Implement backoff**: Exponential backoff for retries
3. **Set limits**: Maximum retry attempts
4. **Monitor error rates**: Alert on abnormal patterns
5. **Graceful degradation**: Fall back to cached data or replicas
6. **Circuit breaking**: Prevent cascading failures
7. **Log comprehensively**: Include context for debugging
8. **Test error scenarios**: Simulate failures in testing

**Remember:** Good error handling makes your application resilient to transient failures while preventing infinite retry loops.

---
---

#### 5. What is the difference between creating a new connection vs using a pool?

**Answer:**

**Creating a new connection** establishes a fresh database connection for each operation, while **using a pool** reuses connections from a managed pool.

**New connection approach:**
```javascript
// ❌ Creating new connection for each request
async function getUser(userId) {
  // 1. Create new connection
  const connection = await mysql.createConnection(config);
  
  try {
    // 2. Execute query
    const [rows] = await connection.execute(
      'SELECT * FROM users WHERE id = ?',
      [userId]
    );
    
    return rows[0];
  } finally {
    // 3. Close connection
    await connection.end();
  }
}

// Problems:
// - High overhead for each request
// - No connection reuse
// - Can exhaust database connection limits
// - Slower response times
```

**Connection pool approach:**
```javascript
// ✅ Using connection pool
const pool = mysql.createPool(config);

async function getUser(userId) {
  // 1. Get connection from pool (reuse existing)
  const connection = await pool.promise().getConnection();
  
  try {
    // 2. Execute query
    const [rows] = await connection.execute(
      'SELECT * FROM users WHERE id = ?',
      [userId]
    );
    
    return rows[0];
  } finally {
    // 3. Release connection back to pool
    connection.release();
  }
}

// Benefits:
// - Connection reuse
// - Lower overhead
// - Controlled connection count
// - Better performance
```

**Detailed comparison:**

| Aspect | New Connection | Connection Pool |
|--------|---------------|-----------------|
| **Performance** | Slow (connection setup each time) | Fast (reuse connections) |
| **Resource usage** | High (each connection uses memory) | Efficient (shared connections) |
| **Scalability** | Poor (hits connection limits quickly) | Good (manages limited connections) |
| **Overhead** | High (TCP/SSL handshake each time) | Low (one-time setup) |
| **Connection limits** | Easy to exceed database limits | Controlled within pool limits |
| **Error handling** | Simple (connection dies with process) | Complex (pool manages failures) |
| **Use case** | CLI tools, one-off scripts | Web servers, applications |
| **Memory usage** | High (each connection ~256KB-2MB) | Optimized (shared among requests) |

**Performance impact:**

**Latency comparison:**
```javascript
// Benchmark: 1000 sequential queries

// New connections: ~10 seconds
// 1. TCP handshake: 1-3ms × 1000 = 1-3s
// 2. SSL negotiation: 10-100ms × 1000 = 10-100s
// 3. Authentication: 1-5ms × 1000 = 1-5s
// 4. Query execution: 1ms × 1000 = 1s
// Total: ~13-109 seconds

// Connection pool: ~1 second
// 1. Pool setup: 10-100ms (once)
// 2. Get connection: 0.1ms × 1000 = 0.1s
// 3. Query execution: 1ms × 1000 = 1s
// 4. Release connection: 0.1ms × 1000 = 0.1s
// Total: ~1.2 seconds

// Result: Pool is 10-100x faster for high concurrency
```

**Resource usage comparison:**

**Memory:**
```javascript
// 100 concurrent requests

// New connections:
// 100 connections × 2MB each = 200MB memory
// Database: 100 connections active

// Connection pool (size 20):
// 20 connections × 2MB each = 40MB memory
// Database: 20 connections active
// 80 requests queued or waiting

// Memory savings: 160MB (80% reduction)
```

**CPU usage:**
```javascript
// Connection establishment CPU cost:
// 1. TCP handshake: Medium CPU
// 2. SSL handshake: High CPU (crypto operations)
// 3. Authentication: Medium CPU
// 4. Session setup: Low CPU

// With pooling: One-time cost for pool setup
// Without pooling: Cost for every request
```

**Database impact:**

**Connection limits:**
```javascript
// MySQL default: max_connections = 151
// PostgreSQL default: max_connections = 100

// Scenario: 200 concurrent requests

// New connections: ❌ FAILS
// 200 > 151 (MySQL) or 200 > 100 (PostgreSQL)
// Error: "Too many connections"

// Connection pool (size 20): ✅ WORKS
// Only 20 connections to database
// 180 requests wait in queue
```

**Connection states:**
```javascript
// Database sees:

// New connections:
// - Many connections in "Sleep" state
// - Short-lived connections
// - High connection churn
// - More work for connection cleanup

// Connection pool:
// - Fewer, long-lived connections
// - Connections mostly active
// - Predictable connection patterns
// - Less cleanup overhead
```

**When to use new connections:**

**Appropriate use cases:**
```javascript
// 1. Command-line tools
async function runScript() {
  const connection = await mysql.createConnection(config);
  // Run one-off queries
  await connection.end();
}

// 2. Batch processing (sequential)
async function processBatch() {
  const connection = await mysql.createConnection(config);
  
  for (const item of items) {
    await connection.query('INSERT ...', item);
  }
  
  await connection.end();
}

// 3. Infrequent operations (< 1/minute)
async function nightlyReport() {
  const connection = await mysql.createConnection(config);
  // Generate report once per day
  await connection.end();
}

// 4. Administrative tasks
async function runMaintenance() {
  const connection = await mysql.createConnection(config);
  // Run OPTIMIZE TABLE, etc.
  await connection.end();
}
```

**When to use connection pools:**

**Appropriate use cases:**
```javascript
// 1. Web applications
const app = express();
const pool = mysql.createPool(config);

app.get('/users', async (req, res) => {
  const users = await pool.query('SELECT * FROM users');
  res.json(users);
});

// 2. API servers
const server = new GraphQLServer({
  context: () => ({
    db: pool // Share pool across requests
  })
});

// 3. Microservices
class UserService {
  constructor() {
    this.pool = mysql.createPool(config);
  }
  
  async getUser(id) {
    return this.pool.query('SELECT * FROM users WHERE id = ?', [id]);
  }
}

// 4. Real-time applications
const io = require('socket.io')(server);

io.on('connection', (socket) => {
  socket.on('message', async (data) => {
    // Use pool for each message
    await pool.query('INSERT INTO messages ...', data);
  });
});
```

**Hybrid approach:**
```javascript
// Use both strategies appropriately
class DatabaseManager {
  constructor() {
    // Pool for regular operations
    this.pool = mysql.createPool({
      connectionLimit: 20,
      ...config
    });
  }
  
  // Use pool for web requests
  async query(sql, params) {
    return this.pool.query(sql, params);
  }
  
  // Use new connection for admin tasks
  async adminQuery(sql, params) {
    const connection = await mysql.createConnection(config);
    try {
      return await connection.query(sql, params);
    } finally {
      await connection.end();
    }
  }
  
  // Use dedicated connection for transactions
  async transaction(callback) {
    const connection = await this.pool.getConnection();
    try {
      await connection.beginTransaction();
      const result = await callback(connection);
      await connection.commit();
      return result;
    } catch (err) {
      await connection.rollback();
      throw err;
    } finally {
      connection.release();
    }
  }
}
```

**Migration from new connections to pool:**

**Before (problematic):**
```javascript
// Old code: New connection per request
app.get('/users/:id', async (req, res) => {
  const connection = await mysql.createConnection(config);
  
  try {
    const [user] = await connection.query(
      'SELECT * FROM users WHERE id = ?',
      [req.params.id]
    );
    
    res.json(user);
  } catch (err) {
    res.status(500).json({ error: err.message });
  } finally {
    await connection.end();
  }
});
```

**After (improved with pool):**
```javascript
// Initialize pool once
const pool = mysql.createPool(config);

// Updated code
app.get('/users/:id', async (req, res) => {
  try {
    const [user] = await pool.query(
      'SELECT * FROM users WHERE id = ?',
      [req.params.id]
    );
    
    res.json(user);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
  // No need to close connection - pool manages it
});
```

**Testing both approaches:**
```javascript
// Performance test
async function benchmark() {
  const iterations = 100;
  
  // Test new connections
  console.time('New connections');
  for (let i = 0; i < iterations; i++) {
    const connection = await mysql.createConnection(config);
    await connection.query('SELECT 1');
    await connection.end();
  }
  console.timeEnd('New connections');
  
  // Test connection pool
  const pool = mysql.createPool(config);
  console.time('Connection pool');
  for (let i = 0; i < iterations; i++) {
    await pool.query('SELECT 1');
  }
  console.timeEnd('Connection pool');
  await pool.end();
  
  // Typical results:
  // New connections: 5000-10000ms
  // Connection pool: 100-500ms
  // Improvement: 50-100x faster
}

benchmark();
```

**Decision matrix:**

| Consideration | Choose New Connection | Choose Connection Pool |
|--------------|----------------------|------------------------|
| **Request rate** | < 1 request/minute | > 1 request/second |
| **Concurrency** | Single user | Multiple concurrent users |
| **Connection lifetime** | Short-lived | Long-lived |
| **Database load** | Low | Medium to high |
| **Application type** | CLI, script | Web app, API, service |
| **Resource constraints** | Memory not concern | Memory optimization needed |
| **Development phase** | Prototype, testing | Production |

**Best practices summary:**
1. **Default to pooling** for web applications
2. **Use new connections** for scripts and admin tasks
3. **Monitor pool metrics** to optimize size
4. **Implement connection reuse** in application code
5. **Consider hybrid approach** for complex scenarios
6. **Test performance** with realistic workloads
7. **Document connection strategy** for team awareness

**Remember:** Connection pooling is essential for production web applications, while new connections are suitable for one-off operations. Choose based on your application's concurrency needs and performance requirements.

---
---

## 30. ORM/ODM Patterns

#### 1. What are ORMs and ODMs?

**Answer:**

**ORM (Object-Relational Mapping)** is a technique that converts data between incompatible type systems in object-oriented programming languages and relational databases.

**ODM (Object-Document Mapping)** is similar to ORM but for document databases (like MongoDB) instead of relational databases.

**Basic concept:**
```javascript
// Without ORM (raw SQL)
const result = await db.query(
  'SELECT id, name, email FROM users WHERE id = ?',
  [userId]
);
const user = result[0];
// user is a plain object: { id: 1, name: 'John', email: 'john@example.com' }

// With ORM
const user = await User.findByPk(userId);
// user is an instance of User model with methods
console.log(user.name); // 'John'
console.log(user.getFullName()); // Method call
await user.update({ name: 'Jane' }); // Instance method
```

**ORM benefits:**
1. **Abstraction**: Hide SQL details
2. **Productivity**: Less boilerplate code
3. **Type safety**: Better IDE support
4. **Relationships**: Easy model associations
5. **Validation**: Built-in data validation
6. **Migrations**: Schema version control

**ODM benefits (MongoDB with Mongoose):**
1. **Schema enforcement**: MongoDB is schemaless, Mongoose adds structure
2. **Validation**: Data type and constraint validation
3. **Middleware**: Pre/post hooks for operations
4. **Population**: Easy document references
5. **Virtuals**: Computed properties
6. **Methods**: Instance and static methods

**Popular ORMs/ODMs for Node.js:**

**1. Sequelize (ORM):**
```javascript
const { Sequelize, DataTypes } = require('sequelize');
const sequelize = new Sequelize('database', 'username', 'password', {
  dialect: 'mysql'
});

const User = sequelize.define('User', {
  name: DataTypes.STRING,
  email: DataTypes.STRING
});

await User.sync();
const users = await User.findAll();
```

**2. TypeORM (ORM):**
```typescript
import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity()
export class User {
  @PrimaryGeneratedColumn()
  id: number;
  
  @Column()
  name: string;
  
  @Column()
  email: string;
}

const userRepository = connection.getRepository(User);
const users = await userRepository.find();
```

**3. Prisma (ORM):**
```javascript
// schema.prisma
model User {
  id    Int     @id @default(autoincrement())
  name  String
  email String  @unique
}

// Usage
const users = await prisma.user.findMany();
const user = await prisma.user.create({
  data: { name: 'John', email: 'john@example.com' }
});
```

**4. Mongoose (ODM):**
```javascript
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const userSchema = new Schema({
  name: String,
  email: String
});

const User = mongoose.model('User', userSchema);
const users = await User.find();
```

**5. Bookshelf (ORM):**
```javascript
const User = bookshelf.Model.extend({
  tableName: 'users',
  posts() {
    return this.hasMany(Post);
  }
});

const users = await User.fetchAll();
```

**ORM vs ODM comparison:**

| Aspect | ORM (Sequelize) | ODM (Mongoose) |
|--------|-----------------|----------------|
| **Database** | SQL (MySQL, PostgreSQL, etc.) | MongoDB |
| **Schema** | Table-based | Document-based |
| **Relationships** | Joins | References/Population |
| **Queries** | SQL generated | MongoDB query language |
| **Transactions** | Supported | Multi-document transactions |
| **Migrations** | Built-in | Manual or third-party |

**Core ORM concepts:**

**1. Models:**
```javascript
// Define data structure
class User extends Model {}
User.init({
  name: DataTypes.STRING,
  email: DataTypes.STRING
}, { sequelize, modelName: 'user' });
```

**2. Associations:**
```javascript
// One-to-many
User.hasMany(Post);
Post.belongsTo(User);

// Many-to-many
User.belongsToMany(Project, { through: 'UserProjects' });
Project.belongsToMany(User, { through: 'UserProjects' });
```

**3. Querying:**
```javascript
// Find with conditions
const users = await User.findAll({
  where: {
    age: { [Op.gt]: 18 }
  },
  include: [Post] // Eager loading
});
```

**4. Hooks:**
```javascript
User.beforeCreate((user, options) => {
  user.createdAt = new Date();
});

User.afterFind((users, options) => {
  console.log(`Found ${users.length} users`);
});
```

**Core ODM concepts (Mongoose):**

**1. Schemas:**
```javascript
const userSchema = new Schema({
  name: { type: String, required: true },
  email: { type: String, unique: true }
});
```

**2. Middleware:**
```javascript
userSchema.pre('save', function(next) {
  this.updatedAt = new Date();
  next();
});
```

**3. Virtuals:**
```javascript
userSchema.virtual('fullName').get(function() {
  return `${this.firstName} ${this.lastName}`;
});
```

**4. Population:**
```javascript
const user = await User.findById(userId).populate('posts');
// user.posts contains Post documents
```

**When to use ORM/ODM:**

**Use ORM when:**
- Working with relational databases
- Need complex queries with joins
- Require ACID transactions
- Have existing SQL database
- Need strong data consistency

**Use ODM when:**
- Working with MongoDB
- Need flexible schema
- Handling hierarchical data
- Prioritizing development speed
- Scaling horizontally

**Use raw queries when:**
- Need maximum performance
- Using database-specific features
- Complex analytics queries
- ORM generates inefficient SQL
- Full control over queries needed

**Remember:** ORMs/ODMs provide productivity benefits but come with learning curves and potential performance overhead. Choose based on your project requirements and team expertise.

---
---

#### 2. What are the advantages and disadvantages of using ORMs?

**Answer:**

**Advantages of ORMs:**

**1. Productivity and development speed:**
```javascript
// Without ORM
const result = await db.query(`
  INSERT INTO users (name, email, created_at) 
  VALUES (?, ?, ?)
`, [name, email, new Date()]);
const userId = result.insertId;

// With ORM
const user = await User.create({ name, email });
// One line, no SQL to write
```

**2. Database abstraction:**
```javascript
// Same code works with different databases
const sequelize = new Sequelize({
  dialect: 'mysql', // or 'postgres', 'sqlite', 'mssql'
  // ... config
});

// Code remains the same regardless of database
const users = await User.findAll();
```

**3. Type safety and autocompletion:**
```typescript
// TypeScript with TypeORM
@Entity()
export class User {
  @PrimaryGeneratedColumn()
  id: number;
  
  @Column()
  name: string; // TypeScript knows this is a string
  
  @Column()
  email: string;
}

// IDE autocompletion
const user = new User();
user.name = 'John'; // IDE suggests .name property
user.emial = '...'; // ❌ TypeScript error: typo
```

**4. Built-in validation:**
```javascript
const User = sequelize.define('User', {
  email: {
    type: DataTypes.STRING,
    validate: {
      isEmail: true,
      notEmpty: true
    }
  },
  age: {
    type: DataTypes.INTEGER,
    validate: {
      min: 0,
      max: 150
    }
  }
});

// Automatic validation
try {
  await User.create({ email: 'invalid', age: -5 });
} catch (err) {
  // ValidationError: Validation error messages
}
```

**5. Relationships and eager loading:**
```javascript
// Define relationships
User.hasMany(Post);
Post.belongsTo(User);

// Easy querying with relationships
const userWithPosts = await User.findOne({
  where: { id: userId },
  include: [Post] // Automatically joins and loads posts
});

console.log(userWithPosts.Posts); // Array of Post instances
```

**6. Migrations and schema management:**
```bash
# Generate migration from model changes
npx sequelize-cli migration:generate --name add-user-role

# Run migrations
npx sequelize-cli db:migrate

# Rollback
npx sequelize-cli db:migrate:undo
```

**7. Security (SQL injection prevention):**
```javascript
// ORM automatically parameterizes queries
const users = await User.findAll({
  where: {
    name: req.query.name // Safe from SQL injection
  }
});

// Equivalent to:
// SELECT * FROM users WHERE name = ? 
// with parameter: req.query.name
```

**8. Caching and optimization:**
```javascript
// Some ORMs include query caching
const users = await User.findAll({
  where: { active: true },
  cache: true, // Cache results
  cacheTTL: 300 // 5 minutes
});
```

**Disadvantages of ORMs:**

**1. Performance overhead:**
```javascript
// ORM-generated SQL might be inefficient
const users = await User.findAll({
  include: [
    { model: Post, include: [Comment] }
  ]
});

// Generated SQL might have unnecessary joins
// or fetch more data than needed
```

**2. Learning curve:**
```javascript
// ORM-specific syntax to learn
const users = await User.findAll({
  where: {
    [Op.and]: [
      { age: { [Op.gt]: 18 } },
      { status: { [Op.in]: ['active', 'pending'] } }
    ]
  },
  order: [['createdAt', 'DESC']],
  limit: 10,
  offset: 0
});

// vs raw SQL (more familiar to many developers)
const users = await db.query(`
  SELECT * FROM users 
  WHERE age > 18 AND status IN ('active', 'pending')
  ORDER BY created_at DESC
  LIMIT 10 OFFSET 0
`);
```

**3. Limited control over SQL:**
```javascript
// Complex query might be hard or impossible with ORM
const report = await db.query(`
  WITH ranked_users AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as rank
    FROM users
  )
  SELECT * FROM ranked_users WHERE rank <= 3
`);

// ORM might not support window functions or CTEs
// forcing you to use raw SQL anyway
```

**4. N+1 query problem:**
```javascript
// ❌ Inefficient: N+1 queries
const users = await User.findAll();
for (const user of users) {
  const posts = await user.getPosts(); // Separate query for each user
  // 1 query for users + N queries for posts
}

// ✅ Efficient: Eager loading
const users = await User.findAll({
  include: [Post] // Single query with JOIN
});
```

**5. Migration complexity:**
```javascript
// ORM migrations can be complex for schema changes
module.exports = {
  up: async (queryInterface, Sequelize) => {
    // Changing column type with data preservation
    await queryInterface.changeColumn('users', 'email', {
      type: Sequelize.STRING(255),
      allowNull: false,
      unique: true
    });
    
    // Need to handle data conversion, indexes, constraints
  }
};
```

**6. Vendor lock-in:**
```javascript
// ORM-specific code is hard to migrate away from
const users = await User.scope('active').findAll({
  include: [{ model: Post, as: 'articles' }]
});

// Switching to another ORM or raw SQL requires rewriting
```

**7. Debugging challenges:**
```javascript
// ORM hides SQL, making debugging harder
const users = await User.findAll({
  where: { /* complex conditions */ }
});

// What SQL was actually generated?
// Need to enable logging or use debug mode
```

**8. Over-fetching data:**
```javascript
// ORM might fetch entire objects when you only need specific fields
const users = await User.findAll(); // Fetches all columns

// vs optimized query
const userNames = await db.query('SELECT name FROM users');
```

**Performance comparison:**

**Simple query:**
```javascript
// Raw SQL: ~1ms
const result = await db.query('SELECT * FROM users WHERE id = ?', [1]);

// ORM: ~2-5ms (2-5x slower)
const user = await User.findByPk(1);
```

**Complex query with joins:**
```javascript
// Raw SQL (optimized): ~5ms
const result = await db.query(`
  SELECT u.*, p.title 
  FROM users u
  LEFT JOIN posts p ON u.id = p.user_id
  WHERE u.active = true
`);

// ORM: ~10-20ms (2-4x slower)
const users = await User.findAll({
  where: { active: true },
  include: [Post]
});
```

**Batch operations:**
```javascript
// Raw SQL (bulk insert): ~10ms for 1000 records
await db.query(`
  INSERT INTO users (name, email) VALUES ?
`, [usersData]);

// ORM (individual creates): ~1000-5000ms (100-500x slower)
for (const userData of usersData) {
  await User.create(userData);
}

// ORM (bulk create): ~50-100ms (5-10x slower)
await User.bulkCreate(usersData);
```

**When ORMs work well:**

**1. CRUD applications:**
```javascript
// Typical web app with basic operations
app.post('/users', async (req, res) => {
  const user = await User.create(req.body); // Simple and clean
  res.json(user);
});

app.get('/users/:id', async (req, res) => {
  const user = await User.findByPk(req.params.id, {
    include: [Profile, Settings]
  });
  res.json(user);
});
```

**2. Rapid prototyping:**
```javascript
// Quick to get started
const User = sequelize.define('User', {
  name: DataTypes.STRING,
  email: DataTypes.STRING
});

// Immediately start building features
// without worrying about SQL schema
```

**3. Teams with junior developers:**
```javascript
// Less SQL knowledge required
// ORM provides guardrails and best practices
// Automatic parameterization prevents SQL injection
```

**4. Applications with complex domain logic:**
```javascript
// Business logic in model methods
class User extends Model {
  async promoteToAdmin() {
    this.role = 'admin';
    this.promotedAt = new Date();
    await this.save();
    
    await Log.create({
      action: 'user_promoted',
      userId: this.id
    });
    
    await sendAdminWelcomeEmail(this.email);
  }
}

// Usage
const user = await User.findByPk(userId);
await user.promoteToAdmin();
```

**When to avoid ORMs:**

**1. High-performance applications:**
```javascript
// Trading systems, real-time analytics
// Need every millisecond of performance
// Use optimized raw SQL or stored procedures
```

**2. Complex reporting/analytics:**
```javascript
// Data warehouses, business intelligence
// Complex SQL with window functions, CTEs, pivots
// ORMs often can't express these efficiently
```

**3. Legacy database integration:**
```javascript
// Existing database with complex schema
// Stored procedures, custom types, triggers
// ORM might not support all features
```

**4. Micro-optimization scenarios:**
```javascript
// High-traffic endpoints
// Need to minimize database load
// Hand-tuned SQL for specific use cases
```

**Hybrid approach:**
```javascript
class UserRepository {
  // Use ORM for simple operations
  async create(userData) {
    return await User.create(userData);
  }
  
  async findById(id) {
    return await User.findByPk(id);
  }
  
  // Use raw SQL for complex operations
  async getActiveUserStats() {
    const result = await sequelize.query(`
      SELECT 
        COUNT(*) as total,
        AVG(age) as avg_age,
        department,
        COUNT(CASE WHEN status = 'active' THEN 1 END) as active_count
      FROM users
      GROUP BY department
      ORDER BY total DESC
    `, {
      type: sequelize.QueryTypes.SELECT
    });
    
    return result;
  }
  
  // Use ORM for relationships
  async getUserWithPosts(userId) {
    return await User.findByPk(userId, {
      include: [Post]
    });
  }
}
```

**Best practices for ORM usage:**

1. **Profile queries**: Identify and optimize slow ORM queries
2. **Use eager loading**: Avoid N+1 query problems
3. **Select specific fields**: Don't fetch unnecessary columns
4. **Implement caching**: For frequently accessed data
5. **Use raw SQL when needed**: Don't force ORM for complex queries
6. **Monitor performance**: Track query execution times
7. **Keep models focused**: Single responsibility principle
8. **Test with realistic data**: Ensure performance at scale

**Remember:** ORMs are tools, not solutions. Use them where they provide value, but don't be afraid to use raw SQL when ORMs become a bottleneck.

---
---

#### 3. How do you choose between raw queries and ORM?

**Answer:**

**Decision framework for choosing between raw queries and ORM:**

**1. Consider project requirements:**

**Use ORM when:**
```javascript
// Project characteristics favoring ORM:
const projectNeeds = {
  rapidDevelopment: true,      // Need to build quickly
  teamFamiliarity: 'low',     // Team knows JavaScript better than SQL
  databaseAbstraction: true,  // Might switch databases later
  complexDomainLogic: true,   // Business logic in application layer
  securityPriority: 'high',   // Automatic SQL injection protection
  crudHeavy: true,            // Mostly Create, Read, Update, Delete
  prototyping: true           // Early stage, requirements may change
};
```

**Use raw queries when:**
```javascript
// Project characteristics favoring raw queries:
const projectNeeds = {
  performanceCritical: true,  // Every millisecond counts
  complexQueries: true,       // Window functions, CTEs, complex joins
  existingSqlExpertise: true, // Team has strong SQL skills
  legacyDatabase: true,       // Complex schema, stored procedures
  reportingAnalytics: true,   // Data warehousing, BI tools
  microOptimization: true,    // Need hand-tuned queries
  fullControl: true          // Want exact control over SQL
};
```

**2. Evaluate query complexity:**

**Simple CRUD operations → ORM:**
```javascript
// ORM is perfect for these
const user = await User.create({ name: 'John', email: 'john@example.com' });
const users = await User.findAll({ where: { active: true } });
await user.update({ name: 'Jane' });
await user.destroy();
```

**Moderate complexity → ORM with custom queries:**
```javascript
// ORM with some raw SQL
const activeUsers = await sequelize.query(`
  SELECT u.*, COUNT(p.id) as post_count
  FROM users u
  LEFT JOIN posts p ON u.id = p.user_id
  WHERE u.active = true
  GROUP BY u.id
  HAVING post_count > 0
  ORDER BY u.created_at DESC
`, {
  model: User,
  mapToModel: true
});
```

**High complexity → Raw SQL:**
```javascript
// Complex analytics query
const analytics = await db.query(`
  WITH user_activity AS (
    SELECT 
      user_id,
      DATE(created_at) as date,
      COUNT(*) as actions,
      SUM(CASE WHEN type = 'purchase' THEN amount ELSE 0 END) as revenue
    FROM events
    WHERE created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
    GROUP BY user_id, DATE(created_at)
  ),
  daily_stats AS (
    SELECT
      date,
      COUNT(DISTINCT user_id) as active_users,
      SUM(actions) as total_actions,
      SUM(revenue) as total_revenue,
      AVG(actions) as avg_actions_per_user
    FROM user_activity
    GROUP BY date
  )
  SELECT * FROM daily_stats ORDER BY date DESC
`);
```

**3. Consider team skills:**

**Junior-heavy team → ORM:**
```javascript
// ORM provides guardrails
// - Automatic parameterization prevents SQL injection
// - Built-in validation
// - Consistent query patterns
// - Easier to understand for JavaScript developers
```

**SQL-expert team → Raw queries:**
```javascript
// Leverage team's SQL expertise
// - Write optimized queries
// - Use database-specific features
// - Implement complex logic in SQL
// - Better performance tuning
```

**Mixed team → Hybrid approach:**
```javascript
// Use ORM for common patterns
// Use raw SQL for complex operations
// Document when to use each approach
```

**4. Performance requirements:**

**Low to medium traffic → ORM:**
```javascript
// ORM overhead acceptable
// Development speed more important
// Can optimize later if needed
```

**High traffic → Raw queries:**
```javascript
// Need maximum performance
// Every query must be optimized
// ORM overhead becomes significant
```

**5. Maintenance considerations:**

**Long-term maintenance → ORM:**
```javascript
// ORM benefits:
// - Self-documenting through models
// - Type safety (with TypeScript)
// - Easier refactoring
// - Automated migrations
```

**Short-term or throwaway → Raw queries:**
```javascript
// Raw SQL benefits:
// - Quick to write
// - No ORM setup overhead
// - Direct control
// - Less abstraction
```

**Decision matrix:**

| Scenario | Recommendation | Reasoning |
|----------|---------------|-----------|
| **Greenfield web app** | ORM | Rapid development, CRUD-heavy |
| **High-frequency trading** | Raw SQL | Maximum performance needed |
| **Internal admin panel** | ORM | Development speed over performance |
| **Data warehouse ETL** | Raw SQL | Complex transformations, batch processing |
| **API with simple queries** | ORM | Productivity, security |
| **Legacy system integration** | Raw SQL | Existing stored procedures, complex schema |
| **Prototype/MVP** | ORM | Quick iteration, changing requirements |
| **Real-time analytics** | Raw SQL | Complex queries, performance critical |

**Practical examples:**

**Example 1: E-commerce application**
```javascript
// Hybrid approach
class ProductService {
  // Use ORM for product management
  async createProduct(data) {
    return await Product.create(data);
  }
  
  async getProduct(id) {
    return await Product.findByPk(id, {
      include: [Category, Reviews]
    });
  }
  
  // Use raw SQL for search (performance critical)
  async searchProducts(query, filters) {
    return await sequelize.query(`
      SELECT p.*,
        MATCH(p.name, p.description) AGAINST(:query) as relevance,
        c.name as category_name
      FROM products p
      JOIN categories c ON p.category_id = c.id
      WHERE MATCH(p.name, p.description) AGAINST(:query IN BOOLEAN MODE)
        AND p.price BETWEEN :minPrice AND :maxPrice
        AND p.stock > 0
      ORDER BY relevance DESC, p.created_at DESC
      LIMIT :limit OFFSET :offset
    `, {
      replacements: {
        query,
        minPrice: filters.minPrice || 0,
        maxPrice: filters.maxPrice || 999999,
        limit: filters.limit || 20,
        offset: filters.offset || 0
      },
      type: sequelize.QueryTypes.SELECT
    });
  }
  
  // Use raw SQL for analytics
  async getSalesReport(startDate, endDate) {
    return await sequelize.query(`
      SELECT 
        DATE(o.created_at) as date,
        COUNT(DISTINCT o.id) as orders,
        SUM(oi.quantity) as items_sold,
        SUM(oi.quantity * oi.unit_price) as revenue,
        AVG(oi.quantity * oi.unit_price) as avg_order_value
      FROM orders o
      JOIN order_items oi ON o.id = oi.order_id
      WHERE o.created_at BETWEEN :startDate AND :endDate
        AND o.status = 'completed'
      GROUP BY DATE(o.created_at)
      ORDER BY date DESC
    `, {
      replacements: { startDate, endDate },
      type: sequelize.QueryTypes.SELECT
    });
  }
}
```

**Example 2: Social media platform**
```javascript
// Mostly ORM with some raw SQL
class PostService {
  // ORM for basic operations
  async createPost(userId, content) {
    return await Post.create({
      userId,
      content,
      createdAt: new Date()
    });
  }
  
  async getFeed(userId, limit = 50) {
    // Complex feed logic with raw SQL
    return await sequelize.query(`
      WITH user_follows AS (
        SELECT followed_id 
        FROM follows 
        WHERE follower_id = :userId
      ),
      relevant_posts AS (
        SELECT p.*,
          CASE 
            WHEN p.user_id = :userId THEN 10
            WHEN p.user_id IN (SELECT followed_id FROM user_follows) THEN 5
            ELSE 1
          END as relevance_score
        FROM posts p
        WHERE p.created_at > DATE_SUB(NOW(), INTERVAL 7 DAY)
          AND (p.user_id = :userId 
               OR p.user_id IN (SELECT followed_id FROM user_follows)
               OR p.id IN (
                 SELECT post_id FROM likes 
                 WHERE user_id IN (SELECT followed_id FROM user_follows)
                 AND created_at > DATE_SUB(NOW(), INTERVAL 1 DAY)
               ))
      )
      SELECT * FROM relevant_posts
      ORDER BY (relevance_score * 0.6 + 
               (SELECT COUNT(*) FROM likes l WHERE l.post_id = relevant_posts.id) * 0.3 +
               (SELECT COUNT(*) FROM comments c WHERE c.post_id = relevant_posts.id) * 0.1) DESC,
               created_at DESC
      LIMIT :limit
    `, {
      replacements: { userId, limit },
      model: Post,
      mapToModel: true
    });
  }
}
```

**Example 3: Financial application**
```javascript
// Mostly raw SQL for performance and accuracy
class TransactionService {
  // Raw SQL for financial transactions (critical)
  async transferFunds(fromAccountId, toAccountId, amount) {
    const transaction = await sequelize.transaction();
    
    try {
      // Use raw SQL for atomic operations
      await sequelize.query(`
        UPDATE accounts 
        SET balance = balance - :amount,
            updated_at = NOW()
        WHERE id = :fromAccountId
        AND balance >= :amount
      `, {
        replacements: { amount, fromAccountId },
        transaction
      });
      
      await sequelize.query(`
        UPDATE accounts 
        SET balance = balance + :amount,
            updated_at = NOW()
        WHERE id = :toAccountId
      `, {
        replacements: { amount, toAccountId },
        transaction
      });
      
      await sequelize.query(`
        INSERT INTO transactions 
        (from_account_id, to_account_id, amount, type, created_at)
        VALUES (:fromAccountId, :toAccountId, :amount, 'transfer', NOW())
      `, {
        replacements: { fromAccountId, toAccountId, amount },
        transaction
      });
      
      await transaction.commit();
      return true;
    } catch (err) {
      await transaction.rollback();
      throw err;
    }
  }
  
  // Use ORM for non-critical operations
  async getTransactionHistory(accountId) {
    return await Transaction.findAll({
      where: {
        [Op.or]: [
          { fromAccountId: accountId },
          { toAccountId: accountId }
        ]
      },
      order: [['createdAt', 'DESC']],
      limit: 100
    });
  }
}
```

**Migration strategy from ORM to raw SQL:**

**Step 1: Identify bottlenecks**
```javascript
// Profile queries to find slow ones
const slowQueries = await profileDatabaseQueries();
// slowQueries: [{ query: 'SELECT * FROM users...', duration: 1500ms }, ...]
```

**Step 2: Start with hybrid approach**
```javascript
// Keep ORM for simple queries
// Convert only problematic queries to raw SQL
class OptimizedUserRepository {
  // Keep using ORM
  async getUser(id) {
    return await User.findByPk(id);
  }
  
  // Convert to raw SQL
  async getActiveUsersWithStats() {
    return await sequelize.query(`
      SELECT ... -- Optimized query
    `);
  }
}
```

**Step 3: Establish patterns**
```javascript
// Create guidelines for team
const queryGuidelines = {
  simpleCrud: 'Use ORM',
  complexJoins: 'Consider raw SQL',
  analytics: 'Use raw SQL',
  performanceCritical: 'Always raw SQL',
  securitySensitive: 'ORM (automatic parameterization)'
};
```

**Step 4: Monitor and adjust**
```javascript
// Continuously monitor performance
setInterval(async () => {
  const metrics = await getQueryMetrics();
  
  if (metrics.ormSlowQueries > threshold) {
    console.log('Consider converting more queries to raw SQL');
  }
  
  if (metrics.rawSqlErrors > threshold) {
    console.log('Review raw SQL for potential issues');
  }
}, 300000); // Every 5 minutes
```

**Tools to help decide:**

**1. Query profiling:**
```javascript
// Enable query logging
const sequelize = new Sequelize({
  // ... config
  logging: (sql, timing) => {
    if (timing > 100) { // Log slow queries
      console.log(`Slow query (${timing}ms): ${sql}`);
    }
  }
});
```

**2. Performance monitoring:**
```javascript
// Use APM tools
const apm = require('elastic-apm-node').start({
  serviceName: 'my-app'
});

// Track database query performance
```

**3. EXPLAIN plans:**
```javascript
// Analyze query execution plans
const explain = await sequelize.query(`
  EXPLAIN SELECT * FROM users WHERE email = 'test@example.com'
`);
console.log('Query plan:', explain);
```

**Final recommendations:**

1. **Start with ORM** for new projects - easier to begin
2. **Profile early** - identify performance issues before they become problems
3. **Use hybrid approach** - best of both worlds
4. **Document decisions** - why each query uses ORM or raw SQL
5. **Review regularly** - as application evolves, reassess choices
6. **Train team** - ensure everyone understands both approaches
7. **Establish patterns** - consistency across codebase

**Remember:** The choice isn't binary. Most applications benefit from a hybrid approach using ORM for productivity and raw SQL for performance-critical operations.

---
---

#### 4. What is the N+1 query problem and how do you solve it?

**Answer:**

**The N+1 query problem** occurs when an application makes 1 query to fetch N records, then makes N additional queries to fetch related data for each record.

**Example of N+1 problem:**
```javascript
// ❌ N+1 QUERY PROBLEM
// 1 query to get all users
const users = await User.findAll();

// N queries to get posts for each user
for (const user of users) {
  const posts = await user.getPosts(); // Separate query for each user
  user.posts = posts;
}

// If there are 100 users:
// 1 query: SELECT * FROM users
// 100 queries: SELECT * FROM posts WHERE user_id = ?
// Total: 101 queries (N+1)
```

**Why N+1 is problematic:**
1. **Performance**: Each query has overhead (network, parsing, execution)
2. **Database load**: Many small queries instead of few efficient ones
3. **Response time**: Sequential queries add up
4. **Scalability**: Gets worse with more data

**Solutions to N+1 problem:**

**1. Eager loading (JOIN):**
```javascript
// ✅ SOLUTION: Eager loading with JOIN
// 1 query with JOIN
const users = await User.findAll({
  include: [Post] // Eager load posts
});

// Generated SQL:
// SELECT users.*, posts.* 
// FROM users 
// LEFT JOIN posts ON users.id = posts.user_id

// Result: 1 query instead of N+1
```

**2. Batch loading (WHERE IN):**
```javascript
// ✅ SOLUTION: Batch loading
// 1 query to get users
const users = await User.findAll();

// Extract user IDs
const userIds = users.map(user => user.id);

// 1 query to get all posts for these users
const allPosts = await Post.findAll({
  where: {
    userId: { [Op.in]: userIds }
  }
});

// Map posts to users in memory
const postsByUserId = {};
allPosts.forEach(post => {
  if (!postsByUserId[post.userId]) {
    postsByUserId[post.userId] = [];
  }
  postsByUserId[post.userId].push(post);
});

users.forEach(user => {
  user.posts = postsByUserId[user.id] || [];
});

// Total: 2 queries instead of N+1
```

**3. GraphQL DataLoader pattern:**
```javascript
// ✅ SOLUTION: DataLoader batching
const DataLoader = require('dataloader');

// Create a batched loader
const postLoader = new DataLoader(async (userIds) => {
  // userIds is an array of user IDs
  const posts = await Post.findAll({
    where: {
      userId: { [Op.in]: userIds }
    }
  });
  
  // Group posts by user ID
  const postsByUserId = {};
  posts.forEach(post => {
    if (!postsByUserId[post.userId]) {
      postsByUserId[post.userId] = [];
    }
    postsByUserId[post.userId].push(post);
  });
  
  // Return array of arrays matching input order
  return userIds.map(userId => postsByUserId[userId] || []);
});

// Usage
const users = await User.findAll();

// Load posts for all users (batched into 1 query)
const postsPromises = users.map(user => 
  postLoader.load(user.id)
);

const postsArrays = await Promise.all(postsPromises);

users.forEach((user, index) => {
  user.posts = postsArrays[index];
});
```

**4. Raw SQL with aggregation:**
```javascript
// ✅ SOLUTION: Single optimized query
const results = await sequelize.query(`
  SELECT 
    u.*,
    JSON_ARRAYAGG(
      JSON_OBJECT(
        'id', p.id,
        'title', p.title,
        'content', p.content
      )
    ) as posts
  FROM users u
  LEFT JOIN posts p ON u.id = p.user_id
  GROUP BY u.id
`, {
  type: sequelize.QueryTypes.SELECT,
  nest: true
});

// Parse JSON array
results.forEach(row => {
  row.posts = JSON.parse(row.posts);
});
```

**5. Caching strategy:**
```javascript
// ✅ SOLUTION: Cache related data
class UserService {
  constructor() {
    this.postsCache = new Map();
  }
  
  async getUsersWithPosts() {
    const users = await User.findAll();
    const userIds = users.map(u => u.id);
    
    // Check cache first
    const uncachedUserIds = userIds.filter(id => !this.postsCache.has(id));
    
    if (uncachedUserIds.length > 0) {
      // Fetch uncached posts
      const posts = await Post.findAll({
        where: { userId: { [Op.in]: uncachedUserIds } }
      });
      
      // Update cache
      posts.forEach(post => {
        if (!this.postsCache.has(post.userId)) {
          this.postsCache.set(post.userId, []);
        }
        this.postsCache.get(post.userId).push(post);
      });
    }
    
    // Attach posts from cache
    users.forEach(user => {
      user.posts = this.postsCache.get(user.id) || [];
    });
    
    return users;
  }
}
```

**Nested N+1 problem (multiple levels):**
```javascript
// ❌ NESTED N+1 PROBLEM
const users = await User.findAll();

for (const user of users) {
  const posts = await user.getPosts(); // N queries
  
  for (const post of posts) {
    const comments = await post.getComments(); // N×M queries
    post.comments = comments;
  }
  
  user.posts = posts;
}

// If 100 users, each with 10 posts:
// Users: 1 query
// Posts: 100 queries
// Comments: 1000 queries
// Total: 1101 queries
```

**Solution for nested N+1:**
```javascript
// ✅ SOLUTION: Deep eager loading
const users = await User.findAll({
  include: [{
    model: Post,
    include: [Comment] // Nested eager loading
  }]
});

// Generated SQL (simplified):
// SELECT users.*, posts.*, comments.*
// FROM users
// LEFT JOIN posts ON users.id = posts.user_id
// LEFT JOIN comments ON posts.id = comments.post_id

// Result: 1 query with multiple JOINs
```

**Performance comparison:**

**Small dataset (10 users):**
```javascript
// N+1: 11 queries × 5ms = 55ms
// Eager loading: 1 query × 10ms = 10ms
// Improvement: 5.5x faster
```

**Medium dataset (100 users):**
```javascript
// N+1: 101 queries × 5ms = 505ms
// Eager loading: 1 query × 20ms = 20ms
// Improvement: 25x faster
```

**Large dataset (1000 users):**
```javascript
// N+1: 1001 queries × 5ms = 5005ms (5 seconds)
// Eager loading: 1 query × 100ms = 100ms
// Improvement: 50x faster
```

**When eager loading can be problematic:**

**1. Cartesian product explosion:**
```javascript
// If user has 10 posts and each post has 10 comments:
// Result set: 1 user × 10 posts × 10 comments = 100 rows
// Data duplication: user data repeated 100 times

// Solution: Separate queries or application-side joining
const [users, posts, comments] = await Promise.all([
  User.findAll(),
  Post.findAll(),
  Comment.findAll()
]);

// Join in application code
```

**2. Memory usage:**
```javascript
// Large JOIN result sets can consume memory
// Solution: Pagination or batch processing
const users = await User.findAll({
  include: [Post],
  limit: 50,
  offset: 0
});
```

**3. Complex filtering:**
```javascript
// Filtering on included models can be tricky
const users = await User.findAll({
  include: [{
    model: Post,
    where: { status: 'published' }, // INNER JOIN
    required: false // LEFT JOIN
  }]
});
```

**Detection tools:**

**1. ORM logging:**
```javascript
const sequelize = new Sequelize({
  logging: (sql) => {
    console.log(sql);
    // Monitor for patterns of many similar queries
  }
});
```

**2. Database monitoring:**
```sql
-- MySQL slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1; -- Log queries > 1 second

-- PostgreSQL log
log_min_duration_statement = 1000 -- Log queries > 1 second
```

**3. Application profiling:**
```javascript
const start = Date.now();
const users = await getUsersWithPosts();
const duration = Date.now() - start;

if (duration > 1000) {
  console.warn(`Slow operation: ${duration}ms`);
  // Investigate for N+1
}
```

**Best practices to avoid N+1:**

1. **Always use eager loading** for known relationships
2. **Profile queries** in development and staging
3. **Implement DataLoader pattern** for GraphQL APIs
4. **Use pagination** for large datasets
5. **Monitor query counts** in production
6. **Educate team** about N+1 problem
7. **Code review** for N+1 patterns
8. **Automated testing** for query performance

**Example with multiple solutions:**

```javascript
class PostService {
  // Solution 1: Eager loading (simple cases)
  async getPostsWithAuthors() {
    return await Post.findAll({
      include: [User]
    });
  }
  
  // Solution 2: DataLoader (GraphQL, complex cases)
  async getPostsWithComments(posts) {
    const commentLoader = new DataLoader(async (postIds) => {
      const comments = await Comment.findAll({
        where: { postId: { [Op.in]: postIds } }
      });
      
      const commentsByPostId = {};
      comments.forEach(comment => {
        if (!commentsByPostId[comment.postId]) {
          commentsByPostId[comment.postId] = [];
        }
        commentsByPostId[comment.postId].push(comment);
      });
      
      return postIds.map(id => commentsByPostId[id] || []);
    });
    
    const postIds = posts.map(p => p.id);
    const commentsArrays = await commentLoader.loadMany(postIds);
    
    posts.forEach((post, index) => {
      post.comments = commentsArrays[index];
    });
    
    return posts;
  }
  
  // Solution 3: Raw SQL (performance critical)
  async getPostsWithStats() {
    return await sequelize.query(`
      SELECT 
        p.*,
        u.name as author_name,
        COUNT(c.id) as comment_count,
        COUNT(l.id) as like_count
      FROM posts p
      JOIN users u ON p.user_id = u.id
      LEFT JOIN comments c ON p.id = c.post_id
      LEFT JOIN likes l ON p.id = l.post_id
      WHERE p.status = 'published'
      GROUP BY p.id
      ORDER BY p.created_at DESC
      LIMIT 100
    `, {
      type: sequelize.QueryTypes.SELECT
    });
  }
}
```

**Remember:** The N+1 query problem is one of the most common performance issues in database-driven applications. Always be mindful of query patterns and use appropriate loading strategies.

---
---

#### 5. How do you handle complex queries with ORMs?

**Answer:**

**Complex queries** often involve multiple joins, subqueries, window functions, or database-specific features that can be challenging with ORMs.

**Strategies for handling complex queries with ORMs:**

**1. Raw SQL within ORM:**
```javascript
// Use ORM's raw SQL capability
const results = await sequelize.query(`
  WITH ranked_products AS (
    SELECT 
      p.*,
      c.name as category_name,
      ROW_NUMBER() OVER (PARTITION BY p.category_id ORDER BY p.price DESC) as price_rank
    FROM products p
    JOIN categories c ON p.category_id = c.id
    WHERE p.stock > 0
  )
  SELECT * FROM ranked_products
  WHERE price_rank <= 3
  ORDER BY category_name, price_rank
`, {
  type: sequelize.QueryTypes.SELECT,
  // Optional: map to models
  model: Product,
  mapToModel: true
});

// Can still use ORM features on results
results.forEach(product => {
  console.log(product.toJSON());
});
```

**2. Hybrid approach (ORM + raw SQL):**
```javascript
class ReportService {
  // Use ORM for simple parts
  async getBasicUserStats() {
    return await User.findAll({
      attributes: [
        'id',
        'name',
        'email',
        [sequelize.fn('COUNT', sequelize.col('posts.id')), 'postCount']
      ],
      include: [{
        model: Post,
        attributes: []
      }],
      group: ['User.id'],
      raw: true
    });
  }
  
  // Use raw SQL for complex parts
  async getAdvancedAnalytics() {
    return await sequelize.query(`
      SELECT 
        DATE(created_at) as date,
        COUNT(*) as signups,
        SUM(CASE WHEN verified = true THEN 1 ELSE 0 END) as verified_count,
        AVG(
          (SELECT COUNT(*) FROM posts p WHERE p.user_id = u.id)
        ) as avg_posts_per_user
      FROM users u
      WHERE created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
      GROUP BY DATE(created_at)
      ORDER BY date DESC
    `, {
      type: sequelize.QueryTypes.SELECT
    });
  }
}
```

**3. Query builder mode:**
```javascript
// Some ORMs have query builder interfaces
const query = sequelize.getQueryInterface().queryGenerator.selectQuery(
  'users',
  {
    attributes: ['id', 'name'],
    where: { active: true },
    include: [{
      model: 'posts',
      attributes: ['id', 'title']
    }],
    limit: 10,
    offset: 0
  }
);

console.log('Generated SQL:', query);

// Execute the built query
const results = await sequelize.query(query, {
  type: sequelize.QueryTypes.SELECT
});
```

**4. Stored procedures and functions:**
```javascript
// Call stored procedures through ORM
const revenueReport = await sequelize.query(
  'CALL get_monthly_revenue_report(:year, :month)',
  {
    replacements: { year: 2024, month: 1 },
    type: sequelize.QueryTypes.RAW
  }
);

// Call database functions
const distance = await sequelize.query(
  'SELECT calculate_distance(:lat1, :lon1, :lat2, :lon2) as distance',
  {
    replacements: { lat1, lon1, lat2, lon2 },
    type: sequelize.QueryTypes.SELECT
  }
);
```

**5. Custom query methods:**
```javascript
// Extend model with custom query methods
User.findActiveWithPosts = function(options = {}) {
  const defaultOptions = {
    where: { active: true },
    include: [{
      model: Post,
      where: { status: 'published' },
      required: false
    }],
    order: [['createdAt', 'DESC']],
    limit: options.limit || 50
  };
  
  return this.findAll({ ...defaultOptions, ...options });
};

// Usage
const activeUsers = await User.findActiveWithPosts({
  limit: 100,
  attributes: ['id', 'name', 'email']
});
```

**6. View-based queries:**
```javascript
// Create database view for complex query
await sequelize.query(`
  CREATE OR REPLACE VIEW user_stats AS
  SELECT 
    u.id,
    u.name,
    u.email,
    COUNT(p.id) as post_count,
    COUNT(c.id) as comment_count,
    MAX(p.created_at) as last_post_date
  FROM users u
  LEFT JOIN posts p ON u.id = p.user_id
  LEFT JOIN comments c ON u.id = c.user_id
  GROUP BY u.id, u.name, u.email
`);

// Query the view as a model
const UserStats = sequelize.define('UserStats', {}, {
  tableName: 'user_stats',
  timestamps: false
});

const stats = await UserStats.findAll({
  where: { post_count: { [Op.gt]: 0 } },
  order: [['post_count', 'DESC']]
});
```

**7. Composite queries with Promise.all:**
```javascript
// Execute multiple queries in parallel
const [users, posts, comments] = await Promise.all([
  User.findAll({ where: { active: true } }),
  Post.findAll({ 
    where: { 
      createdAt: { [Op.gt]: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000) }
    }
  }),
  Comment.findAll({
    where: { approved: true },
    limit: 1000
  })
]);

// Combine results in application code
const userMap = new Map(users.map(u => [u.id, u]));
const postMap = new Map(posts.map(p => [p.id, p]));

comments.forEach(comment => {
  const post = postMap.get(comment.postId);
  if (post) {
    const user = userMap.get(post.userId);
    if (user) {
      // Build complex object structure
    }
  }
});
```

**8. Window functions and CTEs:**
```javascript
// Some ORMs support window functions
const rankedProducts = await Product.findAll({
  attributes: {
    include: [
      [sequelize.literal(`
        ROW_NUMBER() OVER (
          PARTITION BY category_id 
          ORDER BY price DESC
        )
      `), 'price_rank']
    ]
  },
  where: sequelize.literal('price_rank <= 3'),
  raw: true
});

// Or use raw SQL with CTEs
const topProducts = await sequelize.query(`
  WITH ranked_products AS (
    SELECT *,
      RANK() OVER (PARTITION BY category_id ORDER BY sales DESC) as sales_rank
    FROM products
    WHERE stock > 0
  )
  SELECT * FROM ranked_products
  WHERE sales_rank <= 5
  ORDER BY category_id, sales_rank
`, {
  model: Product,
  mapToModel: true
});
```

**9. Dynamic query building:**
```javascript
function buildComplexQuery(filters = {}) {
  const query = {
    where: {},
    include: [],
    order: [],
    limit: filters.limit || 50,
    offset: filters.offset || 0
  };
  
  // Dynamic where conditions
  if (filters.category) {
    query.where.categoryId = filters.category;
  }
  
  if (filters.priceRange) {
    query.where.price = {
      [Op.between]: [filters.priceRange.min, filters.priceRange.max]
    };
  }
  
  // Dynamic includes
  if (filters.includeReviews) {
    query.include.push({
      model: Review,
      where: filters.minRating ? {
        rating: { [Op.gte]: filters.minRating }
      } : undefined
    });
  }
  
  if (filters.includeSeller) {
    query.include.push({
      model: User,
      as: 'seller',
      attributes: ['id', 'name', 'rating']
    });
  }
  
  // Dynamic ordering
  if (filters.sortBy === 'price') {
    query.order.push(['price', filters.sortOrder || 'ASC']);
  } else if (filters.sortBy === 'rating') {
    query.order.push([
      sequelize.literal('(SELECT AVG(rating) FROM reviews WHERE product_id = Product.id)'),
      filters.sortOrder || 'DESC'
    ]);
  }
  
  return query;
}

// Usage
const query = buildComplexQuery({
  category: 5,
  priceRange: { min: 10, max: 100 },
  includeReviews: true,
  minRating: 4,
  includeSeller: true,
  sortBy: 'rating',
  sortOrder: 'DESC',
  limit: 20
});

const products = await Product.findAll(query);
```

**10. Materialized views for expensive queries:**
```javascript
// Create materialized view
await sequelize.query(`
  CREATE MATERIALIZED VIEW daily_sales_summary AS
  SELECT 
    DATE(created_at) as sale_date,
    product_id,
    SUM(quantity) as total_quantity,
    SUM(quantity * unit_price) as total_revenue,
    COUNT(DISTINCT order_id) as order_count
  FROM order_items
  WHERE created_at >= DATE_SUB(NOW(), INTERVAL 90 DAY)
  GROUP BY DATE(created_at), product_id
`);

// Refresh periodically
await sequelize.query('REFRESH MATERIALIZED VIEW daily_sales_summary');

// Query materialized view
const salesSummary = await sequelize.query(`
  SELECT * FROM daily_sales_summary
  WHERE sale_date = :date
`, {
  replacements: { date: '2024-01-15' },
  type: sequelize.QueryTypes.SELECT
});
```

**Performance optimization techniques:**

**1. Query explanation and analysis:**
```javascript
// Get query execution plan
const explain = await sequelize.query(
  'EXPLAIN ' + sequelize.getQueryInterface().queryGenerator.selectQuery(
    'users',
    { where: { active: true }, include: [Post] }
  ),
  { type: sequelize.QueryTypes.SELECT }
);

console.log('Query plan:', explain);
```

**2. Index hinting:**
```javascript
const users = await User.findAll({
  where: { active: true },
  include: [Post],
  // Suggest index to use
  indexHints: [
    { type: 'USE', values: ['idx_users_active'] }
  ]
});
```

**3. Query caching:**
```javascript
const users = await User.findAll({
  where: { active: true },
  include: [Post],
  // Cache results
  cache: true,
  cacheTTL: 300, // 5 minutes
  cacheKey: 'active_users_with_posts'
});
```

**4. Batch operations:**
```javascript
// Instead of individual updates
for (const user of users) {
  await user.update({ lastLogin: new Date() });
}

// Use batch update
await User.update(
  { lastLogin: new Date() },
  { where: { id: { [Op.in]: userIds } } }
);
```

**Common pitfalls and solutions:**

**Pitfall 1: Over-fetching with eager loading**
```javascript
// ❌ Fetches all columns from all tables
const users = await User.findAll({
  include: [Post] // SELECT users.*, posts.*
});

// ✅ Select specific columns
const users = await User.findAll({
  attributes: ['id', 'name', 'email'],
  include: [{
    model: Post,
    attributes: ['id', 'title', 'createdAt']
  }]
});
```

**Pitfall 2: Missing indexes on foreign keys**
```javascript
// Slow query without index
const posts = await Post.findAll({
  include: [{
    model: User,
    where: { country: 'USA' } // Needs index on users.country
  }]
});

// Ensure indexes exist
await sequelize.query(`
  CREATE INDEX idx_users_country ON users(country)
`);
```

**Pitfall 3: Cartesian product with multiple includes**
```javascript
// ❌ Cartesian product
const users = await User.findAll({
  include: [Post, Comment] // posts × comments rows
});

// ✅ Separate queries or application-side join
const [users, posts, comments] = await Promise.all([
  User.findAll(),
  Post.findAll({ where: { userId: { [Op.in]: userIds } } }),
  Comment.findAll({ where: { userId: { [Op.in]: userIds } } })
]);
```

**Testing complex queries:**

```javascript
describe('Complex Query Performance', () => {
  beforeEach(async () => {
    // Setup test data
    await User.bulkCreate(testUsers);
    await Post.bulkCreate(testPosts);
  });
  
  test('should execute complex query efficiently', async () => {
    const start = Date.now();
    
    const results = await User.findAll({
      include: [{
        model: Post,
        include: [Comment]
      }],
      where: { active: true },
      limit: 100
    });
    
    const duration = Date.now() - start;
    
    // Performance assertion
    expect(duration).toBeLessThan(100); // Should complete in < 100ms
    expect(results.length).toBeLessThanOrEqual(100);
  });
  
  test('should generate correct SQL', async () => {
    const query = User.findAll({
      include: [Post],
      where: { active: true }
    }).toString();
    
    // Verify SQL contains expected patterns
    expect(query).toContain('SELECT');
    expect(query).toContain('FROM users');
    expect(query).toContain('LEFT JOIN posts');
    expect(query).toContain('WHERE users.active = true');
  });
});
```

**Best practices summary:**

1. **Know your ORM's limits** - Use raw SQL when ORM can't express the query efficiently
2. **Profile queries** - Use EXPLAIN and query logging
3. **Use appropriate loading strategy** - Eager loading vs separate queries
4. **Optimize indexes** - Based on query patterns
5. **Implement caching** - For expensive, frequently accessed queries
6. **Batch operations** - Instead of individual row operations
7. **Monitor performance** - In production environments
8. **Test with realistic data** - Volume matters for query performance

**Remember:** ORMs are great for productivity, but complex queries often require dropping down to raw SQL or using database-specific features. The key is knowing when to use each approach.

---
---

## 31. Database Transactions

#### 1. What are database transactions and when should you use them?

**Answer:**

**Database transactions** are sequences of database operations that are executed as a single unit of work. They follow the ACID properties (Atomicity, Consistency, Isolation, Durability) to ensure data integrity.

**Real-life analogy:** Think of a bank transfer. When you transfer money from your account to someone else's, two things must happen: money is deducted from your account AND added to their account. If either operation fails, both should fail. This "all or nothing" approach is a transaction.

**When to use transactions:**

1. **Financial operations**: Bank transfers, payments, refunds
2. **E-commerce**: Order processing (create order + update inventory + charge payment)
3. **User registration**: Create user account + send welcome email + create profile
4. **Inventory management**: Stock updates across multiple warehouses
5. **Booking systems**: Reserve seat + create booking + process payment

**Example scenario:** An e-commerce checkout process involves:
- Deducting items from inventory
- Creating an order record
- Processing payment
- Sending confirmation email

If the payment fails after inventory is deducted, you'd have incorrect stock counts. Transactions ensure all steps succeed or none do.

---

#### 2. How do you implement transactions in different databases?

**Answer:**

**MySQL implementation:**
Transactions in MySQL use `BEGIN`, `COMMIT`, and `ROLLBACK` statements. You start a transaction, execute your operations, then either commit (save changes) or rollback (undo changes) based on success.

**PostgreSQL implementation:** 
Similar to MySQL but with additional features like savepoints (nested transactions) and different isolation levels. PostgreSQL also supports two-phase commit for distributed transactions.

**MongoDB implementation:**
MongoDB added multi-document transactions in version 4.0. While MongoDB is document-oriented, transactions work across multiple documents and collections, useful for financial data or inventory systems.

**Key differences:**
- **SQL databases**: Native transaction support with ACID compliance
- **MongoDB**: Added later, works across documents but with some performance considerations
- **Redis**: Supports transactions but with different semantics (MULTI/EXEC)

**Real-world consideration:** Choose databases with strong transaction support for financial applications, while document databases might suffice for social media feeds where eventual consistency is acceptable.

---

#### 3. What is ACID compliance?

**Answer:**

**ACID** is a set of properties that guarantee reliable processing of database transactions:

**A - Atomicity**: Transactions are "all or nothing". If any part fails, the entire transaction fails and the database state is left unchanged.

**Example:** In a flight booking system, atomicity ensures that either both seat reservation and payment processing succeed, or neither happens. You won't end up with a reserved seat but no payment, or payment taken but no seat.

**C - Consistency**: Transactions bring the database from one valid state to another, maintaining all database rules and constraints.

**Example:** If a database has a rule that account balances can't be negative, consistency ensures a transfer that would make an account negative fails completely.

**I - Isolation**: Concurrent transactions don't interfere with each other. Each transaction appears to execute in isolation.

**Example:** When two people try to book the last seat on a flight simultaneously, isolation ensures only one succeeds, preventing double-booking.

**D - Durability**: Once a transaction is committed, it remains committed even in case of system failure.

**Example:** After a successful purchase, the order persists even if the database server crashes immediately after.

**Real-world importance:** Banking systems, stock trading platforms, and e-commerce sites require ACID compliance to prevent data corruption and ensure business rules are always enforced.

---

#### 4. How do you handle transaction rollbacks?

**Answer:**

**Transaction rollbacks** undo all operations within a transaction when an error occurs or when explicitly requested.

**When rollbacks happen:**
1. **System errors**: Database crashes, network failures
2. **Business logic errors**: Insufficient funds, validation failures
3. **Deadlocks**: Two transactions waiting for each other's resources
4. **Timeouts**: Transactions taking too long
5. **Manual rollback**: Developer decides to cancel the transaction

**Real-life example:** In an online shopping cart:
1. User adds items to cart
2. System starts transaction
3. Checks inventory (OK)
4. Processes payment (fails due to expired card)
5. System rolls back: inventory restored, cart remains unchanged
6. User sees error message about payment failure

**Best practices for rollback handling:**
- Always implement proper error handling around transactions
- Use retry logic for transient failures (network issues)
- Log rollback reasons for debugging
- Consider savepoints for partial rollbacks in complex transactions
- Test rollback scenarios thoroughly

**Common pitfall:** Forgetting to handle rollbacks can leave databases in inconsistent states, like deducting inventory without creating an order.

---

#### 5. What are isolation levels in transactions?

**Answer:**

**Isolation levels** define how much one transaction is isolated from other concurrent transactions. They balance consistency vs performance.

**Four standard isolation levels (from weakest to strongest):**

1. **Read Uncommitted**: Transactions can see uncommitted changes from other transactions.
   - **Problem**: "Dirty reads" - reading data that might be rolled back
   - **Use case**: Reporting systems where absolute accuracy isn't critical

2. **Read Committed**: Transactions see only committed changes.
   - **Problem**: "Non-repeatable reads" - same query returns different results within a transaction
   - **Use case**: Default for PostgreSQL, good for most applications

3. **Repeatable Read**: Guarantees that reads are consistent throughout the transaction.
   - **Problem**: "Phantom reads" - new rows appear in subsequent reads
   - **Use case**: Default for MySQL, financial systems

4. **Serializable**: Highest isolation, transactions execute as if serially.
   - **Problem**: Performance overhead, potential for deadlocks
   - **Use case**: Banking systems, stock trading

**Real-world analogy:** Imagine multiple people editing a shared document:
- **Read Uncommitted**: You see others' changes as they type (even if they might delete them)
- **Read Committed**: You only see changes after they save
- **Repeatable Read**: You see a snapshot of the document when you started reading
- **Serializable**: Only one person can edit at a time

**Choosing isolation levels:** Higher isolation means more consistency but less concurrency. Most applications use Read Committed or Repeatable Read as a balance.

---

## 32. Database Migrations & Seeding

#### 1. What are database migrations and why are they important?

**Answer:**

**Database migrations** are version-controlled scripts that manage database schema changes over time, similar to how Git manages code changes.

**Why migrations are important:**

1. **Version control for database**: Track schema changes alongside code changes
2. **Consistent environments**: Ensure dev, staging, and production databases match
3. **Rollback capability**: Revert schema changes if something goes wrong
4. **Team collaboration**: Multiple developers can work on database changes
5. **Automated deployment**: Deploy database changes with application code

**Real-life example:** A startup building a social media app:
- Week 1: Create users table with basic fields
- Week 2: Add profile pictures column
- Week 3: Add indexes for faster search
- Week 4: Split users table into users and profiles

Without migrations, each developer would manually run SQL scripts, leading to inconsistencies. With migrations, changes are tracked, tested, and deployed systematically.

**Migration lifecycle:**
1. Create migration file describing the change
2. Test migration locally
3. Commit to version control
4. Run in staging environment
5. Deploy to production

**Common migration types:**
- **Schema changes**: Add/remove tables, columns, indexes
- **Data migrations**: Transform existing data
- **Seed data**: Insert initial or test data
- **Rollback scripts**: Reverse changes if needed

---

#### 2. How do you implement migrations in Node.js?

**Answer:**

**Popular migration tools for Node.js:**

1. **Knex.js**: SQL-based migrations with support for multiple databases
2. **Sequelize CLI**: ORM-based migrations with model synchronization
3. **TypeORM**: TypeScript-first migrations with decorator-based models
4. **db-migrate**: Database-agnostic migration tool
5. **Prisma Migrate**: Declarative migrations with automatic generation

**Typical migration workflow:**

1. **Generate migration**: Create a new migration file with timestamp
2. **Write up/down methods**: Define how to apply and revert the change
3. **Run migration**: Apply changes to database
4. **Verify**: Check that migration succeeded
5. **Commit**: Add migration file to version control

**Real-world scenario:** Adding a "premium_user" flag to your application:
- Create migration: `add_premium_column_to_users`
- Up method: `ALTER TABLE users ADD COLUMN premium BOOLEAN DEFAULT FALSE`
- Down method: `ALTER TABLE users DROP COLUMN premium`
- Run migration on development database
- Test application with new column
- Deploy to production during maintenance window

**Best practices:**
- Keep migrations small and focused
- Always write reversible down methods
- Test migrations with realistic data volumes
- Backup database before running production migrations
- Use environment-specific configurations

**Common pitfalls:**
- Forgetting to write down methods (can't rollback)
- Making breaking changes without proper communication
- Running migrations during peak traffic
- Not testing with production-like data

---

#### 3. What are the popular migration tools?

**Answer:**

**Knex.js**: 
- **Best for**: SQL-focused applications, multiple database support
- **Strengths**: Raw SQL control, good for complex migrations
- **Use case**: Applications needing fine-grained SQL control

**Sequelize CLI**:
- **Best for**: Sequelize ORM users
- **Strengths**: Tight integration with models, automatic migration generation
- **Use case**: Teams already using Sequelize ORM

**TypeORM**:
- **Best for**: TypeScript projects
- **Strengths**: Type safety, decorator-based models, excellent TypeScript support
- **Use case**: TypeScript-first applications

**Prisma Migrate**:
- **Best for**: Modern applications with Prisma ORM
- **Strengths**: Declarative schema, automatic migration generation, type safety
- **Use case**: Greenfield projects using Prisma

**db-migrate**:
- **Best for**: Database-agnostic projects
- **Strengths**: Supports many databases, simple API
- **Use case**: Projects that might switch databases

**Choosing a tool:**
- **Existing ORM**: Use the ORM's migration tool
- **TypeScript**: Consider TypeORM or Prisma
- **Multiple databases**: Knex.js or db-migrate
- **Simple needs**: Any tool will work, choose based on team familiarity

**Real-world consideration:** A fintech startup might choose TypeORM for type safety in financial calculations, while a content management system might choose Knex.js for complex SQL optimizations.

---

#### 4. How do you handle database seeding?

**Answer:**

**Database seeding** is the process of populating a database with initial or test data.

**Types of seed data:**

1. **Initial data**: Required for application to function (admin users, default settings)
2. **Test data**: Realistic data for development and testing
3. **Reference data**: Lookup tables (countries, currencies, product categories)
4. **Demo data**: Sample data for demonstrations or staging environments

**When to seed:**
- **Development**: Populate with test data for realistic development
- **Testing**: Create specific test scenarios
- **Staging**: Mirror production data (sanitized)
- **Production**: Insert essential initial data only

**Real-world example:** An e-commerce platform needs:
- Initial: Admin user, payment methods, shipping options
- Test: Sample products, customers, orders
- Reference: Countries, states, product categories
- Demo: Featured products, customer testimonials

**Best practices for seeding:**
- Keep seed data in version control
- Use environment variables for sensitive data
- Make seeding idempotent (can run multiple times)
- Separate development and production seeds
- Consider using factories for generating test data

**Common approaches:**
1. **SQL files**: Simple but not version-controlled with application
2. **Migration tools**: Knex, Sequelize have built-in seeding
3. **Custom scripts**: More control but more maintenance
4. **Factories**: Generate realistic test data dynamically

**Pitfall to avoid:** Never seed production with test data or include sensitive information in seed files committed to version control.

---

#### 5. How do you rollback migrations?

**Answer:**

**Migration rollback** reverses applied migrations, returning the database to a previous state.

**When to rollback:**
1. **Failed deployment**: Migration causes errors in production
2. **Bug discovery**: Schema change introduces unexpected issues
3. **Performance problems**: New index slows down queries
4. **Business decision**: Feature being reverted

**Rollback strategies:**

1. **Full rollback**: Revert all migrations to a specific point
2. **Partial rollback**: Revert only the problematic migration
3. **Forward fix**: Create new migration to fix issues instead of rolling back

**Real-world scenario:** A social media app adds a "location" column to users table but discovers:
- The column type is wrong (should be JSON, not TEXT)
- Existing data migration corrupted some records
- Performance issues with new indexes

**Options:**
1. **Rollback migration**: Remove the column, lose new data
2. **Create fix migration**: Change column type, fix data
3. **Hybrid approach**: Rollback, fix migration, re-run

**Best practices:**
- Always write reversible down methods
- Test rollbacks as thoroughly as migrations
- Have database backups before migrations
- Consider data preservation during rollbacks
- Communicate rollback plans to stakeholders

**Rollback challenges:**
- **Data loss**: Rolling back might delete data added after migration
- **Dependencies**: Later migrations might depend on rolled-back changes
- **Timing**: Rolling back during peak traffic can cause downtime
- **Complexity**: Some changes are hard to reverse (dropped columns with data)

**Modern approach:** Many teams prefer "forward-only" migrations where instead of rolling back, you create a new migration to fix issues. This avoids data loss and keeps a clear history.

---

## 33. Security Best Practices

#### 1. What are the top security risks for Node.js applications?

**Answer:**

**Top security risks specific to Node.js applications:**

1. **Dependency vulnerabilities**: Node.js relies heavily on npm packages, which can contain vulnerabilities.

2. **Injection attacks**: SQL injection, NoSQL injection, command injection through user input.

3. **Authentication flaws**: Weak password policies, session management issues, JWT mishandling.

4. **Sensitive data exposure**: Logging sensitive data, improper encryption, hardcoded secrets.

5. **Insecure deserialization**: Attackers can manipulate serialized objects to execute code.

6. **Server-side request forgery (SSRF)**: Applications making requests to internal resources based on user input.

7. **Insufficient logging and monitoring**: Unable to detect or respond to attacks.

8. **Cross-site scripting (XSS)**: Despite being server-side, Node.js apps can facilitate XSS through rendered content.

9. **Denial of Service (DoS)**: Event loop blocking, memory exhaustion through crafted requests.

10. **Configuration weaknesses**: Default settings, exposed debug endpoints, verbose error messages.

**Real-world example:** A popular npm package with millions of downloads had a vulnerability allowing remote code execution. Applications using this package without updating became vulnerable to takeover.

**Mitigation strategies:**
- Regular dependency updates and security scanning
- Input validation and parameterized queries
- Proper authentication and session management
- Encryption of sensitive data
- Security headers and Content Security Policy
- Rate limiting and request validation
- Regular security audits and penetration testing

**Node.js specific concerns:** The single-threaded event loop can be exploited for DoS attacks, and the npm ecosystem's openness requires vigilant dependency management.

---

#### 2. How do you secure an Express application?

**Answer:**

**Essential security measures for Express applications:**

1. **Helmet middleware**: Sets security-related HTTP headers
   - `X-Content-Type-Options`: Prevents MIME type sniffing
   - `X-Frame-Options`: Prevents clickjacking
   - `X-XSS-Protection`: Enables browser XSS filtering

2. **Input validation**: Validate and sanitize all user input
   - Use libraries like `joi` or `express-validator`
   - Never trust user input, even from authenticated users

3. **Authentication security**:
   - Use strong password hashing (bcrypt, argon2)
   - Implement proper session management
   - Use HTTPS for all communications
   - Consider multi-factor authentication for sensitive operations

4. **Dependency management**:
   - Regularly update dependencies
   - Use `npm audit` to check for vulnerabilities
   - Consider tools like Snyk or Dependabot

5. **Error handling**:
   - Don't leak stack traces in production
   - Use generic error messages for users
   - Log detailed errors for debugging

6. **Rate limiting**: Prevent brute force and DoS attacks
   - Use `express-rate-limit` middleware
   - Implement different limits for different endpoints

7. **CORS configuration**: Restrict cross-origin requests
   - Only allow trusted domains
   - Use specific methods and headers

8. **Security headers**:
   - Content Security Policy (CSP)
   - HTTP Strict Transport Security (HSTS)
   - Referrer-Policy

**Real-world implementation:** A banking application would implement all these measures plus additional layers like Web Application Firewalls (WAF), intrusion detection systems, and regular security audits.

**Common mistakes to avoid:**
- Using `eval()` or other dangerous functions
- Storing secrets in code or version control
- Using weak encryption algorithms
- Not validating file uploads
- Exposing administrative endpoints

**Security as a process:** Security isn't a one-time setup but an ongoing process of monitoring, updating, and adapting to new threats.

---

#### 3. What are the OWASP Top 10 security risks?

**Answer:**

**OWASP (Open Web Application Security Project) Top 10** is a standard awareness document representing the most critical security risks to web applications.

**Current OWASP Top 10 (2021):**

1. **Broken Access Control**: Users can act outside their intended permissions.
   - **Example**: User accessing another user's data by modifying URL parameters

2. **Cryptographic Failures**: Sensitive data exposure due to weak cryptography.
   - **Example**: Storing passwords in plain text or using weak encryption

3. **Injection**: Untrusted data sent to interpreter as part of command or query.
   - **Example**: SQL injection, NoSQL injection, OS command injection

4. **Insecure Design**: Missing or ineffective security controls in design phase.
   - **Example**: No rate limiting allowing brute force attacks

5. **Security Misconfiguration**: Default configurations, incomplete setups.
   - **Example**: Exposed admin interfaces, default passwords

6. **Vulnerable and Outdated Components**: Using components with known vulnerabilities.
   - **Example**: Unpatched libraries with known security issues

7. **Identification and Authentication Failures**: Problems in authentication mechanisms.
   - **Example**: Weak password policies, session fixation

8. **Software and Data Integrity Failures**: Making unauthorized changes to software or data.
   - **Example**: Insecure CI/CD pipelines, malicious package updates

9. **Security Logging and Monitoring Failures**: Insufficient detection of breaches.
   - **Example**: Not logging failed login attempts

10. **Server-Side Request Forgery (SSRF)**: Forcing server to make requests to internal resources.
    - **Example**: Attacker accessing internal AWS metadata service

**Real-world impact:** Each of these risks has caused major breaches. For instance, the Equifax breach (2017) involved multiple OWASP Top 10 issues including vulnerable components and insufficient logging.

**Application to Node.js:** Node.js applications are particularly vulnerable to injection attacks (through NoSQL or template injection), dependency vulnerabilities (npm ecosystem), and insecure design (async nature can lead to race conditions).

**Mitigation strategy:** Regular security training, code reviews focusing on security, automated security testing, and following security best practices throughout development lifecycle.

---

#### 4. How do you perform security audits for Node.js applications?

**Answer:**

**Security audits** are systematic evaluations of an application's security posture to identify vulnerabilities and weaknesses.

**Types of security audits:**

1. **Static Application Security Testing (SAST)**: Analyzing source code for vulnerabilities.
   - **Tools**: ESLint security rules, SonarQube, Snyk Code
   - **Focus**: Code patterns, hardcoded secrets, unsafe functions

2. **Dynamic Application Security Testing (DAST)**: Testing running application for vulnerabilities.
   - **Tools**: OWASP ZAP, Burp Suite, Nessus
   - **Focus**: Runtime behavior, configuration issues, live vulnerabilities

3. **Dependency scanning**: Checking third-party packages for known vulnerabilities.
   - **Tools**: `npm audit`, Snyk, Dependabot
   - **Focus**: CVEs in dependencies, outdated packages

4. **Container scanning**: Checking Docker images for vulnerabilities.
   - **Tools**: Trivy, Clair, Docker Scout
   - **Focus**: OS packages, base image vulnerabilities

5. **Manual penetration testing**: Human experts attempting to exploit vulnerabilities.
   - **Approach**: Ethical hackers simulating real attacks
   - **Focus**: Business logic flaws, complex attack chains

**Audit process for Node.js applications:**

1. **Preparation**: Define scope, gather documentation, set up test environment
2. **Automated scanning**: Run SAST, DAST, dependency scans
3. **Manual testing**: Explore application, test authentication, authorization
4. **Analysis**: Review findings, validate vulnerabilities, assess risk
5. **Reporting**: Document vulnerabilities with severity and remediation steps
6. **Remediation**: Fix vulnerabilities, retest fixes
7. **Follow-up**: Schedule next audit, update security controls

**Real-world example:** A fintech company would conduct:
- Monthly automated dependency scans
- Quarterly SAST scans
- Bi-annual penetration tests by external firm
- Continuous monitoring for suspicious activity

**Key areas to audit in Node.js apps:**
- Input validation and sanitization
- Authentication and session management
- Error handling and logging
- Dependency management
- Configuration and secrets management
- API security
- Data protection and encryption

**Budget considerations:** Start with free tools (ESLint, npm audit) and graduate to commercial tools as the application grows in complexity and sensitivity.

---

#### 5. What are security headers and how do you implement them?

**Answer:**

**Security headers** are HTTP response headers that instruct browsers to enable additional security features when rendering web pages.

**Essential security headers for Node.js applications:**

1. **Content-Security-Policy (CSP)**: Defines allowed sources for content.
   - **Purpose**: Prevent XSS attacks by restricting resource loading
   - **Example**: `Content-Security-Policy: default-src 'self'`

2. **Strict-Transport-Security (HSTS)**: Forces browsers to use HTTPS.
   - **Purpose**: Prevent SSL stripping attacks
   - **Example**: `Strict-Transport-Security: max-age=31536000; includeSubDomains`

3. **X-Content-Type-Options**: Prevents MIME type sniffing.
   - **Purpose**: Stop browsers from interpreting files as different MIME types
   - **Example**: `X-Content-Type-Options: nosniff`

4. **X-Frame-Options**: Controls whether page can be embedded in frames.
   - **Purpose**: Prevent clickjacking attacks
   - **Example**: `X-Frame-Options: DENY`

5. **X-XSS-Protection**: Enables browser's XSS filter.
   - **Purpose**: Basic XSS protection in older browsers
   - **Example**: `X-XSS-Protection: 1; mode=block`

6. **Referrer-Policy**: Controls how much referrer information is sent.
   - **Purpose**: Protect user privacy
   - **Example**: `Referrer-Policy: strict-origin-when-cross-origin`

7. **Permissions-Policy**: Controls browser features and APIs.
   - **Purpose**: Limit access to sensitive browser features
   - **Example**: `Permissions-Policy: geolocation=()`

**Implementation in Express:**
```javascript
const helmet = require('helmet');
app.use(helmet());

// Customize specific policies
app.use(helmet.contentSecurityPolicy({
  directives: {
    defaultSrc: ["'self'"],
    scriptSrc: ["'self'", "trusted-cdn.com"],
    styleSrc: ["'self'", "fonts.googleapis.com"],
    imgSrc: ["'self'", "data:", "cdn.example.com"]
  }
}));
```

**Real-world deployment considerations:**

1. **CSP implementation**: Start with report-only mode to avoid breaking functionality
   ```javascript
   Content-Security-Policy-Report-Only: default-src 'self'; report-uri /csp-report
   ```

2. **HSTS preloading**: Submit site to browser preload lists for maximum protection

3. **Testing headers**: Use tools like SecurityHeaders.com to test configuration

4. **Browser compatibility**: Some headers have limited browser support

5. **CDN considerations**: Ensure CDN passes through or adds security headers

**Common mistakes:**
- Setting overly restrictive CSP breaking legitimate functionality
- Forgetting to include subdomains in HSTS
- Not testing headers in different browsers
- Setting headers incorrectly (typos, wrong syntax)
- Not updating headers as application evolves

**Security headers as defense in depth:** While not a silver bullet, security headers provide an important layer of defense that works even if other security measures fail.

---
---

## 34. Helmet.js & Security Headers

#### 1. What is Helmet.js and how does it work?

**Answer:**

**Helmet.js** is an Express middleware that helps secure your application by setting various HTTP security headers. It's essentially a collection of smaller middleware functions that set security-related HTTP headers.

**How it works:** Helmet wraps 15 smaller middleware functions, each responsible for setting a specific security header. When you use `app.use(helmet())`, it enables all these middleware functions with sensible defaults.

**Real-world analogy:** Think of Helmet as a security guard for your web application. Just like a security guard checks IDs, monitors entrances, and enforces rules, Helmet checks and sets HTTP headers that tell browsers how to interact with your site securely.

**Key benefits:**
1. **Easy implementation**: One line of code adds multiple security headers
2. **Sensible defaults**: Pre-configured with secure settings
3. **Customizable**: Can enable/disable specific headers as needed
4. **Regular updates**: Maintained by the Express.js team
5. **Widely adopted**: Used by millions of applications

**Installation and basic usage:**
```javascript
const helmet = require('helmet');
const express = require('express');
const app = express();

// Enable all Helmet middleware with defaults
app.use(helmet());
```

**What happens under the hood:** When a request comes to your Express app, Helmet intercepts the response and adds security headers before sending it to the client. These headers instruct browsers on security policies to enforce.

**Real-world impact:** A major e-commerce site implemented Helmet and reduced XSS (Cross-Site Scripting) attacks by 85% because the Content Security Policy header prevented malicious scripts from executing.

---

#### 2. What security headers does Helmet set by default?

**Answer:**

**Helmet sets 11 security headers by default** when you use `app.use(helmet())`:

1. **Content-Security-Policy**: Restricts sources for scripts, styles, images, etc.
   - Default: Very restrictive policy that only allows same-origin resources

2. **Cross-Origin-Embedder-Policy**: Controls cross-origin resource embedding
   - Default: `require-corp` (requires Cross-Origin Resource Policy)

3. **Cross-Origin-Opener-Policy**: Controls how documents can be opened
   - Default: `same-origin` (only same-origin documents can open)

4. **Cross-Origin-Resource-Policy**: Controls cross-origin resource requests
   - Default: `same-origin` (only same-origin requests allowed)

5. **Expect-CT**: Enforces Certificate Transparency
   - Default: Not set (requires manual configuration)

6. **Origin-Agent-Cluster**: Isolates origin in separate process
   - Default: `?1` (enabled)

7. **Referrer-Policy**: Controls referrer information sent
   - Default: `no-referrer` (no referrer information sent)

8. **Strict-Transport-Security**: Enforces HTTPS
   - Default: `max-age=15552000; includeSubDomains` (6 months)

9. **X-Content-Type-Options**: Prevents MIME type sniffing
   - Default: `nosniff`

10. **X-DNS-Prefetch-Control**: Controls DNS prefetching
    - Default: `off`

11. **X-Download-Options**: IE-specific download security
    - Default: `noopen`

12. **X-Frame-Options**: Prevents clickjacking
    - Default: `SAMEORIGIN`

13. **X-Permitted-Cross-Domain-Policies**: Flash/PDF security
    - Default: `none`

14. **X-Powered-By**: Removes X-Powered-By header
    - Default: Removed (security through obscurity)

15. **X-XSS-Protection**: Legacy XSS protection
    - Default: `0` (disabled, use CSP instead)

**Real-world example:** A banking application uses all these headers plus additional custom configurations. The CSP is particularly strict, only allowing scripts from their own CDN and blocking all inline scripts.

**Important note:** Some headers like Expect-CT require additional configuration. The defaults are designed to be secure but may need adjustment based on your application's specific needs.

**Browser support:** Most modern browsers support these headers, but some (like X-XSS-Protection) are legacy and being phased out in favor of Content Security Policy.

---

#### 3. How do you customize Helmet configurations?

**Answer:**

**Helmet is highly customizable** - you can enable/disable specific headers or configure them individually.

**Basic customization approaches:**

1. **Disable specific headers:**
```javascript
app.use(helmet({
  contentSecurityPolicy: false, // Disable CSP
  xFrameOptions: false         // Disable X-Frame-Options
}));
```

2. **Configure individual headers:**
```javascript
app.use(helmet.contentSecurityPolicy({
  directives: {
    defaultSrc: ["'self'"],
    scriptSrc: ["'self'", "trusted-cdn.com"]
  }
}));

app.use(helmet.hsts({
  maxAge: 31536000, // 1 year
  includeSubDomains: true,
  preload: true
}));
```

3. **Use individual middleware (fine-grained control):**
```javascript
// Instead of helmet(), use specific middleware
app.use(helmet.contentSecurityPolicy());
app.use(helmet.xFrameOptions());
app.use(helmet.noSniff());
// Skip headers you don't need
```

**Common customization scenarios:**

**Scenario 1: E-commerce site with third-party payment processor**
```javascript
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'", "payments.example.com", "'unsafe-inline'"],
      styleSrc: ["'self'", "fonts.googleapis.com"],
      imgSrc: ["'self'", "data:", "cdn.example.com"],
      connectSrc: ["'self'", "api.payments.example.com"]
    }
  }
}));
```

**Scenario 2: API-only service (no frontend)**
```javascript
app.use(helmet({
  contentSecurityPolicy: false, // No HTML to protect
  xFrameOptions: false,         // No iframe embedding needed
  hsts: {
    maxAge: 31536000,
    includeSubDomains: true
  }
}));
```

**Scenario 3: Development environment**
```javascript
if (process.env.NODE_ENV === 'development') {
  // Looser security for development
  app.use(helmet({
    contentSecurityPolicy: false, // Allow inline scripts for hot reload
    hsts: false                   // Don't force HTTPS locally
  }));
} else {
  // Full security for production
  app.use(helmet());
}
```

**Best practices for customization:**
1. **Start with defaults**: Use `helmet()` first, then customize as needed
2. **Test thoroughly**: Security headers can break functionality
3. **Use environment-specific configs**: Different settings for dev/staging/prod
4. **Monitor reports**: Use CSP report-only mode initially
5. **Keep updated**: Helmet updates may change defaults

**Common customization needs:**
- **CDN integration**: Adding external domains to CSP
- **Analytics/ads**: Allowing third-party scripts
- **WebSocket connections**: Adding to connect-src
- **Font hosting**: Adding font sources
- **Media content**: Adding video/audio sources

**Real-world example:** A news website customizes Helmet to allow:
- Google Analytics scripts
- Social media sharing widgets
- Embedded YouTube videos
- Custom fonts from Google Fonts
- Ad network scripts (with careful sandboxing)

---

#### 4. What is Content Security Policy (CSP) and how do you implement it?

**Answer:**

**Content Security Policy (CSP)** is a security standard that helps prevent cross-site scripting (XSS), clickjacking, and other code injection attacks by specifying which sources of content are allowed to be loaded by a web page.

**How CSP works:** Instead of allowing all content from anywhere, CSP creates a whitelist of trusted content sources. The browser enforces this policy and blocks anything not explicitly allowed.

**Key CSP directives:**
- `default-src`: Fallback for other resource types
- `script-src`: Valid sources for JavaScript
- `style-src`: Valid sources for stylesheets
- `img-src`: Valid sources for images
- `connect-src`: Valid sources for XMLHttpRequest, WebSocket, etc.
- `font-src`: Valid sources for fonts
- `object-src`: Valid sources for plugins (Flash, Java)
- `media-src`: Valid sources for audio/video
- `frame-src`: Valid sources for frames/iframes
- `report-uri`: Where to send violation reports

**Implementation with Helmet:**
```javascript
app.use(helmet.contentSecurityPolicy({
  directives: {
    defaultSrc: ["'self'"], // Default: only same origin
    scriptSrc: [
      "'self'",            // Same origin scripts
      "https://apis.google.com", // Google APIs
      "'unsafe-inline'"    // Allow inline scripts (use cautiously)
    ],
    styleSrc: [
      "'self'",
      "https://fonts.googleapis.com" // Google Fonts
    ],
    imgSrc: [
      "'self'",
      "data:",             // data: URLs (for inline images)
      "https://*.example.com" // CDN images
    ],
    fontSrc: [
      "'self'",
      "https://fonts.gstatic.com" // Google Fonts
    ],
    connectSrc: [
      "'self'",
      "wss://api.example.com" // WebSocket connections
    ],
    frameSrc: [
      "'self'",
      "https://www.youtube.com" // Embedded YouTube
    ],
    reportUri: '/csp-violation-report' // Where to send reports
  },
  reportOnly: false // Set to true for testing
}));
```

**Real-world implementation strategy:**

**Phase 1: Monitoring (report-only mode)**
```javascript
// Start with report-only to see what would be blocked
app.use(helmet.contentSecurityPolicy({
  directives: { /* your policy */ },
  reportOnly: true,
  reportUri: '/csp-report'
}));
```

**Phase 2: Analyze reports**
- Check `/csp-report` endpoint for violations
- Identify legitimate resources being blocked
- Adjust policy based on real usage

**Phase 3: Enforce policy**
- Set `reportOnly: false`
- Monitor for any issues
- Adjust as needed

**Common CSP challenges and solutions:**

1. **Inline scripts/styles**: Use nonces or hashes instead of `'unsafe-inline'`
2. **eval() usage**: Avoid or use `'unsafe-eval'` cautiously
3. **Third-party widgets**: Add specific domains to appropriate directives
4. **Dynamic content**: Use nonces for scripts that change frequently
5. **Browser compatibility**: Some older browsers have limited CSP support

**Real-world example:** A SaaS application implements CSP with:
- Strict policy blocking all inline scripts
- Nonces for dynamic script injection
- Specific CDN domains for static resources
- Report-uri to monitor violations
- Regular policy reviews and updates

**CSP nonce example (more secure than unsafe-inline):**
```javascript
// Generate unique nonce for each request
app.use((req, res, next) => {
  res.locals.cspNonce = crypto.randomBytes(16).toString('hex');
  next();
});

app.use(helmet.contentSecurityPolicy({
  directives: {
    scriptSrc: [
      "'self'",
      (req, res) => `'nonce-${res.locals.cspNonce}'` // Dynamic nonce
    ]
  }
}));

// In template
<script nonce="<%= cspNonce %>">
  // This inline script is allowed
</script>
```

**Benefits of CSP:**
- **XSS protection**: Blocks malicious script injection
- **Data theft prevention**: Stops data exfiltration
- **Clickjacking mitigation**: Controls frame embedding
- **Mixed content blocking**: Enforces HTTPS for resources

**Remember:** CSP is a powerful security tool but requires careful implementation to avoid breaking legitimate functionality.

---

#### 5. How do you handle CORS securely?

**Answer:**

**CORS (Cross-Origin Resource Sharing)** is a mechanism that allows restricted resources on a web page to be requested from another domain outside the domain from which the first resource was served.

**Secure CORS implementation involves:**

1. **Restrict origins**: Only allow specific, trusted domains
2. **Limit methods**: Only allow necessary HTTP methods
3. **Control headers**: Only allow necessary request/response headers
4. **Use credentials carefully**: Be explicit about cookie/authentication handling
5. **Set appropriate max-age**: Cache preflight responses appropriately

**Secure CORS configuration with Express:**
```javascript
const cors = require('cors');

const corsOptions = {
  origin: (origin, callback) => {
    // Allow requests with no origin (like mobile apps or curl requests)
    if (!origin) return callback(null, true);
    
    const allowedOrigins = [
      'https://www.example.com',
      'https://admin.example.com',
      'https://app.example.com'
    ];
    
    if (allowedOrigins.indexOf(origin) !== -1) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: [
    'Content-Type',
    'Authorization',
    'X-Requested-With',
    'Accept'
  ],
  exposedHeaders: ['X-Total-Count', 'X-RateLimit-Limit'],
  credentials: true, // Allow cookies/auth headers
  maxAge: 86400, // 24 hours
  preflightContinue: false,
  optionsSuccessStatus: 204
};

app.use(cors(corsOptions));
```

**Security considerations for CORS:**

1. **Never use `origin: '*'` with credentials**: This creates security vulnerabilities
2. **Validate origins dynamically**: Check against whitelist or database
3. **Limit exposed headers**: Only expose necessary headers
4. **Use appropriate max-age**: Balance security and performance
5. **Handle preflight requests properly**: Essential for complex requests

**Real-world scenarios:**

**Scenario 1: Public API (read-only)**
```javascript
// Allow all origins for GET requests only
app.use('/api/public', cors({
  origin: '*',
  methods: ['GET', 'OPTIONS'],
  credentials: false
}));
```

**Scenario 2: Private API (authenticated)**
```javascript
// Strict origin checking for authenticated endpoints
app.use('/api/private', cors({
  origin: ['https://app.example.com', 'https://admin.example.com'],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE']
}));
```

**Scenario 3: Microservices communication**
```javascript
// Internal services only
app.use('/api/internal', cors({
  origin: [
    'https://service1.internal.example.com',
    'https://service2.internal.example.com'
  ],
  credentials: true
}));
```

**Common CORS security mistakes:**

1. **Wildcard origin with credentials**: Allows any site to make authenticated requests
2. **Overly permissive methods**: Allowing PUT/DELETE when only GET is needed
3. **Exposing sensitive headers**: Leaking internal information
4. **No origin validation**: Accepting requests from malicious domains
5. **Infinite max-age**: Caching preflight responses too long

**Advanced CORS security patterns:**

**Pattern 1: Dynamic origin validation from database**
```javascript
const corsOptions = {
  origin: async (origin, callback) => {
    if (!origin) return callback(null, true);
    
    // Check if origin is allowed in database
    const isAllowed = await AllowedOrigin.exists({ domain: origin });
    
    if (isAllowed) {
      callback(null, true);
    } else {
      callback(new Error('Origin not allowed'));
    }
  }
};
```

**Pattern 2: Environment-based CORS configuration**
```javascript
const getCorsConfig = () => {
  if (process.env.NODE_ENV === 'development') {
    return {
      origin: 'http://localhost:3000', // Development frontend
      credentials: true
    };
  }
  
  if (process.env.NODE_ENV === 'staging') {
    return {
      origin: ['https://staging.example.com', 'https://admin-staging.example.com'],
      credentials: true
    };
  }
  
  return {
    origin: ['https://example.com', 'https://www.example.com'],
    credentials: true
  };
};

app.use(cors(getCorsConfig()));
```

**Pattern 3: Route-specific CORS policies**
```javascript
// Public endpoints
app.get('/api/public/data', cors({ origin: '*' }), (req, res) => {
  res.json({ data: 'public data' });
});

// Private endpoints
app.get('/api/private/data', cors({
  origin: 'https://app.example.com',
  credentials: true
}), (req, res) => {
  res.json({ data: 'private data' });
});
```

**Monitoring and maintenance:**
1. **Log CORS violations**: Track blocked requests
2. **Regularly review allowed origins**: Remove unused domains
3. **Test CORS configuration**: Ensure it works as expected
4. **Update for new clients**: Add new domains as needed
5. **Security audits**: Include CORS in security reviews

**Remember:** CORS is a security feature, not just a convenience. Proper configuration prevents cross-origin attacks while allowing legitimate cross-origin requests.

---
---

## 35. CORS Implementation

#### 1. What is CORS and why is it needed?

**Answer:**

**CORS (Cross-Origin Resource Sharing)** is a security mechanism that allows web applications running at one origin (domain) to access resources from a different origin. It's implemented through HTTP headers that tell browsers which cross-origin requests are permitted.

**Why CORS is needed:** Browsers enforce the **same-origin policy** by default, which prevents web pages from making requests to a different domain than the one that served the web page. CORS provides a way to relax this policy in a controlled manner.

**Real-world analogy:** Imagine a library (your website) that only allows books from its own shelves (same origin) to be read. CORS is like a library card system that allows you to borrow books from other libraries (different origins) but only from specific, trusted libraries and with specific rules about what you can do with them.

**Common scenarios requiring CORS:**

1. **Frontend-backend separation**: Frontend on `app.example.com` needs to call API on `api.example.com`
2. **Third-party APIs**: Your application needs to access external services
3. **Microservices architecture**: Different services on different subdomains need to communicate
4. **CDN resources**: Loading fonts, scripts, or images from content delivery networks
5. **Embedded widgets**: Third-party widgets embedded in your site

**How CORS works:**
1. Browser sends request to different origin
2. Server responds with CORS headers indicating what's allowed
3. Browser checks if request is allowed based on headers
4. If allowed, request proceeds; if not, browser blocks it

**Without CORS:** A JavaScript application on `https://app.example.com` cannot make an AJAX request to `https://api.example.com` even though they're related domains.

**With CORS:** The API server can explicitly allow requests from `https://app.example.com` using CORS headers.

**Real-world example:** A weather application hosted on `weather-app.com` needs to fetch data from `api.weather-service.com`. Without CORS, the browser would block this request. With proper CORS configuration on the weather service API, the request is allowed.

**Key CORS headers:**
- `Access-Control-Allow-Origin`: Which origins are permitted
- `Access-Control-Allow-Methods`: Which HTTP methods are allowed
- `Access-Control-Allow-Headers`: Which headers can be used
- `Access-Control-Allow-Credentials`: Whether cookies/credentials can be sent
- `Access-Control-Max-Age`: How long to cache preflight responses

**CORS is a browser security feature:** Note that CORS is enforced by browsers, not servers. Servers can respond to any request; browsers decide whether to allow the client-side code to see the response.

---

#### 2. How do you implement CORS in Express?

**Answer:**

**There are three main approaches to implement CORS in Express:**

**1. Using the `cors` middleware (recommended):**
```javascript
const express = require('express');
const cors = require('cors');
const app = express();

// Basic usage - allow all origins (NOT recommended for production)
app.use(cors());

// Configured usage
app.use(cors({
  origin: 'https://example.com',
  methods: ['GET', 'POST'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));

// Route-specific CORS
app.get('/api/data', cors({ origin: 'https://app.example.com' }), (req, res) => {
  res.json({ data: 'protected data' });
});
```

**2. Manual CORS headers:**
```javascript
// Custom middleware
app.use((req, res, next) => {
  // Allow specific origin
  res.header('Access-Control-Allow-Origin', 'https://example.com');
  
  // Allow specific methods
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  
  // Allow specific headers
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  
  // Allow credentials
  res.header('Access-Control-Allow-Credentials', 'true');
  
  // Handle preflight requests
  if (req.method === 'OPTIONS') {
    return res.sendStatus(200);
  }
  
  next();
});
```

**3. Environment-based CORS configuration:**
```javascript
const corsConfig = {
  development: {
    origin: ['http://localhost:3000', 'http://localhost:3001'],
    credentials: true
  },
  staging: {
    origin: ['https://staging.example.com', 'https://admin-staging.example.com'],
    credentials: true
  },
  production: {
    origin: ['https://example.com', 'https://www.example.com'],
    credentials: true
  }
};

const environment = process.env.NODE_ENV || 'development';
app.use(cors(corsConfig[environment]));
```

**Complete implementation example:**
```javascript
const express = require('express');
const cors = require('cors');
const app = express();

// Dynamic origin validation
const allowedOrigins = [
  'https://example.com',
  'https://www.example.com',
  'https://admin.example.com',
  'http://localhost:3000' // Development
];

const corsOptions = {
  origin: (origin, callback) => {
    // Allow requests with no origin (like mobile apps, curl, postman)
    if (!origin) return callback(null, true);
    
    if (allowedOrigins.indexOf(origin) === -1) {
      const msg = `The CORS policy for this site does not allow access from ${origin}`;
      return callback(new Error(msg), false);
    }
    
    return callback(null, true);
  },
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: [
    'Origin',
    'X-Requested-With',
    'Content-Type',
    'Accept',
    'Authorization',
    'X-Auth-Token'
  ],
  exposedHeaders: [
    'Content-Range',
    'X-Content-Range',
    'X-Total-Count',
    'X-RateLimit-Limit',
    'X-RateLimit-Remaining'
  ],
  credentials: true,
  maxAge: 86400, // 24 hours
  preflightContinue: false,
  optionsSuccessStatus: 204
};

// Apply CORS to all routes
app.use(cors(corsOptions));

// Handle preflight requests for all routes
app.options('*', cors(corsOptions));

// Your routes
app.get('/api/data', (req, res) => {
  res.json({ message: 'CORS-enabled response' });
});

app.post('/api/data', (req, res) => {
  res.json({ message: 'POST request successful' });
});
```

**Real-world implementation considerations:**

**For public APIs:**
```javascript
// Allow all origins for public data
app.use('/api/public', cors({
  origin: '*',
  methods: ['GET', 'OPTIONS'],
  credentials: false
}));
```

**For authenticated APIs:**
```javascript
// Strict origin checking for private data
app.use('/api/private', cors({
  origin: (origin, callback) => {
    // Check against database of allowed clients
    if (isValidClient(origin)) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed'));
    }
  },
  credentials: true
}));
```

**For different API versions:**
```javascript
// v1 API - legacy clients
app.use('/api/v1', cors({
  origin: ['https://legacy-app.example.com'],
  methods: ['GET', 'POST']
}));

// v2 API - modern clients
app.use('/api/v2', cors({
  origin: ['https://app.example.com', 'https://mobile-app.example.com'],
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH']
}));
```

**Testing CORS implementation:**
```javascript
// Test endpoint to verify CORS is working
app.get('/api/cors-test', cors(corsOptions), (req, res) => {
  res.json({
    message: 'CORS test successful',
    headers: req.headers,
    origin: req.headers.origin
  });
});
```

**Common implementation mistakes to avoid:**

1. **Using `origin: '*'` with `credentials: true`**: Security vulnerability
2. **Forgetting to handle OPTIONS requests**: Preflight requests will fail
3. **Not setting appropriate `maxAge`**: Too short causes frequent preflights, too long delays policy updates
4. **Exposing unnecessary headers**: Information leakage
5. **Hardcoding origins**: Makes deployment to new environments difficult

**Monitoring CORS:**
- Log CORS violations for analysis
- Track which origins are making requests
- Monitor preflight request frequency
- Alert on unexpected origin patterns

**Remember:** CORS implementation should be tailored to your specific use case, balancing security needs with functional requirements.

---

#### 3. What are preflight requests and how do you handle them?

**Answer:**

**Preflight requests** are OPTIONS requests that browsers send before making certain types of cross-origin requests to determine if the actual request is safe to send. They're part of the CORS protocol.

**When browsers send preflight requests:**
1. **Non-simple methods**: PUT, DELETE, PATCH, etc.
2. **Custom headers**: Any header not in the safe list
3. **Content-Type**: Other than `application/x-www-form-urlencoded`, `multipart/form-data`, or `text/plain`
4. **Requests with credentials**: When `withCredentials` is true

**Simple requests (no preflight):**
- GET, HEAD, POST methods
- Limited set of headers
- Simple content types
- No credentials (unless explicitly allowed)

**How preflight works:**
1. Browser sends OPTIONS request with:
   - `Origin` header (requesting domain)
   - `Access-Control-Request-Method` (intended method)
   - `Access-Control-Request-Headers` (intended headers)
2. Server responds with CORS headers indicating what's allowed
3. Browser checks if actual request is permitted
4. If allowed, browser sends actual request
5. If not allowed, browser blocks the request

**Handling preflight requests in Express:**

**Method 1: Automatic handling with `cors` middleware**
```javascript
const cors = require('cors');
app.use(cors()); // Automatically handles OPTIONS requests
```

**Method 2: Manual handling**
```javascript
// Handle OPTIONS for all routes
app.options('*', (req, res) => {
  res.header('Access-Control-Allow-Origin', 'https://example.com');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  res.header('Access-Control-Max-Age', '86400'); // 24 hours
  res.sendStatus(204);
});
```

**Method 3: Route-specific preflight handling**
```javascript
// Specific route that needs custom preflight handling
app.options('/api/complex-endpoint', (req, res) => {
  res.header('Access-Control-Allow-Origin', 'https://app.example.com');
  res.header('Access-Control-Allow-Methods', 'POST, PUT');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-Custom-Header');
  res.header('Access-Control-Allow-Credentials', 'true');
  res.header('Access-Control-Max-Age', '3600'); // 1 hour
  res.sendStatus(204);
});
```

**Optimizing preflight requests:**

**1. Set appropriate `maxAge`:**
```javascript
// Cache preflight response for 24 hours
res.header('Access-Control-Max-Age', '86400');
```

**2. Use wildcards carefully:**
```javascript
// Allow all methods (reduces preflight caching effectiveness)
res.header('Access-Control-Allow-Methods', '*');

// Better: Specify exact methods
res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
```

**3. Handle complex scenarios:**
```javascript
// Dynamic preflight handling based on request
app.options('/api/:resource', (req, res) => {
  const resource = req.params.resource;
  const config = getCorsConfigForResource(resource);
  
  Object.entries(config.headers).forEach(([key, value]) => {
    res.header(key, value);
  });
  
  res.sendStatus(204);
});
```

**Real-world example:** A file upload endpoint needs special handling:
```javascript
app.options('/api/upload', (req, res) => {
  res.header('Access-Control-Allow-Origin', 'https://app.example.com');
  res.header('Access-Control-Allow-Methods', 'POST');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-File-Size');
  res.header('Access-Control-Allow-Credentials', 'true');
  res.header('Access-Control-Max-Age', '3600'); // 1 hour for upload endpoints
  res.sendStatus(204);
});

app.post('/api/upload', (req, res) => {
  // Handle file upload
});
```

**Common preflight issues and solutions:**

**Issue 1: Preflight failing due to missing headers**
- **Solution**: Ensure all required headers are in `Access-Control-Allow-Headers`

**Issue 2: Preflight not cached**
- **Solution**: Set `Access-Control-Max-Age` header

**Issue 3: Multiple preflight requests for same endpoint**
- **Solution**: Check browser caching, ensure consistent headers

**Issue 4: Preflight for simple requests**
- **Solution**: Review request characteristics, may need to simplify

**Monitoring preflight requests:**
```javascript
// Log preflight requests for debugging
app.use((req, res, next) => {
  if (req.method === 'OPTIONS') {
    console.log('Preflight request:', {
      origin: req.headers.origin,
      method: req.headers['access-control-request-method'],
      headers: req.headers['access-control-request-headers'],
      timestamp: new Date().toISOString()
    });
  }
  next();
});
```

**Performance considerations:**
- Preflight requests add latency (extra round trip)
- Caching reduces but doesn't eliminate overhead
- Consider making requests "simple" when possible
- Balance security needs with performance

**Security implications:**
- Preflight doesn't prevent actual request from being sent
- Server should still validate all requests
- Preflight is a browser feature, not server enforcement
- Malicious clients can ignore CORS entirely

**Remember:** Preflight requests are a security feature that protects users by having browsers check with servers before making potentially dangerous cross-origin requests. Proper handling ensures both security and performance.

---

#### 4. How do you configure allowed origins, methods, and headers?

**Answer:**

**Configuring CORS properly involves three key components:** origins (who can access), methods (what they can do), and headers (what information they can send/receive).

**1. Configuring allowed origins:**

**Static origins (hardcoded):**
```javascript
app.use(cors({
  origin: 'https://example.com' // Single origin
}));

app.use(cors({
  origin: ['https://example.com', 'https://www.example.com'] // Multiple origins
}));
```

**Dynamic origin validation:**
```javascript
const allowedOrigins = [
  'https://example.com',
  'https://app.example.com',
  'https://admin.example.com',
  'http://localhost:3000', // Development
  'https://staging.example.com' // Staging
];

app.use(cors({
  origin: (origin, callback) => {
    // Allow requests with no origin (mobile apps, server-to-server)
    if (!origin) return callback(null, true);
    
    // Check against allowed list
    if (allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error(`Origin ${origin} not allowed`));
    }
  }
}));
```

**Database-driven origin validation:**
```javascript
app.use(cors({
  origin: async (origin, callback) => {
    if (!origin) return callback(null, true);
    
    // Check database for allowed origin
    const client = await Client.findOne({ domain: origin });
    
    if (client && client.isActive) {
      callback(null, true);
    } else {
      callback(new Error('Origin not authorized'));
    }
  }
}));
```

**2. Configuring allowed methods:**

**Basic method configuration:**
```javascript
app.use(cors({
  methods: ['GET', 'POST'] // Only allow GET and POST
}));

app.use(cors({
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'] // Common REST methods
}));
```

**Route-specific methods:**
```javascript
// Read-only endpoint
app.get('/api/products', cors({ methods: ['GET'] }), (req, res) => {
  res.json(products);
});

// Read-write endpoint
app.use('/api/admin/products', cors({ methods: ['GET', 'POST', 'PUT', 'DELETE'] }));
```

**Dynamic method configuration:**
```javascript
const getMethodsForEndpoint = (path) => {
  const methodMap = {
    '/api/public': ['GET'],
    '/api/users': ['GET', 'POST'],
    '/api/users/:id': ['GET', 'PUT', 'DELETE'],
    '/api/upload': ['POST']
  };
  
  return methodMap[path] || ['GET', 'POST', 'PUT', 'DELETE'];
};

app.use(cors({
  methods: (req, res) => getMethodsForEndpoint(req.path)
}));
```

**3. Configuring allowed headers:**

**Basic header configuration:**
```javascript
app.use(cors({
  allowedHeaders: ['Content-Type', 'Authorization'] // Minimal set
}));

app.use(cors({
  allowedHeaders: [
    'Origin',
    'X-Requested-With',
    'Content-Type',
    'Accept',
    'Authorization',
    'X-Auth-Token',
    'X-API-Key'
  ]
}));
```

**Dynamic header configuration:**
```javascript
app.use(cors({
  allowedHeaders: (req, callback) => {
    const baseHeaders = ['Content-Type', 'Authorization'];
    
    // Add custom headers for specific endpoints
    if (req.path.startsWith('/api/upload')) {
      baseHeaders.push('X-File-Name', 'X-File-Size');
    }
    
    if (req.path.startsWith('/api/analytics')) {
      baseHeaders.push('X-Client-ID', 'X-Session-ID');
    }
    
    callback(null, baseHeaders);
  }
}));
```

**Complete configuration example:**
```javascript
const corsConfig = {
  // Origins
  origin: (origin, callback) => {
    const allowed = [
      'https://production-app.com',
      'https://admin.production-app.com',
      'https://staging-app.com',
      'http://localhost:3000'
    ];
    
    if (!origin || allowed.includes(origin)) {
      callback(null, true);
    } else {
      console.warn(`Blocked CORS request from: ${origin}`);
      callback(new Error('Not allowed by CORS'));
    }
  },
  
  // Methods
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  
  // Headers
  allowedHeaders: [
    'Origin',
    'X-Requested-With',
    'Content-Type',
    'Accept',
    'Authorization',
    'X-CSRF-Token',
    'X-API-Version'
  ],
  
  // Exposed headers (client can access)
  exposedHeaders: [
    'X-Total-Count',
    'X-Page-Count',
    'X-RateLimit-Limit',
    'X-RateLimit-Remaining'
  ],
  
  // Credentials
  credentials: true,
  
  // Max age for preflight cache
  maxAge: 86400, // 24 hours
  
  // Success status for OPTIONS
  optionsSuccessStatus: 204
};

app.use(cors(corsConfig));
```

**Environment-specific configurations:**

**Development:**
```javascript
const devCorsConfig = {
  origin: ['http://localhost:3000', 'http://localhost:3001', 'http://localhost:8080'],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS', 'PATCH'],
  allowedHeaders: ['*'] // Allow all during development
};
```

**Staging:**
```javascript
const stagingCorsConfig = {
  origin: [
    'https://staging.example.com',
    'https://admin-staging.example.com',
    'https://app-staging.example.com'
  ],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization', 'X-API-Key']
};
```

**Production:**
```javascript
const productionCorsConfig = {
  origin: [
    'https://example.com',
    'https://www.example.com',
    'https://app.example.com'
  ],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  maxAge: 3600 // 1 hour for production
};
```

**Validation and testing:**
```javascript
// Test endpoint to verify CORS configuration
app.get('/api/cors-config-test', cors(corsConfig), (req, res) => {
  res.json({
    allowedOrigins: corsConfig.origin.toString(),
    allowedMethods: corsConfig.methods,
    allowedHeaders: corsConfig.allowedHeaders,
    currentOrigin: req.headers.origin,
    timestamp: new Date().toISOString()
  });
});
```

**Best practices for configuration:**

1. **Principle of least privilege**: Only allow what's necessary
2. **Environment-specific configs**: Different rules for dev/staging/prod
3. **Regular reviews**: Update allowed origins as applications evolve
4. **Logging**: Track blocked requests for security monitoring
5. **Documentation**: Document why each origin/method/header is allowed

**Security considerations:**
- Never use `origin: '*'` with `credentials: true`
- Be specific with allowed methods (don't use wildcards)
- Limit exposed headers to prevent information leakage
- Regularly audit and remove unused origins
- Consider rate limiting for CORS-enabled endpoints

**Remember:** CORS configuration is a balance between security and functionality. Start restrictive and loosen only as needed, with proper justification for each relaxation.

---

#### 5. What are the security considerations for CORS?

**Answer:**

**CORS security considerations are critical because misconfiguration can expose your application to various attacks.**

**Major security risks:**

1. **Overly permissive origins**: Using `origin: '*'` or allowing too many domains
   - **Risk**: Any website can make requests to your API
   - **Mitigation**: Use specific allowlists, validate origins dynamically

2. **Credentials with wildcard origins**: `credentials: true` with `origin: '*'`
   - **Risk**: Cross-site request forgery (CSRF) and session hijacking
   - **Mitigation**: Never combine wildcard origins with credentials

3. **Exposing sensitive headers**: Headers that leak internal information
   - **Risk**: Information disclosure about server internals
   - **Mitigation**: Only expose necessary headers, use `exposedHeaders` carefully

4. **Allowing dangerous methods**: PUT, DELETE without proper authentication
   - **Risk**: Data modification or deletion by unauthorized parties
   - **Mitigation**: Restrict methods based on endpoint sensitivity

5. **Insufficient preflight caching**: Too short `maxAge` values
   - **Risk**: Performance issues, but not direct security risk
   - **Mitigation**: Balance security and performance needs

**Security best practices:**

**1. Origin validation:**
```javascript
// Never do this in production
app.use(cors({ origin: '*' }));

// Instead, validate origins
const allowedOrigins = new Set([
  'https://trusted-domain.com',
  'https://another-trusted.com'
]);

app.use(cors({
  origin: (origin, callback) => {
    if (allowedOrigins.has(origin)) {
      callback(null, true);
    } else {
      // Log blocked attempts
      console.warn(`Blocked CORS request from: ${origin}`);
      callback(new Error('Not allowed'));
    }
  }
}));
```

**2. Credential handling:**
```javascript
// Public endpoints (no credentials)
app.use('/api/public', cors({
  origin: '*',
  credentials: false
}));

// Private endpoints (with credentials)
app.use('/api/private', cors({
  origin: 'https://trusted-app.com',
  credentials: true
}));
```

**3. Method restriction:**
```javascript
// Read-only endpoints
app.use('/api/readonly', cors({
  methods: ['GET', 'OPTIONS']
}));

// Administrative endpoints
app.use('/api/admin', cors({
  origin: 'https://admin.trusted-app.com',
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  credentials: true
}));
```

**4. Header management:**
```javascript
// Minimal headers for security
app.use(cors({
  allowedHeaders: ['Content-Type', 'Authorization'],
  exposedHeaders: [] // Don't expose unnecessary headers
}));
```

**Advanced security measures:**

**1. Rate limiting by origin:**
```javascript
const rateLimit = require('express-rate-limit');

const originLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: (req) => {
    // Different limits for different origins
    const origin = req.headers.origin;
    if (origin === 'https://trusted-partner.com') {
      return 1000; // Higher limit for trusted partner
    }
    return 100; // Default limit
  },
  keyGenerator: (req) => req.headers.origin || req.ip
});

app.use('/api', originLimiter);
```

**2. CORS with authentication:**
```javascript
// Combine CORS with authentication middleware
app.use('/api/secure', cors({
  origin: 'https://secure-app.com',
  credentials: true
}), authenticateUser, (req, res) => {
  // Only authenticated users from allowed origin
});
```

**3. Monitoring and logging:**
```javascript
// Log all CORS requests for security auditing
app.use((req, res, next) => {
  if (req.headers.origin) {
    console.log({
      timestamp: new Date().toISOString(),
      origin: req.headers.origin,
      method: req.method,
      path: req.path,
      userAgent: req.headers['user-agent']
    });
  }
  next();
});
```

**4. Regular security audits:**
- Review allowed origins quarterly
- Remove unused origins
- Test CORS configuration
- Check for new vulnerabilities

**Common attack scenarios and defenses:**

**Scenario 1: CSRF via CORS misconfiguration**
- **Attack**: Malicious site uses victim's credentials to make requests
- **Defense**: Never use `credentials: true` with wildcard origins

**Scenario 2: Information leakage via exposed headers**
- **Attack**: Attacker reads sensitive headers from responses
- **Defense**: Minimize `exposedHeaders`, don't expose internal info

**Scenario 3: DoS via preflight requests**
- **Attack**: Flood server with OPTIONS requests
- **Defense**: Rate limit preflight requests, use appropriate `maxAge`

**Scenario 4: Origin spoofing**
- **Attack**: Fake origin header to bypass restrictions
- **Defense**: Server-side origin validation, don't trust client headers

**Real-world security incident:** A major API provider had CORS misconfigured, allowing any website to make authenticated requests on behalf of users. This was fixed by implementing strict origin validation and removing wildcard origins.

**Security checklist for CORS:**
- [ ] No wildcard origins with credentials
- [ ] Specific allowlist of trusted origins
- [ ] Minimal allowed methods per endpoint
- [ ] Minimal allowed and exposed headers
- [ ] Proper preflight caching
- [ ] Regular origin list reviews
- [ ] Logging of blocked requests
- [ ] Rate limiting by origin
- [ ] Combined with other security measures

**Remember:** CORS is not a substitute for proper authentication, authorization, and input validation. It's one layer in a defense-in-depth security strategy.

---
---

## 36. Rate Limiting & Throttling

#### 1. Why is rate limiting important?

**Answer:**

**Rate limiting** is the practice of restricting the number of requests a client can make to an API or web service within a specific time period. It's a critical component of API management and web application security.

**Why rate limiting is important:**

1. **Prevent abuse and attacks**: Stops brute force attacks, credential stuffing, and denial-of-service (DoS) attacks
2. **Protect resources**: Ensures fair usage and prevents resource exhaustion
3. **Maintain service quality**: Prevents a few users from degrading performance for everyone
4. **Control costs**: For cloud-based services, limits unexpected billing spikes
5. **Enforce business rules**: Implements tiered access based on subscription levels
6. **Gather analytics**: Provides data on usage patterns and potential abuse

**Real-world examples of rate limiting needs:**

**E-commerce platform:**
- Prevent price scraping by competitors
- Stop inventory hoarding by bots
- Limit checkout attempts to prevent fraud
- Control API usage by third-party integrations

**Social media platform:**
- Limit post creation to prevent spam
- Control API calls by third-party apps
- Prevent brute force login attempts
- Manage feed refresh rates

**Financial service:**
- Restrict transaction attempts for security
- Limit account lookup queries
- Control real-time data streaming
- Prevent trading algorithm abuse

**API provider:**
- Enforce subscription tiers (free vs paid)
- Prevent API key sharing
- Manage server load during peak times
- Protect against coordinated attacks

**Consequences of no rate limiting:**
1. **Service degradation**: Legitimate users experience slow responses
2. **Resource exhaustion**: Database connections, memory, CPU overwhelmed
3. **Security breaches**: Brute force attacks succeed
4. **Financial impact**: Cloud costs spiral out of control
5. **Reputation damage**: Service becomes unreliable

**Types of rate limiting:**

1. **User-based**: Limits per user account
2. **IP-based**: Limits per IP address
3. **API key-based**: Limits per API key
4. **Endpoint-based**: Different limits for different endpoints
5. **Geographic**: Different limits by region
6. **Time-based**: Varying limits by time of day

**Real-world incident:** A popular API without rate limiting was used by a research project to make millions of requests, causing service outages for all users. Implementation of rate limiting restored stability.

**Rate limiting vs throttling:**
- **Rate limiting**: Hard limit, requests beyond limit are rejected
- **Throttling**: Soft limit, requests are delayed or queued

**Business impact:** Proper rate limiting enables monetization through tiered pricing, protects against abuse, and ensures service reliability - all critical for business success.

---

#### 2. How do you implement rate limiting in Express?

**Answer:**

**There are several approaches to implement rate limiting in Express, from simple to sophisticated.**

**1. Using `express-rate-limit` middleware (recommended):**
```javascript
const rateLimit = require('express-rate-limit');

// Basic rate limiter
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // Limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP, please try again later',
  standardHeaders: true, // Return rate limit info in `RateLimit-*` headers
  legacyHeaders: false, // Disable `X-RateLimit-*` headers
});

// Apply to all requests
app.use(limiter);

// Or apply to specific routes
app.use('/api/', limiter);
```

**2. Custom rate limiting middleware:**
```javascript
const rateLimitStore = new Map();

const customLimiter = (req, res, next) => {
  const ip = req.ip;
  const currentTime = Date.now();
  const windowMs = 15 * 60 * 1000; // 15 minutes
  const maxRequests = 100;
  
  if (!rateLimitStore.has(ip)) {
    rateLimitStore.set(ip, {
      count: 1,
      resetTime: currentTime + windowMs
    });
    return next();
  }
  
  const userData = rateLimitStore.get(ip);
  
  if (currentTime > userData.resetTime) {
    // Reset window
    userData.count = 1;
    userData.resetTime = currentTime + windowMs;
    return next();
  }
  
  if (userData.count >= maxRequests) {
    return res.status(429).json({
      error: 'Too many requests',
      retryAfter: Math.ceil((userData.resetTime - currentTime) / 1000)
    });
  }
  
  userData.count++;
  next();
};

app.use(customLimiter);
```

**3. Redis-based rate limiting (for distributed systems):**
```javascript
const Redis = require('ioredis');
const redis = new Redis();
const { RateLimiterRedis } = require('rate-limiter-flexible');

const rateLimiter = new RateLimiterRedis({
  storeClient: redis,
  points: 10, // Number of points
  duration: 1, // Per second
  keyPrefix: 'rl' // Redis key prefix
});

const redisLimiter = (req, res, next) => {
  rateLimiter.consume(req.ip)
    .then(() => {
      next();
    })
    .catch(() => {
      res.status(429).send('Too Many Requests');
    });
};

app.use(redisLimiter);
```

**4. Route-specific rate limiting:**
```javascript
const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 5, // Limit each IP to 5 requests per windowMs
  message: 'Too many login attempts, please try again later'
});

const apiLimiter = rateLimit({
  windowMs: 60 * 1000, // 1 minute
  max: 60, // Limit each IP to 60 requests per minute
  message: 'Too many API requests, please slow down'
});

// Apply different limiters to different routes
app.post('/login', authLimiter, loginController);
app.use('/api/', apiLimiter);
```

**5. User-based rate limiting (with authentication):**
```javascript
const userLimiter = rateLimit({
  windowMs: 60 * 60 * 1000, // 1 hour
  max: (req) => {
    // Different limits based on user role
    if (req.user?.role === 'premium') {
      return 1000;
    }
    if (req.user?.role === 'free') {
      return 100;
    }
    return 10; // Unauthenticated users
  },
  keyGenerator: (req) => req.user?.id || req.ip,
  skip: (req) => req.user?.role === 'admin' // Skip for admins
});

app.use('/api/protected', authenticate, userLimiter);
```

**Complete implementation example:**
```javascript
const express = require('express');
const rateLimit = require('express-rate-limit');
const RedisStore = require('rate-limit-redis');
const Redis = require('ioredis');

const app = express();
const redisClient = new Redis();

// Global rate limiter (loose)
const globalLimiter = rateLimit({
  store: new RedisStore({
    sendCommand: (...args) => redisClient.call(...args),
  }),
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 1000, // Maximum 1000 requests per IP
  message: {
    error: 'Too many requests, please try again later.',
    retryAfter: '15 minutes'
  },
  standardHeaders: true,
  skip: (req) => req.ip === '127.0.0.1' // Skip for localhost
});

// Authentication rate limiter (strict)
const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 5, // 5 attempts per IP
  message: {
    error: 'Too many login attempts. Account may be temporarily locked.',
    retryAfter: '15 minutes'
  },
  skipFailedRequests: true // Don't count failed attempts
});

// API rate limiter (tiered)
const apiLimiter = rateLimit({
  windowMs: 60 * 1000, // 1 minute
  max: (req) => {
    const apiKey = req.headers['x-api-key'];
    if (!apiKey) return 10; // No API key
    
    // Check API key tier from database/cache
    const tier = getApiKeyTier(apiKey);
    switch(tier) {
      case 'enterprise': return 1000;
      case 'professional': return 100;
      case 'basic': return 50;
      default: return 10;
    }
  },
  keyGenerator: (req) => req.headers['x-api-key'] || req.ip,
  message: 'API rate limit exceeded. Upgrade your plan for higher limits.'
});

// Apply limiters
app.use(globalLimiter); // All routes
app.post('/auth/login', authLimiter); // Login endpoint
app.use('/api/v1', apiLimiter); // API routes

// Health check endpoint (no rate limiting)
app.get('/health', (req, res) => {
  res.json({ status: 'healthy' });
});
```

**Best practices for implementation:**

1. **Start with reasonable defaults**: 100 requests/15 minutes is common
2. **Use different limits for different endpoints**: Authentication vs data retrieval
3. **Consider skip options**: Exclude health checks, internal IPs
4. **Provide clear error messages**: Tell users when and why they're limited
5. **Include retry information**: Headers indicating when to retry
6. **Monitor and adjust**: Based on actual usage patterns
7. **Use persistent storage**: For distributed applications
8. **Test thoroughly**: Ensure it doesn't break legitimate usage

**Monitoring rate limiting:**
- Track rate limit hits vs misses
- Monitor which IPs/users hit limits frequently
- Adjust limits based on usage patterns
- Alert on abnormal rate limit activity

**Remember:** Rate limiting should be transparent to legitimate users while effectively blocking abuse. Good implementation balances security, usability, and performance.

---

#### 3. What are the different rate limiting algorithms?

**Answer:**

**Different rate limiting algorithms** offer various trade-offs between accuracy, memory usage, and implementation complexity.

**1. Fixed Window Counter:**
- **How it works**: Counts requests in fixed time windows (e.g., per minute)
- **Pros**: Simple to implement, memory efficient
- **Cons**: Allows bursts at window boundaries, less accurate
- **Use case**: Basic rate limiting, low-traffic applications

```javascript
// Example: 100 requests per minute
// Window 1: 00:00-00:59, Window 2: 01:00-01:59
// Problem: 100 requests at 00:59 + 100 requests at 01:00 = 200 requests in 2 seconds
```

**2. Sliding Window Log:**
- **How it works**: Keeps timestamp of each request, removes old ones
- **Pros**: Accurate, no burst problems
- **Cons**: Memory intensive (stores all timestamps), computationally expensive
- **Use case**: When accuracy is critical, low request volume

```javascript
// Store: [timestamp1, timestamp2, timestamp3, ...]
// For each request: remove timestamps older than window, count remaining
```

**3. Sliding Window Counter:**
- **How it works**: Combines current and previous window counts
- **Pros**: More accurate than fixed window, less memory than sliding log
- **Cons**: More complex implementation
- **Use case**: Most production applications

```javascript
// Example: If current window is 40% through, count = 
// (previous window count * 0.6) + current window count
```

**4. Token Bucket:**
- **How it works**: Tokens added at fixed rate, each request consumes token
- **Pros**: Allows bursts, smooths traffic
- **Cons**: More complex, requires token management
- **Use case**: APIs needing burst capability

```javascript
// Bucket capacity: 100 tokens
// Refill rate: 10 tokens per second
// Request uses 1 token, if bucket empty → rate limited
```

**5. Leaky Bucket:**
- **How it works**: Requests enter queue, processed at fixed rate
- **Pros**: Smooths traffic, prevents bursts
- **Cons**: Can cause delays, queue management
- **Use case**: When steady processing rate is needed

```javascript
// Queue with fixed processing rate
// If queue full → rate limited
// Processes 10 requests per second regardless of arrival rate
```

**6. Generic Cell Rate Algorithm (GCRA):**
- **How it works**: Theoretical arrival time for next request
- **Pros**: Very accurate, prevents bursts
- **Cons**: Complex implementation
- **Use case**: Telecommunications, high-precision needs

**Algorithm comparison:**

| Algorithm | Accuracy | Memory | CPU | Burst Handling | Implementation |
|-----------|----------|--------|-----|----------------|----------------|
| Fixed Window | Low | Low | Low | Poor | Easy |
| Sliding Log | High | High | High | Good | Medium |
| Sliding Counter | Medium | Low | Low | Fair | Medium |
| Token Bucket | Medium | Medium | Medium | Excellent | Hard |
| Leaky Bucket | Medium | Medium | Medium | Poor | Hard |
| GCRA | High | Low | Medium | Good | Hard |

**Choosing the right algorithm:**

**For API rate limiting:**
- **Simple needs**: Fixed Window or Sliding Counter
- **Accuracy needed**: Sliding Window Counter
- **Burst handling**: Token Bucket

**For authentication endpoints:**
- **Login attempts**: Fixed Window (simpler, still effective)
- **Password reset**: Sliding Window (more accurate)

**For distributed systems:**
- **Redis-based**: Use Redis' built-in algorithms
- **Database-backed**: Fixed Window with database counters

**Real-world examples:**

**Twitter API**: Uses Token Bucket algorithm
- Allows bursts for trending topics
- Smooths overall traffic
- Different buckets for different endpoints

**GitHub API**: Uses Leaky Bucket algorithm
- Steady processing rate
- Prevents API abuse
- Clear rate limit headers

**Stripe API**: Uses Sliding Window Counter
- Accurate billing calculations
- Fair usage across time
- Tiered limits for customers

**Implementation considerations:**

**Memory vs accuracy trade-off:**
- Sliding Log: High accuracy, high memory
- Fixed Window: Lower accuracy, low memory
- Choose based on your constraints

**Distributed systems:**
- Algorithms must work across multiple servers
- Redis or database storage needed
- Consider consistency vs performance

**Monitoring and adjustment:**
- Track which algorithm works best
- Adjust parameters based on data
- Consider hybrid approaches

**Modern libraries:** Most rate limiting libraries (like `express-rate-limit` or `rate-limiter-flexible`) implement these algorithms internally, allowing you to choose based on your needs without implementing from scratch.

**Remember:** The best algorithm depends on your specific requirements. Start with something simple (Fixed Window) and upgrade if you need more accuracy or specific features.

---

#### 4. How do you handle rate limit headers?

**Answer:**

**Rate limit headers** communicate rate limiting information to clients, helping them understand their current usage and limits. Proper header implementation improves API usability and developer experience.

**Standard rate limit headers (RFC 6585):**

1. **RateLimit-Limit**: Maximum requests allowed in time window
2. **RateLimit-Remaining**: Remaining requests in current window
3. **RateLimit-Reset**: Time when limit resets (Unix timestamp)
4. **RateLimit-Policy**: Description of rate limit policy
5. **Retry-After**: When to retry after being rate limited (seconds)

**Legacy headers (deprecated but still used):**
- `X-RateLimit-Limit`
- `X-RateLimit-Remaining`
- `X-RateLimit-Reset`

**Implementation with `express-rate-limit`:**
```javascript
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100,
  standardHeaders: true, // Use standard RFC headers
  legacyHeaders: false, // Disable legacy headers
  message: {
    error: 'Rate limit exceeded',
    retryAfter: '15 minutes'
  },
  // Custom headers
  headers: true,
});

app.use(limiter);
```

**Custom header implementation:**
```javascript
const customLimiter = (req, res, next) => {
  const ip = req.ip;
  const windowMs = 15 * 60 * 1000;
  const maxRequests = 100;
  
  // Get current usage (from Redis, database, or memory)
  const { count, resetTime } = getUsage(ip);
  const remaining = Math.max(0, maxRequests - count);
  const reset = Math.ceil(resetTime / 1000); // Unix timestamp
  
  // Set headers
  res.set({
    'RateLimit-Limit': maxRequests,
    'RateLimit-Remaining': remaining,
    'RateLimit-Reset': reset,
    'RateLimit-Policy': `${maxRequests};w=${windowMs/1000}`,
  });
  
  if (count >= maxRequests) {
    res.set('Retry-After', Math.ceil((resetTime - Date.now()) / 1000));
    return res.status(429).json({
      error: 'Rate limit exceeded',
      retryAfter: Math.ceil((resetTime - Date.now()) / 1000)
    });
  }
  
  next();
};
```

**Tiered rate limit headers:**
```javascript
const tieredLimiter = rateLimit({
  windowMs: 60 * 1000, // 1 minute
  max: (req) => {
    const apiKey = req.headers['x-api-key'];
    const tier = getTier(apiKey);
    return tier.limit;
  },
  keyGenerator: (req) => req.headers['x-api-key'] || req.ip,
  handler: (req, res) => {
    const apiKey = req.headers['x-api-key'];
    const tier = getTier(apiKey);
    
    res.set({
      'RateLimit-Limit': tier.limit,
      'RateLimit-Remaining': 0,
      'RateLimit-Reset': Math.ceil((Date.now() + 60 * 1000) / 1000),
      'RateLimit-Policy': `${tier.limit};w=60`,
      'Retry-After': 60
    });
    
    res.status(429).json({
      error: 'Rate limit exceeded',
      message: `You have exceeded your ${tier.name} tier limit of ${tier.limit} requests per minute`,
      upgradeUrl: tier.upgradeUrl,
      retryAfter: 60
    });
  }
});
```

**Endpoint-specific headers:**
```javascript
// Different headers for different endpoints
app.get('/api/public', rateLimit({
  windowMs: 60 * 1000,
  max: 60,
  handler: (req, res) => {
    res.set({
      'RateLimit-Limit': 60,
      'RateLimit-Policy': '60;w=60'
    });
    res.status(429).json({ error: 'Public API limit exceeded' });
  }
}));

app.get('/api/private', rateLimit({
  windowMs: 60 * 1000,
  max: 1000,
  handler: (req, res) => {
    res.set({
      'RateLimit-Limit': 1000,
      'RateLimit-Policy': '1000;w=60'
    });
    res.status(429).json({ error: 'Private API limit exceeded' });
  }
}));
```

**Best practices for rate limit headers:**

1. **Always include headers**: Even when not rate limited
2. **Use standard headers**: `RateLimit-*` instead of `X-RateLimit-*`
3. **Provide clear policies**: In `RateLimit-Policy` header
4. **Include retry information**: `Retry-After` when rate limited
5. **Make headers machine-readable**: Easy for clients to parse
6. **Document headers**: In API documentation
7. **Test header correctness**: Ensure calculations are accurate

**Client-side handling examples:**

**JavaScript client:**
```javascript
async function makeRequest() {
  const response = await fetch('/api/data');
  
  if (response.status === 429) {
    const retryAfter = response.headers.get('Retry-After');
    const limit = response.headers.get('RateLimit-Limit');
    const remaining = response.headers.get('RateLimit-Remaining');
    
    console.log(`Rate limited. Limit: ${limit}, Remaining: ${remaining}, Retry after: ${retryAfter}s`);
    
    // Wait and retry
    await new Promise(resolve => setTimeout(resolve, retryAfter * 1000));
    return makeRequest();
  }
  
  return response.json();
}
```

**API client library:**
```javascript
class APIClient {
  constructor() {
    this.rateLimit = {
      limit: null,
      remaining: null,
      reset: null
    };
  }
  
  async request(endpoint) {
    const response = await fetch(endpoint);
    
    // Update rate limit info
    this.rateLimit.limit = response.headers.get('RateLimit-Limit');
    this.rateLimit.remaining = response.headers.get('RateLimit-Remaining');
    this.rateLimit.reset = response.headers.get('RateLimit-Reset');
    
    if (response.status === 429) {
      this.handleRateLimit(response);
    }
    
    return response;
  }
  
  handleRateLimit(response) {
    const retryAfter = response.headers.get('Retry-After');
    // Implement retry logic or notify user
  }
}
```

**Monitoring and analytics:**
```javascript
// Log rate limit header usage
app.use((req, res, next) => {
  const oldSend = res.send;
  res.send = function(data) {
    if (res.statusCode === 429) {
      console.log('Rate limit hit:', {
        ip: req.ip,
        endpoint: req.path,
        limit: res.get('RateLimit-Limit'),
        remaining: res.get('RateLimit-Remaining'),
        reset: res.get('RateLimit-Reset'),
        timestamp: new Date().toISOString()
      });
    }
    oldSend.apply(res, arguments);
  };
  next();
});
```

**Common header mistakes to avoid:**

1. **Incorrect reset times**: Using wrong timestamp format
2. **Missing headers**: Not including all relevant headers
3. **Inconsistent policies**: Different headers for same endpoint
4. **No documentation**: Clients don't know how to interpret headers
5. **Not updating remaining**: Headers show wrong count
6. **Ignoring timezone**: Reset times in wrong timezone

**Advanced header features:**

**Dynamic policies:**
```javascript
res.set('RateLimit-Policy', `${limit};w=${window};burst=${burstAllowance}`);
```

**Multiple policies:**
```javascript
res.set('RateLimit-Policy', [
  '100;w=60',    // 100 requests per minute
  '1000;w=3600'  // 1000 requests per hour
].join(', '));
```

**Custom metadata:**
```javascript
res.set('X-RateLimit-Tier', 'free');
res.set('X-RateLimit-Upgrade-URL', 'https://example.com/upgrade');
```

**Remember:** Good rate limit headers turn rate limiting from a frustrating restriction into a transparent system that clients can understand and work with effectively.

---

#### 5. How do you implement different rate limits for different endpoints?

**Answer:**

**Different rate limits for different endpoints** is essential because not all endpoints have the same resource requirements, security sensitivity, or usage patterns.

**Implementation strategies:**

**1. Route-specific middleware:**
```javascript
const rateLimit = require('express-rate-limit');

// Authentication endpoints (strict)
const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 5, // 5 attempts
  message: 'Too many login attempts'
});

// API endpoints (moderate)
const apiLimiter = rateLimit({
  windowMs: 60 * 1000, // 1 minute
  max: 60, // 60 requests
  message: 'API rate limit exceeded'
});

// Public endpoints (generous)
const publicLimiter = rateLimit({
  windowMs: 60 * 1000,
  max: 100,
  message: 'Please slow down'
});

// Administrative endpoints (very strict)
const adminLimiter = rateLimit({
  windowMs: 60 * 1000,
  max: 10,
  message: 'Admin rate limit',
  skip: (req) => req.ip === '127.0.0.1' // Allow localhost
});

// Apply to specific routes
app.post('/login', authLimiter, loginController);
app.post('/register', authLimiter, registerController);
app.use('/api/', apiLimiter);
app.use('/public/', publicLimiter);
app.use('/admin/', adminLimiter);
```

**2. Dynamic rate limiting based on endpoint characteristics:**
```javascript
const dynamicLimiter = (req, res, next) => {
  const endpointConfig = {
    '/api/login': { windowMs: 900000, max: 5 },    // 15 min, 5 attempts
    '/api/register': { windowMs: 3600000, max: 3 }, // 1 hour, 3 attempts
    '/api/search': { windowMs: 60000, max: 30 },    // 1 min, 30 requests
    '/api/upload': { windowMs: 60000, max: 10 },    // 1 min, 10 uploads
    '/api/download': { windowMs: 60000, max: 5 },   // 1 min, 5 downloads
    default: { windowMs: 60000, max: 60 }           // 1 min, 60 requests
  };
  
  const config = endpointConfig[req.path] || endpointConfig.default;
  
  // Apply rate limiting with dynamic config
  const limiter = rateLimit(config);
  limiter(req, res, next);
};

app.use('/api/', dynamicLimiter);
```

**3. Tiered rate limiting by user role:**
```javascript
const roleBasedLimiter = rateLimit({
  windowMs: 60 * 1000, // 1 minute
  max: (req) => {
    if (!req.user) return 10; // Unauthenticated
    
    switch(req.user.role) {
      case 'admin': return 1000;
      case 'premium': return 500;
      case 'user': return 100;
      case 'guest': return 50;
      default: return 10;
    }
  },
  keyGenerator: (req) => req.user?.id || req.ip,
  message: (req) => {
    const role = req.user?.role || 'guest';
    return `${role} rate limit exceeded`;
  }
});

app.use('/api/protected', authenticate, roleBasedLimiter);
```

**4. Resource-based rate limiting:**
```javascript
const resourceLimiter = (resourceType) => {
  const limits = {
    'user': { windowMs: 60000, max: 100 },   // User operations
    'product': { windowMs: 60000, max: 200 }, // Product operations
    'order': { windowMs: 60000, max: 50 },    // Order operations
    'payment': { windowMs: 60000, max: 20 }   // Payment operations
  };
  
  const config = limits[resourceType] || limits.user;
  return rateLimit(config);
};

// Apply to resource-based routes
app.get('/api/users', resourceLimiter('user'), getUsers);
app.get('/api/products', resourceLimiter('product'), getProducts);
app.post('/api/orders', resourceLimiter('order'), createOrder);
app.post('/api/payments', resourceLimiter('payment'), processPayment);
```

**5. Cost-based rate limiting (for expensive operations):**
```javascript
const costBasedLimiter = rateLimit({
  windowMs: 60 * 1000,
  max: (req) => {
    // Estimate operation cost
    const endpointCost = {
      '/api/simple-query': 1,
      '/api/complex-report': 10,
      '/api/batch-process': 50,
      '/api/ml-prediction': 100
    };
    
    const cost = endpointCost[req.path] || 1;
    const userLimit = getUserLimit(req.user); // e.g., 1000 points/minute
    
    return Math.floor(userLimit / cost);
  },
  keyGenerator: (req) => req.user?.id || req.ip,
  skip: (req) => req.path === '/api/health' // Skip health checks
});
```

**Complete implementation example:**
```javascript
const express = require('express');
const rateLimit = require('express-rate-limit');
const RedisStore = require('rate-limit-redis');
const Redis = require('ioredis');

const app = express();
const redis = new Redis();

// Store for rate limit data
const store = new RedisStore({
  sendCommand: (...args) => redis.call(...args),
});

// Endpoint classification
const endpointCategories = {
  // Authentication (very strict)
  auth: {
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 5,
    message: 'Too many authentication attempts'
  },
  
  // Public API (moderate)
  public: {
    windowMs: 60 * 1000, // 1 minute
    max: 60,
    message: 'Public API rate limit exceeded'
  },
  
  // Private API (generous for authenticated users)
  private: {
    windowMs: 60 * 1000,
    max: (req) => req.user?.premium ? 500 : 100,
    keyGenerator: (req) => req.user?.id || req.ip,
    message: 'Private API rate limit exceeded'
  },
  
  // Administrative (strict but bypass for local)
  admin: {
    windowMs: 60 * 1000,
    max: 20,
    skip: (req) => req.ip === '127.0.0.1',
    message: 'Admin API rate limit exceeded'
  },
  
  // File operations (strict due to resource usage)
  files: {
    windowMs: 60 * 1000,
    max: 10,
    message: 'File operation rate limit exceeded'
  },
  
  // Webhooks (very generous for external services)
  webhooks: {
    windowMs: 60 * 1000,
    max: 1000,
    message: 'Webhook rate limit exceeded'
  }
};

// Create limiters for each category
const limiters = {};
Object.entries(endpointCategories).forEach(([category, config]) => {
  limiters[category] = rateLimit({
    store,
    ...config,
    standardHeaders: true,
    legacyHeaders: false
  });
});

// Route categorization middleware
app.use((req, res, next) => {
  // Determine category based on route
  if (req.path.startsWith('/auth/')) {
    req.rateLimitCategory = 'auth';
  } else if (req.path.startsWith('/api/admin/')) {
    req.rateLimitCategory = 'admin';
  } else if (req.path.startsWith('/api/files/')) {
    req.rateLimitCategory = 'files';
  } else if (req.path.startsWith('/webhooks/')) {
    req.rateLimitCategory = 'webhooks';
  } else if (req.path.startsWith('/api/') && req.user) {
    req.rateLimitCategory = 'private';
  } else if (req.path.startsWith('/api/')) {
    req.rateLimitCategory = 'public';
  } else {
    req.rateLimitCategory = 'public'; // Default
  }
  
  next();
});

// Apply rate limiting based on category
app.use((req, res, next) => {
  const limiter = limiters[req.rateLimitCategory];
  if (limiter) {
    limiter(req, res, next);
  } else {
    next();
  }
});

// Define routes
app.post('/auth/login', (req, res) => { /* login logic */ });
app.post('/auth/register', (req, res) => { /* register logic */ });
app.get('/api/public/data', (req, res) => { /* public data */ });
app.get('/api/private/data', authenticate, (req, res) => { /* private data */ });
app.post('/api/files/upload', authenticate, (req, res) => { /* upload */ });
app.post('/webhooks/stripe', (req, res) => { /* webhook */ });
app.get('/api/admin/users', authenticate, isAdmin, (req, res) => { /* admin */ });
```

**Best practices for endpoint-specific rate limiting:**

1. **Classify endpoints by sensitivity**: Authentication vs public data
2. **Consider resource usage**: CPU-intensive operations need stricter limits
3. **Account for user roles**: Different limits for different user types
4. **Monitor and adjust**: Based on actual usage patterns
5. **Document limits**: Clear documentation for API consumers
6. **Provide upgrade paths**: For users needing higher limits
7. **Test thoroughly**: Ensure limits don't break functionality
8. **Log limit hits**: For security monitoring and adjustment

**Monitoring and analytics:**
```javascript
// Track rate limit hits by endpoint
app.use((req, res, next) => {
  const oldSend = res.send;
  res.send = function(data) {
    if (res.statusCode === 429) {
      analytics.track('rate_limit_hit', {
        endpoint: req.path,
        category: req.rateLimitCategory,
        ip: req.ip,
        user: req.user?.id,
        timestamp: new Date().toISOString()
      });
    }
    oldSend.apply(res, arguments);
  };
  next();
});
```

**Common patterns:**

**Pattern 1: Stricter limits for state-changing operations**
- GET: 100/minute
- POST: 50/minute
- PUT/DELETE: 20/minute

**Pattern 2: Time-based limits**
- Business hours: Stricter limits
- Off-hours: More generous limits

**Pattern 3: Geographic limits**
- High-risk regions: Stricter limits
- Trusted regions: More generous limits

**Pattern 4: Adaptive limits**
- Normal traffic: Standard limits
- Attack detection: Temporary stricter limits

**Remember:** The goal of endpoint-specific rate limiting is to protect resources while allowing legitimate usage. Well-designed rate limits are transparent to normal users but effective against abuse.

---

## 37. Input Validation & Sanitization

#### 1. Why is input validation important?

**Answer:**

**Input validation** is the process of checking user-provided data to ensure it meets expected criteria before processing. It's a critical security measure that prevents malicious data from entering your application.

**Why it's important:**

1. **Security**: Prevents injection attacks (SQL, NoSQL, XSS, command injection)
2. **Data integrity**: Ensures data conforms to expected format and type
3. **System stability**: Prevents crashes from unexpected data types
4. **User experience**: Provides immediate feedback on invalid input
5. **Business logic**: Enforces business rules and constraints

**Real-world example:** A banking application without proper validation allowed users to enter negative amounts for transfers, enabling them to steal money by transferring negative amounts to their accounts.

**Consequences of poor validation:**
- **SQL injection**: Attackers can read/modify/delete database data
- **XSS attacks**: Malicious scripts execute in users' browsers
- **Buffer overflows**: Can crash applications or execute arbitrary code
- **Business logic bypass**: Users can manipulate application behavior

**Defense in depth:** Input validation is the first layer of defense, but should be combined with other security measures like output encoding, proper authentication, and least privilege access.

---

#### 2. How do you validate request data in Express?

**Answer:**

**Express provides several approaches for request data validation:**

**1. Manual validation in route handlers:**
```javascript
app.post('/register', (req, res) => {
  const { email, password, age } = req.body;
  
  // Basic validation
  if (!email || !email.includes('@')) {
    return res.status(400).json({ error: 'Invalid email' });
  }
  
  if (!password || password.length < 8) {
    return res.status(400).json({ error: 'Password too short' });
  }
  
  if (age && (age < 18 || age > 100)) {
    return res.status(400).json({ error: 'Invalid age' });
  }
  
  // Process valid data
});
```

**2. Middleware-based validation:**
```javascript
const validateUser = (req, res, next) => {
  const errors = [];
  
  if (!req.body.email) errors.push('Email required');
  if (!req.body.password) errors.push('Password required');
  if (req.body.password && req.body.password.length < 8) {
    errors.push('Password must be at least 8 characters');
  }
  
  if (errors.length > 0) {
    return res.status(400).json({ errors });
  }
  
  next();
};

app.post('/register', validateUser, registerController);
```

**3. Schema-based validation (recommended):**
Using libraries like Joi or express-validator that define validation schemas.

**Best practices:**
- **Validate early**: Validate as soon as data enters your application
- **Validate on server**: Never trust client-side validation alone
- **Return clear errors**: Help users understand what's wrong
- **Log validation failures**: For security monitoring
- **Validate all input sources**: Body, query params, headers, cookies

**Real-world example:** Twitter's registration form validates email format, password strength, username availability, and age requirements before creating an account.

---

#### 3. What are the popular validation libraries (Joi, express-validator)?

**Answer:**

**Joi (Object schema validation):**
- **Purpose**: Schema description language and validator for JavaScript objects
- **Strengths**: Rich validation rules, readable schemas, async validation
- **Use case**: Complex validation scenarios, configuration validation

```javascript
const Joi = require('joi');

const userSchema = Joi.object({
  email: Joi.string().email().required(),
  password: Joi.string().min(8).required(),
  age: Joi.number().min(18).max(100),
  role: Joi.string().valid('user', 'admin').default('user')
});

const { error, value } = userSchema.validate(req.body);
```

**express-validator (Express middleware):**
- **Purpose**: Set of express.js middlewares that wraps validator.js
- **Strengths**: Express integration, sanitization features, chainable API
- **Use case**: Request validation in Express applications

```javascript
const { body, validationResult } = require('express-validator');

app.post('/register', 
  body('email').isEmail().normalizeEmail(),
  body('password').isLength({ min: 8 }),
  body('age').optional().isInt({ min: 18, max: 100 }),
  (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    // Process valid data
  }
);
```

**Other popular libraries:**
- **Yup**: Schema validation for forms and objects
- **Validator.js**: String validation and sanitization
- **Ajv**: JSON schema validator (fastest)
- **Class-validator**: Decorator-based validation for TypeScript

**Choosing the right library:**
- **Simple validation**: express-validator or validator.js
- **Complex schemas**: Joi or Yup
- **JSON schemas**: Ajv
- **TypeScript projects**: class-validator
- **Form validation**: Yup (React forms) or Joi

**Real-world example:** GitHub's API uses JSON schema validation to ensure all API requests meet expected formats before processing.

---

#### 4. How do you sanitize user input?

**Answer:**

**Sanitization** is the process of cleaning user input to remove potentially harmful content while preserving the intended data.

**Common sanitization techniques:**

**1. HTML sanitization (prevent XSS):**
```javascript
// Using DOMPurify library
const DOMPurify = require('dompurify');
const cleanHTML = DOMPurify.sanitize(userInput);

// Removes: <script>, <iframe>, on* attributes, javascript: URLs
// Keeps: Safe HTML like <b>, <i>, <a> with safe href
```

**2. SQL sanitization (prevent injection):**
```javascript
// Using parameterized queries (NOT string concatenation)
// BAD: `SELECT * FROM users WHERE email = '${email}'`
// GOOD: `SELECT * FROM users WHERE email = ?` with [email] as parameter
```

**3. NoSQL sanitization:**
```javascript
// Convert user input to expected types
const userId = mongoose.Types.ObjectId(req.params.id); // MongoDB
// Prevents: { $ne: null } injection attacks
```

**4. Path traversal prevention:**
```javascript
// Prevent directory traversal attacks
const safePath = path.normalize(userInput).replace(/^(\.\.(\/|\\|$))+/, '');
// Prevents: ../../../etc/passwd attacks
```

**5. Command injection prevention:**
```javascript
// Never use user input directly in shell commands
// BAD: exec(`rm ${userFile}`)
// GOOD: Use safe APIs or validate/sanitize input
```

**express-validator sanitization examples:**
```javascript
const { body } = require('express-validator');

app.post('/comment',
  body('content')
    .trim() // Remove whitespace
    .escape() // Convert HTML to entities
    .stripLow() // Remove control characters
    .blacklist('<>[]{}'), // Remove specific characters
  (req, res) => {
    // req.body.content is now sanitized
  }
);
```

**Real-world example:** A comment system sanitizes HTML input to allow basic formatting (bold, italics, links) while preventing script injection that could steal user cookies.

**Sanitization vs Validation:**
- **Validation**: Checks if data meets criteria (rejects if not)
- **Sanitization**: Transforms data to make it safe (keeps but cleans)

**Best practices:**
- **Sanitize based on context**: HTML context needs different sanitization than SQL context
- **Use established libraries**: Don't write custom sanitizers for complex cases
- **Sanitize before storage**: Clean data before saving to database
- **Also sanitize on output**: Defense in depth approach

---

#### 5. What is the difference between validation and sanitization?

**Answer:**

**Validation** and **sanitization** are complementary security measures with different purposes:

| Aspect | Validation | Sanitization |
|--------|------------|--------------|
| **Purpose** | Check if data is valid | Make data safe |
| **Action** | Accept or reject | Transform or clean |
| **When** | Before processing | Before storage/display |
| **Result** | Boolean (valid/invalid) | Modified data |
| **Example** | Email format check | Remove HTML tags |

**Validation examples:**
- Email must contain "@" symbol
- Password must be 8+ characters
- Age must be between 18-100
- Username must be alphanumeric

**Sanitization examples:**
- Convert `<script>alert('xss')</script>` to `&lt;script&gt;alert('xss')&lt;/script&gt;`
- Remove null bytes from filenames
- Trim whitespace from strings
- Convert special characters to HTML entities

**Real-world analogy:**
- **Validation**: Checking ID at a bar (rejects underage)
- **Sanitization**: Sanitizing hands before surgery (cleans but keeps)

**When to use each:**

**Use validation when:**
- Data must meet specific criteria
- Business rules must be enforced
- You need to reject invalid data
- Example: Registration form validation

**Use sanitization when:**
- Data will be used in dangerous contexts (HTML, SQL, shell)
- You want to preserve user input but make it safe
- Data needs cleaning but not rejection
- Example: Comment system allowing HTML formatting

**Combined approach (recommended):**
```javascript
// 1. Validate (check format)
if (!isValidEmail(email)) {
  return error('Invalid email');
}

// 2. Sanitize (make safe)
const safeEmail = sanitizeEmail(email);

// 3. Use safely
saveToDatabase(safeEmail);
```

**Real-world example:** A hotel booking system:
- **Validation**: Checks dates are valid (not in past, check-in before check-out)
- **Sanitization**: Escapes special characters in guest names to prevent SQL injection

**Key principle:** Validate for correctness, sanitize for safety. Always validate before sanitizing, as sanitization can sometimes make invalid data appear valid.

---
## 38. SQL/NoSQL Injection Prevention

#### 1. What is SQL injection and how do you prevent it?

**Answer:**

**SQL injection** is a code injection technique where attackers insert malicious SQL statements into input fields, allowing them to execute arbitrary SQL commands on the database.

**How it works:**
```sql
-- User input: ' OR '1'='1
-- Original query: SELECT * FROM users WHERE email = '[email]' AND password = '[password]'
-- Resulting query: SELECT * FROM users WHERE email = '' OR '1'='1' AND password = '[password]'
-- Returns all users because '1'='1' is always true
```

**Real-world example:** In 2019, a major hotel chain suffered a SQL injection attack that exposed 500 million customer records including passport numbers and credit card details.

**Prevention techniques:**

**1. Parameterized queries (prepared statements):**
```javascript
// BAD: String concatenation (vulnerable)
db.query(`SELECT * FROM users WHERE email = '${email}'`);

// GOOD: Parameterized query (safe)
db.query('SELECT * FROM users WHERE email = ?', [email]);
```

**2. Stored procedures:**
```sql
-- Define in database
CREATE PROCEDURE GetUserByEmail(@email VARCHAR(255))
AS
BEGIN
  SELECT * FROM users WHERE email = @email;
END

-- Call from application
db.execute('EXEC GetUserByEmail @email = ?', [email]);
```

**3. ORM/ODM usage:**
```javascript
// Using Sequelize (SQL ORM)
User.findOne({ where: { email: email } });

// Using Mongoose (MongoDB ODM)
User.findOne({ email: email });
```

**4. Input validation and sanitization:**
- Validate email format
- Reject SQL keywords in input
- Use allowlists for expected values

**5. Least privilege principle:**
- Database users should have minimal necessary permissions
- Use read-only accounts for queries
- Separate application accounts from admin accounts

**6. Regular security testing:**
- Use SQL injection scanners
- Conduct penetration testing
- Monitor for unusual query patterns

**Real-world defense:** GitHub uses parameterized queries exclusively and conducts regular security audits to prevent SQL injection vulnerabilities.

---

#### 2. How do you prevent NoSQL injection in MongoDB?

**Answer:**

**NoSQL injection** attacks exploit vulnerabilities in NoSQL databases by injecting malicious queries through user input.

**Common MongoDB injection vectors:**

**1. Operator injection:**
```javascript
// User input: { "$ne": null }
// Query becomes: db.users.find({ username: { "$ne": null } })
// Returns all users instead of specific user
```

**2. JavaScript injection:**
```javascript
// User input: "'; while(true) {} '"
// In $where clauses: db.users.find({ $where: "this.username == '" + userInput + "'" })
// Can cause denial of service or data exposure
```

**Prevention techniques:**

**1. Type conversion and validation:**
```javascript
// Convert string to ObjectId
const userId = mongoose.Types.ObjectId(req.params.id);
User.findById(userId);

// Validate expected types
if (typeof req.body.age !== 'number') {
  return res.status(400).json({ error: 'Age must be a number' });
}
```

**2. Avoid dangerous operators:**
```javascript
// BAD: Using $where with user input
User.find({ $where: `this.email == '${email}'` });

// GOOD: Use standard query operators
User.find({ email: email });
```

**3. Use Mongoose schema validation:**
```javascript
const userSchema = new mongoose.Schema({
  email: { type: String, required: true, match: /.+\@.+\..+/ },
  age: { type: Number, min: 18, max: 100 }
});
// Mongoose validates before query execution
```

**4. Sanitize query operators:**
```javascript
const sanitizeQuery = (query) => {
  const allowedOperators = ['$eq', '$gt', '$lt', '$in', '$nin'];
  const sanitized = {};
  
  Object.keys(query).forEach(key => {
    if (typeof query[key] === 'object') {
      sanitized[key] = {};
      Object.keys(query[key]).forEach(op => {
        if (allowedOperators.includes(op)) {
          sanitized[key][op] = query[key][op];
        }
      });
    } else {
      sanitized[key] = query[key];
    }
  });
  
  return sanitized;
};
```

**5. Use aggregation pipeline safely:**
```javascript
// BAD: User controls pipeline stages
const pipeline = JSON.parse(userInput);
User.aggregate(pipeline);

// GOOD: Validate pipeline structure
const safePipeline = validateAggregationPipeline(userInput);
```

**Real-world example:** A popular MEAN stack application was vulnerable to NoSQL injection allowing attackers to bypass authentication by sending `{ "$ne": null }` as password.

**MongoDB security features:**
- **Role-based access control**: Limit database permissions
- **Field-level encryption**: Protect sensitive data
- **Audit logging**: Monitor query patterns
- **Network encryption**: TLS for data in transit

**Best practices:**
- Never trust user input in queries
- Use Mongoose or similar ODM
- Validate all query parameters
- Implement proper authentication
- Regular security updates

---

#### 3. What are parameterized queries?

**Answer:**

**Parameterized queries** (also called prepared statements) are database queries where user input is passed as parameters rather than concatenated into the query string. This separates SQL code from data, preventing injection attacks.

**How they work:**
```javascript
// UNSAFE: String concatenation
const query = `SELECT * FROM users WHERE email = '${email}' AND password = '${password}'`;

// SAFE: Parameterized query
const query = 'SELECT * FROM users WHERE email = ? AND password = ?';
const params = [email, password];
db.execute(query, params);
```

**Benefits:**

1. **Security**: Prevents SQL injection by separating code from data
2. **Performance**: Database can cache execution plans for repeated queries
3. **Readability**: Clear separation between query structure and data
4. **Type safety**: Database handles type conversion appropriately

**Implementation in different databases:**

**MySQL with mysql2:**
```javascript
const [rows] = await connection.execute(
  'SELECT * FROM users WHERE email = ? AND age > ?',
  [email, minAge]
);
```

**PostgreSQL with pg:**
```javascript
const result = await pool.query(
  'SELECT * FROM users WHERE email = $1 AND age > $2',
  [email, minAge]
);
```

**SQLite with better-sqlite3:**
```javascript
const stmt = db.prepare('SELECT * FROM users WHERE email = ? AND age > ?');
const user = stmt.get(email, minAge);
```

**MongoDB (concept similar):**
```javascript
// MongoDB doesn't have traditional parameterized queries
// but similar safety comes from proper query construction
User.find({ email: email, age: { $gt: minAge } });
```

**Real-world example:** All major banks use parameterized queries exclusively for financial transactions to prevent injection attacks that could manipulate account balances.

**How parameterization prevents injection:**
1. Query structure is fixed at prepare time
2. User input is treated as data, not code
3. Database engine handles escaping automatically
4. Even malicious input can't change query meaning

**Common misconceptions:**
- **Myth**: Escaping is enough (it's error-prone)
- **Myth**: Stored procedures prevent injection (they can still be vulnerable if not used properly)
- **Myth**: ORMs are always safe (they can be misused)

**Best practices:**
- Use parameterized queries for ALL database queries
- Never build queries with string concatenation
- Use ORMs that support parameterization
- Validate input even with parameterized queries
- Log and monitor query execution

---

#### 4. How do you sanitize user input for database queries?

**Answer:**

**Database query sanitization** involves cleaning user input specifically for use in database operations to prevent injection attacks.

**Levels of sanitization:**

**1. Input validation (first line of defense):**
```javascript
// Validate format and type
if (!isValidEmail(email)) {
  throw new Error('Invalid email format');
}

if (typeof age !== 'number' || age < 0 || age > 150) {
  throw new Error('Invalid age');
}
```

**2. Type conversion:**
```javascript
// Convert to expected types
const userId = parseInt(req.params.id, 10);
const price = parseFloat(req.body.price);
const isActive = Boolean(req.body.active);
const date = new Date(req.body.date);

// MongoDB ObjectId conversion
const objectId = mongoose.Types.ObjectId(id);
```

**3. Escape special characters:**
```javascript
// For LIKE queries (SQL)
const searchTerm = userInput.replace(/%/g, '\\%').replace(/_/g, '\\_');
// Prevents: % matching everything

// For JSON queries
const safeJson = JSON.stringify(userInput)
  .replace(/\\/g, '\\\\')
  .replace(/'/g, "\\'");
```

**4. Use query builders/ORMs:**
```javascript
// Sequelize (SQL)
User.findAll({
  where: {
    email: { [Op.eq]: email },
    age: { [Op.gt]: minAge }
  }
});

// Mongoose (MongoDB)
User.find({
  email: email,
  age: { $gt: minAge }
}).select('name email -_id'); // Explicit field selection
```

**5. Implement allowlists:**
```javascript
// For sort fields
const allowedSortFields = ['name', 'email', 'createdAt'];
const sortField = allowedSortFields.includes(req.query.sort) 
  ? req.query.sort 
  : 'createdAt';

// For filter operators
const allowedOperators = ['eq', 'gt', 'lt', 'in'];
const operator = allowedOperators.includes(req.query.op)
  ? req.query.op
  : 'eq';
```

**6. Sanitize for specific database types:**

**SQL databases:**
- Use parameterized queries
- Escape wildcards for LIKE
- Validate numeric ranges
- Sanitize table/column names

**MongoDB:**
- Convert strings to ObjectId
- Validate query operators
- Sanitize aggregation pipelines
- Use projection to limit returned fields

**Redis:**
- Validate key patterns
- Sanitize Lua scripts
- Limit command execution

**Real-world example:** An e-commerce site sanitizes search terms to prevent users from using wildcards to access all products, which could overload the database.

**Sanitization libraries:**
- **express-validator**: For request data sanitization
- **validator.js**: String sanitization functions
- **DOMPurify**: For HTML content (if storing HTML)
- **xss**: Cross-site scripting prevention

**Best practices:**
- **Sanitize early**: As close to input as possible
- **Context-aware**: Different sanitization for different contexts
- **Defense in depth**: Multiple layers of protection
- **Log sanitization failures**: For security monitoring
- **Regular testing**: Test with malicious inputs

**Remember:** Sanitization complements but doesn't replace parameterized queries. Always use both for maximum security.

---

#### 5. What are the common injection attack vectors?

**Answer:**

**Injection attack vectors** are the entry points through which attackers can inject malicious code into applications. Understanding these helps in implementing proper defenses.

**Common injection vectors:**

**1. Web forms and inputs:**
- Login forms (username/password)
- Search boxes
- Comment fields
- Contact forms
- File upload fields

**Example:** Attackers inject SQL into login form to bypass authentication.

**2. URL parameters:**
```javascript
// Vulnerable: /api/users?id=1 OR 1=1
app.get('/api/users', (req, res) => {
  db.query(`SELECT * FROM users WHERE id = ${req.query.id}`);
});
```

**3. HTTP headers:**
- User-Agent (can contain SQL or JavaScript)
- Referer header
- Custom headers (X-Forwarded-For, etc.)

**4. Cookies:**
- Session cookies manipulated to contain malicious code
- Authentication tokens with injection payloads

**5. File uploads:**
- Malicious files with executable code
- File names containing injection payloads
- File metadata manipulation

**6. API requests:**
- JSON payloads with malicious content
- GraphQL queries with injection
- REST parameters in URLs and bodies

**7. Third-party integrations:**
- Webhook payloads from external services
- OAuth callback parameters
- Payment gateway responses

**8. Database fields:**
- Stored XSS in user profiles
- Malicious content in product descriptions
- Injection in configuration data

**Real-world attack examples:**

**1. SQL injection via search:**
- **Vector**: Search box accepting user input
- **Attack**: `' UNION SELECT username, password FROM users--`
- **Result**: Exposes all user credentials

**2. NoSQL injection via API:**
- **Vector**: REST API accepting JSON
- **Attack**: `{ "password": { "$ne": null } }`
- **Result**: Bypasses authentication

**3. Command injection via file upload:**
- **Vector**: File upload with filename parameter
- **Attack**: `file.png; rm -rf /`
- **Result**: Deletes server files if executed

**4. LDAP injection via login:**
- **Vector**: Corporate login form
- **Attack**: `*)(uid=*))(|(uid=*`
- **Result**: Bypasses directory authentication

**5. XML injection (XXE):**
- **Vector**: XML file upload/processing
- **Attack**: External entity references
- **Result**: File disclosure, SSRF attacks

**Defense strategies by vector:**

**For forms/inputs:**
- Input validation and sanitization
- Parameterized queries
- Content Security Policy (CSP)

**For URLs/headers:**
- Strict validation of all incoming data
- URL encoding/decoding
- Header whitelisting

**For file uploads:**
- File type verification
- Virus scanning
- Secure file storage

**For APIs:**
- Schema validation
- Rate limiting
- Authentication/authorization

**For databases:**
- Least privilege access
- Regular security updates
- Query logging and monitoring

**Real-world incident:** The 2017 Equifax breach exploited an Apache Struts vulnerability through injection vectors in web forms, exposing 147 million records.

**Detection and prevention:**
- **Web Application Firewalls (WAF)**: Detect and block injection attempts
- **Security scanners**: Regular vulnerability assessments
- **Code review**: Manual and automated security reviews
- **Monitoring**: Log analysis for suspicious patterns

**Key principle:** Assume all input is malicious until proven otherwise. Implement defense in depth with validation, sanitization, parameterized queries, and proper error handling.

---
## 39. XSS & CSRF Protection

#### 1. What is Cross-Site Scripting (XSS) and how do you prevent it?

**Answer:**

**Cross-Site Scripting (XSS)** is a security vulnerability that allows attackers to inject malicious scripts into web pages viewed by other users. These scripts execute in the victim's browser with the permissions of the web application.

**How XSS works:**
1. Attacker finds a vulnerable input field (comment, search, profile)
2. Injects malicious JavaScript: `<script>stealCookies()</script>`
3. Victim views page containing the malicious script
4. Script executes in victim's browser, stealing data or performing actions

**Types of XSS:**

**1. Stored XSS (Persistent):**
- Malicious script stored on server (database, files)
- Executes for every user viewing the affected page
- **Example**: Malicious comment on a blog post

**2. Reflected XSS (Non-persistent):**
- Script reflected from current request
- Often via URL parameters or form submissions
- **Example**: Search results page echoing search term

**3. DOM-based XSS:**
- Client-side vulnerability in JavaScript code
- Script modifies DOM directly
- **Example**: `document.write(userControlledData)`

**Real-world example:** In 2018, British Airways suffered an XSS attack through their website's baggage claim form, stealing payment card details from 380,000 customers.

**Prevention techniques:**

**1. Input validation and sanitization:**
```javascript
// Sanitize HTML input
const cleanHTML = DOMPurify.sanitize(userInput);
// Removes <script>, on* attributes, javascript: URLs
```

**2. Output encoding:**
```javascript
// Encode for HTML context
const encoded = userInput
  .replace(/&/g, '&amp;')
  .replace(/</g, '&lt;')
  .replace(/>/g, '&gt;')
  .replace(/"/g, '&quot;')
  .replace(/'/g, '&#x27;');
```

**3. Content Security Policy (CSP):**
```http
Content-Security-Policy: default-src 'self'; script-src 'self' https://trusted.cdn.com
```
- Restricts sources for scripts, styles, images
- Prevents inline script execution
- Reports violations for monitoring

**4. HttpOnly cookies:**
```javascript
res.cookie('session', token, {
  httpOnly: true, // Not accessible via JavaScript
  secure: true,   // HTTPS only
  sameSite: 'strict'
});
```

**5. Framework protections:**
- React: Automatically escapes content in JSX
- Angular: Built-in sanitization
- Vue.js: Text interpolation escapes HTML

**6. Regular security testing:**
- XSS scanners (OWASP ZAP, Burp Suite)
- Manual penetration testing
- Code review for XSS vulnerabilities

**Real-world defense:** GitHub uses strict CSP headers, automatic escaping in templates, and regular security audits to prevent XSS attacks.

**Best practices:**
- **Never trust user input**: Validate and sanitize everything
- **Context-aware encoding**: Different contexts need different encoding
- **Use security headers**: CSP, X-XSS-Protection
- **Keep software updated**: Libraries, frameworks, browsers
- **Educate developers**: Security training and awareness

**Remember:** XSS prevention requires a multi-layered approach combining input validation, output encoding, security headers, and secure coding practices.

---

#### 2. What is Cross-Site Request Forgery (CSRF) and how do you prevent it?

**Answer:**

**Cross-Site Request Forgery (CSRF)** is an attack that tricks users into performing unwanted actions on a web application where they're authenticated. The attacker forces the victim's browser to make requests to a vulnerable site.

**How CSRF works:**
1. User logs into `bank.com` (gets session cookie)
2. User visits malicious site `evil.com`
3. `evil.com` contains: `<img src="https://bank.com/transfer?to=attacker&amount=1000">`
4. Browser automatically sends request with user's session cookie
5. Bank processes transfer thinking it's legitimate user request

**Real-world example:** In 2008, a CSRF vulnerability in Netflix allowed attackers to change shipping addresses and add items to rental queues without user consent.

**Prevention techniques:**

**1. CSRF tokens (synchronizer tokens):**
```javascript
// Generate token on server
const csrfToken = crypto.randomBytes(32).toString('hex');
req.session.csrfToken = csrfToken;

// Include in forms
<form action="/transfer" method="POST">
  <input type="hidden" name="_csrf" value="<%= csrfToken %>">
  <!-- form fields -->
</form>

// Validate on server
app.post('/transfer', (req, res) => {
  if (req.body._csrf !== req.session.csrfToken) {
    return res.status(403).send('Invalid CSRF token');
  }
  // Process request
});
```

**2. SameSite cookies:**
```javascript
res.cookie('session', token, {
  sameSite: 'strict', // or 'lax'
  secure: true,
  httpOnly: true
});
```
- **strict**: Cookie not sent with cross-site requests
- **lax**: Cookie sent with safe top-level navigation (GET requests)

**3. Double submit cookies:**
```javascript
// Set random token in cookie
res.cookie('XSRF-TOKEN', token, { secure: true });

// Client sends token in header
fetch('/api/data', {
  headers: { 'X-XSRF-TOKEN': getCookie('XSRF-TOKEN') }
});
```

**4. Custom request headers:**
```javascript
// Require custom header for state-changing requests
app.use('/api', (req, res, next) => {
  if (['POST', 'PUT', 'DELETE'].includes(req.method)) {
    if (!req.headers['x-requested-with']) {
      return res.status(403).send('Missing custom header');
    }
  }
  next();
});
```

**5. Referer/Origin validation:**
```javascript
// Check request origin
const validOrigins = ['https://yourapp.com', 'https://app.yourapp.com'];
const origin = req.headers.origin || req.headers.referer;

if (!validOrigins.some(o => origin.startsWith(o))) {
  return res.status(403).send('Invalid origin');
}
```

**6. Re-authentication for sensitive actions:**
- Require password for financial transactions
- Use multi-factor authentication
- Implement confirmation dialogs

**Real-world defense:** Banks typically use multiple CSRF protections including tokens, SameSite cookies, and re-authentication for transfers.

**Best practices:**
- **Use framework solutions**: Express csurf, Django CSRF middleware
- **Protect all state-changing requests**: POST, PUT, DELETE, PATCH
- **Combine multiple defenses**: Defense in depth
- **Regular security testing**: CSRF vulnerability scanning
- **Educate users**: About phishing and safe browsing

**Remember:** CSRF exploits the trust a site has in a user's browser, not the user themselves. The key is ensuring requests originate from your application, not third-party sites.

---

#### 3. How do you implement CSRF protection in Express?

**Answer:**

**Express provides several approaches for CSRF protection, from manual implementation to using middleware libraries.**

**1. Using `csurf` middleware (deprecated but still used):**
```javascript
const csrf = require('csurf');
const cookieParser = require('cookie-parser');

// Configure CSRF protection
const csrfProtection = csrf({
  cookie: {
    key: '_csrf',
    secure: process.env.NODE_ENV === 'production',
    sameSite: 'strict',
    httpOnly: true
  }
});

// Apply middleware
app.use(cookieParser());
app.use(csrfProtection);

// Get token for views
app.get('/form', (req, res) => {
  res.render('form', { csrfToken: req.csrfToken() });
});

// Validate in POST requests
app.post('/process', (req, res) => {
  // CSRF validation happens automatically
  res.send('Form processed successfully');
});
```

**2. Manual CSRF token implementation:**
```javascript
const crypto = require('crypto');

// Generate and store token
app.use((req, res, next) => {
  if (!req.session.csrfToken) {
    req.session.csrfToken = crypto.randomBytes(32).toString('hex');
  }
  res.locals.csrfToken = req.session.csrfToken;
  next();
});

// Validate token middleware
const validateCSRF = (req, res, next) => {
  const token = req.body._csrf || req.headers['x-csrf-token'];
  
  if (!token || token !== req.session.csrfToken) {
    return res.status(403).json({
      error: 'Invalid CSRF token',
      message: 'This request may be forged'
    });
  }
  
  // Generate new token for next request
  req.session.csrfToken = crypto.randomBytes(32).toString('hex');
  next();
};

// Apply to state-changing routes
app.post('/api/transfer', validateCSRF, transferController);
app.put('/api/profile', validateCSRF, updateProfileController);
app.delete('/api/item', validateCSRF, deleteItemController);
```

**3. Double submit cookie pattern:**
```javascript
// Server-side setup
app.use((req, res, next) => {
  // Set CSRF token in cookie
  if (!req.cookies['XSRF-TOKEN']) {
    const token = crypto.randomBytes(32).toString('hex');
    res.cookie('XSRF-TOKEN', token, {
      secure: true,
      sameSite: 'strict'
    });
    req.csrfToken = token;
  } else {
    req.csrfToken = req.cookies['XSRF-TOKEN'];
  }
  next();
});

// Client-side (JavaScript)
fetch('/api/data', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-XSRF-TOKEN': getCookie('XSRF-TOKEN')
  },
  body: JSON.stringify(data)
});

// Server validation
app.use('/api', (req, res, next) => {
  if (['POST', 'PUT', 'DELETE', 'PATCH'].includes(req.method)) {
    const token = req.headers['x-xsrf-token'];
    const cookieToken = req.cookies['XSRF-TOKEN'];
    
    if (!token || token !== cookieToken) {
      return res.status(403).json({ error: 'CSRF validation failed' });
    }
  }
  next();
});
```

**4. Using `csrf-csrf` (modern alternative):**
```javascript
const { doubleCsrf } = require("csrf-csrf");
const { generateToken, doubleCsrfProtection } = doubleCsrf({
  getSecret: (req) => req.session.csrfSecret,
  cookieName: "_csrf",
  cookieOptions: { 
    secure: true,
    sameSite: "strict" 
  },
  size: 64,
  ignoredMethods: ["GET", "HEAD", "OPTIONS"],
});

// Apply protection
app.use(doubleCsrfProtection);

// Get token for client
app.get("/form", (req, res) => {
  const token = generateToken(req);
  res.render("form", { csrfToken: token });
});
```

**5. API-specific CSRF protection:**
```javascript
// For SPA/API applications
const apiCsrfProtection = (req, res, next) => {
  // Skip for safe methods
  if (['GET', 'HEAD', 'OPTIONS'].includes(req.method)) {
    return next();
  }
  
  // Check Origin/Referer headers
  const origin = req.headers.origin || req.headers.referer;
  const allowedOrigins = ['https://app.example.com', 'https://admin.example.com'];
  
  if (!origin || !allowedOrigins.some(o => origin.startsWith(o))) {
    return res.status(403).json({ error: 'Invalid request origin' });
  }
  
  // Check custom header (AJAX requests)
  if (!req.headers['x-requested-with'] === 'XMLHttpRequest') {
    return res.status(403).json({ error: 'Missing required header' });
  }
  
  next();
};

app.use('/api', apiCsrfProtection);
```

**Best practices for Express CSRF protection:**

1. **Use middleware**: Simplify implementation with tested libraries
2. **Protect all state-changing endpoints**: POST, PUT, DELETE, PATCH
3. **Exclude safe methods**: GET, HEAD, OPTIONS don't need protection
4. **Combine with SameSite cookies**: Additional layer of protection
5. **Regenerate tokens**: After use or periodically
6. **Handle token mismatch gracefully**: Clear error messages
7. **Test thoroughly**: Ensure protection doesn't break functionality
8. **Monitor for attacks**: Log CSRF validation failures

**Real-world example:** A popular Express-based e-commerce platform uses double submit cookies with SameSite strict cookies, protecting millions of transactions daily.

**Common pitfalls to avoid:**
- Not protecting API endpoints used by SPAs
- Storing tokens in localStorage (vulnerable to XSS)
- Using predictable tokens
- Not invalidating tokens after use
- Forgetting to exclude static assets

**Remember:** CSRF protection should be invisible to legitimate users while effectively blocking malicious requests. Proper implementation balances security with usability.

---

#### 4. What are the different types of XSS attacks?

**Answer:**

**XSS attacks are categorized based on how the malicious script is delivered and executed. Understanding the types helps in implementing targeted defenses.**

**1. Stored XSS (Persistent/Type I):**
- **How it works**: Malicious script permanently stored on server
- **Delivery**: Database, file system, cache, comments, user profiles
- **Impact**: Affects all users viewing infected content
- **Example**: `<script>sendCookiesToAttacker()</script>` in blog comment

**Real-world case**: Samy worm on MySpace (2005) - stored XSS that propagated to over 1 million users in 20 hours.

**2. Reflected XSS (Non-persistent/Type II):**
- **How it works**: Script reflected from current HTTP request
- **Delivery**: URL parameters, form submissions, search results
- **Impact**: Requires user to click malicious link
- **Example**: `https://site.com/search?q=<script>alert(1)</script>`

**Real-world case**: PayPal reflected XSS (2006) - allowed stealing session cookies via crafted URLs.

**3. DOM-based XSS (Type 0):**
- **How it works**: Client-side vulnerability in JavaScript code
- **Delivery**: URL fragments, client-side storage, DOM manipulation
- **Impact**: No server interaction needed
- **Example**: `document.write(location.hash.substring(1))`

**Real-world case**: Twitter DOM XSS (2010) - via t.co URL shortener affecting logged-in users.

**4. Blind XSS:**
- **How it works**: Stored XSS where output appears in admin panels
- **Delivery**: User input that only admins can see
- **Impact**: Compromise admin accounts and systems
- **Example**: Malicious script in support ticket viewed by admin

**Real-world case**: Blind XSS in helpdesk software allowing attacker access to admin panel.

**5. Self-XSS:**
- **How it works**: Requires user to paste malicious code into browser console
- **Delivery**: Social engineering ("paste this to unlock feature")
- **Impact**: Limited to users who follow instructions
- **Example**: "Copy this code to get free premium"

**6. Mutation-based XSS (mXSS):**
- **How it works**: Browsers mutate HTML in ways that bypass filters
- **Delivery**: Carefully crafted HTML that changes after parsing
- **Impact**: Bypasses common sanitization libraries
- **Example**: `<noscript><p title="</noscript><script>alert(1)</script>">`

**7. Flash-based XSS:**
- **How it works**: Exploits vulnerabilities in Flash Player
- **Delivery**: Malicious SWF files or ActionScript
- **Impact**: Less common since Flash deprecation

**Attack vectors by type:**

**For stored XSS:**
- Comment systems
- User profiles
- Product reviews
- Forum posts
- Chat messages

**For reflected XSS:**
- Search functionality
- Error messages
- Login forms
- Contact forms
- URL redirects

**For DOM-based XSS:**
- Client-side routing
- JavaScript frameworks
- Browser extensions
- LocalStorage usage
- URL hash manipulation

**Defense strategies by type:**

**Stored XSS prevention:**
- Input validation and sanitization
- Output encoding
- Content Security Policy
- Regular security audits

**Reflected XSS prevention:**
- URL parameter validation
- Reflected input encoding
- SameSite cookies
- User education about suspicious links

**DOM-based XSS prevention:**
- Safe DOM manipulation APIs
- Avoid `innerHTML`, `document.write`
- Use `textContent` instead of `innerHTML`
- Validate client-side data sources

**Real-world defense example:** Google uses a combination of automated scanning, manual code review, and strict CSP headers to protect against all XSS types across their products.

**Detection techniques:**
- **Automated scanners**: OWASP ZAP, Burp Suite
- **Manual testing**: Browser developer tools
- **Code analysis**: Static and dynamic analysis
- **Bug bounty programs**: Crowdsourced security testing

**Remember:** Different XSS types require different defense strategies. A comprehensive approach addresses all potential attack vectors through input validation, output encoding, secure coding practices, and security headers.

---

#### 5. How do you sanitize HTML content?

**Answer:**

**HTML sanitization** is the process of removing or neutralizing potentially dangerous elements and attributes from HTML content while preserving safe markup. It's essential when allowing user-generated HTML content.

**Why sanitize HTML:**
- Prevent XSS attacks
- Maintain content structure
- Allow safe formatting (bold, italics, links)
- Block malicious scripts and iframes

**Approaches to HTML sanitization:**

**1. Using DOMPurify (recommended):**
```javascript
const DOMPurify = require('dompurify');
const { JSDOM } = require('jsdom');

const window = new JSDOM('').window;
const purify = DOMPurify(window);

// Basic sanitization
const cleanHTML = purify.sanitize(dirtyHTML);

// Custom configuration
const cleanHTML = purify.sanitize(dirtyHTML, {
  ALLOWED_TAGS: ['b', 'i', 'em', 'strong', 'a', 'p', 'br'],
  ALLOWED_ATTR: ['href', 'title', 'target'],
  ALLOWED_URI_REGEXP: /^(?:(?:(?:f|ht)tps?|mailto|tel):|[^a-z]|[a-z+.\-]+(?:[^a-z+.\-:]|$))/i
});
```

**2. Using `xss` library:**
```javascript
const xss = require('xss');

const cleanHTML = xss(dirtyHTML, {
  whiteList: {
    a: ['href', 'title', 'target'],
    p: [],
    b: [],
    i: [],
    br: []
  },
  stripIgnoreTag: true, // Remove non-whitelisted tags
  stripIgnoreTagBody: ['script'] // Remove script content
});
```

**3. Using `sanitize-html`:**
```javascript
const sanitizeHtml = require('sanitize-html');

const cleanHTML = sanitizeHtml(dirtyHTML, {
  allowedTags: ['b', 'i', 'em', 'strong', 'a', 'p', 'h1', 'h2', 'h3'],
  allowedAttributes: {
    a: ['href', 'name', 'target'],
    '*': ['class']
  },
  allowedSchemes: ['http', 'https', 'mailto'],
  transformTags: {
    'a': (tagName, attribs) => {
      // Force external links to open in new tab
      if (attribs.href && !attribs.href.startsWith('/')) {
        attribs.target = '_blank';
        attribs.rel = 'noopener noreferrer';
      }
      return { tagName, attribs };
    }
  }
});
```

**4. Manual sanitization (not recommended for complex cases):**
```javascript
function sanitizeHTML(html) {
  // Remove script tags and content
  html = html.replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '');
  
  // Remove event handlers
  html = html.replace(/ on\w+="[^"]*"/g, '');
  html = html.replace(/ on\w+='[^']*'/g, '');
  html = html.replace(/ on\w+=\w+/g, '');
  
  // Remove javascript: URLs
  html = html.replace(/href="javascript:[^"]*"/gi, 'href="#"');
  html = html.replace(/href='javascript:[^']*'/gi, "href='#'");
  
  return html;
}
```

**5. Framework-specific sanitization:**

**React (dangerouslySetInnerHTML with sanitization):**
```javascript
import DOMPurify from 'dompurify';

function SafeHTML({ html }) {
  const cleanHTML = DOMPurify.sanitize(html);
  return <div dangerouslySetInnerHTML={{ __html: cleanHTML }} />;
}
```

**Angular (built-in sanitization):**
```html
<!-- Angular automatically sanitizes -->
<div [innerHTML]="userContent"></div>
```

**What to sanitize:**

**Remove/neutralize:**
- `<script>` tags and content
- `<iframe>`, `<embed>`, `<object>`
- Event handlers (`onclick`, `onload`, etc.)
- `javascript:` URLs
- Data URLs (`data:text/html`)
- CSS expressions and `style` attributes with `url()`
- HTML comments that might hide malicious content

**Allow with restrictions:**
- `<a>` tags with `href` (only http/https/mailto)
- `<img>` tags with `src` (validate URLs)
- Formatting tags (`<b>`, `<i>`, `<strong>`, `<em>`)
- Structural tags (`<p>`, `<div>`, `<span>` with classes)
- Lists and tables (if needed)

**Real-world example:** Medium's editor allows rich text formatting but sanitizes all content to prevent XSS while maintaining readability and style.

**Best practices for HTML sanitization:**

1. **Use established libraries**: Don't write custom sanitizers
2. **Context-aware sanitization**: Different rules for different contexts
3. **Defense in depth**: Combine with CSP and output encoding
4. **Regular updates**: Keep sanitization libraries updated
5. **Testing**: Test with known XSS payloads
6. **Logging**: Log sanitization failures for monitoring
7. **Performance**: Consider caching sanitized content

**Common pitfalls:**
- **Over-sanitization**: Removing legitimate content
- **Under-sanitization**: Missing new attack vectors
- **Bypass vulnerabilities**: Mutation-based attacks
- **Performance issues**: Sanitizing large amounts of content
- **Encoding issues**: Character set problems

**Remember:** HTML sanitization is just one layer of defense. Combine it with proper input validation, output encoding, Content Security Policy, and secure coding practices for comprehensive XSS protection.

---
## 40. Caching Strategies

#### 1. What are the different caching strategies?

**Answer:**

**Caching strategies** determine how and when data is stored in cache to improve performance and reduce load on primary data sources. Different strategies offer trade-offs between freshness, consistency, and complexity.

**Common caching strategies:**

**1. Cache-Aside (Lazy Loading):**
- **How it works**: Application checks cache first, loads from source if miss, then populates cache
- **Use case**: Read-heavy workloads, data that doesn't change frequently
- **Pros**: Simple, only caches requested data
- **Cons**: Cache miss penalty, potential stale data

```javascript
async function getProduct(id) {
  // 1. Check cache
  let product = await cache.get(`product:${id}`);
  
  // 2. If miss, load from database
  if (!product) {
    product = await db.products.findByPk(id);
    
    // 3. Store in cache
    await cache.set(`product:${id}`, product, 3600); // 1 hour TTL
  }
  
  return product;
}
```

**2. Read-Through:**
- **How it works**: Cache sits between app and data source, automatically loads on miss
- **Use case**: When cache can manage data loading transparently
- **Pros**: Cleaner application code, automatic cache population
- **Cons**: Requires cache with read-through capability

**3. Write-Through:**
- **How it works**: Write to cache and data source simultaneously
- **Use case**: When data consistency is critical
- **Pros**: Cache always up-to-date, good for write-heavy
- **Cons**: Write latency (waits for both writes)

```javascript
async function updateProduct(id, data) {
  // 1. Update database
  const product = await db.products.update(id, data);
  
  // 2. Update cache simultaneously
  await cache.set(`product:${id}`, product, 3600);
  
  return product;
}
```

**4. Write-Behind (Write-Back):**
- **How it works**: Write to cache immediately, batch writes to source later
- **Use case**: High-write throughput, can tolerate some data loss
- **Pros**: Excellent write performance, reduces database load
- **Cons**: Risk of data loss if cache fails, eventual consistency

**5. Refresh-Ahead:**
- **How it works**: Proactively refresh cache before expiration
- **Use case**: Critical data that must always be fresh
- **Pros**: No cache misses for users, always fresh data
- **Cons**: Wasted resources if data not accessed

**6. Time-to-Live (TTL) based:**
- **How it works**: Cache entries expire after specified time
- **Use case**: Data that changes periodically but not instantly
- **Pros**: Simple, prevents stale data accumulation
- **Cons**: May serve stale data until TTL expires

**Real-world examples:**

**E-commerce site:**
- **Product catalog**: Cache-aside with 5-minute TTL
- **Shopping cart**: Write-through for consistency
- **Product recommendations**: Refresh-ahead before user visits
- **Inventory count**: Write-behind to handle flash sales

**Social media platform:**
- **User profiles**: Read-through with 1-hour TTL
- **News feed**: Cache-aside with 1-minute TTL
- **Notifications**: Write-through for immediate delivery
- **Trending topics**: Refresh-ahead every 5 minutes

**Choosing the right strategy:**

**Consider these factors:**
- **Data volatility**: How often data changes
- **Read/write ratio**: Read-heavy vs write-heavy
- **Consistency requirements**: Strong vs eventual consistency
- **Performance needs**: Latency sensitivity
- **Data criticality**: Impact of stale or lost data

**Hybrid approaches:** Most real-world applications use multiple strategies:
- Cache-aside for most reads
- Write-through for critical data
- TTL for time-sensitive data
- Write-behind for analytics data

**Real-world case:** Amazon uses sophisticated caching strategies combining cache-aside for product pages, write-through for inventory, and write-behind for recommendation algorithms.

**Best practices:**
- **Monitor cache hit ratio**: Aim for 80-90% for optimal performance
- **Implement cache warming**: Pre-load cache during off-peak
- **Use appropriate TTLs**: Balance freshness and performance
- **Handle cache failures**: Graceful degradation when cache is down
- **Regularly review strategy**: Adjust as usage patterns change

**Remember:** The best caching strategy depends on your specific use case. Start simple (cache-aside with TTL) and evolve as you understand your data access patterns better.

---

#### 2. How do you implement caching in Node.js applications?

**Answer:**

**Node.js offers multiple approaches for implementing caching, from in-memory caches to distributed systems.**

**1. In-memory caching (Node.js process):**
```javascript
const NodeCache = require('node-cache');
const cache = new NodeCache({ stdTTL: 600 }); // 10 minutes default

// Set cache
cache.set('user:123', userData, 3600); // 1 hour TTL

// Get cache
const userData = cache.get('user:123');
if (!userData) {
  // Load from database and cache
}

// Advanced features
cache.mset([{key: 'key1', val: 'val1', ttl: 100}, {key: 'key2', val: 'val2'}]);
cache.getStats(); // { hits: 5, misses: 2, keys: 10 }
```

**2. Redis caching (distributed):**
```javascript
const Redis = require('ioredis');
const redis = new Redis();

// Simple set/get
await redis.set('user:123', JSON.stringify(userData), 'EX', 3600);
const data = await redis.get('user:123');
const userData = JSON.parse(data);

// Advanced patterns
// Hash for object storage
await redis.hset('user:123', 'name', 'John', 'email', 'john@example.com');
const user = await redis.hgetall('user:123');

// Sorted sets for leaderboards
await redis.zadd('leaderboard', 100, 'player1', 200, 'player2');
const topPlayers = await redis.zrevrange('leaderboard', 0, 9, 'WITHSCORES');
```

**3. Memcached caching:**
```javascript
const Memcached = require('memcached');
const memcached = new Memcached('localhost:11211');

memcached.set('user:123', userData, 3600, (err) => {
  if (!err) {
    memcached.get('user:123', (err, data) => {
      console.log(data);
    });
  }
});
```

**4. Database query caching:**
```javascript
// Using Sequelize with Redis cache
const sequelize = new Sequelize(/* config */, {
  define: {
    hooks: {
      afterFind: (result) => {
        if (result) {
          redis.set(`model:${result.id}`, JSON.stringify(result), 'EX', 300);
        }
      }
    }
  }
});

// Custom query caching middleware
const cacheMiddleware = (key, ttl = 300) => {
  return async (req, res, next) => {
    const cacheKey = `${key}:${req.params.id || req.query.q}`;
    
    try {
      const cached = await redis.get(cacheKey);
      if (cached) {
        return res.json(JSON.parse(cached));
      }
      
      // Store original send method
      const originalSend = res.send;
      res.send = function(data) {
        // Cache successful responses
        if (res.statusCode === 200) {
          redis.set(cacheKey, data, 'EX', ttl);
        }
        originalSend.call(this, data);
      };
      
      next();
    } catch (error) {
      next(); // Continue without cache on error
    }
  };
};

app.get('/api/products/:id', cacheMiddleware('product', 600), getProduct);
```

**5. HTTP caching with Express:**
```javascript
const apicache = require('apicache');
const cache = apicache.middleware;

// Cache all GET requests for 5 minutes
app.use(cache('5 minutes'));

// Cache specific routes
app.get('/api/products', cache('10 minutes'), getProducts);
app.get('/api/users/:id', cache('1 hour'), getUser);

// Clear cache programmatically
apicache.clear(); // Clear all
apicache.clear('products'); // Clear by key

// Advanced: Cache based on query parameters
const onlyStatus200 = (req, res) => res.statusCode === 200;
app.get('/api/search', cache('2 minutes', onlyStatus200), searchController);
```

**6. CDN caching for static assets:**
```javascript
// Express static with cache headers
app.use('/static', express.static('public', {
  maxAge: '1y', // Browser cache for 1 year
  immutable: true, // Content never changes
  setHeaders: (res, path) => {
    if (path.endsWith('.html')) {
      // HTML files change more often
      res.setHeader('Cache-Control', 'public, max-age=3600');
    }
  }
}));
```

**7. Application-level caching patterns:**

**Cache warming (pre-loading):**
```javascript
// Load popular products into cache on startup
async function warmCache() {
  const popularProducts = await db.products.findAll({
    where: { views: { [Op.gt]: 1000 } },
    limit: 100
  });
  
  for (const product of popularProducts) {
    await redis.set(`product:${product.id}`, JSON.stringify(product), 'EX', 3600);
  }
  
  console.log(`Warmed cache with ${popularProducts.length} products`);
}
```

**Cache stampede prevention:**
```javascript
const getProductWithLock = async (id) => {
  const cacheKey = `product:${id}`;
  const lockKey = `lock:${cacheKey}`;
  
  // Try to get from cache
  let product = await redis.get(cacheKey);
  if (product) return JSON.parse(product);
  
  // Try to acquire lock
  const lockAcquired = await redis.set(lockKey, '1', 'NX', 'EX', 5);
  
  if (lockAcquired) {
    // Load from database
    product = await db.products.findByPk(id);
    
    // Store in cache
    await redis.set(cacheKey, JSON.stringify(product), 'EX', 3600);
    
    // Release lock
    await redis.del(lockKey);
    
    return product;
  } else {
    // Wait and retry
    await new Promise(resolve => setTimeout(resolve, 100));
    return getProductWithLock(id);
  }
};
```

**Real-world example:** Netflix uses multi-layer caching with in-memory caches for user sessions, Redis for recommendations, and CDN caching for video content, serving millions of requests efficiently.

**Best practices for Node.js caching:**

1. **Choose the right cache type**: Memory, Redis, or CDN based on needs
2. **Implement cache invalidation**: Clear cache when data changes
3. **Monitor cache performance**: Hit ratios, memory usage, latency
4. **Handle cache failures**: Graceful degradation
5. **Use appropriate TTLs**: Balance freshness and performance
6. **Test cache behavior**: Under load and failure conditions
7. **Document cache strategy**: For team understanding and maintenance

**Common pitfalls:**
- **Cache stampedes**: Multiple requests miss cache simultaneously
- **Memory leaks**: Unbounded cache growth
- **Stale data**: Incorrect TTL or invalidation
- **Cache penetration**: Queries for non-existent data
- **Serialization issues**: Complex objects in cache

**Remember:** Caching should be implemented strategically, not everywhere. Profile your application to identify bottlenecks and cache only where it provides meaningful performance benefits.

---

#### 3. What are the popular caching solutions (Redis, Memcached)?

**Answer:**

**Redis and Memcached are the most popular caching solutions, each with different strengths and use cases.**

**Redis (Remote Dictionary Server):**

**Key features:**
- **Data structures**: Strings, hashes, lists, sets, sorted sets, streams
- **Persistence**: Optional disk persistence (RDB snapshots, AOF logging)
- **Replication**: Master-slave replication for high availability
- **Transactions**: Multi/exec for atomic operations
- **Lua scripting**: Server-side script execution
- **Pub/Sub**: Publish-subscribe messaging
- **Geospatial**: Location-based data indexing
- **Modules**: Extensible with custom modules

**Use cases:**
- **Session storage**: User sessions with TTL
- **Leaderboards**: Sorted sets for rankings
- **Real-time analytics**: Increment counters, time series
- **Message queues**: List operations for job queues
- **Full-page caching**: HTML content caching
- **Rate limiting**: Token bucket implementation

**Example Redis patterns:**
```javascript
// Session storage
await redis.setex(`session:${sessionId}`, 3600, JSON.stringify(sessionData));

// Leaderboard
await redis.zadd('game:scores', score, `user:${userId}`);

// Rate limiting
const key = `rate:${ip}:${Date.now() / 1000 | 0}`;
const current = await redis.incr(key);
await redis.expire(key, 60);
if (current > 100) throw new Error('Rate limit exceeded');
```

**Memcached:**

**Key features:**
- **Simple key-value store**: Strings only (up to 1MB)
- **Multi-threaded**: Better CPU utilization on multi-core systems
- **LRU eviction**: Automatic eviction when memory full
- **Binary protocol**: Efficient network communication
- **Cluster support**: Built-in sharding across nodes
- **No persistence**: Pure in-memory cache

**Use cases:**
- **Simple caching**: HTML fragments, API responses
- **Database query results**: Reduce database load
- **Session caching**: When persistence not needed
- **Content delivery**: Cache static content
- **Compute caching**: Expensive computation results

**Example Memcached usage:**
```javascript
// Simple get/set
memcached.set('homepage', htmlContent, 600, (err) => {
  memcached.get('homepage', (err, data) => {
    res.send(data);
  });
});

// Multi-get for batch operations
memcached.getMulti(['user:1', 'user:2', 'user:3'], (err, results) => {
  // Process multiple users
});
```

**Comparison table:**

| Feature | Redis | Memcached |
|---------|-------|-----------|
| **Data types** | Rich (strings, hashes, lists, sets, sorted sets) | Simple (strings only) |
| **Persistence** | Yes (RDB, AOF) | No (pure cache) |
| **Replication** | Yes (master-slave) | Limited |
| **Transactions** | Yes (MULTI/EXEC) | No |
| **Lua scripting** | Yes | No |
| **Pub/Sub** | Yes | No |
| **Memory management** | Configurable policies | LRU only |
| **Threading** | Single-threaded | Multi-threaded |
| **Max value size** | 512MB | 1MB |
| **Use case** | Complex caching needs, data structures | Simple caching, high throughput |

**Other popular caching solutions:**

**1. Varnish Cache:**
- **Type**: HTTP accelerator (reverse proxy)
- **Use case**: Full-page caching, CDN replacement
- **Strengths**: Very fast for static content, VCL configuration language

**2. Nginx caching:**
- **Type**: Web server with caching capabilities
- **Use case**: Static file caching, reverse proxy caching
- **Strengths**: Integrated with web server, simple configuration

**3. CDN caching (Cloudflare, Akamai, AWS CloudFront):**
- **Type**: Distributed edge caching
- **Use case**: Global content delivery, DDoS protection
- **Strengths**: Geographic distribution, built-in security

**4. In-memory databases:**
- **Apache Ignite**: Distributed database with caching
- **Hazelcast**: In-memory data grid
- **Aerospike**: High-performance NoSQL with caching

**5. Application-level caches:**
- **Node-cache**: Simple in-memory cache for Node.js
- **LRU-cache**: Least-recently-used cache implementation
- **Quick-lru**: Faster LRU cache implementation

**Choosing the right solution:**

**Choose Redis when:**
- Need rich data structures
- Require persistence
- Want pub/sub or Lua scripting
- Need complex caching logic

**Choose Memcached when:**
- Need simple key-value storage
- Want maximum throughput
- Have multi-core systems
- Don't need persistence

**Choose Varnish/Nginx when:**
- Caching HTTP responses
- Need reverse proxy capabilities
- Want web server integration

**Choose CDN when:**
- Global audience
- Static content delivery
- Need DDoS protection

**Real-world usage examples:**

**Twitter**: Uses Redis for timelines, sessions, and real-time features
**Wikipedia**: Uses Varnish for full-page caching
**YouTube**: Uses CDN caching for video content worldwide
**Facebook**: Uses Memcached for database query results

**Best practices:**
- **Start simple**: Use in-memory cache, upgrade as needed
- **Monitor performance**: Cache hit ratio, latency, memory usage
- **Plan for scale**: Consider distributed caching early
- **Implement fallbacks**: Handle cache failures gracefully
- **Regular maintenance**: Clear stale data, update configurations

**Remember:** The best caching solution depends on your specific requirements. Many applications use multiple solutions together (Redis for sessions, CDN for static files, in-memory for hot data).

---

#### 4. How do you handle cache invalidation?

**Answer:**

**Cache invalidation** is the process of removing or updating cached data when the underlying data changes. It's one of the hardest problems in computer science, as famously stated: "There are only two hard things in Computer Science: cache invalidation and naming things."

**Cache invalidation strategies:**

**1. Time-based expiration (TTL):**
- **How it works**: Cache entries automatically expire after specified time
- **Use case**: Data that changes periodically, not instantly
- **Pros**: Simple, no coordination needed
- **Cons**: May serve stale data until TTL expires

```javascript
// Set with TTL
await redis.set('product:123', productData, 'EX', 300); // 5 minutes

// Or using EXPIRE
await redis.set('product:123', productData);
await redis.expire('product:123', 300);
```

**2. Explicit invalidation:**
- **How it works**: Manually delete cache entries when data changes
- **Use case**: When data must be immediately consistent
- **Pros**: Immediate consistency, no stale data
- **Cons**: Requires tracking what to invalidate

```javascript
async function updateProduct(id, data) {
  // 1. Update database
  const product = await db.products.update(id, data);
  
  // 2. Invalidate cache
  await redis.del(`product:${id}`);
  
  // 3. Invalidate related caches
  await redis.del('products:list');
  await redis.del('products:featured');
  
  return product;
}
```

**3. Write-through invalidation:**
- **How it works**: Update cache simultaneously with database write
- **Use case**: Critical data requiring immediate consistency
- **Pros**: Cache always up-to-date
- **Cons**: Write latency penalty

```javascript
async function updateProduct(id, data) {
  // 1. Update database
  const product = await db.products.update(id, data);
  
  // 2. Update cache
  await redis.set(`product:${id}`, JSON.stringify(product), 'EX', 3600);
  
  return product;
}
```

**4. Version-based invalidation:**
- **How it works**: Include version in cache key, update version on change
- **Use case**: When you want to keep old versions temporarily
- **Pros**: Can serve old data while new computes
- **Cons**: More complex, requires version tracking

```javascript
// Get current version
const version = await redis.get('products:version') || 'v1';

// Cache with versioned key
const cacheKey = `products:${version}:list`;
let products = await redis.get(cacheKey);

if (!products) {
  products = await db.products.findAll();
  await redis.set(cacheKey, JSON.stringify(products), 'EX', 3600);
}

// Invalidate by updating version
async function invalidateProducts() {
  const newVersion = `v${Date.now()}`;
  await redis.set('products:version', newVersion);
  // Old cache entries will expire naturally
}
```

**5. Tag-based invalidation:**
- **How it works**: Associate cache entries with tags, invalidate by tag
- **Use case**: Complex relationships between cached items
- **Pros**: Can invalidate related items together
- **Cons**: More overhead, requires tag management

```javascript
// Store with tags
async function cacheWithTags(key, value, tags, ttl = 3600) {
  await redis.set(key, JSON.stringify(value), 'EX', ttl);
  
  // Store reverse mapping: tag -> keys
  for (const tag of tags) {
    await redis.sadd(`tag:${tag}`, key);
  }
}

// Invalidate by tag
async function invalidateTag(tag) {
  const keys = await redis.smembers(`tag:${tag}`);
  
  if (keys.length > 0) {
    await redis.del(...keys);
    await redis.del(`tag:${tag}`);
  }
}

// Usage
await cacheWithTags('product:123', productData, ['products', 'user:456:products'], 3600);

// Invalidate all products
await invalidateTag('products');
```

**6. Event-driven invalidation:**
- **How it works**: Listen to database change events, invalidate cache
- **Use case**: Microservices, event-driven architectures
- **Pros**: Decoupled, real-time invalidation
- **Cons**: Complex setup, requires event system

```javascript
// Listen to database events
db.on('product:updated', (productId) => {
  redis.del(`product:${productId}`);
  redis.del('products:list');
});

// Or use database triggers
// PostgreSQL NOTIFY/LISTEN
// MongoDB change streams
// MySQL binlog replication
```

**7. Cache warming after invalidation:**
```javascript
async function updateAndWarmCache(id, data) {
  // 1. Update database
  const product = await db.products.update(id, data);
  
  // 2. Invalidate old cache
  await redis.del(`product:${id}`);
  
  // 3. Pre-warm new cache (async, don't wait)
  setTimeout(async () => {
    await redis.set(`product:${id}`, JSON.stringify(product), 'EX', 3600);
  }, 0);
  
  return product;
}
```

**Real-world invalidation patterns:**

**E-commerce site:**
- **Product price**: Write-through (immediate consistency)
- **Product description**: TTL 5 minutes (can be slightly stale)
- **Product list**: Tag-based (invalidate when any product changes)
- **Inventory count**: Event-driven (real-time updates)

**Social media:**
- **User profile**: TTL 1 hour (infrequent changes)
- **News feed**: Version-based (compute new, serve old meanwhile)
- **Notifications**: Write-through (immediate delivery)
- **Friend list**: Explicit invalidation (on friend add/remove)

**Best practices for cache invalidation:**

1. **Choose appropriate strategy**: Based on consistency requirements
2. **Implement logging**: Track what gets invalidated and why
3. **Monitor stale data**: Alert if data is stale beyond acceptable limits
4. **Test invalidation logic**: Ensure it works correctly in all scenarios
5. **Consider performance**: Invalidation shouldn't block user requests
6. **Handle failures**: What if invalidation fails?
7. **Document strategy**: For team understanding

**Common pitfalls:**
- **Thundering herd**: Many requests miss cache simultaneously after invalidation
- **Over-invalidation**: Clearing more cache than necessary
- **Under-invalidation**: Leaving stale data in cache
- **Race conditions**: Read while invalidating
- **Cascading invalidation**: One invalidation triggers many others

**Real-world example:** Facebook uses a sophisticated invalidation system combining TTL for non-critical data, write-through for critical data, and event-driven invalidation for real-time features, handling billions of cache operations daily.

**Remember:** The right invalidation strategy balances consistency requirements with performance. Often, a combination of strategies works best for different types of data in your application.

---

#### 5. What is the difference between client-side and server-side caching?

**Answer:**

**Client-side caching** and **server-side caching** operate at different layers of the application stack with different purposes, control, and characteristics.

**Client-side caching:**

**Where it happens**: User's browser or device
**What it caches**: HTTP responses, assets, application state
**Control**: Limited control by server (via headers)
**Examples**: Browser cache, Service Worker cache, localStorage

**Server-side caching:**

**Where it happens**: Application servers, databases, CDN edges
**What it caches**: Database queries, API responses, computed results
**Control**: Full control by application
**Examples**: Redis, Memcached, Varnish, database query cache

**Detailed comparison:**

| Aspect | Client-side caching | Server-side caching |
|--------|-------------------|-------------------|
| **Location** | User's browser/device | Your infrastructure |
| **Control** | Limited (via headers) | Complete |
| **What's cached** | HTTP responses, assets | Data, computations, pages |
| **Beneficiary** | Individual user | All users |
| **Invalidation** | Hard (depends on headers) | Easy (direct control) |
| **Security** | Less secure (user controls) | More secure (you control) |
| **Storage limit** | Browser limits (5-50MB) | Server resources |
| **Use case** | Repeat visits, offline use | Reduce server load, improve performance |

**Client-side caching examples:**

**1. Browser cache (HTTP caching):**
```javascript
// Express setting cache headers
app.use('/static', express.static('public', {
  maxAge: '1y',
  immutable: true,
  etag: true,
  lastModified: true
}));

// Headers sent:
// Cache-Control: public, max-age=31536000, immutable
// ETag: "abc123"
// Last-Modified: Wed, 21 Oct 2015 07:28:00 GMT
```

**2. Service Worker caching:**
```javascript
// service-worker.js
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open('v1').then((cache) => {
      return cache.addAll([
        '/',
        '/index.html',
        '/styles.css',
        '/app.js'
      ]);
    })
  );
});

self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request);
    })
  );
});
```

**3. Application cache (localStorage, IndexedDB):**
```javascript
// localStorage for simple data
localStorage.setItem('userPreferences', JSON.stringify(prefs));
const prefs = JSON.parse(localStorage.getItem('userPreferences'));

// IndexedDB for complex data
const db = await idb.openDB('my-db', 1, {
  upgrade(db) {
    db.createObjectStore('products', { keyPath: 'id' });
  }
});

await db.put('products', product);
const product = await db.get('products', id);
```

**Server-side caching examples:**

**1. Application cache (Redis):**
```javascript
// Cache API responses
app.get('/api/products', async (req, res) => {
  const cacheKey = `products:${req.query.category || 'all'}`;
  const cached = await redis.get(cacheKey);
  
  if (cached) {
    return res.json(JSON.parse(cached));
  }
  
  const products = await db.products.findAll({
    where: req.query.category ? { category: req.query.category } : {}
  });
  
  await redis.set(cacheKey, JSON.stringify(products), 'EX', 300);
  res.json(products);
});
```

**2. Database query cache:**
```javascript
// MySQL query cache (deprecated in MySQL 8.0)
SET GLOBAL query_cache_size = 1000000;

// PostgreSQL with pgpool-II
// Configures connection pooling with query caching
```

**3. Full-page cache (Varnish/Nginx):**
```nginx
# Nginx configuration
location /products/ {
  proxy_cache products_cache;
  proxy_cache_key "$scheme$request_method$host$request_uri";
  proxy_cache_valid 200 302 10m;
  proxy_cache_valid 404 1m;
  proxy_pass http://backend;
}
```

**4. CDN caching:**
```javascript
// Cloudflare cache rules via API
// Or via Page Rules in dashboard
```

**When to use each:**

**Use client-side caching when:**
- Assets don't change often (CSS, JS, images)
- Improving perceived performance for repeat visitors
- Supporting offline functionality
- Reducing server bandwidth costs

**Use server-side caching when:**
- Database queries are expensive
- API responses are compute-intensive
- Serving the same data to many users
- Need to reduce backend load

**Real-world usage patterns:**

**News website:**
- **Client-side**: CSS/JS files (1 year), article HTML (5 minutes)
- **Server-side**: Homepage (1 minute), article content (5 minutes), comments (real-time)

**E-commerce:**
- **Client-side**: Product images (1 year), CSS/JS (1 year)
- **Server-side**: Product details (1 minute), prices (real-time), inventory (real-time)

**Social media:**
- **Client-side**: User avatar (1 week), CSS/JS (1 year)
- **Server-side**: News feed (1 minute), notifications (real-time), profiles (1 hour)

**Combined approach (recommended):**
```javascript
// Server sets appropriate headers
app.get('/api/data', (req, res) => {
  const data = getDataFromCacheOrCompute();
  
  // Server-side cache hit
  res.set({
    'Cache-Control': 'public, max-age=60',
    'ETag': generateETag(data),
    'Last-Modified': new Date().toUTCString()
  });
  
  res.json(data);
});

// Client can cache based on headers
// Browser caches for 60 seconds
// Service Worker can cache for offline
```

**Best practices:**

**For client-side caching:**
- Use appropriate Cache-Control headers
- Implement versioning for assets (file.hash.js)
- Consider Service Workers for offline support
- Test across different browsers
- Monitor cache hit ratios

**For server-side caching:**
- Choose the right cache strategy
- Implement proper invalidation
- Monitor cache performance
- Plan for cache failures
- Use multiple cache layers

**Real-world example:** Google Search uses sophisticated multi-layer caching with browser cache for static assets, CDN caching for search results, and server-side caching for search indexes, serving billions of queries efficiently.

**Remember:** Client-side and server-side caching are complementary, not mutually exclusive. A well-architected application uses both to maximize performance at all layers of the stack.

---
## 41. Load Balancing & Clustering

#### 1. What is clustering in Node.js and why is it needed?

**Answer:**

**Clustering** in Node.js is the process of creating multiple instances (workers) of your application to run concurrently, utilizing multiple CPU cores. Since Node.js runs in a single thread, clustering allows you to take advantage of multi-core systems.

**Why clustering is needed:**

1. **CPU utilization**: Node.js is single-threaded, but servers have multiple cores
2. **Performance**: Handle more requests by distributing load across workers
3. **Fault tolerance**: If one worker crashes, others continue serving requests
4. **Zero-downtime deployments**: Restart workers one at a time
5. **Memory management**: Each worker has separate memory space

**Without clustering:**
- Single process uses one CPU core
- Other cores sit idle
- Limited concurrent connections
- Single point of failure

**With clustering:**
- Multiple processes use all CPU cores
- Higher throughput and concurrency
- Better resource utilization
- Improved reliability

**Real-world example:** An e-commerce site during Black Friday sales uses clustering to handle 10x normal traffic by distributing requests across 8 CPU cores instead of just one.

**When to use clustering:**
- **CPU-bound applications**: Image processing, data analysis
- **High-traffic websites**: E-commerce, social media
- **Real-time applications**: Chat, gaming, collaboration tools
- **API servers**: Handling thousands of concurrent requests

**When NOT to use clustering:**
- **I/O-bound applications**: Already efficient with single thread
- **Low-traffic applications**: Overhead not justified
- **Development environment**: Simpler single-process debugging
- **Serverless/containerized**: Orchestration handles scaling

**Performance impact:** Proper clustering can improve throughput by 4-8x on an 8-core server, depending on the application type.

---

#### 2. How does the cluster module work?

**Answer:**

**The cluster module** is Node.js's built-in solution for creating child processes (workers) that share server ports. It uses the `child_process.fork()` method to spawn workers.

**How it works:**

1. **Master process**: Creates worker processes, manages lifecycle
2. **Worker processes**: Run application code, handle requests
3. **IPC (Inter-Process Communication)**: Master and workers communicate via messages
4. **Load distribution**: OS or master distributes incoming connections

**Basic cluster setup:**
```javascript
const cluster = require('cluster');
const os = require('os');

if (cluster.isMaster) {
  // Master process
  const numCPUs = os.cpus().length;
  
  console.log(`Master ${process.pid} is running`);
  console.log(`Forking ${numCPUs} workers`);
  
  // Fork workers
  for (let i = 0; i < numCPUs; i++) {
    cluster.fork();
  }
  
  // Handle worker events
  cluster.on('exit', (worker, code, signal) => {
    console.log(`Worker ${worker.process.pid} died`);
    // Restart worker
    cluster.fork();
  });
  
} else {
  // Worker process
  const express = require('express');
  const app = express();
  
  app.get('/', (req, res) => {
    res.send(`Hello from worker ${process.pid}`);
  });
  
  app.listen(3000, () => {
    console.log(`Worker ${process.pid} started`);
  });
}
```

**Key components:**

**1. Master process responsibilities:**
- Creates worker processes
- Monitors worker health
- Restarts failed workers
- Handles graceful shutdown
- Distributes connections (optional)

**2. Worker process responsibilities:**
- Runs application code
- Handles incoming requests
- Maintains separate memory space
- Can crash independently

**3. Process communication:**
```javascript
// Master to worker
cluster.workers[workerId].send({ type: 'shutdown' });

// Worker to master
process.send({ type: 'stats', data: requestCount });

// Worker receives message
process.on('message', (msg) => {
  if (msg.type === 'shutdown') {
    process.exit(0);
  }
});
```

**4. Load distribution strategies:**
- **Round-robin (default)**: Distributes connections evenly
- **OS scheduling**: Let operating system decide
- **Custom logic**: Based on worker load or affinity

**Advanced cluster features:**

**Graceful shutdown:**
```javascript
// Master handles shutdown
process.on('SIGTERM', () => {
  console.log('Master received SIGTERM, shutting down gracefully');
  
  for (const id in cluster.workers) {
    cluster.workers[id].send('shutdown');
    cluster.workers[id].disconnect();
    
    setTimeout(() => {
      if (cluster.workers[id]) {
        cluster.workers[id].kill();
      }
    }, 5000);
  }
});
```

**Worker health monitoring:**
```javascript
// Master monitors worker health
cluster.on('online', (worker) => {
  console.log(`Worker ${worker.process.pid} is online`);
});

cluster.on('disconnect', (worker) => {
  console.log(`Worker ${worker.process.pid} disconnected`);
});

cluster.on('message', (worker, message) => {
  console.log(`Message from worker ${worker.process.pid}:`, message);
});
```

**Real-world example:** Netflix uses clustering extensively in their Node.js microservices to handle millions of concurrent streaming requests across thousands of servers.

**Limitations of cluster module:**
- **Shared nothing**: Workers don't share memory
- **State management**: Need external solutions for shared state
- **Complex debugging**: Multiple processes harder to debug
- **Port sharing**: Only HTTP/HTTPS servers can share ports

**Best practices:**
- Use number of workers equal to CPU cores
- Implement graceful shutdown
- Monitor worker health and restart if needed
- Use external storage for shared state
- Test with production-like load

**Remember:** The cluster module provides a simple way to scale Node.js applications vertically (using more CPU cores on a single machine). For horizontal scaling (multiple machines), you need load balancers.

---

#### 3. How do you implement load balancing for Node.js applications?

**Answer:**

**Load balancing** distributes incoming network traffic across multiple servers to ensure no single server becomes overwhelmed. For Node.js applications, this can be implemented at different levels.

**Levels of load balancing:**

**1. Application-level load balancing (cluster module):**
```javascript
// Using cluster module with round-robin
const cluster = require('cluster');
const http = require('http');
const numCPUs = require('os').cpus().length;

if (cluster.isMaster) {
  for (let i = 0; i < numCPUs; i++) {
    cluster.fork();
  }
} else {
  http.createServer((req, res) => {
    res.writeHead(200);
    res.end(`Processed by worker ${process.pid}\n`);
  }).listen(8000);
}
```

**2. Reverse proxy load balancing (Nginx):**
```nginx
# nginx.conf
http {
  upstream node_app {
    # Load balancing method
    least_conn; # or ip_hash, random, round-robin
    
    # Server instances
    server 127.0.0.1:3000 weight=3;
    server 127.0.0.1:3001 weight=2;
    server 127.0.0.1:3002 weight=1;
    
    # Health checks
    server 127.0.0.1:3003 backup;
  }
  
  server {
    listen 80;
    
    location / {
      proxy_pass http://node_app;
      proxy_set_header Host $host;
      proxy_set_header X-Real-IP $remote_addr;
    }
  }
}
```

**3. Cloud load balancers (AWS, GCP, Azure):**
```javascript
// AWS Elastic Load Balancer configuration
// Auto-scaling group with Node.js instances
// Health checks on /health endpoint
app.get('/health', (req, res) => {
  res.json({ 
    status: 'healthy',
    timestamp: new Date().toISOString(),
    pid: process.pid 
  });
});
```

**4. DNS-based load balancing:**
```javascript
// Multiple A records for domain
// example.com -> 192.168.1.10
// example.com -> 192.168.1.11
// example.com -> 192.168.1.12
// DNS round-robin distributes requests
```

**Load balancing algorithms:**

**1. Round-robin:**
- Requests distributed sequentially
- Simple and fair
- Doesn't consider server load

**2. Least connections:**
- Sends to server with fewest active connections
- Better for long-lived connections
- Requires tracking connection counts

**3. IP hash:**
- Client IP determines server
- Enables sticky sessions
- Can cause uneven distribution

**4. Weighted round-robin:**
- Servers have different weights
- More powerful servers get more traffic
- Manual configuration required

**5. Random:**
- Random server selection
- Good for large numbers of servers
- Simple but unpredictable

**Implementation with PM2 (process manager):**
```bash
# Start 4 instances with load balancing
pm2 start app.js -i 4

# Auto-scale based on CPU
pm2 start app.js -i max

# Cluster mode with reload
pm2 start app.js -i 4 --name "api" --watch
```

**PM2 cluster configuration:**
```javascript
// ecosystem.config.js
module.exports = {
  apps: [{
    name: 'api',
    script: 'app.js',
    instances: 'max', // Use all CPU cores
    exec_mode: 'cluster', // Enable cluster mode
    watch: true,
    env: {
      NODE_ENV: 'development'
    },
    env_production: {
      NODE_ENV: 'production'
    }
  }]
};
```

**Health checks and monitoring:**
```javascript
// Health check endpoint
app.get('/health', (req, res) => {
  const health = {
    status: 'UP',
    timestamp: Date.now(),
    uptime: process.uptime(),
    memory: process.memoryUsage(),
    cpu: process.cpuUsage(),
    pid: process.pid
  };
  
  // Add custom checks
  health.database = checkDatabaseConnection();
  health.redis = checkRedisConnection();
  health.externalApi = checkExternalApi();
  
  const isHealthy = health.database && health.redis;
  res.status(isHealthy ? 200 : 503).json(health);
});

// Load balancer uses this to determine server health
```

**Real-world example:** Uber uses sophisticated load balancing with Nginx as reverse proxy, distributing millions of ride requests across thousands of Node.js instances globally.

**Best practices for load balancing:**

1. **Implement health checks**: Load balancer can remove unhealthy instances
2. **Use connection draining**: Gracefully remove instances during deployment
3. **Monitor load distribution**: Ensure even traffic distribution
4. **Implement circuit breakers**: Prevent cascading failures
5. **Use multiple availability zones**: For high availability
6. **Test failover scenarios**: Ensure system handles instance failures
7. **Implement auto-scaling**: Add/remove instances based on load

**Common pitfalls:**
- **Session stickiness issues**: Without proper session management
- **Uneven load distribution**: Due to improper algorithm choice
- **Single point of failure**: Load balancer itself failing
- **Configuration drift**: Inconsistent configurations across instances
- **DNS caching issues**: With DNS-based load balancing

**Remember:** Load balancing is essential for scaling Node.js applications beyond a single server. Start with simple solutions (cluster module, PM2) and evolve to more sophisticated setups (Nginx, cloud load balancers) as your traffic grows.

---

#### 4. What is sticky sessions and when is it needed?

**Answer:**

**Sticky sessions** (session affinity) ensure that requests from the same client are always routed to the same backend server. This is necessary when session data is stored locally on the server rather than in a shared storage.

**How sticky sessions work:**
1. First request from client reaches load balancer
2. Load balancer assigns client to a specific server
3. Load balancer remembers this assignment (via cookie or IP)
4. Subsequent requests from same client go to same server
5. Server has client's session data in memory

**Implementation methods:**

**1. Load balancer cookies:**
```nginx
# Nginx configuration
upstream backend {
  ip_hash; # Sticky sessions based on IP
  
  server 10.0.0.1:3000;
  server 10.0.0.2:3000;
}

# Or using sticky cookie
upstream backend {
  sticky cookie srv_id expires=1h domain=.example.com path=/;
  
  server 10.0.0.1:3000;
  server 10.0.0.2:3000;
}
```

**2. Application-level stickiness:**
```javascript
// Client stores server identifier
app.use((req, res, next) => {
  // Check for server affinity cookie
  const serverId = req.cookies.server_affinity;
  
  if (serverId && serverId !== process.env.SERVER_ID) {
    // Redirect to correct server
    res.redirect(`http://server-${serverId}.example.com${req.path}`);
  } else {
    // Set cookie for future requests
    res.cookie('server_affinity', process.env.SERVER_ID, {
      maxAge: 3600000,
      httpOnly: true
    });
    next();
  }
});
```

**3. IP-based stickiness:**
```javascript
// Simple hash based on client IP
function getServerForIP(ip) {
  const servers = ['server1', 'server2', 'server3'];
  const hash = ip.split('.').reduce((acc, octet) => acc + parseInt(octet), 0);
  return servers[hash % servers.length];
}
```

**When sticky sessions are needed:**

**1. In-memory sessions:**
```javascript
// Session stored in server memory (not shared)
const sessions = new Map();

app.use(session({
  secret: 'keyboard cat',
  resave: false,
  saveUninitialized: true,
  store: new MemoryStore() // Local to this server
}));

// Requires sticky sessions - otherwise session lost on different server
```

**2. File uploads in progress:**
- Large file being uploaded to specific server
- Subsequent chunks must go to same server
- Otherwise upload fails

**3. WebSocket connections:**
- Persistent connection to specific server
- Messages must route to same server
- Otherwise connection broken

**4. Real-time collaboration:**
- Multiple users editing same document
- All need to connect to same server
- For consistent state management

**5. Legacy applications:**
- Applications not designed for distributed sessions
- Hard to migrate to shared session storage
- Temporary solution during migration

**When NOT to use sticky sessions:**

**1. Stateless applications:**
- JWT tokens in Authorization header
- No server-side session storage
- Any server can handle any request

**2. Shared session storage:**
```javascript
// Using Redis for shared sessions
app.use(session({
  store: new RedisStore({
    client: redisClient,
    ttl: 86400 // 24 hours
  }),
  secret: 'keyboard cat',
  resave: false,
  saveUninitialized: false
}));

// Any server can handle any request - no stickiness needed
```

**3. Microservices architecture:**
- Each request independent
- Services stateless
- Load balancer can distribute freely

**Problems with sticky sessions:**

**1. Uneven load distribution:**
- Some servers get more sticky clients
- Can't rebalance easily
- Hotspots develop

**2. Server failure handling:**
- Client sessions lost when server fails
- Need session replication or shared storage
- Complex failover scenarios

**3. Scalability limitations:**
- Can't add/remove servers dynamically
- Sticky assignments need updating
- DNS/cookie propagation delays

**4. Mobile clients:**
- IP changes frequently (cellular networks)
- Sticky sessions break
- Poor user experience

**Best practices:**

**1. Avoid when possible:**
- Use shared session storage (Redis, database)
- Make applications stateless
- Store session data in encrypted cookies

**2. If needed, implement properly:**
- Use load balancer features (not application hacks)
- Set reasonable timeout for stickiness
- Implement session backup/replication

**3. Monitor and adjust:**
- Track session distribution
- Alert on uneven load
- Plan migration away from stickiness

**Real-world example:** A banking application initially used sticky sessions for security reasons but migrated to Redis session storage to enable better load balancing and failover capabilities.

**Migration strategy from sticky sessions:**
1. Implement shared session storage (Redis)
2. Run both systems in parallel
3. Gradually move users to shared storage
4. Remove sticky session configuration
5. Monitor for issues during migration

**Remember:** Sticky sessions are a workaround, not a solution. Aim for stateless applications or shared session storage to enable proper load balancing and high availability.

---

#### 5. How do you handle shared state in a clustered environment?

**Answer:**

**Shared state management** is critical in clustered environments where multiple Node.js processes need to access and update common data. Since each worker has separate memory, you need external mechanisms for state sharing.

**Approaches to shared state:**

**1. External data stores (recommended):**

**Redis for shared data:**
```javascript
const Redis = require('ioredis');
const redis = new Redis();

// Shared counter
async function incrementCounter() {
  return await redis.incr('global:counter');
}

// Shared session storage
const sessionStore = new RedisStore({ client: redis });

// Shared cache
async function getCachedData(key) {
  const data = await redis.get(key);
  return data ? JSON.parse(data) : null;
}

async function setCachedData(key, value, ttl = 3600) {
  await redis.setex(key, ttl, JSON.stringify(value));
}

// Pub/Sub for communication
redis.subscribe('cluster:events', (err, count) => {
  console.log(`Subscribed to ${count} channels`);
});

redis.on('message', (channel, message) => {
  console.log(`Received ${message} from ${channel}`);
});

// Publish to all workers
redis.publish('cluster:events', 'worker_restarted');
```

**Database for persistent state:**
```javascript
// Using PostgreSQL for shared state
async function updateSharedState(key, value) {
  await db.query(`
    INSERT INTO shared_state (key, value, updated_at)
    VALUES ($1, $2, NOW())
    ON CONFLICT (key) 
    DO UPDATE SET value = $2, updated_at = NOW()
  `, [key, value]);
}

async function getSharedState(key) {
  const result = await db.query(
    'SELECT value FROM shared_state WHERE key = $1',
    [key]
  );
  return result.rows[0]?.value;
}
```

**2. Message passing between workers:**
```javascript
// Using process messaging
if (cluster.isMaster) {
  // Master relays messages between workers
  cluster.on('message', (worker, message) => {
    // Broadcast to all workers
    for (const id in cluster.workers) {
      if (cluster.workers[id].id !== worker.id) {
        cluster.workers[id].send(message);
      }
    }
  });
} else {
  // Worker sends and receives messages
  process.on('message', (msg) => {
    if (msg.type === 'user_connected') {
      // Update local state
      connectedUsers.add(msg.userId);
    }
  });
  
  // Notify other workers
  function broadcastUserConnected(userId) {
    process.send({
      type: 'user_connected',
      userId: userId,
      workerId: process.pid
    });
  }
}
```

**3. Shared memory (advanced):**
```javascript
// Using shared array buffers (limited use)
const { Worker, isMainThread, parentPort, workerData, SharedArrayBuffer } = require('worker_threads');

if (isMainThread) {
  // Create shared buffer
  const sharedBuffer = new SharedArrayBuffer(1024);
  const sharedArray = new Int32Array(sharedBuffer);
  
  // Create workers with shared buffer
  const worker1 = new Worker(__filename, { workerData: { sharedBuffer } });
  const worker2 = new Worker(__filename, { workerData: { sharedBuffer } });
  
} else {
  // Worker thread accesses shared buffer
  const sharedArray = new Int32Array(workerData.sharedBuffer);
  
  // Use Atomics for safe operations
  Atomics.add(sharedArray, 0, 1); // Increment counter
  console.log('Counter:', Atomics.load(sharedArray, 0));
}
```

**4. Distributed consensus algorithms:**
- **Raft or Paxos**: For strongly consistent state
- **ZooKeeper or etcd**: For configuration and coordination
- **Consul**: For service discovery and key-value store

**Common shared state scenarios:**

**1. Session management:**
```javascript
// Using Redis for shared sessions
const session = require('express-session');
const RedisStore = require('connect-redis')(session);

app.use(session({
  store: new RedisStore({
    client: redisClient,
    prefix: 'session:',
    ttl: 86400 // 24 hours
  }),
  secret: 'your-secret-key',
  resave: false,
  saveUninitialized: false
}));
```

**2. Rate limiting across workers:**
```javascript
// Global rate limiting with Redis
const rateLimit = require('express-rate-limit');
const RedisStore = require('rate-limit-redis');

const globalLimiter = rateLimit({
  store: new RedisStore({
    sendCommand: (...args) => redisClient.call(...args),
  }),
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // Limit each IP to 100 requests per window
  message: 'Too many requests from this IP'
});
```

**3. Real-time notifications:**
```javascript
// Using Redis Pub/Sub for real-time updates
const io = require('socket.io')(server);
const redisAdapter = require('socket.io-redis');

io.adapter(redisAdapter({ 
  host: 'localhost', 
  port: 6379 
}));

// Any worker can emit to all connected clients
io.on('connection', (socket) => {
  socket.on('chat message', (msg) => {
    // This will reach all clients across all workers
    io.emit('chat message', msg);
  });
});
```

**4. Job queues:**
```javascript
// Using Bull (Redis-based queue)
const Queue = require('bull');

// Create queue shared across workers
const videoQueue = new Queue('video processing', {
  redis: { port: 6379, host: '127.0.0.1' }
});

// Worker 1 adds job
videoQueue.add({ video: 'video1.mp4', format: 'mp4' });

// Worker 2 processes job
videoQueue.process((job, done) => {
  processVideo(job.data).then(() => done());
});
```

**5. Cache synchronization:**
```javascript
// Invalidate cache across all workers
async function updateProduct(id, data) {
  // Update database
  const product = await db.products.update(id, data);
  
  // Invalidate cache in all workers
  await redis.publish('cache:invalidate', `product:${id}`);
  
  return product;
}

// Workers listen for cache invalidation
redis.subscribe('cache:invalidate', (err, count) => {
  console.log(`Subscribed to cache invalidation channel`);
});

redis.on('message', (channel, message) => {
  if (channel === 'cache:invalidate') {
    // Clear local cache entry
    localCache.delete(message);
  }
});
```

**Best practices for shared state:**

1. **Choose the right tool**: Redis for speed, database for persistence
2. **Implement retry logic**: Network failures happen
3. **Use connection pooling**: For database/Redis connections
4. **Monitor performance**: Latency, throughput, error rates
5. **Implement caching layers**: Reduce shared state access
6. **Test failure scenarios**: Network partitions, service outages
7. **Document data flow**: How state is shared and synchronized

**Common pitfalls:**

1. **Race conditions**: Multiple workers updating same data
2. **Network latency**: Slower than in-memory access
3. **Single point of failure**: Shared service goes down
4. **Consistency issues**: Eventually consistent vs strongly consistent
5. **Memory leaks**: Unbounded growth in shared storage

**Real-world example:** Twitter uses Redis clusters for shared session storage, real-time counters, and caching, allowing their Node.js services to scale horizontally while maintaining consistent state.

**Remember:** The goal is to minimize shared state when possible. When needed, use battle-tested solutions (Redis, databases) rather than building custom synchronization mechanisms.

---
## 42. Compression & Minification

#### 1. Why is compression important for web applications?

**Answer:**

**Compression** reduces the size of data transferred between server and client, significantly improving web application performance and user experience.

**Why compression is important:**

1. **Faster page loads**: Smaller files download quicker
2. **Reduced bandwidth costs**: Less data transferred
3. **Better SEO**: Page speed is a ranking factor
4. **Improved user experience**: Especially on mobile/slow connections
5. **Lower server load**: Fewer bytes to serve per request

**Impact of compression:**

**Without compression:**
- HTML: 50KB → 50KB transferred
- CSS: 100KB → 100KB transferred  
- JS: 200KB → 200KB transferred
- **Total: 350KB**

**With compression (70% reduction):**
- HTML: 50KB → 15KB transferred
- CSS: 100KB → 30KB transferred
- JS: 200KB → 60KB transferred
- **Total: 105KB (70% smaller)**

**Real-world example:** Amazon found that every 100ms of latency cost them 1% in sales. Compression can reduce load times by 50-70%, directly impacting revenue.

**Types of compression:**

**1. Text compression (HTML, CSS, JS, JSON):**
- Gzip: 60-80% reduction
- Brotli: 70-90% reduction (better than Gzip)
- Deflate: Similar to Gzip, less common

**2. Image compression:**
- Lossless: PNG, WebP (no quality loss)
- Lossy: JPEG, WebP (quality vs size trade-off)
- Modern formats: AVIF, WebP 2 (better compression)

**3. Video compression:**
- H.264, H.265, VP9, AV1
- Adaptive bitrate streaming

**4. Font compression:**
- WOFF2: 30% better than WOFF
- Subsetting: Include only needed characters

**Browser support:** All modern browsers support Gzip and Brotli compression automatically when servers provide compressed content.

**Performance benefits:**

**Mobile users (3G connection):**
- Without compression: 10+ second load time
- With compression: 3-5 second load time
- **Impact**: Lower bounce rates, higher engagement

**International users:**
- Higher latency connections
- Expensive bandwidth in some regions
- Compression reduces costs and improves access

**SEO impact:**
- Google considers page speed in rankings
- Faster sites rank higher
- Compression directly improves Core Web Vitals

**Implementation levels:**

**1. Static file compression:**
- Compress during build process
- Serve pre-compressed files
- No runtime overhead

**2. Dynamic compression:**
- Compress responses on-the-fly
- Handles API responses, dynamic content
- Small CPU overhead

**3. CDN compression:**
- Edge servers handle compression
- Global distribution
- Reduced origin server load

**Real-world case study:** A news website implemented Brotli compression and reduced their page weight by 65%, resulting in 40% faster load times and 15% increase in page views.

**Best practices:**
- **Always compress text assets**: HTML, CSS, JS, JSON, XML
- **Use appropriate compression level**: Balance size vs CPU
- **Implement caching**: Avoid recompressing same content
- **Monitor compression ratios**: Ensure effectiveness
- **Test with real users**: Different devices and connections

**Remember:** Compression is one of the easiest performance optimizations with the highest impact. It should be enabled on all production web applications.

---

#### 2. How do you implement compression in Express?

**Answer:**

**Express provides several approaches for implementing compression, from middleware for dynamic content to build-time compression for static assets.**

**1. Using `compression` middleware (dynamic compression):**
```javascript
const compression = require('compression');
const express = require('express');
const app = express();

// Enable compression for all responses
app.use(compression());

// With custom options
app.use(compression({
  level: 6, // Compression level (0-9, 6 is default)
  threshold: 1024, // Only compress responses > 1KB
  filter: (req, res) => {
    // Custom filter function
    if (req.headers['x-no-compression']) {
      return false; // Don't compress
    }
    return compression.filter(req, res); // Use default filter
  }
}));

// Routes work normally - responses automatically compressed
app.get('/api/data', (req, res) => {
  const data = { message: 'This will be compressed' };
  res.json(data); // Automatically compressed if > threshold
});

app.get('/html', (req, res) => {
  res.send('<h1>This HTML will be compressed</h1>');
});
```

**2. Pre-compressed static files:**
```javascript
const express = require('express');
const fs = require('fs');
const path = require('path');
const zlib = require('zlib');

const app = express();

// Middleware to serve pre-compressed files
app.use((req, res, next) => {
  const acceptEncoding = req.headers['accept-encoding'] || '';
  const filePath = path.join(__dirname, 'public', req.path);
  
  // Check if pre-compressed version exists
  if (acceptEncoding.includes('br') && fs.existsSync(filePath + '.br')) {
    req.url = req.url + '.br';
    res.set('Content-Encoding', 'br');
    res.set('Content-Type', getContentType(filePath));
  } else if (acceptEncoding.includes('gzip') && fs.existsSync(filePath + '.gz')) {
    req.url = req.url + '.gz';
    res.set('Content-Encoding', 'gzip');
    res.set('Content-Type', getContentType(filePath));
  }
  
  next();
});

// Serve static files
app.use(express.static('public'));

function getContentType(filePath) {
  const ext = path.extname(filePath);
  const types = {
    '.html': 'text/html',
    '.css': 'text/css',
    '.js': 'application/javascript',
    '.json': 'application/json'
  };
  return types[ext] || 'text/plain';
}
```

**3. Nginx compression (recommended for production):**
```nginx
# nginx.conf - compression at reverse proxy level
http {
  gzip on;
  gzip_vary on;
  gzip_min_length 1024;
  gzip_proxied any;
  gzip_comp_level 6;
  gzip_types
    text/plain
    text/css
    text/xml
    text/javascript
    application/json
    application/javascript
    application/xml+rss
    application/atom+xml
    image/svg+xml;
  
  # Brotli compression (if supported)
  brotli on;
  brotli_comp_level 6;
  brotli_types
    text/plain
    text/css
    text/xml
    text/javascript
    application/json
    application/javascript
    application/xml+rss
    application/atom+xml
    image/svg+xml;
}
```

**4. CDN compression (Cloudflare, AWS CloudFront):**
```javascript
// Cloudflare automatically compresses content
// Enable in dashboard: Speed > Optimization > Auto Minify

// AWS CloudFront compression
// Enable in distribution settings: Compress Objects Automatically
```

**5. Build-time compression (Webpack, Vite):**
```javascript
// webpack.config.js
const CompressionPlugin = require('compression-webpack-plugin');

module.exports = {
  plugins: [
    new CompressionPlugin({
      filename: '[path][base].gz',
      algorithm: 'gzip',
      test: /\.(js|css|html|svg|json)$/,
      threshold: 10240, // Only files > 10KB
      minRatio: 0.8, // Only compress if compression ratio <= 0.8
    }),
    new CompressionPlugin({
      filename: '[path][base].br',
      algorithm: 'brotliCompress',
      test: /\.(js|css|html|svg|json)$/,
      compressionOptions: { level: 11 },
      threshold: 10240,
      minRatio: 0.8,
    })
  ]
};
```

**6. API-specific compression:**
```javascript
// Compress specific API responses
app.get('/api/large-data', (req, res) => {
  const largeData = generateLargeDataset(); // 1MB+ of JSON
  
  // Check client support
  const acceptEncoding = req.headers['accept-encoding'] || '';
  
  if (acceptEncoding.includes('br')) {
    const compressed = zlib.brotliCompressSync(JSON.stringify(largeData));
    res.set('Content-Encoding', 'br');
    res.set('Content-Type', 'application/json');
    res.send(compressed);
  } else if (acceptEncoding.includes('gzip')) {
    const compressed = zlib.gzipSync(JSON.stringify(largeData));
    res.set('Content-Encoding', 'gzip');
    res.set('Content-Type', 'application/json');
    res.send(compressed);
  } else {
    res.json(largeData); // Uncompressed fallback
  }
});
```

**7. Conditional compression middleware:**
```javascript
const shouldCompress = (req, res) => {
  // Don't compress responses with no-transform cache-control
  if (res.getHeader('Cache-Control')?.includes('no-transform')) {
    return false;
  }
  
  // Don't compress very small responses
  if (res.getHeader('Content-Length') < 1024) {
    return false;
  }
  
  // Don't compress binary files
  const contentType = res.getHeader('Content-Type') || '';
  if (contentType.includes('image/') || 
      contentType.includes('video/') || 
      contentType.includes('audio/') ||
      contentType.includes('font/')) {
    return false;
  }
  
  return true;
};

app.use(compression({ filter: shouldCompress }));
```

**Best practices for Express compression:**

1. **Use middleware for dynamic content**: API responses, server-rendered pages
2. **Pre-compress static assets**: During build for better performance
3. **Set appropriate thresholds**: Don't compress very small files
4. **Check client support**: Respect Accept-Encoding header
5. **Combine with caching**: Avoid recompressing same content
6. **Monitor CPU usage**: Compression adds CPU overhead
7. **Test with real traffic**: Ensure it works under load

**Common pitfalls:**
- **Double compression**: Compressing already compressed files
- **Missing headers**: Forgetting Content-Encoding header
- **CPU overhead**: Compressing on every request
- **Small file overhead**: Compression can increase size of tiny files
- **Cache issues**: Caching compressed vs uncompressed versions

**Real-world example:** GitHub uses a combination of Nginx compression for static assets and application-level compression for API responses, reducing their bandwidth usage by over 60%.

**Remember:** Compression should be implemented at the appropriate layer - build-time for static assets, middleware for dynamic content, and reverse proxy/CDN for production optimization.

---

#### 3. What are the different compression algorithms?

**Answer:**

**Compression algorithms** use different techniques to reduce data size. Understanding their strengths helps choose the right one for your use case.

**1. Gzip (GNU zip):**
- **Type**: Lossless, DEFLATE algorithm
- **Compression ratio**: 60-80% for text
- **Speed**: Fast compression, very fast decompression
- **Browser support**: Universal (since 1996)
- **Use case**: General web content, API responses

```javascript
// Node.js implementation
const zlib = require('zlib');
const input = 'Some text to compress';

// Compress
zlib.gzip(input, (err, compressed) => {
  console.log('Compressed size:', compressed.length);
  
  // Decompress
  zlib.gunzip(compressed, (err, original) => {
    console.log('Original:', original.toString());
  });
});
```

**2. Brotli:**
- **Type**: Lossless, LZ77 + Huffman coding + context modeling
- **Compression ratio**: 70-90% for text (better than Gzip)
- **Speed**: Slower compression, fast decompression
- **Browser support**: Chrome 49+, Firefox 44+, Edge 15+, Safari 11+
- **Use case**: Static assets, high-compression needs

```javascript
// Brotli in Node.js
const zlib = require('zlib');
const input = 'Some text to compress';

// Compress with Brotli
zlib.brotliCompress(input, { 
  params: {
    [zlib.constants.BROTLI_PARAM_QUALITY]: 11 // Max compression
  }
}, (err, compressed) => {
  console.log('Brotli compressed size:', compressed.length);
});
```

**3. Deflate:**
- **Type**: Lossless, same algorithm as Gzip without headers
- **Compression ratio**: Similar to Gzip
- **Speed**: Similar to Gzip
- **Browser support**: Universal but less commonly used
- **Use case**: Legacy systems, specific protocols

**4. Zstandard (Zstd):**
- **Type**: Lossless, finite state entropy coding
- **Compression ratio**: Better than Gzip, comparable to Brotli
- **Speed**: Very fast compression and decompression
- **Browser support**: Limited (not natively in browsers)
- **Use case**: Database compression, file storage, APIs

**5. LZ4:**
- **Type**: Lossless, focus on speed
- **Compression ratio**: Lower than Gzip (50-60%)
- **Speed**: Extremely fast compression and decompression
- **Browser support**: Not for web
- **Use case**: Real-time compression, gaming, databases

**6. Snappy:**
- **Type**: Lossless, focus on speed
- **Compression ratio**: Similar to LZ4
- **Speed**: Very fast, designed for speed
- **Browser support**: Not for web
- **Use case**: Big data, database compression

**Comparison table:**

| Algorithm | Best For | Compression | Speed | Browser Support |
|-----------|----------|-------------|-------|-----------------|
| **Gzip** | General web | Good (60-80%) | Fast | Universal |
| **Brotli** | Static assets | Excellent (70-90%) | Medium | Modern browsers |
| **Deflate** | Legacy systems | Good | Fast | Universal |
| **Zstd** | APIs, storage | Excellent | Very Fast | Limited |
| **LZ4** | Real-time | Fair | Extremely Fast | None |
| **Snappy** | Big data | Fair | Very Fast | None |

**Text compression performance:**

**Sample: 100KB JavaScript file**
- **Uncompressed**: 100KB
- **Gzip (level 6)**: 30KB (70% reduction)
- **Brotli (level 11)**: 25KB (75% reduction)
- **Zstd (level 3)**: 28KB (72% reduction)

**Compression levels:**

**Gzip levels (1-9):**
- **1**: Fastest, least compression
- **6**: Default, good balance
- **9**: Slowest, best compression

**Brotli levels (0-11):**
- **0**: Fastest, least compression
- **4**: Default for dynamic content
- **11**: Slowest, best compression (for static)

**Real-world usage patterns:**

**Static assets (CSS, JS, fonts):**
- **Build-time**: Brotli level 11 (maximum compression)
- **Served as**: `.js.br`, `.css.br` files
- **Reason**: Compress once, serve many times

**Dynamic content (API responses):**
- **Runtime**: Gzip level 6 or Brotli level 4
- **Compressed on-the-fly**
- **Reason**: Balance CPU usage with compression

**Large JSON responses:**
- **Brotli level 6**: Good balance for APIs
- **Cache compressed responses**: Avoid recompression

**Image compression (different algorithms):**

**Lossless:**
- **PNG**: DEFLATE algorithm
- **WebP lossless**: Better than PNG
- **AVIF lossless**: Best compression

**Lossy:**
- **JPEG**: Discrete cosine transform
- **WebP lossy**: 30% smaller than JPEG
- **AVIF lossy**: 50% smaller than JPEG

**Choosing the right algorithm:**

**For web applications:**
1. **Static assets**: Pre-compress with Brotli + Gzip fallback
2. **Dynamic content**: Gzip or Brotli with moderate level
3. **API responses**: Gzip (universal) or Brotli (modern clients)
4. **Images**: WebP or AVIF with fallbacks

**For Node.js backends:**
```javascript
// Check client support and choose best algorithm
function getBestCompression(acceptEncoding) {
  if (acceptEncoding.includes('br')) {
    return { algorithm: 'brotli', level: 6 };
  } else if (acceptEncoding.includes('gzip')) {
    return { algorithm: 'gzip', level: 6 };
  } else if (acceptEncoding.includes('deflate')) {
    return { algorithm: 'deflate', level: 6 };
  }
  return null; // No compression supported
}
```

**Real-world example:** Facebook uses Zstandard for their internal API communications and Brotli for public web assets, achieving optimal compression for each use case.

**Best practices:**
- **Support multiple algorithms**: Brotli for modern, Gzip for legacy
- **Pre-compress static files**: Better compression, no CPU overhead
- **Monitor compression ratios**: Ensure effectiveness
- **Test with real data**: Different content compresses differently
- **Consider CPU impact**: Higher compression = more CPU usage

**Remember:** There's no one-size-fits-all compression algorithm. The best choice depends on your content type, client capabilities, and performance requirements.

---

#### 4. How do you minify static assets?

**Answer:**

**Minification** removes unnecessary characters from code (whitespace, comments, formatting) without changing functionality, reducing file size and improving load times.

**What minification removes:**
- Whitespace (spaces, tabs, newlines)
- Comments (//, /* */)
- Block delimiters (optional semicolons, braces)
- Shortens variable names (in advanced minification)
- Removes dead code (unused functions)

**JavaScript minification example:**

**Before (1.2KB):**
```javascript
// Calculate total price
function calculateTotal(price, quantity, taxRate) {
  // Calculate subtotal
  const subtotal = price * quantity;
  
  // Calculate tax
  const tax = subtotal * taxRate;
  
  // Return total
  return subtotal + tax;
}

// Export function
module.exports = { calculateTotal };
```

**After minified (400 bytes - 67% reduction):**
```javascript
function calculateTotal(e,t,a){return e*t+e*t*a}module.exports={calculateTotal};
```

**Tools for minification:**

**1. Build tools (Webpack, Vite, Rollup):**
```javascript
// webpack.config.js - production mode automatically minifies
module.exports = {
  mode: 'production', // Enables minification
  optimization: {
    minimize: true,
    minimizer: [
      new TerserPlugin({ // For JavaScript
        terserOptions: {
          compress: {
            drop_console: true, // Remove console.log
          },
        },
      }),
      new CssMinimizerPlugin(), // For CSS
    ],
  },
};
```

**2. Standalone minifiers:**

**JavaScript:**
```bash
# Using terser
npx terser input.js -o output.min.js -c -m

# Using uglify-js  
npx uglify-js input.js -o output.min.js -c -m
```

**CSS:**
```bash
# Using cssnano
npx cssnano input.css output.min.css

# Using clean-css
npx cleancss -o output.min.css input.css
```

**HTML:**
```bash
# Using html-minifier
npx html-minifier --collapse-whitespace input.html -o output.min.html
```

**3. Express middleware for on-the-fly minification:**
```javascript
const minify = require('express-minify');
const compression = require('compression');

app.use(compression());
app.use(minify({
  cache: path.join(__dirname, 'cache'), // Cache minified files
  cssmin: require('cssmin'), // CSS minifier
  uglifyJs: require('uglify-js'), // JS minifier
  errorHandler: console.error // Error handling
}));

// Files served from public/ will be minified on first request
app.use(express.static('public'));
```

**4. Pre-minification during build (recommended):**
```javascript
// package.json scripts
{
  "scripts": {
    "build:js": "terser src/*.js -o dist/app.min.js -c -m",
    "build:css": "cleancss src/*.css -o dist/app.min.css",
    "build:html": "html-minifier --collapse-whitespace src/index.html -o dist/index.html",
    "build": "npm run build:js && npm run build:css && npm run build:html"
  }
}
```

**5. CDN minification (Cloudflare, AWS):**
```javascript
// Cloudflare Auto Minify
// Enable in dashboard: Speed > Optimization > Auto Minify
// Minifies HTML, CSS, JS automatically at edge

// AWS CloudFront + Lambda@Edge
// Can minify responses on-the-fly
```

**Advanced minification techniques:**

**1. Tree shaking (remove unused code):**
```javascript
// Webpack tree shaking
// Only includes used exports
import { usedFunction } from './library';
// unusedFunction not included in bundle
```

**2. Code splitting:**
```javascript
// Split code into chunks
// Load only what's needed
const module = await import('./heavy-module.js');
```

**3. Module concatenation:**
```javascript
// Combine multiple files
// Reduces HTTP requests
// webpack concatenates modules automatically
```

**4. Dead code elimination:**
```javascript
// Removes code that can never execute
if (false) {
  // This code removed during minification
  console.log('Never executed');
}
```

**Best practices for minification:**

**1. Development vs production:**
```javascript
// Use different configurations
if (process.env.NODE_ENV === 'production') {
  app.use(express.static('dist')); // Minified files
} else {
  app.use(express.static('src')); // Original files
}
```

**2. Source maps for debugging:**
```javascript
// Generate source maps
// webpack.config.js
module.exports = {
  devtool: 'source-map', // Creates .map files
  // Minified code with source maps for debugging
};
```

**3. Cache busting:**
```javascript
// Add hash to filename
// app.abc123.min.js instead of app.min.js
// Forces cache invalidation when file changes
```

**4. Compression after minification:**
```javascript
// Minify first, then compress
// Minification: 30% reduction
// Compression: Additional 70% reduction
// Combined: ~80% total reduction
```

**5. Monitor file sizes:**
```javascript
// Track minification effectiveness
const originalSize = fs.statSync('app.js').size;
const minifiedSize = fs.statSync('app.min.js').size;
const reduction = ((originalSize - minifiedSize) / originalSize * 100).toFixed(1);
console.log(`Minification: ${reduction}% reduction`);
```

**Common pitfalls:**

1. **Breaking functionality**: Over-aggressive minification
2. **No source maps**: Hard to debug minified code
3. **Caching issues**: Old minified files served
4. **Build complexity**: Complex minification pipelines
5. **Error messages**: Unreadable in minified code

**Real-world example:** Google's Closure Compiler performs advanced minification with type checking and optimization, reducing JavaScript file sizes by 80-90% for their applications.

**Performance impact:**
- **First visit**: Minification + compression = 80-90% smaller files
- **Repeat visits**: Cached minified files = instant loading
- **Mobile users**: Significant improvement on slow connections
- **SEO benefit**: Faster sites rank higher

**Remember:** Minification should be part of your build process, not done at runtime. Pre-minified files are faster to serve and reduce server CPU usage.

---

#### 5. What is Brotli compression and how does it compare to Gzip?

**Answer:**

**Brotli** is a modern compression algorithm developed by Google that provides better compression ratios than Gzip, especially for text-based web content.

**Key features of Brotli:**

1. **Better compression**: 20-26% better than Gzip for text
2. **Dictionary-based**: Includes common web terms (HTML tags, CSS properties)
3. **Context modeling**: Better prediction of next characters
4. **Variable quality levels**: 0-11 (higher = better compression)
5. **Fast decompression**: Similar speed to Gzip decompression

**Brotli vs Gzip comparison:**

| Feature | Brotli | Gzip |
|---------|--------|------|
| **Developer** | Google | GNU Project |
| **Release year** | 2015 | 1992 |
| **Algorithm** | LZ77 + Huffman + context modeling | DEFLATE (LZ77 + Huffman) |
| **Compression ratio** | 20-26% better | Baseline |
| **Compression speed** | Slower (especially high levels) | Faster |
| **Decompression speed** | Similar to Gzip | Fast |
| **Browser support** | Chrome 49+, Firefox 44+, Safari 11+ | Universal |
| **Quality levels** | 0-11 | 1-9 |
| **Static compression** | Level 11 (best) | Level 9 (best) |
| **Dynamic compression** | Level 4-6 (balanced) | Level 6 (balanced) |

**Compression performance comparison:**

**Sample: 100KB JavaScript file**
- **Uncompressed**: 100KB
- **Gzip (level 6)**: 30KB (70% reduction)
- **Brotli (level 11)**: 22KB (78% reduction)
- **Brotli advantage**: 8KB smaller (26% better)

**Sample: 50KB CSS file**
- **Uncompressed**: 50KB
- **Gzip (level 6)**: 10KB (80% reduction)
- **Brotli (level 11)**: 7KB (86% reduction)
- **Brotli advantage**: 3KB smaller (30% better)

**Implementation in Node.js:**

**1. Using `compression` middleware with Brotli:**
```javascript
const compression = require('compression');
const express = require('express');
const app = express();

// Enable Brotli if supported
app.use(compression({
  filter: (req, res) => {
    // Check if Brotli is supported
    const acceptEncoding = req.headers['accept-encoding'] || '';
    if (acceptEncoding.includes('br')) {
      res.setHeader('Content-Encoding', 'br');
    }
    return compression.filter(req, res);
  },
  // Brotli requires Node.js 10.16.0+ or 11.8.0+
  brotli: { 
    enabled: true,
    zlib: { level: 6 } // Brotli compression level
  }
}));
```

**2. Pre-compressing static files with Brotli:**
```bash
# Using brotli command line tool
brotli -k -f -q 11 input.js -o input.js.br

# Using node script
const zlib = require('zlib');
const fs = require('fs');

const input = fs.readFileSync('app.js');
zlib.brotliCompress(input, { 
  params: { 
    [zlib.constants.BROTLI_PARAM_QUALITY]: 11 
  } 
}, (err, compressed) => {
  fs.writeFileSync('app.js.br', compressed);
});
```

**3. Serving pre-compressed Brotli files:**
```javascript
const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();

app.use((req, res, next) => {
  const acceptEncoding = req.headers['accept-encoding'] || '';
  const filePath = path.join(__dirname, 'public', req.path);
  
  // Check for Brotli version first
  if (acceptEncoding.includes('br') && fs.existsSync(filePath + '.br')) {
    req.url = req.url + '.br';
    res.set('Content-Encoding', 'br');
    res.set('Vary', 'Accept-Encoding');
  } 
  // Fallback to Gzip
  else if (acceptEncoding.includes('gzip') && fs.existsSync(filePath + '.gz')) {
    req.url = req.url + '.gz';
    res.set('Content-Encoding', 'gzip');
    res.set('Vary', 'Accept-Encoding');
  }
  
  next();
});

app.use(express.static('public'));
```

**When to use Brotli vs Gzip:**

**Use Brotli when:**
1. **Static assets**: Pre-compress with level 11
2. **Modern browsers**: Chrome, Firefox, Safari, Edge
3. **High compression needed**: Text-heavy content
4. **Build-time compression**: No runtime overhead
5. **CDN supports it**: Cloudflare, AWS CloudFront

**Use Gzip when:**
1. **Universal compatibility**: Legacy browsers
2. **Dynamic content**: Faster compression
3. **CPU constraints**: Brotli compression is slower
4. **Fallback needed**: When Brotli not supported
5. **Simple setup**: Gzip is simpler to implement

**Browser support check:**
```javascript
function supportsBrotli(req) {
  const acceptEncoding = req.headers['accept-encoding'] || '';
  return acceptEncoding.includes('br');
}

function getBestCompression(req) {
  if (supportsBrotli(req)) {
    return 'br';
  } else if (req.headers['accept-encoding']?.includes('gzip')) {
    return 'gzip';
  }
  return null;
}
```

**Real-world adoption:**

**Companies using Brotli:**
- **Google**: Search, YouTube, Gmail
- **Facebook**: Web content
- **Cloudflare**: CDN compression
- **Netflix**: Web interface
- **WordPress.com**: Default compression

**Performance impact:**
- **Page load time**: 14-21% improvement over Gzip
- **Bandwidth savings**: 20-26% reduction
- **Mobile users**: Significant improvement on slow connections
- **SEO benefit**: Faster sites rank higher

**Best practices for Brotli implementation:**

1. **Pre-compress static assets**: Use level 11 for maximum compression
2. **Implement fallback**: Serve Gzip when Brotli not supported
3. **Use CDN Brotli**: Cloudflare, Fastly, AWS support Brotli
4. **Monitor adoption**: Track Brotli vs Gzip usage
5. **Test thoroughly**: Ensure compatibility with all clients

**Common issues:**
- **Node.js version**: Brotli requires Node.js 10.16.0+ or 11.8.0+
- **CPU overhead**: Higher compression levels use more CPU
- **Cache separate versions**: Need .br and .gz files
- **Configuration complexity**: More complex than Gzip-only

**Real-world example:** A large e-commerce site implemented Brotli compression and reduced their page weight by 24%, resulting in 17% faster page loads and 12% increase in conversions.

**Remember:** Brotli provides significant compression improvements over Gzip for text-based web content. Implement it for static assets first, then consider for dynamic content if your infrastructure can handle the CPU overhead.

---
## 43. Database Optimization

#### 1. How do you optimize database queries in Node.js?

**Answer:**

**Database query optimization** in Node.js involves improving the performance and efficiency of database operations through various techniques at both application and database levels.

**Application-level optimization:**

**1. Use connection pooling:**
```javascript
// PostgreSQL with pg-pool
const { Pool } = require('pg');
const pool = new Pool({
  max: 20, // Maximum connections
  idleTimeoutMillis: 30000, // Close idle connections
  connectionTimeoutMillis: 2000, // Connection timeout
});

// Reuse connections instead of creating new ones
async function getUser(id) {
  const client = await pool.connect();
  try {
    const result = await client.query('SELECT * FROM users WHERE id = $1', [id]);
    return result.rows[0];
  } finally {
    client.release(); // Return to pool
  }
}
```

**2. Implement query caching:**
```javascript
// Redis cache for frequent queries
const Redis = require('ioredis');
const redis = new Redis();

async function getProductWithCache(id) {
  const cacheKey = `product:${id}`;
  
  // Try cache first
  const cached = await redis.get(cacheKey);
  if (cached) return JSON.parse(cached);
  
  // Query database
  const product = await db.products.findByPk(id);
  
  // Cache for 5 minutes
  if (product) {
    await redis.setex(cacheKey, 300, JSON.stringify(product));
  }
  
  return product;
}
```

**3. Use prepared statements:**
```javascript
// PostgreSQL prepared statement
const statement = await pool.query('PREPARE user_query AS SELECT * FROM users WHERE id = $1');
const result = await pool.query('EXECUTE user_query($1)', [userId]);

// MySQL prepared statement
const [rows] = await connection.execute(
  'SELECT * FROM products WHERE category = ? AND price > ?',
  ['electronics', 100]
);
```

**4. Batch operations:**
```javascript
// Instead of multiple single inserts
// BAD: for (const user of users) { await db.insert(user); }

// GOOD: Batch insert
await db.users.bulkCreate(users);

// Or using INSERT multiple rows
await db.query(`
  INSERT INTO users (name, email) VALUES 
  ${users.map((_, i) => `($${i*2+1}, $${i*2+2})`).join(',')}
`, users.flatMap(u => [u.name, u.email]));
```

**5. Pagination for large results:**
```javascript
// Offset pagination (simple)
app.get('/api/products', async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 20;
  const offset = (page - 1) * limit;
  
  const products = await db.products.findAll({
    limit,
    offset,
    order: [['created_at', 'DESC']]
  });
  
  res.json(products);
});

// Cursor-based pagination (better performance)
app.get('/api/products', async (req, res) => {
  const cursor = req.query.cursor;
  const limit = parseInt(req.query.limit) || 20;
  
  const where = cursor ? { id: { [Op.gt]: cursor } } : {};
  const products = await db.products.findAll({
    where,
    limit,
    order: [['id', 'ASC']]
  });
  
  const nextCursor = products.length > 0 ? products[products.length - 1].id : null;
  res.json({ products, nextCursor });
});
```

**Database-level optimization:**

**1. Add appropriate indexes:**
```sql
-- Create indexes on frequently queried columns
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_products_category_price ON products(category, price);
```

**2. Analyze query execution plans:**
```sql
-- PostgreSQL EXPLAIN
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'test@example.com';

-- MySQL EXPLAIN
EXPLAIN SELECT * FROM users WHERE email = 'test@example.com';
```

**3. Normalize/denormalize appropriately:**
- **Normalize**: Reduce redundancy (better for writes)
- **Denormalize**: Reduce joins (better for reads)
- **Choose based on read/write ratio**

**4. Partition large tables:**
```sql
-- Partition by date range
CREATE TABLE orders_2024 PARTITION OF orders
FOR VALUES FROM ('2024-01-01') TO ('2024-12-31');
```

**5. Update statistics:**
```sql
-- PostgreSQL
ANALYZE users;

-- MySQL
ANALYZE TABLE users;
```

**Real-world example:** An e-commerce site optimized their product search query by adding composite indexes, implementing Redis caching, and using prepared statements, reducing query time from 2 seconds to 50 milliseconds.

**Best practices:**
1. **Profile before optimizing**: Identify actual bottlenecks
2. **Use EXPLAIN/ANALYZE**: Understand query execution
3. **Implement monitoring**: Track slow queries
4. **Test with production data**: Synthetic data may not reveal issues
5. **Review regularly**: Optimization is ongoing, not one-time

**Common optimization mistakes:**
- **Over-indexing**: Too many indexes slow down writes
- **N+1 queries**: Fetching related data in loops
- **SELECT ***: Fetching unnecessary columns
- **No connection pooling**: Creating new connections per query
- **Ignoring database configuration**: Default settings not optimized

**Remember:** Database optimization requires understanding both your application patterns and database capabilities. Measure, analyze, then optimize based on actual performance data.

---

#### 2. What are database indexes and when should you use them?

**Answer:**

**Database indexes** are data structures that improve the speed of data retrieval operations on database tables. They work like a book's index, allowing the database to find data without scanning the entire table.

**How indexes work:**
1. Without index: Database scans entire table (full table scan)
2. With index: Database uses index to find data directly (index seek)
3. Index stores sorted values with pointers to actual rows

**Types of indexes:**

**1. B-tree indexes (most common):**
- Balanced tree structure
- Good for equality and range queries
- Default index type in most databases

**2. Hash indexes:**
- For equality comparisons only
- Very fast for exact matches
- Not for range queries

**3. GiST (Generalized Search Tree):**
- For complex data types (geospatial, full-text)
- PostgreSQL specific

**4. GIN (Generalized Inverted Index):**
- For array and full-text search
- PostgreSQL specific

**5. Composite indexes:**
- Index on multiple columns
- Order matters: (category, price) ≠ (price, category)

**Creating indexes:**
```sql
-- Single column index
CREATE INDEX idx_users_email ON users(email);

-- Composite index
CREATE INDEX idx_orders_user_date ON orders(user_id, order_date);

-- Unique index
CREATE UNIQUE INDEX idx_users_username ON users(username);

-- Partial index (only on subset)
CREATE INDEX idx_active_users ON users(email) WHERE active = true;
```

**When to use indexes:**

**1. Frequently queried columns:**
```sql
-- If you often query by email
SELECT * FROM users WHERE email = 'test@example.com';
-- Create: CREATE INDEX idx_users_email ON users(email);
```

**2. Foreign key columns:**
```sql
-- For JOIN operations
SELECT * FROM orders 
JOIN users ON orders.user_id = users.id;
-- Create: CREATE INDEX idx_orders_user_id ON orders(user_id);
```

**3. Columns in WHERE clauses:**
```sql
-- Equality checks
WHERE status = 'active'

-- Range queries  
WHERE created_at > '2024-01-01'

-- IN clauses
WHERE category IN ('electronics', 'books')
```

**4. Columns in ORDER BY:**
```sql
-- Sorting large results
ORDER BY created_at DESC
-- Create: CREATE INDEX idx_users_created ON users(created_at);
```

**5. Columns in JOIN conditions:**
```sql
-- JOIN performance
ON users.id = orders.user_id
-- Index both sides if possible
```

**When NOT to use indexes:**

**1. Small tables:**
- Table fits in memory
- Full scan is fast anyway
- Index overhead not justified

**2. Frequently updated tables:**
- Indexes slow down INSERT/UPDATE/DELETE
- Each modification updates indexes
- Balance read vs write performance

**3. Columns with low cardinality:**
- Boolean columns (true/false)
- Gender columns (M/F)
- Index provides little benefit

**4. Columns rarely queried:**
- Historical data
- Audit columns
- Don't index "just in case"

**Index best practices:**

**1. Choose the right columns:**
- High cardinality columns (many unique values)
- Frequently filtered columns
- Join and sort columns

**2. Consider composite indexes:**
```sql
-- Query: WHERE category = 'electronics' AND price > 100
-- Good: CREATE INDEX idx_category_price ON products(category, price);
-- Bad: Separate indexes on category and price
```

**3. Monitor index usage:**
```sql
-- PostgreSQL
SELECT * FROM pg_stat_user_indexes;

-- MySQL
SHOW INDEX FROM table_name;
```

**4. Maintain indexes:**
```sql
-- Rebuild fragmented indexes
REINDEX INDEX idx_users_email;

-- Update statistics
ANALYZE users;
```

**5. Test before deploying:**
- Measure query performance
- Compare with and without index
- Consider write performance impact

**Real-world example:** A social media platform added indexes on user_id and created_at columns for their posts table, reducing feed loading time from 3 seconds to 200 milliseconds for users with thousands of posts.

**Index costs:**
- **Storage**: Indexes take disk space
- **Write performance**: Slower INSERT/UPDATE/DELETE
- **Maintenance**: Need rebuilding, statistics updates
- **Complexity**: More indexes = harder to manage

**Common index mistakes:**

**1. Over-indexing:**
```sql
-- Too many indexes
CREATE INDEX idx_col1 ON table(col1);
CREATE INDEX idx_col2 ON table(col2);
CREATE INDEX idx_col3 ON table(col3);
-- Each insert updates 3 indexes
```

**2. Wrong column order:**
```sql
-- Query: WHERE category = 'x' ORDER BY price
-- Bad: CREATE INDEX idx_price_category ON products(price, category);
-- Good: CREATE INDEX idx_category_price ON products(category, price);
```

**3. Not considering query patterns:**
- Indexing based on table structure, not actual queries
- Not analyzing EXPLAIN plans
- Missing composite indexes for common query combinations

**4. Ignoring index maintenance:**
- Fragmented indexes
- Outdated statistics
- Unused indexes consuming resources

**Remember:** Indexes are a trade-off between read performance and write performance. Create indexes based on actual query patterns, monitor their effectiveness, and remove unused indexes.

---

#### 3. How do you monitor slow queries?

**Answer:**

**Monitoring slow queries** is essential for identifying performance bottlenecks and optimizing database performance. Slow queries can indicate missing indexes, poor query design, or database configuration issues.

**Monitoring approaches:**

**1. Database slow query logs:**

**MySQL slow query log:**
```sql
-- Enable slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 2; -- Queries taking >2 seconds
SET GLOBAL slow_query_log_file = '/var/log/mysql/slow.log';

-- Check current settings
SHOW VARIABLES LIKE 'slow_query_log%';
SHOW VARIABLES LIKE 'long_query_time';
```

**PostgreSQL slow queries:**
```sql
-- Enable logging in postgresql.conf
log_min_duration_statement = 2000 -- Log queries >2 seconds
log_statement = 'all' -- Or 'mod', 'ddl', 'none'

-- Check running slow queries
SELECT pid, now() - pg_stat_activity.query_start AS duration, query
FROM pg_stat_activity
WHERE (now() - pg_stat_activity.query_start) > interval '2 seconds';
```

**2. Application-level monitoring:**

**Express middleware for query timing:**
```javascript
const queryLogger = (req, res, next) => {
  const start = Date.now();
  const originalSend = res.send;
  
  res.send = function(data) {
    const duration = Date.now() - start;
    
    if (duration > 1000) { // Log slow requests >1 second
      console.warn(`SLOW REQUEST: ${req.method} ${req.path} - ${duration}ms`);
      console.warn(`Query: ${req.body?.query || 'N/A'}`);
      console.warn(`User: ${req.user?.id || 'anonymous'}`);
    }
    
    originalSend.call(this, data);
  };
  
  next();
};

app.use(queryLogger);
```

**3. ORM/ODM logging:**

**Sequelize query logging:**
```javascript
const sequelize = new Sequelize(database, username, password, {
  logging: (sql, timing) => {
    if (timing > 1000) { // Log slow queries >1 second
      console.warn(`SLOW QUERY (${timing}ms): ${sql}`);
    }
  },
  benchmark: true // Enable timing
});
```

**Mongoose query logging:**
```javascript
mongoose.set('debug', (collectionName, method, query, doc) => {
  console.log(`${collectionName}.${method}`, JSON.stringify(query));
});

// Or with timing
mongoose.set('debug', function(collectionName, method, query, queryOptions) {
  const start = Date.now();
  
  return function(err, result, millis) {
    if (millis > 1000) {
      console.warn(`SLOW MONGOOSE QUERY (${millis}ms):`, {
        collection: collectionName,
        method: method,
        query: query,
        duration: millis
      });
    }
  };
});
```

**4. APM (Application Performance Monitoring) tools:**

**Using New Relic:**
```javascript
// Install newrelic package
require('newrelic');

// Configuration in newrelic.js
exports.config = {
  app_name: ['My Application'],
  license_key: 'your-license-key',
  logging: {
    level: 'info'
  },
  transaction_tracer: {
    enabled: true,
    transaction_threshold: 1, // Report transactions >1 second
    record_sql: 'obfuscated'
  }
};
```

**Using Datadog:**
```javascript
// Install dd-trace
const tracer = require('dd-trace').init({
  service: 'my-node-app',
  logInjection: true
});

// Automatically traces database queries
```

**5. Custom monitoring system:**

**Query performance tracking:**
```javascript
class QueryMonitor {
  constructor() {
    this.slowQueries = [];
    this.threshold = 1000; // 1 second
  }
  
  trackQuery(query, params, duration) {
    if (duration > this.threshold) {
      const slowQuery = {
        query,
        params,
        duration,
        timestamp: new Date().toISOString(),
        stack: new Error().stack // Capture call stack
      };
      
      this.slowQueries.push(slowQuery);
      this.alertIfNeeded(slowQuery);
      
      // Log to file or external service
      this.logToFile(slowQuery);
    }
  }
  
  alertIfNeeded(query) {
    // Send alert if query is extremely slow
    if (query.duration > 5000) {
      this.sendAlert(`Critical slow query: ${query.duration}ms`, query);
    }
  }
  
  getStats() {
    return {
      totalSlowQueries: this.slowQueries.length,
      averageDuration: this.slowQueries.reduce((a, b) => a + b.duration, 0) / this.slowQueries.length,
      recentQueries: this.slowQueries.slice(-10)
    };
  }
}

// Usage
const monitor = new QueryMonitor();

app.use((req, res, next) => {
  const start = Date.now();
  res.on('finish', () => {
    const duration = Date.now() - start;
    monitor.trackQuery(req.originalUrl, req.query, duration);
  });
  next();
});
```

**6. Database performance views:**

**PostgreSQL pg_stat_statements:**
```sql
-- Enable extension
CREATE EXTENSION pg_stat_statements;

-- View slowest queries
SELECT query, calls, total_time, mean_time, rows
FROM pg_stat_statements
ORDER BY mean_time DESC
LIMIT 10;

-- Reset statistics
SELECT pg_stat_statements_reset();
```

**MySQL performance_schema:**
```sql
-- View statement statistics
SELECT * FROM performance_schema.events_statements_summary_by_digest
ORDER BY SUM_TIMER_WAIT DESC
LIMIT 10;
```

**Real-world monitoring setup:**

**Production monitoring stack:**
1. **Database logs**: Slow query logs enabled
2. **APM tool**: New Relic/Datadog for real-time monitoring
3. **Custom middleware**: Application-level query timing
4. **Alerting**: Slack/email alerts for critical slow queries
5. **Dashboard**: Grafana dashboard with query performance metrics

**Best practices for monitoring slow queries:**

1. **Set appropriate thresholds**: Based on your SLA
2. **Include context**: User, endpoint, parameters
3. **Regular review**: Weekly analysis of slow queries
4. **Automate alerts**: For critical performance issues
5. **Correlate with load**: Check if slow during peak traffic
6. **Test fixes**: Verify optimizations work
7. **Document patterns**: Common slow query patterns and fixes

**Common slow query patterns to monitor:**

1. **Full table scans**: Missing indexes
2. **N+1 queries**: Fetching related data in loops
3. **Large result sets**: No pagination/limits
4. **Complex joins**: Too many tables joined
5. **Suboptimal indexes**: Wrong index type or columns
6. **Lock contention**: Queries waiting for locks
7. **Resource exhaustion**: Memory/CPU/disk issues

**Remember:** Monitoring is not just about detecting slow queries, but understanding why they're slow and taking action to fix them. Regular analysis and optimization should be part of your development workflow.

---

#### 4. What is query optimization and how do you approach it?

**Answer:**

**Query optimization** is the process of improving database query performance through analysis, restructuring, and configuration changes. It involves understanding how queries execute and making changes to reduce execution time and resource usage.

**Query optimization approach:**

**1. Identify problematic queries:**
```javascript
// Use monitoring tools to find slow queries
const slowQueries = await getSlowQueriesFromLogs();
// Focus on queries that are:
// - Frequently executed
// - Taking longest time
// - Consuming most resources
```

**2. Analyze query execution plans:**

**PostgreSQL EXPLAIN:**
```sql
EXPLAIN ANALYZE
SELECT * FROM orders 
WHERE user_id = 123 
AND created_at > '2024-01-01'
ORDER BY total_amount DESC;
```

**Output analysis:**
```
Seq Scan on orders  (cost=0.00..1254.32 rows=1 width=48) (actual time=15.234..15.234 rows=0 loops=1)
  Filter: ((user_id = 123) AND (created_at > '2024-01-01'::date))
  Rows Removed by Filter: 10000
Planning Time: 0.156 ms
Execution Time: 15.267 ms
```
- **Seq Scan**: Full table scan (bad for large tables)
- **Rows Removed**: 10000 rows scanned, 0 returned (inefficient)
- **Execution Time**: 15ms (could be improved with index)

**3. Apply optimization techniques:**

**Add appropriate indexes:**
```sql
-- Based on WHERE clause and ORDER BY
CREATE INDEX idx_orders_user_created ON orders(user_id, created_at);
-- After index: Index Scan instead of Seq Scan
```

**Rewrite queries:**
```sql
-- Original: Multiple OR conditions
SELECT * FROM products 
WHERE category = 'electronics' 
   OR category = 'books' 
   OR category = 'clothing';

-- Optimized: Use IN clause
SELECT * FROM products 
WHERE category IN ('electronics', 'books', 'clothing');

-- Even better: If index exists on category
```

**Reduce result set:**
```sql
-- Original: SELECT * (all columns)
SELECT * FROM users WHERE active = true;

-- Optimized: Select only needed columns
SELECT id, name, email FROM users WHERE active = true;

-- Add LIMIT if full set not needed
SELECT id, name, email FROM users WHERE active = true LIMIT 100;
```

**4. Optimize JOIN operations:**

**Ensure join columns are indexed:**
```sql
-- Query with JOIN
SELECT u.name, o.total 
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE u.country = 'US';

-- Indexes needed:
CREATE INDEX idx_users_country ON users(country);
CREATE INDEX idx_orders_user_id ON orders(user_id);
```

**Use appropriate JOIN type:**
```sql
-- Use INNER JOIN when possible (faster than OUTER JOIN)
-- Use EXISTS instead of IN for subqueries when checking existence
SELECT * FROM products p
WHERE EXISTS (
  SELECT 1 FROM inventory i 
  WHERE i.product_id = p.id AND i.quantity > 0
);
```

**5. Batch operations:**

**Instead of multiple single updates:**
```javascript
// BAD: Multiple queries
for (const item of cartItems) {
  await db.query('UPDATE inventory SET quantity = quantity - $1 WHERE product_id = $2', 
    [item.quantity, item.productId]);
}

// GOOD: Single batch update
await db.query(`
  UPDATE inventory 
  SET quantity = quantity - updates.quantity
  FROM (VALUES ${cartItems.map((_, i) => `($${i*2+1}, $${i*2+2})`).join(',')}) 
    AS updates(product_id, quantity)
  WHERE inventory.product_id = updates.product_id::integer
`, cartItems.flatMap(item => [item.productId, item.quantity]));
```

**6. Use query hints (when necessary):**
```sql
-- PostgreSQL query hints
SELECT /*+ IndexScan(users idx_users_email) */ * 
FROM users 
WHERE email = 'test@example.com';

-- MySQL force index
SELECT * FROM users FORCE INDEX (idx_users_email) 
WHERE email = 'test@example.com';
```

**7. Database configuration optimization:**

**PostgreSQL configuration:**
```conf
# postgresql.conf
shared_buffers = 4GB          # 25% of RAM
work_mem = 64MB               # For sorting operations
maintenance_work_mem = 1GB    # For index creation
effective_cache_size = 12GB   # Estimate of available cache
```

**MySQL configuration:**
```conf
# my.cnf
innodb_buffer_pool_size = 4G
innodb_log_file_size = 512M
query_cache_size = 128M
tmp_table_size = 256M
max_heap_table_size = 256M
```

**8. Regular maintenance:**

**Update statistics:**
```sql
-- PostgreSQL
ANALYZE users;

-- MySQL
ANALYZE TABLE users;
```

**Rebuild indexes:**
```sql
-- PostgreSQL
REINDEX INDEX idx_users_email;

-- MySQL
OPTIMIZE TABLE users;
```

**Real-world optimization example:**

**Problem:** User search query taking 5+ seconds
```sql
SELECT * FROM users 
WHERE first_name LIKE '%john%' 
   OR last_name LIKE '%john%' 
   OR email LIKE '%john%'
ORDER BY created_at DESC;
```

**Optimization steps:**

1. **Add full-text search index:**
```sql
CREATE INDEX idx_users_search ON users 
USING gin(to_tsvector('english', first_name || ' ' || last_name || ' ' || email));
```

2. **Rewrite query using full-text search:**
```sql
SELECT * FROM users 
WHERE to_tsvector('english', first_name || ' ' || last_name || ' ' || email) 
      @@ to_tsquery('john:*')
ORDER BY created_at DESC;
```

3. **Result:** Query time reduced from 5 seconds to 50 milliseconds

**Best practices for query optimization:**

1. **Measure first**: Don't optimize without metrics
2. **Use EXPLAIN/ANALYZE**: Understand execution plans
3. **Test with production data**: Synthetic data may not reveal issues
4. **Consider trade-offs**: Indexes improve reads but slow writes
5. **Monitor after changes**: Ensure optimizations work in production
6. **Document optimizations**: For team knowledge and future reference
7. **Regular review**: Performance degrades over time

**Common optimization mistakes:**

1. **Premature optimization**: Optimizing without profiling
2. **Over-indexing**: Too many indexes hurting write performance
3. **Ignoring database configuration**: Default settings not optimal
4. **Not considering data growth**: Optimizations that don't scale
5. **Missing composite indexes**: Indexing single columns instead of combinations
6. **Not updating statistics**: Outdated statistics cause poor plans
7. **Forgetting about maintenance**: Index fragmentation, table bloat

**Remember:** Query optimization is an iterative process: measure, analyze, optimize, verify. Regular maintenance and monitoring are as important as the initial optimization.

---

#### 5. How do you handle database connection timeouts?

**Answer:**

**Database connection timeouts** occur when database operations take too long to complete or when connections remain idle too long. Proper timeout handling prevents resource exhaustion and improves application resilience.

**Types of timeouts to handle:**

**1. Connection timeout:** Time to establish connection
**2. Query timeout:** Time for query to execute
**3. Idle timeout:** Time connection can remain idle
**4. Pool timeout:** Time to wait for available connection

**Implementation strategies:**

**1. Connection pooling with timeouts:**
```javascript
// PostgreSQL with pg-pool
const { Pool } = require('pg');

const pool = new Pool({
  host: 'localhost',
  port: 5432,
  database: 'mydb',
  user: 'user',
  password: 'password',
  
  // Timeout configurations
  connectionTimeoutMillis: 5000, // 5 seconds to connect
  idleTimeoutMillis: 30000, // Close idle connections after 30 seconds
  max: 20, // Maximum connections
  min: 4, // Minimum connections
  
  // Query timeout (via statement_timeout)
  statement_timeout: 10000, // 10 seconds query timeout
});
```

**2. Query timeout middleware:**
```javascript
// Express middleware for query timeout
const queryTimeout = (timeoutMs = 10000) => {
  return (req, res, next) => {
    const timeoutId = setTimeout(() => {
      if (!res.headersSent) {
        res.status(504).json({
          error: 'Database query timeout',
          message: `Query exceeded ${timeoutMs}ms timeout`
        });
      }
    }, timeoutMs);
    
    // Clear timeout on response
    res.on('finish', () => clearTimeout(timeoutId));
    res.on('close', () => clearTimeout(timeoutId));
    
    next();
  };
};

// Apply to specific routes
app.get('/api/complex-report', queryTimeout(30000), getComplexReport);
```

**3. Database driver timeouts:**

**MySQL with mysql2:**
```javascript
const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'password',
  database: 'test',
  
  // Timeout configurations
  connectTimeout: 10000, // 10 seconds connection timeout
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  
  // Enable query timeout
  enableKeepAlive: true,
  keepAliveInitialDelay: 0,
});
```

**MongoDB with mongoose:**
```javascript
const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/test', {
  // Timeout options
  connectTimeoutMS: 10000, // 10 seconds connection timeout
  socketTimeoutMS: 45000, // 45 seconds socket timeout
  
  // Pool options
  maxPoolSize: 10,
  minPoolSize: 2,
  maxIdleTimeMS: 30000, // Close idle connections after 30 seconds
  
  // Server selection timeout
  serverSelectionTimeoutMS: 5000, // 5 seconds to select server
});
```

**4. Retry logic with exponential backoff:**
```javascript
async function executeWithRetry(queryFn, maxRetries = 3) {
  let lastError;
  
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await queryFn();
    } catch (error) {
      lastError = error;
      
      // Check if error is timeout-related
      if (error.code === 'ETIMEDOUT' || 
          error.code === 'ECONNRESET' ||
          error.message.includes('timeout')) {
        
        if (attempt < maxRetries) {
          // Exponential backoff: 100ms, 200ms, 400ms, etc.
          const delay = Math.pow(2, attempt) * 100;
          await new Promise(resolve => setTimeout(resolve, delay));
          continue;
        }
      }
      
      // Not a timeout error or max retries reached
      throw error;
    }
  }
  
  throw lastError;
}

// Usage
const result = await executeWithRetry(() => {
  return db.query('SELECT * FROM large_table');
});
```

**5. Circuit breaker pattern:**
```javascript
class CircuitBreaker {
  constructor(timeout, failureThreshold, resetTimeout) {
    this.timeout = timeout;
    this.failureThreshold = failureThreshold;
    this.resetTimeout = resetTimeout;
    this.failureCount = 0;
    this.state = 'CLOSED'; // CLOSED, OPEN, HALF_OPEN
    this.nextAttempt = Date.now();
  }
  
  async execute(queryFn) {
    if (this.state === 'OPEN') {
      if (Date.now() > this.nextAttempt) {
        this.state = 'HALF_OPEN';
      } else {
        throw new Error('Circuit breaker is OPEN');
      }
    }
    
    try {
      const timeoutPromise = new Promise((_, reject) => {
        setTimeout(() => reject(new Error('Timeout')), this.timeout);
      });
      
      const result = await Promise.race([queryFn(), timeoutPromise]);
      
      // Success - reset failure count
      this.failureCount = 0;
      this.state = 'CLOSED';
      return result;
      
    } catch (error) {
      this.failureCount++;
      
      if (this.failureCount >= this.failureThreshold) {
        this.state = 'OPEN';
        this.nextAttempt = Date.now() + this.resetTimeout;
      }
      
      throw error;
    }
  }
}

// Usage
const breaker = new CircuitBreaker(5000, 3, 30000);
const result = await breaker.execute(() => db.query('SELECT * FROM users'));
```

**6. Health checks and monitoring:**
```javascript
// Database health check endpoint
app.get('/health/database', async (req, res) => {
  const startTime = Date.now();
  
  try {
    // Simple query to check database health
    await db.query('SELECT 1');
    const responseTime = Date.now() - startTime;
    
    res.json({
      status: 'healthy',
      responseTime: `${responseTime}ms`,
      timestamp: new Date().toISOString()
    });
    
  } catch (error) {
    res.status(503).json({
      status: 'unhealthy',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
});
```

**7. Graceful degradation:**
```javascript
// Fallback when database is slow/unavailable
async function getProductsWithFallback() {
  try {
    // Try primary database with timeout
    const timeoutPromise = new Promise((_, reject) => {
      setTimeout(() => reject(new Error('Timeout')), 5000);
    });
    
    const products = await Promise.race([
      db.products.findAll(),
      timeoutPromise
    ]);
    
    return products;
    
  } catch (error) {
    // Fallback to cache or static data
    console.warn('Database timeout, using cache:', error.message);
    
    const cached = await redis.get('products:fallback');
    if (cached) return JSON.parse(cached);
    
    // Ultimate fallback
    return getStaticProductData();
  }
}
```

**Best practices for timeout handling:**

1. **Set appropriate timeouts**: Based on query complexity and SLA
2. **Implement retry logic**: For transient failures
3. **Use circuit breakers**: Prevent cascading failures
4. **Monitor timeout rates**: Alert on increasing timeouts
5. **Implement graceful degradation**: Fallback mechanisms
6. **Test timeout scenarios**: Simulate slow database responses
7. **Document timeout policies**: For team understanding

**Common timeout scenarios and solutions:**

**1. Slow queries:**
- **Solution**: Add indexes, optimize queries, increase timeout
- **Monitoring**: Track query execution times

**2. Connection pool exhaustion:**
- **Solution**: Increase pool size, implement queue, add timeout
- **Monitoring**: Track pool usage and wait times

**3. Network issues:**
- **Solution**: Retry logic, circuit breakers, health checks
- **Monitoring**: Network latency, error rates

**4. Database maintenance:**
- **Solution**: Read replicas, maintenance windows, notifications
- **Monitoring**: Scheduled maintenance tracking

**Real-world example:** A financial application uses 5-second query timeouts for most operations, with circuit breakers that open after 3 consecutive timeouts, falling back to cached data while alerting the operations team.

**Remember:** Timeout handling is about balancing user experience with system stability. Too short timeouts cause unnecessary failures; too long timeouts cause resource exhaustion. Monitor and adjust based on actual performance data.

---
## 44. Memory Leak Detection & Prevention

#### 1. What are common causes of memory leaks in Node.js?

**Answer:**

**Memory leaks** occur when memory is allocated but never released, causing the application's memory usage to grow continuously until it crashes or becomes unresponsive.

**Common causes in Node.js:**

**1. Global variables:**
```javascript
// Accidental global variable
function createUser() {
  user = { name: 'John' }; // Missing 'var', 'let', 'const'
  // 'user' becomes global, never garbage collected
}

// Global array accumulating data
global.users = []; // Never cleared
```

**2. Closures holding references:**
```javascript
function createClosure() {
  const largeData = new Array(1000000).fill('data');
  
  return function() {
    // Closure holds reference to largeData
    console.log('Closure created');
  };
}

const closures = [];
for (let i = 0; i < 1000; i++) {
  closures.push(createClosure()); // Each holds largeData
}
```

**3. Event listeners not removed:**
```javascript
const EventEmitter = require('events');
const emitter = new EventEmitter();

function createListener() {
  const data = new Array(10000).fill('data');
  
  emitter.on('event', () => {
    // Listener holds reference to data
    console.log(data.length);
  });
}

// Never removing listeners
createListener();
createListener();
createListener();
// Each listener holds its own 'data' array
```

**4. Timers and intervals:**
```javascript
// Never cleared intervals
setInterval(() => {
  const data = new Array(1000).fill('data');
  // Data created every interval, never cleared
}, 1000);

// Or setTimeout chains that never stop
function recursiveTimeout() {
  const data = new Array(1000).fill('data');
  setTimeout(recursiveTimeout, 1000);
}
```

**5. Caches without limits:**
```javascript
// Unlimited cache growth
const cache = new Map();

app.get('/data/:id', (req, res) => {
  const data = fetchData(req.params.id);
  cache.set(req.params.id, data); // Never removed
  res.json(data);
});
```

**6. Database connections not closed:**
```javascript
// Connections never released
async function queryDatabase() {
  const connection = await getConnection();
  const result = await connection.query('SELECT * FROM users');
  // Forgot to release connection
  return result;
}
```

**7. Streams not properly handled:**
```javascript
// Readable streams not consumed
const stream = fs.createReadStream('largefile.txt');
stream.on('data', (chunk) => {
  // If not consumed, chunks accumulate
});

// Or not closing writable streams
const writer = fs.createWriteStream('output.txt');
// Never calling writer.end()
```

**8. Circular references:**
```javascript
// Objects referencing each other
let obj1 = { name: 'Object 1' };
let obj2 = { name: 'Object 2' };

obj1.ref = obj2;
obj2.ref = obj1;
// Neither can be garbage collected
```

**9. Third-party libraries:**
- Libraries with memory leaks
- Native addons not freeing memory
- Improper use of buffers or native resources

**10. Worker threads not terminated:**
```javascript
const { Worker } = require('worker_threads');

for (let i = 0; i < 100; i++) {
  const worker = new Worker('./worker.js');
  // Workers never terminated
}
```

**Real-world example:** A Node.js API server had a memory leak where each request added data to a global array that was never cleared, causing the server to crash every 24 hours when it ran out of memory.

**Detection signs:**
- Memory usage grows over time
- Garbage collection runs more frequently
- Application slows down
- Eventually crashes with "JavaScript heap out of memory"

**Prevention strategies:**
1. **Avoid global variables**: Use local scope
2. **Remove event listeners**: When no longer needed
3. **Clear timers**: `clearInterval()`, `clearTimeout()`
4. **Limit cache size**: Implement LRU or TTL
5. **Close resources**: Database connections, file handles
6. **Monitor memory**: Regular profiling
7. **Test with load**: Simulate production usage

**Remember:** Memory leaks are often subtle and only appear under sustained load. Regular monitoring and profiling are essential for detection and prevention.

---

#### 2. How do you detect memory leaks in Node.js?

**Answer:**

**Memory leak detection** involves monitoring memory usage patterns and identifying abnormal growth that indicates unreleased memory.

**Detection methods:**

**1. Built-in monitoring:**
```javascript
// Track memory usage
setInterval(() => {
  const memory = process.memoryUsage();
  console.log({
    rss: `${Math.round(memory.rss / 1024 / 1024)} MB`,
    heapTotal: `${Math.round(memory.heapTotal / 1024 / 1024)} MB`,
    heapUsed: `${Math.round(memory.heapUsed / 1024 / 1024)} MB`,
    external: `${Math.round(memory.external / 1024 / 1024)} MB`
  });
}, 5000);

// Monitor for warnings
process.on('warning', (warning) => {
  if (warning.name === 'MaxListenersExceededWarning') {
    console.warn('Possible memory leak: Too many listeners');
  }
});
```

**2. Heap snapshots comparison:**
```bash
# Take heap snapshot
node --inspect app.js
# Open chrome://inspect
# Take snapshot, perform actions, take another snapshot
# Compare to find growing objects
```

**3. Using `node-memwatch` or `heapdump`:**
```javascript
const heapdump = require('heapdump');

// Take snapshot on signal
process.on('SIGUSR2', () => {
  const filename = `heapdump-${Date.now()}.heapsnapshot`;
  heapdump.writeSnapshot(filename, (err) => {
    if (err) console.error(err);
    else console.log(`Heap snapshot written to ${filename}`);
  });
});

// Or programmatically
setInterval(() => {
  heapdump.writeSnapshot(`heap-${Date.now()}.heapsnapshot`);
}, 30000); // Every 30 seconds
```

**4. Chrome DevTools:**
```bash
# Start with inspector
node --inspect app.js

# Or remote debugging
node --inspect=0.0.0.0:9229 app.js
```
- Open `chrome://inspect`
- Connect to Node.js process
- Use Memory tab for heap snapshots
- Use Performance tab for timeline recording

**5. Production monitoring:**
```javascript
// Integrate with APM tools
const apm = require('elastic-apm-node').start({
  serviceName: 'my-app',
  secretToken: 'your-token',
  serverUrl: 'https://apm-server:8200'
});

// Custom metrics
const metrics = require('metrics');
const memoryGauge = new metrics.Gauge();

setInterval(() => {
  const memory = process.memoryUsage();
  memoryGauge.set(memory.heapUsed);
  // Send to monitoring system
}, 10000);
```

**6. Load testing with monitoring:**
```javascript
// Use artillery or autocannon for load testing
// While monitoring memory
const autocannon = require('autocannon');
const monitor = require('process-monitor');

autocannon({
  url: 'http://localhost:3000',
  connections: 100,
  duration: 60
}, (err, results) => {
  console.log('Load test complete');
});

// Monitor during test
monitor.start({ interval: 1000 });
```

**7. Automated leak detection:**
```javascript
class MemoryLeakDetector {
  constructor(thresholdMB = 100, checkIntervalMs = 10000) {
    this.threshold = thresholdMB * 1024 * 1024;
    this.checkInterval = checkIntervalMs;
    this.lastHeapUsed = 0;
    this.leakCount = 0;
    
    this.startMonitoring();
  }
  
  startMonitoring() {
    setInterval(() => {
      const currentHeap = process.memoryUsage().heapUsed;
      const growth = currentHeap - this.lastHeapUsed;
      
      if (growth > this.threshold) {
        this.leakCount++;
        console.warn(`Possible memory leak detected! Growth: ${Math.round(growth / 1024 / 1024)}MB`);
        
        if (this.leakCount >= 3) {
          console.error('Critical memory leak - taking heap snapshot');
          this.takeHeapSnapshot();
        }
      }
      
      this.lastHeapUsed = currentHeap;
    }, this.checkInterval);
  }
  
  takeHeapSnapshot() {
    // Implementation for heap snapshot
  }
}

// Usage
new MemoryLeakDetector(50, 30000); // Alert if 50MB growth in 30 seconds
```

**8. Log analysis:**
```javascript
// Structured logging of memory stats
const winston = require('winston');

const logger = winston.createLogger({
  transports: [new winston.transports.File({ filename: 'memory.log' })]
});

setInterval(() => {
  const memory = process.memoryUsage();
  logger.info('memory_usage', {
    timestamp: new Date().toISOString(),
    rss: memory.rss,
    heapUsed: memory.heapUsed,
    heapTotal: memory.heapTotal,
    external: memory.external
  });
}, 60000); // Every minute
```

**Real-world detection workflow:**

1. **Baseline measurement**: Memory usage at startup
2. **Load simulation**: Simulate user traffic
3. **Memory tracking**: Record usage over time
4. **Snapshot comparison**: Before/after load
5. **Analysis**: Identify growing object types
6. **Fix verification**: Confirm leak is fixed

**Common leak patterns to look for:**
- **String accumulation**: Growing string buffers
- **Array growth**: Arrays that never shrink
- **Object retention**: Objects referenced from globals
- **Closure references**: Functions holding large data
- **Event emitter growth**: Too many listeners

**Best practices:**
1. **Monitor in production**: Real usage reveals leaks
2. **Automate detection**: Alert on abnormal growth
3. **Profile regularly**: Not just when problems occur
4. **Test with realistic data**: Production-like data volumes
5. **Document findings**: For team knowledge sharing

**Remember:** Memory leak detection is proactive, not reactive. Implement monitoring before leaks cause production issues.

---

#### 3. What tools can you use for memory profiling?

**Answer:**

**Memory profiling tools** help identify memory usage patterns, find leaks, and optimize memory consumption in Node.js applications.

**Built-in Node.js tools:**

**1. `--inspect` flag:**
```bash
# Enable inspector
node --inspect app.js

# With break on start
node --inspect --inspect-brk app.js

# Remote debugging
node --inspect=0.0.0.0:9229 app.js
```
- Chrome DevTools interface
- Real-time memory monitoring
- Heap snapshots and allocation profiling

**2. `--trace-gc` flag:**
```bash
# Trace garbage collection
node --trace-gc app.js

# Output: GC events with timing and memory info
[12345:0x110008000]       10 ms: Scavenge 4.5 (6.5) -> 3.9 (7.5) MB, 0.5 / 0.0 ms
```

**3. `process.memoryUsage()`:**
```javascript
// Programmatic monitoring
const memory = process.memoryUsage();
console.log({
  rss: memory.rss,           // Resident Set Size
  heapTotal: memory.heapTotal, // Total heap size
  heapUsed: memory.heapUsed,   // Used heap size
  external: memory.external    // C++ objects memory
});
```

**Third-party tools:**

**1. Chrome DevTools:**
- **Memory tab**: Heap snapshots, allocation timelines
- **Performance tab**: Memory usage over time
- **Profiles tab**: CPU and memory profiling
- **Best for**: Interactive debugging, visual analysis

**2. `node-heapdump`:**
```javascript
const heapdump = require('heapdump');

// Take snapshot on signal
process.on('SIGUSR2', () => {
  heapdump.writeSnapshot(`heap-${Date.now()}.heapsnapshot`);
});

// Or programmatically
setInterval(() => {
  if (process.memoryUsage().heapUsed > 500 * 1024 * 1024) {
    heapdump.writeSnapshot();
  }
}, 30000);
```

**3. `clinic.js` (by NearForm):**
```bash
# Install
npm install -g clinic

# Memory profiling
clinic heapdoctor -- node app.js

# Or with load testing
autocannon -c 100 -d 30 http://localhost:3000 | clinic heapdoctor -- node app.js
```
- **heapdoctor**: Memory leak detection
- **bubbleprof**: Async activity visualization
- **flame**: CPU profiling

**4. `memwatch-next`:**
```javascript
const memwatch = require('memwatch-next');

// Leak detection
memwatch.on('leak', (info) => {
  console.error('Memory leak detected:', info);
});

// Heap diff comparison
const hd = new memwatch.HeapDiff();
// ... perform operations ...
const diff = hd.end();
console.log('Heap difference:', diff);
```

**5. `v8-profiler` / `v8-profiler-next`:**
```javascript
const profiler = require('v8-profiler-next');

// Start profiling
profiler.startProfiling('session1', true);

// After some time
const profile = profiler.stopProfiling('session1');
profile.export()
  .pipe(fs.createWriteStream(`profile-${Date.now()}.cpuprofile`))
  .on('finish', () => profile.delete());
```

**6. `0x` (flamegraph generator):**
```bash
# Install
npm install -g 0x

# Generate flamegraph
0x app.js

# With custom options
0x --output-dir ./flamegraphs app.js
```
- Visual flamegraphs
- Memory and CPU profiling
- Easy to interpret results

**7. APM tools:**

**New Relic:**
```javascript
require('newrelic');
// Automatic memory monitoring
// Dashboard with memory metrics
// Alerting on memory thresholds
```

**Datadog:**
```javascript
const tracer = require('dd-trace').init();
// Memory metrics integration
// Custom dashboards
// Anomaly detection
```

**Elastic APM:**
```javascript
require('elastic-apm-node').start({
  serviceName: 'my-app'
});
// Memory usage tracking
- Heap statistics
- Garbage collection metrics
```

**8. `node-memory-profiler`:**
```bash
# Command line profiling
npx memory-profiler app.js

# With output options
npx memory-profiler --output=json app.js
```

**9. Custom monitoring scripts:**
```javascript
class MemoryProfiler {
  constructor() {
    this.snapshots = [];
    this.startTime = Date.now();
  }
  
  takeSnapshot(label) {
    const snapshot = {
      label,
      timestamp: Date.now(),
      memory: process.memoryUsage(),
      uptime: process.uptime(),
      gc: process._getActiveRequests().length
    };
    
    this.snapshots.push(snapshot);
    return snapshot;
  }
  
  analyze() {
    const analysis = {
      duration: Date.now() - this.startTime,
      snapshots: this.snapshots.length,
      memoryGrowth: this.calculateGrowth(),
      recommendations: this.generateRecommendations()
    };
    
    return analysis;
  }
  
  calculateGrowth() {
    if (this.snapshots.length < 2) return 0;
    
    const first = this.snapshots[0].memory.heapUsed;
    const last = this.snapshots[this.snapshots.length - 1].memory.heapUsed;
    
    return ((last - first) / first * 100).toFixed(2);
  }
}
```

**10. Production monitoring stack:**

**Prometheus + Grafana:**
```javascript
const client = require('prom-client');

// Custom memory metrics
const memoryGauge = new client.Gauge({
  name: 'nodejs_memory_usage_bytes',
  help: 'Memory usage in bytes',
  labelNames: ['type']
});

setInterval(() => {
  const memory = process.memoryUsage();
  memoryGauge.set({ type: 'rss' }, memory.rss);
  memoryGauge.set({ type: 'heap_used' }, memory.heapUsed);
  memoryGauge.set({ type: 'heap_total' }, memory.heapTotal);
}, 15000);
```

**Choosing the right tool:**

**For development:**
- Chrome DevTools (interactive)
- `node --inspect` (easy setup)
- `clinic.js` (comprehensive)

**For production:**
- APM tools (New Relic, Datadog)
- Custom metrics (Prometheus)
- Logging + alerting

**For deep analysis:**
- `heapdump` (snapshots)
- `v8-profiler` (detailed profiles)
- `0x` (visualization)

**Real-world workflow:**
1. **Development**: Use Chrome DevTools for interactive debugging
2. **Testing**: Use `clinic.js` with load testing
3. **Production**: Use APM tools for continuous monitoring
4. **Incidents**: Use `heapdump` for snapshot analysis

**Best practices:**
1. **Profile regularly**: Not just when problems occur
2. **Compare snapshots**: Before/after changes
3. **Monitor trends**: Not just absolute values
4. **Automate alerts**: For abnormal memory growth
5. **Document findings**: For team knowledge sharing

**Remember:** Different tools serve different purposes. Use a combination for comprehensive memory profiling across development, testing, and production environments.

---

#### 4. How do you prevent memory leaks in Express applications?

**Answer:**

**Preventing memory leaks** in Express requires careful coding practices, proper resource management, and ongoing monitoring.

**Prevention strategies:**

**1. Proper middleware cleanup:**
```javascript
// Middleware that allocates resources
app.use((req, res, next) => {
  // Store data in request, not globally
  req.requestData = {
    id: uuid.v4(),
    startTime: Date.now()
  };
  
  // Clean up on response finish
  res.on('finish', () => {
    delete req.requestData; // Remove reference
  });
  
  next();
});
```

**2. Request-scoped data:**
```javascript
// BAD: Global array accumulating request data
const allRequests = [];

// GOOD: Request-scoped data
app.use((req, res, next) => {
  req.tempData = {}; // Scoped to request
  next();
});

app.use((req, res, next) => {
  // Use req.tempData, not global variables
  req.tempData.user = getUserFromRequest(req);
  next();
});

app.use((req, res, next) => {
  // Clean up in final middleware
  delete req.tempData;
  next();
});
```

**3. Event listener management:**
```javascript
// Express app event listeners
const cleanupListeners = [];

app.on('mount', (parent) => {
  const listener = () => {
    // Cleanup logic
  };
  
  parent.on('close', listener);
  cleanupListeners.push({ parent, listener });
});

// Clean up on server shutdown
process.on('SIGTERM', () => {
  cleanupListeners.forEach(({ parent, listener }) => {
    parent.removeListener('close', listener);
  });
});
```

**4. Database connection pooling:**
```javascript
const { Pool } = require('pg');

// Create pool with proper configuration
const pool = new Pool({
  max: 20, // Limit connections
  idleTimeoutMillis: 30000, // Close idle connections
  connectionTimeoutMillis: 2000 // Timeout for new connections
});

// Always release connections
app.get('/api/data', async (req, res) => {
  const client = await pool.connect();
  
  try {
    const result = await client.query('SELECT * FROM data');
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  } finally {
    client.release(); // CRITICAL: Always release
  }
});

// Clean up pool on shutdown
process.on('SIGTERM', () => {
  pool.end(); // Close all connections
});
```

**5. Stream handling:**
```javascript
// Proper stream consumption
app.get('/large-file', (req, res) => {
  const fileStream = fs.createReadStream('largefile.txt');
  
  // Pipe with error handling
  fileStream.pipe(res);
  
  // Clean up on errors or completion
  fileStream.on('error', (err) => {
    console.error('Stream error:', err);
    if (!res.headersSent) {
      res.status(500).send('Error reading file');
    }
  });
  
  res.on('finish', () => {
    fileStream.destroy(); // Clean up stream
  });
});
```

**6. Cache with limits:**
```javascript
// LRU cache instead of unlimited Map
const LRU = require('lru-cache');

const cache = new LRU({
  max: 100, // Maximum items
  maxAge: 1000 * 60 * 5, // 5 minutes TTL
  dispose: (key, value) => {
    // Cleanup when item is evicted
    if (value.cleanup) value.cleanup();
  }
});

app.get('/api/cached/:id', (req, res) => {
  const cached = cache.get(req.params.id);
  
  if (cached) {
    return res.json(cached);
  }
  
  // Fetch and cache with size limit
  fetchData(req.params.id).then(data => {
    cache.set(req.params.id, data);
    res.json(data);
  });
});
```

**7. Timer cleanup:**
```javascript
// Store timer references for cleanup
const activeTimers = new Set();

app.post('/api/start-job', (req, res) => {
  const jobId = uuid.v4();
  
  // Store timer reference
  const timer = setInterval(() => {
    processJob(jobId);
  }, 5000);
  
  activeTimers.add(timer);
  
  // Provide endpoint to stop job
  res.json({ jobId, stopEndpoint: `/api/stop-job/${jobId}` });
});

app.post('/api/stop-job/:id', (req, res) => {
  // Find and clear timer
  for (const timer of activeTimers) {
    clearInterval(timer);
    activeTimers.delete(timer);
  }
  
  res.json({ stopped: true });
});

// Clean up all timers on shutdown
process.on('SIGTERM', () => {
  activeTimers.forEach(timer => clearInterval(timer));
  activeTimers.clear();
});
```

**8. Third-party library configuration:**
```javascript
// Configure libraries for memory safety
const express = require('express');
const app = express();

// Limit request size
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ limit: '10mb', extended: true }));

// Configure session store with TTL
const session = require('express-session');
const RedisStore = require('connect-redis')(session);

app.use(session({
  store: new RedisStore({
    client: redisClient,
    ttl: 86400 // 24 hours
  }),
  secret: 'your-secret',
  resave: false,
  saveUninitialized: false,
  cookie: { maxAge: 24 * 60 * 60 * 1000 } // 24 hours
}));
```

**9. Memory monitoring middleware:**
```javascript
// Add memory monitoring to Express
app.use((req, res, next) => {
  const startMemory = process.memoryUsage().heapUsed;
  const startTime = Date.now();
  
  // Track request
  req._memoryStart = startMemory;
  req._startTime = startTime;
  
  // Log on response finish
  res.on('finish', () => {
    const endMemory = process.memoryUsage().heapUsed;
    const endTime = Date.now();
    
    const memoryDiff = endMemory - startMemory;
    const timeDiff = endTime - startTime;
    
    if (memoryDiff > 10 * 1024 * 1024) { // 10MB threshold
      console.warn(`Large memory allocation: ${req.method} ${req.path}`, {
        memoryDiff: Math.round(memoryDiff / 1024 / 1024) + 'MB',
        duration: timeDiff + 'ms',
        timestamp: new Date().toISOString()
      });
    }
  });
  
  next();
});
```

**10. Regular testing and profiling:**
```javascript
// Automated memory testing
const autocannon = require('autocannon');
const { spawn } = require('child_process');

async function testMemoryLeaks() {
  // Start app with inspector
  const appProcess = spawn('node', ['--inspect', 'app.js']);
  
  // Wait for startup
  await new Promise(resolve => setTimeout(resolve, 3000));
  
  // Run load test
  const result = await autocannon({
    url: 'http://localhost:3000',
    connections: 50,
    duration: 60,
    requests: [
      { method: 'GET', path: '/api/data' },
      { method: 'POST', path: '/api/data', body: JSON.stringify({ test: 'data' }) }
    ]
  });
  
  // Take heap snapshot
  // (Would use inspector protocol here)
  
  // Kill process
  appProcess.kill();
  
  return result;
}
```

**Real-world prevention checklist:**

1. **✅ No global variables**: Use request/function scope
2. **✅ Connection pooling**: With proper limits and cleanup
3. **✅ Stream management**: Always close/clean up streams
4. **✅ Cache limits**: LRU or TTL-based eviction
5. **✅ Timer cleanup**: Store references for cleanup
6. **✅ Event listener removal**: When no longer needed
7. **✅ Middleware cleanup**: Remove request-scoped data
8. **✅ Memory monitoring**: Log and alert on growth
9. **✅ Load testing**: With memory profiling
10. **✅ Dependency updates**: Keep libraries current

**Common Express-specific leaks:**
- **Middleware chains**: Accumulating data across middleware
- **Static file serving**: Not closing file streams
- **WebSocket connections**: Not cleaning up on disconnect
- **Session storage**: Unlimited session growth
- **Upload handling**: Not cleaning up temp files

**Remember:** Prevention is better than detection. Establish coding standards and patterns that minimize memory leak risks from the start, and complement with monitoring to catch any issues that slip through.

---

#### 5. What is the garbage collection process in Node.js?

**Answer:**

**Garbage collection (GC)** is the automatic memory management process in Node.js that reclaims memory occupied by objects that are no longer in use. Node.js uses V8's garbage collector, which employs several algorithms and generations.

**V8's garbage collection system:**

**1. Memory structure:**
- **New Space (Scavenger)**: Young generation, small (1-8MB)
- **Old Space (Mark-Sweep-Compact)**: Old generation, large
- **Large Object Space**: Objects > 256KB
- **Code Space**: Compiled code
- **Map Space**: Hidden classes and metadata

**2. Generational hypothesis:**
- **Most objects die young**: Short-lived objects
- **Old objects likely to survive**: Long-lived objects
- **Different strategies for different generations**

**GC algorithms:**

**1. Scavenge (Minor GC):**
- **For**: New Space (young generation)
- **How**: Copy surviving objects to other semi-space
- **When**: New Space fills up
- **Speed**: Fast (stop-the-world, but short)

```javascript
// Scavenge process:
// 1. New objects allocated in "From" space
// 2. When "From" space fills, scavenge runs
// 3. Live objects copied to "To" space
// 4. "From" space cleared
// 5. Roles swapped
```

**2. Mark-Sweep-Compact (Major GC):**
- **For**: Old Space (old generation)
- **How**: Mark live objects, sweep dead, compact memory
- **When**: Old Space fills up or after scavenges
- **Speed**: Slow (stop-the-world, can be long)

```javascript
// Mark-Sweep-Compact process:
// 1. Mark: Traverse object graph from roots
// 2. Sweep: Clear unmarked objects
// 3. Compact: Defragment memory (optional)
```

**3. Incremental Marking:**
- **Purpose**: Reduce Major GC pause times
- **How**: Break marking into increments
- **When**: During JavaScript execution
- **Benefit**: Shorter, more frequent pauses

**4. Lazy Sweeping:**
- **Purpose**: Further reduce pause times
- **How**: Defer sweeping until needed
- **When**: After marking completes
- **Benefit**: Memory reclaimed incrementally

**5. Idle-time GC:**
- **Purpose**: Use idle CPU time
- **How**: GC during application idle periods
- **When**: RequestIdleCallback or similar
- **Benefit**: Minimize impact on responsiveness

**GC triggers:**

**1. Allocation pressure:**
```javascript
// Creating many objects triggers GC
for (let i = 0; i < 1000000; i++) {
  const obj = { id: i, data: 'x'.repeat(100) };
  // May trigger scavenge when New Space fills
}
```

**2. Memory limits:**
```bash
# V8 memory limits
node --max-old-space-size=4096 app.js  # 4GB heap
node --max-semi-space-size=64 app.js   # 64MB new space
```

**3. Manual triggers:**
```javascript
// Force GC (development only)
if (global.gc) {
  global.gc();
}

// Or with flags
node --expose-gc app.js
```

**4. Heap size growth:**
- **Factor-based**: GC when heap grows by factor
- **Time-based**: Periodic GC
- **Idle-based**: GC during idle time

**Monitoring GC:**
```javascript
// GC event monitoring
const v8 = require('v8');

// Get heap statistics
const heapStats = v8.getHeapStatistics();
console.log('Heap stats:', {
  totalHeapSize: heapStats.total_heap_size,
  usedHeapSize: heapStats.used_heap_size,
  heapSizeLimit: heapStats.heap_size_limit,
  totalPhysicalSize: heapStats.total_physical_size,
  mallocedMemory: heapStats.malloced_memory
});

// GC flags for monitoring
node --trace-gc app.js
node --trace-gc-verbose app.js
node --trace-gc-nvp app.js
```

**GC performance optimization:**

**1. Reduce object allocation:**
```javascript
// BAD: Creating new objects in loop
function processItems(items) {
  const results = [];
  for (const item of items) {
    const processed = { // New object each iteration
      id: item.id,
      value: item.value * 2,
      timestamp: Date.now()
    };
    results.push(processed);
  }
  return results;
}

// BETTER: Reuse object
function processItems(items) {
  const results = [];
  const template = {}; // Reused object
  
  for (const item of items) {
    template.id = item.id;
    template.value = item.value * 2;
    template.timestamp = Date.now();
    results.push({ ...template }); // Still creates new, but less overhead
  }
  return results;
}
```

**2. Avoid large object retention:**
```javascript
// BAD: Large objects in long-lived references
const cache = new Map();

function processRequest(data) {
  const processed = expensiveProcessing(data); // Large result
  cache.set(data.id, processed); // Kept indefinitely
  return processed;
}

// BETTER: Limit cache size or use TTL
const LRU = require('lru-cache');
const cache = new LRU({ max: 100, maxAge: 60000 });
```

**3. Use object pools:**
```javascript
// For frequently created/destroyed objects
class ObjectPool {
  constructor(createFn, resetFn, size = 100) {
    this.createFn = createFn;
    this.resetFn = resetFn;
    this.pool = [];
    this.size = size;
  }
  
  acquire() {
    if (this.pool.length > 0) {
      const obj = this.pool.pop();
      this.resetFn(obj);
      return obj;
    }
    return this.createFn();
  }
  
  release(obj) {
    if (this.pool.length < this.size) {
      this.pool.push(obj);
    }
  }
}

// Usage for database connections, buffers, etc.
```

**4. Optimize data structures:**
```javascript
// Use TypedArrays for numeric data
// Instead of: const data = new Array(1000000);
const data = new Float64Array(1000000); // More memory efficient

// Use Sets for unique values
const uniqueValues = new Set(); // Better than array with includes()
```

**GC tuning flags:**
```bash
# Common GC tuning options
node --max-old-space-size=4096 app.js      # Increase old space
node --max-semi-space-size=64 app.js       # Increase new space
node --nouse-idle-notification app.js      # Disable idle GC
node --expose-gc app.js                    # Enable global.gc()
node --trace-gc app.js                     # Trace GC events
node --trace-gc-verbose app.js             # Verbose GC tracing
```

**Real-world GC patterns:**

**Web server pattern:**
- **Request objects**: Short-lived (scavenge collected)
- **Cached data**: Long-lived (old generation)
- **Database connections**: Pooled (managed separately)
- **Sessions**: Time-limited (TTL-based cleanup)

**Real-time application pattern:**
- **WebSocket messages**: Very short-lived
- **Connection state**: Medium-lived
- **User data**: Long-lived with updates
- **Broadcast messages**: Immediately discarded

**Monitoring and debugging:**
```javascript
// GC monitoring in production
const gc = (() => {
  const gcStats = {
    minor: 0,
    major: 0,
    incremental: 0,
    lastMinor: 0,
    lastMajor: 0
  };
  
  if (process.gc) {
    const gcTypes = {
      1: 'minor',      // Scavenge
      2: 'major',      // Mark-Sweep-Compact
      4: 'incremental' // Incremental marking
    };
    
    process.gc = (type) => {
      const gcType = gcTypes[type] || 'unknown';
      gcStats[gcType]++;
      gcStats[`last${gcType.charAt(0).toUpperCase() + gcType.slice(1)}`] = Date.now();
      
      // Log if too frequent
      if (gcStats.minor > 1000 || gcStats.major > 10) {
        console.warn('Excessive GC', { ...gcStats });
      }
      
      return process._originalGc(type);
    };
  }
  
  return gcStats;
})();
```

**Best practices:**
1. **Monitor GC frequency**: Alert on excessive GC
2. **Profile memory usage**: Identify allocation patterns
3. **Tune for workload**: Different apps need different settings
4. **Test with production data**: Real data reveals real patterns
5. **Keep V8 updated**: GC improvements in each version

**Remember:** Understanding GC helps write memory-efficient code. While GC is automatic, your code patterns significantly impact its efficiency and performance.

---
## 45. Performance Monitoring

#### 1. How do you monitor Node.js application performance?

**Answer:**

**Performance monitoring** in Node.js involves tracking various metrics to ensure applications run efficiently, identify bottlenecks, and prevent issues before they impact users.

**Monitoring approaches:**

**1. Built-in Node.js metrics:**
```javascript
// Process metrics
const os = require('os');
const v8 = require('v8');

setInterval(() => {
  const metrics = {
    // Process metrics
    memory: process.memoryUsage(),
    cpu: process.cpuUsage(),
    uptime: process.uptime(),
    
    // System metrics
    loadavg: os.loadavg(),
    freemem: os.freemem(),
    totalmem: os.totalmem(),
    
    // V8 metrics
    heap: v8.getHeapStatistics(),
    heapSpace: v8.getHeapSpaceStatistics(),
    
    // Event loop
    eventLoopDelay: Date.now() - performance.now(),
    
    // Active handles/requests
    activeHandles: process._getActiveHandles().length,
    activeRequests: process._getActiveRequests().length
  };
  
  console.log('Metrics:', JSON.stringify(metrics, null, 2));
}, 30000); // Every 30 seconds
```

**2. Express middleware for request monitoring:**
```javascript
// Request timing middleware
app.use((req, res, next) => {
  const start = process.hrtime();
  const startMemory = process.memoryUsage().heapUsed;
  
  // Store on request object
  req._startTime = start;
  req._startMemory = startMemory;
  
  // Log on response finish
  res.on('finish', () => {
    const diff = process.hrtime(start);
    const duration = diff[0] * 1e3 + diff[1] * 1e-6; // milliseconds
    const memoryDiff = process.memoryUsage().heapUsed - startMemory;
    
    console.log({
      method: req.method,
      path: req.path,
      status: res.statusCode,
      duration: `${duration.toFixed(2)}ms`,
      memory: `${Math.round(memoryDiff / 1024)}KB`,
      timestamp: new Date().toISOString()
    });
  });
  
  next();
});
```

**3. Health check endpoints:**
```javascript
// Comprehensive health check
app.get('/health', (req, res) => {
  const health = {
    status: 'healthy',
    timestamp: new Date().toISOString(),
    
    // Application metrics
    uptime: process.uptime(),
    memory: process.memoryUsage(),
    cpu: process.cpuUsage(),
    
    // System metrics
    load: os.loadavg(),
    
    // Application-specific checks
    database: checkDatabaseConnection(),
    redis: checkRedisConnection(),
    externalApi: checkExternalApi(),
    
    // Version info
    version: process.version,
    appVersion: require('./package.json').version,
    
    // Environment
    nodeEnv: process.env.NODE_ENV,
    pid: process.pid
  };
  
  // Determine overall health
  const isHealthy = health.database && health.redis;
  health.status = isHealthy ? 'healthy' : 'unhealthy';
  
  res.status(isHealthy ? 200 : 503).json(health);
});

// Readiness probe (for Kubernetes)
app.get('/ready', (req, res) => {
  const ready = checkReadiness();
  res.status(ready ? 200 : 503).json({ ready });
});

// Liveness probe
app.get('/live', (req, res) => {
  res.json({ alive: true });
});
```

**4. APM (Application Performance Monitoring) integration:**
```javascript
// New Relic
require('newrelic');

// Datadog
const tracer = require('dd-trace').init({
  service: 'my-node-app',
  env: process.env.NODE_ENV
});

// Elastic APM
require('elastic-apm-node').start({
  serviceName: 'my-app',
  secretToken: 'your-token',
  serverUrl: 'https://apm-server:8200'
});

// AppDynamics
require('appdynamics').profile({
  controllerHostName: 'controller.example.com',
  controllerPort: 8090,
  accountName: 'customer1',
  accountAccessKey: 'your-key',
  applicationName: 'MyApp',
  tierName: 'API',
  nodeName: 'API-1'
});
```

**5. Custom metrics with Prometheus:**
```javascript
const client = require('prom-client');
const collectDefaultMetrics = client.collectDefaultMetrics;

// Collect default metrics (CPU, memory, etc.)
collectDefaultMetrics({ timeout: 5000 });

// Custom metrics
const httpRequestDuration = new client.Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'route', 'status'],
  buckets: [0.1, 0.5, 1, 2, 5, 10]
});

const activeConnections = new client.Gauge({
  name: 'active_connections',
  help: 'Number of active connections'
});

// Middleware to track requests
app.use((req, res, next) => {
  const end = httpRequestDuration.startTimer();
  
  res.on('finish', () => {
    end({ method: req.method, route: req.route?.path || req.path, status: res.statusCode });
  });
  
  next();
});

// Metrics endpoint
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', client.register.contentType);
  res.end(await client.register.metrics());
});
```

**6. Log aggregation:**
```javascript
const winston = require('winston');
const { ElasticsearchTransport } = require('winston-elasticsearch');

const logger = winston.createLogger({
  level: 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  ),
  transports: [
    new winston.transports.File({ filename: 'error.log', level: 'error' }),
    new winston.transports.File({ filename: 'combined.log' }),
    new ElasticsearchTransport({
      level: 'info',
      clientOpts: { node: 'http://localhost:9200' }
    })
  ]
});

// Structured logging for performance
app.use((req, res, next) => {
  const start = Date.now();
  
  res.on('finish', () => {
    logger.info('request', {
      method: req.method,
      url: req.url,
      status: res.statusCode,
      duration: Date.now() - start,
      userAgent: req.get('User-Agent'),
      ip: req.ip
    });
  });
  
  next();
});
```

**7. Real-time monitoring dashboard:**
```javascript
// Using Socket.io for real-time updates
const io = require('socket.io')(server);

// Broadcast metrics periodically
setInterval(() => {
  const metrics = {
    memory: process.memoryUsage(),
    cpu: process.cpuUsage(),
    uptime: process.uptime(),
    connections: io.engine.clientsCount,
    timestamp: Date.now()
  };
  
  io.emit('metrics', metrics);
}, 1000); // Every second

// Dashboard client would connect and display metrics
```

**8. Alerting system:**
```javascript
class PerformanceAlert {
  constructor(thresholds) {
    this.thresholds = thresholds;
    this.alerts = new Map();
  }
  
  check(metrics) {
    // Check memory threshold
    if (metrics.memory.heapUsed > this.thresholds.memory) {
      this.triggerAlert('high_memory', {
        current: metrics.memory.heapUsed,
        threshold: this.thresholds.memory
      });
    }
    
    // Check response time
    if (metrics.avgResponseTime > this.thresholds.responseTime) {
      this.triggerAlert('slow_response', {
        current: metrics.avgResponseTime,
        threshold: this.thresholds.responseTime
      });
    }
    
    // Check error rate
    if (metrics.errorRate > this.thresholds.errorRate) {
      this.triggerAlert('high_error_rate', {
        current: metrics.errorRate,
        threshold: this.thresholds.errorRate
      });
    }
  }
  
  triggerAlert(type, data) {
    const alertKey = `${type}_${Date.now()}`;
    
    // Prevent duplicate alerts
    if (!this.alerts.has(alertKey)) {
      this.alerts.set(alertKey, { type, data, timestamp: Date.now() });
      
      // Send alert (email, Slack, PagerDuty, etc.)
      this.sendAlert(type, data);
    }
  }
  
  sendAlert(type, data) {
    // Implement alert delivery
    console.error(`ALERT: ${type}`, data);
    // Could send to Slack, email, SMS, etc.
  }
}
```

**Real-world monitoring stack:**

**Development:**
- **Console logging**: Basic metrics
- **Chrome DevTools**: Profiling
- **Postman/Insomnia**: API testing

**Testing:**
- **Artillery/k6**: Load testing with metrics
- **Jest/Mocha**: Performance tests
- **Docker stats**: Container metrics

**Production:**
- **Prometheus + Grafana**: Metrics collection and visualization
- **ELK Stack**: Log aggregation (Elasticsearch, Logstash, Kibana)
- **APM tools**: New Relic, Datadog, AppDynamics
- **Cloud monitoring**: AWS CloudWatch, Google Stackdriver, Azure Monitor

**Best practices:**
1. **Monitor at multiple levels**: Application, system, network
2. **Set baselines**: Know normal performance
3. **Implement alerts**: Proactive notification
4. **Regular reviews**: Weekly performance reviews
5. **Document incidents**: Learn from issues
6. **Test monitoring**: Ensure alerts work
7. **Review thresholds**: Adjust as application evolves

**Remember:** Effective monitoring provides visibility into application health, helps identify issues before users notice, and provides data for capacity planning and optimization decisions.

---
#### 2. What are the key performance metrics to track?

**Answer:**

**Key performance metrics** provide visibility into application health and help identify bottlenecks. Different metrics serve different purposes in the monitoring strategy.

**1. Application-level metrics:**

**Response time:**
- **Average response time**: Overall performance
- **P95/P99 response time**: Tail latency (worst-case performance)
- **API endpoint latency**: Per-endpoint performance
- **Database query time**: Query performance

**Throughput:**
- **Requests per second (RPS)**: Overall load
- **Transactions per second**: Business transactions
- **Concurrent connections**: Active users/connections

**Error rates:**
- **HTTP error rate**: 4xx/5xx responses
- **Application error rate**: Unhandled exceptions
- **Timeout rate**: Requests timing out

**2. System-level metrics:**

**CPU usage:**
- **Process CPU**: Node.js process CPU usage
- **System CPU**: Overall system CPU
- **CPU steal**: Virtualized environments

**Memory usage:**
- **Heap used/total**: JavaScript heap memory
- **RSS (Resident Set Size)**: Total memory used
- **Heap fragmentation**: Memory efficiency

**Event loop metrics:**
- **Event loop delay**: Lag in event loop
- **Event loop utilization**: CPU time spent in event loop
- **Active handles/requests**: Concurrent operations

**3. Business metrics:**

**User experience:**
- **Page load time**: Frontend performance
- **Time to interactive**: When page becomes usable
- **First contentful paint**: First visual content

**Business impact:**
- **Conversion rate**: Successful transactions
- **Cart abandonment**: Failed purchases
- **User retention**: Returning users

**4. Infrastructure metrics:**

**Database:**
- **Connection pool usage**: Database connections
- **Query performance**: Slow query detection
- **Replication lag**: Data consistency

**Cache:**
- **Cache hit ratio**: Cache effectiveness
- **Cache latency**: Response time
- **Cache memory usage**: Memory consumption

**Network:**
- **Bandwidth usage**: Data transfer
- **Latency**: Network delays
- **Packet loss**: Network reliability

**Implementation example:**
```javascript
class PerformanceMetrics {
  constructor() {
    this.metrics = {
      responseTimes: [],
      errorCount: 0,
      requestCount: 0,
      startTime: Date.now()
    };
  }
  
  recordResponseTime(duration) {
    this.metrics.responseTimes.push(duration);
    // Keep only last 1000 measurements
    if (this.metrics.responseTimes.length > 1000) {
      this.metrics.responseTimes.shift();
    }
  }
  
  recordError() {
    this.metrics.errorCount++;
  }
  
  recordRequest() {
    this.metrics.requestCount++;
  }
  
  getMetrics() {
    const responseTimes = this.metrics.responseTimes;
    const avgResponseTime = responseTimes.length > 0 
      ? responseTimes.reduce((a, b) => a + b, 0) / responseTimes.length 
      : 0;
    
    const sortedTimes = [...responseTimes].sort((a, b) => a - b);
    const p95Index = Math.floor(sortedTimes.length * 0.95);
    const p99Index = Math.floor(sortedTimes.length * 0.99);
    
    return {
      uptime: Date.now() - this.metrics.startTime,
      totalRequests: this.metrics.requestCount,
      errorRate: this.metrics.requestCount > 0 
        ? (this.metrics.errorCount / this.metrics.requestCount) * 100 
        : 0,
      responseTime: {
        avg: avgResponseTime,
        p95: sortedTimes[p95Index] || 0,
        p99: sortedTimes[p99Index] || 0,
        min: sortedTimes[0] || 0,
        max: sortedTimes[sortedTimes.length - 1] || 0
      },
      currentTime: new Date().toISOString()
    };
  }
}

// Usage
const metrics = new PerformanceMetrics();

app.use((req, res, next) => {
  const start = Date.now();
  metrics.recordRequest();
  
  res.on('finish', () => {
    const duration = Date.now() - start;
    metrics.recordResponseTime(duration);
    
    if (res.statusCode >= 400) {
      metrics.recordError();
    }
  });
  
  next();
});

// Metrics endpoint
app.get('/metrics/performance', (req, res) => {
  res.json(metrics.getMetrics());
});
```

**Real-world metric tracking:**

**E-commerce site:**
- **Response time**: < 200ms (P95)
- **Error rate**: < 0.1%
- **Cart conversion**: > 3%
- **Database latency**: < 50ms

**API service:**
- **API latency**: < 100ms (P99)
- **Availability**: 99.95%
- **Throughput**: 10,000 RPS
- **Cache hit ratio**: > 80%

**Monitoring best practices:**

1. **Define SLOs/SLAs**: Service Level Objectives/Agreements
2. **Set alert thresholds**: Proactive monitoring
3. **Track trends**: Not just absolute values
4. **Correlate metrics**: Understand relationships
5. **Review regularly**: Weekly performance reviews
6. **Document baselines**: Normal performance levels
7. **Test under load**: Performance testing

**Tools for metric collection:**
- **Prometheus**: Time-series database
- **StatsD**: Metrics aggregation
- **Telegraf**: Metric collection agent
- **Cloud monitoring**: AWS CloudWatch, Google Stackdriver

**Remember:** The most important metrics are those that impact user experience and business outcomes. Start with a few key metrics and expand as needed.

---

#### 3. How do you implement logging for performance monitoring?

**Answer:**

**Performance logging** captures detailed information about application behavior to identify bottlenecks, debug issues, and analyze trends over time.

**Logging strategies:**

**1. Structured logging (JSON format):**
```javascript
const winston = require('winston');

const logger = winston.createLogger({
  level: 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  ),
  transports: [
    new winston.transports.File({ filename: 'performance.log' })
  ]
});

// Performance logging middleware
app.use((req, res, next) => {
  const start = Date.now();
  const startMemory = process.memoryUsage().heapUsed;
  
  res.on('finish', () => {
    const duration = Date.now() - start;
    const memoryDiff = process.memoryUsage().heapUsed - startMemory;
    
    logger.info('request_performance', {
      timestamp: new Date().toISOString(),
      method: req.method,
      url: req.url,
      statusCode: res.statusCode,
      duration: duration,
      memoryUsed: Math.round(memoryDiff / 1024), // KB
      userAgent: req.get('User-Agent'),
      ip: req.ip,
      userId: req.user?.id || 'anonymous',
      queryParams: Object.keys(req.query).length > 0 ? req.query : undefined,
      bodySize: req.headers['content-length'] || 0
    });
  });
  
  next();
});
```

**2. Correlation IDs for request tracing:**
```javascript
// Generate correlation ID for each request
const { v4: uuidv4 } = require('uuid');

app.use((req, res, next) => {
  // Get correlation ID from header or generate new
  const correlationId = req.headers['x-correlation-id'] || uuidv4();
  
  // Store in request object
  req.correlationId = correlationId;
  
  // Set in response header
  res.set('X-Correlation-ID', correlationId);
  
  // Add to all logs for this request
  req.logger = logger.child({ correlationId });
  
  next();
});

// Usage in route handlers
app.get('/api/data', async (req, res) => {
  req.logger.info('fetching_data', { 
    userId: req.user.id,
    dataType: 'user_profile' 
  });
  
  try {
    const data = await fetchData(req.user.id);
    req.logger.info('data_fetched', { 
      recordCount: data.length,
      duration: Date.now() - req.startTime 
    });
    res.json(data);
  } catch (error) {
    req.logger.error('data_fetch_failed', { 
      error: error.message,
      stack: error.stack 
    });
    res.status(500).json({ error: 'Failed to fetch data' });
  }
});
```

**3. Performance-specific logging levels:**
```javascript
// Custom log levels for performance
const performanceLevels = {
  levels: {
    error: 0,
    warn: 1,
    info: 2,
    performance: 3,
    debug: 4,
    trace: 5
  },
  colors: {
    performance: 'cyan'
  }
};

const perfLogger = winston.createLogger({
  levels: performanceLevels.levels,
  level: 'performance',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  ),
  transports: [
    new winston.transports.File({ 
      filename: 'perf.log',
      level: 'performance'
    })
  ]
});

// Log slow requests
app.use((req, res, next) => {
  const start = Date.now();
  
  res.on('finish', () => {
    const duration = Date.now() - start;
    
    if (duration > 1000) { // Log requests slower than 1 second
      perfLogger.performance('slow_request', {
        duration: duration,
        method: req.method,
        url: req.url,
        status: res.statusCode
      });
    }
  });
  
  next();
});
```

**4. Database query logging:**
```javascript
// Sequelize query logging
const sequelize = new Sequelize(database, username, password, {
  logging: (sql, timing) => {
    if (timing > 100) { // Log slow queries (> 100ms)
      logger.warn('slow_query', {
        sql: sql,
        duration: timing,
        timestamp: new Date().toISOString()
      });
    }
  }
});

// Mongoose query logging
mongoose.set('debug', (collectionName, method, query, doc) => {
  logger.debug('mongoose_query', {
    collection: collectionName,
    method: method,
    query: JSON.stringify(query),
    doc: doc,
    timestamp: new Date().toISOString()
  });
});
```

**5. Memory and CPU logging:**
```javascript
// Periodic system metrics logging
setInterval(() => {
  const memory = process.memoryUsage();
  const cpu = process.cpuUsage();
  const load = os.loadavg();
  
  logger.info('system_metrics', {
    timestamp: new Date().toISOString(),
    memory: {
      heapUsed: Math.round(memory.heapUsed / 1024 / 1024), // MB
      heapTotal: Math.round(memory.heapTotal / 1024 / 1024),
      rss: Math.round(memory.rss / 1024 / 1024)
    },
    cpu: {
      user: Math.round(cpu.user / 1000), // microseconds to milliseconds
      system: Math.round(cpu.system / 1000)
    },
    load: {
      '1min': load[0],
      '5min': load[1],
      '15min': load[2]
    },
    uptime: process.uptime(),
    activeHandles: process._getActiveHandles().length,
    activeRequests: process._getActiveRequests().length
  });
}, 60000); // Every minute
```

**6. Distributed tracing with OpenTelemetry:**
```javascript
const { NodeTracerProvider } = require('@opentelemetry/node');
const { SimpleSpanProcessor } = require('@opentelemetry/tracing');
const { JaegerExporter } = require('@opentelemetry/exporter-jaeger');

// Setup tracing
const tracerProvider = new NodeTracerProvider();
tracerProvider.addSpanProcessor(
  new SimpleSpanProcessor(
    new JaegerExporter({
      serviceName: 'my-service',
      tags: [], // optional
      maxPacketSize: 65000 // optional
    })
  )
);
tracerProvider.register();

// Create spans for operations
const tracer = tracerProvider.getTracer('default');

app.get('/api/process', async (req, res) => {
  const span = tracer.startSpan('process_request');
  
  try {
    span.setAttribute('http.method', req.method);
    span.setAttribute('http.url', req.url);
    
    // Child span for database operation
    const dbSpan = tracer.startSpan('database_query', { parent: span });
    const data = await db.query('SELECT * FROM users');
    dbSpan.end();
    
    // Child span for external API call
    const apiSpan = tracer.startSpan('external_api_call', { parent: span });
    const result = await fetch('https://api.example.com/data');
    apiSpan.end();
    
    span.end();
    res.json(data);
  } catch (error) {
    span.recordException(error);
    span.setStatus({ code: 2, message: error.message }); // Error status
    span.end();
    res.status(500).json({ error: error.message });
  }
});
```

**7. Log aggregation and analysis:**

**ELK Stack (Elasticsearch, Logstash, Kibana):**
```javascript
// Winston Elasticsearch transport
const { ElasticsearchTransport } = require('winston-elasticsearch');

const esTransport = new ElasticsearchTransport({
  level: 'info',
  clientOpts: {
    node: 'http://localhost:9200',
    auth: {
      username: 'elastic',
      password: 'changeme'
    }
  },
  indexPrefix: 'logs',
  indexSuffixPattern: 'YYYY.MM.DD'
});

logger.add(esTransport);
```

**Best practices for performance logging:**

1. **Use structured logging**: JSON format for easy parsing
2. **Include context**: Correlation IDs, user IDs, timestamps
3. **Log at appropriate levels**: Error, warn, info, debug
4. **Avoid sensitive data**: No passwords, tokens, PII
5. **Implement log rotation**: Prevent disk space issues
6. **Monitor log volume**: Alert on abnormal patterns
7. **Test logging**: Ensure logs are captured correctly

**Common pitfalls:**
- **Over-logging**: Too much data, hard to analyze
- **Under-logging**: Missing critical information
- **Synchronous logging**: Blocking event loop
- **No correlation**: Can't trace request flow
- **Plain text logs**: Hard to parse and analyze

**Real-world example:** Netflix uses distributed tracing with detailed performance logging to monitor their microservices, allowing them to identify bottlenecks across thousands of services.

**Remember:** Effective performance logging provides the data needed to understand application behavior, identify issues, and make informed optimization decisions.

---

#### 4. What are APM tools and which ones are popular for Node.js?

**Answer:**

**APM (Application Performance Monitoring)** tools provide comprehensive monitoring solutions that track application performance, errors, dependencies, and user experience in production environments.

**What APM tools provide:**

1. **Performance monitoring**: Response times, throughput, error rates
2. **Distributed tracing**: End-to-end request tracing
3. **Error tracking**: Real-time error detection and alerting
4. **Infrastructure monitoring**: CPU, memory, disk, network
5. **User experience monitoring**: Real user monitoring (RUM)
6. **Business metrics**: Conversion rates, user behavior
7. **Alerting**: Proactive notification of issues
8. **Dashboards**: Visualization of metrics and trends

**Popular APM tools for Node.js:**

**1. New Relic:**
- **Strengths**: Comprehensive monitoring, easy setup, good documentation
- **Features**: APM, infrastructure, browser, mobile, synthetics
- **Pricing**: Freemium model, paid tiers for advanced features

```javascript
// Installation
npm install newrelic

// Configuration (newrelic.js)
exports.config = {
  app_name: ['My Application'],
  license_key: 'your-license-key',
  logging: {
    level: 'info',
    filepath: 'newrelic_agent.log'
  },
  allow_all_headers: true,
  attributes: {
    exclude: [
      'request.headers.cookie',
      'request.headers.authorization',
      'request.headers.proxyAuthorization',
      'request.headers.setCookie*',
      'request.headers.x*',
      'response.headers.cookie',
      'response.headers.authorization',
      'response.headers.proxyAuthorization',
      'response.headers.setCookie*',
      'response.headers.x*'
    ]
  }
};

// In your main file (first line)
require('newrelic');
```

**2. Datadog APM:**
- **Strengths**: Integration with other Datadog products, good for cloud-native
- **Features**: APM, logs, infrastructure, synthetics, RUM
- **Pricing**: Based on host count and features

```javascript
// Installation
npm install dd-trace

// Configuration
const tracer = require('dd-trace').init({
  service: 'my-node-app',
  env: process.env.NODE_ENV,
  version: '1.0.0',
  logInjection: true,
  runtimeMetrics: true,
  profiling: true,
  dbmPropagationMode: 'service'
});

// Automatic instrumentation for Express, MongoDB, Redis, etc.
```

**3. Elastic APM:**
- **Strengths**: Open source, integrates with ELK stack
- **Features**: Distributed tracing, error tracking, metrics
- **Pricing**: Open source (free), paid for support and features

```javascript
// Installation
npm install elastic-apm-node

// Configuration
const apm = require('elastic-apm-node').start({
  serviceName: 'my-app',
  secretToken: 'your-token',
  serverUrl: 'https://apm-server:8200',
  environment: 'production',
  logLevel: 'info',
  captureBody: 'all',
  captureHeaders: true,
  transactionSampleRate: 1.0
});

// Automatic instrumentation
```

**4. AppDynamics:**
- **Strengths**: Enterprise features, business transaction monitoring
- **Features**: APM, infrastructure, database, end-user monitoring
- **Pricing**: Enterprise pricing model

```javascript
// Installation
npm install appdynamics

// Configuration
require('appdynamics').profile({
  controllerHostName: 'controller.example.com',
  controllerPort: 8090,
  controllerSslEnabled: false,
  accountName: 'customer1',
  accountAccessKey: 'your-access-key',
  applicationName: 'MyApp',
  tierName: 'API',
  nodeName: 'API-1',
  reuseNode: true,
  reuseNodePrefix: 'API'
});
```

**5. Dynatrace:**
- **Strengths**: AI-powered insights, automatic discovery
- **Features**: Full-stack monitoring, AIOps, cloud automation
- **Pricing**: Premium enterprise solution

**6. Scout APM:**
- **Strengths**: Simple setup, focused on application performance
- **Features**: Performance monitoring, error tracking, trace drilling
- **Pricing**: Transparent pricing based on host count

**7. Instana:**
- **Strengths**: Automatic discovery, real-time monitoring
- **Features**: Infrastructure, applications, traces, profiles
- **Pricing**: Based on host count

**Comparison of APM tools:**

| Tool | Open Source | Ease of Setup | Features | Pricing | Best For |
|------|-------------|---------------|----------|---------|----------|
| **New Relic** | No | Very Easy | Comprehensive | Freemium | General purpose |
| **Datadog** | No | Easy | Integrated platform | Usage-based | Cloud-native |
| **Elastic APM** | Yes | Moderate | ELK integration | Free/Paid | Open source fans |
| **AppDynamics** | No | Complex | Enterprise features | Enterprise | Large enterprises |
| **Dynatrace** | No | Complex | AI-powered | Premium | AI-driven insights |
| **Scout APM** | No | Very Easy | Simple & focused | Host-based | Simplicity |
| **Instana** | No | Easy | Automatic discovery | Host-based | Dynamic environments |

**Key features to look for:**

**1. Distributed tracing:**
- End-to-end request tracing
- Service dependency mapping
- Performance bottleneck identification

**2. Error tracking:**
- Real-time error detection
- Error grouping and deduplication
- Stack trace analysis

**3. Real User Monitoring (RUM):**
- Browser performance monitoring
- User session replay
- Page load performance

**4. Synthetic monitoring:**
- Automated testing from multiple locations
- Uptime monitoring
- Performance from user perspective

**5. Infrastructure monitoring:**
- Server metrics (CPU, memory, disk)
- Container and orchestration monitoring
- Cloud service integration

**Implementation considerations:**

**1. Performance overhead:**
- APM agents add some overhead (typically 1-5%)
- Test impact on production performance
- Adjust sampling rates if needed

**2. Data volume:**
- APM tools generate large amounts of data
- Consider data retention policies
- Monitor storage costs

**3. Security:**
- Ensure sensitive data is not captured
- Use data masking features
- Secure communication with APM servers

**4. Integration:**
- Ensure compatibility with your stack
- Check for framework-specific integrations
- Consider future technology choices

**Choosing the right APM tool:**

**For startups/small teams:**
- **New Relic**: Free tier, easy setup
- **Elastic APM**: Open source, self-hosted
- **Scout APM**: Simple, affordable

**For medium/large enterprises:**
- **Datadog**: Comprehensive, integrates with everything
- **AppDynamics**: Enterprise features, support
- **Dynatrace**: AI-powered, automatic

**For cloud-native applications:**
- **Datadog**: Native cloud integration
- **New Relic**: Good cloud support
- **Instana**: Automatic discovery

**Real-world usage:**

**Netflix**: Uses multiple monitoring tools including Atlas, Vector, and commercial APM
**Uber**: Built custom monitoring (uMonitor) and uses commercial tools
**Airbnb**: Uses Datadog for comprehensive monitoring
**Spotify**: Uses Prometheus, Grafana, and commercial APM

**Best practices for APM implementation:**

1. **Start early**: Implement in development/staging first
2. **Define metrics**: Know what you want to monitor
3. **Set alerts**: Proactive notification of issues
4. **Train team**: Ensure everyone can use the tool
5. **Review regularly**: Weekly performance reviews
6. **Integrate with CI/CD**: Performance testing in pipeline
7. **Plan for scale**: Consider data volume and costs

**Remember:** APM tools provide valuable insights but are not a substitute for good application architecture and performance optimization. Use them to identify issues and validate improvements.

---

#### 5. How do you handle performance profiling in production?

**Answer:**

**Performance profiling** in production involves analyzing application behavior under real load to identify bottlenecks, memory leaks, and optimization opportunities while minimizing impact on users.

**Approaches to production profiling:**

**1. Sampling profilers (low overhead):**

**Using clinic.js (by NearForm):**
```bash
# Install clinic.js
npm install -g clinic

# Profile CPU usage
clinic doctor -- node app.js

# Profile memory usage  
clinic flame -- node app.js

# Profile I/O operations
clinic bubbleprof -- node app.js
```

**Using 0x (flamegraph generator):**
```bash
# Generate flamegraph
0x app.js

# With specific options
0x -- node --inspect app.js
```

**2. Node.js built-in profiler:**
```javascript
// Start profiling programmatically
const profiler = require('v8-profiler-next');

// Start CPU profiling
profiler.startProfiling('CPU', true);

// After some time, stop and save
setTimeout(() => {
  const profile = profiler.stopProfiling('CPU');
  
  profile.export()
    .pipe(fs.createWriteStream(`cpu-profile-${Date.now()}.cpuprofile`))
    .on('finish', () => {
      profile.delete();
      console.log('CPU profile saved');
    });
}, 30000); // Profile for 30 seconds

// Heap snapshot
const snapshot = profiler.takeSnapshot();
snapshot.export()
  .pipe(fs.createWriteStream(`heap-snapshot-${Date.now()}.heapsnapshot`))
  .on('finish', () => {
    snapshot.delete();
    console.log('Heap snapshot saved');
  });
```

**3. Chrome DevTools profiling:**
```bash
# Start Node.js with inspector
node --inspect app.js

# Or with specific port
node --inspect=9229 app.js

# Connect Chrome DevTools to chrome://inspect
# Use Performance and Memory tabs for profiling
```

**4. Production-safe profiling techniques:**

**A. Sampling with controlled overhead:**
```javascript
class ProductionProfiler {
  constructor(samplingRate = 0.01) { // 1% of requests
    this.samplingRate = samplingRate;
    this.profiler = require('v8-profiler-next');
    this.isProfiling = false;
  }
  
  shouldProfile() {
    return Math.random() < this.samplingRate;
  }
  
  startProfile() {
    if (!this.isProfiling && this.shouldProfile()) {
      this.profiler.startProfiling('production', true);
      this.isProfiling = true;
      this.startTime = Date.now();
      
      // Auto-stop after 30 seconds
      setTimeout(() => this.stopProfile(), 30000);
      
      console.log('Started production profiling');
    }
  }
  
  stopProfile() {
    if (this.isProfiling) {
      const profile = this.profiler.stopProfiling('production');
      const duration = Date.now() - this.startTime;
      
      // Save to S3 or cloud storage (not local disk in production)
      this.uploadProfile(profile, duration);
      
      this.isProfiling = false;
      console.log('Stopped production profiling');
    }
  }
  
  uploadProfile(profile, duration) {
    profile.export()
      .on('error', (err) => console.error('Profile export error:', err))
      .pipe(this.createUploadStream(`profile-${Date.now()}.cpuprofile`))
      .on('finish', () => {
        profile.delete();
        console.log(`Profile uploaded (${duration}ms)`);
      });
  }
  
  createUploadStream(filename) {
    // Implement upload to cloud storage
    // AWS S3, Google Cloud Storage, etc.
    return new require('stream').PassThrough();
  }
}

// Usage
const profiler = new ProductionProfiler(0.01); // 1% sampling

// Trigger profiling on specific conditions
app.use((req, res, next) => {
  // Profile slow requests
  const start = Date.now();
  
  res.on('finish', () => {
    const duration = Date.now() - start;
    
    if (duration > 1000) { // Requests slower than 1 second
      profiler.startProfile();
    }
  });
  
  next();
});
```

**B. Memory leak detection:**
```javascript
class MemoryLeakDetector {
  constructor() {
    this.snapshots = [];
    this.maxSnapshots = 10;
    this.interval = 300000; // 5 minutes
  }
  
  start() {
    setInterval(() => this.takeSnapshot(), this.interval);
  }
  
  takeSnapshot() {
    const heap = process.memoryUsage();
    const snapshot = {
      timestamp: new Date().toISOString(),
      heapUsed: heap.heapUsed,
      heapTotal: heap.heapTotal,
      rss: heap.rss,
      external: heap.external,
      arrayBuffers: heap.arrayBuffers
    };
    
    this.snapshots.push(snapshot);
    
    // Keep only recent snapshots
    if (this.snapshots.length > this.maxSnapshots) {
      this.snapshots.shift();
    }
    
    // Check for memory growth
    this.checkForLeaks();
    
    return snapshot;
  }
  
  checkForLeaks() {
    if (this.snapshots.length < 3) return;
    
    const recent = this.snapshots.slice(-3);
    const growthRate = this.calculateGrowthRate(recent);
    
    if (growthRate > 0.1) { // 10% growth over 15 minutes
      console.warn('Possible memory leak detected:', {
        growthRate: growthRate.toFixed(2),
        recentSnapshots: recent
      });
      
      // Trigger heap dump for analysis
      this.captureHeapDump();
    }
  }
  
  calculateGrowthRate(snapshots) {
    const first = snapshots[0].heapUsed;
    const last = snapshots[snapshots.length - 1].heapUsed;
    return (last - first) / first;
  }
  
  captureHeapDump() {
    const heapdump = require('heapdump');
    const filename = `heapdump-${Date.now()}.heapsnapshot`;
    
    heapdump.writeSnapshot(filename, (err, filename) => {
      if (err) {
        console.error('Heap dump failed:', err);
      } else {
        console.log('Heap dump saved:', filename);
        // Upload to cloud storage for analysis
      }
    });
  }
}

// Usage
const leakDetector = new MemoryLeakDetector();
leakDetector.start();
```

**C. Performance regression detection:**
```javascript
class PerformanceRegressionDetector {
  constructor(baseline, threshold = 0.2) { // 20% degradation
    this.baseline = baseline; // { endpoint: { p95: 100, p99: 200 } }
    this.threshold = threshold;
    this.currentMetrics = new Map();
  }
  
  recordMetric(endpoint, duration) {
    if (!this.currentMetrics.has(endpoint)) {
      this.currentMetrics.set(endpoint, []);
    }
    
    const metrics = this.currentMetrics.get(endpoint);
    metrics.push(duration);
    
    // Keep only recent metrics
    if (metrics.length > 1000) {
      metrics.shift();
    }
  }
  
  checkRegression() {
    const regressions = [];
    
    for (const [endpoint, metrics] of this.currentMetrics) {
      if (metrics.length < 100) continue; // Need sufficient data
      
      const baseline = this.baseline[endpoint];
      if (!baseline) continue;
      
      const sorted = [...metrics].sort((a, b) => a - b);
      const p95Index = Math.floor(sorted.length * 0.95);
      const p99Index = Math.floor(sorted.length * 0.99);
      
      const currentP95 = sorted[p95Index];
      const currentP99 = sorted[p99Index];
      
      const p95Regression = (currentP95 - baseline.p95) / baseline.p95;
      const p99Regression = (currentP99 - baseline.p99) / baseline.p99;
      
      if (p95Regression > this.threshold || p99Regression > this.threshold) {
        regressions.push({
          endpoint,
          baselineP95: baseline.p95,
          currentP95: currentP95,
          p95Regression: p95Regression.toFixed(2),
          baselineP99: baseline.p99,
          currentP99: currentP99,
          p99Regression: p99Regression.toFixed(2),
          timestamp: new Date().toISOString()
        });
      }
    }
    
    return regressions;
  }
}

// Usage
const detector = new PerformanceRegressionDetector({
  '/api/users': { p95: 100, p99: 200 },
  '/api/products': { p95: 150, p99: 300 }
});

// Record metrics
app.use((req, res, next) => {
  const start = Date.now();
  
  res.on('finish', () => {
    const duration = Date.now() - start;
    detector.recordMetric(req.path, duration);
  });
  
  next();
});

// Check for regressions periodically
setInterval(() => {
  const regressions = detector.checkRegression();
  
  if (regressions.length > 0) {
    console.error('Performance regressions detected:', regressions);
    // Send alert
  }
}, 300000); // Every 5 minutes
```

**Production profiling best practices:**

**1. Safety first:**
- Use sampling to minimize overhead
- Profile during low-traffic periods
- Have rollback plan if issues occur
- Monitor profiling impact

**2. Data management:**
- Store profiles in cloud storage
- Automate cleanup of old profiles
- Compress profile data
- Secure sensitive information

**3. Analysis workflow:**
- **Collect**: Gather profiles from production
- **Analyze**: Use tools (Chrome DevTools, speedscope)
- **Identify**: Find bottlenecks and issues
- **Fix**: Implement optimizations
- **Verify**: Test improvements

**4. Tooling:**
- **Flamegraphs**: Identify hot code paths
- **Heap snapshots**: Analyze memory usage
- **CPU profiles**: Find expensive operations
- **Tracing**: Understand request flow

**5. Organizational practices:**
- **Performance culture**: Everyone cares about performance
- **Regular profiling**: Scheduled performance analysis
- **Knowledge sharing**: Share findings and fixes
- **Documentation**: Record performance characteristics

**Real-world production profiling scenarios:**

**Scenario 1: Sudden performance degradation**
- **Symptoms**: Response times increased 50%
- **Approach**: Enable sampling profiler, analyze recent changes
- **Solution**: Found inefficient database query, added index

**Scenario 2: Memory leak**
- **Symptoms**: Memory grows until restart
- **Approach**: Periodic heap snapshots, compare over time
- **Solution**: Found event listener leak, fixed cleanup

**Scenario 3: High CPU usage**
- **Symptoms**: 100% CPU during peak load
- **Approach**: CPU profiling during peak, flamegraph analysis
- **Solution**: Optimized JSON parsing, reduced CPU by 40%

**Tools for production profiling analysis:**

1. **Chrome DevTools**: Load .cpuprofile and .heapsnapshot files
2. **speedscope.app**: Web-based flamegraph viewer
3. **clinic.js**: Analysis of clinic doctor/flame outputs
4. **0x**: Flamegraph generation and analysis
5. **heapdump**: Heap snapshot analysis

**Remember:** Production profiling should be done carefully with proper safeguards. The goal is to gain insights without impacting user experience. Start with low-risk approaches (sampling, off-peak hours) and gradually increase profiling as you gain confidence.

---
## 46. File Uploads with Multer

#### 1. How do you handle file uploads in Express?

**Answer:**

**File uploads in Express** require handling multipart/form-data, which is different from standard JSON or URL-encoded data. Express doesn't handle file uploads natively, so you need middleware to parse multipart data.

**Approaches to file uploads:**

**1. Using Multer (recommended):**
```javascript
const multer = require('multer');
const upload = multer({ dest: 'uploads/' });

app.post('/upload', upload.single('file'), (req, res) => {
  // req.file contains the uploaded file
  res.json({
    filename: req.file.originalname,
    size: req.file.size,
    mimetype: req.file.mimetype,
    path: req.file.path
  });
});
```

**2. Using Formidable (alternative):**
```javascript
const formidable = require('formidable');

app.post('/upload', (req, res) => {
  const form = new formidable.IncomingForm();
  form.uploadDir = 'uploads/';
  form.keepExtensions = true;
  
  form.parse(req, (err, fields, files) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    
    res.json({
      files: files,
      fields: fields
    });
  });
});
```

**3. Using busboy (low-level):**
```javascript
const busboy = require('busboy');

app.post('/upload', (req, res) => {
  const bb = busboy({ headers: req.headers });
  const files = [];
  
  bb.on('file', (name, file, info) => {
    const { filename, encoding, mimeType } = info;
    const chunks = [];
    
    file.on('data', (chunk) => {
      chunks.push(chunk);
    });
    
    file.on('end', () => {
      files.push({
        name: filename,
        type: mimeType,
        data: Buffer.concat(chunks)
      });
    });
  });
  
  bb.on('close', () => {
    res.json({ files: files.length });
  });
  
  req.pipe(bb);
});
```

**4. Using express-fileupload:**
```javascript
const fileUpload = require('express-fileupload');

app.use(fileUpload({
  useTempFiles: true,
  tempFileDir: '/tmp/'
}));

app.post('/upload', (req, res) => {
  if (!req.files || Object.keys(req.files).length === 0) {
    return res.status(400).json({ error: 'No files uploaded' });
  }
  
  const file = req.files.file;
  file.mv(`uploads/${file.name}`, (err) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json({ message: 'File uploaded successfully' });
  });
});
```

**Comparison of file upload libraries:**

| Library | Pros | Cons | Use Case |
|---------|------|------|----------|
| **Multer** | Most popular, good documentation, flexible | Requires disk storage or memory management | General file uploads |
| **Formidable** | Streaming support, no dependencies | Less active development | Large file uploads |
| **busboy** | Low-level, streaming, efficient | Manual implementation needed | Custom upload logic |
| **express-fileupload** | Simple API, easy setup | Less flexible, security concerns | Quick prototypes |

**Basic file upload flow:**

1. **Client sends multipart/form-data**: HTML form or fetch with FormData
2. **Middleware parses request**: Extracts files and fields
3. **File processing**: Validation, storage, transformation
4. **Response**: Success/error message with file info

**HTML form example:**
```html
<form action="/upload" method="POST" enctype="multipart/form-data">
  <input type="file" name="file" />
  <input type="text" name="description" />
  <button type="submit">Upload</button>
</form>
```

**JavaScript fetch example:**
```javascript
const formData = new FormData();
formData.append('file', fileInput.files[0]);
formData.append('description', 'My file');

fetch('/upload', {
  method: 'POST',
  body: formData
});
```

**Real-world example:** A photo sharing application uses Multer to handle image uploads, validates file types, resizes images, and stores them in cloud storage (S3) with CDN distribution.

**Best practices for file uploads:**

1. **Use middleware**: Don't parse multipart data manually
2. **Set size limits**: Prevent DoS attacks
3. **Validate file types**: Security check
4. **Use temporary storage**: Process before final storage
5. **Implement progress tracking**: User feedback for large files
6. **Handle errors gracefully**: Clear error messages
7. **Clean up temp files**: Prevent disk space issues

**Common pitfalls:**
- **No size limits**: Server can be overwhelmed
- **Insecure file types**: Malicious file uploads
- **No validation**: Trusting client-provided data
- **Blocking event loop**: Synchronous file operations
- **Disk space issues**: Not cleaning temp files

**Remember:** File uploads are a common attack vector. Always validate, sanitize, and process uploaded files securely before storing or using them.

---

#### 2. What is Multer and how does it work?

**Answer:**

**Multer** is a Node.js middleware for handling `multipart/form-data`, which is primarily used for uploading files. It's built on top of busboy for maximum efficiency and is the most popular file upload solution for Express.

**How Multer works:**

1. **Intercepts multipart requests**: Detects Content-Type: multipart/form-data
2. **Parses form data**: Separates files from text fields
3. **Processes files**: Stores in memory, disk, or custom storage
4. **Attaches to request**: Makes files available in req.file or req.files
5. **Cleans up**: Removes temp files if configured

**Core concepts:**

**1. Storage engines:**
- **DiskStorage**: Stores files on disk
- **MemoryStorage**: Stores files in memory (Buffer)
- **Custom storage**: Implement your own storage engine

**2. Upload methods:**
- **.single(fieldname)**: Single file upload
- **.array(fieldname, maxCount)**: Multiple files (same field)
- **.fields(fields)**: Multiple files (different fields)
- **.any()**: Any files (use with caution)
- **.none()**: No files, only text fields

**Basic Multer setup:**
```javascript
const multer = require('multer');
const path = require('path');

// Configure storage
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/'); // Save to uploads directory
  },
  filename: (req, file, cb) => {
    // Create unique filename
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    const ext = path.extname(file.originalname);
    cb(null, file.fieldname + '-' + uniqueSuffix + ext);
  }
});

// Create upload middleware
const upload = multer({ 
  storage: storage,
  limits: {
    fileSize: 5 * 1024 * 1024 // 5MB limit
  },
  fileFilter: (req, file, cb) => {
    // Accept images only
    if (file.mimetype.startsWith('image/')) {
      cb(null, true);
    } else {
      cb(new Error('Only image files are allowed'), false);
    }
  }
});

// Use in routes
app.post('/upload', upload.single('avatar'), (req, res) => {
  // req.file contains the uploaded file
  res.json({ file: req.file });
});
```

**File object structure:**
```javascript
{
  fieldname: 'avatar',        // Form field name
  originalname: 'profile.jpg', // Original filename
  encoding: '7bit',           // File encoding
  mimetype: 'image/jpeg',     // MIME type
  destination: 'uploads/',    // Storage directory
  filename: 'avatar-123456789.jpg', // Saved filename
  path: 'uploads/avatar-123456789.jpg', // Full path
  size: 123456                // File size in bytes
}
```

**Memory storage (for processing before saving):**
```javascript
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

app.post('/upload', upload.single('file'), (req, res) => {
  // File is in memory as Buffer
  const buffer = req.file.buffer;
  
  // Process buffer (resize, compress, etc.)
  processImage(buffer).then(processed => {
    // Save processed file
    fs.writeFileSync(`processed/${req.file.originalname}`, processed);
    res.json({ message: 'File processed and saved' });
  });
});
```

**Custom storage engine:**
```javascript
class CloudStorage {
  constructor(bucket) {
    this.bucket = bucket;
  }
  
  _handleFile(req, file, cb) {
    // Implement file handling
    const chunks = [];
    
    file.stream.on('data', (chunk) => {
      chunks.push(chunk);
    });
    
    file.stream.on('end', () => {
      const buffer = Buffer.concat(chunks);
      
      // Upload to cloud storage
      uploadToCloud(this.bucket, file.originalname, buffer)
        .then(url => {
          cb(null, {
            filename: file.originalname,
            size: buffer.length,
            cloudUrl: url
          });
        })
        .catch(err => cb(err));
    });
    
    file.stream.on('error', cb);
  }
  
  _removeFile(req, file, cb) {
    // Implement file removal
    deleteFromCloud(this.bucket, file.filename)
      .then(() => cb(null))
      .catch(cb);
  }
}

const upload = multer({ storage: new CloudStorage('my-bucket') });
```

**Multiple file upload scenarios:**

**Single field, multiple files:**
```javascript
app.post('/upload-multiple', upload.array('photos', 10), (req, res) => {
  // req.files is an array of files
  res.json({ 
    count: req.files.length,
    files: req.files.map(f => f.originalname)
  });
});
```

**Multiple fields, different files:**
```javascript
app.post('/upload-fields', upload.fields([
  { name: 'avatar', maxCount: 1 },
  { name: 'gallery', maxCount: 5 }
]), (req, res) => {
  // req.files is an object
  const avatar = req.files.avatar[0];
  const gallery = req.files.gallery;
  
  res.json({
    avatar: avatar.originalname,
    galleryCount: gallery.length
  });
});
```

**Error handling:**
```javascript
app.post('/upload', upload.single('file'), (req, res) => {
  // Success handler
  res.json({ file: req.file });
});

// Error handling middleware
app.use((err, req, res, next) => {
  if (err instanceof multer.MulterError) {
    // Multer-specific errors
    if (err.code === 'LIMIT_FILE_SIZE') {
      return res.status(400).json({ error: 'File too large' });
    }
    if (err.code === 'LIMIT_FILE_COUNT') {
      return res.status(400).json({ error: 'Too many files' });
    }
    if (err.code === 'LIMIT_UNEXPECTED_FILE') {
      return res.status(400).json({ error: 'Unexpected file field' });
    }
  } else if (err) {
    // Other errors
    return res.status(400).json({ error: err.message });
  }
  
  next(err);
});
```

**Real-world Multer usage patterns:**

**E-commerce product images:**
- Multiple image upload (main + gallery)
- Image validation (type, size, dimensions)
- Automatic resizing for thumbnails
- Cloud storage with CDN

**Document management system:**
- Various file types (PDF, DOC, XLS)
- Virus scanning before storage
- Metadata extraction
- Version control

**Social media platform:**
- Image and video uploads
- Compression and optimization
- Content moderation
- User quota management

**Best practices with Multer:**

1. **Always set limits**: File size, file count
2. **Implement fileFilter**: Validate file types
3. **Use secure filenames**: Prevent path traversal
4. **Clean up temp files**: Automatic or manual cleanup
5. **Handle errors properly**: User-friendly error messages
6. **Test with large files**: Ensure memory/disk handling works
7. **Monitor uploads**: Log and track upload activity

**Common Multer issues:**

1. **Memory exhaustion**: With memoryStorage and large files
2. **Disk space issues**: Not cleaning temp files
3. **Filename collisions**: Non-unique filenames
4. **Security vulnerabilities**: File type validation bypass
5. **Performance problems**: Synchronous operations in callbacks

**Remember:** Multer is a powerful tool but requires proper configuration for security and performance. Always validate files, set appropriate limits, and handle errors gracefully.

---
#### 3. How do you validate file types and sizes?

**Answer:**

**File validation** is critical for security and functionality. Without proper validation, attackers can upload malicious files, overwhelm storage, or crash the application.

**Validation techniques:**

**1. File type validation (MIME types):**
```javascript
const multer = require('multer');
const path = require('path');

// Allowed MIME types
const allowedMimeTypes = [
  'image/jpeg',
  'image/png',
  'image/gif',
  'image/webp',
  'application/pdf',
  'text/plain'
];

// File filter function
const fileFilter = (req, file, cb) => {
  // Check MIME type
  if (allowedMimeTypes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error('Invalid file type. Only images, PDFs, and text files are allowed.'), false);
  }
};

// Check file extension (additional safety)
const checkExtension = (req, file, cb) => {
  const allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.pdf', '.txt'];
  const ext = path.extname(file.originalname).toLowerCase();
  
  if (allowedExtensions.includes(ext)) {
    cb(null, true);
  } else {
    cb(new Error(`File extension ${ext} is not allowed`), false);
  }
};

const upload = multer({
  fileFilter: (req, file, cb) => {
    // Combine both checks
    if (fileFilter(req, file, (err, ok) => {
      if (!ok) return cb(err, false);
      checkExtension(req, file, cb);
    }));
  }
});
```

**2. File size validation:**
```javascript
const upload = multer({
  limits: {
    fileSize: 5 * 1024 * 1024, // 5MB
    files: 5, // Maximum 5 files
    fields: 10 // Maximum 10 non-file fields
  }
});

// Custom size validation per file type
const sizeLimits = {
  'image/jpeg': 10 * 1024 * 1024, // 10MB for JPEG
  'image/png': 5 * 1024 * 1024,   // 5MB for PNG
  'application/pdf': 20 * 1024 * 1024, // 20MB for PDF
  'default': 2 * 1024 * 1024 // 2MB default
};

const fileFilterWithSize = (req, file, cb) => {
  const maxSize = sizeLimits[file.mimetype] || sizeLimits.default;
  
  // Note: Multer handles size limits automatically with limits.fileSize
  // This is for custom per-type validation
  cb(null, true);
};
```

**3. File content validation (magic numbers):**
```javascript
const fileType = require('file-type');

// Validate file content (not just extension/MIME)
const validateFileContent = async (buffer) => {
  const type = await fileType.fromBuffer(buffer);
  
  if (!type) {
    throw new Error('Cannot determine file type');
  }
  
  const allowedTypes = [
    { ext: 'jpg', mime: 'image/jpeg' },
    { ext: 'png', mime: 'image/png' },
    { ext: 'gif', mime: 'image/gif' },
    { ext: 'pdf', mime: 'application/pdf' }
  ];
  
  const isValid = allowedTypes.some(allowed => 
    allowed.ext === type.ext && allowed.mime === type.mime
  );
  
  if (!isValid) {
    throw new Error(`Invalid file content. Detected: ${type.ext} (${type.mime})`);
  }
  
  return type;
};

// Usage with memory storage
const upload = multer({ storage: multer.memoryStorage() });

app.post('/upload', upload.single('file'), async (req, res) => {
  try {
    const fileType = await validateFileContent(req.file.buffer);
    
    // File is valid, proceed with processing
    res.json({ 
      message: 'File validated successfully',
      type: fileType 
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});
```

**4. Image-specific validation (dimensions, EXIF):**
```javascript
const sharp = require('sharp');

const validateImage = async (buffer) => {
  const image = sharp(buffer);
  const metadata = await image.metadata();
  
  // Check dimensions
  if (metadata.width > 5000 || metadata.height > 5000) {
    throw new Error('Image dimensions too large (max 5000x5000)');
  }
  
  if (metadata.width < 100 || metadata.height < 100) {
    throw new Error('Image dimensions too small (min 100x100)');
  }
  
  // Check aspect ratio
  const aspectRatio = metadata.width / metadata.height;
  if (aspectRatio < 0.5 || aspectRatio > 2) {
    throw new Error('Image aspect ratio must be between 0.5 and 2');
  }
  
  // Check for EXIF data (optional)
  if (metadata.exif) {
    // You might want to strip or validate EXIF data
    console.log('Image contains EXIF data');
  }
  
  return metadata;
};
```

**5. Comprehensive validation middleware:**
```javascript
class FileValidator {
  constructor(options = {}) {
    this.options = {
      maxSize: 10 * 1024 * 1024, // 10MB default
      allowedTypes: ['image/jpeg', 'image/png', 'application/pdf'],
      allowedExtensions: ['.jpg', '.jpeg', '.png', '.pdf'],
      maxFiles: 5,
      ...options
    };
  }
  
  validateSingle(file) {
    const errors = [];
    
    // Size validation
    if (file.size > this.options.maxSize) {
      errors.push(`File too large: ${file.size} bytes (max: ${this.options.maxSize})`);
    }
    
    // MIME type validation
    if (!this.options.allowedTypes.includes(file.mimetype)) {
      errors.push(`Invalid MIME type: ${file.mimetype}`);
    }
    
    // Extension validation
    const ext = path.extname(file.originalname).toLowerCase();
    if (!this.options.allowedExtensions.includes(ext)) {
      errors.push(`Invalid extension: ${ext}`);
    }
    
    // Filename validation (security)
    if (file.originalname.includes('..') || file.originalname.includes('/')) {
      errors.push('Invalid filename: path traversal attempt detected');
    }
    
    // Check for null bytes (security)
    if (file.originalname.includes('\0')) {
      errors.push('Invalid filename: null byte detected');
    }
    
    return {
      isValid: errors.length === 0,
      errors: errors
    };
  }
  
  validateMultiple(files) {
    const results = files.map(file => this.validateSingle(file));
    const allValid = results.every(r => r.isValid);
    const allErrors = results.flatMap(r => r.errors);
    
    // Check total file count
    if (files.length > this.options.maxFiles) {
      allErrors.push(`Too many files: ${files.length} (max: ${this.options.maxFiles})`);
    }
    
    return {
      isValid: allValid && allErrors.length === 0,
      errors: allErrors,
      fileResults: results
    };
  }
}

// Usage
const validator = new FileValidator({
  maxSize: 5 * 1024 * 1024,
  allowedTypes: ['image/jpeg', 'image/png'],
  allowedExtensions: ['.jpg', '.jpeg', '.png']
});

app.post('/upload', upload.single('file'), (req, res) => {
  const validation = validator.validateSingle(req.file);
  
  if (!validation.isValid) {
    return res.status(400).json({ 
      error: 'File validation failed',
      details: validation.errors 
    });
  }
  
  // File is valid, process it
  res.json({ message: 'File validated successfully' });
});
```

**6. Virus/malware scanning:**
```javascript
const clamscan = require('clamscan');
const fs = require('fs');

// Initialize ClamAV scanner
const scanner = new clamscan({
  removeInfected: false, // Don't remove infected files automatically
  quarantineInfected: 'quarantine/', // Move infected files here
  scanLog: 'scan.log', // Log file
  debugMode: false,
  fileList: null,
  scanRecursively: false,
  clamscan: {
    path: '/usr/bin/clamscan', // Path to clamscan binary
    db: null, // Custom virus database
    scanArchives: true,
    active: true
  }
});

const scanFile = async (filePath) => {
  try {
    const { isInfected, viruses } = await scanner.scanFile(filePath);
    
    if (isInfected) {
      throw new Error(`File infected with: ${viruses.join(', ')}`);
    }
    
    return { clean: true };
  } catch (error) {
    if (error.message.includes('ENOENT')) {
      // ClamAV not installed or file not found
      console.warn('Virus scanning not available:', error.message);
      return { clean: true, scanned: false };
    }
    throw error;
  }
};

// Usage in upload handler
app.post('/upload', upload.single('file'), async (req, res) => {
  try {
    // First, basic validation
    const basicValidation = validateBasic(req.file);
    if (!basicValidation.isValid) {
      return res.status(400).json({ error: basicValidation.errors });
    }
    
    // Then virus scan
    const scanResult = await scanFile(req.file.path);
    
    if (!scanResult.clean) {
      return res.status(400).json({ error: 'File failed virus scan' });
    }
    
    // File is safe, process it
    res.json({ message: 'File uploaded and scanned successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

**Real-world validation scenarios:**

**User profile pictures:**
- **Types**: JPEG, PNG, WebP
- **Size**: Max 2MB
- **Dimensions**: Min 100x100, max 2000x2000
- **Aspect ratio**: Square (0.9-1.1)
- **Content**: No malicious code, appropriate content

**Document uploads:**
- **Types**: PDF, DOC, DOCX, TXT
- **Size**: Max 10MB
- **Content**: No macros (for security)
- **Metadata**: Strip sensitive information
- **Virus scan**: Always scan documents

**Bulk image upload (e-commerce):**
- **Types**: JPEG, PNG
- **Size**: Max 5MB each
- **Count**: Max 20 files
- **Dimensions**: Consistent aspect ratios
- **Compression**: Auto-optimize for web

**Best practices for file validation:**

1. **Validate on server**: Never trust client-side validation
2. **Use multiple methods**: Extension, MIME, magic numbers
3. **Set reasonable limits**: Based on use case
4. **Scan for malware**: Especially for user uploads
5. **Log validation failures**: For security monitoring
6. **Provide clear errors**: Help users fix issues
7. **Test edge cases**: Empty files, corrupted files, malicious files

**Common validation mistakes:**

1. **Only checking extension**: Easy to bypass
2. **No size limits**: DoS vulnerability
3. **Trusting Content-Type header**: Can be spoofed
4. **No virus scanning**: Malware distribution risk
5. **Insecure filenames**: Path traversal attacks
6. **Blocking event loop**: Synchronous validation

**Remember:** File validation is a security requirement, not just a quality check. Implement multiple layers of validation to protect your application and users.

---

#### 4. How do you handle multiple file uploads?

**Answer:**

**Multiple file uploads** require careful handling of concurrent file processing, memory management, and user experience. Different scenarios need different approaches.

**Approaches to multiple file uploads:**

**1. Multiple files in single field (array):**
```javascript
const upload = multer({ dest: 'uploads/' });

// Handle up to 10 files in 'photos' field
app.post('/upload-array', upload.array('photos', 10), (req, res) => {
  // req.files is an array
  const files = req.files;
  
  res.json({
    count: files.length,
    files: files.map(file => ({
      name: file.originalname,
      size: file.size,
      type: file.mimetype
    }))
  });
});
```

**2. Multiple files in different fields (fields):**
```javascript
app.post('/upload-fields', upload.fields([
  { name: 'avatar', maxCount: 1 },
  { name: 'cover', maxCount: 1 },
  { name: 'gallery', maxCount: 5 }
]), (req, res) => {
  // req.files is an object
  const avatar = req.files.avatar ? req.files.avatar[0] : null;
  const cover = req.files.cover ? req.files.cover[0] : null;
  const gallery = req.files.gallery || [];
  
  res.json({
    avatar: avatar ? avatar.originalname : 'Not provided',
    cover: cover ? cover.originalname : 'Not provided',
    galleryCount: gallery.length
  });
});
```

**3. Any files from any field (use with caution):**
```javascript
// WARNING: Only use .any() with strict validation
app.post('/upload-any', upload.any(), (req, res) => {
  // req.files is an array of all uploaded files
  // You need to manually validate and process
  
  res.json({
    totalFiles: req.files.length,
    fileNames: req.files.map(f => f.originalname)
  });
});
```

**4. Sequential processing with progress tracking:**
```javascript
const processFile = (file) => {
  return new Promise((resolve, reject) => {
    // Simulate file processing
    setTimeout(() => {
      console.log(`Processed: ${file.originalname}`);
      resolve(file);
    }, 1000);
  });
};

app.post('/upload-sequential', upload.array('files', 10), async (req, res) => {
  const results = [];
  const errors = [];
  
  // Process files sequentially
  for (const file of req.files) {
    try {
      const result = await processFile(file);
      results.push({
        name: file.originalname,
        status: 'success',
        result: result
      });
    } catch (error) {
      errors.push({
        name: file.originalname,
        status: 'error',
        error: error.message
      });
    }
  }
  
  res.json({
    processed: results.length,
    failed: errors.length,
    results: results,
    errors: errors
  });
});
```

**5. Parallel processing with concurrency control:**
```javascript
const { promisify } = require('util');
const pipeline = promisify(require('stream').pipeline);
const fs = require('fs');

class ParallelUploadProcessor {
  constructor(maxConcurrent = 3) {
    this.maxConcurrent = maxConcurrent;
    this.queue = [];
    this.processing = 0;
  }
  
  async processFile(file) {
    // Process file (resize, compress, upload to cloud, etc.)
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        console.log(`Processed ${file.originalname}`);
        resolve({ ...file, processed: true });
      }, Math.random() * 2000); // Random processing time
    });
  }
  
  async addToQueue(file) {
    return new Promise((resolve, reject) => {
      this.queue.push({ file, resolve, reject });
      this.processQueue();
    });
  }
  
  async processQueue() {
    if (this.processing >= this.maxConcurrent || this.queue.length === 0) {
      return;
    }
    
    this.processing++;
    const { file, resolve, reject } = this.queue.shift();
    
    try {
      const result = await this.processFile(file);
      resolve(result);
    } catch (error) {
      reject(error);
    } finally {
      this.processing--;
      this.processQueue();
    }
  }
  
  async processAll(files) {
    const promises = files.map(file => this.addToQueue(file));
    return Promise.allSettled(promises);
  }
}

// Usage
const processor = new ParallelUploadProcessor(3); // Max 3 concurrent

app.post('/upload-parallel', upload.array('files', 20), async (req, res) => {
  try {
    const results = await processor.processAll(req.files);
    
    const successful = results.filter(r => r.status === 'fulfilled');
    const failed = results.filter(r => r.status === 'rejected');
    
    res.json({
      total: results.length,
      successful: successful.length,
      failed: failed.length,
      files: successful.map(r => r.value.originalname)
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

**6. Chunked file uploads (for large files):**
```javascript
// Client-side would split file into chunks
// Server-side reassembles chunks

const chunkStorage = multer.diskStorage({
  destination: 'chunks/',
  filename: (req, file, cb) => {
    // Format: fileId-chunkIndex-totalChunks.extension
    const { fileId, chunkIndex, totalChunks } = req.body;
    const ext = path.extname(file.originalname);
    cb(null, `${fileId}-${chunkIndex}-${totalChunks}${ext}`);
  }
});

const chunkUpload = multer({ storage: chunkStorage });

app.post('/upload-chunk', chunkUpload.single('chunk'), (req, res) => {
  const { fileId, chunkIndex, totalChunks, originalName } = req.body;
  
  // Store chunk metadata in database
  saveChunkMetadata({
    fileId,
    chunkIndex: parseInt(chunkIndex),
    totalChunks: parseInt(totalChunks),
    originalName,
    chunkPath: req.file.path
  });
  
  res.json({ 
    chunkIndex,
    received: true 
  });
});

app.post('/assemble-chunks', async (req, res) => {
  const { fileId } = req.body;
  
  // Get all chunks for this file
  const chunks = await getChunks(fileId);
  
  if (chunks.length !== chunks[0].totalChunks) {
    return res.status(400).json({ error: 'Not all chunks received' });
  }
  
  // Sort chunks by index
  chunks.sort((a, b) => a.chunkIndex - b.chunkIndex);
  
  // Assemble file
  const outputPath = `uploads/${chunks[0].originalName}`;
  const writeStream = fs.createWriteStream(outputPath);
  
  for (const chunk of chunks) {
    const chunkBuffer = fs.readFileSync(chunk.chunkPath);
    writeStream.write(chunkBuffer);
    
    // Clean up chunk file
    fs.unlinkSync(chunk.chunkPath);
  }
  
  writeStream.end();
  
  // Clean up metadata
  await deleteChunksMetadata(fileId);
  
  res.json({ 
    message: 'File assembled successfully',
    path: outputPath 
  });
});
```

**7. Batch processing with job queue:**
```javascript
const Queue = require('bull');
const fileQueue = new Queue('file processing');

// Worker process (separate from web server)
fileQueue.process(async (job) => {
  const { files, userId } = job.data;
  
  const results = [];
  for (const file of files) {
    // Process each file
    const result = await processSingleFile(file);
    results.push(result);
  }
  
  return { results, userId };
});

// Web server route
app.post('/upload-batch', upload.array('files', 50), async (req, res) => {
  // Add job to queue for background processing
  const job = await fileQueue.add({
    files: req.files,
    userId: req.user.id
  });
  
  // Return job ID for status tracking
  res.json({
    jobId: job.id,
    message: 'Files queued for processing',
    fileCount: req.files.length
  });
});

// Status check endpoint
app.get('/job-status/:jobId', async (req, res) => {
  const job = await fileQueue.getJob(req.params.jobId);
  
  if (!job) {
    return res.status(404).json({ error: 'Job not found' });
  }
  
  res.json({
    id: job.id,
    status: await job.getState(),
    progress: job.progress(),
    result: job.returnvalue,
    failedReason: job.failedReason
  });
});
```

**Real-world multiple file upload scenarios:**

**Photo gallery upload:**
- **Pattern**: Array upload (upload.array())
- **Features**: Progress bar, thumbnail generation, EXIF stripping
- **Optimization**: Parallel processing, CDN upload

**Document bundle upload:**
- **Pattern**: Fields upload (upload.fields())
- **Features**: Type validation, virus scanning, OCR processing
- **Optimization**: Sequential processing with dependency handling

**Bulk product import:**
- **Pattern**: Zip file upload + server-side extraction
- **Features**: CSV/Excel parsing, image processing, database import
- **Optimization**: Job queue for background processing

**Large media files:**
- **Pattern**: Chunked upload
- **Features**: Resume capability, checksum verification
- **Optimization**: Direct-to-cloud storage

**Best practices for multiple file uploads:**

1. **Set reasonable limits**: File count, total size
2. **Implement progress tracking**: User feedback
3. **Handle failures gracefully**: Partial success handling
4. **Use background processing**: For heavy operations
5. **Clean up temp files**: Prevent disk exhaustion
6. **Monitor resource usage**: Memory, CPU, disk I/O
7. **Test with realistic loads**: Concurrent users, large batches

**Common issues with multiple uploads:**

1. **Memory exhaustion**: Processing all files at once
2. **Timeout issues**: Long processing times
3. **Partial failures**: Some files succeed, others fail
4. **User experience**: No progress feedback
5. **Concurrency problems**: Race conditions
6. **Cleanup challenges**: Orphaned temp files

**Remember:** The approach depends on your specific use case. For small files (< 1MB), parallel processing works well. For large files or complex processing, consider background jobs or chunked uploads.

---
#### 5. What are the security considerations for file uploads?

**Answer:**

**File upload security** is critical because uploaded files can be used to attack your server, steal data, or compromise users. Every file upload feature is a potential attack vector that requires multiple layers of defense.

**Key security considerations:**

**1. File type validation (multiple layers):**
```javascript
// Defense in depth approach
const validateFileSecurity = (file) => {
  const securityChecks = [];
  
  // 1. Extension validation (easy to bypass, but first layer)
  const allowedExtensions = ['.jpg', '.jpeg', '.png', '.pdf', '.txt'];
  const ext = path.extname(file.originalname).toLowerCase();
  securityChecks.push({
    name: 'extension',
    passed: allowedExtensions.includes(ext),
    message: `Extension ${ext} not allowed`
  });
  
  // 2. MIME type validation (can be spoofed)
  const allowedMimeTypes = [
    'image/jpeg',
    'image/png',
    'application/pdf',
    'text/plain'
  ];
  securityChecks.push({
    name: 'mime-type',
    passed: allowedMimeTypes.includes(file.mimetype),
    message: `MIME type ${file.mimetype} not allowed`
  });
  
  // 3. Magic number validation (most reliable)
  const fileType = require('file-type');
  const buffer = file.buffer || fs.readFileSync(file.path);
  const detectedType = fileType.fromBuffer(buffer);
  
  if (detectedType) {
    const allowedMagicNumbers = [
      { ext: 'jpg', mime: 'image/jpeg' },
      { ext: 'png', mime: 'image/png' },
      { ext: 'pdf', mime: 'application/pdf' }
    ];
    
    const magicMatch = allowedMagicNumbers.some(allowed => 
      allowed.ext === detectedType.ext && allowed.mime === detectedType.mime
    );
    
    securityChecks.push({
      name: 'magic-numbers',
      passed: magicMatch,
      message: `File content doesn't match allowed types (detected: ${detectedType.ext})`
    });
  }
  
  // 4. File size validation
  const maxSize = 10 * 1024 * 1024; // 10MB
  securityChecks.push({
    name: 'size',
    passed: file.size <= maxSize,
    message: `File too large: ${file.size} bytes (max: ${maxSize})`
  });
  
  // Check if all security checks passed
  const failedChecks = securityChecks.filter(check => !check.passed);
  
  return {
    passed: failedChecks.length === 0,
    failedChecks: failedChecks.map(c => ({ name: c.name, message: c.message }))
  };
};
```

**2. Filename security (path traversal prevention):**
```javascript
const sanitizeFilename = (filename) => {
  // Remove directory traversal attempts
  let sanitized = filename
    .replace(/\.\./g, '')          // Remove ..
    .replace(/\//g, '')            // Remove /
    .replace(/\\/g, '')            // Remove \
    .replace(/\0/g, '');           // Remove null bytes
  
  // Remove control characters
  sanitized = sanitized.replace(/[^\x20-\x7E]/g, '');
  
  // Limit length
  if (sanitized.length > 255) {
    const ext = path.extname(sanitized);
    const name = path.basename(sanitized, ext);
    sanitized = name.substring(0, 255 - ext.length) + ext;
  }
  
  // Generate unique name to prevent overwrites
  const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
  const ext = path.extname(sanitized);
  const name = path.basename(sanitized, ext);
  
  return `${name}-${uniqueSuffix}${ext}`;
};

// Usage in Multer storage
const storage = multer.diskStorage({
  destination: 'uploads/',
  filename: (req, file, cb) => {
    const safeName = sanitizeFilename(file.originalname);
    cb(null, safeName);
  }
});
```

**3. File content security (malware scanning):**
```javascript
const scanForMalware = async (filePath) => {
  // Option 1: ClamAV (open source)
  try {
    const { default: clamscan } = await import('clamscan');
    const scanner = new clamscan();
    const { isInfected, viruses } = await scanner.scanFile(filePath);
    
    if (isInfected) {
      throw new Error(`Malware detected: ${viruses.join(', ')}`);
    }
  } catch (error) {
    console.warn('ClamAV scan failed or not available:', error.message);
  }
  
  // Option 2: Custom heuristic checks
  const buffer = fs.readFileSync(filePath);
  
  // Check for executable content in non-executable files
  const executablePatterns = [
    Buffer.from('MZ'), // Windows EXE
    Buffer.from('\x7FELF'), // Linux ELF
    Buffer.from('#!'), // Shell script
    Buffer.from('<script'), // HTML/JavaScript
    Buffer.from('<?php'), // PHP
  ];
  
  for (const pattern of executablePatterns) {
    if (buffer.includes(pattern)) {
      throw new Error('Suspicious executable content detected');
    }
  }
  
  // Check file size vs content length mismatch
  const stats = fs.statSync(filePath);
  if (stats.size !== buffer.length) {
    throw new Error('File size mismatch - possible corruption or tampering');
  }
  
  return { clean: true };
};
```

**4. Storage security (isolation and permissions):**
```javascript
const setupSecureStorage = () => {
  // 1. Use separate directory for uploads
  const uploadDir = path.join(__dirname, 'uploads');
  
  // 2. Ensure directory exists with secure permissions
  if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { 
      mode: 0o755, // rwxr-xr-x
      recursive: true 
    });
  }
  
  // 3. Set directory permissions (Unix only)
  fs.chmodSync(uploadDir, 0o755);
  
  // 4. Use subdirectories for different file types
  const subdirs = ['images', 'documents', 'temp'];
  subdirs.forEach(subdir => {
    const dir = path.join(uploadDir, subdir);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { mode: 0o755 });
    }
  });
  
  // 5. Configure web server to not execute files in upload directory
  // In nginx: location /uploads/ { add_header X-Content-Type-Options "nosniff"; }
  // In Express: app.use('/uploads', express.static('uploads', { index: false }));
  
  return uploadDir;
};
```

**5. User input validation and quota management:**
```javascript
class UploadSecurityManager {
  constructor() {
    this.userQuotas = new Map(); // In production, use Redis/database
    this.rateLimits = new Map();
  }
  
  checkUserQuota(userId, fileSize) {
    const quota = {
      dailyLimit: 100 * 1024 * 1024, // 100MB per day
      fileLimit: 10 * 1024 * 1024,   // 10MB per file
      countLimit: 50                 // 50 files per day
    };
    
    const userStats = this.userQuotas.get(userId) || {
      dailyBytes: 0,
      fileCount: 0,
      lastReset: Date.now()
    };
    
    // Reset daily counters
    const now = Date.now();
    const oneDay = 24 * 60 * 60 * 1000;
    if (now - userStats.lastReset > oneDay) {
      userStats.dailyBytes = 0;
      userStats.fileCount = 0;
      userStats.lastReset = now;
    }
    
    // Check limits
    const violations = [];
    
    if (fileSize > quota.fileLimit) {
      violations.push(`File size ${fileSize} exceeds per-file limit ${quota.fileLimit}`);
    }
    
    if (userStats.dailyBytes + fileSize > quota.dailyLimit) {
      violations.push(`Daily storage limit exceeded`);
    }
    
    if (userStats.fileCount >= quota.countLimit) {
      violations.push(`Daily file count limit exceeded`);
    }
    
    return {
      allowed: violations.length === 0,
      violations,
      remaining: {
        bytes: quota.dailyLimit - userStats.dailyBytes,
        files: quota.countLimit - userStats.fileCount
      }
    };
  }
  
  updateUserQuota(userId, fileSize) {
    const userStats = this.userQuotas.get(userId) || {
      dailyBytes: 0,
      fileCount: 0,
      lastReset: Date.now()
    };
    
    userStats.dailyBytes += fileSize;
    userStats.fileCount += 1;
    this.userQuotas.set(userId, userStats);
  }
  
  checkRateLimit(ip) {
    const limit = {
      window: 60 * 1000, // 1 minute
      maxRequests: 10
    };
    
    const now = Date.now();
    const userLimits = this.rateLimits.get(ip) || {
      count: 0,
      resetTime: now + limit.window
    };
    
    // Reset if window expired
    if (now > userLimits.resetTime) {
      userLimits.count = 1;
      userLimits.resetTime = now + limit.window;
    } else {
      userLimits.count++;
    }
    
    this.rateLimits.set(ip, userLimits);
    
    return {
      allowed: userLimits.count <= limit.maxRequests,
      remaining: Math.max(0, limit.maxRequests - userLimits.count),
      resetIn: userLimits.resetTime - now
    };
  }
}
```

**6. Secure file serving (prevent execution):**
```javascript
// Configure Express to serve files securely
app.use('/uploads', express.static('uploads', {
  index: false, // No directory listing
  setHeaders: (res, path) => {
    // Security headers
    res.set('X-Content-Type-Options', 'nosniff');
    res.set('X-Frame-Options', 'DENY');
    res.set('Content-Security-Policy', "default-src 'none'");
    
    // Set correct content type
    const ext = path.extname(path).toLowerCase();
    const mimeTypes = {
      '.jpg': 'image/jpeg',
      '.jpeg': 'image/jpeg',
      '.png': 'image/png',
      '.gif': 'image/gif',
      '.pdf': 'application/pdf',
      '.txt': 'text/plain'
    };
    
    if (mimeTypes[ext]) {
      res.set('Content-Type', mimeTypes[ext]);
    } else {
      // Unknown file type - serve as download
      res.set('Content-Type', 'application/octet-stream');
      res.set('Content-Disposition', 'attachment');
    }
  }
}));

// Alternative: Serve through CDN with security policies
// CloudFront/S3: Bucket policies, signed URLs, CORS restrictions
```

**7. Logging and monitoring for security incidents:**
```javascript
const securityLogger = winston.createLogger({
  level: 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  ),
  transports: [
    new winston.transports.File({ 
      filename: 'security.log',
      level: 'warn' // Log security events at warn level or higher
    })
  ]
});

// Log security events
const logSecurityEvent = (eventType, data) => {
  securityLogger.warn('security_event', {
    type: eventType,
    timestamp: new Date().toISOString(),
    ip: data.ip,
    userId: data.userId,
    userAgent: data.userAgent,
    details: data.details
  });
  
  // Alert on critical events
  if (eventType === 'malware_detected' || eventType === 'path_traversal') {
    sendSecurityAlert(eventType, data);
  }
};

// Usage in upload handler
app.post('/upload', upload.single('file'), async (req, res) => {
  const securityCheck = validateFileSecurity(req.file);
  
  if (!securityCheck.passed) {
    // Log security violation
    logSecurityEvent('file_validation_failed', {
      ip: req.ip,
      userId: req.user?.id,
      userAgent: req.get('User-Agent'),
      details: {
        filename: req.file.originalname,
        failedChecks: securityCheck.failedChecks
      }
    });
    
    return res.status(400).json({ 
      error: 'File validation failed',
      details: 'Invalid file detected' // Don't reveal too much info
    });
  }
  
  // Process file...
});
```

**Common file upload attacks and defenses:**

**1. Malware upload:**
- **Attack**: Upload virus, trojan, or ransomware
- **Defense**: Virus scanning, file type validation, isolated processing

**2. Path traversal:**
- **Attack**: ../../../etc/passwd in filename
- **Defense**: Filename sanitization, secure storage paths

**3. File overwrite:**
- **Attack**: Overwrite critical system files
- **Defense**: Unique filenames, separate upload directory

**4. DoS via large files:**
- **Attack**: Upload huge files to exhaust resources
- **Defense**: File size limits, rate limiting, streaming processing

**5. ZIP bombs:**
- **Attack**: Compressed files that expand enormously
- **Defense**: Limit extraction size, scan compressed files

**6. XML External Entity (XXE):**
- **Attack**: Malicious XML files that read system files
- **Defense**: Disable XXE parsing, validate XML schemas

**7. Server-Side Request Forgery (SSRF):**
- **Attack**: Files that trigger requests to internal services
- **Defense**: Isolate file processing, network restrictions

**Real-world security incidents:**

**Incident 1**: Social media platform allowed SVG uploads with JavaScript, leading to XSS attacks
**Solution**: Strict content-type validation, sanitize SVG files

**Incident 2**: File sharing service had path traversal in filename handling
**Solution**: Implemented filename sanitization, added security headers

**Incident 3**: CMS allowed PHP file upload, leading to server compromise
**Solution**: Added magic number validation, disabled execution in upload directory

**Best practices summary:**

1. **Validate everything**: Type, size, content, filename
2. **Use defense in depth**: Multiple validation layers
3. **Isolate uploads**: Separate directory, no execution
4. **Scan for malware**: Especially for user-generated content
5. **Implement quotas**: Prevent resource exhaustion
6. **Monitor and log**: Detect and respond to attacks
7. **Keep software updated**: Multer, scanning tools, dependencies
8. **Regular security testing**: Penetration testing, code review

**Remember:** No single security measure is sufficient. Implement a comprehensive security strategy that addresses all potential attack vectors for file uploads.

---
## 47. File Processing & Streaming

#### 1. How do you process uploaded files efficiently?

**Answer:**

**Efficient file processing** involves handling files without blocking the event loop, managing memory properly, and using appropriate techniques for different file types and sizes.

**Efficient processing strategies:**

**1. Stream-based processing (for large files):**
```javascript
const fs = require('fs');
const { pipeline } = require('stream');
const { promisify } = require('util');
const pipelineAsync = promisify(pipeline);

// Process file as stream (no full file in memory)
async function processLargeFile(inputPath, outputPath) {
  const readStream = fs.createReadStream(inputPath);
  const writeStream = fs.createWriteStream(outputPath);
  
  // Transform stream for processing
  const transformStream = new require('stream').Transform({
    transform(chunk, encoding, callback) {
      // Process chunk (e.g., convert to uppercase)
      const processed = chunk.toString().toUpperCase();
      this.push(processed);
      callback();
    }
  });
  
  // Use pipeline for proper error handling and cleanup
  await pipelineAsync(
    readStream,
    transformStream,
    writeStream
  );
  
  console.log('File processed successfully');
}

// Usage with Multer memory storage
const upload = multer({ storage: multer.memoryStorage() });

app.post('/process', upload.single('file'), async (req, res) => {
  // For small files, process in memory
  if (req.file.size < 10 * 1024 * 1024) { // < 10MB
    const result = await processInMemory(req.file.buffer);
    res.json({ result });
  } else {
    // For large files, stream to disk first
    const tempPath = `temp/${Date.now()}-${req.file.originalname}`;
    fs.writeFileSync(tempPath, req.file.buffer);
    
    // Process using streams
    const outputPath = `processed/${req.file.originalname}`;
    await processLargeFile(tempPath, outputPath);
    
    // Clean up temp file
    fs.unlinkSync(tempPath);
    
    res.json({ 
      message: 'File processed via streaming',
      output: outputPath 
    });
  }
});
```

**2. Worker threads for CPU-intensive processing:**
```javascript
const { Worker } = require('worker_threads');

function processWithWorker(fileBuffer) {
  return new Promise((resolve, reject) => {
    const worker = new Worker(`
      const { parentPort } = require('worker_threads');
      const sharp = require('sharp');
      
      parentPort.on('message', async (buffer) => {
        try {
          // CPU-intensive image processing
          const processed = await sharp(buffer)
            .resize(800, 600)
            .jpeg({ quality: 80 })
            .toBuffer();
          
          parentPort.postMessage({ success: true, buffer: processed });
        } catch (error) {
          parentPort.postMessage({ success: false, error: error.message });
        }
      });
    `, { eval: true });
    
    worker.on('message', (message) => {
      if (message.success) {
        resolve(message.buffer);
      } else {
        reject(new Error(message.error));
      }
      worker.terminate();
    });
    
    worker.on('error', reject);
    worker.on('exit', (code) => {
      if (code !== 0) {
        reject(new Error(`Worker stopped with exit code ${code}`));
      }
    });
    
    worker.postMessage(fileBuffer);
  });
}

// Usage
app.post('/process-image', upload.single('image'), async (req, res) => {
  try {
    const processedBuffer = await processWithWorker(req.file.buffer);
    
    // Save or send processed image
    res.set('Content-Type', 'image/jpeg');
    res.send(processedBuffer);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

**3. Batch processing with queue:**
```javascript
const Queue = require('bull');
const fileQueue = new Queue('file processing', {
  redis: { port: 6379, host: '127.0.0.1' }
});

// Worker process (can be separate from web server)
fileQueue.process('image', 5, async (job) => { // 5 concurrent jobs
  const { fileBuffer, operations } = job.data;
  
  // Process image with sharp
  let image = sharp(fileBuffer);
  
  for (const op of operations) {
    switch (op.type) {
      case 'resize':
        image = image.resize(op.width, op.height);
        break;
      case 'crop':
        image = image.extract(op);
        break;
      case 'format':
        image = image.toFormat(op.format, op.options);
        break;
    }
  }
  
  return await image.toBuffer();
});

fileQueue.process('document', 3, async (job) => {
  const { fileBuffer } = job.data;
  
  // Process document (e.g., extract text, convert format)
  const text = await extractTextFromPDF(fileBuffer);
  return { text, wordCount: text.split(/\s+/).length };
});

// Web server route
app.post('/process-batch', upload.array('files', 20), async (req, res) => {
  const jobs = [];
  
  for (const file of req.files) {
    const job = await fileQueue.add(
      file.mimetype.startsWith('image/') ? 'image' : 'document',
      {
        fileBuffer: file.buffer,
        operations: [
          { type: 'resize', width: 800, height: 600 },
          { type: 'format', format: 'jpeg', options: { quality: 80 } }
        ]
      },
      {
        attempts: 3,
        backoff: { type: 'exponential', delay: 1000 }
      }
    );
    
    jobs.push(job.id);
  }
  
  res.json({
    message: 'Files queued for processing',
    jobIds: jobs,
    fileCount: req.files.length
  });
});
```

**4. Parallel processing with controlled concurrency:**
```javascript
class FileProcessor {
  constructor(maxConcurrent = 3) {
    this.maxConcurrent = maxConcurrent;
    this.active = 0;
    this.queue = [];
  }
  
  async processFile(file, processorFn) {
    return new Promise((resolve, reject) => {
      this.queue.push({ file, processorFn, resolve, reject });
      this._processQueue();
    });
  }
  
  _processQueue() {
    while (this.active < this.maxConcurrent && this.queue.length > 0) {
      this.active++;
      const { file, processorFn, resolve, reject } = this.queue.shift();
      
      processorFn(file)
        .then(resolve)
        .catch(reject)
        .finally(() => {
          this.active--;
          this._processQueue();
        });
    }
  }
}

// Usage
const processor = new FileProcessor(3); // Max 3 concurrent

app.post('/process-parallel', upload.array('files', 10), async (req, res) => {
  const results = [];
  const errors = [];
  
  const processPromises = req.files.map(file => 
    processor.processFile(file, async (f) => {
      // Simulate processing
      await new Promise(resolve => setTimeout(resolve, 1000));
      return { 
        name: f.originalname, 
        processed: true,
        size: f.size 
      };
    })
  );
  
  const settled = await Promise.allSettled(processPromises);
  
  settled.forEach((result, index) => {
    if (result.status === 'fulfilled') {
      results.push(result.value);
    } else {
      errors.push({
        file: req.files[index].originalname,
        error: result.reason.message
      });
    }
  });
  
  res.json({
    processed: results.length,
    failed: errors.length,
    results,
    errors
  });
});
```

**5. Efficient text file processing:**
```javascript
const readline = require('readline');
const fs = require('fs');

async function processLargeTextFile(filePath) {
  const fileStream = fs.createReadStream(filePath, { encoding: 'utf8' });
  const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity
  });
  
  let lineCount = 0;
  let wordCount = 0;
  const wordFrequency = new Map();
  
  // Process line by line (memory efficient)
  for await (const line of rl) {
    lineCount++;
    const words = line.toLowerCase().match(/\b\w+\b/g) || [];
    wordCount += words.length;
    
    for (const word of words) {
      wordFrequency.set(word, (wordFrequency.get(word) || 0) + 1);
    }
    
    // Process in chunks to avoid blocking
    if (lineCount % 10000 === 0) {
      await new Promise(resolve => setImmediate(resolve));
    }
  }
  
  // Get top 10 words
  const topWords = [...wordFrequency.entries()]
    .sort((a, b) => b[1] - a[1])
    .slice(0, 10)
    .map(([word, count]) => ({ word, count }));
  
  return {
    lineCount,
    wordCount,
    topWords,
    uniqueWords: wordFrequency.size
  };
}

// Usage with uploaded file
app.post('/analyze-text', upload.single('textfile'), async (req, res) => {
  // Save uploaded file temporarily
  const tempPath = `temp/${Date.now()}-${req.file.originalname}`;
  fs.writeFileSync(tempPath, req.file.buffer);
  
  try {
    const analysis = await processLargeTextFile(tempPath);
    res.json(analysis);
  } catch (error) {
    res.status(500).json({ error: error.message });
  } finally {
    // Clean up
    fs.unlinkSync(tempPath);
  }
});
```

**6. Image processing optimization:**
```javascript
const sharp = require('sharp');
const crypto = require('crypto');

async function optimizeImage(inputBuffer, options = {}) {
  const {
    maxWidth = 1200,
    maxHeight = 1200,
    quality = 80,
    format = 'jpeg'
  } = options;
  
  const image = sharp(inputBuffer);
  const metadata = await image.metadata();
  
  // Calculate optimal dimensions
  let width = metadata.width;
  let height = metadata.height;
  
  if (width > maxWidth || height > maxHeight) {
    const ratio = Math.min(maxWidth / width, maxHeight / height);
    width = Math.round(width * ratio);
    height = Math.round(height * ratio);
  }
  
  // Generate cache key
  const cacheKey = crypto
    .createHash('md5')
    .update(inputBuffer)
    .update(`${width}x${height}-${quality}-${format}`)
    .digest('hex');
  
  // Check cache first
  const cachePath = `cache/${cacheKey}.${format}`;
  if (fs.existsSync(cachePath)) {
    return fs.readFileSync(cachePath);
  }
  
  // Process image
  const processed = await image
    .resize(width, height, {
      fit: 'inside',
      withoutEnlargement: true
    })
    .toFormat(format, { quality })
    .toBuffer();
  
  // Cache for future requests
  fs.writeFileSync(cachePath, processed);
  
  return processed;
}

// Usage
app.get('/image/:id', async (req, res) => {
  const { width, height, quality } = req.query;
  
  // Get original image from database or storage
  const originalBuffer = await getImageFromStorage(req.params.id);
  
  const optimized = await optimizeImage(originalBuffer, {
    maxWidth: parseInt(width) || 1200,
    maxHeight: parseInt(height) || 1200,
    quality: parseInt(quality) || 80
  });
  
  res.set('Content-Type', 'image/jpeg');
  res.set('Cache-Control', 'public, max-age=31536000'); // 1 year
  res.send(optimized);
});
```

**Best practices for efficient file processing:**

1. **Choose the right approach**: Streams for large files, memory for small files
2. **Use worker threads**: For CPU-intensive operations
3. **Implement caching**: Avoid reprocessing same files
4. **Set limits**: File size, processing time, memory usage
5. **Monitor resources**: CPU, memory, disk I/O
6. **Clean up temp files**: Prevent disk space exhaustion
7. **Use appropriate libraries**: sharp for images, pdf-parse for PDFs
8. **Implement progress tracking**: User feedback for long operations

**Performance optimization techniques:**

**Memory optimization:**
- Use streams instead of loading entire files
- Process in chunks with backpressure control
- Free memory promptly after processing
- Use buffer pooling for frequent operations

**CPU optimization:**
- Offload to worker threads
- Use native modules (sharp uses libvips)
- Implement batch processing
- Use appropriate algorithms for file type

**I/O optimization:**
- Use async file operations
- Implement read/write buffering
- Use SSD storage for temp files
- Consider memory-mapped files for very large files

**Real-world efficient processing scenarios:**

**E-commerce image processing:**
- **Challenge**: Process thousands of product images
- **Solution**: Queue-based batch processing with sharp
- **Optimization**: CDN caching, progressive JPEGs, WebP format

**Log file analysis:**
- **Challenge**: Analyze multi-GB log files
- **Solution**: Stream processing with readline
- **Optimization**: Parallel processing, incremental analysis

**Video thumbnail generation:**
- **Challenge**: Generate thumbnails from video uploads
- **Solution**: FFmpeg with worker threads
- **Optimization**: Preview generation during upload

**Document conversion service:**
- **Challenge**: Convert various document formats
- **Solution**: Dockerized converters with job queue
- **Optimization**: Format detection, fallback converters

**Remember:** The most efficient processing method depends on your specific use case. Profile your application to identify bottlenecks and choose the right optimization strategy.

---

#### 2. How do you handle large file uploads without memory issues?

**Answer:**

**Large file uploads** require special handling to prevent memory exhaustion, timeouts, and server crashes. The key is to avoid loading entire files into memory and use streaming techniques.

**Strategies for large file uploads:**

**1. Stream directly to disk (Multer disk storage):**
```javascript
const multer = require('multer');
const path = require('path');
const fs = require('fs');

// Configure storage for large files
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const uploadDir = 'uploads/large-files/';
    
    // Ensure directory exists
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
    }
    
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    // Generate unique filename
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    const ext = path.extname(file.originalname);
    cb(null, file.fieldname + '-' + uniqueSuffix + ext);
  }
});

// Configure Multer for large files
const upload = multer({
  storage: storage,
  limits: {
    fileSize: 10 * 1024 * 1024 * 1024, // 10GB limit
    files: 1 // Single file upload for large files
  },
  fileFilter: (req, file, cb) => {
    // Validate file type for large files
    const allowedTypes = [
      'video/mp4',
      'video/avi',
      'application/zip',
      'application/x-rar-compressed'
    ];
    
    if (allowedTypes.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error('File type not allowed for large uploads'), false);
    }
  }
});

// Handle upload
app.post('/upload-large', upload.single('largefile'), (req, res) => {
  res.json({
    message: 'Large file uploaded successfully',
    filename: req.file.filename,
    size: req.file.size,
    path: req.file.path
  });
});
```

**2. Chunked uploads with resumable capability:**
```javascript
// Client splits file into chunks, server reassembles
const chunkStorage = multer.diskStorage({
  destination: 'chunks/',
  filename: (req, file, cb) => {
    const { fileId, chunkIndex, totalChunks } = req.body;
    cb(null, `${fileId}-${chunkIndex}`);
  }
});

const chunkUpload = multer({ storage: chunkStorage });

// Upload chunk endpoint
app.post('/upload-chunk', chunkUpload.single('chunk'), (req, res) => {
  const { fileId, chunkIndex, totalChunks, fileName, fileSize } = req.body;
  
  // Store chunk metadata
  saveChunkMetadata({
    fileId,
    chunkIndex: parseInt(chunkIndex),
    totalChunks: parseInt(totalChunks),
    fileName,
    fileSize: parseInt(fileSize),
    chunkPath: req.file.path,
    uploadedAt: new Date()
  });
  
  // Check if all chunks received
  checkAndAssembleFile(fileId).then(assembled => {
    if (assembled) {
      res.json({ 
        chunkIndex,
        complete: true,
        assembledPath: assembled.path 
      });
    } else {
      res.json({ 
        chunkIndex,
        complete: false,
        nextChunk: parseInt(chunkIndex) + 1 
      });
    }
  });
});

// File assembly function
async function assembleFile(fileId) {
  const chunks = await getChunks(fileId);
  
  if (chunks.length !== chunks[0].totalChunks) {
    return null; // Not all chunks received
  }
  
  // Sort chunks by index
  chunks.sort((a, b) => a.chunkIndex - b.chunkIndex);
  
  // Create output file
  const outputPath = `uploads/${chunks[0].fileName}`;
  const writeStream = fs.createWriteStream(outputPath);
  
  // Write chunks sequentially
  for (const chunk of chunks) {
    const chunkBuffer = fs.readFileSync(chunk.chunkPath);
    writeStream.write(chunkBuffer);
    
    // Clean up chunk file
    fs.unlinkSync(chunk.chunkPath);
  }
  
  writeStream.end();
  
  // Clean up metadata
  await deleteChunksMetadata(fileId);
  
  return {
    path: outputPath,
    size: chunks.reduce((sum, chunk) => sum + chunk.fileSize, 0)
  };
}
```

**3. Direct-to-cloud storage (S3, GCS, Azure):**
```javascript
const { S3Client, CreateMultipartUploadCommand, UploadPartCommand, CompleteMultipartUploadCommand } = require('@aws-sdk/client-s3');
const s3Client = new S3Client({ region: 'us-east-1' });

// Generate pre-signed URL for direct upload
app.post('/init-upload', async (req, res) => {
  const { fileName, fileSize, fileType } = req.body;
  const fileId = crypto.randomUUID();
  
  // Create multipart upload
  const createCommand = new CreateMultipartUploadCommand({
    Bucket: 'my-bucket',
    Key: `uploads/${fileId}/${fileName}`,
    ContentType: fileType
  });
  
  const { UploadId } = await s3Client.send(createCommand);
  
  // Calculate part size (5MB minimum for S3)
  const partSize = 5 * 1024 * 1024; // 5MB
  const partCount = Math.ceil(fileSize / partSize);
  
  // Generate pre-signed URLs for each part
  const parts = [];
  for (let i = 1; i <= partCount; i++) {
    const partUrl = await generatePresignedUrl(fileId, UploadId, i);
    parts.push({
      partNumber: i,
      url: partUrl
    });
  }
  
  res.json({
    fileId,
    uploadId: UploadId,
    parts,
    partSize
  });
});

// Client uploads directly to S3 using pre-signed URLs
// Server only handles completion
app.post('/complete-upload', async (req, res) => {
  const { fileId, uploadId, parts } = req.body;
  
  const completeCommand = new CompleteMultipartUploadCommand({
    Bucket: 'my-bucket',
    Key: `uploads/${fileId}/${req.body.fileName}`,
    UploadId: uploadId,
    MultipartUpload: {
      Parts: parts.map(p => ({
        ETag: p.etag,
        PartNumber: p.partNumber
      }))
    }
  });
  
  await s3Client.send(completeCommand);
  
  res.json({ 
    message: 'Upload completed',
    url: `https://my-bucket.s3.amazonaws.com/uploads/${fileId}/${req.body.fileName}`
  });
});
```

**4. Streaming with backpressure control:**
```javascript
const { PassThrough } = require('stream');

class ControlledUploadStream {
  constructor(maxMemory = 100 * 1024 * 1024) { // 100MB max memory
    this.maxMemory = maxMemory;
    this.bufferedSize = 0;
    this.buffers = [];
    this.destination = null;
    this.isPaused = false;
  }
  
  write(chunk) {
    this.bufferedSize += chunk.length;
    this.buffers.push(chunk);
    
    // Pause if buffer too large
    if (this.bufferedSize > this.maxMemory && !this.isPaused) {
      this.isPaused = true;
      return false; // Signal backpressure
    }
    
    return true;
  }
  
  async flushToDisk(filePath) {
    const writeStream = fs.createWriteStream(filePath);
    
    for (const buffer of this.buffers) {
      const canWrite = writeStream.write(buffer);
      
      if (!canWrite) {
        await new Promise(resolve => writeStream.once('drain', resolve));
      }
    }
    
    writeStream.end();
    await new Promise(resolve => writeStream.on('finish', resolve));
    
    // Clear buffers
    this.buffers = [];
    this.bufferedSize = 0;
    this.isPaused = false;
  }
}

// Usage with custom Multer storage
class MemoryControlledStorage {
  constructor() {
    this.streams = new Map();
  }
  
  _handleFile(req, file, cb) {
    const fileId = crypto.randomUUID();
    const controlledStream = new ControlledUploadStream();
    this.streams.set(fileId, controlledStream);
    
    file.stream.on('data', (chunk) => {
      const canContinue = controlledStream.write(chunk);
      
      if (!canContinue) {
        // Pause source stream
        file.stream.pause();
        
        // Flush to disk and resume
        controlledStream.flushToDisk(`temp/${fileId}.part`)
          .then(() => {
            file.stream.resume();
          })
          .catch(err => cb(err));
      }
    });
    
    file.stream.on('end', async () => {
      try {
        // Final flush
        await controlledStream.flushToDisk(`temp/${fileId}.part`);
        
        // Combine parts if needed
        const finalPath = await this.combineParts(fileId, file.originalname);
        
        cb(null, {
          path: finalPath,
          size: fs.statSync(finalPath).size
        });
      } catch (err) {
        cb(err);
      } finally {
        this.streams.delete(fileId);
      }
    });
    
    file.stream.on('error', cb);
  }
  
  async combineParts(fileId, originalName) {
    // Implementation for combining multiple part files
    const finalPath = `uploads/${originalName}`;
    // ... combine logic
    return finalPath;
  }
  
  _removeFile(req, file, cb) {
    fs.unlink(file.path, cb);
  }
}
```

**5. Progress tracking with socket.io:**
```javascript
const socketIo = require('socket.io');

// Initialize socket.io
const io = socketIo(server);

// Track upload progress
const uploadProgress = new Map();

io.on('connection', (socket) => {
  socket.on('start-upload', (data) => {
    const { fileId, fileSize, fileName } = data;
    
    uploadProgress.set(fileId, {
      fileSize,
      uploaded: 0,
      fileName,
      socketId: socket.id,
      startTime: Date.now()
    });
  });
  
  socket.on('upload-progress', (data) => {
    const { fileId, chunkSize } = data;
    const progress = uploadProgress.get(fileId);
    
    if (progress) {
      progress.uploaded += chunkSize;
      const percent = (progress.uploaded / progress.fileSize * 100).toFixed(1);
      
      // Calculate speed
      const elapsed = (Date.now() - progress.startTime) / 1000; // seconds
      const speed = progress.uploaded / elapsed; // bytes per second
      
      // Emit progress to client
      socket.emit('upload-update', {
        fileId,
        percent,
        uploaded: progress.uploaded,
        total: progress.fileSize,
        speed: Math.round(speed / 1024) // KB/s
      });
    }
  });
  
  socket.on('upload-complete', (fileId) => {
    uploadProgress.delete(fileId);
  });
  
  socket.on('disconnect', () => {
    // Clean up progress tracking for this socket
    for (const [fileId, progress] of uploadProgress.entries()) {
      if (progress.socketId === socket.id) {
        uploadProgress.delete(fileId);
      }
    }
  });
});

// Multer with progress tracking
const upload = multer({ 
  storage: multer.memoryStorage(),
  limits: { fileSize: 2 * 1024 * 1024 * 1024 } // 2GB
});

app.post('/upload-with-progress', upload.single('file'), (req, res) => {
  // File is in memory (for demo - use disk storage for production)
  const fileId = req.headers['x-file-id'];
  
  // Process file...
  res.json({ 
    message: 'Upload complete',
    fileId,
    size: req.file.size 
  });
});
```

**6. Memory management techniques:**
```javascript
class UploadMemoryManager {
  constructor(maxMemoryUsage = 0.8) { // 80% of system memory
    this.maxMemoryUsage = maxMemoryUsage;
    this.activeUploads = new Map();
  }
  
  canAcceptUpload(fileSize) {
    const totalMemory = os.totalmem();
    const freeMemory = os.freemem();
    const usedMemory = totalMemory - freeMemory;
    
    const currentUsage = usedMemory / totalMemory;
    const projectedUsage = (usedMemory + fileSize) / totalMemory;
    
    return projectedUsage < this.maxMemoryUsage;
  }
  
  registerUpload(fileId, fileSize) {
    if (!this.canAcceptUpload(fileSize)) {
      throw new Error('Insufficient memory for upload');
    }
    
    this.activeUploads.set(fileId, {
      size: fileSize,
      startTime: Date.now(),
      bytesReceived: 0
    });
  }
  
  updateProgress(fileId, chunkSize) {
    const upload = this.activeUploads.get(fileId);
    if (upload) {
      upload.bytesReceived += chunkSize;
    }
  }
  
  completeUpload(fileId) {
    this.activeUploads.delete(fileId);
  }
  
  getMemoryStatus() {
    const total = os.totalmem();
    const free = os.freemem();
    const used = total - free;
    
    return {
      total: Math.round(total / 1024 / 1024), // MB
      used: Math.round(used / 1024 / 1024),
      free: Math.round(free / 1024 / 1024),
      usagePercent: (used / total * 100).toFixed(1),
      activeUploads: this.activeUploads.size
    };
  }
}

// Usage
const memoryManager = new UploadMemoryManager();

app.post('/upload', upload.single('file'), (req, res, next) => {
  const fileSize = parseInt(req.headers['content-length']);
  const fileId = req.headers['x-file-id'];
  
  try {
    memoryManager.registerUpload(fileId, fileSize);
    
    // Track progress
    let received = 0;
    req.on('data', (chunk) => {
      received += chunk.length;
      memoryManager.updateProgress(fileId, chunk.length);
    });
    
    req.on('end', () => {
      memoryManager.completeUpload(fileId);
    });
    
    next();
  } catch (error) {
    res.status(503).json({ 
      error: 'Service temporarily unavailable',
      details: error.message,
      memoryStatus: memoryManager.getMemoryStatus()
    });
  }
});
```

**Best practices for large file uploads:**

1. **Use disk storage**: Avoid memory storage for large files
2. **Implement chunking**: For files > 100MB
3. **Add resumable capability**: Handle network failures
4. **Set appropriate timeouts**: Longer for large files
5. **Monitor resources**: Memory, disk space, CPU
6. **Clean up temp files**: Automatic cleanup
7. **Validate early**: Check file type and size before accepting
8. **Use CDN/cloud storage**: Offload from application server

**Common issues and solutions:**

**Memory exhaustion:**
- **Symptom**: Node.js process crashes with OOM error
- **Solution**: Use disk storage, implement chunking, monitor memory

**Timeout errors:**
- **Symptom**: Upload fails after 2 minutes (default timeout)
- **Solution**: Increase timeout, implement resumable uploads

**Disk space exhaustion:**
- **Symptom**: Cannot write temp files
- **Solution**: Monitor disk usage, implement cleanup, use cloud storage

**Network instability:**
- **Symptom**: Upload fails mid-way
- **Solution**: Chunked uploads with resume capability

**Browser limitations:**
- **Symptom**: Upload fails for files > 2GB
- **Solution**: Chunked uploads, Flash/Java fallback (legacy)

**Real-world large file upload scenarios:**

**Video sharing platform:**
- **Files**: 4K videos up to 10GB
- **Solution**: Chunked upload to S3 with progress tracking
- **Optimization**: Parallel chunk upload, checksum verification

**Backup service:**
- **Files**: Database dumps, system images up to 100GB
- **Solution**: Dedicated upload servers, compression during upload
- **Optimization**: Differential uploads, bandwidth throttling

**Scientific data upload:**
- **Files**: Research datasets up to 1TB
- **Solution**: Aspera/GridFTP for high-speed transfer
- **Optimization**: Checksum validation, metadata extraction

**Remember:** The approach depends on your infrastructure and requirements. For most applications, chunked uploads to cloud storage provide the best balance of reliability, scalability, and cost-effectiveness.

---
#### 2. What is the difference between streaming and buffering?

**Answer:**

**Streaming vs Buffering** are two fundamentally different approaches to handling data, each with distinct advantages and use cases.

**Buffering (load entire file into memory):**
```javascript
// Read entire file into memory
const fs = require('fs');

fs.readFile('large-file.txt', (err, data) => {
  if (err) throw err;
  
  // Entire file is now in memory as Buffer
  console.log(data.length); // Total bytes
  
  // Process data
  const lines = data.toString().split('\n');
  lines.forEach(line => console.log(line));
});

// Memory usage: O(file size)
// Time to first byte: Entire file read time
// Good for: Small files, when you need random access
```

**Streaming (process data in chunks):**
```javascript
// Read file in chunks
const readStream = fs.createReadStream('large-file.txt', {
  highWaterMark: 64 * 1024 // 64KB chunks
});

readStream.on('data', (chunk) => {
  // Process each chunk as it arrives
  console.log(`Received chunk of ${chunk.length} bytes`);
});

readStream.on('end', () => {
  console.log('File reading complete');
});

// Memory usage: O(chunk size) - constant
// Time to first byte: Immediate
// Good for: Large files, real-time processing
```

**Comparison table:**

| Aspect | Buffering | Streaming |
|--------|-----------|-----------|
| **Memory usage** | O(file size) | O(chunk size) |
| **Time to first byte** | Slow (entire file) | Fast (first chunk) |
| **Random access** | Yes | No (sequential only) |
| **Large files** | Problematic | Ideal |
| **Real-time processing** | No | Yes |
| **Backpressure handling** | Manual | Automatic |
| **Use case** | Small files, JSON | Large files, video, logs |

**Real-world example:**

**Buffering (bad for large files):**
```javascript
// Reading 1GB file into memory - will crash!
const data = fs.readFileSync('1gb-file.bin');
// Error: Cannot allocate memory
```

**Streaming (good for large files):**
```javascript
// Reading 1GB file in 64KB chunks - works fine
const stream = fs.createReadStream('1gb-file.bin', {
  highWaterMark: 64 * 1024
});

let totalBytes = 0;
stream.on('data', (chunk) => {
  totalBytes += chunk.length;
  console.log(`Processed ${totalBytes} bytes`);
});
```

**Backpressure handling:**

**Without backpressure (buffering problem):**
```javascript
// Reading faster than writing - memory builds up
const readStream = fs.createReadStream('large-file.txt');
const writeStream = fs.createWriteStream('output.txt');

readStream.on('data', (chunk) => {
  // If write is slow, chunks accumulate in memory
  writeStream.write(chunk);
});
```

**With backpressure (streaming solution):**
```javascript
// Proper backpressure handling
const readStream = fs.createReadStream('large-file.txt');
const writeStream = fs.createWriteStream('output.txt');

readStream.on('data', (chunk) => {
  const canContinue = writeStream.write(chunk);
  
  if (!canContinue) {
    // Pause reading until write catches up
    readStream.pause();
  }
});

writeStream.on('drain', () => {
  // Resume reading when write buffer is empty
  readStream.resume();
});

// Or use pipeline (handles backpressure automatically)
const { pipeline } = require('stream');
pipeline(readStream, writeStream, (err) => {
  if (err) console.error('Pipeline failed:', err);
  else console.log('Pipeline succeeded');
});
```

**Performance comparison:**

**Buffering 100MB file:**
- Memory peak: ~100MB
- Time to start processing: 2-3 seconds
- Total time: 3-4 seconds

**Streaming 100MB file:**
- Memory peak: ~64KB (chunk size)
- Time to start processing: Immediate
- Total time: 2-3 seconds

**Best practices:**

1. **Use streaming for large files**: > 10MB
2. **Use buffering for small files**: < 1MB
3. **Always handle backpressure**: In streaming
4. **Use pipeline()**: For automatic backpressure handling
5. **Monitor memory**: Ensure streaming doesn't accumulate

**Remember:** Streaming is more efficient for large files and real-time processing, while buffering is simpler for small files where you need random access.

---

#### 3. How do you handle file compression and decompression?

**Answer:**

**File compression** reduces file size for storage and transfer, while **decompression** restores the original data. Node.js provides built-in support for common compression formats.

**Compression formats:**

**1. Gzip compression (most common):**
```javascript
const fs = require('fs');
const zlib = require('zlib');
const { pipeline } = require('stream');

// Compress file
function compressFile(inputPath, outputPath) {
  const readStream = fs.createReadStream(inputPath);
  const writeStream = fs.createWriteStream(outputPath);
  const gzip = zlib.createGzip();
  
  pipeline(readStream, gzip, writeStream, (err) => {
    if (err) console.error('Compression failed:', err);
    else console.log('File compressed successfully');
  });
}

// Decompress file
function decompressFile(inputPath, outputPath) {
  const readStream = fs.createReadStream(inputPath);
  const writeStream = fs.createWriteStream(outputPath);
  const gunzip = zlib.createGunzip();
  
  pipeline(readStream, gunzip, writeStream, (err) => {
    if (err) console.error('Decompression failed:', err);
    else console.log('File decompressed successfully');
  });
}

// Usage
compressFile('large-file.txt', 'large-file.txt.gz');
decompressFile('large-file.txt.gz', 'large-file-restored.txt');
```

**2. Brotli compression (better compression ratio):**
```javascript
const zlib = require('zlib');

// Compress with Brotli
function compressWithBrotli(inputPath, outputPath) {
  const readStream = fs.createReadStream(inputPath);
  const writeStream = fs.createWriteStream(outputPath);
  const brotli = zlib.createBrotliCompress({
    params: {
      [zlib.constants.BROTLI_PARAM_QUALITY]: 11 // Max compression
    }
  });
  
  pipeline(readStream, brotli, writeStream, (err) => {
    if (err) console.error('Brotli compression failed:', err);
    else console.log('File compressed with Brotli');
  });
}

// Decompress Brotli
function decompressWithBrotli(inputPath, outputPath) {
  const readStream = fs.createReadStream(inputPath);
  const writeStream = fs.createWriteStream(outputPath);
  const brotli = zlib.createBrotliDecompress();
  
  pipeline(readStream, brotli, writeStream, (err) => {
    if (err) console.error('Brotli decompression failed:', err);
    else console.log('File decompressed with Brotli');
  });
}
```

**3. ZIP archive handling:**
```javascript
const archiver = require('archiver');
const extract = require('extract-zip');

// Create ZIP archive
async function createZipArchive(sourceDir, outputPath) {
  return new Promise((resolve, reject) => {
    const output = fs.createWriteStream(outputPath);
    const archive = archiver('zip', { zlib: { level: 9 } });
    
    output.on('close', () => {
      console.log(`Archive created: ${archive.pointer()} bytes`);
      resolve();
    });
    
    archive.on('error', reject);
    archive.pipe(output);
    
    // Add directory to archive
    archive.directory(sourceDir, false);
    archive.finalize();
  });
}

// Extract ZIP archive
async function extractZipArchive(zipPath, outputDir) {
  try {
    await extract(zipPath, { dir: outputDir });
    console.log('Archive extracted successfully');
  } catch (error) {
    console.error('Extraction failed:', error);
  }
}

// Usage
await createZipArchive('./uploads', './archive.zip');
await extractZipArchive('./archive.zip', './extracted');
```

**4. Compression in HTTP responses:**
```javascript
const compression = require('compression');

// Automatic compression middleware
app.use(compression({
  level: 6, // Compression level (0-9)
  threshold: 1024, // Only compress > 1KB
  filter: (req, res) => {
    // Don't compress certain types
    if (req.headers['x-no-compression']) {
      return false;
    }
    return compression.filter(req, res);
  }
}));

// Manual compression for specific routes
app.get('/download-large-file', (req, res) => {
  const filePath = 'large-file.txt';
  const gzip = zlib.createGzip();
  
  res.set('Content-Encoding', 'gzip');
  res.set('Content-Type', 'text/plain');
  
  fs.createReadStream(filePath)
    .pipe(gzip)
    .pipe(res);
});
```

**Real-world compression scenarios:**

**Log file compression:**
- Compress old logs to save space
- Keep recent logs uncompressed for quick access
- Archive compressed logs to cloud storage

**Backup compression:**
- Compress database backups before storage
- Reduce backup storage costs
- Faster transfer to cloud

**API response compression:**
- Compress JSON responses
- Reduce bandwidth usage
- Faster client-side loading

**Best practices:**

1. **Choose right compression**: Gzip for speed, Brotli for ratio
2. **Set appropriate levels**: Balance compression vs CPU
3. **Use streaming**: For large files
4. **Monitor performance**: Compression adds CPU overhead
5. **Test compression**: Ensure it helps (some files don't compress well)

**Remember:** Compression trades CPU for bandwidth. Use it when bandwidth is the bottleneck, not when CPU is already maxed out.

---
## 48. Cloud Storage Integration

#### 1. How do you integrate cloud storage (AWS S3, Google Cloud Storage)?

**Answer:**

**Cloud storage integration** allows you to store files outside your server, providing scalability, reliability, and cost-effectiveness. AWS S3 and Google Cloud Storage are the most popular options.

**AWS S3 integration:**

**1. Basic S3 setup:**
```javascript
const AWS = require('aws-sdk');
const multer = require('multer');
const multerS3 = require('multer-s3');

// Configure AWS SDK
const s3 = new AWS.S3({
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  region: process.env.AWS_REGION
});

// Configure Multer for S3
const upload = multerS3({
  s3: s3,
  bucket: 'my-bucket',
  acl: 'public-read', // or 'private'
  metadata: (req, file, cb) => {
    cb(null, {
      fieldName: file.fieldname,
      uploadedBy: req.user?.id,
      uploadedAt: new Date().toISOString()
    });
  },
  key: (req, file, cb) => {
    // Generate unique key
    const key = `uploads/${Date.now()}-${file.originalname}`;
    cb(null, key);
  }
});

// Use in route
app.post('/upload', upload.single('file'), (req, res) => {
  res.json({
    message: 'File uploaded to S3',
    location: req.file.location,
    key: req.file.key
  });
});
```

**2. Direct file upload to S3:**
```javascript
async function uploadFileToS3(filePath, bucketKey) {
  const fileContent = fs.readFileSync(filePath);
  
  const params = {
    Bucket: 'my-bucket',
    Key: bucketKey,
    Body: fileContent,
    ContentType: 'application/octet-stream',
    Metadata: {
      'uploaded-by': 'nodejs-app',
      'upload-date': new Date().toISOString()
    }
  };
  
  try {
    const result = await s3.upload(params).promise();
    console.log('File uploaded:', result.Location);
    return result;
  } catch (error) {
    console.error('Upload failed:', error);
    throw error;
  }
}

// Usage
app.post('/upload-direct', upload.single('file'), async (req, res) => {
  try {
    const result = await uploadFileToS3(
      req.file.path,
      `uploads/${req.file.filename}`
    );
    
    res.json({ 
      message: 'File uploaded successfully',
      url: result.Location 
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

**3. Streaming upload to S3:**
```javascript
async function streamUploadToS3(readStream, bucketKey) {
  const params = {
    Bucket: 'my-bucket',
    Key: bucketKey,
    Body: readStream,
    ContentType: 'application/octet-stream'
  };
  
  return s3.upload(params).promise();
}

// Usage with large files
app.post('/upload-stream', upload.single('file'), async (req, res) => {
  try {
    const readStream = fs.createReadStream(req.file.path);
    const result = await streamUploadToS3(
      readStream,
      `uploads/${req.file.filename}`
    );
    
    // Clean up local file
    fs.unlinkSync(req.file.path);
    
    res.json({ 
      message: 'Large file uploaded via streaming',
      url: result.Location 
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

**Google Cloud Storage integration:**

**1. Basic GCS setup:**
```javascript
const { Storage } = require('@google-cloud/storage');
const multer = require('multer');

// Initialize GCS
const storage = new Storage({
  projectId: process.env.GCP_PROJECT_ID,
  keyFilename: process.env.GCP_KEY_FILE
});

const bucket = storage.bucket('my-bucket');

// Configure Multer for GCS
const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 10 * 1024 * 1024 } // 10MB
});

// Upload middleware
const uploadToGCS = (req, res, next) => {
  if (!req.file) return next();
  
  const file = bucket.file(req.file.originalname);
  
  const stream = file.createWriteStream({
    metadata: {
      contentType: req.file.mimetype,
      metadata: {
        uploadedBy: req.user?.id,
        uploadedAt: new Date().toISOString()
      }
    }
  });
  
  stream.on('error', (err) => {
    res.status(500).json({ error: err.message });
  });
  
  stream.on('finish', () => {
    req.file.gcsUrl = `https://storage.googleapis.com/${bucket.name}/${file.name}`;
    next();
  });
  
  stream.end(req.file.buffer);
};

// Use in route
app.post('/upload', upload.single('file'), uploadToGCS, (req, res) => {
  res.json({
    message: 'File uploaded to GCS',
    url: req.file.gcsUrl
  });
});
```

**2. Signed URLs for secure access:**
```javascript
// Generate signed URL for S3
async function generateS3SignedUrl(bucketKey, expiresIn = 3600) {
  const params = {
    Bucket: 'my-bucket',
    Key: bucketKey,
    Expires: expiresIn
  };
  
  return s3.getSignedUrl('getObject', params);
}

// Generate signed URL for GCS
async function generateGCSSignedUrl(fileName, expiresIn = 3600) {
  const file = bucket.file(fileName);
  
  const [url] = await file.getSignedUrl({
    version: 'v4',
    action: 'read',
    expires: Date.now() + expiresIn * 1000
  });
  
  return url;
}

// Usage
app.get('/download/:fileId', async (req, res) => {
  try {
    const signedUrl = await generateS3SignedUrl(`uploads/${req.params.fileId}`);
    res.json({ downloadUrl: signedUrl });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

**3. File deletion from cloud storage:**
```javascript
// Delete from S3
async function deleteFromS3(bucketKey) {
  const params = {
    Bucket: 'my-bucket',
    Key: bucketKey
  };
  
  return s3.deleteObject(params).promise();
}

// Delete from GCS
async function deleteFromGCS(fileName) {
  const file = bucket.file(fileName);
  return file.delete();
}

// Usage
app.delete('/file/:fileId', async (req, res) => {
  try {
    await deleteFromS3(`uploads/${req.params.fileId}`);
    res.json({ message: 'File deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

**Real-world cloud storage patterns:**

**E-commerce product images:**
- Upload to S3 with CDN (CloudFront)
- Generate thumbnails on upload
- Store metadata in database
- Use signed URLs for private images

**User file storage:**
- Organize by user ID: `users/{userId}/files/`
- Implement quota management
- Track file versions
- Enable file sharing with signed URLs

**Backup storage:**
- Compress before upload
- Store in cheaper storage class (Glacier)
- Implement retention policies
- Automate cleanup of old backups

**Best practices:**

1. **Use environment variables**: For credentials
2. **Implement error handling**: Network failures, timeouts
3. **Monitor uploads**: Track success/failure rates
4. **Use CDN**: For frequently accessed files
5. **Implement quotas**: Prevent storage abuse
6. **Secure credentials**: Never commit keys to repo
7. **Test thoroughly**: With various file sizes

**Remember:** Cloud storage provides scalability and reliability but adds latency. Use CDN for frequently accessed files and implement proper error handling for network failures.

---

#### 2. How do you handle file downloads and streaming from cloud storage?

**Answer:**

**File downloads and streaming** from cloud storage requires efficient handling of large files, proper headers, and error management.

**1. Direct download from S3:**
```javascript
// Download file from S3
app.get('/download/:fileId', async (req, res) => {
  const params = {
    Bucket: 'my-bucket',
    Key: `uploads/${req.params.fileId}`
  };
  
  try {
    const data = await s3.getObject(params).promise();
    
    res.set({
      'Content-Type': data.ContentType,
      'Content-Length': data.ContentLength,
      'Content-Disposition': `attachment; filename="${req.params.fileId}"`
    });
    
    res.send(data.Body);
  } catch (error) {
    res.status(404).json({ error: 'File not found' });
  }
});
```

**2. Streaming download (for large files):**
```javascript
// Stream file from S3
app.get('/stream/:fileId', (req, res) => {
  const params = {
    Bucket: 'my-bucket',
    Key: `uploads/${req.params.fileId}`
  };
  
  const stream = s3.getObject(params).createReadStream();
  
  stream.on('error', (error) => {
    if (error.code === 'NoSuchKey') {
      res.status(404).json({ error: 'File not found' });
    } else {
      res.status(500).json({ error: error.message });
    }
  });
  
  res.set({
    'Content-Type': 'application/octet-stream',
    'Content-Disposition': `attachment; filename="${req.params.fileId}"`
  });
  
  stream.pipe(res);
});
```

**3. Range requests (resume downloads):**
```javascript
// Support range requests for resumable downloads
app.get('/download-resumable/:fileId', async (req, res) => {
  const params = {
    Bucket: 'my-bucket',
    Key: `uploads/${req.params.fileId}`
  };
  
  try {
    // Get file metadata
    const headData = await s3.headObject(params).promise();
    const fileSize = headData.ContentLength;
    
    const range = req.headers.range;
    
    if (range) {
      // Parse range header
      const parts = range.replace(/bytes=/, '').split('-');
      const start = parseInt(parts[0], 10);
      const end = parts[1] ? parseInt(parts[1], 10) : fileSize - 1;
      
      // Get partial content
      const stream = s3.getObject({
        ...params,
        Range: `bytes=${start}-${end}`
      }).createReadStream();
      
      res.status(206); // Partial Content
      res.set({
        'Content-Range': `bytes ${start}-${end}/${fileSize}`,
        'Content-Length': end - start + 1,
        'Content-Type': 'application/octet-stream'
      });
      
      stream.pipe(res);
    } else {
      // Full file download
      const stream = s3.getObject(params).createReadStream();
      
      res.set({
        'Content-Length': fileSize,
        'Content-Type': 'application/octet-stream',
        'Accept-Ranges': 'bytes'
      });
      
      stream.pipe(res);
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

**4. Signed URL download:**
```javascript
// Generate temporary download link
app.get('/download-link/:fileId', async (req, res) => {
  try {
    const signedUrl = await generateS3SignedUrl(
      `uploads/${req.params.fileId}`,
      3600 // 1 hour expiry
    );
    
    res.json({ 
      downloadUrl: signedUrl,
      expiresIn: 3600
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Client-side: redirect to signed URL
// window.location.href = downloadUrl;
```

**5. Streaming with progress tracking:**
```javascript
// Track download progress
app.get('/download-progress/:fileId', (req, res) => {
  const params = {
    Bucket: 'my-bucket',
    Key: `uploads/${req.params.fileId}`
  };
  
  const stream = s3.getObject(params).createReadStream();
  let downloadedBytes = 0;
  
  stream.on('data', (chunk) => {
    downloadedBytes += chunk.length;
    
    // Log progress (could send to client via WebSocket)
    console.log(`Downloaded: ${downloadedBytes} bytes`);
  });
  
  stream.on('error', (error) => {
    res.status(500).json({ error: error.message });
  });
  
  res.set({
    'Content-Type': 'application/octet-stream',
    'Content-Disposition': `attachment; filename="${req.params.fileId}"`
  });
  
  stream.pipe(res);
});
```

**6. Proxy download (hide S3 URL):**
```javascript
// Proxy file through your server
app.get('/file/:fileId', async (req, res) => {
  // Check permissions
  if (!hasAccess(req.user, req.params.fileId)) {
    return res.status(403).json({ error: 'Access denied' });
  }
  
  const params = {
    Bucket: 'my-bucket',
    Key: `uploads/${req.params.fileId}`
  };
  
  try {
    const data = await s3.getObject(params).promise();
    
    // Add custom headers
    res.set({
      'Content-Type': data.ContentType,
      'X-File-Id': req.params.fileId,
      'X-Downloaded-By': req.user.id,
      'Cache-Control': 'private, max-age=3600'
    });
    
    res.send(data.Body);
  } catch (error) {
    res.status(404).json({ error: 'File not found' });
  }
});
```

**Best practices for downloads:**

1. **Use streaming**: For large files
2. **Support range requests**: Enable resume capability
3. **Set proper headers**: Content-Type, Content-Disposition
4. **Implement permissions**: Check access before download
5. **Monitor bandwidth**: Track download usage
6. **Use CDN**: For frequently downloaded files
7. **Handle errors**: Network failures, missing files
8. **Log downloads**: For audit and analytics

**Real-world scenarios:**

**Document download:**
- Check user permissions
- Log download for audit
- Track download count
- Implement rate limiting

**Video streaming:**
- Support range requests
- Use adaptive bitrate
- Implement progress tracking
- Cache at CDN edge

**Backup download:**
- Verify integrity (checksums)
- Support resumable downloads
- Implement expiring links
- Track restoration attempts

**Remember:** Streaming is more efficient than buffering for large files. Always implement proper error handling and security checks before allowing downloads.

---
## 49. Image Processing & Optimization

#### 1. How do you process and optimize images in Node.js?

**Answer:**

**Image processing and optimization** involves resizing, compressing, converting formats, and applying effects to images while maintaining quality and minimizing file size.

**1. Image processing with Sharp (recommended):**
```javascript
const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

// Basic image optimization
async function optimizeImage(inputPath, outputPath) {
  try {
    await sharp(inputPath)
      .resize(1920, 1080, {
        fit: 'inside',
        withoutEnlargement: true
      })
      .jpeg({ quality: 80, progressive: true })
      .toFile(outputPath);
    
    console.log('Image optimized successfully');
  } catch (error) {
    console.error('Optimization failed:', error);
  }
}

// Generate multiple sizes (thumbnails)
async function generateThumbnails(inputPath, outputDir) {
  const sizes = [
    { name: 'thumb', width: 150, height: 150 },
    { name: 'small', width: 300, height: 300 },
    { name: 'medium', width: 600, height: 600 },
    { name: 'large', width: 1200, height: 1200 }
  ];
  
  const image = sharp(inputPath);
  
  for (const size of sizes) {
    const outputPath = path.join(
      outputDir,
      `${path.basename(inputPath, path.extname(inputPath))}-${size.name}.jpg`
    );
    
    await image
      .resize(size.width, size.height, {
        fit: 'cover',
        position: 'center'
      })
      .jpeg({ quality: 80 })
      .toFile(outputPath);
  }
  
  console.log('Thumbnails generated successfully');
}

// Convert to modern formats
async function convertToWebP(inputPath, outputPath) {
  try {
    await sharp(inputPath)
      .webp({ quality: 80 })
      .toFile(outputPath);
    
    console.log('Converted to WebP');
  } catch (error) {
    console.error('Conversion failed:', error);
  }
}

// Usage in Express
const upload = multer({ storage: multer.memoryStorage() });

app.post('/upload-image', upload.single('image'), async (req, res) => {
  try {
    const filename = `${Date.now()}-${req.file.originalname}`;
    const outputDir = 'uploads/images';
    
    // Save original
    const originalPath = path.join(outputDir, `original-${filename}`);
    fs.writeFileSync(originalPath, req.file.buffer);
    
    // Generate thumbnails
    await generateThumbnails(originalPath, outputDir);
    
    // Convert to WebP
    const webpPath = path.join(outputDir, `${filename}.webp`);
    await convertToWebP(originalPath, webpPath);
    
    res.json({
      message: 'Image processed successfully',
      original: originalPath,
      webp: webpPath
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

**2. Advanced image processing:**
```javascript
// Extract metadata
async function getImageMetadata(imagePath) {
  const metadata = await sharp(imagePath).metadata();
  
  return {
    width: metadata.width,
    height: metadata.height,
    format: metadata.format,
    colorspace: metadata.space,
    hasAlpha: metadata.hasAlpha,
    density: metadata.density,
    chromaSubsampling: metadata.chromaSubsampling,
    isProgressive: metadata.isProgressive
  };
}

// Apply filters and effects
async function applyFilters(inputPath, outputPath) {
  const image = sharp(inputPath);
  
  // Grayscale
  await image.grayscale().toFile(`${outputPath}-grayscale.jpg`);
  
  // Blur
  await image.blur(5).toFile(`${outputPath}-blur.jpg`);
  
  // Sharpen
  await image.sharpen().toFile(`${outputPath}-sharp.jpg`);
  
  // Rotate
  await image.rotate(90).toFile(`${outputPath}-rotated.jpg`);
  
  // Flip
  await image.flip().toFile(`${outputPath}-flipped.jpg`);
}

// Composite images (overlay)
async function compositeImages(baseImage, overlayImage, outputPath) {
  await sharp(baseImage)
    .composite([
      {
        input: overlayImage,
        top: 10,
        left: 10
      }
    ])
    .toFile(outputPath);
}

// Extract region (crop)
async function cropImage(inputPath, outputPath, left, top, width, height) {
  await sharp(inputPath)
    .extract({ left, top, width, height })
    .toFile(outputPath);
}
```

**3. Batch image processing:**
```javascript
// Process multiple images
async function batchProcessImages(inputDir, outputDir) {
  const files = fs.readdirSync(inputDir);
  const imageFiles = files.filter(f => /\.(jpg|jpeg|png|webp)$/i.test(f));
  
  for (const file of imageFiles) {
    const inputPath = path.join(inputDir, file);
    const outputPath = path.join(outputDir, `optimized-${file}`);
    
    try {
      await sharp(inputPath)
        .resize(1920, 1080, { fit: 'inside', withoutEnlargement: true })
        .jpeg({ quality: 80, progressive: true })
        .toFile(outputPath);
      
      console.log(`Processed: ${file}`);
    } catch (error) {
      console.error(`Failed to process ${file}:`, error.message);
    }
  }
}

// Usage
app.post('/batch-process', async (req, res) => {
  try {
    await batchProcessImages('uploads/raw', 'uploads/optimized');
    res.json({ message: 'Batch processing complete' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

**4. Responsive image generation:**
```javascript
// Generate responsive images for different screen sizes
async function generateResponsiveImages(inputPath, outputDir, filename) {
  const breakpoints = [
    { width: 320, suffix: 'xs' },
    { width: 640, suffix: 'sm' },
    { width: 1024, suffix: 'md' },
    { width: 1920, suffix: 'lg' },
    { width: 2560, suffix: 'xl' }
  ];
  
  const images = {};
  
  for (const bp of breakpoints) {
    const outputPath = path.join(
      outputDir,
      `${filename}-${bp.suffix}.jpg`
    );
    
    await sharp(inputPath)
      .resize(bp.width, null, { withoutEnlargement: true })
      .jpeg({ quality: 80, progressive: true })
      .toFile(outputPath);
    
    images[bp.suffix] = outputPath;
  }
  
  return images;
}

// Generate srcset for HTML
function generateSrcset(baseUrl, filename) {
  const breakpoints = ['xs', 'sm', 'md', 'lg', 'xl'];
  const widths = [320, 640, 1024, 1920, 2560];
  
  return breakpoints
    .map((suffix, i) => `${baseUrl}/${filename}-${suffix}.jpg ${widths[i]}w`)
    .join(', ');
}

// Usage
app.post('/upload-responsive', upload.single('image'), async (req, res) => {
  try {
    const filename = `${Date.now()}-image`;
    const outputDir = 'uploads/responsive';
    
    // Save original
    const originalPath = path.join(outputDir, `${filename}-original.jpg`);
    fs.writeFileSync(originalPath, req.file.buffer);
    
    // Generate responsive images
    const images = await generateResponsiveImages(
      originalPath,
      outputDir,
      filename
    );
    
    // Generate srcset
    const srcset = generateSrcset('/uploads/responsive', filename);
    
    res.json({
      images,
      srcset,
      html: `<img srcset="${srcset}" src="/uploads/responsive/${filename}-md.jpg" alt="Responsive image">`
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

**Real-world image optimization patterns:**

**E-commerce product images:**
- Generate multiple sizes (thumbnail, product page, zoom)
- Convert to WebP with JPEG fallback
- Extract and store metadata
- Implement CDN caching

**Social media uploads:**
- Resize to platform specifications
- Compress aggressively
- Strip EXIF data (privacy)
- Generate preview thumbnails

**Blog/CMS images:**
- Generate responsive sizes
- Create srcset for different devices
- Optimize for web (progressive JPEG)
- Generate WebP alternatives

**Best practices:**

1. **Use Sharp**: Most efficient image library for Node.js
2. **Generate multiple sizes**: For responsive design
3. **Convert to modern formats**: WebP with fallbacks
4. **Strip metadata**: Remove EXIF for privacy
5. **Implement caching**: Cache processed images
6. **Monitor performance**: Track processing time
7. **Handle errors**: Invalid images, corrupted files
8. **Use CDN**: Serve images from edge locations

**Performance comparison:**

**Original JPEG: 2.5MB**
- Optimized JPEG (80% quality): 450KB (82% reduction)
- WebP (80% quality): 280KB (89% reduction)
- Thumbnail (150x150): 8KB (99.7% reduction)

**Remember:** Image optimization significantly improves page load times and user experience. Always generate multiple sizes and modern formats for best results.

---

#### 2. How do you handle image uploads with automatic optimization?

**Answer:**

**Automatic image optimization** on upload ensures all images are processed consistently, reducing storage costs and improving performance without manual intervention.

**1. Complete image upload pipeline:**
```javascript
const multer = require('multer');
const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

// Configure upload
const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 10 * 1024 * 1024 }, // 10MB
  fileFilter: (req, file, cb) => {
    // Only accept images
    if (file.mimetype.startsWith('image/')) {
      cb(null, true);
    } else {
      cb(new Error('Only image files are allowed'));
    }
  }
});

// Image optimization middleware
const optimizeImage = async (req, res, next) => {
  if (!req.file) return next();
  
  try {
    const timestamp = Date.now();
    const filename = `${timestamp}-${path.parse(req.file.originalname).name}`;
    const outputDir = 'uploads/images';
    
    // Ensure output directory exists
    if (!fs.existsSync(outputDir)) {
      fs.mkdirSync(outputDir, { recursive: true });
    }
    
    // Get image metadata
    const metadata = await sharp(req.file.buffer).metadata();
    
    // Generate optimized versions
    const versions = {};
    
    // 1. Original (optimized)
    const originalPath = path.join(outputDir, `${filename}-original.jpg`);
    await sharp(req.file.buffer)
      .rotate() // Auto-rotate based on EXIF
      .withMetadata(false) // Remove EXIF
      .jpeg({ quality: 90, progressive: true })
      .toFile(originalPath);
    versions.original = originalPath;
    
    // 2. Thumbnail
    const thumbPath = path.join(outputDir, `${filename}-thumb.jpg`);
    await sharp(req.file.buffer)
      .resize(150, 150, { fit: 'cover' })
      .jpeg({ quality: 80 })
      .toFile(thumbPath);
    versions.thumb = thumbPath;
    
    // 3. Medium
    const mediumPath = path.join(outputDir, `${filename}-medium.jpg`);
    await sharp(req.file.buffer)
      .resize(600, 600, { fit: 'inside', withoutEnlargement: true })
      .jpeg({ quality: 85, progressive: true })
      .toFile(mediumPath);
    versions.medium = mediumPath;
    
    // 4. Large
    const largePath = path.join(outputDir, `${filename}-large.jpg`);
    await sharp(req.file.buffer)
      .resize(1920, 1920, { fit: 'inside', withoutEnlargement: true })
      .jpeg({ quality: 80, progressive: true })
      .toFile(largePath);
    versions.large = largePath;
    
    // 5. WebP versions
    const webpPath = path.join(outputDir, `${filename}.webp`);
    await sharp(req.file.buffer)
      .resize(1920, 1920, { fit: 'inside', withoutEnlargement: true })
      .webp({ quality: 80 })
      .toFile(webpPath);
    versions.webp = webpPath;
    
    // Store metadata
    req.imageData = {
      filename,
      originalName: req.file.originalname,
      mimeType: req.file.mimetype,
      size: req.file.size,
      metadata: {
        width: metadata.width,
        height: metadata.height,
        format: metadata.format,
        colorspace: metadata.space,
        hasAlpha: metadata.hasAlpha
      },
      versions,
      uploadedAt: new Date().toISOString()
    };
    
    next();
  } catch (error) {
    res.status(400).json({ error: `Image processing failed: ${error.message}` });
  }
};

// Route with automatic optimization
app.post('/upload-image', upload.single('image'), optimizeImage, (req, res) => {
  // Save metadata to database
  saveImageMetadata(req.imageData);
  
  res.json({
    message: 'Image uploaded and optimized successfully',
    data: req.imageData
  });
});
```

**2. Async image processing (background job):**
```javascript
const Queue = require('bull');
const imageQueue = new Queue('image-processing');

// Process images in background
imageQueue.process(async (job) => {
  const { imageBuffer, filename, userId } = job.data;
  
  try {
    // Process image
    const versions = await processImage(imageBuffer, filename);
    
    // Update database
    await updateImageRecord(userId, filename, versions);
    
    // Update job progress
    job.progress(100);
    
    return { success: true, versions };
  } catch (error) {
    throw new Error(`Image processing failed: ${error.message}`);
  }
});

// Handle completed jobs
imageQueue.on('completed', (job) => {
  console.log(`Image processing completed: ${job.id}`);
});

// Handle failed jobs
imageQueue.on('failed', (job, err) => {
  console.error(`Image processing failed: ${job.id}`, err.message);
});

// Upload route (queues job)
app.post('/upload-async', upload.single('image'), async (req, res) => {
  try {
    // Queue image processing job
    const job = await imageQueue.add({
      imageBuffer: req.file.buffer,
      filename: `${Date.now()}-${req.file.originalname}`,
      userId: req.user.id
    });
    
    res.json({
      message: 'Image queued for processing',
      jobId: job.id,
      statusUrl: `/job-status/${job.id}`
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Check job status
app.get('/job-status/:jobId', async (req, res) => {
  const job = await imageQueue.getJob(req.params.jobId);
  
  if (!job) {
    return res.status(404).json({ error: 'Job not found' });
  }
  
  res.json({
    id: job.id,
    status: await job.getState(),
    progress: job.progress(),
    result: job.returnvalue
  });
});
```

**3. Error handling and validation:**
```javascript
// Comprehensive image upload with validation
app.post('/upload-safe', upload.single('image'), optimizeImage, async (req, res) => {
  try {
    // Validate image dimensions
    const { width, height } = req.imageData.metadata;
    
    if (width < 100 || height < 100) {
      return res.status(400).json({ 
        error: 'Image too small (minimum 100x100)' 
      });
    }
    
    if (width > 10000 || height > 10000) {
      return res.status(400).json({ 
        error: 'Image too large (maximum 10000x10000)' 
      });
    }
    
    // Check file size after optimization
    const originalSize = req.file.size;
    const optimizedSize = fs.statSync(req.imageData.versions.original).size;
    
    if (optimizedSize > 5 * 1024 * 1024) { // 5MB
      return res.status(400).json({ 
        error: 'Optimized image still too large' 
      });
    }
    
    // Save to database
    const image = await Image.create({
      userId: req.user.id,
      filename: req.imageData.filename,
      originalName: req.imageData.originalName,
      mimeType: req.imageData.mimeType,
      originalSize,
      optimizedSize,
      width,
      height,
      versions: req.imageData.versions,
      uploadedAt: new Date()
    });
    
    res.json({
      message: 'Image uploaded successfully',
      image: {
        id: image.id,
        url: `/images/${image.id}`,
        sizes: {
          thumb: `/images/${image.id}/thumb`,
          medium: `/images/${image.id}/medium`,
          large: `/images/${image.id}/large`
        }
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

**Best practices for automatic optimization:**

1. **Process in background**: Don't block user request
2. **Generate multiple sizes**: For responsive design
3. **Convert to modern formats**: WebP with fallbacks
4. **Validate dimensions**: Prevent extreme sizes
5. **Strip metadata**: Remove EXIF for privacy
6. **Implement error handling**: Graceful failure
7. **Monitor performance**: Track processing time
8. **Cache results**: Avoid reprocessing

**Real-world implementation:**

**Social media platform:**
- Upload → Queue job → Process → Store → Notify user
- Generate 5-10 different sizes
- Convert to WebP
- Strip EXIF data
- Implement CDN caching

**E-commerce site:**
- Upload → Immediate optimization → Store → Generate thumbnails
- Multiple product angles
- Zoom-capable images
- Mobile-optimized versions

**Remember:** Automatic optimization ensures consistency, improves performance, and reduces storage costs. Always process images in the background to avoid blocking user requests.

---