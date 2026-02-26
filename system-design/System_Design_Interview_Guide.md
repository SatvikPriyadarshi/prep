# Complete System Design Interview Guide

## Table of Contents

### Core Concepts
1. [Core Fundamentals](#1-core-fundamentals)
2. [Requirements & Capacity Estimation](#2-requirements--capacity-estimation)
3. [Key Trade-offs & CAP Theorem](#3-key-trade-offs--cap-theorem)
4. [Load Balancing & Caching](#4-load-balancing--caching)
5. [Databases: SQL vs NoSQL](#5-databases-sql-vs-nosql)
6. [Database Replication & Sharding](#6-database-replication--sharding)
7. [Microservices vs Monolith](#7-microservices-vs-monolith)
8. [Design Patterns & Architecture](#8-design-patterns--architecture)
9. [Message Queues & Event-Driven Architecture](#9-message-queues--event-driven-architecture)
10. [Consistent Hashing](#10-consistent-hashing)
11. [CDN & Performance Optimization](#11-cdn--performance-optimization)
12. [API Design: REST vs GraphQL vs gRPC](#12-api-design-rest-vs-graphql-vs-grpc)
13. [Distributed Systems Basics](#13-distributed-systems-basics)

### Case Studies
14. [Design URL Shortener (TinyURL)](#11-design-url-shortener-tinyurl)
15. [Design WhatsApp/Chat System](#12-design-whatsappchat-system)
16. [Design Twitter/News Feed](#13-design-twitternews-feed)
17. [Design Uber/Ride-Hailing](#14-design-uberride-hailing)
18. [Design Instagram/Photo Sharing](#15-design-instagramphoto-sharing)
19. [Design YouTube/Netflix (Video Streaming)](#16-design-youtubenetflix-video-streaming)
20. [Design Amazon/E-commerce](#17-design-amazone-commerce)
21. [Design Dropbox/Google Drive](#18-design-dropboxgoogle-drive-file-storage)
22. [Design Parking Lot System](#19-design-parking-lot-system)
23. [Design Vending Machine](#20-design-vending-machine)
24. [Design Library Management System](#21-design-library-management-system)
25. [Design Chess Game](#22-design-chess-game)
26. [Design Restaurant Booking System](#23-design-restaurant-booking-system)
27. [Design Airline Reservation System](#24-design-airline-reservation-system)
28. [Design Hotel Booking System](#25-design-hotel-booking-system)

### Bonus
29. [Quick Prep Questions](#bonus-quick-prep-questions)
30. [Interview Tips](#tips-for-system-design-interviews)

---

## 1. Core Fundamentals {#1-core-fundamentals}

### 1.1 What are the key principles of system design?

**Answer:**
System design focuses on building scalable, reliable, and maintainable systems. Key principles include:

- **Scalability**: Handle growing data and users
- **Reliability**: System continues functioning despite failures
- **Maintainability**: Easy to update, debug, and extend
- **Performance**: Low latency and high throughput
- **Availability**: System uptime and accessibility

**Real-world Example:**
Twitter's system must handle millions of concurrent users posting tweets. It uses horizontal scaling (adding more servers) rather than vertical scaling (upgrading one server) to maintain performance.

### 1.2 What is the difference between horizontal and vertical scaling?

**Answer:**
- **Vertical Scaling**: Adding more power to existing machines (more CPU, RAM, storage)
  - Pros: Simple, no code changes needed
  - Cons: Limited by hardware, single point of failure, expensive
  
- **Horizontal Scaling**: Adding more machines to the system
  - Pros: Unlimited scalability, fault tolerance, cost-effective
  - Cons: Complex, requires load balancing, data consistency challenges

**Real-world Example:**
Netflix uses horizontal scaling with thousands of servers across multiple regions. If one server fails, others handle the traffic automatically.

### 1.3 What is latency and throughput?

**Answer:**
- **Latency**: Time taken to process a single request (measured in milliseconds)
- **Throughput**: Number of requests processed per unit time (requests/second)

Trade-off: You can optimize for low latency (fast response) or high throughput (many requests), but rarely both simultaneously.

**Real-world Example:**
- Video streaming (Netflix): Prioritizes throughput (streaming many bytes/second)
- Online gaming: Prioritizes latency (quick response to player actions)

### 1.4 What is the difference between availability and reliability?

**Answer:**
- **Availability**: Percentage of time system is operational (uptime)
- **Reliability**: Probability system will function correctly without failure

**Real-world Example:**
- 99.9% availability (three 9s) = 43 minutes downtime/month
- 99.99% availability (four 9s) = 4 minutes downtime/month
- Reliability ensures when system is up, it works correctly

### 1.5 What is redundancy and why is it important?

**Answer:**
Redundancy means having duplicate components so if one fails, others take over. Types:

- **Hardware Redundancy**: Multiple servers, databases, network paths
- **Data Redundancy**: Replication across multiple locations
- **Software Redundancy**: Multiple instances of services

**Real-world Example:**
Amazon S3 replicates data across multiple data centers. If one center fails, data is still accessible from others.

---

## 2. Requirements & Capacity Estimation {#2-requirements--capacity-estimation}

### 2.1 How do you gather functional and non-functional requirements?

**Answer:**
**Functional Requirements** (what system does):
- User registration and authentication
- Post creation and viewing
- Search functionality

**Non-Functional Requirements** (how system performs):
- Scalability: Handle 1 million concurrent users
- Latency: Response time < 200ms
- Availability: 99.99% uptime
- Consistency: Data accuracy across regions

**Real-world Example:**
For a Twitter-like system:
- Functional: Users can tweet, retweet, like
- Non-functional: Handle 500K tweets/second, 100ms response time

### 2.2 How do you estimate capacity requirements?

**Answer:**
Steps:
1. Estimate daily active users (DAU)
2. Calculate requests per second (RPS)
3. Estimate storage needs
4. Calculate bandwidth requirements

**Example Calculation:**
- 100 million DAU
- 10 requests per user per day
- Total requests = 100M × 10 = 1 billion/day
- RPS = 1 billion / 86,400 seconds ≈ 11,600 RPS

### 2.3 How do you calculate storage requirements?

**Answer:**
Storage = (Data per request) × (Total requests) × (Retention period)

**Example:**
- 1 KB per tweet
- 500K tweets/second
- 1 year retention
- Storage = 1 KB × 500K × 86,400 × 365 ≈ 15.7 PB

### 2.4 What is bandwidth estimation?

**Answer:**
Bandwidth = (Data per request) × (Requests per second)

**Example:**
- 100 KB per request
- 10,000 RPS
- Bandwidth = 100 KB × 10,000 = 1 GB/second

### 2.5 How do you handle traffic spikes?

**Answer:**
- **Auto-scaling**: Automatically add servers during peak hours
- **Caching**: Reduce database load
- **Rate limiting**: Prevent abuse
- **Queue systems**: Buffer excess requests

**Real-world Example:**
During New Year's Eve, Twitter experiences 10x normal traffic. Auto-scaling adds servers automatically to handle the spike.

---

## 3. Key Trade-offs & CAP Theorem {#3-key-trade-offs--cap-theorem}

### 3.1 What is the CAP Theorem?

**Answer:**
CAP Theorem states a distributed system can guarantee only 2 of 3 properties:

- **Consistency**: All nodes see same data at same time
- **Availability**: System always responds to requests
- **Partition Tolerance**: System works despite network failures

**Real-world Example:**
- **CP (Consistency + Partition)**: Banking systems prioritize consistency (correct balance) over availability
- **AP (Availability + Partition)**: Social media prioritizes availability (always accessible) over consistency (slight delay in updates)

### 3.2 What is eventual consistency?

**Answer:**
System guarantees that if no new updates occur, all nodes will eventually have the same data. Used in AP systems.

**Real-world Example:**
When you like a post on Instagram, your friend might not see the updated count immediately, but within seconds they will.

### 3.3 What is strong consistency?

**Answer:**
All reads return the most recent write. Used in CP systems. Slower but guarantees correctness.

**Real-world Example:**
Bank transfers must be strongly consistent. You can't withdraw money that hasn't been confirmed as deducted.

### 3.4 What are the trade-offs between consistency and availability?

**Answer:**
- **High Consistency**: Slower, less available, but accurate
- **High Availability**: Faster, always accessible, but may have stale data

Choose based on use case:
- Banking: Consistency > Availability
- Social media: Availability > Consistency

### 3.5 What is the difference between ACID and BASE?

**Answer:**
- **ACID** (Atomicity, Consistency, Isolation, Durability): Strong consistency, used in SQL databases
- **BASE** (Basically Available, Soft state, Eventually consistent): Weak consistency, used in NoSQL databases

**Real-world Example:**
- ACID: PostgreSQL for financial transactions
- BASE: MongoDB for user profiles (eventual consistency acceptable)

---

## 4. Load Balancing & Caching {#4-load-balancing--caching}

### 4.1 What is load balancing and why is it needed?

**Answer:**
Load balancing distributes incoming requests across multiple servers to prevent any single server from becoming a bottleneck.

**Benefits:**
- Improved performance
- High availability
- Fault tolerance
- Scalability

**Real-world Example:**
Netflix uses load balancers to distribute video streaming requests across thousands of servers globally.

### 4.2 What are different load balancing algorithms?

**Answer:**
- **Round Robin**: Distribute requests sequentially
- **Least Connections**: Send to server with fewest active connections
- **IP Hash**: Route based on client IP (ensures same client goes to same server)
- **Weighted Round Robin**: Distribute based on server capacity
- **Random**: Random server selection

**Real-world Example:**
E-commerce sites use Least Connections during sales to balance load across servers with different capacities.

### 4.3 What is caching and its benefits?

**Answer:**
Caching stores frequently accessed data in fast-access storage to reduce database queries.

**Benefits:**
- Reduced latency
- Lower database load
- Improved throughput
- Cost savings

**Real-world Example:**
Facebook caches user profiles in Redis. When you visit a profile, it's retrieved from cache (milliseconds) instead of database (milliseconds to seconds).

### 4.4 What are different caching strategies?

**Answer:**
- **Cache-Aside**: Application checks cache, if miss, fetches from database
- **Write-Through**: Write to cache and database simultaneously
- **Write-Behind**: Write to cache first, then database asynchronously
- **Refresh-Ahead**: Proactively refresh cache before expiration

**Real-world Example:**
YouTube uses Cache-Aside for video metadata. Popular videos are cached; unpopular ones are fetched on demand.

### 4.5 What is cache invalidation?

**Answer:**
Removing stale data from cache. Strategies:

- **TTL (Time To Live)**: Expire after set time
- **Event-based**: Invalidate when data changes
- **LRU (Least Recently Used)**: Remove least used items when cache is full

**Real-world Example:**
When a user updates their profile on Twitter, the cache is invalidated so followers see the updated profile.

---

## 5. Databases: SQL vs NoSQL {#5-databases-sql-vs-nosql}

### 5.1 What is the difference between SQL and NoSQL databases?

**Answer:**
| Feature | SQL | NoSQL |
|---------|-----|-------|
| Schema | Fixed schema | Flexible schema |
| Scalability | Vertical | Horizontal |
| Consistency | Strong (ACID) | Eventual (BASE) |
| Query Language | SQL | Varies (JSON, etc.) |
| Transactions | Multi-row | Limited |
| Use Case | Structured data | Unstructured data |

**Real-world Example:**
- SQL: Banking (structured transactions)
- NoSQL: Social media (flexible user profiles)

### 5.2 When should you use SQL databases?

**Answer:**
Use SQL when:
- Data is highly structured
- ACID transactions required
- Complex queries needed
- Data relationships are important

**Real-world Example:**
E-commerce platforms use SQL for orders, payments, and inventory (structured, transactional).

### 5.3 When should you use NoSQL databases?

**Answer:**
Use NoSQL when:
- Data is unstructured or semi-structured
- Horizontal scalability needed
- High throughput required
- Flexible schema needed

**Real-world Example:**
Uber uses NoSQL for driver locations (constantly changing, high volume, flexible schema).

### 5.4 What are different types of NoSQL databases?

**Answer:**
- **Document**: MongoDB (JSON-like documents)
- **Key-Value**: Redis (fast lookups)
- **Column-Family**: Cassandra (time-series data)
- **Graph**: Neo4j (relationships)

**Real-world Example:**
- Document: User profiles
- Key-Value: Session storage
- Column-Family: Analytics data
- Graph: Social connections

### 5.5 What is denormalization and when is it used?

**Answer:**
Denormalization means storing redundant data to improve query performance. Opposite of normalization.

**Trade-off:**
- Pros: Faster reads, simpler queries
- Cons: Slower writes, data inconsistency risk

**Real-world Example:**
In a social media database, store user's follower count directly instead of counting followers each time (denormalized for speed).

---

## 6. Database Replication & Sharding {#6-database-replication--sharding}

### 6.1 What is database replication?

**Answer:**
Replication copies data across multiple database instances for redundancy and availability.

**Types:**
- **Master-Slave**: One master (writes), multiple slaves (reads)
- **Master-Master**: Multiple masters (both read/write)

**Real-world Example:**
MySQL replication: Master database in US, slave in Europe. Reads distributed, writes go to master.

### 6.2 What is the difference between master-slave and master-master replication?

**Answer:**
- **Master-Slave**: 
  - One master handles writes
  - Slaves handle reads
  - Simple, but master is bottleneck
  
- **Master-Master**:
  - Multiple masters handle writes
  - Better availability
  - Complex conflict resolution

**Real-world Example:**
- Master-Slave: Most common, used by Twitter
- Master-Master: Used when multiple regions need write capability

### 6.3 What is database sharding?

**Answer:**
Sharding partitions data across multiple databases based on a shard key. Each shard holds subset of data.

**Benefits:**
- Horizontal scalability
- Reduced query load
- Improved performance

**Real-world Example:**
MongoDB sharding: User data sharded by user_id. User 1-1M on Shard 1, User 1M-2M on Shard 2.

### 6.4 What are sharding strategies?

**Answer:**
- **Range-based**: Shard by value ranges (user IDs 1-1M, 1M-2M)
- **Hash-based**: Shard by hash of key (consistent hashing)
- **Directory-based**: Lookup table maps key to shard

**Real-world Example:**
Uber uses hash-based sharding on driver_id to evenly distribute driver data.

### 6.5 What are challenges with sharding?

**Answer:**
- **Uneven distribution**: Some shards get more data (hot shards)
- **Cross-shard queries**: Queries spanning multiple shards are slow
- **Resharding**: Adding new shards requires data migration
- **Transactions**: Multi-shard transactions are complex

**Real-world Example:**
If you shard by city and one city becomes very popular, that shard becomes overloaded (hot shard problem).

---

## 7. Microservices vs Monolith {#7-microservices-vs-monolith}

### 7.1 What is a monolithic architecture?

**Answer:**
Single codebase with all features tightly coupled. One deployment unit.

**Pros:**
- Simple to develop initially
- Easy debugging
- Better performance (no network calls)

**Cons:**
- Hard to scale individual features
- Technology lock-in
- Difficult to deploy changes
- Single point of failure

**Real-world Example:**
Early Twitter was monolithic. All features (tweets, followers, search) in one codebase.

### 7.2 What is microservices architecture?

**Answer:**
Multiple independent services, each handling specific business logic. Services communicate via APIs.

**Pros:**
- Independent scaling
- Technology flexibility
- Easier deployment
- Fault isolation

**Cons:**
- Complex distributed system
- Network latency
- Data consistency challenges
- Operational complexity

**Real-world Example:**
Modern Netflix has separate services: User Service, Recommendation Service, Payment Service, etc.

### 7.3 When should you use microservices?

**Answer:**
Use microservices when:
- System is large and complex
- Different teams own different features
- Independent scaling needed
- Different technologies required

**Real-world Example:**
Uber uses microservices: Driver Service, Rider Service, Payment Service, each scaled independently.

### 7.4 What are the challenges of microservices?

**Answer:**
- **Distributed Tracing**: Hard to debug across services
- **Data Consistency**: Eventual consistency required
- **Network Latency**: Service-to-service calls add latency
- **Operational Complexity**: More services to monitor and deploy

**Real-world Example:**
If Payment Service is down, entire Uber ride booking fails (cascading failure).

### 7.5 How do you handle communication between microservices?

**Answer:**
- **Synchronous**: REST APIs, gRPC (request-response)
- **Asynchronous**: Message queues, event streaming

**Real-world Example:**
- Synchronous: User Service calls Payment Service to verify payment
- Asynchronous: Order Service publishes "OrderCreated" event, Notification Service subscribes

---

## 8. Design Patterns & Architecture {#8-design-patterns--architecture}

### 8.1 What is the API Gateway pattern?

**Answer:**
Single entry point for all client requests. Routes requests to appropriate microservices.

**Benefits:**
- Centralized authentication
- Request routing
- Rate limiting
- Load balancing

**Real-world Example:**
Amazon API Gateway routes requests to different Lambda functions based on URL path.

### 8.2 What is the Circuit Breaker pattern?

**Answer:**
Prevents cascading failures by stopping requests to failing services. States:

- **Closed**: Normal operation
- **Open**: Reject requests (service failing)
- **Half-Open**: Test if service recovered

**Real-world Example:**
If Payment Service is down, Circuit Breaker opens and returns error immediately instead of waiting for timeout.

### 8.3 What is the Bulkhead pattern?

**Answer:**
Isolates resources to prevent one failure from affecting entire system. Like compartments in a ship.

**Real-world Example:**
Thread pool per service. If one service is slow, it doesn't affect other services' thread pools.

### 8.4 What is the Saga pattern?

**Answer:**
Manages distributed transactions across microservices. Two types:

- **Choreography**: Services listen to events and react
- **Orchestration**: Central coordinator manages transaction

**Real-world Example:**
Order processing: Order Service → Payment Service → Inventory Service → Shipping Service (coordinated transaction).

### 8.5 What is the CQRS pattern?

**Answer:**
Command Query Responsibility Segregation. Separate read and write models.

**Benefits:**
- Optimize reads and writes independently
- Better scalability
- Improved performance

**Real-world Example:**
E-commerce: Write model updates inventory, Read model serves product listings (optimized for reads).

---

## 9. Message Queues & Event-Driven Architecture {#9-message-queues--event-driven-architecture}

### 9.1 What is a message queue?

**Answer:**
Asynchronous communication system where services send messages to queue. Consumers process messages later.

**Benefits:**
- Decoupling services
- Asynchronous processing
- Fault tolerance
- Load leveling

**Real-world Example:**
When you order on Amazon, order is queued. Payment processed asynchronously, warehouse notified separately.

### 9.2 What are popular message queue systems?

**Answer:**
- **RabbitMQ**: Reliable, supports multiple protocols
- **Apache Kafka**: High throughput, distributed
- **AWS SQS**: Managed, scalable
- **Redis Streams**: Fast, in-memory

**Real-world Example:**
- Kafka: Netflix for event streaming
- RabbitMQ: Traditional task queues
- SQS: AWS-based systems

### 9.3 What is event-driven architecture?

**Answer:**
Services communicate by publishing and subscribing to events. Decoupled, asynchronous communication.

**Real-world Example:**
User Registration Event → Email Service sends welcome email, Analytics Service logs signup, Recommendation Service initializes profile.

### 9.4 What is the difference between pub-sub and point-to-point messaging?

**Answer:**
- **Pub-Sub**: One publisher, multiple subscribers (broadcast)
- **Point-to-Point**: One sender, one receiver (queue)

**Real-world Example:**
- Pub-Sub: Tweet published, all followers notified
- Point-to-Point: Email sent to specific user

### 9.5 How do you handle message ordering and exactly-once delivery?

**Answer:**
- **Ordering**: Use partitions/shards (Kafka partitions)
- **Exactly-Once**: Idempotent processing, deduplication

**Real-world Example:**
Kafka partitions ensure messages from same user processed in order. Idempotent IDs prevent duplicate processing.

---

## 10. Consistent Hashing {#10-consistent-hashing}

### 10.1 What problem does consistent hashing solve?

**Answer:**
Consistent hashing solves the problem of key redistribution when servers are added or removed in distributed systems.

**Problem with Traditional Hashing:**
Using `key % number_of_servers` causes massive redistribution:
- 3 servers → 4 servers: 75% of keys need to move
- Causes cache misses, database overload, performance degradation

**Consistent Hashing Solution:**
- Only ~1/n keys need redistribution when adding/removing servers
- Minimizes cache invalidation
- Maintains load balance

**Real-world Example:**
Memcached cluster: Adding new server redistributes only ~25% of keys instead of 75%.

### 10.2 How does consistent hashing work with virtual nodes?

**Answer:**
Virtual nodes are multiple hash positions per physical server, improving load distribution.

**Without Virtual Nodes:**
- Uneven distribution (hot spots)
- Some servers overloaded, others underutilized

**With Virtual Nodes:**
- Each physical server has 150-200 virtual nodes on hash ring
- Keys distributed evenly across all servers
- Better fault tolerance (when server fails, load spreads across many servers)

**Real-world Example:**
Redis Cluster: Each node has 16,384 slots (virtual nodes). When node fails, slots distributed to remaining nodes evenly.

### 10.3 Why is consistent hashing used in distributed caches like DynamoDB?

**Answer:**
Consistent hashing enables:
- **Scalability**: Add/remove nodes without massive redistribution
- **Fault Tolerance**: Node failure affects only its keys
- **Load Balancing**: Even distribution across nodes
- **Minimal Downtime**: Gradual key migration

**Real-world Example:**
DynamoDB uses consistent hashing for partitioning. When you add capacity, only new keys go to new partitions. Existing keys stay in place.

### 10.4 How does consistent hashing handle node addition/removal?

**Answer:**
**Node Addition:**
1. New node placed on hash ring
2. Keys between new node and previous node reassigned
3. Only ~1/n keys affected (n = total nodes)

**Node Removal:**
1. Node removed from ring
2. Its keys reassigned to next node clockwise
3. Again, only ~1/n keys affected

**Real-world Example:**
Cassandra cluster: Adding node redistributes ~25% of keys. Removing node redistributes its keys to replicas.

### 10.5 What are the alternatives to consistent hashing?

**Answer:**
- **Rendezvous Hashing**: Highest-ranked server wins (simpler, similar performance)
- **Jump Hash**: Fast, minimal state, used by Google
- **Maglev Hashing**: Consistent, fast, used by Google Load Balancer
- **Range-based Partitioning**: Fixed ranges (simpler but less flexible)

**Comparison:**
- Consistent Hashing: Most popular, proven
- Rendezvous: Simpler implementation
- Jump Hash: Faster computation
- Range-based: Easier to understand, less flexible

---

## 11. CDN & Performance Optimization {#11-cdn--performance-optimization}

### 11.1 How does a CDN work and when would you use it?

**Answer:**
**How CDN Works:**
1. User requests content
2. DNS routes to nearest CDN edge server
3. If cached, serve immediately
4. If not cached, fetch from origin and cache
5. Serve to user

**When to Use CDN:**
- Static assets (images, CSS, JS)
- Video streaming
- Large file downloads
- Global user base
- High traffic spikes

**Real-world Example:**
Netflix uses CDN to serve videos from servers near users. Video served from local server (10ms) instead of origin (100ms+).

### 11.2 What are the different caching levels (Browser, CDN, Application, Database)?

**Answer:**
**1. Browser Cache:**
- Stores in user's browser
- Controlled by Cache-Control headers
- Fastest (no network request)

**2. CDN Cache:**
- Edge servers near users
- Reduces origin load
- ~10-50ms latency

**3. Application Cache:**
- In-memory cache (Redis, Memcached)
- Reduces database queries
- ~1-5ms latency

**4. Database Cache:**
- Query result caching
- Buffer pools
- Reduces disk I/O

**Real-world Example:**
Amazon product page: Browser caches CSS (1 week), CDN caches images (1 day), Redis caches product data (1 hour), Database caches query results (5 minutes).

### 11.3 How do you optimize API response times?

**Answer:**
**Strategies:**
- **Caching**: Cache responses at multiple levels
- **Compression**: Gzip/Brotli reduce payload size
- **Pagination**: Return limited data per request
- **Lazy Loading**: Load data on demand
- **Database Indexing**: Faster queries
- **Connection Pooling**: Reuse database connections
- **Async Processing**: Offload heavy work to background jobs
- **CDN**: Serve static content from edge

**Real-world Example:**
Twitter API optimization:
- Cache tweets in Redis (1 hour)
- Compress responses with Brotli
- Paginate results (20 tweets per request)
- Index user_id and created_at in database

### 11.4 What is lazy loading and when is it useful?

**Answer:**
Lazy loading defers loading resources until needed. Improves initial page load time.

**Types:**
- **Image Lazy Loading**: Load images when visible in viewport
- **Code Splitting**: Load JavaScript modules on demand
- **Pagination**: Load next page when user scrolls

**Benefits:**
- Faster initial load
- Reduced bandwidth
- Better user experience

**Real-world Example:**
Instagram: Images load as you scroll. First 10 images load immediately, next 10 load when you scroll down.

### 11.5 How do you handle database query optimization?

**Answer:**
**Techniques:**
- **Indexing**: Create indexes on frequently queried columns
- **Query Analysis**: Use EXPLAIN to analyze query plans
- **Denormalization**: Store redundant data for faster reads
- **Caching**: Cache query results
- **Partitioning**: Split large tables
- **Connection Pooling**: Reuse connections
- **Batch Operations**: Reduce round trips

**Real-world Example:**
E-commerce database:
- Index on user_id, product_id, created_at
- Cache popular products in Redis
- Denormalize product count in category table
- Use connection pooling (max 100 connections)

---

## 12. API Design: REST vs GraphQL vs gRPC {#12-api-design-rest-vs-graphql-vs-grpc}

### 12.1 Compare REST, GraphQL, and gRPC with use cases

**Answer:**
| Feature | REST | GraphQL | gRPC |
|---------|------|---------|------|
| Protocol | HTTP/1.1 | HTTP/1.1 or HTTP/2 | HTTP/2 |
| Data Format | JSON | JSON | Protocol Buffers (binary) |
| Query Language | Fixed endpoints | Flexible queries | Predefined methods |
| Performance | Good | Good | Excellent |
| Bandwidth | Higher | Lower | Lowest |
| Learning Curve | Easy | Medium | Hard |
| Browser Support | Excellent | Good | Limited |
| Use Case | Public APIs | Complex queries | Internal services |

**Real-world Examples:**
- REST: Twitter, GitHub public APIs
- GraphQL: Facebook, GitHub GraphQL API
- gRPC: Google internal services, Kubernetes

### 12.2 What are RESTful best practices?

**Answer:**
**1. Resource-Based URLs:**
```
GET /users/123 - Get user
POST /users - Create user
PUT /users/123 - Update user
DELETE /users/123 - Delete user
```

**2. HTTP Status Codes:**
- 200: Success
- 201: Created
- 400: Bad Request
- 401: Unauthorized
- 404: Not Found
- 500: Server Error

**3. Consistent Naming:**
- Use plural nouns: /users not /user
- Use hyphens: /user-profiles not /userProfiles
- Use lowercase: /users not /Users

**4. Stateless:**
- Each request contains all information
- No session state on server

**5. Versioning:**
- /v1/users, /v2/users

**Real-world Example:**
GitHub API: `GET /repos/{owner}/{repo}/issues` follows all REST principles.

### 12.3 How do you version APIs?

**Answer:**
**Methods:**
1. **URL Versioning:** `/v1/users`, `/v2/users`
   - Pros: Clear, easy to understand
   - Cons: Duplicate code

2. **Header Versioning:** `Accept: application/vnd.api+json;version=1`
   - Pros: Clean URLs
   - Cons: Less discoverable

3. **Query Parameter:** `/users?version=1`
   - Pros: Simple
   - Cons: Messy URLs

4. **Content Negotiation:** Different response formats

**Best Practice:**
URL versioning is most common and discoverable.

**Real-world Example:**
Stripe API: `/v1/customers` - clear versioning in URL.

### 12.4 How do you handle pagination in APIs?

**Answer:**
**Methods:**
1. **Offset-based:**
```
GET /users?offset=20&limit=10
```
- Simple but slow for large offsets
- Problem: Skipped items if data changes

2. **Cursor-based:**
```
GET /users?cursor=abc123&limit=10
```
- Efficient, handles data changes
- Better for large datasets

3. **Keyset Pagination:**
```
GET /users?last_id=123&limit=10
```
- Efficient, works with sorting

**Best Practice:**
Use cursor-based for large datasets, offset-based for small datasets.

**Real-world Example:**
Twitter API uses cursor-based pagination for timeline (millions of tweets).

### 12.5 What are idempotent APIs and why are they important?

**Answer:**
Idempotent API: Multiple identical requests produce same result as single request.

**Idempotent Methods:**
- GET: Always returns same data
- PUT: Replace resource (same result)
- DELETE: Remove resource (idempotent)

**Non-Idempotent:**
- POST: Creates new resource each time (not idempotent)

**Why Important:**
- Network failures: Can retry safely
- Duplicate requests: No side effects
- Distributed systems: Ensures consistency

**Real-world Example:**
Payment API: `PUT /payments/123` is idempotent (updates same payment). `POST /payments` is not (creates new payment each time).

**Best Practice:**
Use idempotency keys for POST requests:
```
POST /payments
Idempotency-Key: unique-key-123
```
Server stores key, returns same result if duplicate request received.

---

## 13. Distributed Systems Basics {#13-distributed-systems-basics}

### 13.1 What are the challenges in distributed systems?

**Answer:**
**1. Network Failures:**
- Servers can't communicate
- Partial network partitions
- Solution: Timeouts, retries, circuit breakers

**2. Partial Failures:**
- Some components fail, others work
- Hard to detect (is server down or network slow?)
- Solution: Health checks, monitoring

**3. Data Consistency:**
- Keeping data synchronized across nodes
- Trade-off between consistency and availability
- Solution: Replication strategies, eventual consistency

**4. Latency:**
- Network delays between services
- Can't assume instant communication
- Solution: Caching, async processing

**5. Scalability:**
- Managing many components
- Coordination overhead
- Solution: Sharding, partitioning

**Real-world Example:**
AWS outage: Some regions fail, others work. Services must handle partial failures gracefully.

### 13.2 What is the difference between consistency and eventual consistency?

**Answer:**
**Strong Consistency:**
- All reads return most recent write
- Slower (must wait for all replicas)
- Used in: Banking, financial systems

**Eventual Consistency:**
- Reads may return stale data temporarily
- Faster (no waiting)
- Eventually all replicas converge
- Used in: Social media, caching

**Real-world Example:**
- Strong: Bank transfer (must be consistent)
- Eventual: Instagram like count (slight delay acceptable)

**Trade-off:**
Strong consistency = slower but accurate
Eventual consistency = faster but temporarily stale

### 13.3 How do you handle failures in distributed systems (retries, timeouts, circuit breakers)?

**Answer:**
**1. Retries:**
- Retry failed requests
- Exponential backoff: 1s, 2s, 4s, 8s
- Max retries: 3-5 times
- Idempotent operations only

**2. Timeouts:**
- Set maximum wait time
- Prevent hanging requests
- Typical: 5-30 seconds
- Fail fast instead of waiting forever

**3. Circuit Breaker:**
- Closed: Normal operation
- Open: Reject requests (service failing)
- Half-Open: Test if service recovered
- Prevents cascading failures

**Real-world Example:**
Payment Service fails:
- Retry 3 times with exponential backoff
- Timeout after 10 seconds
- Circuit breaker opens, returns error immediately
- After 30 seconds, try half-open state

### 13.4 What is the difference between horizontal and vertical scaling?

**Answer:**
**Vertical Scaling (Scale Up):**
- Add more power to existing machine
- More CPU, RAM, storage
- Pros: Simple, no code changes
- Cons: Limited by hardware, single point of failure, expensive

**Horizontal Scaling (Scale Out):**
- Add more machines
- Distribute load across servers
- Pros: Unlimited scalability, fault tolerance, cost-effective
- Cons: Complex, requires load balancing, data consistency

**Real-world Example:**
- Vertical: Upgrade server from 8GB to 64GB RAM
- Horizontal: Add 10 more servers to handle load

**When to Use:**
- Vertical: Small systems, simple applications
- Horizontal: Large systems, high traffic, microservices

### 13.5 How do you monitor distributed systems?

**Answer:**
**Metrics to Monitor:**
- **Latency**: Response time (p50, p95, p99)
- **Throughput**: Requests per second
- **Error Rate**: Failed requests percentage
- **CPU/Memory**: Resource utilization
- **Network**: Bandwidth, packet loss
- **Disk**: I/O, space usage

**Tools:**
- **Metrics**: Prometheus, Datadog, New Relic
- **Logging**: ELK Stack, Splunk, CloudWatch
- **Tracing**: Jaeger, Zipkin, DataDog
- **Alerting**: PagerDuty, Opsgenie

**Best Practices:**
- Centralized logging (all services log to one place)
- Distributed tracing (track request across services)
- Alerting on anomalies (not just thresholds)
- Dashboard for quick overview

**Real-world Example:**
Netflix monitoring:
- Prometheus scrapes metrics every 15 seconds
- Jaeger traces requests across 100+ services
- Alerts trigger if error rate > 1% or p99 latency > 500ms

---

**End of System Design Interview Guide**

This comprehensive guide covers all major system design topics with practical examples and real-world scenarios. Each section includes multiple questions with detailed answers focusing on explanation and practical application.


---

## Top 15 Most Asked System Design Questions

### Case Study 1: Design URL Shortener (TinyURL)

**Problem:** Create a service that converts long URLs to short URLs and redirects back.

**Key Requirements:**
- Generate unique short URLs
- Redirect short URL to original URL
- Handle millions of URLs
- Fast redirects (< 100ms)

**High-Level Design:**
1. **API Endpoints:**
   - POST /shorten → Generate short URL
   - GET /:shortCode → Redirect to original

2. **Database:**
   - NoSQL (MongoDB) for flexibility
   - Schema: {shortCode, originalUrl, createdAt, expiryDate}

3. **Short Code Generation:**
   - Base62 encoding (0-9, a-z, A-Z)
   - 6 characters = 62^6 ≈ 56 trillion URLs
   - Use counter + encoding or random generation

4. **Caching:**
   - Redis cache for popular URLs
   - Cache-Aside strategy

5. **Scalability:**
   - Horizontal scaling with load balancer
   - Database sharding by shortCode
   - CDN for redirects

**Real-world:** Bit.ly, TinyURL use this approach.

---

### Case Study 2: Design WhatsApp/Chat System

**Problem:** Real-time messaging system for millions of users.

**Key Requirements:**
- Send/receive messages in real-time
- Group chats
- Message history
- Online/offline status
- Typing indicators

**High-Level Design:**
1. **Real-time Communication:**
   - WebSockets for persistent connection
   - Socket.io or native WebSocket

2. **Message Storage:**
   - NoSQL (MongoDB) for messages
   - Schema: {senderId, receiverId, message, timestamp, status}

3. **User Status:**
   - Redis for online/offline status
   - Presence system with heartbeat

4. **Message Delivery:**
   - Acknowledgment system (sent, delivered, read)
   - Message queue for offline users

5. **Scalability:**
   - Horizontal scaling with sticky sessions
   - Message queue (Kafka) for reliability
   - Database sharding by userId

**Real-world:** WhatsApp handles 100 billion messages/day using this architecture.

---

### Case Study 3: Design Twitter/News Feed

**Problem:** Real-time feed showing tweets from followed users.

**Key Requirements:**
- Post tweets
- View feed from followed users
- Like, retweet, reply
- Handle millions of concurrent users

**High-Level Design:**
1. **Tweet Storage:**
   - NoSQL (MongoDB) for tweets
   - Schema: {tweetId, userId, content, timestamp, likes, retweets}

2. **Feed Generation:**
   - **Pull Model:** User fetches tweets when opening feed (simple, stale data)
   - **Push Model:** Tweets pushed to followers' feeds (complex, real-time)
   - **Hybrid:** Push for active users, pull for inactive

3. **Caching:**
   - Redis for feed cache
   - Cache top 1000 tweets per user

4. **Scalability:**
   - Horizontal scaling
   - Database sharding by userId
   - Message queue for async operations

5. **Consistency:**
   - Eventual consistency acceptable
   - Slight delay in feed updates acceptable

**Real-world:** Twitter uses hybrid push-pull model with heavy caching.

---

### Case Study 4: Design Uber/Ride-Hailing

**Problem:** Match riders with drivers in real-time.

**Key Requirements:**
- Find nearby drivers
- Match rider with driver
- Real-time location tracking
- Handle surge pricing

**High-Level Design:**
1. **Location Tracking:**
   - GPS updates every 5-10 seconds
   - Redis Geo for spatial queries
   - Find drivers within 5km radius

2. **Matching Algorithm:**
   - Find available drivers near rider
   - Calculate ETA
   - Assign driver with best match

3. **Database:**
   - SQL for rides (transactions needed)
   - NoSQL for driver locations
   - Schema: {rideId, riderId, driverId, pickupLocation, dropoffLocation, status}

4. **Real-time Updates:**
   - WebSockets for location updates
   - Push notifications for driver assignment

5. **Scalability:**
   - Horizontal scaling with load balancer
   - Database sharding by city/region
   - Message queue for ride events

**Real-world:** Uber processes 15 million rides/day using this architecture.

---

### Case Study 5: Design Instagram/Photo Sharing

**Problem:** Photo sharing platform with billions of images.

**Key Requirements:**
- Upload photos
- View feed
- Like, comment, follow
- Handle massive storage

**High-Level Design:**
1. **Photo Storage:**
   - Cloud storage (AWS S3) for images
   - CDN for fast delivery
   - Multiple sizes (thumbnail, medium, original)

2. **Metadata Storage:**
   - NoSQL (MongoDB) for photo metadata
   - Schema: {photoId, userId, caption, likes, comments, timestamp}

3. **Feed Generation:**
   - Similar to Twitter (push/pull hybrid)
   - Cache popular photos

4. **Image Processing:**
   - Async image resizing
   - Message queue for processing
   - Generate thumbnails on upload

5. **Scalability:**
   - Horizontal scaling
   - Database sharding by userId
   - CDN for global distribution

**Real-world:** Instagram stores 95 million photos/day using this approach.

---

### Case Study 6: Design YouTube/Netflix (Video Streaming)

**Problem:** Stream videos to millions of concurrent users.

**Key Requirements:**
- Upload videos
- Stream videos efficiently
- Handle different quality levels
- Minimize buffering

**High-Level Design:**
1. **Video Storage:**
   - Cloud storage (AWS S3) for videos
   - Multiple quality levels (480p, 720p, 1080p, 4K)

2. **Video Processing:**
   - Transcode videos to multiple formats
   - Message queue for async processing
   - Store in CDN for fast delivery

3. **Streaming:**
   - Adaptive bitrate streaming (HLS, DASH)
   - Adjust quality based on bandwidth
   - CDN for edge delivery

4. **Metadata:**
   - NoSQL for video metadata
   - Cache popular videos

5. **Scalability:**
   - CDN with edge servers globally
   - Database sharding by videoId
   - Horizontal scaling for API servers

**Real-world:** Netflix streams to 250 million users using this architecture.

---

### Case Study 7: Design Amazon/E-commerce

**Problem:** E-commerce platform with product catalog, shopping cart, orders.

**Key Requirements:**
- Browse products
- Shopping cart
- Checkout and payment
- Order tracking
- Inventory management

**High-Level Design:**
1. **Product Catalog:**
   - SQL database for structured data
   - Elasticsearch for search
   - Cache popular products

2. **Shopping Cart:**
   - Redis for session storage
   - Quick add/remove operations

3. **Orders:**
   - SQL database (ACID transactions needed)
   - Schema: {orderId, userId, items, total, status, timestamp}

4. **Payment:**
   - Third-party payment gateway
   - Idempotent payment processing

5. **Inventory:**
   - SQL database with locking
   - Real-time stock updates
   - Message queue for inventory events

6. **Scalability:**
   - Horizontal scaling with load balancer
   - Database replication for reads
   - Caching layer for products

**Real-world:** Amazon handles 300 million+ products and millions of orders/day.

---

### Case Study 8: Design Dropbox/Google Drive (File Storage)

**Problem:** Cloud file storage and sync system.

**Key Requirements:**
- Upload/download files
- Sync across devices
- Version history
- Share files
- Handle large files

**High-Level Design:**
1. **File Storage:**
   - Cloud storage (AWS S3) for files
   - Chunked upload for large files
   - Deduplication to save space

2. **Metadata:**
   - SQL database for file metadata
   - Schema: {fileId, userId, filename, size, timestamp, version}

3. **Sync:**
   - Track file changes
   - Sync to all devices
   - Conflict resolution

4. **Version History:**
   - Store multiple versions
   - Efficient storage with delta compression

5. **Sharing:**
   - Generate share links
   - Permission management

6. **Scalability:**
   - Horizontal scaling
   - Database sharding by userId
   - CDN for downloads

**Real-world:** Dropbox stores 500 billion+ files using this approach.

---

### Case Study 9: Design Parking Lot System

**Problem:** Manage parking lot with multiple levels and spots.

**Key Requirements:**
- Find available spots
- Reserve spot
- Track vehicle entry/exit
- Calculate parking fee

**High-Level Design:**
1. **Data Model:**
   - ParkingLot (levels, spots per level)
   - ParkingSpot (spotId, level, status, vehicleType)
   - ParkingTicket (tickleId, spotId, vehicleId, entryTime, exitTime)

2. **Find Available Spot:**
   - Search by vehicle type
   - Prefer closest spot
   - Return available spot or null

3. **Entry/Exit:**
   - Generate ticket on entry
   - Calculate fee on exit
   - Update spot status

4. **Database:**
   - SQL for structured data
   - Real-time spot availability

5. **Scalability:**
   - Multiple parking lots
   - Distributed system for large lots

**Real-world:** Smart parking systems use this design.

---

### Case Study 10: Design Vending Machine

**Problem:** Vending machine that dispenses items and accepts payment.

**Key Requirements:**
- Display items
- Accept payment
- Dispense item
- Track inventory
- Handle errors

**High-Level Design:**
1. **State Machine:**
   - Idle → Item Selected → Payment → Dispensing → Idle

2. **Components:**
   - Display: Show items and prices
   - Payment: Accept coins/cards
   - Dispenser: Release item
   - Inventory: Track stock

3. **Operations:**
   - selectItem(itemId)
   - acceptPayment(amount)
   - dispenseItem(itemId)
   - refund()

4. **Error Handling:**
   - Insufficient funds
   - Out of stock
   - Dispenser jam
   - Payment failure

**Real-world:** Modern vending machines use this design with remote monitoring.

---

### Case Study 11: Design Library Management System

**Problem:** Manage library books, members, and borrowing.

**Key Requirements:**
- Add/remove books
- Member registration
- Borrow/return books
- Track due dates
- Fine calculation

**High-Level Design:**
1. **Data Model:**
   - Book (bookId, title, author, isbn, copies)
   - Member (memberId, name, email, joinDate)
   - BorrowRecord (recordId, memberId, bookId, borrowDate, dueDate, returnDate)

2. **Operations:**
   - addBook(book)
   - registerMember(member)
   - borrowBook(memberId, bookId)
   - returnBook(recordId)
   - calculateFine(daysLate)

3. **Database:**
   - SQL for structured data
   - Queries for overdue books, member history

4. **Notifications:**
   - Email reminders for due dates
   - Fine notifications

**Real-world:** Library management systems use this design.

---

### Case Study 12: Design Chess Game

**Problem:** Online chess game with real-time moves.

**Key Requirements:**
- Two players play simultaneously
- Validate moves
- Track game state
- Handle disconnections
- Elo rating system

**High-Level Design:**
1. **Game State:**
   - Board representation (8x8 grid)
   - Piece positions
   - Move history
   - Current turn

2. **Move Validation:**
   - Check legal moves for piece
   - Detect check/checkmate
   - Validate move notation

3. **Real-time Communication:**
   - WebSockets for move updates
   - Broadcast moves to both players

4. **Database:**
   - SQL for game records
   - Schema: {gameId, player1Id, player2Id, moves, result, timestamp}

5. **Rating System:**
   - Elo rating calculation
   - Update ratings after game

**Real-world:** Chess.com handles millions of games using this design.

---

### Case Study 13: Design Restaurant Booking System

**Problem:** Online restaurant reservation system.

**Key Requirements:**
- Search restaurants
- Check availability
- Make reservations
- Cancel reservations
- Review restaurants

**High-Level Design:**
1. **Data Model:**
   - Restaurant (restaurantId, name, location, cuisine, capacity)
   - Table (tableId, restaurantId, capacity, location)
   - Reservation (reservationId, restaurantId, userId, tableId, date, time, partySize)

2. **Availability Check:**
   - Query available tables for date/time
   - Check capacity matches party size

3. **Booking:**
   - Reserve table
   - Send confirmation
   - Handle cancellations

4. **Database:**
   - SQL for structured data
   - Indexes on date/time for fast queries

5. **Scalability:**
   - Horizontal scaling
   - Cache popular restaurants
   - Database sharding by restaurantId

**Real-world:** OpenTable handles millions of reservations using this design.

---

### Case Study 14: Design Airline Reservation System

**Problem:** Book flights and manage reservations.

**Key Requirements:**
- Search flights
- Check seat availability
- Book seats
- Cancel bookings
- Handle overbooking

**High-Level Design:**
1. **Data Model:**
   - Flight (flightId, airline, departure, arrival, date, capacity)
   - Seat (seatId, flightId, seatNumber, status)
   - Booking (bookingId, flightId, userId, seats, status, timestamp)

2. **Search Flights:**
   - Query by departure, arrival, date
   - Show available seats

3. **Booking:**
   - Reserve seats
   - Process payment
   - Generate ticket

4. **Database:**
   - SQL for ACID transactions
   - Locking for seat availability

5. **Scalability:**
   - Horizontal scaling
   - Database sharding by flightId
   - Cache popular routes

**Real-world:** Airlines use this design for booking systems.

---

### Case Study 15: Design Hotel Booking System

**Problem:** Online hotel reservation system.

**Key Requirements:**
- Search hotels
- Check room availability
- Make reservations
- Manage cancellations
- Dynamic pricing

**High-Level Design:**
1. **Data Model:**
   - Hotel (hotelId, name, location, rating)
   - Room (roomId, hotelId, roomType, capacity, price)
   - Booking (bookingId, roomId, userId, checkIn, checkOut, status)

2. **Availability:**
   - Query available rooms for date range
   - Check room type and capacity

3. **Pricing:**
   - Base price + dynamic pricing
   - Surge pricing during peak season

4. **Database:**
   - SQL for structured data
   - Indexes on date range queries

5. **Scalability:**
   - Horizontal scaling
   - Cache popular hotels
   - Database sharding by hotelId

**Real-world:** Booking.com handles millions of reservations daily.

---

## Core System Design Interview Questions (Detailed)

### 1. Requirements & Capacity Estimation

#### 1.1 How do you gather functional and non-functional requirements for a system?

**Functional Requirements (What system does):**
- User registration and login
- Create, read, update, delete operations
- Search functionality
- Notifications

**Non-Functional Requirements (How system performs):**
- Scalability: Handle 1M concurrent users
- Latency: Response time < 200ms
- Availability: 99.99% uptime
- Consistency: Strong or eventual
- Security: Encryption, authentication

**Interview Tip:** Ask clarifying questions before designing. Don't assume requirements.

#### 1.2 How do you estimate traffic, storage, and bandwidth for your system?

**Traffic Estimation:**
- DAU (Daily Active Users): 100 million
- Requests per user per day: 10
- Total requests/day: 1 billion
- RPS (Requests Per Second): 1 billion / 86,400 ≈ 11,600 RPS

**Storage Estimation:**
- Data per request: 1 KB
- Total storage/day: 1 billion × 1 KB = 1 TB
- Annual storage: 1 TB × 365 = 365 TB

**Bandwidth Estimation:**
- Data per request: 100 KB
- RPS: 10,000
- Bandwidth: 100 KB × 10,000 = 1 GB/second

#### 1.3 What are DAU, MAU, and concurrent users and how do you calculate them?

**DAU (Daily Active Users):** Users active in a day
- Example: 100 million DAU

**MAU (Monthly Active Users):** Users active in a month
- Example: 500 million MAU
- Typically MAU = DAU × 5-10

**Concurrent Users:** Users online simultaneously
- Peak concurrent = DAU × (peak hours / 24) × (active users / total users)
- Example: 100M DAU × (4 hours / 24) × 0.5 = 8.3M concurrent users

#### 1.4 How do you handle peak traffic and seasonal spikes?

**Strategies:**
- Auto-scaling: Add servers during peak hours
- Caching: Reduce database load
- Rate limiting: Prevent abuse
- Queue systems: Buffer excess requests
- CDN: Distribute static content

**Real-world Example:**
Black Friday: E-commerce sites experience 10x normal traffic. Auto-scaling adds 10x servers temporarily.

#### 1.5 How do you calculate server requirements based on traffic estimates?

**Calculation:**
- RPS: 10,000
- Requests per server per second: 1,000
- Servers needed: 10,000 / 1,000 = 10 servers
- Add 2x for redundancy and failover: 20 servers

**Factors:**
- Server capacity (CPU, RAM)
- Response time requirements
- Redundancy needs
- Geographic distribution

---

### 2. Key Trade-offs & CAP Theorem

#### 2.1 Explain CAP Theorem with examples

**CAP Theorem:** Distributed system can guarantee only 2 of 3:
- **Consistency:** All nodes see same data
- **Availability:** System always responds
- **Partition Tolerance:** System works despite network failures

**CP (Consistency + Partition):**
- Example: Banking systems
- Sacrifice availability for consistency
- If network fails, system goes down rather than serve stale data

**AP (Availability + Partition):**
- Example: Social media
- Sacrifice consistency for availability
- System always responds, but data may be stale

**Real-world:** You can't have all 3. Network partitions happen, so choose between C and A.

#### 2.2 When would you choose consistency over availability (and vice versa)?

**Choose Consistency:**
- Banking (money transfer must be accurate)
- Payment processing (can't lose transactions)
- Inventory management (stock must be accurate)

**Choose Availability:**
- Social media (slight delay in updates acceptable)
- Video streaming (availability more important)
- Chat systems (eventual consistency acceptable)

#### 2.3 What is PACELC theorem and how does it extend CAP?

**PACELC:** If there's a Partition, choose Availability or Consistency; Else, choose Latency or Consistency.

**Extends CAP by addressing:**
- What happens when network is healthy?
- Trade-off between latency and consistency

**Example:**
- Partition: Choose AP (availability + partition tolerance)
- No Partition: Choose LC (low latency + consistency)

#### 2.4 How do you balance between consistency and performance?

**Strategies:**
- **Eventual Consistency:** Accept stale data for performance
- **Read Replicas:** Serve reads from replicas (stale data)
- **Caching:** Cache frequently accessed data
- **Async Processing:** Process updates asynchronously

**Real-world Example:**
YouTube: Video view count may be stale (eventual consistency) for performance. Exact count updated later.

#### 2.5 What are the trade-offs between SQL and NoSQL databases?

| Aspect | SQL | NoSQL |
|--------|-----|-------|
| Consistency | Strong (ACID) | Eventual (BASE) |
| Scalability | Vertical | Horizontal |
| Schema | Fixed | Flexible |
| Transactions | Multi-row | Limited |
| Performance | Slower writes | Faster writes |
| Use Case | Structured | Unstructured |

**Choose SQL:** Financial transactions, structured data
**Choose NoSQL:** User profiles, logs, unstructured data

---

### 3. Load Balancing & Caching

#### 3.1 What are different load balancing algorithms?

**Round Robin:**
- Distribute requests sequentially
- Simple but doesn't consider server load
- Use when servers have equal capacity

**Least Connections:**
- Send to server with fewest active connections
- Better for long-lived connections
- Use for WebSocket connections

**IP Hash:**
- Route based on client IP
- Ensures same client goes to same server
- Use for sticky sessions

**Weighted Round Robin:**
- Distribute based on server capacity
- Powerful servers get more requests
- Use for heterogeneous servers

**Random:**
- Random server selection
- Simple, works well with many servers

#### 3.2 How does consistent hashing work and why is it important?

**Problem:** With modulo hashing (key % n), adding/removing servers requires redistributing all keys.

**Solution:** Consistent hashing minimizes redistribution.

**How it works:**
1. Create hash ring (0 to 2^32)
2. Place servers on ring: hash(server_id)
3. Place keys on ring: hash(key)
4. Key assigned to next server clockwise

**Benefit:** Adding 1 server redistributes only ~1/n keys (n = number of servers).

**Real-world:** Memcached, Redis Cluster use consistent hashing.

#### 3.3 Explain different caching strategies

**Cache-Aside:**
- Application checks cache
- If miss, fetch from database
- Most common strategy

**Write-Through:**
- Write to cache and database simultaneously
- Ensures consistency
- Slower writes

**Write-Behind (Write-Back):**
- Write to cache first
- Asynchronously write to database
- Fast writes, risk of data loss

**Refresh-Ahead:**
- Proactively refresh cache before expiration
- Prevents cache misses
- Use for predictable access patterns

#### 3.4 What are cache eviction policies?

**LRU (Least Recently Used):**
- Remove least recently accessed item
- Most common
- Good for temporal locality

**LFU (Least Frequently Used):**
- Remove least frequently accessed item
- Better for popularity-based access

**TTL (Time To Live):**
- Expire after set time
- Simple, predictable
- May keep stale data

**FIFO (First In First Out):**
- Remove oldest item
- Simple but not optimal

#### 3.5 How do you handle cache invalidation and cache stampede?

**Cache Invalidation:**
- **Event-based:** Invalidate when data changes
- **TTL-based:** Expire after time
- **Manual:** Explicitly invalidate

**Cache Stampede:**
- Problem: Multiple requests miss cache simultaneously, all hit database
- Solution: Use lock or probabilistic early expiration

**Real-world Example:**
When user updates profile, invalidate their profile cache. Next request fetches fresh data.

---

### 4. Databases (SQL vs NoSQL, Replication, Sharding)

#### 4.1 When would you choose SQL vs NoSQL? Give examples

**SQL (PostgreSQL, MySQL):**
- Structured data with relationships
- ACID transactions required
- Complex queries needed
- Examples: Banking, E-commerce orders

**NoSQL (MongoDB, Cassandra):**
- Unstructured/semi-structured data
- Horizontal scalability needed
- High throughput required
- Examples: User profiles, Logs, Analytics

#### 4.2 What is database indexing and how does it work?

**Purpose:** Speed up data retrieval by creating sorted data structure.

**Types:**
- **B-Tree Index:** Most common, good for range queries
- **Hash Index:** Fast equality lookups
- **Full-Text Index:** Search text content

**Trade-off:**
- Pros: Faster reads
- Cons: Slower writes, more storage

**Real-world Example:**
Index on user_id speeds up "SELECT * FROM users WHERE user_id = 123" from O(n) to O(log n).

#### 4.3 Explain master-slave vs master-master replication

**Master-Slave:**
- One master (writes), multiple slaves (reads)
- Pros: Simple, consistent
- Cons: Master is bottleneck, single point of failure

**Master-Master:**
- Multiple masters (both read/write)
- Pros: Better availability, load distribution
- Cons: Complex conflict resolution, eventual consistency

**Real-world Example:**
- Master-Slave: Most common, used by Twitter
- Master-Master: Used when multiple regions need write capability

#### 4.4 What is database sharding and what are different sharding strategies?

**Sharding:** Partition data across multiple databases based on shard key.

**Strategies:**
- **Range-based:** Shard by value ranges (user IDs 1-1M, 1M-2M)
- **Hash-based:** Shard by hash of key (consistent hashing)
- **Directory-based:** Lookup table maps key to shard

**Challenges:**
- Uneven distribution (hot shards)
- Cross-shard queries are slow
- Resharding is complex

#### 4.5 How do you handle database migrations in production?

**Strategies:**
- **Blue-Green Deployment:** Run old and new schema simultaneously, switch when ready
- **Canary Deployment:** Migrate small percentage first, monitor, then full migration
- **Backward Compatibility:** New code works with old schema, migrate data gradually

**Real-world Example:**
Adding new column: Deploy code that handles both old and new schema, migrate data in background, remove old column later.

#### 4.6 What is denormalization and when would you use it?

**Denormalization:** Store redundant data to improve query performance.

**Trade-off:**
- Pros: Faster reads, simpler queries
- Cons: Slower writes, data inconsistency risk

**Real-world Example:**
Store user's follower count directly instead of counting followers each time. Update count when someone follows/unfollows.

---

### 5. Microservices vs Monolith

#### 5.1 When should you start with monolith vs microservices?

**Start with Monolith:**
- Early stage startup
- Small team
- Simple requirements
- Easier to develop and deploy

**Migrate to Microservices:**
- System becomes large and complex
- Different teams own different features
- Independent scaling needed
- Different technologies required

**Real-world Example:**
Amazon started monolithic, migrated to microservices as it grew. Netflix was microservices from start.

#### 5.2 What are the advantages and disadvantages of microservices?

**Advantages:**
- Independent scaling
- Technology flexibility
- Easier deployment
- Fault isolation

**Disadvantages:**
- Complex distributed system
- Network latency
- Data consistency challenges
- Operational complexity

#### 5.3 How do microservices communicate (Sync vs Async)?

**Synchronous (REST, gRPC):**
- Request-response pattern
- Immediate feedback
- Tight coupling
- Use for critical operations

**Asynchronous (Message Queue, Events):**
- Fire-and-forget
- Loose coupling
- Better scalability
- Use for non-critical operations

**Real-world Example:**
- Sync: User Service calls Payment Service to verify payment
- Async: Order Service publishes "OrderCreated" event, Notification Service subscribes

#### 5.4 What is service discovery and why is it needed?

**Problem:** In microservices, services are dynamic (added/removed). How do services find each other?

**Solution:** Service discovery maintains registry of available services.

**Types:**
- **Client-side:** Client queries registry, calls service directly
- **Server-side:** Client calls load balancer, which queries registry

**Real-world Example:**
Kubernetes service discovery: Services register with Kubernetes, others discover via DNS.

#### 5.5 How do you handle distributed transactions in microservices (SAGA pattern)?

**Problem:** Multi-service transaction (Order → Payment → Inventory) may partially fail.

**SAGA Pattern:**
- **Choreography:** Services listen to events and react
- **Orchestration:** Central coordinator manages transaction

**Example (Choreography):**
1. Order Service creates order, publishes "OrderCreated"
2. Payment Service listens, processes payment, publishes "PaymentProcessed"
3. Inventory Service listens, updates inventory, publishes "InventoryUpdated"

**Rollback:** If Payment fails, publish "PaymentFailed", Order Service compensates (cancels order).

---

### 6. Message Queues & Event-Driven Architecture

#### 6.1 What are message queues and when would you use them?

**Message Queue:** Asynchronous communication system. Services send messages to queue, consumers process later.

**Benefits:**
- Decoupling services
- Asynchronous processing
- Fault tolerance
- Load leveling

**When to use:**
- Async operations (email, notifications)
- Load leveling (handle traffic spikes)
- Fault tolerance (retry failed messages)

#### 6.2 Compare RabbitMQ, Kafka, and AWS SQS

| Feature | RabbitMQ | Kafka | SQS |
|---------|----------|-------|-----|
| Type | Message Broker | Event Streaming | Managed Queue |
| Throughput | Medium | Very High | High |
| Persistence | Optional | Persistent | Persistent |
| Ordering | Per queue | Per partition | FIFO queue |
| Use Case | Task queues | Event streaming | Simple queues |

**Choose:**
- RabbitMQ: Traditional task queues
- Kafka: Event streaming, high throughput
- SQS: AWS-based, managed service

#### 6.3 What is the difference between point-to-point and pub-sub?

**Point-to-Point:**
- One sender, one receiver
- Message consumed once
- Use for task queues

**Pub-Sub:**
- One publisher, multiple subscribers
- Message consumed by all subscribers
- Use for events

**Real-world Example:**
- Point-to-Point: Email queue (one email per recipient)
- Pub-Sub: Tweet published (all followers notified)

#### 6.4 What is event-driven architecture and how does it differ from request-driven?

**Request-Driven:**
- Client sends request, waits for response
- Synchronous
- Tight coupling

**Event-Driven:**
- Service publishes event, others react
- Asynchronous
- Loose coupling

**Real-world Example:**
- Request-Driven: User Service calls Payment Service directly
- Event-Driven: Order Service publishes "OrderCreated", Payment Service subscribes

#### 6.5 How do you guarantee message delivery (at-least-once, exactly-once)?

**At-Least-Once:**
- Message delivered at least once
- May have duplicates
- Use idempotent processing

**Exactly-Once:**
- Message delivered exactly once
- Complex to implement
- Use distributed transactions

**Implementation:**
- Idempotent IDs: Track processed messages
- Deduplication: Remove duplicate messages
- Transactions: Atomic processing

**Real-world Example:**
Kafka: Use idempotent producer + consumer offset management for exactly-once semantics.

---

**End of Top 15 Most Asked Questions & Core System Design Topics**

This comprehensive section covers the most frequently asked system design questions in interviews with detailed explanations, real-world examples, and practical strategies for each topic.


---

## Top 15 Most Asked System Design Questions (Detailed Case Studies)

### 11. Design URL Shortener (TinyURL) {#11-design-url-shortener-tinyurl}

#### 11.1 How would you generate unique short URLs?

**Answer:**
**Approaches:**

1. **Base62 Encoding:**
   - Convert auto-increment ID to base62 (0-9, a-z, A-Z)
   - ID 1 → "a", ID 62 → "10", ID 3844 → "100"
   - Pros: Deterministic, no collisions
   - Cons: Sequential (predictable)

2. **Random Generation:**
   - Generate random 6-8 character string
   - Check if exists in database
   - Pros: Non-sequential, harder to guess
   - Cons: Need collision handling

3. **Hashing:**
   - Hash original URL with salt
   - Take first 6 characters
   - Pros: Same URL always generates same short URL
   - Cons: Collisions possible

**Real-world Example:**
TinyURL uses base62 encoding with auto-increment IDs. Bit.ly uses random generation with collision detection.

#### 11.2 How do you handle collisions in URL generation?

**Answer:**
**Collision Handling:**

1. **Retry with Different Seed:**
   - Generate new random string
   - Check database again
   - Repeat until unique found

2. **Append Counter:**
   - If collision, append counter (url-1, url-2)
   - Increment until unique

3. **Use Distributed ID Generator:**
   - Snowflake ID (Twitter's approach)
   - Generates globally unique IDs
   - No collisions by design

**Real-world Example:**
Bit.ly: If random collision occurs, retry with different seed. Probability of collision with 6 chars = 1 in 56 billion.

#### 11.3 What database would you choose and why?

**Answer:**
**SQL Database (PostgreSQL/MySQL):**
- Pros: ACID transactions, strong consistency, good for lookups
- Cons: Slower writes at scale, vertical scaling limits

**NoSQL Database (Redis/Memcached):**
- Pros: Fast reads/writes, horizontal scaling
- Cons: No transactions, eventual consistency

**Hybrid Approach (Recommended):**
- **Primary:** PostgreSQL for durability and consistency
- **Cache:** Redis for fast lookups (99% reads)
- **Analytics:** Cassandra for click tracking (time-series)

**Schema:**
```
urls table:
- id (primary key)
- short_code (unique index)
- original_url
- created_at
- expires_at
- user_id
```

**Real-world Example:**
TinyURL uses MySQL for main storage, Redis for caching hot URLs.

#### 11.4 How do you handle redirection with low latency?

**Answer:**
**Optimization Strategies:**

1. **Caching Layer:**
   - Cache hot URLs in Redis
   - TTL: 24 hours
   - Hit rate: 80-90%

2. **Database Indexing:**
   - Index on short_code for O(1) lookup
   - Partition by creation date

3. **CDN for Static Redirects:**
   - Cache redirect responses at edge
   - Serve from nearest location

4. **Connection Pooling:**
   - Reuse database connections
   - Reduce connection overhead

**Latency Targets:**
- Cache hit: < 5ms
- Database hit: < 50ms
- P99 latency: < 100ms

**Real-world Example:**
Bit.ly: 95% cache hit rate, average latency 8ms.

#### 11.5 How would you implement analytics (click tracking)?

**Answer:**
**Analytics Pipeline:**

1. **Event Capture:**
   - Log click event asynchronously
   - Include: timestamp, user_id, IP, user_agent, referrer

2. **Event Queue:**
   - Use Kafka/RabbitMQ for buffering
   - Prevents blocking redirect response

3. **Analytics Storage:**
   - Cassandra for time-series data (optimized for writes)
   - Schema: (short_code, timestamp) → click_count

4. **Aggregation:**
   - Batch process every hour
   - Calculate: total clicks, unique users, geographic distribution

**Real-world Example:**
```
Click event:
{
  short_code: "abc123",
  timestamp: 1234567890,
  user_id: "user_456",
  country: "US",
  device: "mobile"
}
```

#### 11.6 How do you handle custom aliases?

**Answer:**
**Custom Alias Implementation:**

1. **Validation:**
   - Check if alias already exists
   - Validate format (alphanumeric, 3-20 chars)
   - Reserve keywords (admin, api, etc.)

2. **Storage:**
   - Store in same table with flag: is_custom = true
   - Unique constraint on short_code

3. **Pricing Model:**
   - Free users: Auto-generated only
   - Premium users: Custom aliases allowed

**Real-world Example:**
Bit.ly: Custom aliases for premium users. Example: bit.ly/mycompany instead of bit.ly/abc123.

#### 11.7 How would you scale this system to handle billions of URLs?

**Answer:**
**Scaling Strategies:**

1. **Database Sharding:**
   - Shard by short_code hash
   - 1000 shards for billions of URLs
   - Each shard handles ~1M URLs

2. **Read Replicas:**
   - Master for writes
   - Multiple replicas for reads
   - Distribute read load

3. **Caching Hierarchy:**
   - L1: Local cache (in-process)
   - L2: Redis cluster
   - L3: Database

4. **Async Processing:**
   - Analytics in background
   - Don't block redirect response

5. **CDN:**
   - Cache redirects at edge
   - Reduce origin load

**Architecture:**
```
Client → Load Balancer → API Servers (100+)
         ↓
    Redis Cluster (10 nodes)
         ↓
    Database Shards (1000 shards)
         ↓
    CDN Edge Servers
```

**Real-world Example:**
Bit.ly handles 600M+ URLs with sharded PostgreSQL, Redis cluster, and CDN.

#### 11.8 How do you handle URL expiration and cleanup?

**Answer:**
**Expiration Strategy:**

1. **TTL in Database:**
   - Store expires_at timestamp
   - Check on redirect (lazy deletion)

2. **Batch Cleanup:**
   - Run daily job to delete expired URLs
   - Delete in batches (1000 at a time)
   - Avoid locking entire table

3. **Soft Delete:**
   - Mark as deleted instead of removing
   - Easier to recover if needed
   - Separate cleanup job

**Implementation:**
```
Cleanup job (daily at 2 AM):
- Find URLs where expires_at < NOW()
- Delete in batches of 1000
- Log deleted count
- Alert if > 100K deleted
```

**Real-world Example:**
TinyURL: URLs expire after 30 days of inactivity. Cleanup runs nightly.


### 12. Design WhatsApp/Chat System {#12-design-whatsappchat-system}

#### 12.1 How do you handle real-time message delivery?

**Answer:**
**Real-time Delivery Architecture:**

1. **WebSocket Connection:**
   - Persistent connection between client and server
   - Bidirectional communication
   - Low latency (< 100ms)

2. **Message Queue:**
   - Kafka/RabbitMQ for message buffering
   - Ensures no message loss
   - Handles traffic spikes

3. **Connection Manager:**
   - Track active connections per user
   - Route messages to correct server
   - Handle disconnections gracefully

**Flow:**
```
Sender → API Server → Message Queue → Connection Manager
                                    ↓
                            Receiver's WebSocket
```

**Real-world Example:**
WhatsApp: 100+ million concurrent connections using custom protocol over TCP.

#### 12.2 How do you ensure message ordering in chats?

**Answer:**
**Message Ordering Strategies:**

1. **Sequence Numbers:**
   - Assign monotonic sequence to each message
   - Client stores last_seq_received
   - Request missing messages if gap detected

2. **Timestamps:**
   - Use server-generated timestamps
   - Receiver sorts by timestamp
   - Handle clock skew with NTP

3. **Single Writer Principle:**
   - One server handles all messages for conversation
   - Ensures ordering
   - Failover to replica if needed

**Implementation:**
```
Message schema:
{
  message_id: UUID,
  conversation_id: UUID,
  sender_id: UUID,
  sequence_number: 12345,
  timestamp: 1234567890,
  content: "Hello",
  status: "sent"
}
```

**Real-world Example:**
Telegram: Uses sequence numbers per conversation. If gap detected, client requests missing messages.

#### 12.3 How do you handle offline users and message sync?

**Answer:**
**Offline Message Handling:**

1. **Message Storage:**
   - Store messages in database for offline users
   - TTL: 30 days
   - Index by user_id for fast retrieval

2. **Sync on Reconnect:**
   - Client sends last_sync_timestamp
   - Server returns all messages since then
   - Pagination: 100 messages per request

3. **Notification:**
   - Send push notification for offline messages
   - Include message preview
   - Tap to open app

**Flow:**
```
User offline → Message stored in DB → Push notification sent
User comes online → Request sync → Receive all pending messages
```

**Real-world Example:**
WhatsApp: Stores messages for 30 days. When user comes online, syncs all pending messages.

#### 12.4 How would you implement group chats?

**Answer:**
**Group Chat Architecture:**

1. **Group Management:**
   - Store group metadata (name, members, created_at)
   - Track member join/leave events
   - Admin permissions

2. **Message Distribution:**
   - Fanout to all group members
   - Use message queue for reliability
   - Handle large groups (1000+ members)

3. **Scalability:**
   - For large groups, use topic-based pub-sub
   - Kafka topic per group
   - Members subscribe to group topic

**Schema:**
```
groups table:
- group_id
- name
- created_by
- created_at

group_members table:
- group_id
- user_id
- joined_at
- role (admin, member)

group_messages table:
- message_id
- group_id
- sender_id
- content
- timestamp
```

**Real-world Example:**
WhatsApp: Supports groups up to 256 members. Uses fanout for message distribution.

#### 12.5 How do you handle delivery receipts (sent, delivered, read)?

**Answer:**
**Receipt States:**

1. **Sent:** Message reached server
2. **Delivered:** Message reached recipient's device
3. **Read:** User opened and read message

**Implementation:**

1. **Sent Receipt:**
   - Server acknowledges message received
   - Send ACK to sender immediately

2. **Delivered Receipt:**
   - Recipient's device confirms receipt
   - Send delivery receipt to sender
   - Update message status in DB

3. **Read Receipt:**
   - User opens chat
   - Send read receipt for all messages
   - Update message status

**Flow:**
```
Sender sends message
    ↓
Server receives (Sent)
    ↓
Recipient receives (Delivered)
    ↓
User opens chat (Read)
    ↓
Sender sees all three receipts
```

**Real-world Example:**
WhatsApp: Shows single check (sent), double check (delivered), blue double check (read).

#### 12.6 How would you implement end-to-end encryption?

**Answer:**
**E2E Encryption Implementation:**

1. **Key Exchange:**
   - Use Signal Protocol (Double Ratchet Algorithm)
   - Exchange public keys via server
   - Generate session keys

2. **Message Encryption:**
   - Encrypt on sender's device
   - Server stores encrypted message
   - Only recipient can decrypt

3. **Key Rotation:**
   - Rotate keys periodically
   - Forward secrecy: Old keys can't decrypt new messages
   - Backward secrecy: New keys can't decrypt old messages

**Flow:**
```
Sender: plaintext → encrypt with recipient's public key → ciphertext
Server: store ciphertext (can't read)
Recipient: ciphertext → decrypt with private key → plaintext
```

**Real-world Example:**
WhatsApp: Uses Signal Protocol. Messages encrypted end-to-end, server can't read.

#### 12.7 How do you handle media sharing (images, videos)?

**Answer:**
**Media Handling Pipeline:**

1. **Upload:**
   - Client uploads to object storage (S3)
   - Generate thumbnail
   - Send message with media URL

2. **Processing:**
   - Compress image/video
   - Generate multiple resolutions
   - Scan for malware

3. **Delivery:**
   - Serve from CDN
   - Adaptive bitrate for video
   - Progressive download

**Architecture:**
```
Client → Upload to S3 → Lambda processes → CDN caches → Recipient downloads
```

**Real-world Example:**
WhatsApp: Compresses images to 100KB, videos to 5MB. Serves from CDN.

#### 12.8 How would you scale for millions of concurrent connections?

**Answer:**
**Scaling Strategies:**

1. **Connection Servers:**
   - Stateless API servers
   - Each handles 10K connections
   - 100K servers for 1B connections

2. **Load Balancing:**
   - Distribute connections across servers
   - Sticky sessions (same user → same server)
   - Health checks for failover

3. **Message Queue:**
   - Kafka for message buffering
   - Prevents message loss
   - Handles traffic spikes

4. **Database:**
   - Sharded by user_id
   - Read replicas for queries
   - Cassandra for message storage

5. **Caching:**
   - Redis for active conversations
   - Cache user presence
   - Cache group metadata

**Architecture:**
```
Millions of clients
    ↓
Load Balancer
    ↓
Connection Servers (100K+)
    ↓
Message Queue (Kafka)
    ↓
Database Shards (1000+)
    ↓
Cache Layer (Redis)
```

**Real-world Example:**
WhatsApp: 100+ million concurrent connections across 50+ data centers globally.


### 13. Design Twitter/News Feed {#13-design-twitternews-feed}

#### 13.1 How would you generate a user's timeline/news feed?

**Answer:**
**Feed Generation Approaches:**

1. **Pull Model (On-Demand):**
   - When user opens feed, query all followed users' tweets
   - Pros: Always fresh, no storage overhead
   - Cons: Slow (multiple DB queries), high latency

2. **Push Model (Fanout):**
   - When user tweets, push to all followers' feeds
   - Pros: Fast reads, pre-computed
   - Cons: Storage overhead, slow writes

3. **Hybrid Model (Recommended):**
   - Push for normal users (< 10K followers)
   - Pull for celebrities (> 10K followers)
   - Reduces storage, maintains performance

**Real-world Example:**
Twitter uses hybrid: Push for regular users, Pull for celebrities like @Obama.

#### 13.2 What is the difference between push (fanout) and pull models?

**Answer:**
| Aspect | Push (Fanout) | Pull |
|--------|---------------|------|
| Write Latency | High (fanout to all followers) | Low (just store tweet) |
| Read Latency | Low (pre-computed) | High (query on demand) |
| Storage | High (duplicate per follower) | Low (single copy) |
| Best For | Regular users | Celebrities |
| Example | Your tweets | @Obama's tweets |

**Push Model Flow:**
```
User tweets → Store tweet → Fanout to all followers' feeds → Followers see instantly
```

**Pull Model Flow:**
```
User tweets → Store tweet → Followers query on demand → Followers see after query
```

**Real-world Example:**
Twitter: Uses push for 99% of users, pull for top 1% (celebrities).

#### 13.3 How do you handle celebrities with millions of followers?

**Answer:**
**Celebrity Handling:**

1. **Identify Celebrities:**
   - Users with > 10K followers
   - Flag in database

2. **Pull Model for Celebrities:**
   - Don't fanout tweets
   - Followers pull tweets on demand
   - Reduces write load

3. **Caching:**
   - Cache celebrity tweets in Redis
   - TTL: 1 hour
   - High hit rate (popular tweets)

4. **Hybrid Feed:**
   - Show pushed tweets from regular users
   - Show pulled tweets from celebrities
   - Merge and sort by timestamp

**Real-world Example:**
@Obama has 130M followers. Pushing to all would be 130M writes. Instead, followers pull tweets on demand.

#### 13.4 How would you implement ranking/trending algorithm?

**Answer:**
**Ranking Factors:**

1. **Engagement:**
   - Likes, retweets, replies
   - Weight: 40%

2. **Recency:**
   - Newer tweets ranked higher
   - Decay over time
   - Weight: 30%

3. **Social Graph:**
   - Tweets from close friends ranked higher
   - Weight: 20%

4. **Personalization:**
   - User's interests and history
   - Weight: 10%

**Ranking Formula:**
```
score = (likes × 2 + retweets × 3 + replies × 1) × recency_decay × social_weight × personalization
```

**Real-world Example:**
Twitter's algorithm: Prioritizes engagement and recency. Shows tweets with high engagement first.

#### 13.5 How do you store and retrieve tweets efficiently?

**Answer:**
**Storage Strategy:**

1. **Primary Storage:**
   - Cassandra for tweets (time-series optimized)
   - Partition by user_id and date
   - Sorted by timestamp (descending)

2. **Indexing:**
   - Index on user_id for user's tweets
   - Index on hashtags for search
   - Index on created_at for timeline

3. **Retrieval:**
   - Query: tweets WHERE user_id = X ORDER BY created_at DESC LIMIT 20
   - Pagination: Use keyset pagination (last_tweet_id)

**Schema:**
```
tweets table:
- tweet_id (primary key)
- user_id (partition key)
- created_at (sort key)
- content
- likes_count
- retweets_count
- media_urls
```

**Real-world Example:**
Twitter: Stores 500M+ tweets daily in Cassandra. Retrieves 20 tweets per page.

#### 13.6 How would you implement search functionality?

**Answer:**
**Search Implementation:**

1. **Full-Text Search:**
   - Use Elasticsearch for indexing
   - Index: tweet content, hashtags, mentions
   - Real-time indexing

2. **Search Query:**
   - Parse query (keywords, hashtags, mentions)
   - Query Elasticsearch
   - Rank by relevance and recency

3. **Caching:**
   - Cache popular searches
   - TTL: 1 hour
   - Reduce Elasticsearch load

**Real-world Example:**
Twitter Search: Elasticsearch indexes all tweets. Searches return results in < 100ms.

#### 13.7 How do you handle real-time updates to feeds?

**Answer:**
**Real-time Updates:**

1. **WebSocket Connection:**
   - Persistent connection to server
   - Server pushes new tweets
   - Low latency (< 100ms)

2. **Event Stream:**
   - Use Kafka for tweet events
   - Subscribers listen to topics
   - Distribute to followers

3. **Notification:**
   - Notify followers of new tweets
   - Update feed in real-time
   - Show "New tweets" button

**Flow:**
```
User tweets → Kafka event → Followers' servers → WebSocket push → Real-time update
```

**Real-world Example:**
Twitter: Uses WebSocket for real-time feed updates. New tweets appear instantly.

#### 13.8 How would you design the follow/unfollow feature?

**Answer:**
**Follow/Unfollow Implementation:**

1. **Data Model:**
   - followers table: (follower_id, following_id)
   - following table: (user_id, followed_id)
   - Bidirectional for efficiency

2. **Follow Operation:**
   - Add to followers table
   - Add to following table
   - Update follower count
   - Trigger fanout if using push model

3. **Unfollow Operation:**
   - Remove from followers table
   - Remove from following table
   - Update follower count
   - Stop fanout

4. **Caching:**
   - Cache follower list in Redis
   - TTL: 1 day
   - Invalidate on follow/unfollow

**Real-world Example:**
Twitter: Stores follow relationships in MySQL. Caches in Redis for fast lookups.


### 14. Design Uber/Ride-Hailing {#14-design-uberride-hailing}

#### 14.1 How do you match riders with nearby drivers?

**Answer:**
**Matching Algorithm:**

1. **Location Indexing:**
   - Use geospatial index (R-tree, Quadtree)
   - Store driver locations in Redis Geo
   - Query: Find drivers within 5km radius

2. **Matching Logic:**
   - Find available drivers near rider
   - Filter by rating (> 4.5 stars)
   - Sort by distance
   - Assign closest driver

3. **Optimization:**
   - Batch matching every 100ms
   - Predict driver movement
   - Consider traffic patterns

**Real-world Example:**
Uber: Uses geospatial indexing to find drivers within 2km. Matches in < 10 seconds.

#### 14.2 How do you handle real-time location tracking?

**Answer:**
**Location Tracking System:**

1. **GPS Updates:**
   - Driver sends location every 5 seconds
   - Rider sends location every 10 seconds
   - Use WebSocket for real-time updates

2. **Storage:**
   - Redis Geo for current locations
   - Cassandra for historical data
   - TTL: 24 hours

3. **Broadcasting:**
   - Rider sees driver's real-time location
   - Driver sees rider's location
   - Update map every 2 seconds

**Flow:**
```
Driver's phone → GPS → Server → Redis Geo → Rider's app (real-time map)
```

**Real-world Example:**
Uber: Drivers send location every 5 seconds. Riders see real-time location on map.

#### 14.3 How would you implement surge pricing?

**Answer:**
**Surge Pricing Algorithm:**

1. **Demand Calculation:**
   - Count ride requests in last 5 minutes
   - Calculate demand ratio: requests / available_drivers

2. **Surge Multiplier:**
   - 1.0x: Normal (demand = supply)
   - 1.5x: High demand (2x requests vs drivers)
   - 2.0x: Very high demand (3x requests vs drivers)
   - 3.0x+: Extreme demand (peak hours)

3. **Price Calculation:**
   - Base fare × surge_multiplier
   - Update every 5 minutes
   - Notify users of surge pricing

**Real-world Example:**
Uber: During New Year's Eve, surge multiplier reaches 5x. Base fare $10 becomes $50.

#### 14.4 How do you calculate ETA for rides?

**Answer:**
**ETA Calculation:**

1. **Route Calculation:**
   - Use Google Maps API
   - Get distance and estimated time
   - Account for traffic

2. **Factors:**
   - Current traffic conditions
   - Time of day
   - Historical data
   - Weather

3. **Accuracy:**
   - Update ETA every 30 seconds
   - Adjust based on actual progress
   - Show range: 8-12 minutes

**Formula:**
```
ETA = base_time × traffic_factor × time_of_day_factor
```

**Real-world Example:**
Uber: Calculates ETA using Google Maps + historical traffic data. Accuracy: ±2 minutes.

#### 14.5 How would you handle ride lifecycle (request, accept, start, end)?

**Answer:**
**Ride States:**

1. **Requested:**
   - Rider requests ride
   - System finds nearby drivers
   - Send notifications

2. **Accepted:**
   - Driver accepts ride
   - Rider sees driver info and location
   - Driver navigates to pickup

3. **Arrived:**
   - Driver reaches pickup location
   - Notify rider
   - Start timer (5 min wait)

4. **Started:**
   - Rider gets in car
   - Driver starts navigation
   - Meter running

5. **Completed:**
   - Driver reaches destination
   - Calculate fare
   - Request payment
   - Rate driver

**State Machine:**
```
Requested → Accepted → Arrived → Started → Completed
```

**Real-world Example:**
Uber: Tracks ride state in real-time. Updates both rider and driver.

#### 14.6 How do you handle payments and fare calculation?

**Answer:**
**Fare Calculation:**

1. **Base Components:**
   - Base fare: $2.50
   - Per-mile: $1.50/mile
   - Per-minute: $0.35/minute
   - Surge multiplier: 1.0x - 5.0x

2. **Formula:**
   ```
   fare = (base + distance × per_mile + time × per_minute) × surge_multiplier
   ```

3. **Payment Processing:**
   - Store payment method (credit card, wallet)
   - Charge after ride completion
   - Handle failed payments (retry 3 times)
   - Send receipt

4. **Refunds:**
   - Rider cancels before driver arrives: No charge
   - Rider cancels after driver arrives: $5 cancellation fee
   - Driver cancels: Rider not charged

**Real-world Example:**
Uber: 5-mile ride at 2x surge = (2.50 + 5×1.50 + 10×0.35) × 2 = $27.

#### 14.7 How would you design for high availability during peak hours?

**Answer:**
**High Availability Design:**

1. **Horizontal Scaling:**
   - Auto-scale servers during peak hours
   - Add 10x servers during rush hour
   - Remove after peak

2. **Database Replication:**
   - Master-slave replication
   - Read replicas for queries
   - Failover to replica if master fails

3. **Caching:**
   - Cache driver locations in Redis
   - Cache popular routes
   - Reduce database load

4. **Circuit Breaker:**
   - If payment service down, queue payments
   - If maps service down, use cached routes
   - Graceful degradation

5. **Load Balancing:**
   - Distribute across multiple regions
   - Sticky sessions for driver-rider connection
   - Health checks for failover

**Real-world Example:**
Uber: During peak hours, scales to 100K+ servers. Maintains 99.99% availability.

#### 14.8 How do you handle driver availability and dispatching?

**Answer:**
**Driver Availability:**

1. **Driver States:**
   - Offline: Not working
   - Online: Available for rides
   - On Ride: Currently with passenger
   - Break: Taking break

2. **Availability Tracking:**
   - Store in Redis with TTL
   - Update every 5 seconds
   - Expire if no update (driver offline)

3. **Dispatching Algorithm:**
   - Find available drivers near rider
   - Consider driver rating and acceptance rate
   - Assign to closest driver
   - Timeout: 30 seconds (reassign if no response)

4. **Optimization:**
   - Predict driver movement
   - Pre-match drivers before request
   - Batch matching every 100ms

**Real-world Example:**
Uber: Maintains 1M+ available drivers at peak hours. Matches riders in < 10 seconds.


### 15. Design Instagram/Photo Sharing {#15-design-instagramphoto-sharing}

#### 15.1 How would you store and serve photos efficiently?

**Answer:**
**Photo Storage Architecture:**

1. **Object Storage:**
   - Use S3 for durability and scalability
   - Store original photo
   - Generate multiple sizes (thumbnail, medium, large)

2. **CDN Distribution:**
   - CloudFront for global distribution
   - Cache photos at edge servers
   - Serve from nearest location

3. **Storage Optimization:**
   - Compress images (JPEG quality 85%)
   - Generate WebP format for modern browsers
   - Lazy load images

4. **Sizes Generated:**
   - Thumbnail: 150x150px (10KB)
   - Medium: 600x600px (50KB)
   - Large: 1200x1200px (200KB)
   - Original: Uncompressed (2-5MB)

**Real-world Example:**
Instagram: Stores 100B+ photos in S3. Serves from CloudFront. Average photo size: 100KB.

#### 15.2 How do you handle photo uploads and processing?

**Answer:**
**Upload Pipeline:**

1. **Upload:**
   - Client uploads to S3 directly (pre-signed URL)
   - Reduces server load
   - Parallel upload for large files

2. **Processing Queue:**
   - Lambda triggered on S3 upload
   - Generate thumbnails and sizes
   - Scan for inappropriate content

3. **Processing Steps:**
   - Resize to multiple sizes
   - Compress with ImageMagick
   - Generate WebP format
   - Extract metadata (EXIF)

4. **Storage:**
   - Store processed images in S3
   - Update database with URLs
   - Invalidate CDN cache

**Flow:**
```
Client → S3 upload → Lambda trigger → Process images → Store in S3 → Update DB → CDN cache
```

**Real-world Example:**
Instagram: Processes 350M+ photos daily. Average processing time: 2 seconds per photo.

#### 15.3 How would you implement user feeds?

**Answer:**
**Feed Generation:**

1. **Push Model:**
   - When user posts, push to all followers' feeds
   - Store in Redis sorted set
   - Key: user_id, Value: photo_id, Score: timestamp

2. **Feed Retrieval:**
   - Query Redis for user's feed
   - Get last 20 photos
   - Pagination: Use timestamp as cursor

3. **Caching:**
   - Cache feed in Redis
   - TTL: 1 hour
   - Invalidate on new post

4. **Ranking:**
   - Sort by timestamp (newest first)
   - Consider engagement (likes, comments)
   - Personalize based on user interests

**Real-world Example:**
Instagram: Uses push model for regular users. Feed loads in < 500ms.

#### 15.4 How do you handle likes and comments?

**Answer:**
**Likes Implementation:**

1. **Like Storage:**
   - Store in database: (user_id, photo_id, timestamp)
   - Index on photo_id for fast count
   - Cache like count in Redis

2. **Like Count:**
   - Increment counter on like
   - Decrement on unlike
   - Update cache immediately

3. **Like Feed:**
   - Show who liked the photo
   - Query: SELECT user_id FROM likes WHERE photo_id = X LIMIT 10

**Comments Implementation:**

1. **Comment Storage:**
   - Store in database: (comment_id, photo_id, user_id, content, timestamp)
   - Index on photo_id for retrieval

2. **Comment Retrieval:**
   - Paginate: 20 comments per page
   - Sort by timestamp (newest first)
   - Cache popular comments

3. **Notifications:**
   - Notify photo owner of new comments
   - Notify users mentioned in comments
   - Use push notifications

**Real-world Example:**
Instagram: 95M+ likes per day. Comments cached in Redis for fast retrieval.

#### 15.5 How would you implement the explore/recommendation feature?

**Answer:**
**Recommendation Algorithm:**

1. **Collaborative Filtering:**
   - Find users with similar interests
   - Recommend photos they liked
   - Weight by similarity score

2. **Content-Based:**
   - Extract features from photos (hashtags, objects)
   - Recommend similar photos
   - Use image recognition (ML model)

3. **Trending:**
   - Calculate trending score: likes + comments + shares
   - Decay over time
   - Show trending photos

4. **Personalization:**
   - User's interests and history
   - Geographic location
   - Time of day

**Ranking Formula:**
```
score = collaborative_score × 0.4 + content_score × 0.3 + trending_score × 0.2 + personalization × 0.1
```

**Real-world Example:**
Instagram: Explore page shows 100+ personalized photos. Uses ML for recommendations.

#### 15.6 How do you handle stories feature (24-hour content)?

**Answer:**
**Stories Architecture:**

1. **Storage:**
   - Store in Cassandra (time-series optimized)
   - Partition by user_id and date
   - TTL: 24 hours (auto-delete)

2. **Retrieval:**
   - Query: stories WHERE user_id = X AND created_at > NOW() - 24h
   - Pagination: 10 stories per page

3. **Viewing:**
   - Track who viewed story
   - Store in database: (user_id, story_id, viewer_id, timestamp)
   - Show viewer list

4. **Notifications:**
   - Notify followers of new story
   - Push notification
   - Show "New story" indicator

**Real-world Example:**
Instagram: 500M+ daily active stories. Stories auto-delete after 24 hours.

#### 15.7 How would you scale for millions of daily active users?

**Answer:**
**Scaling Strategy:**

1. **Database Sharding:**
   - Shard by user_id
   - 1000 shards for 1B users
   - Each shard handles 1M users

2. **Read Replicas:**
   - Master for writes
   - Multiple replicas for reads
   - Distribute read load

3. **Caching:**
   - Redis for feed cache
   - Cache popular photos
   - Cache user profiles

4. **CDN:**
   - CloudFront for photos
   - Cache at edge servers
   - Reduce origin load

5. **Message Queue:**
   - Kafka for notifications
   - Async processing
   - Handle traffic spikes

**Architecture:**
```
Millions of users
    ↓
Load Balancer
    ↓
API Servers (1000+)
    ↓
Redis Cache
    ↓
Database Shards (1000+)
    ↓
S3 + CloudFront
```

**Real-world Example:**
Instagram: 2B+ monthly active users. Handles 95K+ requests per second.

#### 15.8 How do you implement photo search and discovery?

**Answer:**
**Search Implementation:**

1. **Full-Text Search:**
   - Use Elasticsearch
   - Index: photo captions, hashtags, user names
   - Real-time indexing

2. **Search Query:**
   - Parse query (keywords, hashtags)
   - Query Elasticsearch
   - Rank by relevance and popularity

3. **Hashtag Search:**
   - Index hashtags separately
   - Show photos with hashtag
   - Show hashtag statistics (usage count)

4. **Discovery:**
   - Trending hashtags
   - Popular locations
   - Suggested searches

**Real-world Example:**
Instagram: Elasticsearch indexes 100B+ photos. Searches return results in < 200ms.


### 16. Design YouTube/Netflix (Video Streaming) {#16-design-youtubenetflix-video-streaming}

#### 16.1 How would you store large video files?

**Answer:**
**Video Storage Architecture:**

1. **Object Storage:**
   - Use S3 for durability and scalability
   - Store original video file
   - Replicate across multiple regions

2. **Storage Optimization:**
   - Store in chunks (segments)
   - Each segment: 10 seconds of video
   - Enables parallel upload/download

3. **Redundancy:**
   - 3x replication across data centers
   - Ensures durability
   - Handles data center failures

4. **Lifecycle Management:**
   - Archive old videos to Glacier
   - Reduce storage costs
   - Retrieve if needed

**Real-world Example:**
YouTube: Stores 500+ hours of video uploaded per minute. Uses S3 with 3x replication.

#### 16.2 How do you handle video transcoding (different formats/resolutions)?

**Answer:**
**Transcoding Pipeline:**

1. **Input Formats:**
   - Accept: MP4, WebM, MOV, AVI
   - Extract metadata (duration, bitrate, resolution)

2. **Output Formats:**
   - Generate multiple resolutions:
     - 360p (500 Kbps)
     - 480p (1 Mbps)
     - 720p (2.5 Mbps)
     - 1080p (5 Mbps)
     - 4K (15 Mbps)

3. **Transcoding Process:**
   - Use FFmpeg for encoding
   - Run on Lambda or EC2
   - Process in parallel (multiple resolutions)
   - Store encoded videos in S3

4. **Queue System:**
   - Upload video → Queue transcoding job
   - Worker picks up job
   - Transcode and upload
   - Update database when complete

**Flow:**
```
Upload video → Queue → Transcode (parallel) → Store multiple resolutions → Ready to stream
```

**Real-world Example:**
Netflix: Transcodes videos to 50+ formats. Average transcoding time: 2-3 hours per video.

#### 16.3 How would you implement adaptive bitrate streaming?

**Answer:**
**Adaptive Bitrate Streaming (ABR):**

1. **How It Works:**
   - Client measures bandwidth
   - Request appropriate quality
   - Switch quality based on network conditions

2. **Streaming Protocol:**
   - Use HLS (HTTP Live Streaming) or DASH
   - Divide video into segments (10 seconds each)
   - Client downloads segments sequentially

3. **Quality Selection:**
   - Measure bandwidth every 10 seconds
   - If bandwidth high: request 1080p
   - If bandwidth low: request 360p
   - Smooth transitions (no buffering)

4. **Buffer Management:**
   - Maintain 30-60 second buffer
   - Prevent buffering
   - Adapt quality if buffer depletes

**Real-world Example:**
Netflix: Uses DASH for adaptive streaming. Switches quality every 10 seconds based on bandwidth.

#### 16.4 How do you use CDNs for video delivery?

**Answer:**
**CDN Strategy:**

1. **Edge Caching:**
   - Cache video segments at CDN edge servers
   - Serve from nearest location
   - Reduce latency from 100ms to 10ms

2. **Cache Hierarchy:**
   - L1: User's ISP cache
   - L2: CDN edge servers (1000+ locations)
   - L3: CDN origin servers
   - L4: S3 (source)

3. **Cache Invalidation:**
   - Cache segments for 30 days
   - Segments immutable (same content)
   - No invalidation needed

4. **Bandwidth Optimization:**
   - Serve from CDN reduces origin bandwidth
   - Saves 90% of bandwidth costs
   - Improves user experience

**Real-world Example:**
Netflix: Uses CDN to serve 50% of internet traffic. Saves millions in bandwidth costs.

#### 16.5 How would you implement video recommendations?

**Answer:**
**Recommendation Algorithm:**

1. **Collaborative Filtering:**
   - Find users with similar watch history
   - Recommend videos they watched
   - Weight by similarity

2. **Content-Based:**
   - Extract features: genre, actors, director
   - Recommend similar videos
   - Use metadata

3. **Trending:**
   - Calculate trending score: views + engagement
   - Show trending videos
   - Decay over time

4. **Personalization:**
   - User's watch history
   - Ratings and preferences
   - Time of day
   - Device type

**Ranking Formula:**
```
score = collaborative × 0.4 + content × 0.3 + trending × 0.2 + personalization × 0.1
```

**Real-world Example:**
Netflix: 80% of views from recommendations. Uses ML models for personalization.

#### 16.6 How do you handle video upload and processing pipeline?

**Answer:**
**Upload Pipeline:**

1. **Upload:**
   - Client uploads to S3 (pre-signed URL)
   - Parallel upload for large files
   - Resume capability

2. **Validation:**
   - Check file format
   - Check file size (max 100GB)
   - Scan for malware

3. **Processing Queue:**
   - Lambda triggered on upload
   - Queue transcoding job
   - Notify user of progress

4. **Transcoding:**
   - Transcode to multiple formats
   - Generate thumbnail
   - Extract metadata

5. **Completion:**
   - Update database
   - Notify user
   - Video ready to stream

**Flow:**
```
Upload → Validate → Queue → Transcode → Store → Update DB → Ready
```

**Real-world Example:**
YouTube: Processes 500+ hours of video per minute. Average processing time: 1-2 hours.

#### 16.7 How would you implement watch history and resume playback?

**Answer:**
**Watch History:**

1. **Storage:**
   - Store in database: (user_id, video_id, timestamp, watch_duration)
   - Index on user_id for fast retrieval
   - Cache in Redis

2. **Tracking:**
   - Send heartbeat every 10 seconds
   - Update watch position
   - Track completion (> 90% watched)

3. **Retrieval:**
   - Show last 100 watched videos
   - Sort by timestamp (newest first)
   - Pagination: 20 videos per page

**Resume Playback:**

1. **Storage:**
   - Store: (user_id, video_id, resume_position)
   - Update every 10 seconds

2. **Resume:**
   - When user opens video, fetch resume position
   - Start playback from position
   - Show "Resume from 1:23:45" button

3. **Sync Across Devices:**
   - Sync watch position across devices
   - User can resume on different device
   - Update in real-time

**Real-world Example:**
Netflix: Stores watch history for 10 years. Resume position synced across devices.

#### 16.8 How do you handle copyright and content moderation?

**Answer:**
**Copyright Protection:**

1. **Content ID System:**
   - Fingerprint videos (audio + visual)
   - Compare against known copyrighted content
   - Detect matches automatically

2. **Actions on Match:**
   - Block video (remove)
   - Monetize (share revenue with copyright holder)
   - Track (monitor usage)

3. **Manual Review:**
   - Copyright claims reviewed by humans
   - Dispute process for false positives
   - Appeal mechanism

**Content Moderation:**

1. **Automated Detection:**
   - Use ML models to detect:
     - Violence and gore
     - Hate speech
     - Sexual content
     - Misinformation

2. **Flagging System:**
   - Users can flag inappropriate content
   - Moderators review flagged content
   - Take action (remove, age-restrict, etc.)

3. **Policies:**
   - Community guidelines
   - Terms of service
   - Age restrictions

**Real-world Example:**
YouTube: Content ID system detects 98% of copyrighted content. 10K+ human moderators review flagged content.

---

**End of System Design Interview Guide - Complete**

This comprehensive guide covers 13 core system design concepts and 6 detailed case studies with practical implementations, real-world examples, and scalability strategies for interview preparation.


### 17. Design Amazon/E-commerce {#17-design-amazone-commerce}

#### 17.1 How would you design product catalog at scale?

**Answer:**
**Product Catalog Architecture:**

1. **Data Model:**
   - Products table: (product_id, name, description, price, category)
   - Product variants: (variant_id, product_id, size, color, sku)
   - Product images: (image_id, product_id, url, order)

2. **Storage:**
   - MySQL for product metadata (structured)
   - Elasticsearch for search and filtering
   - Redis for popular products cache
   - S3 for product images

3. **Indexing:**
   - Index on category for fast filtering
   - Index on price for sorting
   - Full-text index on name and description

4. **Caching:**
   - Cache top 10K products in Redis
   - TTL: 1 day
   - Invalidate on price change

**Real-world Example:**
Amazon: Catalogs 350M+ products. Uses Elasticsearch for search, MySQL for metadata.

#### 17.2 How do you handle inventory management?

**Answer:**
**Inventory System:**

1. **Inventory Tracking:**
   - Store: (product_id, warehouse_id, quantity)
   - Update on purchase, return, restock
   - Real-time updates

2. **Stock Levels:**
   - Available: quantity in stock
   - Reserved: quantity in pending orders
   - Damaged: quantity unusable

3. **Inventory Updates:**
   - Decrement on order placement
   - Increment on cancellation
   - Sync across warehouses

4. **Low Stock Alerts:**
   - Alert when stock < threshold
   - Trigger reorder from supplier
   - Prevent overselling

5. **Multi-Warehouse:**
   - Distribute inventory across warehouses
   - Route orders to nearest warehouse
   - Reduce shipping time

**Real-world Example:**
Amazon: Manages inventory across 175+ fulfillment centers. Real-time inventory sync.

#### 17.3 How would you implement shopping cart?

**Answer:**
**Shopping Cart Design:**

1. **Cart Storage:**
   - Redis for active carts (fast access)
   - Database for persistent storage
   - Key: user_id, Value: {product_id: quantity}

2. **Cart Operations:**
   - Add item: cart[product_id] += quantity
   - Remove item: delete cart[product_id]
   - Update quantity: cart[product_id] = new_quantity
   - Clear cart: delete all items

3. **Cart Persistence:**
   - Save to database on checkout
   - Sync across devices
   - Recover abandoned carts

4. **Cart Expiration:**
   - TTL: 30 days
   - Auto-delete expired carts
   - Notify user of expiration

**Real-world Example:**
Amazon: Carts stored in Redis. Synced across web, mobile, app.

#### 17.4 How do you handle checkout and order processing?

**Answer:**
**Checkout Flow:**

1. **Order Creation:**
   - Validate cart items
   - Check inventory availability
   - Reserve inventory
   - Create order record

2. **Order States:**
   - Pending: Awaiting payment
   - Confirmed: Payment received
   - Processing: Preparing shipment
   - Shipped: In transit
   - Delivered: Completed

3. **Order Processing:**
   - Validate shipping address
   - Calculate shipping cost
   - Apply discounts/coupons
   - Calculate total

4. **Atomicity:**
   - Use transactions for consistency
   - Rollback if payment fails
   - Release reserved inventory

**Flow:**
```
Cart → Validate → Reserve inventory → Payment → Confirm → Process → Ship
```

**Real-world Example:**
Amazon: Processes 300+ orders per second. Average checkout time: 2 minutes.

#### 17.5 How would you implement payment processing?

**Answer:**
**Payment System:**

1. **Payment Methods:**
   - Credit/Debit card
   - Digital wallets (Apple Pay, Google Pay)
   - Bank transfer
   - Buy now, pay later

2. **Payment Gateway:**
   - Use Stripe, PayPal, or Square
   - Tokenize card details
   - PCI compliance

3. **Payment Flow:**
   - Validate payment method
   - Charge amount
   - Handle response (success/failure)
   - Retry on failure (3 times)

4. **Security:**
   - Encrypt sensitive data
   - Use HTTPS
   - PCI DSS compliance
   - Fraud detection

5. **Refunds:**
   - Full refund: Return entire amount
   - Partial refund: Return portion
   - Process within 5-7 business days

**Real-world Example:**
Amazon: Processes 1M+ payments daily. Uses Stripe for payment processing.

#### 17.6 How do you handle flash sales and high traffic?

**Answer:**
**Flash Sale Strategy:**

1. **Pre-Sale Preparation:**
   - Pre-load inventory
   - Cache product data
   - Warm up servers
   - Set up load balancers

2. **Traffic Handling:**
   - Auto-scale servers (10x during sale)
   - Queue system for requests
   - Rate limiting per user
   - Prevent bot purchases

3. **Inventory Protection:**
   - Reserve inventory immediately
   - Limit quantity per user (max 5)
   - First-come, first-served
   - Timeout after 10 minutes if not purchased

4. **Graceful Degradation:**
   - Show "Sold Out" if inventory depleted
   - Queue users for waitlist
   - Notify when back in stock

**Real-world Example:**
Amazon Prime Day: 100M+ visitors, 1M+ concurrent users. Handles with auto-scaling and queuing.

#### 17.7 How would you design product search and filters?

**Answer:**
**Search Architecture:**

1. **Search Engine:**
   - Use Elasticsearch
   - Index: product name, description, category, tags
   - Real-time indexing

2. **Filters:**
   - Category: Electronics, Clothing, etc.
   - Price range: $0-$100, $100-$500, etc.
   - Rating: 4+ stars, 3+ stars, etc.
   - Brand: Apple, Samsung, etc.

3. **Search Query:**
   - Parse query (keywords, filters)
   - Query Elasticsearch
   - Rank by relevance and popularity

4. **Autocomplete:**
   - Suggest search terms
   - Based on popular searches
   - Cached in Redis

**Real-world Example:**
Amazon: Elasticsearch indexes 350M+ products. Searches return results in < 100ms.

#### 17.8 How do you implement review and rating system?

**Answer:**
**Review System:**

1. **Review Storage:**
   - Store: (review_id, product_id, user_id, rating, title, content, timestamp)
   - Index on product_id for fast retrieval

2. **Rating Calculation:**
   - Average rating: sum(ratings) / count
   - Update on new review
   - Cache in Redis

3. **Review Moderation:**
   - Flag suspicious reviews (fake, spam)
   - Manual review by moderators
   - Remove fake reviews

4. **Helpful Votes:**
   - Users vote if review helpful
   - Sort by helpfulness
   - Show most helpful first

5. **Verified Purchase:**
   - Only verified buyers can review
   - Show "Verified Purchase" badge
   - Increases trust

**Real-world Example:**
Amazon: 100M+ reviews. Average rating calculated from 1000+ reviews per product.


### 18. Design Dropbox/Google Drive (File Storage) {#18-design-dropboxgoogle-drive-file-storage}

#### 18.1 How would you store and organize user files?

**Answer:**
**File Storage Architecture:**

1. **File Organization:**
   - Hierarchical structure: /user/folder/subfolder/file
   - Store metadata: (file_id, user_id, parent_id, name, size, type, created_at)
   - Support nested folders

2. **Storage Backend:**
   - S3 for file content (durability)
   - MySQL for metadata (fast queries)
   - Redis for active file cache

3. **File Naming:**
   - Use unique file_id (UUID)
   - Store original filename
   - Handle duplicate names (rename with suffix)

4. **Quota Management:**
   - Track storage per user
   - Free: 15GB, Pro: 1TB, Business: Unlimited
   - Alert when approaching limit

**Real-world Example:**
Google Drive: Stores 1T+ files. Uses hierarchical structure with metadata in database.

#### 18.2 How do you handle file versioning?

**Answer:**
**Versioning System:**

1. **Version Storage:**
   - Store each version separately
   - Keep last 30 versions
   - Older versions archived to Glacier

2. **Version Metadata:**
   - Store: (version_id, file_id, user_id, timestamp, size, modified_by)
   - Link to S3 object

3. **Version Retrieval:**
   - Show version history
   - Allow restore to previous version
   - Show who modified and when

4. **Storage Optimization:**
   - Use delta compression (store only changes)
   - Reduces storage by 80%
   - Faster restore

**Real-world Example:**
Dropbox: Keeps 30 versions per file. Uses delta compression to save space.

#### 18.3 How would you implement file sync across devices?

**Answer:**
**Sync Architecture:**

1. **Change Detection:**
   - Monitor local file system
   - Detect: create, modify, delete
   - Queue changes for sync

2. **Sync Process:**
   - Upload changes to server
   - Download changes from server
   - Merge conflicts (last-write-wins)
   - Update local file system

3. **Sync Queue:**
   - Queue changes locally
   - Sync when online
   - Retry on failure

4. **Conflict Resolution:**
   - If both devices modify same file
   - Create conflicted copy: file (conflicted copy).txt
   - User manually resolves

**Flow:**
```
Device A modifies file → Upload to server → Device B downloads → Local update
```

**Real-world Example:**
Dropbox: Syncs files across devices in < 30 seconds. Handles conflicts automatically.

#### 18.4 How do you handle large file uploads (resumable uploads)?

**Answer:**
**Resumable Upload:**

1. **Chunked Upload:**
   - Split file into 5MB chunks
   - Upload chunks in parallel
   - Resume from failed chunk

2. **Upload Session:**
   - Create session: (session_id, file_id, user_id, total_size)
   - Track uploaded chunks
   - Expire after 24 hours

3. **Upload Process:**
   - Upload chunk 1 → Server stores
   - Upload chunk 2 → Server stores
   - Upload chunk 3 → Server stores
   - Combine chunks → Final file

4. **Resumption:**
   - Query uploaded chunks
   - Resume from next chunk
   - No re-upload of completed chunks

**Real-world Example:**
Google Drive: Supports resumable uploads. Can pause and resume anytime.

#### 18.5 How would you implement file sharing and permissions?

**Answer:**
**Sharing System:**

1. **Share Types:**
   - Private: Only owner
   - Shared with specific users
   - Public link (anyone with link)
   - Public (anyone can find)

2. **Permissions:**
   - View: Read-only
   - Comment: Can add comments
   - Edit: Can modify
   - Manage: Can change permissions

3. **Share Storage:**
   - Store: (share_id, file_id, user_id, shared_with_id, permission, created_at)
   - Index on file_id and shared_with_id

4. **Public Links:**
   - Generate unique link
   - Set expiration (optional)
   - Track access count

**Real-world Example:**
Google Drive: Supports sharing with specific users or public links. Granular permissions.

#### 18.6 How do you handle offline access and sync conflicts?

**Answer:**
**Offline Access:**

1. **Offline Mode:**
   - Cache files locally
   - Allow editing offline
   - Queue changes for sync

2. **Conflict Detection:**
   - Compare timestamps
   - If both modified: conflict
   - Create conflicted copy

3. **Sync on Reconnect:**
   - Upload local changes
   - Download remote changes
   - Merge if no conflict
   - Notify user of conflicts

**Conflict Resolution:**
```
Local version: modified 2 hours ago
Remote version: modified 1 hour ago
Result: Create "file (conflicted copy).txt" with local version
```

**Real-world Example:**
Dropbox: Supports offline editing. Syncs when online. Handles conflicts automatically.

#### 18.7 How would you implement delta sync (only sync changes)?

**Answer:**
**Delta Sync:**

1. **Change Tracking:**
   - Track file modifications
   - Store: (file_id, version, hash, timestamp)
   - Compare hashes to detect changes

2. **Delta Calculation:**
   - Compare old and new file
   - Calculate differences (delta)
   - Send only delta (not entire file)

3. **Delta Application:**
   - Receive delta
   - Apply to local file
   - Reconstruct full file

4. **Bandwidth Savings:**
   - 1GB file modified: Send only 10MB delta
   - Saves 99% bandwidth
   - Faster sync

**Real-world Example:**
Dropbox: Uses delta sync. Syncs only changed portions of files.

#### 18.8 How do you ensure data durability and availability?

**Answer:**
**Durability & Availability:**

1. **Replication:**
   - 3x replication across data centers
   - Ensures durability
   - Handles data center failures

2. **Backup:**
   - Daily backups to separate region
   - Recover from accidental deletion
   - Retention: 30 days

3. **Availability:**
   - Multi-region deployment
   - Failover to replica if primary fails
   - 99.99% uptime SLA

4. **Disaster Recovery:**
   - RTO (Recovery Time Objective): < 1 hour
   - RPO (Recovery Point Objective): < 5 minutes
   - Regular DR drills

**Real-world Example:**
Google Drive: 99.99% availability. 3x replication across regions. Daily backups.


### 19. Design Parking Lot System {#19-design-parking-lot-system}

#### 19.1 How would you design the parking spot allocation?

**Answer:**
**Spot Allocation Strategy:**

1. **Spot Representation:**
   - Each spot has: (spot_id, level, row, number, type, status)
   - Types: Compact, Regular, Large, Handicap
   - Status: Available, Occupied, Reserved

2. **Allocation Algorithm:**
   - Find nearest available spot to entrance
   - Prefer closer spots (reduce walking)
   - Allocate based on vehicle type

3. **Data Structure:**
   - Use hash map for O(1) lookup
   - Key: spot_id, Value: spot_details
   - Index by level and type for fast search

4. **Availability Tracking:**
   - Update status on entry/exit
   - Real-time availability count
   - Cache in Redis

**Real-world Example:**
Parking lot with 1000 spots: Allocate in < 100ms using hash map.

#### 19.2 How do you handle different vehicle types?

**Answer:**
**Vehicle Type Handling:**

1. **Vehicle Types:**
   - Compact: Small cars (1 spot)
   - Regular: Standard cars (1 spot)
   - Large: SUVs, trucks (1.5 spots)
   - Handicap: Disabled (1 spot, reserved)

2. **Spot Compatibility:**
   - Compact car → Compact or Regular spot
   - Regular car → Regular or Large spot
   - Large vehicle → Large spot only
   - Handicap vehicle → Handicap spot only

3. **Allocation Logic:**
   - Match vehicle to appropriate spot
   - Prevent oversizing (large car in compact spot)
   - Prevent undersizing (compact car in large spot)

**Real-world Example:**
Parking lot: 500 regular, 300 compact, 150 large, 50 handicap spots.

#### 19.3 How would you implement payment calculation?

**Answer:**
**Payment System:**

1. **Pricing Model:**
   - Hourly rate: $5/hour
   - Daily rate: $20/day (max)
   - Monthly rate: $300/month

2. **Duration Calculation:**
   - Entry time: 10:00 AM
   - Exit time: 2:30 PM
   - Duration: 4.5 hours
   - Cost: 4.5 × $5 = $22.50

3. **Pricing Rules:**
   - First 15 minutes: Free
   - Hourly rate: $5/hour
   - Daily cap: $20 (after 4 hours)
   - Monthly: Unlimited

4. **Payment Methods:**
   - Cash
   - Credit/Debit card
   - Mobile payment (Apple Pay, Google Pay)

**Real-world Example:**
Parking lot: $5/hour, $20/day max, $300/month unlimited.

#### 19.4 How do you track available vs occupied spots?

**Answer:**
**Spot Tracking:**

1. **Spot Status:**
   - Available: Empty, can be used
   - Occupied: Vehicle parked
   - Reserved: Held for specific user
   - Maintenance: Out of service

2. **Real-time Updates:**
   - Update on entry: Available → Occupied
   - Update on exit: Occupied → Available
   - Broadcast to all users

3. **Availability Count:**
   - Total spots: 1000
   - Occupied: 750
   - Available: 250
   - Reserved: 0

4. **Display:**
   - Show available spots per level
   - Show available spots per type
   - Update every 10 seconds

**Real-world Example:**
Parking lot app: Shows 250 available spots. Updates in real-time.

#### 19.5 How would you handle entry and exit gates?

**Answer:**
**Gate Management:**

1. **Entry Gate:**
   - Vehicle arrives
   - Scan license plate (ANPR)
   - Check availability
   - Issue ticket with spot number
   - Open gate

2. **Ticket System:**
   - Generate ticket: (ticket_id, license_plate, entry_time, spot_id)
   - Store in database
   - Print on receipt

3. **Exit Gate:**
   - Vehicle approaches
   - Scan license plate
   - Calculate parking duration
   - Calculate fee
   - Process payment
   - Open gate

4. **Gate Control:**
   - Automatic gates (ANPR)
   - Manual gates (attendant)
   - Backup manual override

**Flow:**
```
Entry: Scan plate → Check availability → Allocate spot → Issue ticket → Open gate
Exit: Scan plate → Calculate fee → Process payment → Open gate
```

**Real-world Example:**
Modern parking lot: ANPR cameras at entry/exit. Automatic gate control.

#### 19.6 How do you implement valet parking or reservation?

**Answer:**
**Valet Parking:**

1. **Valet Service:**
   - Customer drops car at valet
   - Valet parks car in available spot
   - Customer gets ticket
   - Valet retrieves car on exit

2. **Valet Tracking:**
   - Store: (valet_id, vehicle_id, spot_id, timestamp)
   - Track which valet parked which car
   - Retrieve car quickly

**Reservation System:**

1. **Reservation:**
   - User reserves spot in advance
   - Reserve for specific time period
   - Hold spot for 15 minutes after reservation time

2. **Reservation Storage:**
   - Store: (reservation_id, user_id, spot_id, start_time, end_time)
   - Mark spot as reserved
   - Prevent other users from using

3. **Reservation Expiration:**
   - If user doesn't arrive by start_time + 15 min
   - Release spot
   - Notify user

**Real-world Example:**
Valet parking: Valet parks car, customer gets ticket. Valet retrieves on exit.

#### 19.7 How would you generate parking tickets?

**Answer:**
**Ticket Generation:**

1. **Ticket Information:**
   - Ticket ID: Unique identifier
   - License plate: Vehicle identification
   - Entry time: When vehicle entered
   - Exit time: When vehicle exited
   - Duration: Parking duration
   - Fee: Amount charged
   - Payment method: How paid

2. **Ticket Format:**
   - Print on receipt
   - QR code for quick lookup
   - Barcode for scanning

3. **Ticket Storage:**
   - Store in database
   - Archive after 1 year
   - Retrieve for disputes

**Real-world Example:**
Parking ticket: Shows entry 10:00 AM, exit 2:30 PM, duration 4.5 hours, fee $22.50.

#### 19.8 How do you handle peak hours and waiting queues?

**Answer:**
**Peak Hour Management:**

1. **Capacity Planning:**
   - Monitor occupancy rate
   - Alert when > 90% full
   - Suggest alternative parking

2. **Queue Management:**
   - Queue vehicles waiting for spot
   - Allocate spot as soon as available
   - Notify waiting vehicle

3. **Dynamic Pricing:**
   - Increase price during peak hours
   - Encourage off-peak parking
   - Reduce congestion

4. **Overflow Handling:**
   - Redirect to nearby parking lots
   - Partner with other lots
   - Show availability on app

**Real-world Example:**
Peak hours (9-10 AM, 5-6 PM): 95% occupancy. Queue 50+ vehicles. Dynamic pricing: $8/hour.


### 20. Design Vending Machine {#20-design-vending-machine}

#### 20.1 How would you design the state machine for vending machine?

**Answer:**
**Vending Machine States:**

1. **Idle State:**
   - Machine waiting for input
   - Display available products
   - Accept money

2. **Money Inserted State:**
   - User inserts money
   - Display balance
   - Accept more money or selection

3. **Product Selected State:**
   - User selects product
   - Check if sufficient balance
   - Check if product available

4. **Dispensing State:**
   - Dispense product
   - Update inventory
   - Calculate change

5. **Change Return State:**
   - Calculate change
   - Dispense coins/bills
   - Return to Idle

**State Transitions:**
```
Idle → Money Inserted → Product Selected → Dispensing → Change Return → Idle
```

**Real-world Example:**
Vending machine: Insert $5 → Select Coke ($2.50) → Dispense → Return $2.50 change.

#### 20.2 How do you handle inventory management?

**Answer:**
**Inventory System:**

1. **Product Storage:**
   - Store: (product_id, name, price, quantity, location)
   - Location: Row and column in machine
   - Quantity: Number of items

2. **Inventory Tracking:**
   - Decrement on sale
   - Increment on refill
   - Alert when low (< 5 items)

3. **Out of Stock:**
   - Mark product as unavailable
   - Don't allow selection
   - Show "Out of Stock" message

4. **Refilling:**
   - Maintenance person refills machine
   - Update inventory in system
   - Log refill time and quantity

**Real-world Example:**
Vending machine: 20 Cokes, 15 Sprites, 10 Fanta. Alert when < 5 items.

#### 20.3 How would you implement payment processing (cash, card)?

**Answer:**
**Payment Methods:**

1. **Cash Payment:**
   - Accept bills: $1, $5, $10, $20
   - Accept coins: $0.25, $0.10, $0.05, $0.01
   - Validate bills (check for counterfeits)
   - Count total inserted

2. **Card Payment:**
   - Accept credit/debit cards
   - Connect to payment gateway
   - Validate card
   - Charge amount
   - Handle declined cards

3. **Mobile Payment:**
   - Accept QR code scanning
   - Accept NFC (Apple Pay, Google Pay)
   - Validate payment
   - Charge amount

4. **Payment Validation:**
   - Check if balance >= product price
   - Prevent insufficient payment
   - Reject invalid payment methods

**Real-world Example:**
Vending machine: Accept cash ($1-$20), cards, and mobile payments.

#### 20.4 How do you handle change calculation and dispensing?

**Answer:**
**Change Calculation:**

1. **Change Amount:**
   - Product price: $2.50
   - Money inserted: $5.00
   - Change: $5.00 - $2.50 = $2.50

2. **Change Dispensing:**
   - Use greedy algorithm
   - Dispense largest denominations first
   - $2.50 = 2 × $1 + 2 × $0.25

3. **Coin/Bill Inventory:**
   - Track coins and bills in machine
   - Alert when low
   - Refill during maintenance

4. **Edge Cases:**
   - Insufficient change (e.g., need $0.75, only have $1 bills)
   - Refund entire amount
   - Log incident

**Real-world Example:**
Change $2.50: Dispense 2 × $1 + 2 × $0.25.

#### 20.5 How would you design for multiple product selections?

**Answer:**
**Multiple Selection:**

1. **Product Selection:**
   - User selects first product
   - Display price and balance
   - Allow additional selections
   - Show total cost

2. **Selection Tracking:**
   - Store selected products: [Coke, Sprite, Chips]
   - Calculate total: $2.50 + $2.00 + $1.50 = $6.00
   - Check if balance sufficient

3. **Dispensing Multiple:**
   - Dispense each product sequentially
   - Update inventory for each
   - Calculate total change

4. **Cancellation:**
   - Allow user to cancel selection
   - Refund money
   - Return to Idle

**Real-world Example:**
Select Coke ($2.50) + Sprite ($2.00) = $4.50. Insert $5. Dispense both. Return $0.50.

#### 20.6 How do you handle out-of-stock scenarios?

**Answer:**
**Out of Stock Handling:**

1. **Detection:**
   - Check inventory before dispensing
   - If quantity = 0: Out of stock
   - Don't allow selection

2. **User Notification:**
   - Display "Out of Stock" message
   - Suggest alternative products
   - Allow selection of different product

3. **Refund:**
   - If user already paid
   - Refund entire amount
   - Return to Idle

4. **Maintenance Alert:**
   - Alert maintenance person
   - Log out-of-stock event
   - Schedule refill

**Real-world Example:**
User selects Coke (out of stock). Machine displays "Out of Stock". Suggests Sprite.

#### 20.7 How would you implement transaction logging?

**Answer:**
**Transaction Log:**

1. **Log Information:**
   - Transaction ID: Unique identifier
   - Timestamp: When transaction occurred
   - Product: What was purchased
   - Price: Amount charged
   - Payment method: Cash, card, mobile
   - Status: Success, failed, refunded

2. **Log Storage:**
   - Store locally on machine
   - Sync to server periodically
   - Archive after 1 year

3. **Log Analysis:**
   - Track sales by product
   - Track revenue
   - Identify popular products
   - Identify failed transactions

**Real-world Example:**
Transaction log: 2024-01-15 10:30 AM, Coke, $2.50, Card, Success.

#### 20.8 How do you handle maintenance and refilling?

**Answer:**
**Maintenance System:**

1. **Refilling:**
   - Maintenance person opens machine
   - Refill products
   - Refill coins/bills
   - Update inventory in system

2. **Maintenance Alerts:**
   - Low inventory alert
   - Low change alert
   - Machine malfunction alert
   - Schedule maintenance

3. **Machine Status:**
   - Track machine health
   - Log errors and issues
   - Schedule preventive maintenance
   - Track uptime

4. **Remote Monitoring:**
   - Monitor inventory remotely
   - Monitor sales remotely
   - Alert on issues
   - Schedule refill proactively

**Real-world Example:**
Maintenance: Refill Coke (20 units), Sprite (15 units), coins ($100). Update system.


### 21. Design Library Management System {#21-design-library-management-system}

#### 21.1 How would you design book catalog and search?

**Answer:**
**Book Catalog:**

1. **Book Metadata:**
   - Store: (book_id, title, author, isbn, publisher, year, genre, quantity)
   - Index on title, author, isbn for fast search
   - Full-text search on title and author

2. **Search Implementation:**
   - Use Elasticsearch for full-text search
   - Index: title, author, isbn, genre
   - Support filters: genre, year, author

3. **Book Copies:**
   - Each book has multiple copies
   - Track: (copy_id, book_id, status, location)
   - Status: Available, Checked Out, Reserved, Damaged

4. **Catalog Display:**
   - Show book details: title, author, cover, description
   - Show availability: X copies available
   - Show reviews and ratings

**Real-world Example:**
Library catalog: 1M+ books. Search returns results in < 100ms.

#### 21.2 How do you handle book checkouts and returns?

**Answer:**
**Checkout System:**

1. **Checkout Process:**
   - Member scans library card
   - Select book to checkout
   - Check availability
   - Create checkout record: (checkout_id, member_id, copy_id, checkout_date, due_date)
   - Update copy status: Available → Checked Out

2. **Due Date:**
   - Standard: 14 days
   - Renewal: Extend by 7 days (if no holds)
   - Overdue: After due date, charge late fees

3. **Return Process:**
   - Member returns book
   - Scan book barcode
   - Update copy status: Checked Out → Available
   - Calculate late fees if overdue
   - Process payment if needed

4. **Renewal:**
   - Member can renew online or in-person
   - Extend due date by 7 days
   - Only if no holds on book

**Real-world Example:**
Checkout: 14-day loan period. Renewal: +7 days. Late fee: $0.25/day.

#### 21.3 How would you implement member management?

**Answer:**
**Member System:**

1. **Member Registration:**
   - Collect: name, email, phone, address
   - Generate member ID
   - Issue library card
   - Set membership type: Student, Faculty, Public

2. **Member Types:**
   - Student: 14-day loan, 5 books max
   - Faculty: 21-day loan, 10 books max
   - Public: 14-day loan, 3 books max

3. **Member Status:**
   - Active: Can checkout books
   - Suspended: Overdue fees unpaid
   - Expired: Membership expired

4. **Member Profile:**
   - Track checkout history
   - Track fines and payments
   - Track holds and reservations

**Real-world Example:**
Library: 50K+ members. Student members: 30K, Faculty: 5K, Public: 15K.

#### 21.4 How do you handle due dates and late fees?

**Answer:**
**Due Date Management:**

1. **Due Date Calculation:**
   - Checkout date: Jan 1
   - Loan period: 14 days
   - Due date: Jan 15

2. **Late Fee Calculation:**
   - Return date: Jan 20 (5 days late)
   - Late fee: $0.25/day × 5 = $1.25
   - Max fee: $10 per book

3. **Overdue Notifications:**
   - Email 1 day before due date
   - Email on due date
   - Email 3 days after due date
   - Email 7 days after due date

4. **Fine Payment:**
   - Pay online or in-person
   - Accept cash, card, check
   - Generate receipt

**Real-world Example:**
Late fee: $0.25/day, max $10. Overdue 20 days: $5 fine.

#### 21.5 How would you implement reservations/holds?

**Answer:**
**Reservation System:**

1. **Hold Request:**
   - Member requests book (all copies checked out)
   - Create hold: (hold_id, member_id, book_id, request_date)
   - Add to queue

2. **Hold Queue:**
   - FIFO (First In, First Out)
   - Show position in queue
   - Notify when book available

3. **Hold Notification:**
   - Email when book available
   - Hold for 3 days
   - If not picked up, release to next member

4. **Hold Pickup:**
   - Member comes to library
   - Checkout book
   - Remove from hold queue

**Real-world Example:**
Popular book: 10 holds in queue. Member is #5. Notified when book available.

#### 21.6 How do you handle multiple copies of same book?

**Answer:**
**Multiple Copies:**

1. **Copy Tracking:**
   - Book: "Harry Potter" (book_id: 123)
   - Copy 1: Available
   - Copy 2: Checked Out (due Jan 15)
   - Copy 3: Reserved
   - Copy 4: Damaged

2. **Availability:**
   - Show total copies: 4
   - Show available: 1
   - Show checked out: 2
   - Show reserved: 1

3. **Copy Assignment:**
   - On checkout, assign any available copy
   - Track which copy member has
   - Ensure return of same copy

4. **Copy Maintenance:**
   - Track condition of each copy
   - Mark damaged copies
   - Remove from circulation if damaged

**Real-world Example:**
"Harry Potter": 10 copies total. 7 available, 2 checked out, 1 reserved.

#### 21.7 How would you design the notification system?

**Answer:**
**Notification System:**

1. **Notification Types:**
   - Due date reminder: 1 day before
   - Overdue notice: 1, 3, 7 days after
   - Hold available: Book ready for pickup
   - Renewal confirmation: Loan extended

2. **Notification Channels:**
   - Email
   - SMS
   - In-app notification
   - Phone call (for high fines)

3. **Notification Timing:**
   - Due date reminder: 1 day before
   - Overdue: Daily for first 3 days, then weekly
   - Hold available: Immediately

4. **Opt-out:**
   - Members can opt-out of notifications
   - Except critical notices (overdue, holds)

**Real-world Example:**
Member receives email: "Book due tomorrow". SMS: "Book overdue, fine $2.50".

#### 21.8 How do you handle inventory and book tracking?

**Answer:**
**Inventory System:**

1. **Book Tracking:**
   - Barcode on each book
   - Scan on checkout/return
   - Track location: Shelf, Checkout, Reserved

2. **Inventory Count:**
   - Physical count quarterly
   - Compare with system records
   - Investigate discrepancies

3. **Lost Books:**
   - If not returned after 30 days overdue
   - Mark as lost
   - Charge replacement fee
   - Remove from circulation

4. **Damaged Books:**
   - Mark as damaged
   - Remove from circulation
   - Repair or discard
   - Update inventory

**Real-world Example:**
Inventory: 100K books. Quarterly count. 50 lost books/year. 100 damaged books/year.


### 22. Design Chess Game {#22-design-chess-game}

#### 22.1 How would you design the game board and pieces?

**Answer:**
**Board Representation:**

1. **Board Structure:**
   - 8x8 grid
   - Represent as 2D array: board[8][8]
   - Each cell contains piece or empty

2. **Piece Representation:**
   - Piece type: Pawn, Rook, Knight, Bishop, Queen, King
   - Color: White or Black
   - Position: (row, col)

3. **Data Structure:**
   ```
   Piece {
     type: PieceType (Pawn, Rook, etc.)
     color: Color (White, Black)
     position: (row, col)
     hasMoved: boolean (for castling, pawn first move)
   }
   ```

4. **Initial Setup:**
   - White pieces: rows 0-1
   - Black pieces: rows 6-7
   - Standard chess starting position

**Real-world Example:**
Chess board: 8x8 grid. 32 pieces (16 per side). Represented as 2D array.

#### 22.2 How do you implement move validation?

**Answer:**
**Move Validation:**

1. **Piece Movement Rules:**
   - Pawn: 1 square forward (2 on first move), capture diagonally
   - Rook: Any number of squares horizontally/vertically
   - Knight: L-shape (2+1 squares)
   - Bishop: Any number of squares diagonally
   - Queen: Any number of squares (rook + bishop)
   - King: 1 square in any direction

2. **Validation Steps:**
   - Check if piece belongs to current player
   - Check if destination is valid for piece type
   - Check if path is clear (no pieces blocking)
   - Check if move doesn't leave king in check

3. **Special Moves:**
   - Castling: King and rook move together
   - En passant: Pawn captures pawn diagonally
   - Promotion: Pawn reaches end, becomes queen/rook/bishop/knight

4. **Implementation:**
   ```
   isValidMove(from, to, board):
     piece = board[from]
     if not isValidPieceMove(piece, from, to):
       return false
     if not isPathClear(from, to, board):
       return false
     if wouldLeaveKingInCheck(from, to, board):
       return false
     return true
   ```

**Real-world Example:**
Pawn at e2 can move to e3 or e4. Cannot move to e5 (blocked by piece).

#### 22.3 How would you handle check, checkmate, and stalemate?

**Answer:**
**Game States:**

1. **Check:**
   - King is under attack
   - Player must move to escape check
   - Detect: Is king's position attacked?

2. **Checkmate:**
   - King is in check
   - No legal moves to escape check
   - Game over, opponent wins
   - Detect: Check + no valid moves

3. **Stalemate:**
   - King is NOT in check
   - No legal moves available
   - Game is draw
   - Detect: Not in check + no valid moves

4. **Detection Algorithm:**
   ```
   if isKingInCheck(board, color):
     if hasValidMoves(board, color):
       return "Check"
     else:
       return "Checkmate"
   else:
     if hasValidMoves(board, color):
       return "Normal"
     else:
       return "Stalemate"
   ```

**Real-world Example:**
White king in check with no escape moves = Checkmate. Black wins.

#### 22.4 How do you implement game state persistence?

**Answer:**
**State Storage:**

1. **Game State:**
   - Board position: Current piece positions
   - Move history: All moves played
   - Current player: Whose turn
   - Game status: Ongoing, checkmate, stalemate, draw

2. **Move History:**
   - Store each move: (from, to, piece, captured_piece, timestamp)
   - Enable undo/redo
   - Enable replay

3. **Database Storage:**
   - Store game: (game_id, player1_id, player2_id, status, created_at)
   - Store moves: (move_id, game_id, move_number, from, to, timestamp)
   - Store final result: (game_id, winner, reason)

4. **Serialization:**
   - FEN (Forsyth-Edwards Notation): Compact board representation
   - PGN (Portable Game Notation): Standard format for games

**Real-world Example:**
Game saved: FEN = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"

#### 22.5 How would you design for multiplayer online play?

**Answer:**
**Multiplayer Architecture:**

1. **Connection:**
   - WebSocket for real-time communication
   - Persistent connection between players
   - Low latency (< 100ms)

2. **Move Synchronization:**
   - Player 1 makes move
   - Send move to server
   - Server validates move
   - Broadcast to Player 2
   - Update both boards

3. **Game Matching:**
   - Queue system for finding opponents
   - Match by rating (ELO)
   - Match by time control

4. **Concurrency:**
   - Prevent simultaneous moves
   - Lock game state during move
   - Ensure move order

**Flow:**
```
Player 1 moves → Server validates → Broadcast to Player 2 → Update board
```

**Real-world Example:**
Chess.com: 10M+ concurrent players. Real-time move synchronization.

#### 22.6 How do you handle time controls?

**Answer:**
**Time Control:**

1. **Time Formats:**
   - Blitz: 3 minutes per player
   - Rapid: 10 minutes per player
   - Classical: 30+ minutes per player
   - Bullet: 1 minute per player

2. **Time Tracking:**
   - Each player has time budget
   - Decrement on their turn
   - Increment after move (some formats)

3. **Time Management:**
   - Start timer on player's turn
   - Stop timer on opponent's turn
   - Alert when time low (< 1 minute)

4. **Time Expiration:**
   - If time runs out: Player loses
   - Exception: If opponent has insufficient material, draw

**Real-world Example:**
Blitz game: 3 minutes per player. Player 1 has 2:45 left. Player 2 has 1:30 left.

#### 22.7 How would you implement move history and undo?

**Answer:**
**Move History:**

1. **History Storage:**
   - Store all moves: [(from1, to1), (from2, to2), ...]
   - Store board state after each move
   - Enable replay

2. **Undo Implementation:**
   - Undo last move
   - Restore previous board state
   - Switch current player
   - Limit undos (e.g., 3 per game)

3. **Redo Implementation:**
   - Redo undone move
   - Restore board state
   - Switch current player

4. **Move Notation:**
   - Algebraic notation: e2-e4 (pawn moves to e4)
   - Capture notation: exd5 (pawn on e-file captures on d5)
   - Check notation: Nf3+ (knight to f3, check)

**Real-world Example:**
Move history: 1. e2-e4 e7-e5 2. Nf1-f3 Nb8-c6 3. Bf1-c4

#### 22.8 How do you handle game replay and analysis?

**Answer:**
**Replay System:**

1. **Replay Functionality:**
   - Load game from history
   - Step through moves one by one
   - Show board state after each move
   - Show move annotations

2. **Analysis Tools:**
   - Show best moves (using chess engine)
   - Show evaluation (advantage for white/black)
   - Show blunders and mistakes
   - Compare with engine recommendations

3. **Chess Engine Integration:**
   - Use Stockfish or similar engine
   - Analyze position
   - Suggest best moves
   - Evaluate position

4. **Annotations:**
   - Add comments to moves
   - Mark good moves (!)
   - Mark bad moves (?)
   - Mark blunders (??)

**Real-world Example:**
Game replay: Step through 40 moves. Engine shows best move was Nf3, player played e4 (blunder).

---

**End of System Design Interview Guide - Complete with 22 Case Studies**

This comprehensive guide now covers 13 core system design concepts and 10 detailed case studies (sections 11-22) with practical implementations, real-world examples, and scalability strategies for complete interview preparation.


### 23. Design Restaurant Booking System {#23-design-restaurant-booking-system}

#### 23.1 How would you design table availability and booking?

**Answer:**
**Table Management:**

1. **Table Representation:**
   - Store: (table_id, restaurant_id, capacity, location, status)
   - Capacity: 2, 4, 6, 8 seats
   - Status: Available, Occupied, Reserved, Maintenance

2. **Availability Tracking:**
   - Track available tables per time slot
   - Time slots: 30-minute intervals
   - Query: Available tables for 4 people at 7:00 PM

3. **Booking Storage:**
   - Store: (booking_id, restaurant_id, table_id, customer_id, date, time, party_size, status)
   - Status: Confirmed, Cancelled, No-show, Completed

4. **Real-time Updates:**
   - Update availability on booking
   - Update on cancellation
   - Cache in Redis for fast lookups

**Real-world Example:**
Restaurant: 20 tables. 4-person table booked 7:00 PM. Availability updated immediately.

#### 23.2 How do you handle table allocation optimization?

**Answer:**
**Allocation Algorithm:**

1. **Matching Logic:**
   - Find smallest table that fits party size
   - Avoid wasting large tables for small parties
   - Optimize table turnover

2. **Optimization Criteria:**
   - Minimize table waste (4-person table for 2 people = waste)
   - Maximize turnover (small tables turn over faster)
   - Consider location preferences (window, quiet corner)

3. **Algorithm:**
   ```
   findBestTable(party_size, time_slot):
     available_tables = getAvailableTables(time_slot)
     suitable_tables = filter(available_tables, capacity >= party_size)
     best_table = min(suitable_tables, by=capacity)
     return best_table
   ```

4. **Constraints:**
   - Don't split parties across tables
   - Respect location preferences
   - Consider future bookings (don't block larger parties)

**Real-world Example:**
Party of 2: Allocate 2-person table (not 4-person). Saves 4-person table for larger party.

#### 23.3 How would you implement time slot management?

**Answer:**
**Time Slot System:**

1. **Slot Definition:**
   - Duration: 30 minutes
   - Slots: 5:00 PM, 5:30 PM, 6:00 PM, 6:30 PM, etc.
   - Operating hours: 5:00 PM - 11:00 PM

2. **Slot Availability:**
   - Track available tables per slot
   - Update on booking/cancellation
   - Show available slots to customer

3. **Slot Duration:**
   - Typical dining: 1.5-2 hours
   - Table held for 2 hours after booking time
   - Turnover time: 15 minutes for cleaning

4. **Slot Blocking:**
   - Block slots for maintenance
   - Block slots for private events
   - Block slots during closed hours

**Real-world Example:**
7:00 PM slot: 15 tables available. 7:30 PM slot: 12 tables available.

#### 23.4 How do you handle cancellations and no-shows?

**Answer:**
**Cancellation Policy:**

1. **Cancellation:**
   - Customer cancels booking
   - Release table for time slot
   - Update availability
   - Notify waitlist

2. **No-Show:**
   - Customer doesn't arrive by 15 minutes after booking time
   - Mark as no-show
   - Release table
   - Charge cancellation fee (optional)

3. **Cancellation Fees:**
   - Cancel 24+ hours before: No fee
   - Cancel 2-24 hours before: 50% fee
   - Cancel < 2 hours: 100% fee
   - No-show: 100% fee

4. **Tracking:**
   - Track no-show rate per customer
   - Suspend account if > 3 no-shows
   - Require credit card for high no-show customers

**Real-world Example:**
Customer cancels 2 hours before: 50% fee charged. Table released for other bookings.

#### 23.5 How would you implement waitlist and notifications?

**Answer:**
**Waitlist System:**

1. **Waitlist Request:**
   - Customer requests table (no availability)
   - Add to waitlist: (waitlist_id, customer_id, party_size, preferred_time)
   - Show position in queue

2. **Waitlist Notification:**
   - When table becomes available
   - Notify customer (SMS, email, push)
   - Hold table for 15 minutes
   - If not confirmed, move to next customer

3. **Notification Channels:**
   - SMS: Immediate notification
   - Email: Backup notification
   - Push notification: In-app alert

4. **Waitlist Management:**
   - FIFO (First In, First Out)
   - Prioritize by party size (easier to fill)
   - Prioritize by time (earlier preferred)

**Real-world Example:**
Waitlist: 5 customers waiting. Table becomes available. Notify #1 customer. Hold for 15 minutes.

#### 23.6 How do you handle special requests and preferences?

**Answer:**
**Preferences System:**

1. **Special Requests:**
   - Dietary restrictions: Vegetarian, vegan, gluten-free
   - Allergies: Nuts, shellfish, dairy
   - Preferences: Window seat, quiet corner, high chair for baby

2. **Storage:**
   - Store in booking: (booking_id, special_requests, preferences)
   - Share with restaurant staff
   - Alert kitchen of dietary restrictions

3. **Fulfillment:**
   - Restaurant confirms special requests
   - Prepare in advance (high chair, booster seat)
   - Alert kitchen of allergies

4. **Communication:**
   - Send special requests to restaurant
   - Confirm fulfillment before booking
   - Alert customer if can't fulfill

**Real-world Example:**
Booking: Party of 4, vegetarian, window seat preferred. Restaurant confirms vegetarian menu available.

#### 23.7 How would you design the restaurant discovery feature?

**Answer:**
**Discovery System:**

1. **Search Filters:**
   - Cuisine: Italian, Chinese, Indian, etc.
   - Location: Radius search (5km, 10km)
   - Rating: 4+ stars, 3+ stars
   - Price: $, $$, $$$, $$$$
   - Availability: Date, time, party size

2. **Search Implementation:**
   - Use Elasticsearch for full-text search
   - Geospatial search for location
   - Filter by rating, price, cuisine

3. **Ranking:**
   - Rank by rating
   - Rank by distance
   - Rank by popularity
   - Personalize based on user history

4. **Restaurant Details:**
   - Photos, menu, reviews
   - Hours, location, phone
   - Availability for selected date/time

**Real-world Example:**
Search: Italian restaurants, 5km radius, 4+ stars, available 7:00 PM for 4 people.

#### 23.8 How do you handle peak hours and weekends?

**Answer:**
**Peak Hour Management:**

1. **Capacity Planning:**
   - Identify peak hours: 7-9 PM Friday-Saturday
   - Increase staff during peak hours
   - Prepare in advance

2. **Booking Limits:**
   - Limit bookings per time slot
   - Prevent overbooking
   - Maintain service quality

3. **Dynamic Pricing:**
   - Increase prices during peak hours
   - Encourage off-peak bookings
   - Premium pricing for Friday-Saturday

4. **Waitlist Management:**
   - Longer waitlists during peak hours
   - Manage customer expectations
   - Offer alternative times

**Real-world Example:**
Friday 7:00 PM: 100% booked. Waitlist: 20 customers. Suggest 8:30 PM or Saturday.


### 24. Design Airline Reservation System {#24-design-airline-reservation-system}

#### 24.1 How would you design flight search (origin, destination, date)?

**Answer:**
**Flight Search:**

1. **Search Parameters:**
   - Origin: Departure airport (LAX, JFK)
   - Destination: Arrival airport (SFO, LHR)
   - Date: Departure date
   - Passengers: Number of passengers
   - Trip type: One-way, round-trip, multi-city

2. **Flight Data:**
   - Store: (flight_id, airline, origin, destination, departure_time, arrival_time, duration, aircraft)
   - Index on origin, destination, date for fast search

3. **Search Implementation:**
   - Query flights matching criteria
   - Filter by date
   - Sort by price, duration, departure time
   - Show available seats

4. **Caching:**
   - Cache popular routes
   - TTL: 1 hour
   - Invalidate on booking

**Real-world Example:**
Search: LAX → SFO, Jan 15, 2 passengers. Results: 50+ flights. Sort by price.

#### 24.2 How do you handle seat selection and inventory?

**Answer:**
**Seat Management:**

1. **Seat Representation:**
   - Aircraft: 300 seats
   - Rows: 1-30
   - Columns: A-J (10 seats per row)
   - Seat: 1A, 1B, 1C, etc.

2. **Seat Classes:**
   - Economy: Rows 10-30 (200 seats)
   - Business: Rows 1-9 (90 seats)
   - First: Rows 1-3 (10 seats)

3. **Seat Status:**
   - Available: Can be booked
   - Booked: Occupied
   - Blocked: Maintenance, crew rest

4. **Seat Selection:**
   - Show available seats
   - Allow seat selection
   - Premium seats (window, aisle): Extra charge
   - Blocked seats: Can't select

**Real-world Example:**
Flight: 300 seats. 250 booked. 50 available. Window seats: +$20.

#### 24.3 How would you implement booking and payment?

**Answer:**
**Booking Process:**

1. **Booking Steps:**
   - Select flight
   - Select seats
   - Add passengers
   - Enter contact info
   - Select payment method
   - Confirm booking

2. **Booking Storage:**
   - Store: (booking_id, flight_id, passenger_id, seat_id, booking_date, status)
   - Status: Pending, Confirmed, Cancelled

3. **Payment Processing:**
   - Charge credit card
   - Handle payment failures
   - Retry 3 times
   - Generate receipt

4. **Confirmation:**
   - Send confirmation email
   - Include booking reference
   - Include e-ticket
   - Allow check-in 24 hours before

**Real-world Example:**
Booking: LAX-SFO, Jan 15, seat 12A, $250. Payment confirmed. E-ticket sent.

#### 24.4 How do you handle pricing and fare classes?

**Answer:**
**Pricing System:**

1. **Fare Classes:**
   - Economy: Base price
   - Premium Economy: +30%
   - Business: +200%
   - First: +400%

2. **Dynamic Pricing:**
   - Base price: $200
   - Demand multiplier: 1.0x - 3.0x
   - Time multiplier: Book early = discount
   - Day multiplier: Weekend = premium

3. **Pricing Formula:**
   ```
   price = base_price × demand_multiplier × time_multiplier × day_multiplier
   ```

4. **Inclusions:**
   - Economy: 1 carry-on, 1 checked bag
   - Business: 2 carry-on, 2 checked bags, lounge access
   - First: 3 carry-on, 3 checked bags, lounge, meals

**Real-world Example:**
LAX-SFO: Economy $200, Business $600, First $1000. Book 30 days early: -20% discount.

#### 24.5 How would you implement cancellations and refunds?

**Answer:**
**Cancellation Policy:**

1. **Cancellation Types:**
   - Full refund: Cancel 7+ days before
   - 50% refund: Cancel 2-7 days before
   - No refund: Cancel < 2 days before
   - No-show: No refund

2. **Refund Processing:**
   - Process within 5-7 business days
   - Refund to original payment method
   - Deduct cancellation fee
   - Generate refund receipt

3. **Rebooking:**
   - Allow rebooking on different flight
   - No additional charge if same price
   - Charge difference if higher price

4. **Tracking:**
   - Track cancellation reason
   - Track refund status
   - Notify customer of refund

**Real-world Example:**
Cancel 5 days before: 50% refund = $100. Rebook on different flight: No additional charge.

#### 24.6 How do you handle overbooking and waitlisting?

**Answer:**
**Overbooking Strategy:**

1. **Overbooking:**
   - Airlines overbook by 10-15%
   - Assume 10% no-show rate
   - Sell 330 seats for 300-seat aircraft

2. **Handling Overbooking:**
   - Ask for volunteers to take later flight
   - Offer compensation: $200-$500 voucher
   - Involuntary bumping: Compensation required

3. **Waitlist:**
   - If flight full, add to waitlist
   - Notify if seat becomes available
   - Hold for 24 hours

4. **Compensation:**
   - Involuntary bumping: $200-$400 + rebooking
   - Delayed flight: $200-$600 depending on delay
   - Lost luggage: Up to $2500

**Real-world Example:**
Flight overbooked. Ask for 5 volunteers. Offer $300 voucher. 3 volunteers accept.

#### 24.7 How would you design for multi-city bookings?

**Answer:**
**Multi-City Booking:**

1. **Multi-City Trip:**
   - LAX → SFO (Jan 15)
   - SFO → NYC (Jan 18)
   - NYC → LAX (Jan 22)

2. **Booking Process:**
   - Search each leg separately
   - Select flights for each leg
   - Combine into single booking
   - Single payment

3. **Constraints:**
   - Minimum connection time: 2 hours
   - Same airline preferred (baggage through-checked)
   - Different airlines: Baggage may not transfer

4. **Pricing:**
   - Calculate total price
   - Apply discounts for multi-city
   - Show price breakdown per leg

**Real-world Example:**
Multi-city: LAX-SFO $200 + SFO-NYC $300 + NYC-LAX $250 = $750 total.

#### 24.8 How do you integrate with external systems (GDS)?

**Answer:**
**GDS Integration:**

1. **GDS (Global Distribution System):**
   - Amadeus, Sabre, Galileo
   - Connect airlines to travel agencies
   - Real-time inventory and pricing

2. **Integration Points:**
   - Flight search: Query GDS for availability
   - Booking: Create booking in GDS
   - Pricing: Get real-time fares from GDS
   - Inventory: Sync seat availability

3. **API Communication:**
   - Use SOAP or REST APIs
   - Real-time synchronization
   - Handle failures gracefully

4. **Data Sync:**
   - Sync flights every 1 hour
   - Sync prices every 30 minutes
   - Sync inventory every 5 minutes

**Real-world Example:**
Search query → Query Amadeus GDS → Get 50 flights → Display to user.


### 25. Design Hotel Booking System {#25-design-hotel-booking-system}

#### 25.1 How would you design hotel search with filters?

**Answer:**
**Hotel Search:**

1. **Search Parameters:**
   - Location: City, address, coordinates
   - Check-in date
   - Check-out date
   - Number of guests
   - Number of rooms

2. **Search Filters:**
   - Price range: $50-$500/night
   - Star rating: 1-5 stars
   - Amenities: WiFi, pool, gym, parking
   - Hotel type: Luxury, budget, boutique
   - Distance from landmark

3. **Search Implementation:**
   - Use Elasticsearch for full-text search
   - Geospatial search for location
   - Filter by price, rating, amenities
   - Sort by price, rating, distance

4. **Results Display:**
   - Show hotel name, rating, price
   - Show photos and reviews
   - Show availability
   - Show distance from landmark

**Real-world Example:**
Search: NYC, Jan 15-17, 2 guests, 1 room. Results: 500+ hotels. Filter: 4+ stars, $100-$300/night.

#### 25.2 How do you handle room availability and rates?

**Answer:**
**Room Inventory:**

1. **Room Types:**
   - Single: 1 bed, 1 guest
   - Double: 1 bed, 2 guests
   - Twin: 2 beds, 2 guests
   - Suite: Multiple rooms, 4+ guests

2. **Availability Tracking:**
   - Track available rooms per type per date
   - Update on booking/cancellation
   - Show availability calendar

3. **Dynamic Pricing:**
   - Base rate: $100/night
   - Demand multiplier: 1.0x - 3.0x
   - Day multiplier: Weekend = +50%
   - Occupancy multiplier: 90%+ = +20%

4. **Rate Calculation:**
   ```
   rate = base_rate × demand_multiplier × day_multiplier × occupancy_multiplier
   ```

**Real-world Example:**
Single room: $100 base. Weekend: $150. 95% occupancy: $180. High demand: $270.

#### 25.3 How would you implement booking engine?

**Answer:**
**Booking Process:**

1. **Booking Steps:**
   - Select hotel and room type
   - Enter check-in/check-out dates
   - Enter guest information
   - Add special requests
   - Select payment method
   - Confirm booking

2. **Booking Storage:**
   - Store: (booking_id, hotel_id, room_id, guest_id, check_in, check_out, status)
   - Status: Pending, Confirmed, Cancelled, Completed

3. **Reservation Lock:**
   - Lock room for 15 minutes during booking
   - Prevent double booking
   - Release if not completed

4. **Confirmation:**
   - Send confirmation email
   - Include booking reference
   - Include check-in instructions
   - Allow modifications

**Real-world Example:**
Booking: Hilton NYC, Double room, Jan 15-17, $450 total. Confirmation sent.

#### 25.4 How do you handle cancellation policies?

**Answer:**
**Cancellation Policies:**

1. **Policy Types:**
   - Free cancellation: Cancel anytime, full refund
   - Non-refundable: No refund, no cancellation
   - Flexible: Cancel 24 hours before, full refund
   - Moderate: Cancel 7 days before, full refund
   - Strict: Cancel 30 days before, full refund

2. **Refund Calculation:**
   - Free cancellation: 100% refund
   - Flexible: 100% refund if cancel 24h before
   - Moderate: 100% refund if cancel 7 days before
   - Strict: 100% refund if cancel 30 days before
   - Non-refundable: 0% refund

3. **Refund Processing:**
   - Process within 5-7 business days
   - Refund to original payment method
   - Generate refund receipt

4. **Rebooking:**
   - Allow rebooking on different dates
   - No additional charge if same price
   - Charge difference if higher price

**Real-world Example:**
Flexible policy: Cancel 24 hours before check-in, full refund. Cancel 12 hours before: No refund.

#### 25.5 How would you implement review and rating system?

**Answer:**
**Review System:**

1. **Review Storage:**
   - Store: (review_id, hotel_id, guest_id, rating, title, content, date)
   - Rating: 1-5 stars
   - Only verified guests can review

2. **Rating Calculation:**
   - Average rating: sum(ratings) / count
   - Update on new review
   - Show rating breakdown (5 stars: 40%, 4 stars: 30%, etc.)

3. **Review Moderation:**
   - Flag suspicious reviews (fake, spam)
   - Manual review by moderators
   - Remove fake reviews

4. **Review Display:**
   - Show most helpful reviews first
   - Show recent reviews
   - Show reviews by rating (5 stars, 1 star)
   - Show verified purchase badge

**Real-world Example:**
Hotel: 4.5 stars from 1000+ reviews. 40% 5-star, 30% 4-star, 20% 3-star, 10% 2-star.

#### 25.6 How do you handle special requests and preferences?

**Answer:**
**Preferences System:**

1. **Special Requests:**
   - Room preferences: High floor, quiet room, near elevator
   - Bed preferences: King bed, twin beds
   - Accessibility: Wheelchair accessible, grab bars
   - Amenities: Crib, high chair, pet-friendly

2. **Storage:**
   - Store in booking: (booking_id, special_requests, preferences)
   - Share with hotel staff
   - Confirm fulfillment

3. **Fulfillment:**
   - Hotel confirms special requests
   - Prepare room in advance
   - Alert staff of accessibility needs

4. **Communication:**
   - Send special requests to hotel
   - Confirm fulfillment before check-in
   - Alert guest if can't fulfill

**Real-world Example:**
Booking: High floor, king bed, wheelchair accessible. Hotel confirms all requests.

#### 25.7 How would you design for loyalty programs?

**Answer:**
**Loyalty Program:**

1. **Membership Tiers:**
   - Silver: 0-10 nights/year
   - Gold: 10-25 nights/year
   - Platinum: 25+ nights/year

2. **Benefits:**
   - Silver: 5% discount, free WiFi
   - Gold: 10% discount, free WiFi, room upgrade
   - Platinum: 15% discount, free WiFi, room upgrade, late checkout

3. **Points System:**
   - Earn 1 point per $1 spent
   - Redeem 100 points = $10 discount
   - Bonus points: 2x during promotions

4. **Tracking:**
   - Track points per member
   - Track tier status
   - Notify of tier upgrades
   - Expire points after 2 years

**Real-world Example:**
Gold member: 10% discount + room upgrade. Earn 450 points on $450 booking.

#### 25.8 How do you handle inventory across multiple channels?

**Answer:**
**Multi-Channel Inventory:**

1. **Channels:**
   - Direct booking (hotel website)
   - OTA (Booking.com, Expedia)
   - Travel agencies
   - Corporate bookings

2. **Inventory Sync:**
   - Central inventory system
   - Sync across all channels
   - Real-time updates
   - Prevent overbooking

3. **Channel Manager:**
   - Manage rates per channel
   - Manage availability per channel
   - Set channel-specific policies
   - Track bookings per channel

4. **Overbooking Prevention:**
   - Lock inventory on booking
   - Sync across channels immediately
   - Prevent double booking
   - Handle conflicts

**Real-world Example:**
100 rooms available. 50 booked on Booking.com, 30 on Expedia, 20 direct. Total: 100 (no overbooking).

---

## Bonus: Quick Prep Questions {#bonus-quick-prep-questions}

### Estimation Questions

#### How many requests per second for Twitter?

**Answer:**
- Daily active users: 300M
- Tweets per user per day: 1
- Total tweets per day: 300M
- Tweets per second: 300M / 86,400 ≈ 3,500 TPS
- Peak hours (5x): 17,500 TPS
- Add retweets, likes, searches: 50,000+ TPS at peak

**Real-world:** Twitter handles 500K+ TPS at peak.

#### Storage required for Google Photos?

**Answer:**
- Users: 2B
- Photos per user: 1000
- Total photos: 2T
- Average photo size: 2MB
- Total storage: 2T × 2MB = 4 Exabytes
- With 3x replication: 12 Exabytes

**Real-world:** Google Photos stores 1T+ photos.

#### Bandwidth for Netflix streaming?

**Answer:**
- Concurrent users: 200M
- Average bitrate: 5 Mbps
- Total bandwidth: 200M × 5 Mbps = 1 Exabit/s
- Peak hours (2x): 2 Exabits/s

**Real-world:** Netflix uses 50% of internet bandwidth during peak hours.

#### Servers needed for WhatsApp?

**Answer:**
- Concurrent connections: 100M
- Connections per server: 10K
- Servers needed: 100M / 10K = 10K servers
- Add redundancy (2x): 20K servers
- Add for different regions: 50K+ servers

**Real-world:** WhatsApp uses 50K+ servers globally.

### Database Choice Scenarios

#### When to use MongoDB vs PostgreSQL?

**Answer:**
- **MongoDB:**
  - Unstructured data (JSON documents)
  - Flexible schema
  - Horizontal scaling needed
  - High write throughput
  - Example: User profiles, social media posts

- **PostgreSQL:**
  - Structured data (relational)
  - ACID transactions required
  - Complex queries
  - Strong consistency needed
  - Example: Banking, financial transactions

#### When to use Cassandra vs DynamoDB?

**Answer:**
- **Cassandra:**
  - Open-source, self-hosted
  - Multi-region replication
  - High write throughput
  - Time-series data
  - Example: Analytics, metrics

- **DynamoDB:**
  - Managed service (AWS)
  - Automatic scaling
  - Simple queries
  - Pay-per-request pricing
  - Example: Mobile apps, real-time data

#### When to use Redis vs Memcached?

**Answer:**
- **Redis:**
  - Persistent storage
  - Complex data structures (lists, sets, hashes)
  - Pub/sub messaging
  - Transactions
  - Example: Session storage, real-time analytics

- **Memcached:**
  - In-memory only
  - Simple key-value
  - Distributed caching
  - Lower latency
  - Example: Cache layer, session storage

### Common Follow-up Questions

#### How would you handle failure scenarios?

**Answer:**
- **Server failure:** Use load balancer, failover to replica
- **Database failure:** Use replication, failover to replica
- **Network partition:** Use circuit breaker, timeout, retry
- **Cascading failure:** Use bulkhead pattern, rate limiting
- **Data loss:** Use backup, replication, WAL (Write-Ahead Logging)

#### What are the bottlenecks in your design?

**Answer:**
- **Database:** Slow queries, high load
- **Network:** Bandwidth limitations
- **Cache:** Cache misses, eviction
- **CPU:** High CPU usage
- **Memory:** Memory leaks, insufficient RAM

**Solutions:**
- Add caching layer
- Optimize queries
- Add database replicas
- Horizontal scaling
- CDN for static content

#### How would you monitor this system?

**Answer:**
- **Metrics:** Latency, throughput, error rate, CPU, memory
- **Logging:** Centralized logging (ELK Stack)
- **Tracing:** Distributed tracing (Jaeger)
- **Alerting:** Alert on anomalies
- **Dashboards:** Real-time monitoring

**Tools:** Prometheus, Datadog, New Relic, CloudWatch

#### How would you test this system at scale?

**Answer:**
- **Load testing:** Simulate 100K+ concurrent users
- **Stress testing:** Push beyond capacity
- **Chaos engineering:** Inject failures
- **Soak testing:** Run for 24+ hours
- **Spike testing:** Sudden traffic increase

**Tools:** JMeter, Locust, Gatling, Chaos Monkey

#### What would you improve with more time?

**Answer:**
- Add machine learning for recommendations
- Implement advanced caching strategies
- Add more comprehensive monitoring
- Improve disaster recovery
- Add multi-region deployment
- Optimize database queries
- Implement advanced security measures

---

## Tips for System Design Interviews {#tips-for-system-design-interviews}

### 1. Always start with requirements clarification
- Ask about functional requirements
- Ask about non-functional requirements
- Clarify scale and constraints
- Understand use cases

### 2. Do capacity estimation before diving deep
- Estimate DAU, QPS, storage
- Calculate bandwidth
- Determine server count
- Identify bottlenecks

### 3. Draw diagrams to explain your architecture
- High-level architecture
- Component interactions
- Data flow
- Deployment topology

### 4. Discuss trade-offs explicitly
- Consistency vs availability
- Latency vs throughput
- Cost vs performance
- Simplicity vs scalability

### 5. Start simple, then add complexity
- Start with basic design
- Identify bottlenecks
- Add caching layer
- Add database replicas
- Add load balancing
- Add CDN

### 6. Mention failure scenarios and how you handle them
- Server failures
- Database failures
- Network partitions
- Cascading failures
- Data loss

### 7. Be prepared to scale your design
- Horizontal vs vertical scaling
- Database sharding
- Caching strategies
- Load balancing
- CDN usage

### 8. Know your databases and when to use them
- SQL vs NoSQL
- Relational vs document
- Consistency models
- Replication strategies
- Sharding approaches

---

**End of Complete System Design Interview Guide**

This comprehensive guide covers:
- 13 core system design concepts
- 13 detailed case studies (sections 11-25)
- Bonus quick prep questions
- Database choice scenarios
- Common follow-up questions
- Interview tips and best practices

Total: 25+ major topics with practical implementations, real-world examples, and scalability strategies for complete system design interview preparation.
