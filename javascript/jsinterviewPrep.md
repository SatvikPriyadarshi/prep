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



---

## FUNCTIONS

### Q11: What are the different ways to declare a function in JavaScript?

**Answer:**
There are several ways to declare functions, each with different characteristics:

```javascript
// 1. Function Declaration
function add(a, b) {
  return a + b;
}

// 2. Function Expression
const multiply = function(a, b) {
  return a * b;
};

// 3. Arrow Function (ES6+)
const subtract = (a, b) => a - b;

// 4. Named Function Expression
const divide = function divideNumbers(a, b) {
  return a / b;
};

// 5. Constructor Function
function Calculator(name) {
  this.name = name;
}

// 6. IIFE (Immediately Invoked Function Expression)
(function() {
  console.log("Runs immediately");
})();

// 7. Generator Function
function* generateNumbers() {
  yield 1;
  yield 2;
}

// 8. Async Function
async function fetchData() {
  return await fetch('/api/data');
}
```

### Q12: What is the difference between function declaration and function expression?

**Answer:**

| Aspect | Declaration | Expression |
|--------|-------------|-----------|
| Hoisting | Fully hoisted | Not hoisted (TDZ with let/const) |
| Can be called before declaration | Yes | No |
| Name requirement | Required | Optional |
| Scope | Function scoped (var) or block scoped (let/const) | Depends on variable declaration |

```javascript
// Function Declaration - hoisted
console.log(add(2, 3)); // 5 (works)
function add(a, b) {
  return a + b;
}

// Function Expression - not hoisted
console.log(multiply(2, 3)); // TypeError: multiply is not a function
const multiply = function(a, b) {
  return a * b;
};

// Named function expression - name only available inside function
const factorial = function fact(n) {
  if (n <= 1) return 1;
  return n * fact(n - 1); // 'fact' accessible here
};
console.log(typeof fact); // undefined (not accessible outside)
```

### Q13: What are arrow functions and how do they differ from regular functions?

**Answer:**
Arrow functions are a concise syntax for writing functions introduced in ES6. Key differences:

```javascript
// Regular function
const regular = function(x) {
  return x * 2;
};

// Arrow function
const arrow = (x) => x * 2;

// Key differences:

// 1. No 'this' binding - inherits from parent scope
const obj = {
  name: "John",
  regularFunc: function() {
    console.log(this.name); // "John"
  },
  arrowFunc: () => {
    console.log(this.name); // undefined (this from global scope)
  }
};

// 2. No 'arguments' object
function regular2() {
  console.log(arguments); // [1, 2, 3]
}
const arrow2 = (...args) => {
  console.log(args); // [1, 2, 3]
};

// 3. Cannot be used as constructor
const Regular = function() {
  this.value = 5;
};
new Regular(); // OK

const Arrow = () => {
  this.value = 5;
};
new Arrow(); // TypeError

// 4. No 'prototype' property
console.log(typeof regular.prototype); // "object"
console.log(typeof arrow.prototype);   // "undefined"

// 5. Syntax variations
const single = x => x * 2;           // single param, no parens
const multiple = (x, y) => x + y;    // multiple params
const noParams = () => 42;           // no params
const multiLine = (x) => {           // multi-line body
  const result = x * 2;
  return result;
};
```

### Q14: What is a callback function?

**Answer:**
A callback function is a function passed as an argument to another function, which is then invoked inside the outer function.

```javascript
// Simple callback
function greet(name, callback) {
  console.log("Hello " + name);
  callback();
}

function sayGoodbye() {
  console.log("Goodbye!");
}

greet("John", sayGoodbye);
// Output: Hello John
//         Goodbye!

// Callback with parameters
function processArray(arr, callback) {
  for (let i = 0; i < arr.length; i++) {
    callback(arr[i], i);
  }
}

processArray([1, 2, 3], (value, index) => {
  console.log(`Index ${index}: ${value}`);
});

// Callback hell (Pyramid of Doom)
function getData(callback) {
  setTimeout(() => {
    callback({ id: 1 });
  }, 1000);
}

function getUser(id, callback) {
  setTimeout(() => {
    callback({ name: "John", id });
  }, 1000);
}

// Nested callbacks - hard to read
getData((data) => {
  getUser(data.id, (user) => {
    console.log(user);
  });
});

// Solution: Use promises or async/await (covered later)
```

### Q15: What is the 'this' keyword and how does it work?

**Answer:**
The 'this' keyword refers to the object that is executing the current function. Its value depends on how the function is called.

```javascript
// 1. Global context
console.log(this); // window (browser) or global (Node.js)

// 2. Object method
const obj = {
  name: "John",
  greet: function() {
    console.log(this.name); // "John"
  }
};
obj.greet();

// 3. Function call (non-strict)
function test() {
  console.log(this); // window or global
}
test();

// 4. Function call (strict mode)
function testStrict() {
  "use strict";
  console.log(this); // undefined
}
testStrict();

// 5. Constructor
function Person(name) {
  this.name = name;
}
const person = new Person("John");
console.log(person.name); // "John"

// 6. Arrow function (inherits this)
const obj2 = {
  name: "Jane",
  greet: () => {
    console.log(this); // global (not obj2)
  }
};

// 7. Explicit binding with call, apply, bind
function introduce(greeting) {
  console.log(greeting + ", I'm " + this.name);
}

const person1 = { name: "John" };
const person2 = { name: "Jane" };

introduce.call(person1, "Hi");      // "Hi, I'm John"
introduce.apply(person2, ["Hello"]); // "Hello, I'm Jane"

const boundIntroduce = introduce.bind(person1);
boundIntroduce("Hey");              // "Hey, I'm John"
```

### Q16: What is the difference between call, apply, and bind?

**Answer:**
All three methods are used to set the 'this' context, but they differ in how they invoke the function:

```javascript
function greet(greeting, punctuation) {
  console.log(greeting + ", " + this.name + punctuation);
}

const person = { name: "John" };

// call() - invokes immediately, arguments passed individually
greet.call(person, "Hello", "!");
// Output: Hello, John!

// apply() - invokes immediately, arguments passed as array
greet.apply(person, ["Hi", "?"]);
// Output: Hi, John?

// bind() - returns new function, doesn't invoke immediately
const boundGreet = greet.bind(person, "Hey");
boundGreet(".");
// Output: Hey, John.

// Practical example: Array methods with different context
const numbers = [1, 2, 3];

function sum() {
  return this.values.reduce((a, b) => a + b);
}

const calculator = { values: [10, 20, 30] };

console.log(sum.call(calculator));    // 60
console.log(sum.apply(calculator));   // 60
const boundSum = sum.bind(calculator);
console.log(boundSum());              // 60

// bind() is useful for event handlers
const button = document.querySelector('button');
const handler = {
  name: "Button Handler",
  handleClick: function() {
    console.log(this.name + " clicked");
  }
};

// Without bind, 'this' would be the button element
button.addEventListener('click', handler.handleClick.bind(handler));
```

### Q17: What are default parameters in functions?

**Answer:**
Default parameters allow you to set default values for function parameters if no value is provided.

```javascript
// ES5 way
function greet(name) {
  name = name || "Guest";
  console.log("Hello " + name);
}

// ES6 default parameters
function greet2(name = "Guest") {
  console.log("Hello " + name);
}

greet2();        // "Hello Guest"
greet2("John");  // "Hello John"

// Default parameters can be expressions
function createUser(name = "Anonymous", role = "user", timestamp = Date.now()) {
  return { name, role, timestamp };
}

// Default parameters can reference other parameters
function createMessage(name = "User", greeting = `Hello ${name}`) {
  return greeting;
}

console.log(createMessage());           // "Hello User"
console.log(createMessage("John"));     // "Hello John"
console.log(createMessage("Jane", "Hi Jane")); // "Hi Jane"

// undefined triggers default, null doesn't
function test(x = 10) {
  console.log(x);
}

test();          // 10
test(undefined); // 10
test(null);      // null
test(0);         // 0
```

### Q18: What are rest parameters and spread operator?

**Answer:**
Rest parameters (...) collect multiple arguments into an array. The spread operator unpacks arrays/objects.

```javascript
// Rest parameters - collect arguments
function sum(...numbers) {
  return numbers.reduce((a, b) => a + b, 0);
}

console.log(sum(1, 2, 3, 4, 5)); // 15

// Rest with other parameters
function greet(greeting, ...names) {
  console.log(greeting + " " + names.join(", "));
}

greet("Hello", "John", "Jane", "Bob"); // "Hello John, Jane, Bob"

// Spread operator - unpack arrays
const arr1 = [1, 2, 3];
const arr2 = [4, 5, 6];
const combined = [...arr1, ...arr2];
console.log(combined); // [1, 2, 3, 4, 5, 6]

// Spread with function arguments
const numbers = [1, 2, 3];
console.log(Math.max(...numbers)); // 3

// Spread with objects
const obj1 = { a: 1, b: 2 };
const obj2 = { c: 3, ...obj1 };
console.log(obj2); // { c: 3, a: 1, b: 2 }

// Spread creates shallow copy
const original = [1, 2, 3];
const copy = [...original];
copy[0] = 99;
console.log(original[0]); // 1 (unchanged)

// Rest parameters must be last
function test(a, b, ...rest) {
  console.log(a, b, rest);
}
test(1, 2, 3, 4, 5); // 1, 2, [3, 4, 5]
```

### Q19: What is a pure function?

**Answer:**
A pure function always returns the same output for the same input and has no side effects (doesn't modify external state).

```javascript
// Pure function
function add(a, b) {
  return a + b;
}

// Pure function
function getFullName(firstName, lastName) {
  return firstName + " " + lastName;
}

// Impure function - depends on external state
let multiplier = 2;
function multiply(x) {
  return x * multiplier; // depends on external variable
}

// Impure function - modifies external state
const user = { name: "John" };
function updateName(newName) {
  user.name = newName; // modifies external object
}

// Impure function - has side effects
function logAndAdd(a, b) {
  console.log("Adding numbers"); // side effect
  return a + b;
}

// Pure version
function pureAdd(a, b) {
  return a + b;
}

// Benefits of pure functions:
// 1. Predictable - same input always gives same output
// 2. Testable - easy to test
// 3. Reusable - no hidden dependencies
// 4. Parallelizable - can run in parallel safely

// Example: Array methods
const numbers = [1, 2, 3, 4, 5];

// Pure - returns new array
const doubled = numbers.map(x => x * 2);
console.log(numbers); // [1, 2, 3, 4, 5] (unchanged)

// Impure - modifies original
numbers.forEach((x, i) => {
  numbers[i] = x * 2;
});
console.log(numbers); // [2, 4, 6, 8, 10] (modified)
```

### Q20: What is function composition?

**Answer:**
Function composition is combining multiple functions to create a new function. The output of one function becomes the input of the next.

```javascript
// Simple composition
const add = (x) => x + 1;
const multiply = (x) => x * 2;
const subtract = (x) => x - 3;

// Manual composition
const result = subtract(multiply(add(5)));
console.log(result); // ((5 + 1) * 2) - 3 = 9

// Compose function (left to right)
const compose = (...fns) => (x) => fns.reduce((acc, fn) => fn(acc), x);

const pipeline = compose(add, multiply, subtract);
console.log(pipeline(5)); // 9

// Pipe function (right to left)
const pipe = (...fns) => (x) => fns.reduceRight((acc, fn) => fn(acc), x);

const reversePipeline = pipe(subtract, multiply, add);
console.log(reversePipeline(5)); // 9

// Practical example
const users = [
  { name: "John", age: 25 },
  { name: "Jane", age: 30 },
  { name: "Bob", age: 35 }
];

const getNames = (users) => users.map(u => u.name);
const toUpperCase = (names) => names.map(n => n.toUpperCase());
const join = (names) => names.join(", ");

const getUsersString = compose(getNames, toUpperCase, join);
console.log(getUsersString(users)); // "JOHN, JANE, BOB"
```



---

## OBJECTS & PROTOTYPES

### Q21: What are objects in JavaScript and how do you create them?

**Answer:**
Objects are collections of key-value pairs. They can be created in multiple ways:

```javascript
// 1. Object literal
const person = {
  name: "John",
  age: 30,
  greet: function() {
    console.log("Hello");
  }
};

// 2. Constructor function
function Person(name, age) {
  this.name = name;
  this.age = age;
}
const person2 = new Person("Jane", 25);

// 3. Object.create()
const proto = {
  greet: function() {
    console.log("Hello");
  }
};
const person3 = Object.create(proto);
person3.name = "Bob";

// 4. Class (ES6)
class PersonClass {
  constructor(name, age) {
    this.name = name;
    this.age = age;
  }
}
const person4 = new PersonClass("Alice", 28);

// 5. Factory function
function createPerson(name, age) {
  return {
    name,
    age,
    greet() {
      console.log(`Hello, I'm ${this.name}`);
    }
  };
}
const person5 = createPerson("Charlie", 32);

// Accessing properties
console.log(person.name);        // "John"
console.log(person["age"]);      // 30
console.log(person.greet());     // "Hello"

// Adding properties
person.email = "john@example.com";

// Deleting properties
delete person.email;
```

### Q22: What is the prototype and prototype chain?

**Answer:**
Every JavaScript object has a prototype, which is another object. The prototype chain is the mechanism by which objects inherit properties and methods from other objects.

```javascript
// Prototype chain
const animal = {
  eat: function() {
    console.log("Eating");
  }
};

const dog = Object.create(animal);
dog.bark = function() {
  console.log("Woof");
};

dog.eat();  // "Eating" (inherited from animal)
dog.bark(); // "Woof" (own property)

// Constructor function and prototype
function Animal(name) {
  this.name = name;
}

Animal.prototype.eat = function() {
  console.log(this.name + " is eating");
};

const cat = new Animal("Whiskers");
cat.eat(); // "Whiskers is eating"

// Prototype chain lookup
console.log(cat.hasOwnProperty("name"));     // true
console.log(cat.hasOwnProperty("eat"));      // false
console.log("eat" in cat);                   // true

// Accessing prototype
console.log(Object.getPrototypeOf(cat));     // Animal.prototype
console.log(cat.__proto__);                  // Animal.prototype (deprecated)
console.log(cat.constructor);                // Animal

// Prototype chain: cat -> Animal.prototype -> Object.prototype -> null
console.log(Object.getPrototypeOf(Object.getPrototypeOf(cat))); // Object.prototype
console.log(Object.getPrototypeOf(Object.getPrototypeOf(Object.getPrototypeOf(cat)))); // null
```

### Q23: What is the difference between __proto__ and prototype?

**Answer:**

- **prototype**: Property of constructor functions; defines properties/methods for instances
- **__proto__**: Property of objects; points to the prototype of the constructor

```javascript
function Person(name) {
  this.name = name;
}

Person.prototype.greet = function() {
  console.log("Hello");
};

const person = new Person("John");

// prototype - on constructor function
console.log(typeof Person.prototype);  // "object"
console.log(Person.prototype.greet);   // function

// __proto__ - on instance
console.log(person.__proto__);         // Person.prototype
console.log(person.__proto__ === Person.prototype); // true

// Correct way to access prototype
console.log(Object.getPrototypeOf(person)); // Person.prototype

// __proto__ is deprecated, use Object.getPrototypeOf() instead
```

### Q24: What is Object.create() and how does it work?

**Answer:**
Object.create() creates a new object with the specified prototype object and properties.

```javascript
// Basic usage
const proto = {
  greet: function() {
    console.log("Hello");
  }
};

const obj = Object.create(proto);
obj.greet(); // "Hello"

// With property descriptors
const person = Object.create(
  {
    greet: function() {
      console.log("Hello " + this.name);
    }
  },
  {
    name: {
      value: "John",
      writable: true,
      enumerable: true,
      configurable: true
    },
    age: {
      value: 30,
      writable: false,
      enumerable: true,
      configurable: false
    }
  }
);

console.log(person.name);  // "John"
console.log(person.age);   // 30
person.name = "Jane";      // OK
person.age = 25;           // Fails silently (or error in strict mode)

// Creating object with null prototype
const obj2 = Object.create(null);
console.log(Object.getPrototypeOf(obj2)); // null
console.log(obj2.toString);               // undefined (no inherited methods)

// Practical example: Inheritance
function Animal(name) {
  this.name = name;
}

Animal.prototype.eat = function() {
  console.log(this.name + " is eating");
};

function Dog(name, breed) {
  Animal.call(this, name);
  this.breed = breed;
}

Dog.prototype = Object.create(Animal.prototype);
Dog.prototype.constructor = Dog;
Dog.prototype.bark = function() {
  console.log(this.name + " is barking");
};

const dog = new Dog("Rex", "Labrador");
dog.eat();  // "Rex is eating"
dog.bark(); // "Rex is barking"
```

### Q25: What is Object.defineProperty() and Object.defineProperties()?

**Answer:**
These methods define or modify properties on objects with fine-grained control over property attributes.

```javascript
const obj = {};

// defineProperty - single property
Object.defineProperty(obj, "name", {
  value: "John",
  writable: true,      // can be changed
  enumerable: true,    // shows in for...in loop
  configurable: true   // can be deleted or reconfigured
});

console.log(obj.name); // "John"
obj.name = "Jane";     // OK
delete obj.name;       // OK

// defineProperties - multiple properties
const person = {};

Object.defineProperties(person, {
  firstName: {
    value: "John",
    writable: true,
    enumerable: true,
    configurable: true
  },
  lastName: {
    value: "Doe",
    writable: true,
    enumerable: true,
    configurable: true
  },
  fullName: {
    get: function() {
      return this.firstName + " " + this.lastName;
    },
    enumerable: true,
    configurable: true
  }
});

console.log(person.fullName); // "John Doe"

// Read-only property
const config = {};
Object.defineProperty(config, "API_KEY", {
  value: "secret123",
  writable: false,
  enumerable: true,
  configurable: false
});

config.API_KEY = "newkey"; // Fails silently (or error in strict mode)

// Hidden property (not enumerable)
const user = {};
Object.defineProperty(user, "_password", {
  value: "secret",
  writable: true,
  enumerable: false,
  configurable: true
});

console.log(Object.keys(user)); // [] (password not shown)

// Getter and Setter
const temperature = {};
let _celsius = 0;

Object.defineProperty(temperature, "celsius", {
  get: function() {
    return _celsius;
  },
  set: function(value) {
    _celsius = value;
  },
  enumerable: true,
  configurable: true
});

Object.defineProperty(temperature, "fahrenheit", {
  get: function() {
    return this.celsius * 9/5 + 32;
  },
  set: function(value) {
    this.celsius = (value - 32) * 5/9;
  },
  enumerable: true,
  configurable: true
});

temperature.celsius = 0;
console.log(temperature.fahrenheit); // 32
temperature.fahrenheit = 212;
console.log(temperature.celsius);    // 100
```

### Q26: What are getters and setters?

**Answer:**
Getters and setters are special methods that allow you to define custom behavior when reading or writing to object properties.

```javascript
// Using getters and setters in object literal
const person = {
  _name: "John",
  
  get name() {
    console.log("Getting name");
    return this._name;
  },
  
  set name(value) {
    console.log("Setting name to " + value);
    this._name = value;
  }
};

console.log(person.name);  // "Getting name" then "John"
person.name = "Jane";      // "Setting name to Jane"

// In class
class User {
  constructor(firstName, lastName) {
    this._firstName = firstName;
    this._lastName = lastName;
  }
  
  get fullName() {
    return this._firstName + " " + this._lastName;
  }
  
  set fullName(name) {
    const parts = name.split(" ");
    this._firstName = parts[0];
    this._lastName = parts[1];
  }
}

const user = new User("John", "Doe");
console.log(user.fullName);  // "John Doe"
user.fullName = "Jane Smith";
console.log(user._firstName); // "Jane"

// Validation with setters
class BankAccount {
  constructor(balance) {
    this._balance = balance;
  }
  
  get balance() {
    return this._balance;
  }
  
  set balance(amount) {
    if (amount < 0) {
      throw new Error("Balance cannot be negative");
    }
    this._balance = amount;
  }
}

const account = new BankAccount(1000);
console.log(account.balance); // 1000
account.balance = 500;        // OK
account.balance = -100;       // Error
```

### Q27: What is Object.assign() and how does it work?

**Answer:**
Object.assign() copies properties from one or more source objects to a target object. It performs a shallow copy.

```javascript
// Basic usage
const target = { a: 1 };
const source = { b: 2, c: 3 };
const result = Object.assign(target, source);

console.log(result);  // { a: 1, b: 2, c: 3 }
console.log(target);  // { a: 1, b: 2, c: 3 } (target is modified)

// Multiple sources
const obj1 = { a: 1 };
const obj2 = { b: 2 };
const obj3 = { c: 3 };
const merged = Object.assign({}, obj1, obj2, obj3);
console.log(merged); // { a: 1, b: 2, c: 3 }

// Overwriting properties
const defaults = { name: "Anonymous", age: 0 };
const user = { name: "John" };
const config = Object.assign({}, defaults, user);
console.log(config); // { name: "John", age: 0 }

// Shallow copy
const original = { 
  name: "John", 
  address: { city: "NYC" } 
};
const copy = Object.assign({}, original);
copy.name = "Jane";
copy.address.city = "LA";

console.log(original.name);         // "John" (unchanged)
console.log(original.address.city); // "LA" (changed - shallow copy)

// Cloning objects
const person = { name: "John", age: 30 };
const clone = Object.assign({}, person);

// Spread operator (modern alternative)
const spread = { ...person };
```

### Q28: What is the difference between shallow copy and deep copy?

**Answer:**
- **Shallow Copy**: Copies only the first level; nested objects are still referenced
- **Deep Copy**: Recursively copies all levels; completely independent copy

```javascript
// Shallow copy
const original = {
  name: "John",
  address: { city: "NYC", zip: "10001" }
};

// Method 1: Object.assign()
const shallow1 = Object.assign({}, original);

// Method 2: Spread operator
const shallow2 = { ...original };

// Method 3: Object.create()
const shallow3 = Object.create(Object.getPrototypeOf(original));
Object.assign(shallow3, original);

// Modifying nested object affects original
shallow1.address.city = "LA";
console.log(original.address.city); // "LA" (changed)

// Deep copy
// Method 1: JSON (works for simple objects)
const deep1 = JSON.parse(JSON.stringify(original));
deep1.address.city = "Boston";
console.log(original.address.city); // "NYC" (unchanged)

// Method 2: Recursive function
function deepCopy(obj) {
  if (obj === null || typeof obj !== "object") return obj;
  if (obj instanceof Date) return new Date(obj);
  if (obj instanceof Array) return obj.map(item => deepCopy(item));
  if (obj instanceof Object) {
    const copy = {};
    for (let key in obj) {
      if (obj.hasOwnProperty(key)) {
        copy[key] = deepCopy(obj[key]);
      }
    }
    return copy;
  }
}

const deep2 = deepCopy(original);
deep2.address.city = "Chicago";
console.log(original.address.city); // "NYC" (unchanged)

// Method 3: structuredClone() (modern)
const deep3 = structuredClone(original);

// Limitations of JSON method
const objWithFunction = {
  name: "John",
  greet: function() { console.log("Hi"); }
};

const jsonCopy = JSON.parse(JSON.stringify(objWithFunction));
console.log(jsonCopy.greet); // undefined (function lost)
```

### Q29: What is Object.freeze() and Object.seal()?

**Answer:**
- **Object.freeze()**: Prevents adding, removing, or modifying properties
- **Object.seal()**: Prevents adding or removing properties, but allows modification

```javascript
// Object.freeze()
const frozen = { name: "John", age: 30 };
Object.freeze(frozen);

frozen.name = "Jane";      // Fails silently
frozen.email = "john@example.com"; // Fails silently
delete frozen.age;         // Fails silently

console.log(frozen); // { name: "John", age: 30 } (unchanged)

// Object.seal()
const sealed = { name: "John", age: 30 };
Object.seal(sealed);

sealed.name = "Jane";      // OK
sealed.email = "john@example.com"; // Fails silently
delete sealed.age;         // Fails silently

console.log(sealed); // { name: "Jane", age: 30 }

// Checking if object is frozen/sealed
console.log(Object.isFrozen(frozen));   // true
console.log(Object.isSealed(sealed));   // true

// Shallow freeze (nested objects not frozen)
const obj = {
  name: "John",
  address: { city: "NYC" }
};
Object.freeze(obj);

obj.address.city = "LA"; // OK (nested object not frozen)
console.log(obj.address.city); // "LA"

// Deep freeze
function deepFreeze(obj) {
  Object.freeze(obj);
  Object.getOwnPropertyNames(obj).forEach(prop => {
    if (obj[prop] !== null && (typeof obj[prop] === "object" || typeof obj[prop] === "function")) {
      deepFreeze(obj[prop]);
    }
  });
  return obj;
}

const deepFrozen = deepFreeze({
  name: "John",
  address: { city: "NYC" }
});

deepFrozen.address.city = "LA"; // Fails silently
console.log(deepFrozen.address.city); // "NYC"
```

### Q30: What is the difference between for...in and for...of loops?

**Answer:**

| Feature | for...in | for...of |
|---------|---------|---------|
| Iterates over | Enumerable property keys | Iterable values |
| Works with | Objects, Arrays | Arrays, Strings, Sets, Maps |
| Includes inherited | Yes | No |
| Order | Not guaranteed | Guaranteed |

```javascript
// for...in - iterates over keys
const obj = { a: 1, b: 2, c: 3 };
for (let key in obj) {
  console.log(key, obj[key]);
}
// Output: a 1, b 2, c 3

// for...in with array (not recommended)
const arr = ["x", "y", "z"];
for (let index in arr) {
  console.log(index, arr[index]);
}
// Output: 0 x, 1 y, 2 z (but index is string)

// for...in includes inherited properties
const parent = { a: 1 };
const child = Object.create(parent);
child.b = 2;

for (let key in child) {
  console.log(key); // b, a (includes inherited)
}

// for...of - iterates over values
const arr2 = ["x", "y", "z"];
for (let value of arr2) {
  console.log(value);
}
// Output: x, y, z

// for...of with string
const str = "hello";
for (let char of str) {
  console.log(char);
}
// Output: h, e, l, l, o

// for...of with Set
const set = new Set([1, 2, 3]);
for (let value of set) {
  console.log(value);
}
// Output: 1, 2, 3

// for...of with Map
const map = new Map([["a", 1], ["b", 2]]);
for (let [key, value] of map) {
  console.log(key, value);
}
// Output: a 1, b 2

// for...of doesn't work with objects
const obj2 = { a: 1, b: 2 };
for (let value of obj2) { // TypeError
  console.log(value);
}

// Make object iterable
const iterableObj = {
  data: [1, 2, 3],
  [Symbol.iterator]: function() {
    let index = 0;
    return {
      next: () => {
        if (index < this.data.length) {
          return { value: this.data[index++], done: false };
        }
        return { done: true };
      }
    };
  }
};

for (let value of iterableObj) {
  console.log(value);
}
// Output: 1, 2, 3
```



---

## ARRAYS & METHODS

### Q31: What are the different ways to create arrays?

**Answer:**
Arrays can be created using various methods:

```javascript
// 1. Array literal
const arr1 = [1, 2, 3];
const arr2 = ["a", "b", "c"];
const arr3 = [1, "two", true, null, undefined];

// 2. Array constructor
const arr4 = new Array(1, 2, 3);
const arr5 = new Array(5); // Creates array with 5 empty slots

// 3. Array.of() - creates array from arguments
const arr6 = Array.of(1, 2, 3);
const arr7 = Array.of(5); // [5] (not 5 empty slots)

// 4. Array.from() - creates array from iterable
const arr8 = Array.from("hello"); // ["h", "e", "l", "l", "o"]
const arr9 = Array.from([1, 2, 3], x => x * 2); // [2, 4, 6]

// 5. Spread operator
const arr10 = [...[1, 2, 3]];
const arr11 = [..."hello"]; // ["h", "e", "l", "l", "o"]

// Difference between Array(5) and Array.of(5)
console.log(new Array(5));      // [empty × 5]
console.log(Array.of(5));       // [5]
console.log(new Array(5).length); // 5
console.log(Array.of(5).length);  // 1
```

### Q32: What are the main array methods and their differences?

**Answer:**
Array methods can be categorized as mutating (modify original) or non-mutating (return new array):

```javascript
// MUTATING METHODS (modify original array)

// push() - adds to end
const arr = [1, 2, 3];
arr.push(4, 5);
console.log(arr); // [1, 2, 3, 4, 5]

// pop() - removes from end
const last = arr.pop();
console.log(last); // 5
console.log(arr);  // [1, 2, 3, 4]

// unshift() - adds to beginning
arr.unshift(0);
console.log(arr); // [0, 1, 2, 3, 4]

// shift() - removes from beginning
const first = arr.shift();
console.log(first); // 0
console.log(arr);   // [1, 2, 3, 4]

// splice() - adds/removes at any position
const arr2 = [1, 2, 3, 4, 5];
arr2.splice(2, 1, "a", "b"); // remove 1 at index 2, add "a", "b"
console.log(arr2); // [1, 2, "a", "b", 4, 5]

// reverse() - reverses array
const arr3 = [1, 2, 3];
arr3.reverse();
console.log(arr3); // [3, 2, 1]

// sort() - sorts array
const arr4 = [3, 1, 4, 1, 5];
arr4.sort();
console.log(arr4); // [1, 1, 3, 4, 5]

// sort with comparator
const arr5 = [3, 1, 4, 1, 5];
arr5.sort((a, b) => b - a); // descending
console.log(arr5); // [5, 4, 3, 1, 1]

// fill() - fills array with value
const arr6 = new Array(5);
arr6.fill(0);
console.log(arr6); // [0, 0, 0, 0, 0]

// copyWithin() - copies part of array to another location
const arr7 = [1, 2, 3, 4, 5];
arr7.copyWithin(0, 3, 5); // copy elements 3-4 to position 0
console.log(arr7); // [4, 5, 3, 4, 5]

// NON-MUTATING METHODS (return new array)

// map() - transforms each element
const arr8 = [1, 2, 3];
const doubled = arr8.map(x => x * 2);
console.log(doubled); // [2, 4, 6]
console.log(arr8);    // [1, 2, 3] (unchanged)

// filter() - keeps elements that pass test
const arr9 = [1, 2, 3, 4, 5];
const evens = arr9.filter(x => x % 2 === 0);
console.log(evens); // [2, 4]

// reduce() - reduces to single value
const arr10 = [1, 2, 3, 4];
const sum = arr10.reduce((acc, x) => acc + x, 0);
console.log(sum); // 10

// slice() - extracts portion
const arr11 = [1, 2, 3, 4, 5];
const sliced = arr11.slice(1, 4);
console.log(sliced); // [2, 3, 4]
console.log(arr11);  // [1, 2, 3, 4, 5] (unchanged)

// concat() - combines arrays
const arr12 = [1, 2];
const arr13 = [3, 4];
const combined = arr12.concat(arr13);
console.log(combined); // [1, 2, 3, 4]

// join() - joins elements into string
const arr14 = ["a", "b", "c"];
const str = arr14.join("-");
console.log(str); // "a-b-c"

// flat() - flattens nested arrays
const arr15 = [1, [2, 3], [4, [5, 6]]];
const flattened = arr15.flat(2);
console.log(flattened); // [1, 2, 3, 4, 5, 6]

// flatMap() - maps then flattens
const arr16 = [1, 2, 3];
const result = arr16.flatMap(x => [x, x * 2]);
console.log(result); // [1, 2, 2, 4, 3, 6]
```

### Q33: What is the difference between map, filter, and reduce?

**Answer:**

```javascript
const numbers = [1, 2, 3, 4, 5];

// map() - transforms each element, returns array of same length
const doubled = numbers.map(x => x * 2);
console.log(doubled); // [2, 4, 6, 8, 10]

// filter() - keeps elements that pass test, returns smaller array
const evens = numbers.filter(x => x % 2 === 0);
console.log(evens); // [2, 4]

// reduce() - reduces to single value
const sum = numbers.reduce((acc, x) => acc + x, 0);
console.log(sum); // 15

// Combining them
const result = numbers
  .filter(x => x % 2 === 0)  // [2, 4]
  .map(x => x * 2)           // [4, 8]
  .reduce((a, b) => a + b, 0); // 12
console.log(result); // 12

// Practical examples

// map - extract specific property
const users = [
  { name: "John", age: 30 },
  { name: "Jane", age: 25 },
  { name: "Bob", age: 35 }
];
const names = users.map(u => u.name);
console.log(names); // ["John", "Jane", "Bob"]

// filter - get users over 30
const over30 = users.filter(u => u.age > 30);
console.log(over30); // [{ name: "Bob", age: 35 }]

// reduce - calculate total age
const totalAge = users.reduce((sum, u) => sum + u.age, 0);
console.log(totalAge); // 90

// reduce - group by property
const grouped = users.reduce((acc, u) => {
  const key = u.age > 30 ? "over30" : "under30";
  if (!acc[key]) acc[key] = [];
  acc[key].push(u);
  return acc;
}, {});
console.log(grouped);
// { over30: [{name: "Bob", age: 35}], under30: [{name: "John", age: 30}, {name: "Jane", age: 25}] }
```

### Q34: What are find, findIndex, some, and every methods?

**Answer:**

```javascript
const numbers = [1, 2, 3, 4, 5];
const users = [
  { name: "John", age: 30 },
  { name: "Jane", age: 25 },
  { name: "Bob", age: 35 }
];

// find() - returns first element that passes test
const firstEven = numbers.find(x => x % 2 === 0);
console.log(firstEven); // 2

const user = users.find(u => u.name === "Jane");
console.log(user); // { name: "Jane", age: 25 }

// findIndex() - returns index of first element that passes test
const index = numbers.findIndex(x => x % 2 === 0);
console.log(index); // 1

const userIndex = users.findIndex(u => u.age > 30);
console.log(userIndex); // 2

// some() - returns true if at least one element passes test
const hasEven = numbers.some(x => x % 2 === 0);
console.log(hasEven); // true

const hasAdult = users.some(u => u.age >= 18);
console.log(hasAdult); // true

// every() - returns true if all elements pass test
const allPositive = numbers.every(x => x > 0);
console.log(allPositive); // true

const allAdults = users.every(u => u.age >= 18);
console.log(allAdults); // true

// Practical examples
const products = [
  { name: "Laptop", price: 1000, inStock: true },
  { name: "Phone", price: 500, inStock: false },
  { name: "Tablet", price: 300, inStock: true }
];

// Check if product exists
const laptop = products.find(p => p.name === "Laptop");
console.log(laptop); // { name: "Laptop", price: 1000, inStock: true }

// Check if all products are in stock
const allInStock = products.every(p => p.inStock);
console.log(allInStock); // false

// Check if any product is out of stock
const anyOutOfStock = products.some(p => !p.inStock);
console.log(anyOutOfStock); // true

// Get index of expensive product
const expensiveIndex = products.findIndex(p => p.price > 800);
console.log(expensiveIndex); // 0
```

### Q35: What is the difference between includes and indexOf?

**Answer:**

```javascript
const arr = [1, 2, 3, NaN, null, undefined];

// indexOf() - returns index or -1
console.log(arr.indexOf(2));      // 1
console.log(arr.indexOf(10));     // -1
console.log(arr.indexOf(NaN));    // -1 (NaN not found)
console.log(arr.indexOf(null));   // 4
console.log(arr.indexOf(undefined)); // 5

// includes() - returns boolean
console.log(arr.includes(2));     // true
console.log(arr.includes(10));    // false
console.log(arr.includes(NaN));   // true (finds NaN)
console.log(arr.includes(null));  // true
console.log(arr.includes(undefined)); // true

// Key difference: NaN handling
const arr2 = [1, 2, NaN, 3];
console.log(arr2.indexOf(NaN));   // -1
console.log(arr2.includes(NaN));  // true

// includes with fromIndex
const arr3 = [1, 2, 3, 2, 1];
console.log(arr3.includes(2));        // true
console.log(arr3.includes(2, 3));     // false (search from index 3)

// indexOf with fromIndex
console.log(arr3.indexOf(2));         // 1
console.log(arr3.indexOf(2, 3));      // 3 (search from index 3)

// With objects (reference comparison)
const obj1 = { name: "John" };
const obj2 = { name: "John" };
const arr4 = [obj1];

console.log(arr4.includes(obj1));     // true (same reference)
console.log(arr4.includes(obj2));     // false (different reference)
console.log(arr4.indexOf(obj1));      // 0
console.log(arr4.indexOf(obj2));      // -1
```

### Q36: What is Array.isArray() and how to check if something is an array?

**Answer:**

```javascript
// Array.isArray() - most reliable method
console.log(Array.isArray([1, 2, 3]));        // true
console.log(Array.isArray("hello"));          // false
console.log(Array.isArray({ length: 3 }));   // false
console.log(Array.isArray(null));             // false
console.log(Array.isArray(undefined));        // false

// Other methods (less reliable)

// typeof - doesn't work for arrays
console.log(typeof [1, 2, 3]);                // "object"
console.log(typeof { a: 1 });                 // "object"

// instanceof - works but can fail in cross-frame scenarios
console.log([1, 2, 3] instanceof Array);      // true
console.log({ a: 1 } instanceof Array);       // false

// Object.prototype.toString - works but verbose
console.log(Object.prototype.toString.call([1, 2, 3])); // "[object Array]"
console.log(Object.prototype.toString.call({ a: 1 }));  // "[object Object]"

// constructor property - can be modified
console.log([1, 2, 3].constructor === Array); // true

// Best practice: Always use Array.isArray()
function processArray(input) {
  if (!Array.isArray(input)) {
    throw new TypeError("Input must be an array");
  }
  return input.map(x => x * 2);
}

processArray([1, 2, 3]); // OK
processArray("hello");   // TypeError
```

### Q37: What is destructuring and how does it work with arrays?

**Answer:**
Destructuring allows extracting values from arrays or objects into separate variables.

```javascript
// Basic array destructuring
const [a, b, c] = [1, 2, 3];
console.log(a, b, c); // 1, 2, 3

// Skipping elements
const [x, , z] = [1, 2, 3];
console.log(x, z); // 1, 3

// Rest element
const [first, ...rest] = [1, 2, 3, 4, 5];
console.log(first); // 1
console.log(rest);  // [2, 3, 4, 5]

// Default values
const [p = 10, q = 20] = [5];
console.log(p, q); // 5, 20

// Swapping variables
let num1 = 5, num2 = 10;
[num1, num2] = [num2, num1];
console.log(num1, num2); // 10, 5

// Nested destructuring
const [m, [n, o]] = [1, [2, 3]];
console.log(m, n, o); // 1, 2, 3

// Function parameters
function sum([a, b]) {
  return a + b;
}
console.log(sum([5, 3])); // 8

// With default values in function
function greet([name = "Guest", greeting = "Hello"]) {
  console.log(greeting + ", " + name);
}
greet(["John"]);        // "Hello, John"
greet(["Jane", "Hi"]);  // "Hi, Jane"

// Practical example
const [min, max] = [Math.min(...[3, 1, 4, 1, 5]), Math.max(...[3, 1, 4, 1, 5])];
console.log(min, max); // 1, 5
```

### Q38: What is the spread operator and how does it work with arrays?

**Answer:**
The spread operator (...) expands an array into individual elements.

```javascript
// Copying arrays
const original = [1, 2, 3];
const copy = [...original];
copy[0] = 99;
console.log(original[0]); // 1 (unchanged)

// Combining arrays
const arr1 = [1, 2];
const arr2 = [3, 4];
const combined = [...arr1, ...arr2];
console.log(combined); // [1, 2, 3, 4]

// Adding elements
const arr3 = [1, 2, 3];
const withExtra = [0, ...arr3, 4, 5];
console.log(withExtra); // [0, 1, 2, 3, 4, 5]

// Function arguments
const numbers = [1, 2, 3];
console.log(Math.max(...numbers)); // 3

// String to array
const str = "hello";
const chars = [...str];
console.log(chars); // ["h", "e", "l", "l", "o"]

// Shallow copy (nested arrays not copied)
const nested = [[1, 2], [3, 4]];
const shallowCopy = [...nested];
shallowCopy[0][0] = 99;
console.log(nested[0][0]); // 99 (changed)

// Practical examples
const users = [
  { id: 1, name: "John" },
  { id: 2, name: "Jane" }
];

// Add new user
const newUser = { id: 3, name: "Bob" };
const updatedUsers = [...users, newUser];

// Remove user
const filteredUsers = users.filter(u => u.id !== 1);

// Update user
const modifiedUsers = users.map(u => 
  u.id === 1 ? { ...u, name: "John Doe" } : u
);
```

### Q39: What is Array.from() and what are its use cases?

**Answer:**
Array.from() creates a new array from an iterable or array-like object.

```javascript
// From string
const str = "hello";
const arr1 = Array.from(str);
console.log(arr1); // ["h", "e", "l", "l", "o"]

// From Set
const set = new Set([1, 2, 3, 2, 1]);
const arr2 = Array.from(set);
console.log(arr2); // [1, 2, 3]

// From Map
const map = new Map([["a", 1], ["b", 2]]);
const arr3 = Array.from(map);
console.log(arr3); // [["a", 1], ["b", 2]]

// From array-like object
const arrayLike = { 0: "a", 1: "b", 2: "c", length: 3 };
const arr4 = Array.from(arrayLike);
console.log(arr4); // ["a", "b", "c"]

// With mapping function
const numbers = [1, 2, 3];
const doubled = Array.from(numbers, x => x * 2);
console.log(doubled); // [2, 4, 6]

// With mapping and this context
const obj = { multiplier: 2 };
const result = Array.from([1, 2, 3], function(x) {
  return x * this.multiplier;
}, obj);
console.log(result); // [2, 4, 6]

// Practical examples

// Convert NodeList to array
const elements = document.querySelectorAll("div");
const arr5 = Array.from(elements);

// Create range of numbers
const range = Array.from({ length: 5 }, (_, i) => i + 1);
console.log(range); // [1, 2, 3, 4, 5]

// Remove duplicates
const arr6 = [1, 2, 2, 3, 3, 3];
const unique = Array.from(new Set(arr6));
console.log(unique); // [1, 2, 3]

// Convert arguments to array
function test() {
  const args = Array.from(arguments);
  console.log(args);
}
test(1, 2, 3); // [1, 2, 3]
```

### Q40: What is the difference between splice and slice?

**Answer:**

| Feature | splice() | slice() |
|---------|----------|---------|
| Mutates original | Yes | No |
| Returns | Removed elements | New array |
| Syntax | splice(start, deleteCount, items) | slice(start, end) |
| Use case | Modify array | Extract portion |

```javascript
// splice() - mutates original array
const arr1 = [1, 2, 3, 4, 5];
const removed = arr1.splice(2, 1, "a", "b");
console.log(removed);  // [3] (removed elements)
console.log(arr1);     // [1, 2, "a", "b", 4, 5] (modified)

// slice() - doesn't mutate
const arr2 = [1, 2, 3, 4, 5];
const sliced = arr2.slice(2, 4);
console.log(sliced);   // [3, 4] (new array)
console.log(arr2);     // [1, 2, 3, 4, 5] (unchanged)

// splice with negative index
const arr3 = [1, 2, 3, 4, 5];
arr3.splice(-2, 1); // remove 1 element from 2nd position from end
console.log(arr3); // [1, 2, 3, 5]

// slice with negative index
const arr4 = [1, 2, 3, 4, 5];
const sliced2 = arr4.slice(-3, -1);
console.log(sliced2); // [3, 4]

// splice to insert without removing
const arr5 = [1, 2, 3];
arr5.splice(1, 0, "a", "b");
console.log(arr5); // [1, "a", "b", 2, 3]

// splice to remove all after index
const arr6 = [1, 2, 3, 4, 5];
arr6.splice(2);
console.log(arr6); // [1, 2]

// Practical examples

// Remove item from array
const items = ["apple", "banana", "cherry", "date"];
const index = items.indexOf("cherry");
if (index > -1) {
  items.splice(index, 1);
}
console.log(items); // ["apple", "banana", "date"]

// Get last N elements
const arr7 = [1, 2, 3, 4, 5];
const last3 = arr7.slice(-3);
console.log(last3); // [3, 4, 5]

// Clone array
const original = [1, 2, 3];
const clone = original.slice();
```



---

## SCOPE & CLOSURES

### Q41: What is scope in JavaScript?

**Answer:**
Scope determines the accessibility of variables. JavaScript has function scope, block scope, and global scope.

```javascript
// Global scope
var globalVar = "global";
let globalLet = "global";

function test() {
  // Function scope
  var functionVar = "function";
  let functionLet = "function";
  
  if (true) {
    // Block scope
    var blockVar = "block";
    let blockLet = "block";
    const blockConst = "block";
  }
  
  console.log(blockVar);   // "block" (var is function scoped)
  console.log(blockLet);   // ReferenceError (let is block scoped)
}

test();
console.log(globalVar);    // "global"
console.log(globalLet);    // "global"
console.log(functionVar);  // ReferenceError

// Scope chain
const outer = "outer";

function outerFunc() {
  const middle = "middle";
  
  function innerFunc() {
    const inner = "inner";
    console.log(inner);    // "inner" (own scope)
    console.log(middle);   // "middle" (parent scope)
    console.log(outer);    // "outer" (global scope)
  }
  
  innerFunc();
}

outerFunc();

// Lexical scope - inner functions have access to outer scope
function parent() {
  const x = 10;
  
  function child() {
    console.log(x); // 10 (accesses parent's x)
  }
  
  return child;
}

const childFunc = parent();
childFunc(); // 10
```

### Q42: What is a closure?

**Answer:**
A closure is a function that has access to variables from its outer scope even after the outer function has returned.

```javascript
// Simple closure
function outer() {
  const x = 10;
  
  function inner() {
    console.log(x); // accesses x from outer scope
  }
  
  return inner;
}

const closure = outer();
closure(); // 10

// Closure with parameter
function makeAdder(x) {
  return function(y) {
    return x + y;
  };
}

const add5 = makeAdder(5);
console.log(add5(3));  // 8
console.log(add5(10)); // 15

// Closure with state
function counter() {
  let count = 0;
  
  return {
    increment: function() {
      return ++count;
    },
    decrement: function() {
      return --count;
    },
    getCount: function() {
      return count;
    }
  };
}

const myCounter = counter();
console.log(myCounter.increment()); // 1
console.log(myCounter.increment()); // 2
console.log(myCounter.decrement()); // 1
console.log(myCounter.getCount());  // 1

// Closure in loop (common issue)
const functions = [];

// Problem: all functions reference same i
for (var i = 0; i < 3; i++) {
  functions.push(function() {
    console.log(i);
  });
}

functions[0](); // 3 (not 0)
functions[1](); // 3 (not 1)
functions[2](); // 3 (not 2)

// Solution 1: Use let (block scope)
const functions2 = [];
for (let i = 0; i < 3; i++) {
  functions2.push(function() {
    console.log(i);
  });
}

functions2[0](); // 0
functions2[1](); // 1
functions2[2](); // 2

// Solution 2: IIFE (Immediately Invoked Function Expression)
const functions3 = [];
for (var i = 0; i < 3; i++) {
  functions3.push((function(j) {
    return function() {
      console.log(j);
    };
  })(i));
}

functions3[0](); // 0
functions3[1](); // 1
functions3[2](); // 2

// Practical example: Module pattern
const calculator = (function() {
  let result = 0;
  
  return {
    add: function(x) {
      result += x;
      return this;
    },
    subtract: function(x) {
      result -= x;
      return this;
    },
    multiply: function(x) {
      result *= x;
      return this;
    },
    getResult: function() {
      return result;
    }
  };
})();

console.log(calculator.add(5).multiply(2).subtract(3).getResult()); // 7
```

### Q43: What is the difference between lexical scope and dynamic scope?

**Answer:**
- **Lexical Scope**: Variable resolution based on where function is defined
- **Dynamic Scope**: Variable resolution based on where function is called (not used in JavaScript)

```javascript
// JavaScript uses LEXICAL scope
const x = "global";

function outer() {
  const x = "outer";
  inner();
}

function inner() {
  console.log(x); // "global" (lexical scope - where inner is defined)
}

outer();

// If JavaScript used dynamic scope, it would print "outer"

// Another example
const name = "Global";

const obj = {
  name: "Object",
  greet: function() {
    console.log(this.name);
  }
};

obj.greet(); // "Object" (this is dynamic, but scope is lexical)

const greetFunc = obj.greet;
greetFunc(); // "Global" (this is dynamic)

// Lexical scope with closures
function createGreeter(greeting) {
  return function(name) {
    console.log(greeting + ", " + name);
  };
}

const sayHi = createGreeter("Hi");
const sayHello = createGreeter("Hello");

sayHi("John");    // "Hi, John"
sayHello("Jane"); // "Hello, Jane"
```

### Q44: What is the scope chain?

**Answer:**
The scope chain is the mechanism JavaScript uses to look up variables. It searches from inner scope to outer scope until the variable is found or reaches global scope.

```javascript
// Scope chain example
const global = "global";

function level1() {
  const level1Var = "level1";
  
  function level2() {
    const level2Var = "level2";
    
    function level3() {
      const level3Var = "level3";
      
      console.log(level3Var);  // Found in level3 scope
      console.log(level2Var);  // Found in level2 scope
      console.log(level1Var);  // Found in level1 scope
      console.log(global);     // Found in global scope
    }
    
    level3();
  }
  
  level2();
}

level1();

// Scope chain with shadowing
const x = "global";

function outer() {
  const x = "outer";
  
  function inner() {
    const x = "inner";
    console.log(x); // "inner" (uses closest scope)
  }
  
  inner();
  console.log(x); // "outer"
}

outer();
console.log(x); // "global"

// Scope chain with function parameters
function test(param) {
  const local = "local";
  
  function inner() {
    console.log(param);  // Found in function scope
    console.log(local);  // Found in function scope
  }
  
  inner();
}

test("value");

// Scope chain lookup order
// 1. Local scope
// 2. Enclosing function scope
// 3. Global scope
// 4. ReferenceError if not found
```

### Q45: What is the Module Pattern?

**Answer:**
The Module Pattern uses closures to create private and public variables/methods.

```javascript
// Basic module pattern
const myModule = (function() {
  // Private variables
  let privateVar = "private";
  
  // Private function
  function privateFunc() {
    console.log("Private function");
  }
  
  // Public API
  return {
    publicVar: "public",
    publicFunc: function() {
      console.log("Public function");
      privateFunc();
    },
    getPrivateVar: function() {
      return privateVar;
    }
  };
})();

console.log(myModule.publicVar);      // "public"
console.log(myModule.publicFunc());   // "Public function" then "Private function"
console.log(myModule.getPrivateVar()); // "private"
console.log(myModule.privateVar);     // undefined (private)

// Module with initialization
const userModule = (function() {
  let users = [];
  
  return {
    addUser: function(name, email) {
      users.push({ name, email });
    },
    getUsers: function() {
      return [...users]; // return copy
    },
    removeUser: function(email) {
      users = users.filter(u => u.email !== email);
    }
  };
})();

userModule.addUser("John", "john@example.com");
userModule.addUser("Jane", "jane@example.com");
console.log(userModule.getUsers());
userModule.removeUser("john@example.com");
console.log(userModule.getUsers());

// Revealing module pattern
const calculator = (function() {
  let result = 0;
  
  const add = function(x) {
    result += x;
  };
  
  const subtract = function(x) {
    result -= x;
  };
  
  const getResult = function() {
    return result;
  };
  
  return {
    add,
    subtract,
    getResult
  };
})();

calculator.add(5);
calculator.subtract(2);
console.log(calculator.getResult()); // 3
```

### Q46: What is the Immediately Invoked Function Expression (IIFE)?

**Answer:**
An IIFE is a function that is defined and executed immediately. It's useful for creating a new scope and avoiding global namespace pollution.

```javascript
// Basic IIFE
(function() {
  console.log("IIFE executed");
})();

// IIFE with parameters
(function(name) {
  console.log("Hello " + name);
})("John");

// IIFE with return value
const result = (function() {
  return 5 + 3;
})();
console.log(result); // 8

// IIFE with arrow function
(() => {
  console.log("Arrow IIFE");
})();

// IIFE to create private scope
(function() {
  const privateVar = "private";
  console.log(privateVar);
})();
console.log(typeof privateVar); // undefined

// IIFE with multiple statements
(function() {
  const x = 10;
  const y = 20;
  console.log(x + y); // 30
})();

// IIFE to avoid variable conflicts
(function() {
  const name = "IIFE 1";
  console.log(name);
})();

(function() {
  const name = "IIFE 2";
  console.log(name);
})();

// IIFE with conditional
const isMobile = (function() {
  return window.innerWidth < 768;
})();

// IIFE for initialization
(function() {
  const config = {
    apiUrl: "https://api.example.com",
    timeout: 5000
  };
  
  window.APP_CONFIG = config;
})();

console.log(window.APP_CONFIG);
```

### Q47: What is variable shadowing?

**Answer:**
Variable shadowing occurs when a variable declared in an inner scope has the same name as a variable in an outer scope, hiding the outer variable.

```javascript
// Simple shadowing
const x = "global";

function test() {
  const x = "function"; // shadows global x
  console.log(x); // "function"
}

test();
console.log(x); // "global"

// Shadowing with block scope
let x = "outer";

if (true) {
  let x = "inner"; // shadows outer x
  console.log(x); // "inner"
}

console.log(x); // "outer"

// Shadowing with function parameters
function greet(name) {
  const name = "John"; // Error: Identifier 'name' has already been declared
}

// Shadowing with nested functions
const value = "global";

function outer() {
  const value = "outer";
  
  function inner() {
    const value = "inner";
    console.log(value); // "inner"
  }
  
  inner();
  console.log(value); // "outer"
}

outer();
console.log(value); // "global"

// Accessing outer variable when shadowed
const y = "outer";

function test2() {
  const y = "inner";
  console.log(y); // "inner"
  // Can't access outer y directly, it's shadowed
}

// Shadowing can be confusing - best to avoid
// Use different variable names for clarity
```

### Q48: What is the difference between global and local scope?

**Answer:**

| Feature | Global Scope | Local Scope |
|---------|--------------|------------|
| Accessibility | Accessible everywhere | Accessible only within function/block |
| Lifetime | Exists for entire program | Exists only during function/block execution |
| Memory | Stays in memory | Garbage collected after execution |
| Pollution | Can cause conflicts | Isolated from other scopes |

```javascript
// Global scope
var globalVar = "global";
let globalLet = "global";
const globalConst = "global";

function test() {
  // Local scope
  var localVar = "local";
  let localLet = "local";
  const localConst = "local";
  
  console.log(globalVar);  // "global" (accessible)
  console.log(localVar);   // "local" (accessible)
}

test();
console.log(globalVar);    // "global" (accessible)
console.log(localVar);     // ReferenceError (not accessible)

// Global scope pollution
window.myGlobal = "polluted"; // Creates global variable

// Local scope isolation
function func1() {
  const x = 10;
}

function func2() {
  const x = 20;
}

func1();
func2();
// Each function has its own x, no conflict

// Block scope (let/const)
if (true) {
  let blockVar = "block";
  const blockConst = "block";
}

console.log(blockVar);   // ReferenceError
console.log(blockConst); // ReferenceError

// var doesn't have block scope
if (true) {
  var blockVar2 = "block";
}

console.log(blockVar2); // "block" (accessible)

// Best practice: Minimize global scope
// Use modules or IIFE to create local scope
(function() {
  const privateVar = "private";
  // privateVar is not global
})();
```

### Q49: What is the Temporal Dead Zone (TDZ) in detail?

**Answer:**
The Temporal Dead Zone is the period between entering a scope and reaching the declaration of a let/const variable where accessing the variable throws a ReferenceError.

```javascript
// TDZ example
console.log(typeof x); // ReferenceError (in TDZ)
let x = 5;

// Why? let/const are hoisted but not initialized
// From scope start to declaration is the TDZ

// var doesn't have TDZ
console.log(typeof y); // "undefined" (hoisted and initialized)
var y = 5;

// TDZ with function parameters
function test(x = y, y = 2) {
  console.log(x, y);
}

test(undefined, 3); // ReferenceError (y is in TDZ when x = y is evaluated)

// TDZ with class
console.log(typeof MyClass); // ReferenceError (in TDZ)
class MyClass {}

// TDZ with nested scopes
let a = 1;

function test2() {
  console.log(a); // ReferenceError (a is in TDZ)
  let a = 2;
}

test2();

// TDZ with for loop
for (let i = 0; i < 3; i++) {
  console.log(i); // OK (i is declared in loop scope)
}

// TDZ with destructuring
const [x2 = y2, y2 = 1] = []; // ReferenceError (y2 is in TDZ)

// Practical implications
function example() {
  // TDZ starts here
  console.log(x3); // ReferenceError
  
  let x3 = 5; // TDZ ends here
  console.log(x3); // 5
}

// Best practice: Declare variables at top of scope to avoid TDZ issues
```

### Q50: What is the difference between function scope and block scope?

**Answer:**

| Feature | Function Scope | Block Scope |
|---------|----------------|------------|
| Variable | var | let, const |
| Scope | Entire function | Block (if, for, while, {}) |
| Hoisting | Hoisted, initialized to undefined | Hoisted, TDZ |
| Re-declaration | Allowed | Not allowed |

```javascript
// Function scope (var)
function test1() {
  if (true) {
    var x = 1;
  }
  console.log(x); // 1 (accessible outside block)
}

// Block scope (let/const)
function test2() {
  if (true) {
    let y = 2;
    const z = 3;
  }
  console.log(y); // ReferenceError
  console.log(z); // ReferenceError
}

// var in loop
for (var i = 0; i < 3; i++) {
  // i is function scoped
}
console.log(i); // 3 (accessible outside loop)

// let in loop
for (let j = 0; j < 3; j++) {
  // j is block scoped
}
console.log(j); // ReferenceError

// Block scope with {}
{
  let x = 1;
  const y = 2;
}
console.log(x); // ReferenceError
console.log(y); // ReferenceError

// Function scope with {}
{
  var x = 1;
}
console.log(x); // 1 (accessible)

// Nested blocks
{
  let a = 1;
  {
    let a = 2;
    console.log(a); // 2 (inner block)
  }
  console.log(a); // 1 (outer block)
}

// Best practice: Use let/const for block scope, avoid var
```



---

## ASYNCHRONOUS JAVASCRIPT

### Q51: What is asynchronous programming and why is it important?

**Answer:**
Asynchronous programming allows code to run without blocking the main thread. It's essential for operations like API calls, file I/O, and timers.

```javascript
// Synchronous - blocks execution
function syncTask() {
  console.log("Start");
  // Imagine this takes 5 seconds
  for (let i = 0; i < 1000000000; i++) {}
  console.log("End");
}

syncTask(); // Blocks everything

// Asynchronous - doesn't block
function asyncTask() {
  console.log("Start");
  setTimeout(() => {
    console.log("End");
  }, 1000);
  console.log("Middle");
}

asyncTask();
// Output: Start, Middle, End (after 1 second)

// Why asynchronous is important
// 1. Responsiveness - UI stays responsive
// 2. Performance - can do multiple things concurrently
// 3. User experience - no freezing

// Example: Fetching data
// Synchronous (blocking)
// const data = fetch('/api/data'); // blocks

// Asynchronous (non-blocking)
fetch('/api/data')
  .then(response => response.json())
  .then(data => console.log(data));
console.log("Request sent"); // executes immediately
```

### Q52: What is a callback function and callback hell?

**Answer:**
A callback is a function passed to another function. Callback hell occurs when callbacks are nested too deeply, making code hard to read.

```javascript
// Simple callback
function fetchData(callback) {
  setTimeout(() => {
    callback({ id: 1, name: "John" });
  }, 1000);
}

fetchData((data) => {
  console.log(data);
});

// Callback hell (Pyramid of Doom)
function getUser(userId, callback) {
  setTimeout(() => {
    callback({ id: userId, name: "John" });
  }, 1000);
}

function getPosts(userId, callback) {
  setTimeout(() => {
    callback([{ id: 1, title: "Post 1" }]);
  }, 1000);
}

function getComments(postId, callback) {
  setTimeout(() => {
    callback([{ id: 1, text: "Comment 1" }]);
  }, 1000);
}

// Nested callbacks - hard to read
getUser(1, (user) => {
  console.log(user);
  getPosts(user.id, (posts) => {
    console.log(posts);
    getComments(posts[0].id, (comments) => {
      console.log(comments);
    });
  });
});

// Problems with callback hell:
// 1. Hard to read and understand
// 2. Difficult to handle errors
// 3. Hard to maintain
// 4. Easy to make mistakes

// Solution: Use promises or async/await (covered next)
```

### Q53: What are Promises and how do they work?

**Answer:**
A Promise is an object representing the eventual completion (or failure) of an asynchronous operation and its resulting value.

```javascript
// Creating a promise
const promise = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve("Success!");
  }, 1000);
});

// Consuming a promise
promise
  .then(result => console.log(result))
  .catch(error => console.log(error));

// Promise states
// 1. Pending - initial state
// 2. Fulfilled - operation completed successfully
// 3. Rejected - operation failed

// Promise with rejection
const promise2 = new Promise((resolve, reject) => {
  setTimeout(() => {
    reject("Error!");
  }, 1000);
});

promise2
  .then(result => console.log(result))
  .catch(error => console.log(error)); // "Error!"

// Promise chaining
fetch('/api/user/1')
  .then(response => response.json())
  .then(user => {
    console.log(user);
    return fetch(`/api/posts/${user.id}`);
  })
  .then(response => response.json())
  .then(posts => console.log(posts))
  .catch(error => console.log(error));

// Promise.all() - wait for all promises
const promise3 = Promise.resolve(1);
const promise4 = new Promise(resolve => setTimeout(() => resolve(2), 1000));
const promise5 = Promise.resolve(3);

Promise.all([promise3, promise4, promise5])
  .then(results => console.log(results)); // [1, 2, 3]

// Promise.race() - first promise to settle
Promise.race([promise3, promise4, promise5])
  .then(result => console.log(result)); // 1

// Promise.allSettled() - wait for all, regardless of outcome
Promise.allSettled([promise3, promise4, promise5])
  .then(results => console.log(results));
// [{ status: 'fulfilled', value: 1 }, ...]

// Promise.any() - first fulfilled promise
Promise.any([promise3, promise4, promise5])
  .then(result => console.log(result)); // 1

// finally() - executes regardless of outcome
promise
  .then(result => console.log(result))
  .catch(error => console.log(error))
  .finally(() => console.log("Done"));
```

### Q54: What is async/await and how does it work?

**Answer:**
Async/await is syntactic sugar over promises, making asynchronous code look and behave more like synchronous code.

```javascript
// Basic async/await
async function fetchData() {
  try {
    const response = await fetch('/api/data');
    const data = await response.json();
    console.log(data);
    return data;
  } catch (error) {
    console.log(error);
  }
}

fetchData();

// async function always returns a promise
async function test() {
  return "Hello";
}

test().then(result => console.log(result)); // "Hello"

// await pauses execution until promise settles
async function example() {
  console.log("Start");
  const result = await new Promise(resolve => {
    setTimeout(() => resolve("Done"), 1000);
  });
  console.log(result); // "Done" (after 1 second)
  console.log("End");
}

example();

// Error handling with try/catch
async function fetchUser(userId) {
  try {
    const response = await fetch(`/api/user/${userId}`);
    if (!response.ok) throw new Error("User not found");
    const user = await response.json();
    return user;
  } catch (error) {
    console.log("Error:", error.message);
  }
}

// Sequential vs parallel execution
// Sequential (slower)
async function sequential() {
  const user = await fetchUser(1);
  const posts = await fetchPosts(user.id);
  const comments = await fetchComments(posts[0].id);
  return { user, posts, comments };
}

// Parallel (faster)
async function parallel() {
  const user = await fetchUser(1);
  const [posts, comments] = await Promise.all([
    fetchPosts(user.id),
    fetchComments(1)
  ]);
  return { user, posts, comments };
}

// async/await with loops
async function processArray(arr) {
  for (const item of arr) {
    const result = await processItem(item);
    console.log(result);
  }
}

// async/await with map (parallel)
async function processArrayParallel(arr) {
  const results = await Promise.all(
    arr.map(item => processItem(item))
  );
  return results;
}

// Practical example
async function getUserWithPosts(userId) {
  try {
    const userResponse = await fetch(`/api/users/${userId}`);
    const user = await userResponse.json();
    
    const postsResponse = await fetch(`/api/posts?userId=${userId}`);
    const posts = await postsResponse.json();
    
    return { user, posts };
  } catch (error) {
    console.error("Failed to fetch data:", error);
    throw error;
  }
}
```

### Q55: What is the difference between Promise and async/await?

**Answer:**

| Feature | Promise | async/await |
|---------|---------|------------|
| Syntax | .then().catch() | try/catch |
| Readability | Chaining | Looks synchronous |
| Error handling | .catch() | try/catch |
| Debugging | Harder | Easier |
| Return value | Promise | Promise |

```javascript
// Promise approach
function fetchDataPromise() {
  return fetch('/api/data')
    .then(response => response.json())
    .then(data => {
      console.log(data);
      return data;
    })
    .catch(error => console.log(error));
}

// async/await approach
async function fetchDataAsync() {
  try {
    const response = await fetch('/api/data');
    const data = await response.json();
    console.log(data);
    return data;
  } catch (error) {
    console.log(error);
  }
}

// Both return a promise
fetchDataPromise().then(data => console.log(data));
fetchDataAsync().then(data => console.log(data));

// Error handling comparison
// Promise
fetch('/api/data')
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.log("Error:", error));

// async/await
async function example() {
  try {
    const response = await fetch('/api/data');
    const data = await response.json();
    console.log(data);
  } catch (error) {
    console.log("Error:", error);
  }
}

// Parallel execution
// Promise
Promise.all([
  fetch('/api/user'),
  fetch('/api/posts'),
  fetch('/api/comments')
])
  .then(responses => Promise.all(responses.map(r => r.json())))
  .then(data => console.log(data));

// async/await
async function parallel() {
  const responses = await Promise.all([
    fetch('/api/user'),
    fetch('/api/posts'),
    fetch('/api/comments')
  ]);
  const data = await Promise.all(responses.map(r => r.json()));
  console.log(data);
}

// Best practice: Use async/await for better readability
```

### Q56: What is the event loop and how does it work?

**Answer:**
The event loop is the mechanism that allows JavaScript to perform non-blocking operations by offloading operations to the browser/Node.js.

```javascript
// Event loop demonstration
console.log("1. Start");

setTimeout(() => {
  console.log("2. setTimeout");
}, 0);

Promise.resolve()
  .then(() => {
    console.log("3. Promise");
  });

console.log("4. End");

// Output:
// 1. Start
// 4. End
// 3. Promise
// 2. setTimeout

// Why? Event loop order:
// 1. Execute synchronous code (1, 4)
// 2. Execute microtasks (promises, queueMicrotask)
// 3. Execute macrotasks (setTimeout, setInterval)

// Microtasks vs Macrotasks
console.log("Start");

// Macrotask
setTimeout(() => {
  console.log("setTimeout");
}, 0);

// Microtask
Promise.resolve()
  .then(() => {
    console.log("Promise 1");
  })
  .then(() => {
    console.log("Promise 2");
  });

// Microtask
queueMicrotask(() => {
  console.log("queueMicrotask");
});

console.log("End");

// Output:
// Start
// End
// Promise 1
// queueMicrotask
// Promise 2
// setTimeout

// Event loop phases:
// 1. Call Stack - executes synchronous code
// 2. Microtask Queue - promises, queueMicrotask
// 3. Macrotask Queue - setTimeout, setInterval, I/O
// 4. Render - browser renders if needed
// 5. Repeat

// Practical example
function example() {
  console.log("1");
  
  setTimeout(() => {
    console.log("2");
  }, 0);
  
  Promise.resolve()
    .then(() => {
      console.log("3");
      setTimeout(() => {
        console.log("4");
      }, 0);
    });
  
  console.log("5");
}

example();
// Output: 1, 5, 3, 2, 4
```

### Q57: What is the difference between setTimeout and setInterval?

**Answer:**

| Feature | setTimeout | setInterval |
|---------|-----------|------------|
| Execution | Once after delay | Repeatedly at interval |
| Return | Timeout ID | Interval ID |
| Cancellation | clearTimeout() | clearInterval() |
| Use case | Delayed action | Repeated action |

```javascript
// setTimeout - executes once
setTimeout(() => {
  console.log("Executed after 1 second");
}, 1000);

// setInterval - executes repeatedly
const intervalId = setInterval(() => {
  console.log("Executed every 1 second");
}, 1000);

// Clear interval
setTimeout(() => {
  clearInterval(intervalId);
  console.log("Interval cleared");
}, 5000);

// setTimeout with parameters
setTimeout((name, age) => {
  console.log(`${name} is ${age} years old`);
}, 1000, "John", 30);

// Canceling setTimeout
const timeoutId = setTimeout(() => {
  console.log("This won't execute");
}, 1000);

clearTimeout(timeoutId);

// Practical example: Debouncing
function debounce(func, delay) {
  let timeoutId;
  return function(...args) {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => {
      func(...args);
    }, delay);
  };
}

const search = debounce((query) => {
  console.log("Searching for:", query);
}, 500);

search("javascript");
search("javascript tutorial"); // Previous timeout cleared

// Practical example: Throttling
function throttle(func, delay) {
  let lastCall = 0;
  return function(...args) {
    const now = Date.now();
    if (now - lastCall >= delay) {
      func(...args);
      lastCall = now;
    }
  };
}

const handleScroll = throttle(() => {
  console.log("Scroll event");
}, 1000);

// Practical example: Polling
function poll(func, interval, maxAttempts) {
  let attempts = 0;
  const intervalId = setInterval(() => {
    func();
    attempts++;
    if (attempts >= maxAttempts) {
      clearInterval(intervalId);
    }
  }, interval);
}

poll(() => {
  console.log("Polling...");
}, 1000, 5);
```

### Q58: What is requestAnimationFrame and how does it differ from setTimeout?

**Answer:**
requestAnimationFrame (rAF) is optimized for animations and syncs with browser's refresh rate, while setTimeout uses a fixed delay.

```javascript
// setTimeout - fixed delay
setTimeout(() => {
  console.log("After 16ms");
}, 16);

// requestAnimationFrame - syncs with refresh rate
requestAnimationFrame(() => {
  console.log("Next frame");
});

// Animation with setTimeout
let x = 0;
function animateWithTimeout() {
  x += 5;
  element.style.left = x + "px";
  if (x < 500) {
    setTimeout(animateWithTimeout, 16);
  }
}

// Animation with requestAnimationFrame (better)
let x = 0;
function animateWithRAF() {
  x += 5;
  element.style.left = x + "px";
  if (x < 500) {
    requestAnimationFrame(animateWithRAF);
  }
}

requestAnimationFrame(animateWithRAF);

// Advantages of requestAnimationFrame:
// 1. Syncs with browser refresh rate (60fps)
// 2. Pauses when tab is not visible
// 3. Better performance
// 4. Smoother animations

// Canceling requestAnimationFrame
const animationId = requestAnimationFrame(() => {
  console.log("Animation frame");
});

cancelAnimationFrame(animationId);

// Practical example: Smooth scroll
function smoothScroll(target, duration) {
  const start = window.scrollY;
  const distance = target - start;
  let startTime = null;
  
  function animation(currentTime) {
    if (startTime === null) startTime = currentTime;
    const elapsed = currentTime - startTime;
    const progress = Math.min(elapsed / duration, 1);
    
    window.scrollTo(0, start + distance * progress);
    
    if (progress < 1) {
      requestAnimationFrame(animation);
    }
  }
  
  requestAnimationFrame(animation);
}

// Practical example: FPS counter
let lastTime = Date.now();
let frames = 0;

function measureFPS() {
  frames++;
  const currentTime = Date.now();
  
  if (currentTime - lastTime >= 1000) {
    console.log("FPS:", frames);
    frames = 0;
    lastTime = currentTime;
  }
  
  requestAnimationFrame(measureFPS);
}

requestAnimationFrame(measureFPS);
```

### Q59: What is a microtask and macrotask?

**Answer:**
Microtasks and macrotasks are different types of asynchronous tasks with different execution priorities in the event loop.

```javascript
// Microtasks (higher priority)
// - Promises (.then, .catch, .finally)
// - queueMicrotask()
// - MutationObserver
// - process.nextTick() (Node.js)

// Macrotasks (lower priority)
// - setTimeout
// - setInterval
// - setImmediate (Node.js)
// - I/O operations
// - UI rendering

// Execution order demonstration
console.log("Script start");

setTimeout(() => {
  console.log("setTimeout");
}, 0);

Promise.resolve()
  .then(() => {
    console.log("Promise 1");
  })
  .then(() => {
    console.log("Promise 2");
  });

queueMicrotask(() => {
  console.log("queueMicrotask");
});

console.log("Script end");

// Output:
// Script start
// Script end
// Promise 1
// queueMicrotask
// Promise 2
// setTimeout

// Event loop cycle:
// 1. Execute all synchronous code
// 2. Execute all microtasks
// 3. Render (if needed)
// 4. Execute one macrotask
// 5. Go to step 2

// Complex example
console.log("1");

setTimeout(() => {
  console.log("2");
  Promise.resolve().then(() => console.log("3"));
}, 0);

Promise.resolve()
  .then(() => {
    console.log("4");
    setTimeout(() => console.log("5"), 0);
  })
  .then(() => {
    console.log("6");
  });

console.log("7");

// Output: 1, 7, 4, 6, 2, 3, 5

// Practical implications
// 1. Microtasks always execute before macrotasks
// 2. Multiple microtasks execute before next macrotask
// 3. Promises are microtasks, so they execute before setTimeout
```

### Q60: What is Promise.all(), Promise.race(), Promise.allSettled(), and Promise.any()?

**Answer:**

```javascript
// Promise.all() - waits for all promises, rejects if any fails
const p1 = Promise.resolve(1);
const p2 = new Promise(resolve => setTimeout(() => resolve(2), 1000));
const p3 = Promise.resolve(3);

Promise.all([p1, p2, p3])
  .then(results => console.log(results)) // [1, 2, 3]
  .catch(error => console.log(error));

// Promise.all() with rejection
const p4 = Promise.reject("Error");
Promise.all([p1, p4, p3])
  .then(results => console.log(results))
  .catch(error => console.log(error)); // "Error"

// Promise.race() - returns first settled promise
Promise.race([p1, p2, p3])
  .then(result => console.log(result)) // 1 (fastest)
  .catch(error => console.log(error));

// Promise.race() with rejection
const p5 = Promise.reject("Error");
Promise.race([p2, p5])
  .then(result => console.log(result))
  .catch(error => console.log(error)); // "Error" (if rejects first)

// Promise.allSettled() - waits for all, returns status
Promise.allSettled([p1, p4, p3])
  .then(results => console.log(results));
// [
//   { status: 'fulfilled', value: 1 },
//   { status: 'rejected', reason: 'Error' },
//   { status: 'fulfilled', value: 3 }
// ]

// Promise.any() - returns first fulfilled promise
Promise.any([p1, p4, p3])
  .then(result => console.log(result)) // 1
  .catch(error => console.log(error));

// Promise.any() with all rejections
const p6 = Promise.reject("Error 1");
const p7 = Promise.reject("Error 2");
Promise.any([p6, p7])
  .then(result => console.log(result))
  .catch(error => console.log(error)); // AggregateError

// Practical examples

// Promise.all() - fetch multiple resources
async function fetchMultiple() {
  try {
    const [users, posts, comments] = await Promise.all([
      fetch('/api/users').then(r => r.json()),
      fetch('/api/posts').then(r => r.json()),
      fetch('/api/comments').then(r => r.json())
    ]);
    return { users, posts, comments };
  } catch (error) {
    console.log("Failed to fetch:", error);
  }
}

// Promise.race() - timeout
function fetchWithTimeout(url, timeout) {
  return Promise.race([
    fetch(url),
    new Promise((_, reject) =>
      setTimeout(() => reject(new Error("Timeout")), timeout)
    )
  ]);
}

// Promise.allSettled() - handle all results
async function processAll(promises) {
  const results = await Promise.allSettled(promises);
  const successful = results
    .filter(r => r.status === 'fulfilled')
    .map(r => r.value);
  const failed = results
    .filter(r => r.status === 'rejected')
    .map(r => r.reason);
  return { successful, failed };
}
```



---

## ES6+ FEATURES

### Q61: What are the main ES6+ features?

**Answer:**
ES6 (2015) introduced major features that modernized JavaScript. Here are the key ones:

```javascript
// 1. let and const
let x = 1;
const y = 2;

// 2. Arrow functions
const add = (a, b) => a + b;

// 3. Template literals
const name = "John";
const greeting = `Hello, ${name}!`;

// 4. Destructuring
const [a, b] = [1, 2];
const { name: n, age } = { name: "John", age: 30 };

// 5. Default parameters
function greet(name = "Guest") {
  console.log("Hello " + name);
}

// 6. Rest and spread
const [first, ...rest] = [1, 2, 3];
const arr = [...[1, 2], 3];

// 7. Classes
class Person {
  constructor(name) {
    this.name = name;
  }
}

// 8. Modules
export const myFunction = () => {};
import { myFunction } from './module.js';

// 9. Promises
const promise = new Promise((resolve, reject) => {});

// 10. for...of loop
for (const item of [1, 2, 3]) {
  console.log(item);
}

// 11. Map and Set
const map = new Map();
const set = new Set([1, 2, 3]);

// 12. Symbols
const sym = Symbol("id");

// 13. Generators
function* generator() {
  yield 1;
  yield 2;
}

// 14. Proxy and Reflect
const proxy = new Proxy({}, {});
```

### Q62: What are template literals and how do they work?

**Answer:**
Template literals are strings enclosed in backticks that support interpolation and multi-line strings.

```javascript
// Basic template literal
const name = "John";
const greeting = `Hello, ${name}!`;
console.log(greeting); // "Hello, John!"

// Multi-line strings
const multiLine = `
  This is a
  multi-line
  string
`;

// Expression interpolation
const a = 5;
const b = 10;
console.log(`${a} + ${b} = ${a + b}`); // "5 + 10 = 15"

// Function calls in template literals
function getName() {
  return "Jane";
}
console.log(`Hello, ${getName()}!`); // "Hello, Jane!"

// Nested template literals
const obj = { name: "John", age: 30 };
console.log(`User: ${`${obj.name} (${obj.age})`}`); // "User: John (30)"

// Tagged template literals
function tag(strings, ...values) {
  console.log(strings); // ["Hello ", "!"]
  console.log(values);  // ["John"]
  return strings[0] + values[0].toUpperCase() + strings[1];
}

const result = tag`Hello ${name}!`;
console.log(result); // "Hello JOHN!"

// Practical example: HTML template
const user = { name: "John", email: "john@example.com" };
const html = `
  <div class="user">
    <h1>${user.name}</h1>
    <p>${user.email}</p>
  </div>
`;

// Practical example: SQL query
const userId = 1;
const query = `
  SELECT * FROM users
  WHERE id = ${userId}
`;
```

### Q63: What are classes and how do they work?

**Answer:**
Classes are syntactic sugar over JavaScript's prototype-based inheritance, providing a cleaner way to create objects.

```javascript
// Class declaration
class Person {
  constructor(name, age) {
    this.name = name;
    this.age = age;
  }
  
  greet() {
    console.log(`Hello, I'm ${this.name}`);
  }
  
  static info() {
    console.log("This is a Person class");
  }
}

const person = new Person("John", 30);
person.greet(); // "Hello, I'm John"
Person.info();  // "This is a Person class"

// Class inheritance
class Employee extends Person {
  constructor(name, age, salary) {
    super(name, age);
    this.salary = salary;
  }
  
  work() {
    console.log(`${this.name} is working`);
  }
}

const employee = new Employee("Jane", 25, 50000);
employee.greet(); // "Hello, I'm Jane"
employee.work();  // "Jane is working"

// Getters and setters
class User {
  constructor(firstName, lastName) {
    this._firstName = firstName;
    this._lastName = lastName;
  }
  
  get fullName() {
    return `${this._firstName} ${this._lastName}`;
  }
  
  set fullName(name) {
    const [first, last] = name.split(" ");
    this._firstName = first;
    this._lastName = last;
  }
}

const user = new User("John", "Doe");
console.log(user.fullName); // "John Doe"
user.fullName = "Jane Smith";
console.log(user.fullName); // "Jane Smith"

// Private fields (ES2022)
class BankAccount {
  #balance = 0;
  
  deposit(amount) {
    this.#balance += amount;
  }
  
  getBalance() {
    return this.#balance;
  }
}

const account = new BankAccount();
account.deposit(100);
console.log(account.getBalance()); // 100
console.log(account.#balance);     // SyntaxError

// Static methods and properties
class MathUtils {
  static PI = 3.14159;
  
  static add(a, b) {
    return a + b;
  }
}

console.log(MathUtils.PI);        // 3.14159
console.log(MathUtils.add(2, 3)); // 5
```

### Q64: What is the difference between class and constructor function?

**Answer:**

| Feature | Class | Constructor Function |
|---------|-------|----------------------|
| Syntax | class keyword | function keyword |
| Hoisting | Not hoisted (TDZ) | Hoisted |
| Inheritance | extends keyword | prototype chain |
| Methods | In class body | On prototype |
| Constructor | constructor method | function itself |

```javascript
// Constructor function
function PersonFunc(name, age) {
  this.name = name;
  this.age = age;
}

PersonFunc.prototype.greet = function() {
  console.log(`Hello, I'm ${this.name}`);
};

const person1 = new PersonFunc("John", 30);

// Class (modern way)
class PersonClass {
  constructor(name, age) {
    this.name = name;
    this.age = age;
  }
  
  greet() {
    console.log(`Hello, I'm ${this.name}`);
  }
}

const person2 = new PersonClass("Jane", 25);

// Both work the same way, but class is cleaner

// Inheritance with constructor function
function EmployeeFunc(name, age, salary) {
  PersonFunc.call(this, name, age);
  this.salary = salary;
}

EmployeeFunc.prototype = Object.create(PersonFunc.prototype);
EmployeeFunc.prototype.constructor = EmployeeFunc;

// Inheritance with class
class EmployeeClass extends PersonClass {
  constructor(name, age, salary) {
    super(name, age);
    this.salary = salary;
  }
}

// Classes are not hoisted
console.log(typeof PersonClass); // ReferenceError (TDZ)
class PersonClass2 {}

// Constructor functions are hoisted
console.log(typeof PersonFunc2); // "function"
function PersonFunc2() {}

// Best practice: Use classes for modern JavaScript
```

### Q65: What are destructuring assignments?

**Answer:**
Destructuring allows extracting values from objects or arrays into separate variables.

```javascript
// Array destructuring
const [a, b, c] = [1, 2, 3];
console.log(a, b, c); // 1, 2, 3

// Object destructuring
const { name, age } = { name: "John", age: 30 };
console.log(name, age); // "John", 30

// Renaming in destructuring
const { name: n, age: a } = { name: "John", age: 30 };
console.log(n, a); // "John", 30

// Default values
const [x = 10, y = 20] = [5];
console.log(x, y); // 5, 20

const { name: nm = "Guest", age: ag = 0 } = {};
console.log(nm, ag); // "Guest", 0

// Nested destructuring
const [p, [q, r]] = [1, [2, 3]];
console.log(p, q, r); // 1, 2, 3

const { user: { name: un, age: ua } } = { user: { name: "John", age: 30 } };
console.log(un, ua); // "John", 30

// Rest in destructuring
const [first, ...rest] = [1, 2, 3, 4, 5];
console.log(first, rest); // 1, [2, 3, 4, 5]

const { name: nm2, ...other } = { name: "John", age: 30, email: "john@example.com" };
console.log(nm2, other); // "John", { age: 30, email: "john@example.com" }

// Function parameters
function greet({ name, age }) {
  console.log(`${name} is ${age} years old`);
}

greet({ name: "John", age: 30 }); // "John is 30 years old"

// Swapping variables
let x2 = 5, y2 = 10;
[x2, y2] = [y2, x2];
console.log(x2, y2); // 10, 5
```

### Q66: What are Map and Set data structures?

**Answer:**
Map and Set are collections introduced in ES6 with different characteristics than objects and arrays.

```javascript
// Map - key-value pairs (any type of key)
const map = new Map();
map.set("name", "John");
map.set(1, "one");
map.set({ id: 1 }, "object");

console.log(map.get("name"));      // "John"
console.log(map.get(1));           // "one"
console.log(map.size);             // 3
console.log(map.has("name"));      // true
map.delete("name");
console.log(map.size);             // 2
map.clear();
console.log(map.size);             // 0

// Map initialization
const map2 = new Map([
  ["a", 1],
  ["b", 2],
  ["c", 3]
]);

// Map iteration
for (const [key, value] of map2) {
  console.log(key, value);
}

// Map methods
console.log(map2.keys());          // MapIterator
console.log(map2.values());        // MapIterator
console.log(map2.entries());       // MapIterator

// Set - unique values
const set = new Set();
set.add(1);
set.add(2);
set.add(2); // duplicate, not added
set.add(3);

console.log(set.size);             // 3
console.log(set.has(2));           // true
set.delete(2);
console.log(set.size);             // 2
set.clear();
console.log(set.size);             // 0

// Set initialization
const set2 = new Set([1, 2, 2, 3, 3, 3]);
console.log(set2.size);            // 3

// Set iteration
for (const value of set2) {
  console.log(value);
}

// Remove duplicates from array
const arr = [1, 2, 2, 3, 3, 3];
const unique = [...new Set(arr)];
console.log(unique);               // [1, 2, 3]

// Map vs Object
// Map: any type of key, maintains insertion order, has size property
// Object: string/symbol keys, order not guaranteed, no size property

// WeakMap and WeakSet (garbage collection friendly)
const weakMap = new WeakMap();
const obj = { id: 1 };
weakMap.set(obj, "value");
console.log(weakMap.get(obj));     // "value"

const weakSet = new WeakSet();
weakSet.add(obj);
console.log(weakSet.has(obj));     // true
```

### Q67: What are Symbols and what are they used for?

**Answer:**
Symbols are unique, immutable identifiers often used as object keys to avoid naming conflicts.

```javascript
// Creating symbols
const sym1 = Symbol("id");
const sym2 = Symbol("id");

console.log(sym1 === sym2);        // false (each symbol is unique)
console.log(typeof sym1);          // "symbol"

// Using symbols as object keys
const obj = {};
const id = Symbol("id");
obj[id] = 123;

console.log(obj[id]);              // 123
console.log(obj.id);               // undefined (not accessible with dot notation)

// Symbols are not enumerable
for (const key in obj) {
  console.log(key); // nothing (symbols not enumerated)
}

// Getting symbol properties
console.log(Object.getOwnPropertySymbols(obj)); // [Symbol(id)]

// Well-known symbols
// Symbol.iterator - makes object iterable
const iterable = {
  data: [1, 2, 3],
  [Symbol.iterator]: function() {
    let index = 0;
    return {
      next: () => {
        if (index < this.data.length) {
          return { value: this.data[index++], done: false };
        }
        return { done: true };
      }
    };
  }
};

for (const value of iterable) {
  console.log(value); // 1, 2, 3
}

// Symbol.hasInstance - customizes instanceof
class MyClass {
  static [Symbol.hasInstance](obj) {
    return obj.type === "MyClass";
  }
}

const obj2 = { type: "MyClass" };
console.log(obj2 instanceof MyClass); // true

// Symbol.toStringTag - customizes Object.prototype.toString
class MyType {
  get [Symbol.toStringTag]() {
    return "MyType";
  }
}

const instance = new MyType();
console.log(Object.prototype.toString.call(instance)); // "[object MyType]"

// Global symbols
const globalSym = Symbol.for("app.id");
const sameSym = Symbol.for("app.id");
console.log(globalSym === sameSym); // true

// Practical use: Private properties
const privateData = Symbol("private");
class User {
  constructor(name) {
    this.name = name;
    this[privateData] = "secret";
  }
  
  getPrivate() {
    return this[privateData];
  }
}

const user = new User("John");
console.log(user.name);            // "John"
console.log(user[privateData]);    // "secret"
console.log(user.getPrivate());    // "secret"
```

### Q68: What are Generators and how do they work?

**Answer:**
Generators are functions that can be paused and resumed, yielding values one at a time.

```javascript
// Generator function
function* simpleGenerator() {
  yield 1;
  yield 2;
  yield 3;
}

const gen = simpleGenerator();
console.log(gen.next()); // { value: 1, done: false }
console.log(gen.next()); // { value: 2, done: false }
console.log(gen.next()); // { value: 3, done: false }
console.log(gen.next()); // { value: undefined, done: true }

// Generator with for...of
function* generator2() {
  yield "a";
  yield "b";
  yield "c";
}

for (const value of generator2()) {
  console.log(value); // a, b, c
}

// Generator with return
function* generatorWithReturn() {
  yield 1;
  yield 2;
  return 3;
}

const gen2 = generatorWithReturn();
console.log(gen2.next()); // { value: 1, done: false }
console.log(gen2.next()); // { value: 2, done: false }
console.log(gen2.next()); // { value: 3, done: true }

// Generator with input
function* generatorWithInput() {
  const x = yield "Enter a number";
  const y = yield `You entered ${x}`;
  yield `Sum: ${x + y}`;
}

const gen3 = generatorWithInput();
console.log(gen3.next());      // { value: "Enter a number", done: false }
console.log(gen3.next(5));     // { value: "You entered 5", done: false }
console.log(gen3.next(3));     // { value: "Sum: 8", done: false }

// Infinite generator
function* infiniteGenerator() {
  let i = 0;
  while (true) {
    yield i++;
  }
}

const gen4 = infiniteGenerator();
console.log(gen4.next().value); // 0
console.log(gen4.next().value); // 1
console.log(gen4.next().value); // 2

// Practical example: Range generator
function* range(start, end) {
  for (let i = start; i < end; i++) {
    yield i;
  }
}

for (const num of range(1, 5)) {
  console.log(num); // 1, 2, 3, 4
}

// Practical example: Fibonacci
function* fibonacci() {
  let [a, b] = [0, 1];
  while (true) {
    yield a;
    [a, b] = [b, a + b];
  }
}

const fib = fibonacci();
console.log(fib.next().value); // 0
console.log(fib.next().value); // 1
console.log(fib.next().value); // 1
console.log(fib.next().value); // 2
console.log(fib.next().value); // 3
```

### Q69: What are Proxy and Reflect?

**Answer:**
Proxy allows intercepting and customizing operations on objects. Reflect provides methods for performing operations.

```javascript
// Basic Proxy
const target = { name: "John", age: 30 };
const handler = {
  get: (target, prop) => {
    console.log(`Getting ${prop}`);
    return target[prop];
  },
  set: (target, prop, value) => {
    console.log(`Setting ${prop} to ${value}`);
    target[prop] = value;
    return true;
  }
};

const proxy = new Proxy(target, handler);
console.log(proxy.name);  // "Getting name" then "John"
proxy.age = 31;           // "Setting age to 31"

// Proxy traps
const obj = {};
const handler2 = {
  get: (target, prop) => target[prop] || "default",
  set: (target, prop, value) => {
    if (typeof value === "number") {
      target[prop] = value;
      return true;
    }
    return false;
  },
  has: (target, prop) => prop in target,
  deleteProperty: (target, prop) => {
    delete target[prop];
    return true;
  },
  ownKeys: (target) => Object.keys(target),
  getOwnPropertyDescriptor: (target, prop) => {
    return Object.getOwnPropertyDescriptor(target, prop);
  }
};

const proxy2 = new Proxy(obj, handler2);
proxy2.x = 10;
console.log(proxy2.x);     // 10
console.log(proxy2.y);     // "default"
console.log("x" in proxy2); // true

// Reflect
const target2 = { name: "John" };
Reflect.set(target2, "age", 30);
console.log(Reflect.get(target2, "age")); // 30
console.log(Reflect.has(target2, "name")); // true
Reflect.deleteProperty(target2, "age");
console.log(Reflect.has(target2, "age")); // false

// Proxy with Reflect
const handler3 = {
  get: (target, prop) => {
    console.log(`Getting ${prop}`);
    return Reflect.get(target, prop);
  },
  set: (target, prop, value) => {
    console.log(`Setting ${prop} to ${value}`);
    return Reflect.set(target, prop, value);
  }
};

const proxy3 = new Proxy({}, handler3);
proxy3.x = 5;
console.log(proxy3.x);

// Practical example: Validation
const user = {};
const userProxy = new Proxy(user, {
  set: (target, prop, value) => {
    if (prop === "age" && typeof value !== "number") {
      throw new TypeError("Age must be a number");
    }
    if (prop === "email" && !value.includes("@")) {
      throw new TypeError("Invalid email");
    }
    target[prop] = value;
    return true;
  }
});

userProxy.age = 30;        // OK
userProxy.email = "john@example.com"; // OK
userProxy.age = "thirty";  // TypeError
```

### Q70: What are the differences between var, let, and const in ES6+?

**Answer:**
Already covered in Q6, but here's a summary with ES6+ context:

```javascript
// var - avoid in modern JavaScript
var x = 1;
var x = 2; // re-declaration allowed
x = 3;     // re-assignment allowed

// let - use for variables that change
let y = 1;
let y = 2; // SyntaxError
y = 3;     // OK

// const - use by default
const z = 1;
const z = 2; // SyntaxError
z = 3;       // TypeError

// const with objects (reference doesn't change, but properties can)
const obj = { name: "John" };
obj.name = "Jane"; // OK
obj = {};          // TypeError

// Best practice in ES6+:
// 1. Use const by default
// 2. Use let when reassignment needed
// 3. Avoid var
```



---

## DOM MANIPULATION

### Q71: What is the DOM and how do you select elements?

**Answer:**
The DOM (Document Object Model) is a tree representation of HTML. You can select elements using various methods.

```javascript
// getElementById
const element = document.getElementById("myId");

// getElementsByClassName
const elements = document.getElementsByClassName("myClass");

// getElementsByTagName
const divs = document.getElementsByTagName("div");

// querySelector (CSS selector)
const element2 = document.querySelector(".myClass");
const element3 = document.querySelector("#myId");
const element4 = document.querySelector("div.myClass");

// querySelectorAll
const elements2 = document.querySelectorAll(".myClass");
const elements3 = document.querySelectorAll("div > p");

// Difference between querySelector and getElementById
// querySelector: more flexible, slower
// getElementById: faster, only for IDs

// Practical example
const button = document.querySelector("button.primary");
const inputs = document.querySelectorAll("input[type='text']");
const parent = document.querySelector(".container");
```

### Q72: How do you manipulate DOM elements?

**Answer:**
You can modify element properties, attributes, and content.

```javascript
// Getting and setting content
const element = document.getElementById("myElement");
element.textContent = "New text";
element.innerHTML = "<p>New HTML</p>";
element.innerText = "New text";

// Difference:
// textContent: plain text, faster
// innerHTML: HTML content, slower, security risk
// innerText: visible text only

// Getting and setting attributes
element.getAttribute("data-id");
element.setAttribute("data-id", "123");
element.removeAttribute("data-id");
element.hasAttribute("data-id");

// Using dataset for data attributes
element.dataset.id = "123";
console.log(element.dataset.id); // "123"

// Getting and setting classes
element.classList.add("active");
element.classList.remove("active");
element.classList.toggle("active");
element.classList.contains("active");

// Getting and setting styles
element.style.color = "red";
element.style.backgroundColor = "blue";
element.style.display = "none";

// Getting computed styles
const styles = window.getComputedStyle(element);
console.log(styles.color);
console.log(styles.display);

// Creating and appending elements
const newElement = document.createElement("div");
newElement.textContent = "Hello";
document.body.appendChild(newElement);

// Inserting elements
const parent = document.getElementById("parent");
const newChild = document.createElement("p");
parent.insertBefore(newChild, parent.firstChild);
parent.appendChild(newChild);

// Removing elements
element.remove();
parent.removeChild(element);

// Cloning elements
const clone = element.cloneNode(true); // deep clone
const shallowClone = element.cloneNode(false); // shallow clone
```

### Q73: What are event listeners and how do you use them?

**Answer:**
Event listeners respond to user interactions and other events.

```javascript
// Adding event listener
const button = document.querySelector("button");
button.addEventListener("click", (event) => {
  console.log("Button clicked");
});

// Removing event listener
function handleClick() {
  console.log("Clicked");
}
button.addEventListener("click", handleClick);
button.removeEventListener("click", handleClick);

// Event object
button.addEventListener("click", (event) => {
  console.log(event.type);        // "click"
  console.log(event.target);      // the clicked element
  console.log(event.currentTarget); // the element with listener
  console.log(event.preventDefault); // prevent default behavior
  console.log(event.stopPropagation); // stop event bubbling
});

// Common events
// Mouse events
element.addEventListener("click", handler);
element.addEventListener("dblclick", handler);
element.addEventListener("mousedown", handler);
element.addEventListener("mouseup", handler);
element.addEventListener("mousemove", handler);
element.addEventListener("mouseenter", handler);
element.addEventListener("mouseleave", handler);

// Keyboard events
document.addEventListener("keydown", (event) => {
  console.log(event.key);
  console.log(event.code);
});
document.addEventListener("keyup", handler);
document.addEventListener("keypress", handler);

// Form events
input.addEventListener("change", handler);
input.addEventListener("input", handler);
form.addEventListener("submit", (event) => {
  event.preventDefault();
});

// Window events
window.addEventListener("load", handler);
window.addEventListener("resize", handler);
window.addEventListener("scroll", handler);

// Event delegation
const list = document.querySelector("ul");
list.addEventListener("click", (event) => {
  if (event.target.tagName === "LI") {
    console.log("List item clicked:", event.target.textContent);
  }
});

// Event options
button.addEventListener("click", handler, {
  capture: true,  // capture phase
  once: true,     // remove after first call
  passive: true   // won't call preventDefault
});
```

### Q74: What is event bubbling and event capturing?

**Answer:**
Event bubbling and capturing are two phases of event propagation in the DOM.

```javascript
// Event phases:
// 1. Capturing phase - event goes down from root to target
// 2. Target phase - event reaches target
// 3. Bubbling phase - event goes up from target to root

// Bubbling (default)
const parent = document.querySelector(".parent");
const child = document.querySelector(".child");

parent.addEventListener("click", () => {
  console.log("Parent clicked");
});

child.addEventListener("click", () => {
  console.log("Child clicked");
});

// Clicking child outputs:
// "Child clicked"
// "Parent clicked"

// Capturing
parent.addEventListener("click", () => {
  console.log("Parent capturing");
}, true); // true = capture phase

child.addEventListener("click", () => {
  console.log("Child capturing");
}, true);

// Clicking child outputs:
// "Parent capturing"
// "Child capturing"

// Stopping propagation
child.addEventListener("click", (event) => {
  event.stopPropagation();
  console.log("Child clicked");
});

parent.addEventListener("click", () => {
  console.log("Parent clicked"); // won't execute
});

// Stopping immediate propagation
child.addEventListener("click", (event) => {
  event.stopImmediatePropagation();
  console.log("First listener");
});

child.addEventListener("click", () => {
  console.log("Second listener"); // won't execute
});

// Preventing default behavior
const link = document.querySelector("a");
link.addEventListener("click", (event) => {
  event.preventDefault();
  console.log("Link click prevented");
});
```

---

## ERROR HANDLING

### Q75: What are the different types of errors in JavaScript?

**Answer:**
JavaScript has several built-in error types for different situations.

```javascript
// SyntaxError - parsing error
// const x = ; // SyntaxError

// ReferenceError - variable not defined
console.log(undefinedVar); // ReferenceError

// TypeError - wrong type
const x = null;
x.property; // TypeError

// RangeError - value out of range
const arr = new Array(-1); // RangeError

// URIError - invalid URI
decodeURIComponent("%"); // URIError

// Custom error
class CustomError extends Error {
  constructor(message) {
    super(message);
    this.name = "CustomError";
  }
}

throw new CustomError("Something went wrong");

// Error properties
try {
  throw new Error("Test error");
} catch (error) {
  console.log(error.message);    // "Test error"
  console.log(error.name);       // "Error"
  console.log(error.stack);      // stack trace
}
```

### Q76: How do you handle errors with try/catch/finally?

**Answer:**
Try/catch/finally blocks handle errors gracefully.

```javascript
// Basic try/catch
try {
  // code that might throw error
  throw new Error("Something went wrong");
} catch (error) {
  console.log("Error caught:", error.message);
}

// try/catch/finally
try {
  const result = riskyOperation();
  console.log(result);
} catch (error) {
  console.log("Error:", error.message);
} finally {
  console.log("Cleanup code"); // always executes
}

// Catching specific errors
try {
  JSON.parse("invalid json");
} catch (error) {
  if (error instanceof SyntaxError) {
    console.log("JSON parsing error");
  } else if (error instanceof TypeError) {
    console.log("Type error");
  }
}

// Rethrowing errors
try {
  try {
    throw new Error("Inner error");
  } catch (error) {
    console.log("Inner catch");
    throw error; // rethrow
  }
} catch (error) {
  console.log("Outer catch:", error.message);
}

// Error handling in async/await
async function fetchData() {
  try {
    const response = await fetch('/api/data');
    const data = await response.json();
    return data;
  } catch (error) {
    console.log("Error:", error.message);
    throw error;
  } finally {
    console.log("Request completed");
  }
}

// Error handling with promises
fetch('/api/data')
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.log("Error:", error))
  .finally(() => console.log("Done"));
```

### Q77: What is the difference between throw and return?

**Answer:**

```javascript
// throw - stops execution and throws error
function test1() {
  throw new Error("Error occurred");
  console.log("This won't execute");
}

// return - stops execution and returns value
function test2() {
  return "Success";
  console.log("This won't execute");
}

// throw in try/catch
try {
  throw new Error("Test");
} catch (error) {
  console.log(error.message); // "Test"
}

// throw vs return
function divide(a, b) {
  if (b === 0) {
    throw new Error("Division by zero");
  }
  return a / b;
}

try {
  console.log(divide(10, 2)); // 5
  console.log(divide(10, 0)); // throws error
} catch (error) {
  console.log("Error:", error.message);
}
```

---

## ADVANCED CONCEPTS

### Q78: What is the difference between == and === (revisited with edge cases)?

**Answer:**
Already covered in Q3, but here are more edge cases:

```javascript
// Strict equality (===) - no type coercion
console.log(0 === false);        // false
console.log("" === false);       // false
console.log(null === undefined); // false

// Loose equality (==) - type coercion
console.log(0 == false);         // true
console.log("" == false);        // true
console.log(null == undefined);  // true

// Weird cases
console.log([] == false);        // true
console.log([] == "");           // true
console.log([] == 0);            // true
console.log("0" == false);       // true
console.log("0" == 0);           // true

// Best practice: Always use ===
```

### Q79: What is the this keyword in different contexts?

**Answer:**
Already covered in Q15, but here's a comprehensive review:

```javascript
// Global context
console.log(this); // window (browser) or global (Node.js)

// Function context
function test() {
  console.log(this); // window or global (non-strict)
}

// Strict mode
function testStrict() {
  "use strict";
  console.log(this); // undefined
}

// Object method
const obj = {
  name: "John",
  greet: function() {
    console.log(this.name); // "John"
  }
};

// Arrow function (inherits this)
const obj2 = {
  name: "Jane",
  greet: () => {
    console.log(this); // global (not obj2)
  }
};

// Constructor
function Person(name) {
  this.name = name;
}

// Explicit binding
function introduce() {
  console.log(this.name);
}

const person = { name: "John" };
introduce.call(person);      // "John"
introduce.apply(person);     // "John"
const bound = introduce.bind(person);
bound();                      // "John"
```

### Q80: What is the difference between shallow and deep equality?

**Answer:**

```javascript
// Shallow equality - only compares first level
function shallowEqual(obj1, obj2) {
  const keys1 = Object.keys(obj1);
  const keys2 = Object.keys(obj2);
  
  if (keys1.length !== keys2.length) return false;
  
  for (let key of keys1) {
    if (obj1[key] !== obj2[key]) return false;
  }
  
  return true;
}

const obj1 = { a: 1, b: { c: 2 } };
const obj2 = { a: 1, b: { c: 2 } };

console.log(shallowEqual(obj1, obj2)); // false (nested objects different)
console.log(obj1 === obj2);           // false

// Deep equality - compares all levels
function deepEqual(obj1, obj2) {
  if (obj1 === obj2) return true;
  
  if (obj1 == null || obj2 == null) return false;
  if (typeof obj1 !== "object" || typeof obj2 !== "object") return false;
  
  const keys1 = Object.keys(obj1);
  const keys2 = Object.keys(obj2);
  
  if (keys1.length !== keys2.length) return false;
  
  for (let key of keys1) {
    if (!deepEqual(obj1[key], obj2[key])) return false;
  }
  
  return true;
}

console.log(deepEqual(obj1, obj2)); // true
```

### Q81: What is memoization and how do you implement it?

**Answer:**
Memoization caches function results to avoid redundant calculations.

```javascript
// Simple memoization
function memoize(func) {
  const cache = {};
  
  return function(...args) {
    const key = JSON.stringify(args);
    
    if (key in cache) {
      console.log("From cache");
      return cache[key];
    }
    
    console.log("Computing");
    const result = func(...args);
    cache[key] = result;
    return result;
  };
}

function add(a, b) {
  return a + b;
}

const memoizedAdd = memoize(add);
console.log(memoizedAdd(1, 2)); // Computing, 3
console.log(memoizedAdd(1, 2)); // From cache, 3

// Memoization with fibonacci
function fibonacci(n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

const memoizedFib = memoize(fibonacci);
console.log(memoizedFib(10)); // Much faster

// Practical example: API caching
const memoizedFetch = memoize(async (url) => {
  const response = await fetch(url);
  return response.json();
});
```

### Q82: What is currying and how do you implement it?

**Answer:**
Currying transforms a function with multiple arguments into a series of functions with single arguments.

```javascript
// Regular function
function add(a, b, c) {
  return a + b + c;
}

console.log(add(1, 2, 3)); // 6

// Curried function
function curriedAdd(a) {
  return function(b) {
    return function(c) {
      return a + b + c;
    };
  };
}

console.log(curriedAdd(1)(2)(3)); // 6

// Arrow function version
const curriedAdd2 = a => b => c => a + b + c;
console.log(curriedAdd2(1)(2)(3)); // 6

// Generic curry function
function curry(func) {
  return function curried(...args) {
    if (args.length >= func.length) {
      return func(...args);
    }
    return (...nextArgs) => curried(...args, ...nextArgs);
  };
}

const add2 = (a, b, c) => a + b + c;
const curriedAdd3 = curry(add2);

console.log(curriedAdd3(1)(2)(3)); // 6
console.log(curriedAdd3(1, 2)(3)); // 6
console.log(curriedAdd3(1)(2, 3)); // 6

// Practical example: Configuration
const multiply = (a, b) => a * b;
const curriedMultiply = curry(multiply);
const double = curriedMultiply(2);
const triple = curriedMultiply(3);

console.log(double(5));  // 10
console.log(triple(5));  // 15
```

### Q83: What is partial application?

**Answer:**
Partial application creates a new function by fixing some arguments of an existing function.

```javascript
// Partial application
function partial(func, ...fixedArgs) {
  return function(...remainingArgs) {
    return func(...fixedArgs, ...remainingArgs);
  };
}

function add(a, b, c) {
  return a + b + c;
}

const add5 = partial(add, 5);
console.log(add5(2, 3)); // 10

const add5and2 = partial(add, 5, 2);
console.log(add5and2(3)); // 10

// Using bind for partial application
const add10 = add.bind(null, 10);
console.log(add10(2, 3)); // 15

// Practical example
function greet(greeting, name, punctuation) {
  return greeting + ", " + name + punctuation;
}

const greetHello = partial(greet, "Hello");
console.log(greetHello("John", "!")); // "Hello, John!"

const greetHelloJohn = partial(greet, "Hello", "John");
console.log(greetHelloJohn("!")); // "Hello, John!"
```

### Q84: What is the difference between composition and inheritance?

**Answer:**

```javascript
// Inheritance - "is-a" relationship
class Animal {
  eat() {
    console.log("Eating");
  }
}

class Dog extends Animal {
  bark() {
    console.log("Woof");
  }
}

const dog = new Dog();
dog.eat();  // "Eating"
dog.bark(); // "Woof"

// Composition - "has-a" relationship
const canEat = {
  eat: function() {
    console.log("Eating");
  }
};

const canBark = {
  bark: function() {
    console.log("Woof");
  }
};

const dog2 = Object.assign({}, canEat, canBark);
dog2.eat();  // "Eating"
dog2.bark(); // "Woof"

// Composition with functions
function createDog(name) {
  return {
    name,
    eat: () => console.log(name + " is eating"),
    bark: () => console.log(name + " is barking")
  };
}

const myDog = createDog("Rex");
myDog.eat();  // "Rex is eating"
myDog.bark(); // "Rex is barking"

// Composition is more flexible and avoids deep inheritance hierarchies
```

### Q85: What is the Observer Pattern?

**Answer:**
The Observer Pattern defines a one-to-many relationship where multiple observers watch for changes in a subject.

```javascript
// Simple observer pattern
class Subject {
  constructor() {
    this.observers = [];
  }
  
  subscribe(observer) {
    this.observers.push(observer);
  }
  
  unsubscribe(observer) {
    this.observers = this.observers.filter(obs => obs !== observer);
  }
  
  notify(data) {
    this.observers.forEach(observer => observer.update(data));
  }
}

class Observer {
  constructor(name) {
    this.name = name;
  }
  
  update(data) {
    console.log(`${this.name} received: ${data}`);
  }
}

const subject = new Subject();
const observer1 = new Observer("Observer 1");
const observer2 = new Observer("Observer 2");

subject.subscribe(observer1);
subject.subscribe(observer2);

subject.notify("Hello"); // Both observers notified

// Practical example: Event emitter
class EventEmitter {
  constructor() {
    this.events = {};
  }
  
  on(event, listener) {
    if (!this.events[event]) {
      this.events[event] = [];
    }
    this.events[event].push(listener);
  }
  
  emit(event, data) {
    if (this.events[event]) {
      this.events[event].forEach(listener => listener(data));
    }
  }
  
  off(event, listener) {
    if (this.events[event]) {
      this.events[event] = this.events[event].filter(l => l !== listener);
    }
  }
}

const emitter = new EventEmitter();
emitter.on("message", (data) => console.log("Received:", data));
emitter.emit("message", "Hello"); // "Received: Hello"
```



---

## PERFORMANCE & OPTIMIZATION

### Q86: What are the main performance optimization techniques?

**Answer:**
Performance optimization involves reducing load time, improving responsiveness, and efficient resource usage.

```javascript
// 1. Debouncing - delay function execution
function debounce(func, delay) {
  let timeoutId;
  return function(...args) {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => func(...args), delay);
  };
}

const handleSearch = debounce((query) => {
  console.log("Searching:", query);
}, 500);

// 2. Throttling - limit function execution frequency
function throttle(func, delay) {
  let lastCall = 0;
  return function(...args) {
    const now = Date.now();
    if (now - lastCall >= delay) {
      func(...args);
      lastCall = now;
    }
  };
}

const handleScroll = throttle(() => {
  console.log("Scroll event");
}, 1000);

// 3. Lazy loading - load resources on demand
const images = document.querySelectorAll("img[data-src]");
const imageObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const img = entry.target;
      img.src = img.dataset.src;
      imageObserver.unobserve(img);
    }
  });
});

images.forEach(img => imageObserver.observe(img));

// 4. Code splitting - load code on demand
// Dynamic import
import('./module.js').then(module => {
  module.doSomething();
});

// 5. Memoization - cache results
const memoize = (func) => {
  const cache = {};
  return (...args) => {
    const key = JSON.stringify(args);
    return key in cache ? cache[key] : (cache[key] = func(...args));
  };
};

// 6. Avoiding memory leaks
// Remove event listeners
const handler = () => console.log("clicked");
element.addEventListener("click", handler);
element.removeEventListener("click", handler);

// Clear timers
const timeoutId = setTimeout(() => {}, 1000);
clearTimeout(timeoutId);

// 7. Efficient DOM manipulation
// Bad - multiple reflows
for (let i = 0; i < 1000; i++) {
  element.style.width = i + "px";
}

// Good - batch updates
element.style.width = "1000px";

// 8. Using requestAnimationFrame
function animate() {
  element.style.transform = "translateX(10px)";
  requestAnimationFrame(animate);
}

// 9. Minimizing reflows and repaints
// Bad
for (let i = 0; i < 100; i++) {
  element.style.left = i + "px";
}

// Good
const fragment = document.createDocumentFragment();
for (let i = 0; i < 100; i++) {
  const div = document.createElement("div");
  fragment.appendChild(div);
}
document.body.appendChild(fragment);
```

### Q87: What is the difference between reflow and repaint?

**Answer:**

```javascript
// Reflow - recalculating layout
// Triggered by:
// - Changing dimensions (width, height)
// - Changing position (top, left)
// - Changing display property
// - Adding/removing elements

// Repaint - redrawing pixels
// Triggered by:
// - Changing colors
// - Changing background
// - Changing opacity

// Expensive operations (cause reflow)
element.style.width = "100px";      // reflow
element.style.height = "100px";     // reflow
element.style.left = "10px";        // reflow

// Less expensive operations (cause repaint)
element.style.color = "red";        // repaint
element.style.backgroundColor = "blue"; // repaint
element.style.opacity = "0.5";      // repaint

// Optimization: batch DOM changes
// Bad
element.style.width = "100px";
element.style.height = "100px";
element.style.left = "10px";

// Good
element.style.cssText = "width: 100px; height: 100px; left: 10px;";

// Or use classes
element.classList.add("new-style");
```

### Q88: What is the Virtual DOM and how does it improve performance?

**Answer:**
The Virtual DOM is an in-memory representation of the real DOM used by frameworks like React.

```javascript
// Simplified Virtual DOM concept
class VirtualDOM {
  constructor(type, props, children) {
    this.type = type;
    this.props = props;
    this.children = children;
  }
}

// Creating virtual elements
const vdom = new VirtualDOM("div", { className: "container" }, [
  new VirtualDOM("h1", {}, ["Hello"]),
  new VirtualDOM("p", {}, ["World"])
]);

// Diffing algorithm - compare old and new VDOM
function diff(oldVdom, newVdom) {
  if (oldVdom.type !== newVdom.type) {
    return "REPLACE";
  }
  
  if (oldVdom.props !== newVdom.props) {
    return "UPDATE_PROPS";
  }
  
  if (oldVdom.children !== newVdom.children) {
    return "UPDATE_CHILDREN";
  }
  
  return "NO_CHANGE";
}

// Benefits of Virtual DOM:
// 1. Batches DOM updates
// 2. Minimizes reflows and repaints
// 3. Improves performance for complex UIs
// 4. Easier to reason about state changes
```

### Q89: What are Web Workers and how do they improve performance?

**Answer:**
Web Workers run JavaScript in background threads, preventing UI blocking.

```javascript
// Main thread
const worker = new Worker("worker.js");

// Send data to worker
worker.postMessage({ data: [1, 2, 3, 4, 5] });

// Receive data from worker
worker.onmessage = (event) => {
  console.log("Result from worker:", event.data);
};

// Worker file (worker.js)
self.onmessage = (event) => {
  const data = event.data.data;
  const result = data.reduce((a, b) => a + b);
  self.postMessage(result);
};

// Benefits:
// 1. Non-blocking heavy computations
// 2. Parallel processing
// 3. Improved UI responsiveness

// Practical example: Image processing
const imageWorker = new Worker("image-worker.js");
imageWorker.postMessage({ imageData: canvas.getImageData(0, 0, width, height) });
imageWorker.onmessage = (event) => {
  const processedData = event.data;
  // Update canvas with processed data
};
```

### Q90: What is the difference between synchronous and asynchronous code in terms of performance?

**Answer:**

```javascript
// Synchronous - blocks execution
function syncTask() {
  console.log("Start");
  for (let i = 0; i < 1000000000; i++) {} // blocks
  console.log("End");
}

syncTask(); // UI freezes during execution

// Asynchronous - doesn't block
function asyncTask() {
  console.log("Start");
  setTimeout(() => {
    console.log("End");
  }, 0);
  console.log("Middle");
}

asyncTask(); // UI remains responsive

// Performance implications:
// Synchronous: Simple but can freeze UI
// Asynchronous: More complex but keeps UI responsive

// Breaking long tasks into chunks
function processLargeArray(arr, callback) {
  let index = 0;
  
  function processChunk() {
    const chunkSize = 1000;
    const end = Math.min(index + chunkSize, arr.length);
    
    for (let i = index; i < end; i++) {
      // process arr[i]
    }
    
    index = end;
    
    if (index < arr.length) {
      setTimeout(processChunk, 0);
    } else {
      callback();
    }
  }
  
  processChunk();
}
```

---

## BROWSER APIs

### Q91: What is the Fetch API and how do you use it?

**Answer:**
The Fetch API provides a modern way to make HTTP requests.

```javascript
// Basic fetch
fetch('/api/data')
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.log(error));

// Fetch with options
fetch('/api/data', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({ name: 'John' })
})
  .then(response => response.json())
  .then(data => console.log(data));

// Fetch with async/await
async function fetchData() {
  try {
    const response = await fetch('/api/data');
    if (!response.ok) throw new Error('Network error');
    const data = await response.json();
    return data;
  } catch (error) {
    console.log('Error:', error);
  }
}

// Response methods
fetch('/api/data')
  .then(response => {
    console.log(response.status);      // 200
    console.log(response.statusText);  // "OK"
    console.log(response.headers);     // Headers object
    return response.json();            // parse as JSON
    // or response.text()
    // or response.blob()
    // or response.arrayBuffer()
  });

// Request headers
const headers = new Headers({
  'Content-Type': 'application/json',
  'Authorization': 'Bearer token'
});

fetch('/api/data', { headers });

// Abort fetch
const controller = new AbortController();
const timeoutId = setTimeout(() => controller.abort(), 5000);

fetch('/api/data', { signal: controller.signal })
  .then(response => response.json())
  .catch(error => {
    if (error.name === 'AbortError') {
      console.log('Request aborted');
    }
  })
  .finally(() => clearTimeout(timeoutId));
```

### Q92: What is localStorage and sessionStorage?

**Answer:**
Web Storage APIs allow storing data on the client side.

```javascript
// localStorage - persists until manually cleared
localStorage.setItem('name', 'John');
console.log(localStorage.getItem('name')); // "John"
localStorage.removeItem('name');
localStorage.clear(); // clear all

// sessionStorage - cleared when tab closes
sessionStorage.setItem('sessionId', '12345');
console.log(sessionStorage.getItem('sessionId')); // "12345"

// Storing objects
const user = { name: 'John', age: 30 };
localStorage.setItem('user', JSON.stringify(user));
const retrievedUser = JSON.parse(localStorage.getItem('user'));

// Checking if key exists
if (localStorage.getItem('name')) {
  console.log('Name exists');
}

// Iterating through storage
for (let i = 0; i < localStorage.length; i++) {
  const key = localStorage.key(i);
  const value = localStorage.getItem(key);
  console.log(key, value);
}

// Storage events
window.addEventListener('storage', (event) => {
  console.log('Storage changed:', event.key, event.newValue);
});

// Practical example: User preferences
function savePreferences(prefs) {
  localStorage.setItem('preferences', JSON.stringify(prefs));
}

function getPreferences() {
  const prefs = localStorage.getItem('preferences');
  return prefs ? JSON.parse(prefs) : {};
}
```

### Q93: What is the Geolocation API?

**Answer:**
The Geolocation API provides access to the user's location.

```javascript
// Get current position
navigator.geolocation.getCurrentPosition(
  (position) => {
    console.log(position.coords.latitude);
    console.log(position.coords.longitude);
    console.log(position.coords.accuracy);
  },
  (error) => {
    console.log('Error:', error.message);
  }
);

// Watch position (continuous updates)
const watchId = navigator.geolocation.watchPosition(
  (position) => {
    console.log('New position:', position.coords);
  },
  (error) => {
    console.log('Error:', error.message);
  }
);

// Stop watching
navigator.geolocation.clearWatch(watchId);

// With options
navigator.geolocation.getCurrentPosition(
  (position) => {
    console.log(position);
  },
  (error) => {
    console.log(error);
  },
  {
    enableHighAccuracy: true,
    timeout: 5000,
    maximumAge: 0
  }
);

// Practical example: Show user on map
function showUserLocation() {
  navigator.geolocation.getCurrentPosition((position) => {
    const { latitude, longitude } = position.coords;
    // Use latitude and longitude with map API
  });
}
```

### Q94: What is the Notification API?

**Answer:**
The Notification API allows sending notifications to the user.

```javascript
// Request permission
Notification.requestPermission().then(permission => {
  if (permission === 'granted') {
    console.log('Notification permission granted');
  }
});

// Send notification
if (Notification.permission === 'granted') {
  new Notification('Hello!', {
    body: 'This is a notification',
    icon: '/icon.png',
    badge: '/badge.png',
    tag: 'notification-1',
    requireInteraction: true
  });
}

// Notification events
const notification = new Notification('Title');
notification.onclick = () => {
  console.log('Notification clicked');
};
notification.onclose = () => {
  console.log('Notification closed');
};
notification.onerror = () => {
  console.log('Notification error');
};

// Practical example: Show notification after delay
function scheduleNotification(title, delay) {
  setTimeout(() => {
    if (Notification.permission === 'granted') {
      new Notification(title);
    }
  }, delay);
}
```

### Q95: What is the Intersection Observer API?

**Answer:**
The Intersection Observer API detects when elements enter or leave the viewport.

```javascript
// Create observer
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      console.log('Element is visible');
      entry.target.classList.add('visible');
    } else {
      console.log('Element is not visible');
      entry.target.classList.remove('visible');
    }
  });
});

// Observe elements
const elements = document.querySelectorAll('.lazy-load');
elements.forEach(el => observer.observe(el));

// Stop observing
observer.unobserve(element);
observer.disconnect();

// Options
const options = {
  root: null,           // viewport
  rootMargin: '0px',    // margin around root
  threshold: 0.5        // 50% visible
};

const observer2 = new IntersectionObserver(callback, options);

// Practical example: Lazy loading images
const images = document.querySelectorAll('img[data-src]');
const imageObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const img = entry.target;
      img.src = img.dataset.src;
      img.removeAttribute('data-src');
      imageObserver.unobserve(img);
    }
  });
});

images.forEach(img => imageObserver.observe(img));

// Practical example: Infinite scroll
const sentinel = document.querySelector('.sentinel');
const observer3 = new IntersectionObserver((entries) => {
  if (entries[0].isIntersecting) {
    loadMoreContent();
  }
});

observer3.observe(sentinel);
```

### Q96: What is the Mutation Observer API?

**Answer:**
The Mutation Observer API detects changes to the DOM.

```javascript
// Create observer
const observer = new MutationObserver((mutations) => {
  mutations.forEach(mutation => {
    console.log('Mutation type:', mutation.type);
    console.log('Target:', mutation.target);
    
    if (mutation.type === 'childList') {
      console.log('Children added/removed');
    } else if (mutation.type === 'attributes') {
      console.log('Attribute changed:', mutation.attributeName);
    } else if (mutation.type === 'characterData') {
      console.log('Text content changed');
    }
  });
});

// Options
const options = {
  childList: true,        // watch for added/removed children
  attributes: true,       // watch for attribute changes
  characterData: true,    // watch for text changes
  subtree: true,          // watch all descendants
  attributeFilter: ['class', 'id'], // specific attributes
  attributeOldValue: true, // record old attribute value
  characterDataOldValue: true // record old text value
};

// Start observing
const element = document.querySelector('.container');
observer.observe(element, options);

// Stop observing
observer.disconnect();

// Practical example: Track dynamic content changes
const contentObserver = new MutationObserver((mutations) => {
  mutations.forEach(mutation => {
    if (mutation.type === 'childList') {
      mutation.addedNodes.forEach(node => {
        if (node.nodeType === 1) { // Element node
          console.log('New element added:', node.tagName);
        }
      });
    }
  });
});

contentObserver.observe(document.body, {
  childList: true,
  subtree: true
});
```

### Q97: What is the Service Worker API?

**Answer:**
Service Workers are scripts that run in the background, enabling offline functionality and caching.

```javascript
// Register service worker
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/sw.js')
    .then(registration => {
      console.log('Service Worker registered');
    })
    .catch(error => {
      console.log('Service Worker registration failed:', error);
    });
}

// Service Worker file (sw.js)
self.addEventListener('install', (event) => {
  console.log('Service Worker installing');
  event.waitUntil(
    caches.open('v1').then((cache) => {
      return cache.addAll([
        '/',
        '/index.html',
        '/styles.css',
        '/script.js'
      ]);
    })
  );
});

self.addEventListener('activate', (event) => {
  console.log('Service Worker activating');
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== 'v1') {
            return caches.delete(cacheName);
          }
        })
      );
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

// Unregister service worker
navigator.serviceWorker.getRegistrations().then((registrations) => {
  registrations.forEach(registration => {
    registration.unregister();
  });
});
```

### Q98: What is the Canvas API?

**Answer:**
The Canvas API allows drawing graphics using JavaScript.

```javascript
// Get canvas context
const canvas = document.querySelector('canvas');
const ctx = canvas.getContext('2d');

// Drawing shapes
ctx.fillStyle = 'red';
ctx.fillRect(10, 10, 100, 100); // filled rectangle

ctx.strokeStyle = 'blue';
ctx.strokeRect(10, 10, 100, 100); // outlined rectangle

ctx.clearRect(10, 10, 50, 50); // clear area

// Drawing circles
ctx.beginPath();
ctx.arc(100, 100, 50, 0, Math.PI * 2);
ctx.fill();

// Drawing lines
ctx.beginPath();
ctx.moveTo(0, 0);
ctx.lineTo(100, 100);
ctx.stroke();

// Drawing text
ctx.font = '20px Arial';
ctx.fillText('Hello', 10, 50);
ctx.strokeText('World', 10, 100);

// Transformations
ctx.translate(50, 50);
ctx.rotate(Math.PI / 4);
ctx.scale(2, 2);

// Saving and restoring state
ctx.save();
ctx.fillStyle = 'red';
ctx.fillRect(0, 0, 100, 100);
ctx.restore();
ctx.fillStyle = 'blue'; // back to previous

// Getting image data
const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
const data = imageData.data; // pixel data

// Practical example: Simple animation
function animate() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  ctx.fillStyle = 'red';
  ctx.fillRect(x, y, 50, 50);
  x += 1;
  requestAnimationFrame(animate);
}

animate();
```

### Q99: What is the Web Audio API?

**Answer:**
The Web Audio API provides audio processing and synthesis capabilities.

```javascript
// Create audio context
const audioContext = new (window.AudioContext || window.webkitAudioContext)();

// Load and play audio
const audioElement = document.querySelector('audio');
const source = audioContext.createMediaElementAudioSource(audioElement);

// Create gain node (volume control)
const gainNode = audioContext.createGain();
gainNode.gain.value = 0.5;

// Connect nodes
source.connect(gainNode);
gainNode.connect(audioContext.destination);

// Play audio
audioElement.play();

// Adjust volume
gainNode.gain.value = 0.8;

// Create oscillator (tone generation)
const oscillator = audioContext.createOscillator();
oscillator.frequency.value = 440; // A4 note
oscillator.type = 'sine';

const gain = audioContext.createGain();
gain.gain.setValueAtTime(0.3, audioContext.currentTime);
gain.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 1);

oscillator.connect(gain);
gain.connect(audioContext.destination);

oscillator.start(audioContext.currentTime);
oscillator.stop(audioContext.currentTime + 1);

// Practical example: Simple synthesizer
function playNote(frequency, duration) {
  const osc = audioContext.createOscillator();
  const gain = audioContext.createGain();
  
  osc.frequency.value = frequency;
  osc.connect(gain);
  gain.connect(audioContext.destination);
  
  gain.gain.setValueAtTime(0.3, audioContext.currentTime);
  gain.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + duration);
  
  osc.start(audioContext.currentTime);
  osc.stop(audioContext.currentTime + duration);
}

playNote(440, 0.5); // A4 for 0.5 seconds
```

### Q100: What is the Fullscreen API?

**Answer:**
The Fullscreen API allows elements to be displayed in fullscreen mode.

```javascript
// Request fullscreen
const element = document.querySelector('.video-container');

element.requestFullscreen()
  .then(() => {
    console.log('Entered fullscreen');
  })
  .catch(error => {
    console.log('Error entering fullscreen:', error);
  });

// Exit fullscreen
document.exitFullscreen();

// Check if fullscreen is supported
if (document.fullscreenEnabled) {
  console.log('Fullscreen is supported');
}

// Check current fullscreen element
console.log(document.fullscreenElement); // element or null

// Fullscreen events
document.addEventListener('fullscreenchange', () => {
  if (document.fullscreenElement) {
    console.log('Entered fullscreen');
  } else {
    console.log('Exited fullscreen');
  }
});

document.addEventListener('fullscreenerror', () => {
  console.log('Fullscreen error');
});

// Practical example: Video player fullscreen button
const video = document.querySelector('video');
const fullscreenBtn = document.querySelector('.fullscreen-btn');

fullscreenBtn.addEventListener('click', () => {
  if (!document.fullscreenElement) {
    video.requestFullscreen();
  } else {
    document.exitFullscreen();
  }
});
```

---

## CONCLUSION

This comprehensive guide covers JavaScript from basic to advanced concepts. Key takeaways:

1. **Master the fundamentals**: Understand data types, scope, closures, and the event loop
2. **Learn modern syntax**: Use ES6+ features like arrow functions, classes, and destructuring
3. **Understand asynchronous programming**: Promises, async/await, and the event loop are crucial
4. **Practice optimization**: Debouncing, throttling, and efficient DOM manipulation matter
5. **Know the APIs**: Fetch, localStorage, Intersection Observer, and others are essential for modern web development

Keep practicing and building projects to solidify your understanding. Good luck with your interviews!

