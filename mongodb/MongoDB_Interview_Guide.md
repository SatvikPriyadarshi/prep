# MongoDB Interview Guide: Basic to Advanced

## Table of Contents
1. [Basic MongoDB](#basic-mongodb)
2. [CRUD Operations](#crud-operations)
3. [Querying & Filtering](#querying--filtering)
4. [Indexing & Performance](#indexing--performance)
5. [Aggregation Framework](#aggregation-framework)
6. [Transactions & ACID](#transactions--acid)
7. [Replication](#replication)
8. [Sharding](#sharding)
9. [Security](#security)
10. [Advanced Concepts](#advanced-concepts)

---

## BASIC MONGODB

### Q1: What is MongoDB and what are its key features?

**Answer:**
MongoDB is a NoSQL document-oriented database that stores data in JSON-like documents (BSON format). Key features include:

- **Document-oriented**: Stores data as flexible JSON documents
- **Schema-less**: No predefined schema required
- **Scalability**: Horizontal scaling through sharding
- **Replication**: Built-in replication for high availability
- **Indexing**: Support for various index types
- **Aggregation**: Powerful aggregation framework for data processing
- **Transactions**: ACID transactions support (4.0+)

```javascript
// Example MongoDB document
{
  _id: ObjectId("507f1f77bcf86cd799439011"),
  name: "John Doe",
  email: "john@example.com",
  age: 30,
  address: {
    street: "123 Main St",
    city: "New York",
    country: "USA"
  },
  hobbies: ["reading", "gaming", "coding"],
  createdAt: ISODate("2024-01-24T10:00:00Z")
}
```

### Q2: What is the difference between MongoDB and SQL databases?

**Answer:**

| Feature | MongoDB | SQL |
|---------|---------|-----|
| Data Model | Document (JSON) | Relational (Tables) |
| Schema | Flexible/Schema-less | Fixed Schema |
| Scalability | Horizontal (Sharding) | Vertical |
| Transactions | ACID (4.0+) | ACID |
| Joins | Embedded docs/Lookup | Foreign Keys |
| Query Language | MongoDB Query Language | SQL |
| Consistency | Eventual | Strong |

```javascript
// MongoDB - Embedded document
{
  _id: 1,
  name: "John",
  address: {
    street: "123 Main",
    city: "NYC"
  }
}

// SQL - Normalized tables
Users table:
| id | name |
| 1  | John |

Addresses table:
| id | user_id | street    | city |
| 1  | 1       | 123 Main  | NYC  |
```

### Q3: What is BSON and why is it used?

**Answer:**
BSON (Binary JSON) is a binary-encoded serialization format used by MongoDB. It extends JSON with additional data types.

```javascript
// BSON advantages:
// 1. Efficient storage and transmission
// 2. Supports additional data types (Date, ObjectId, Binary, etc.)
// 3. Faster parsing than JSON
// 4. Preserves type information

// BSON data types
{
  _id: ObjectId("507f1f77bcf86cd799439011"),
  name: "John",
  age: 30,
  salary: NumberDecimal("50000.50"),
  joinDate: ISODate("2024-01-24T10:00:00Z"),
  isActive: true,
  tags: ["developer", "senior"],
  metadata: BinData(0, "base64encodeddata"),
  nullField: null,
  timestamp: Timestamp(1234567890, 1)
}
```

### Q4: What is ObjectId and how is it generated?

**Answer:**
ObjectId is a 12-byte unique identifier automatically generated for each document. It's the default _id field.

```javascript
// ObjectId structure (12 bytes):
// - 4 bytes: Timestamp (seconds since epoch)
// - 5 bytes: Random value
// - 3 bytes: Counter (starts random, increments)

// Example
const id = ObjectId("507f1f77bcf86cd799439011");

// ObjectId properties
id.getTimestamp(); // Returns the timestamp
id.toString();     // "507f1f77bcf86cd799439011"

// Creating ObjectId
const newId = new ObjectId();
const customId = new ObjectId("507f1f77bcf86cd799439011");

// ObjectId is sortable by creation time
// Useful for time-based queries
```

### Q5: What are collections and databases in MongoDB?

**Answer:**
- **Database**: Container for collections (similar to schema in SQL)
- **Collection**: Container for documents (similar to table in SQL)

```javascript
// Database structure
myapp (database)
├── users (collection)
│   ├── { _id: 1, name: "John" }
│   └── { _id: 2, name: "Jane" }
├── posts (collection)
│   ├── { _id: 1, title: "Post 1" }
│   └── { _id: 2, title: "Post 2" }
└── comments (collection)
    ├── { _id: 1, text: "Comment 1" }
    └── { _id: 2, text: "Comment 2" }

// Accessing database and collection
use myapp;
db.users.find();
db.posts.find();
```



---

## CRUD OPERATIONS

### Q6: How do you insert documents in MongoDB?

**Answer:**
MongoDB provides several methods to insert documents into a collection.

```javascript
// insertOne - insert single document
db.users.insertOne({
  name: "John",
  email: "john@example.com",
  age: 30
});

// insertMany - insert multiple documents
db.users.insertMany([
  { name: "John", age: 30 },
  { name: "Jane", age: 25 },
  { name: "Bob", age: 35 }
]);

// insert (deprecated) - insert one or many
db.users.insert({ name: "Alice", age: 28 });

// Returned values
const result = db.users.insertOne({ name: "Charlie" });
result.insertedId; // ObjectId of inserted document

// Insert with custom _id
db.users.insertOne({
  _id: "custom-id-123",
  name: "David",
  age: 40
});

// Ordered vs Unordered insert
db.users.insertMany(
  [
    { name: "User1" },
    { name: "User2" }
  ],
  { ordered: true }  // Stop on first error
);

db.users.insertMany(
  [
    { name: "User1" },
    { name: "User2" }
  ],
  { ordered: false } // Continue on error
);
```

### Q7: How do you read/query documents in MongoDB?

**Answer:**
MongoDB provides find() method to query documents with various options.

```javascript
// Find all documents
db.users.find();

// Find with filter
db.users.find({ age: 30 });
db.users.find({ name: "John" });

// Find with multiple conditions (AND)
db.users.find({ age: 30, name: "John" });

// Find with OR condition
db.users.find({
  $or: [
    { age: 30 },
    { name: "John" }
  ]
});

// Find with comparison operators
db.users.find({ age: { $gt: 25 } });      // greater than
db.users.find({ age: { $gte: 25 } });     // greater than or equal
db.users.find({ age: { $lt: 35 } });      // less than
db.users.find({ age: { $lte: 35 } });     // less than or equal
db.users.find({ age: { $eq: 30 } });      // equal
db.users.find({ age: { $ne: 30 } });      // not equal

// Find with IN operator
db.users.find({ age: { $in: [25, 30, 35] } });
db.users.find({ age: { $nin: [25, 30] } }); // not in

// Find with regex
db.users.find({ name: /john/i }); // case-insensitive

// Find with array operators
db.users.find({ hobbies: "reading" });
db.users.find({ hobbies: { $all: ["reading", "gaming"] } });
db.users.find({ hobbies: { $size: 3 } });

// Find with projection (select fields)
db.users.find({}, { name: 1, age: 1, _id: 0 });

// Find with limit and skip
db.users.find().limit(10).skip(20);

// Find with sort
db.users.find().sort({ age: 1 });   // ascending
db.users.find().sort({ age: -1 });  // descending

// Find one document
db.users.findOne({ name: "John" });

// Count documents
db.users.countDocuments({ age: { $gt: 25 } });
```

### Q8: How do you update documents in MongoDB?

**Answer:**
MongoDB provides several update methods with various operators.

```javascript
// updateOne - update first matching document
db.users.updateOne(
  { name: "John" },
  { $set: { age: 31 } }
);

// updateMany - update all matching documents
db.users.updateMany(
  { age: { $lt: 30 } },
  { $set: { status: "junior" } }
);

// Update operators
// $set - set field value
db.users.updateOne(
  { _id: 1 },
  { $set: { age: 31, city: "NYC" } }
);

// $unset - remove field
db.users.updateOne(
  { _id: 1 },
  { $unset: { age: "" } }
);

// $inc - increment field
db.users.updateOne(
  { _id: 1 },
  { $inc: { age: 1 } }
);

// $push - add element to array
db.users.updateOne(
  { _id: 1 },
  { $push: { hobbies: "reading" } }
);

// $pull - remove element from array
db.users.updateOne(
  { _id: 1 },
  { $pull: { hobbies: "reading" } }
);

// $addToSet - add element if not exists
db.users.updateOne(
  { _id: 1 },
  { $addToSet: { hobbies: "reading" } }
);

// $pop - remove first/last element
db.users.updateOne(
  { _id: 1 },
  { $pop: { hobbies: 1 } }  // 1 for last, -1 for first
);

// replaceOne - replace entire document
db.users.replaceOne(
  { _id: 1 },
  { name: "John", age: 31, city: "NYC" }
);

// findOneAndUpdate - update and return document
db.users.findOneAndUpdate(
  { name: "John" },
  { $set: { age: 31 } },
  { returnDocument: "after" }
);

// Upsert - update or insert
db.users.updateOne(
  { email: "john@example.com" },
  { $set: { name: "John", age: 30 } },
  { upsert: true }
);
```

### Q9: How do you delete documents in MongoDB?

**Answer:**
MongoDB provides deleteOne and deleteMany methods.

```javascript
// deleteOne - delete first matching document
db.users.deleteOne({ name: "John" });

// deleteMany - delete all matching documents
db.users.deleteMany({ age: { $lt: 18 } });

// Delete all documents
db.users.deleteMany({});

// findOneAndDelete - delete and return document
const deleted = db.users.findOneAndDelete({ name: "John" });

// Delete with multiple conditions
db.users.deleteMany({
  $or: [
    { age: { $lt: 18 } },
    { status: "inactive" }
  ]
});

// Bulk delete operations
db.users.bulkWrite([
  { deleteOne: { filter: { age: { $lt: 18 } } } },
  { deleteOne: { filter: { status: "inactive" } } }
]);
```

### Q10: What are bulk operations in MongoDB?

**Answer:**
Bulk operations allow multiple write operations in a single request for better performance.

```javascript
// Ordered bulk operations (stop on first error)
const bulk = db.users.initializeOrderedBulkOp();
bulk.insert({ name: "User1" });
bulk.insert({ name: "User2" });
bulk.find({ name: "User1" }).updateOne({ $set: { age: 30 } });
bulk.find({ name: "User2" }).deleteOne();
bulk.execute();

// Unordered bulk operations (continue on error)
const bulk = db.users.initializeUnorderedBulkOp();
bulk.insert({ name: "User1" });
bulk.find({ name: "User1" }).updateOne({ $set: { age: 30 } });
bulk.execute();

// bulkWrite method
db.users.bulkWrite([
  { insertOne: { document: { name: "User1" } } },
  { updateOne: { filter: { name: "User1" }, update: { $set: { age: 30 } } } },
  { deleteOne: { filter: { name: "User2" } } }
]);

// Benefits:
// 1. Reduced network round trips
// 2. Better performance
// 3. Atomic operations
// 4. Error handling
```



---

## QUERYING & FILTERING

### Q11: What are query operators in MongoDB?

**Answer:**
Query operators allow you to filter documents with various conditions.

```javascript
// Comparison operators
db.users.find({ age: { $gt: 25 } });      // greater than
db.users.find({ age: { $gte: 25 } });     // greater than or equal
db.users.find({ age: { $lt: 35 } });      // less than
db.users.find({ age: { $lte: 35 } });     // less than or equal
db.users.find({ age: { $eq: 30 } });      // equal
db.users.find({ age: { $ne: 30 } });      // not equal

// Logical operators
db.users.find({
  $and: [
    { age: { $gt: 25 } },
    { status: 'active' }
  ]
});

db.users.find({
  $or: [
    { age: { $gt: 25 } },
    { status: 'premium' }
  ]
});

db.users.find({
  $nor: [
    { age: { $lt: 18 } },
    { status: 'banned' }
  ]
});

db.users.find({
  $not: { age: { $gt: 25 } }
});

// Array operators
db.users.find({ hobbies: 'reading' });
db.users.find({ hobbies: { $all: ['reading', 'gaming'] } });
db.users.find({ hobbies: { $in: ['reading', 'gaming'] } });
db.users.find({ hobbies: { $nin: ['reading'] } });
db.users.find({ hobbies: { $size: 3 } });
db.users.find({ hobbies: { $elemMatch: { $gt: 5 } } });

// Element operators
db.users.find({ email: { $exists: true } });
db.users.find({ age: { $type: 'int' } });

// Regex operator
db.users.find({ name: { $regex: '^John', $options: 'i' } });
db.users.find({ name: /john/i });

// Text search
db.users.find({ $text: { $search: 'john' } });
```

### Q12: What is indexing and why is it important?

**Answer:**
Indexes improve query performance by allowing MongoDB to locate data without scanning every document.

```javascript
// Create index
db.users.createIndex({ email: 1 });
db.users.createIndex({ age: 1, name: 1 }); // compound index

// Index types
// 1 = ascending, -1 = descending
db.users.createIndex({ age: 1 });
db.users.createIndex({ age: -1 });

// Unique index
db.users.createIndex({ email: 1 }, { unique: true });

// Sparse index (only indexes documents with the field)
db.users.createIndex({ phone: 1 }, { sparse: true });

// TTL index (auto-delete documents after time)
db.sessions.createIndex({ createdAt: 1 }, { expireAfterSeconds: 3600 });

// Text index
db.articles.createIndex({ title: 'text', content: 'text' });

// Geospatial index
db.locations.createIndex({ coordinates: '2dsphere' });

// View indexes
db.users.getIndexes();

// Drop index
db.users.dropIndex('email_1');
db.users.dropIndexes(); // drop all except _id

// Index statistics
db.users.aggregate([{ $indexStats: {} }]);

// Benefits of indexing:
// 1. Faster queries
// 2. Reduced CPU usage
// 3. Better performance for sorting
// 4. Enables efficient range queries

// Drawbacks:
// 1. Slower writes (index must be updated)
// 2. More disk space
// 3. Index maintenance overhead
```

### Q13: What is projection and how do you use it?

**Answer:**
Projection allows you to select which fields to include or exclude in query results.

```javascript
// Include specific fields
db.users.find({}, { name: 1, email: 1 });

// Exclude specific fields
db.users.find({}, { password: 0, ssn: 0 });

// Include _id and exclude others
db.users.find({}, { _id: 1, name: 1 });

// Exclude _id
db.users.find({}, { name: 1, email: 1, _id: 0 });

// Nested field projection
db.users.find({}, { 'address.city': 1, name: 1 });

// Array projection
db.users.find({}, { hobbies: { $slice: 2 } }); // first 2 elements
db.users.find({}, { hobbies: { $slice: [1, 2] } }); // skip 1, take 2

// Conditional projection
db.users.find({}, {
  name: 1,
  status: { $cond: [{ $gte: ['$age', 18] }, 'adult', 'minor'] }
});

// Projection with aggregation
db.users.aggregate([
  {
    $project: {
      name: 1,
      email: 1,
      fullName: { $concat: ['$firstName', ' ', '$lastName'] }
    }
  }
]);
```

### Q14: What is sorting and pagination?

**Answer:**
Sorting and pagination help organize and display large datasets efficiently.

```javascript
// Sorting
db.users.find().sort({ age: 1 });      // ascending
db.users.find().sort({ age: -1 });     // descending
db.users.find().sort({ age: 1, name: 1 }); // multiple fields

// Pagination with skip and limit
const page = 2;
const pageSize = 10;
const skip = (page - 1) * pageSize;

db.users.find()
  .skip(skip)
  .limit(pageSize)
  .sort({ createdAt: -1 });

// Pagination example
function getPaginatedUsers(page = 1, pageSize = 10) {
  const skip = (page - 1) * pageSize;
  
  const users = db.users.find()
    .skip(skip)
    .limit(pageSize)
    .toArray();
  
  const total = db.users.countDocuments();
  
  return {
    users,
    total,
    pages: Math.ceil(total / pageSize),
    currentPage: page
  };
}

// Cursor-based pagination (better for large datasets)
db.users.find({ _id: { $gt: lastId } })
  .limit(10)
  .sort({ _id: 1 });
```

### Q15: What is aggregation and how does it work?

**Answer:**
Aggregation framework processes documents through a pipeline of stages to transform and analyze data.

```javascript
// Basic aggregation
db.users.aggregate([
  { $match: { age: { $gt: 25 } } },
  { $group: { _id: '$status', count: { $sum: 1 } } },
  { $sort: { count: -1 } }
]);

// Aggregation stages
// $match - filter documents
db.users.aggregate([
  { $match: { age: { $gt: 25 } } }
]);

// $group - group documents
db.users.aggregate([
  { $group: { _id: '$status', count: { $sum: 1 } } }
]);

// $project - reshape documents
db.users.aggregate([
  { $project: { name: 1, age: 1, _id: 0 } }
]);

// $sort - sort documents
db.users.aggregate([
  { $sort: { age: -1 } }
]);

// $limit - limit documents
db.users.aggregate([
  { $limit: 10 }
]);

// $skip - skip documents
db.users.aggregate([
  { $skip: 20 }
]);

// $lookup - join collections
db.users.aggregate([
  {
    $lookup: {
      from: 'posts',
      localField: '_id',
      foreignField: 'userId',
      as: 'userPosts'
    }
  }
]);

// $unwind - deconstruct array
db.users.aggregate([
  { $unwind: '$hobbies' },
  { $group: { _id: '$hobbies', count: { $sum: 1 } } }
]);

// Complex aggregation example
db.orders.aggregate([
  { $match: { status: 'completed' } },
  { $group: { _id: '$customerId', total: { $sum: '$amount' } } },
  { $sort: { total: -1 } },
  { $limit: 10 },
  {
    $lookup: {
      from: 'customers',
      localField: '_id',
      foreignField: '_id',
      as: 'customer'
    }
  },
  { $unwind: '$customer' },
  {
    $project: {
      customerName: '$customer.name',
      totalSpent: '$total',
      _id: 0
    }
  }
]);
```

### Q16: What are transactions in MongoDB?

**Answer:**
Transactions ensure ACID properties for multi-document operations.

```javascript
// Start session
const session = db.getMongo().startSession();

// Transaction
session.startTransaction();

try {
  db.users.updateOne(
    { _id: 1 },
    { $inc: { balance: -100 } },
    { session }
  );
  
  db.users.updateOne(
    { _id: 2 },
    { $inc: { balance: 100 } },
    { session }
  );
  
  session.commitTransaction();
} catch (error) {
  session.abortTransaction();
  throw error;
} finally {
  session.endSession();
}

// Transaction with Node.js driver
const session = client.startSession();

try {
  await session.withTransaction(async () => {
    await usersCollection.updateOne(
      { _id: 1 },
      { $inc: { balance: -100 } },
      { session }
    );
    
    await usersCollection.updateOne(
      { _id: 2 },
      { $inc: { balance: 100 } },
      { session }
    );
  });
} finally {
  await session.endSession();
}

// Transaction options
session.startTransaction({
  readConcern: { level: 'snapshot' },
  writeConcern: { w: 'majority' },
  readPreference: 'primary'
});
```

### Q17: What is data validation in MongoDB?

**Answer:**
Schema validation ensures data integrity by enforcing rules on documents.

```javascript
// Create collection with validation
db.createCollection('users', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      required: ['name', 'email'],
      properties: {
        _id: { bsonType: 'objectId' },
        name: {
          bsonType: 'string',
          description: 'must be a string and is required'
        },
        email: {
          bsonType: 'string',
          pattern: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$',
          description: 'must be a valid email'
        },
        age: {
          bsonType: 'int',
          minimum: 0,
          maximum: 150
        },
        status: {
          enum: ['active', 'inactive', 'banned'],
          description: 'can only be one of the enum values'
        },
        hobbies: {
          bsonType: 'array',
          items: { bsonType: 'string' }
        },
        address: {
          bsonType: 'object',
          properties: {
            street: { bsonType: 'string' },
            city: { bsonType: 'string' },
            country: { bsonType: 'string' }
          }
        }
      }
    }
  }
});

// Update validation
db.runCommand({
  collMod: 'users',
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      required: ['name', 'email', 'age']
    }
  }
});

// Validation action
db.runCommand({
  collMod: 'users',
  validator: { /* schema */ },
  validationAction: 'warn', // 'error' or 'warn'
  validationLevel: 'moderate' // 'strict' or 'moderate'
});
```

### Q18: What is backup and restore in MongoDB?

**Answer:**
Backup and restore operations ensure data safety and recovery.

```javascript
// Backup using mongodump
// Command line: mongodump --db myapp --out ./backup

// Restore using mongorestore
// Command line: mongorestore --db myapp ./backup/myapp

// Backup specific collection
// mongodump --db myapp --collection users --out ./backup

// Restore specific collection
// mongorestore --db myapp --collection users ./backup/myapp/users.bson

// Backup with compression
// mongodump --db myapp --archive=backup.archive --gzip

// Restore from compressed backup
// mongorestore --archive=backup.archive --gzip

// Backup with authentication
// mongodump --username user --password pass --db myapp

// Point-in-time recovery (with oplog)
// mongodump --oplog --out ./backup
// mongorestore --oplogReplay ./backup

// Backup strategies:
// 1. Full backup - backup entire database
// 2. Incremental backup - backup only changes
// 3. Differential backup - backup since last full backup
// 4. Continuous backup - real-time backup
```

### Q19: What is replication in MongoDB?

**Answer:**
Replication provides redundancy and high availability by maintaining multiple copies of data.

```javascript
// Replica set configuration
rs.initiate({
  _id: 'myReplicaSet',
  members: [
    { _id: 0, host: 'localhost:27017' },
    { _id: 1, host: 'localhost:27018' },
    { _id: 2, host: 'localhost:27019' }
  ]
});

// Check replica set status
rs.status();

// Check replica set configuration
rs.conf();

// Add member to replica set
rs.add('localhost:27020');

// Remove member from replica set
rs.remove('localhost:27020');

// Replica set roles:
// 1. Primary - accepts writes and reads
// 2. Secondary - replicates from primary, read-only
// 3. Arbiter - votes in elections, no data

// Failover process:
// 1. Primary becomes unavailable
// 2. Secondaries detect primary is down
// 3. Election held among secondaries
// 4. New primary elected
// 5. Writes resume on new primary

// Read preference
db.collection.find().readPref('primary');
db.collection.find().readPref('primaryPreferred');
db.collection.find().readPref('secondary');
db.collection.find().readPref('secondaryPreferred');
db.collection.find().readPref('nearest');

// Write concern
db.collection.insertOne(
  { name: 'John' },
  { writeConcern: { w: 'majority', j: true } }
);
```

### Q20: What is sharding in MongoDB?

**Answer:**
Sharding distributes data across multiple servers for horizontal scalability.

```javascript
// Enable sharding on database
sh.enableSharding('myapp');

// Shard a collection
sh.shardCollection('myapp.users', { _id: 'hashed' });

// Shard key strategies
// 1. Range-based sharding
sh.shardCollection('myapp.users', { age: 1 });

// 2. Hash-based sharding
sh.shardCollection('myapp.users', { _id: 'hashed' });

// 3. Compound shard key
sh.shardCollection('myapp.users', { country: 1, city: 1 });

// Check sharding status
sh.status();

// Add shard
sh.addShard('shard1/localhost:27017');
sh.addShard('shard2/localhost:27018');

// Remove shard
sh.removeShard('shard1');

// Shard key considerations:
// 1. High cardinality - many unique values
// 2. Evenly distributed - avoid hotspots
// 3. Monotonically increasing - avoid jumbo chunks
// 4. Immutable - cannot change after sharding

// Chunk management
db.adminCommand({ split: 'myapp.users', middle: { _id: 500 } });

// Balancer
sh.startBalancer();
sh.stopBalancer();
sh.getBalancerState();

// Sharding benefits:
// 1. Horizontal scalability
// 2. Distributed load
// 3. Increased throughput
// 4. Larger datasets

// Sharding challenges:
// 1. Complex queries
// 2. Distributed transactions
// 3. Shard key selection
// 4. Operational complexity
```

