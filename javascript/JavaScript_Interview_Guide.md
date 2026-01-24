# JavaScript Interview Guide: Basic to Advanced

## Table of Contents
1. [Basic JavaScript](#basic-javascript)
2. [Functions](#functions)
3. [Objects & Prototypes](#objects--prototypes)
4. [Arrays & Methods](#arrays--methods)
5. [Scope & Closures](#scope--closures)
6. [Asynchronous JavaScript](#asynchronous-javascript)
7. [ES6+ Features](#es6-features)
8. [DOM Manipulation](#dom-manipulation)
9. [Error Handling](#error-handling)
10. [Advanced Concepts](#advanced-concepts)
11. [Performance & Optimization](#performance--optimization)
12. [Browser APIs](#browser-apis)

---

## BASIC JAVASCRIPT

### Q1: What is JavaScript and what are its key characteristics?

**Answer:**
JavaScript is a lightweight, interpreted, dynamically-typed programming language primarily used for web development. Key characteristics include:

- **Dynamically Typed**: Variables can hold any data type and can change types at runtime
- **Prototype-based**: Objects inherit directly from other objects (not classes in traditional sense)
- **First-class Functions**: Functions are objects and can be passed as arguments
- **Event-driven**: Can respond to user interactions
- **Asynchronous**: Supports callbacks, promises, and async/await
- **Single-threaded**: Executes code in a single thread with an event loop

```javascript
// Example of dynamic typing
let x = 5;           // number
x = "hello";         // string
x = true;            // boolean
x = { name: "John" }; // object
```

### Q2: What are the different data types in JavaScript?

**Answer:**
JavaScript has 8 data types:

**Primitive Types (7):**
1. **String**: Text data enclosed in quotes
2. **Number**: Integer or floating-point numbers
3. **Boolean**: true or false
4. **Undefined**: Variable declared but not assigned
5. **Null**: Intentional absence of value
6. **Symbol**: Unique identifier (ES6+)
7. **BigInt**: Large integers beyond Number.MAX_SAFE_INTEGER

**Non-Primitive Type (1):**
8. **Object**: Collections of key-value pairs (includes arrays, functions, dates, etc.)

```javascript
// Primitive types
const str = "hello";
const num = 42;
const bool = true;
let undef;
const nothing = null;
const sym = Symbol("id");
const bigNum = 123456789012345678901234567890n;

// Non-primitive
const obj = { name: "John" };
const arr = [1, 2, 3];
const func = () => {};

// Check types
console.log(typeof str);      // "string"
console.log(typeof num);      // "number"
console.log(typeof bool);     // "boolean"
console.log(typeof undef);    // "undefined"
console.log(typeof nothing);  // "object" (quirk in JS)
console.log(typeof sym);      // "symbol"
console.log(typeof bigNum);   // "bigint"
console.log(typeof obj);      // "object"
```

### Q3: What is the difference between == and === in JavaScript?

**Answer:**
- **==** (Loose Equality): Compares values after type coercion
- **===** (Strict Equality): Compares both value and type without coercion

```javascript
console.log(5 == "5");      // true (type coercion)
console.log(5 === "5");     // false (different types)

console.log(0 == false);    // true (coercion)
console.log(0 === false);   // false

console.log(null == undefined);   // true
console.log(null === undefined);  // false

console.log("" == 0);       // true
console.log("" === 0);      // false

// Best practice: Always use === to avoid unexpected behavior
```

### Q4: What is hoisting in JavaScript?

**Answer:**
Hoisting is JavaScript's behavior of moving declarations to the top of their scope before code execution. However, only declarations are hoisted, not initializations.

```javascript
// Variable hoisting with var
console.log(x); // undefined (not an error)
var x = 5;
console.log(x); // 5

// This is interpreted as:
// var x;
// console.log(x); // undefined
// x = 5;
// console.log(x); // 5

// Function hoisting
sayHi(); // "Hello" - works fine
function sayHi() {
  console.log("Hello");
}

// Function expression hoisting
sayBye(); // TypeError: sayBye is not a function
var sayBye = function() {
  console.log("Bye");
};

// let and const hoisting (Temporal Dead Zone)
console.log(y); // ReferenceError
let y = 10;
```

### Q5: What is the Temporal Dead Zone (TDZ)?

**Answer:**
The Temporal Dead Zone is the period between entering a scope and reaching the declaration of a let/const variable. Accessing the variable during this period throws a ReferenceError.

```javascript
console.log(typeof x); // ReferenceError (not undefined)
let x = 5;

// Why? Because let/const are hoisted but not initialized
// They exist in the TDZ from scope start until declaration

function example() {
  console.log(x); // ReferenceError - in TDZ
  let x = 10;
}

// var doesn't have TDZ
function example2() {
  console.log(y); // undefined (hoisted and initialized to undefined)
  var y = 10;
}
```

### Q6: What are the differences between var, let, and const?

**Answer:**

| Feature | var | let | const |
|---------|-----|-----|-------|
| Scope | Function | Block | Block |
| Hoisting | Yes (initialized to undefined) | Yes (TDZ) | Yes (TDZ) |
| Re-declaration | Yes | No | No |
| Re-assignment | Yes | Yes | No |
| Initialization | Optional | Optional | Required |

```javascript
// var - function scoped
function test1() {
  if (true) {
    var x = 1;
  }
  console.log(x); // 1 (accessible outside block)
}

// let - block scoped
function test2() {
  if (true) {
    let y = 2;
  }
  console.log(y); // ReferenceError
}

// const - block scoped, cannot be reassigned
const z = 3;
z = 4; // TypeError

// But const objects can be mutated
const obj = { name: "John" };
obj.name = "Jane"; // OK
obj = {}; // TypeError

// Best practice: Use const by default, let when reassignment needed, avoid var
```

### Q7: What is NaN and how do you check for it?

**Answer:**
NaN stands for "Not-a-Number" and represents an undefined or unrepresentable numerical result. Interestingly, `typeof NaN` returns "number".

```javascript
console.log(NaN === NaN); // false (NaN is not equal to itself)

// Correct ways to check for NaN
console.log(isNaN(NaN));           // true
console.log(Number.isNaN(NaN));    // true (more reliable)
console.log(Object.is(NaN, NaN));  // true

// isNaN() has quirks - it coerces to number first
console.log(isNaN("hello"));       // true (coerced to NaN)
console.log(Number.isNaN("hello")); // false (no coercion)

// Best practice: Use Number.isNaN()
```

### Q8: What is the difference between null and undefined?

**Answer:**

- **undefined**: Default value for uninitialized variables, missing function parameters, or functions without return statement
- **null**: Intentional assignment representing "no value"

```javascript
let x;
console.log(x); // undefined

function test(param) {
  console.log(param); // undefined if not provided
}
test();

function noReturn() {}
console.log(noReturn()); // undefined

const y = null; // Intentional

// Comparison
console.log(null == undefined);   // true
console.log(null === undefined);  // false

// typeof difference
console.log(typeof undefined); // "undefined"
console.log(typeof null);      // "object" (historical bug)
```

### Q9: What is type coercion and give examples?

**Answer:**
Type coercion is the automatic conversion of values from one type to another. JavaScript has implicit and explicit coercion.

```javascript
// Implicit coercion
console.log("5" + 3);           // "53" (string concatenation)
console.log("5" - 3);           // 2 (numeric operation)
console.log("5" * "2");         // 10
console.log(true + 1);          // 2 (true becomes 1)
console.log(false + 1);         // 1 (false becomes 0)
console.log([] + []);           // "" (empty string)
console.log([] + {});           // "[object Object]"

// Explicit coercion
console.log(String(123));       // "123"
console.log(Number("123"));     // 123
console.log(Boolean(1));        // true
console.log(Boolean(0));        // false
console.log(Boolean(""));       // false
console.log(Boolean("hello"));  // true

// Truthy and falsy values
// Falsy: false, 0, "", null, undefined, NaN
// Truthy: everything else
```

### Q10: What is the difference between pass by value and pass by reference?

**Answer:**
- **Pass by Value**: Primitive types are copied; changes don't affect original
- **Pass by Reference**: Objects are passed by reference; changes affect original

```javascript
// Pass by value (primitives)
let a = 5;
let b = a;
b = 10;
console.log(a); // 5 (unchanged)

// Pass by reference (objects)
let obj1 = { name: "John" };
let obj2 = obj1;
obj2.name = "Jane";
console.log(obj1.name); // "Jane" (changed)

// Function parameters
function changeValue(x) {
  x = 100;
}

function changeObject(obj) {
  obj.value = 100;
}

let num = 5;
let myObj = { value: 5 };

changeValue(num);
console.log(num); // 5 (unchanged)

changeObject(myObj);
console.log(myObj.value); // 100 (changed)

// To avoid mutation, create a copy
let obj3 = { ...obj1 }; // shallow copy
let obj4 = JSON.parse(JSON.stringify(obj1)); // deep copy
```

1234567890