# This script generates the complete JavaScript Interview Guide

$content = @"
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

\`\`\`javascript
// Example of dynamic typing
let x = 5;           // number
x = "hello";         // string
x = true;            // boolean
x = { name: "John" }; // object
\`\`\`

---

## CONCLUSION

This comprehensive guide covers JavaScript from basic to advanced concepts. Key takeaways:

1. **Master the fundamentals**: Understand data types, scope, closures, and the event loop
2. **Learn modern syntax**: Use ES6+ features like arrow functions, classes, and destructuring
3. **Understand asynchronous programming**: Promises, async/await, and the event loop are crucial
4. **Practice optimization**: Debouncing, throttling, and efficient DOM manipulation matter
5. **Know the APIs**: Fetch, localStorage, Intersection Observer, and others are essential for modern web development

Keep practicing and building projects to solidify your understanding. Good luck with your interviews!
"@

$content | Out-File -FilePath "javascript/JavaScript_Interview_Guide.md" -Encoding UTF8
Write-Host "File generated successfully!"
