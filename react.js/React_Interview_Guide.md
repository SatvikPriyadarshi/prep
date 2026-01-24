# React.js Interview Guide

## Table of Contents

### Core React Concepts
1. [Fundamentals](#fundamentals)
2. [Components & Props](#components--props)
3. [State & Lifecycle](#state--lifecycle)
4. [Event Handling](#event-handling)
5. [Conditional Rendering](#conditional-rendering)
6. [Lists & Keys](#lists--keys)
7. [Forms & Controlled Components](#forms--controlled-components)
8. [Composition vs Inheritance](#composition-vs-inheritance)
9. [Context API](#context-api)
10. [Refs](#refs)
11. [Fragments](#fragments)
12. [Portals](#portals)
13. [Error Boundaries](#error-boundaries)

### Advanced React Features
14. [Higher-Order Components (HOCs)](#higher-order-components-hocs)
15. [Render Props](#render-props)
16. [Pure Components](#pure-components)

### React Hooks
17. [useState Hook](#usestate-hook)
18. [useEffect Hook](#useeffect-hook)
19. [useContext Hook](#usecontext-hook)
20. [useReducer Hook](#usereducer-hook)
21. [useCallback Hook](#usecallback-hook)
22. [useMemo Hook](#usememo-hook)
23. [useRef Hook](#useref-hook)
24. [Custom Hooks](#custom-hooks)
25. [Additional Hooks](#additional-hooks)

### Performance & Optimization
26. [Memoization](#memoization)
27. [Code Splitting](#code-splitting)
28. [Lazy Loading](#lazy-loading)
29. [Virtual DOM](#virtual-dom)
30. [Reconciliation](#reconciliation)

### State Management
31. [Local State](#local-state)
32. [Lifting State Up](#lifting-state-up)
33. [State Management Libraries](#state-management-libraries)
34. [Global State Patterns](#global-state-patterns)

### Routing & Navigation
35. [React Router Basics](#react-router-basics)
36. [Advanced Routing](#advanced-routing)
37. [Navigation & Guards](#navigation--guards)

### Styling
38. [Styling Approaches](#styling-approaches)
39. [CSS-in-JS](#css-in-js)
40. [CSS Modules](#css-modules)

### Testing
41. [Testing Fundamentals](#testing-fundamentals)
42. [Testing Tools](#testing-tools)
43. [Testing Strategies](#testing-strategies)

### Architecture & Patterns
44. [Design Patterns](#design-patterns)
45. [Project Structure](#project-structure)
46. [Best Practices](#best-practices)

### Server-Side & Frameworks
47. [SSR Basics](#ssr-basics)
48. [Next.js](#nextjs)
49. [Data Fetching in SSR](#data-fetching-in-ssr)

### Build & Development
50. [Build Tools](#build-tools)
51. [Dev Tools](#dev-tools)
52. [TypeScript with React](#typescript-with-react)

### Advanced Topics
53. [Advanced Patterns](#advanced-patterns)
54. [React Internals](#react-internals)
55. [Concurrent Features](#concurrent-features)
56. [Suspense](#suspense)
57. [Experimental APIs](#experimental-apis)

### Practical & System Design
- [Practical Scenario-Based Questions](#bonus-practical-scenario-based-questions)
- [System Design Questions](#system-design-questions)
- [Behavioral & Experience Questions](#behavioral--experience-questions)

---

## Core React Concepts

### Fundamentals

#### 1. What is React and what problem does it solve?

**Answer:**

React is a JavaScript library developed by Facebook for building user interfaces with reusable components. It focuses on the "View" layer of the MVC architecture.

**Problems it solves:**
- **Complex UI Management**: Traditional DOM manipulation becomes difficult as applications grow. React abstracts this complexity.
- **State Synchronization**: Keeping UI in sync with application state is challenging. React automatically updates the UI when state changes.
- **Code Reusability**: React's component-based architecture promotes reusable, maintainable code.
- **Performance**: React optimizes DOM updates through its Virtual DOM and reconciliation algorithm.
- **Developer Experience**: React provides a declarative way to describe UIs, making code more predictable and easier to debug.

**Real-world scenario**: In a traditional app, if you need to update a user's profile, you'd manually select DOM elements and update them. In React, you change the state, and React automatically re-renders the component with the new data.

---

#### 2. Explain the difference between React and traditional DOM manipulation

**Answer:**

| Aspect | Traditional DOM | React |
|--------|-----------------|-------|
| **Approach** | Imperative (how to do it) | Declarative (what to render) |
| **Updates** | Manual DOM selection and modification | Automatic based on state changes |
| **Performance** | Direct DOM manipulation is slow | Virtual DOM batches updates efficiently |
| **Code Maintainability** | Scattered logic across event handlers | Centralized component logic |
| **Reusability** | Limited code reuse | Component-based reusability |

**Traditional approach:**
```javascript
// Manual DOM manipulation
document.getElementById('counter').textContent = count;
document.getElementById('btn').addEventListener('click', () => {
  count++;
  document.getElementById('counter').textContent = count;
});
```

**React approach:**
```javascript
function Counter() {
  const [count, setCount] = useState(0);
  return (
    <div>
      <p>{count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

React handles the DOM updates automatically. You describe what the UI should look like, and React ensures the DOM matches that description.

---

#### 3. What is JSX and how is it different from HTML?

**Answer:**

JSX (JavaScript XML) is a syntax extension for JavaScript that allows you to write HTML-like code within JavaScript. It's not valid JavaScript—it must be transpiled to JavaScript function calls by Babel.

**Key differences from HTML:**

| Feature | JSX | HTML |
|---------|-----|------|
| **Language** | JavaScript extension | Markup language |
| **Dynamic Values** | Can embed JavaScript expressions | Static content |
| **Attributes** | camelCase (className, onClick) | lowercase (class, onclick) |
| **Closing Tags** | Self-closing tags required | Optional for some tags |
| **Compilation** | Transpiled to React.createElement() | Rendered directly by browser |

**JSX Example:**
```javascript
const name = "Alice";
const element = <h1>Hello, {name}!</h1>;
// Transpiles to: React.createElement('h1', null, 'Hello, ', name, '!');
```

**Key points:**
- JSX is syntactic sugar for `React.createElement()`
- You can embed any JavaScript expression inside `{}`
- JSX is closer to JavaScript than HTML—it's component-oriented, not document-oriented

---

#### 4. Can you use React without JSX?

**Answer:**

Yes, absolutely. JSX is optional. You can write React using `React.createElement()` directly, though it's more verbose.

**Without JSX:**
```javascript
function Greeting() {
  return React.createElement(
    'div',
    null,
    React.createElement('h1', null, 'Hello World'),
    React.createElement('p', null, 'Welcome to React')
  );
}
```

**With JSX (cleaner):**
```javascript
function Greeting() {
  return (
    <div>
      <h1>Hello World</h1>
      <p>Welcome to React</p>
    </div>
  );
}
```

**Why use JSX then?**
- More readable and maintainable
- Closer to HTML, easier for designers to understand
- Less boilerplate code
- Better error messages during development

Most React projects use JSX because it significantly improves code clarity.

---

#### 5. What are the key features of React?

**Answer:**

**1. Component-Based Architecture**
- UI is built from reusable, independent components
- Each component manages its own state and logic
- Components can be composed to build complex UIs

**2. Declarative UI**
- Describe what the UI should look like
- React handles how to update the DOM
- Makes code predictable and easier to debug

**3. Virtual DOM**
- React maintains an in-memory representation of the UI
- Compares new Virtual DOM with previous one (diffing)
- Updates only the changed parts in the real DOM
- Improves performance significantly

**4. Unidirectional Data Flow**
- Data flows from parent to child components via props
- Child components cannot directly modify parent data
- Makes data flow predictable and easier to trace

**5. State Management**
- Components can have local state that triggers re-renders when updated
- State changes are the single source of truth for UI updates

**6. Reusability**
- Components can be reused across the application
- Props allow customization of component behavior
- Reduces code duplication

**7. Developer Tools**
- React DevTools browser extension for debugging
- Hot module reloading for faster development
- Clear error messages and warnings

---

#### 6. Explain the difference between Virtual DOM and Real DOM

**Answer:**

| Aspect | Virtual DOM | Real DOM |
|--------|-------------|----------|
| **Nature** | In-memory JavaScript representation | Actual DOM in the browser |
| **Performance** | Fast (no rendering) | Slow (triggers reflow/repaint) |
| **Updates** | Batched and optimized | Direct and immediate |
| **Manipulation** | Lightweight | Heavy operation |
| **Accessibility** | Not directly accessible | Directly accessible |

**How Virtual DOM works:**

1. **Initial Render**: React creates a Virtual DOM tree representing the UI
2. **State Change**: When state updates, React creates a new Virtual DOM tree
3. **Diffing**: React compares the new Virtual DOM with the previous one
4. **Reconciliation**: React calculates the minimal set of changes needed
5. **Batch Update**: React updates only the changed parts in the real DOM

**Why it matters:**

```javascript
// Without Virtual DOM (traditional approach)
// Each update directly manipulates the real DOM
for (let i = 0; i < 1000; i++) {
  document.body.innerHTML += `<div>${i}</div>`; // 1000 DOM operations!
}

// With React (Virtual DOM)
// React batches updates and applies them once
const items = Array.from({length: 1000}, (_, i) => <div key={i}>{i}</div>);
// React optimizes this to minimal DOM operations
```

**Performance benefit**: Virtual DOM reduces the number of expensive DOM operations, making React applications faster even with frequent updates.

---

#### 7. What is the significance of React.createElement?

**Answer:**

`React.createElement()` is the fundamental function that creates React elements. It's what JSX transpiles to under the hood.

**Signature:**
```javascript
React.createElement(type, props, ...children)
```

**Parameters:**
- `type`: HTML tag name (string) or component (function/class)
- `props`: Object containing attributes and event handlers
- `children`: Content inside the element (can be multiple)

**Significance:**

1. **Foundation of React**: Every React UI is built from elements created by this function
2. **JSX Translation**: JSX syntax is converted to `createElement()` calls during compilation
3. **Programmatic UI Creation**: Allows dynamic UI creation without JSX
4. **Element Objects**: Returns a plain JavaScript object describing what should appear on screen

**Example:**
```javascript
// JSX
<button className="btn" onClick={handleClick}>Click me</button>

// Transpiles to
React.createElement('button', 
  { className: 'btn', onClick: handleClick }, 
  'Click me'
)

// Returns an object like:
{
  type: 'button',
  props: { className: 'btn', onClick: handleClick, children: 'Click me' },
  key: null,
  ref: null
}
```

**Why it matters**: Understanding `createElement()` helps you understand how React works internally and why JSX is just syntactic sugar.

---

#### 8. How does React differ from other frameworks like Angular or Vue?

**Answer:**

| Feature | React | Angular | Vue |
|---------|-------|---------|-----|
| **Type** | Library (View layer) | Full framework | Progressive framework |
| **Learning Curve** | Moderate | Steep | Gentle |
| **Bundle Size** | Small (~40KB) | Large (~500KB) | Small (~35KB) |
| **Language** | JavaScript/JSX | TypeScript (required) | JavaScript/TypeScript |
| **State Management** | Flexible (Redux, Context) | Built-in (RxJS) | Built-in (Vuex/Pinia) |
| **Templating** | JSX (JavaScript) | HTML templates | HTML templates |
| **Performance** | Excellent | Good | Excellent |
| **Community** | Largest | Large | Growing |
| **Use Cases** | SPAs, complex UIs | Enterprise apps | SPAs, small to medium apps |

**React's unique strengths:**
- **Flexibility**: You choose your own tools for routing, state management, etc.
- **JavaScript-first**: JSX keeps you in JavaScript, not a template language
- **Ecosystem**: Largest community and third-party library ecosystem
- **Unidirectional data flow**: Easier to debug and reason about

**React's trade-offs:**
- Requires more decisions (which router? which state manager?)
- Steeper learning curve than Vue
- Less opinionated than Angular

**When to choose React:**
- Large, complex applications
- Need maximum flexibility
- Team is comfortable with JavaScript
- Want access to the largest ecosystem

---

#### 9. What are the advantages and disadvantages of using React?

**Answer:**

**Advantages:**

1. **Reusable Components**
   - Build once, use everywhere
   - Reduces development time and code duplication
   - Easier maintenance and updates

2. **Virtual DOM**
   - Improves application performance
   - Minimizes direct DOM manipulation
   - Batches updates efficiently

3. **Unidirectional Data Flow**
   - Easier to debug (data flows one way)
   - Prevents unexpected side effects
   - Makes code more predictable

4. **Strong Community & Ecosystem**
   - Largest React community among frameworks
   - Abundant libraries and tools
   - Extensive documentation and tutorials

5. **SEO Friendly (with SSR)**
   - Server-side rendering support via Next.js
   - Better search engine indexing

6. **Developer Experience**
   - React DevTools for debugging
   - Hot module reloading
   - Clear error messages

7. **Backed by Facebook**
   - Regular updates and improvements
   - Long-term support and stability

**Disadvantages:**

1. **Steep Learning Curve**
   - JSX syntax can be confusing initially
   - Requires understanding of JavaScript fundamentals
   - Many concepts to learn (hooks, context, etc.)

2. **Boilerplate Code**
   - Requires additional libraries for routing, state management
   - More setup compared to full frameworks like Angular

3. **Rapid Changes**
   - Frequent updates can break existing code
   - Ecosystem tools evolve quickly
   - Requires continuous learning

4. **SEO Challenges (without SSR)**
   - Client-side rendering makes SEO harder
   - Requires additional setup for server-side rendering

5. **Performance Issues (if misused)**
   - Unnecessary re-renders can slow down apps
   - Requires understanding of optimization techniques

6. **Testing Complexity**
   - Testing React components requires additional tools
   - Mocking and setup can be complex

7. **Not a Complete Framework**
   - You need to choose and integrate additional libraries
   - More decisions to make during development

---

#### 10. Explain React's declarative approach vs imperative programming

**Answer:**

**Declarative Programming (React's approach):**
- You describe **what** the UI should look like
- React figures out **how** to achieve it
- Focus on the desired end state
- More readable and maintainable

**Imperative Programming (Traditional approach):**
- You specify **how** to do something step by step
- You manually control each DOM operation
- Focus on the process, not the result
- More verbose and error-prone

**Comparison:**

**Imperative (Traditional DOM):**
```javascript
// Step-by-step instructions
const button = document.createElement('button');
button.textContent = 'Click me';
button.addEventListener('click', () => {
  const count = parseInt(document.getElementById('count').textContent);
  document.getElementById('count').textContent = count + 1;
});
document.body.appendChild(button);
const countDiv = document.createElement('div');
countDiv.id = 'count';
countDiv.textContent = '0';
document.body.appendChild(countDiv);
```

**Declarative (React):**
```javascript
function Counter() {
  const [count, setCount] = useState(0);
  return (
    <div>
      <button onClick={() => setCount(count + 1)}>Click me</button>
      <div>{count}</div>
    </div>
  );
}
```

**Why Declarative is Better:**

1. **Readability**: Code clearly shows what the UI looks like
2. **Maintainability**: Easier to understand and modify
3. **Fewer Bugs**: Less manual state management means fewer mistakes
4. **Scalability**: Easier to build complex UIs
5. **Testability**: Easier to test because you're testing the output, not the process

**Key Insight**: In React, you declare the UI structure and React handles the DOM updates. You don't need to think about "how" to update the DOM—you just describe what it should look like at any given state.

---


---

## 2. Components & Props

#### 1. What is a React component?

A React component is a reusable piece of UI that returns JSX. It's a JavaScript function or class that accepts inputs (props) and returns what should appear on screen.

**Types:**
- **Functional Component**: JavaScript function returning JSX
- **Class Component**: ES6 class extending React.Component

```javascript
// Functional
function Welcome() {
  return <h1>Hello</h1>;
}

// Class
class Welcome extends React.Component {
  render() {
    return <h1>Hello</h1>;
  }
}
```

---

#### 2. Differentiate between functional and class components

| Feature | Functional | Class |
|---------|-----------|-------|
| **Syntax** | JavaScript function | ES6 class |
| **State** | Hooks (useState) | this.state |
| **Lifecycle** | Hooks (useEffect) | Lifecycle methods |
| **Performance** | Slightly faster | Slightly slower |
| **Learning Curve** | Easier | Steeper |
| **Modern Standard** | Preferred now | Legacy |
| **Code Length** | Shorter | Longer |

**Functional (Modern):**
```javascript
function Counter() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(count + 1)}>{count}</button>;
}
```

**Class (Legacy):**
```javascript
class Counter extends React.Component {
  state = { count: 0 };
  render() {
    return (
      <button onClick={() => this.setState({ count: this.state.count + 1 })}>
        {this.state.count}
      </button>
    );
  }
}
```

**Current Best Practice**: Use functional components with hooks. Class components are rarely used in new projects.

---

#### 3. What are props in React?

Props (properties) are read-only data passed from parent to child components. They're how components communicate and customize behavior.

**Characteristics:**
- Immutable (cannot be changed by child)
- Passed from parent to child
- Used to customize component behavior
- Similar to function parameters

```javascript
function Greeting(props) {
  return <h1>Hello, {props.name}!</h1>;
}
```

---

#### 4. How do you pass props to components?

Props are passed as attributes on the component tag.

```javascript
// Passing props
<Greeting name="Alice" age={25} isActive={true} />

// Receiving props
function Greeting({ name, age, isActive }) {
  return <p>{name} is {age} years old</p>;
}

// Or using props object
function Greeting(props) {
  return <p>{props.name} is {props.age} years old</p>;
}
```

**Destructuring** (preferred): Extract props directly in function parameters for cleaner code.

---

#### 5. Can props be modified? Why or why not?

**No, props cannot be modified.** They are read-only.

**Why?**
- **Unidirectional Data Flow**: Data flows one way (parent → child), preventing chaos
- **Predictability**: Child components can't unexpectedly change parent data
- **Debugging**: Easier to trace where data changes come from
- **React Philosophy**: Components should be pure functions

**What to do instead:**
- If child needs to update data, call a callback function passed via props
- Use state management for complex data changes

```javascript
// Parent
function Parent() {
  const [count, setCount] = useState(0);
  return <Child count={count} onIncrement={() => setCount(count + 1)} />;
}

// Child - cannot modify count directly, but can call callback
function Child({ count, onIncrement }) {
  return <button onClick={onIncrement}>{count}</button>;
}
```

---

#### 6. What is prop drilling and how can you avoid it?

**Prop Drilling**: Passing props through multiple intermediate components that don't use them, just to reach a deeply nested component.

**Problem:**
```javascript
// Props passed through multiple levels
<GrandParent data={data} />
  → <Parent data={data} />
    → <Child data={data} />
      → <GrandChild data={data} /> // Finally uses it
```

**Solutions:**

1. **Context API** (built-in):
```javascript
const DataContext = React.createContext();

function GrandParent() {
  return (
    <DataContext.Provider value={data}>
      <Parent />
    </DataContext.Provider>
  );
}

function GrandChild() {
  const data = useContext(DataContext);
  return <div>{data}</div>;
}
```

2. **State Management Libraries** (Redux, Zustand, Recoil)
3. **Component Composition**: Restructure components to reduce nesting

---

#### 7. How do you set default props?

**Using defaultProps:**
```javascript
function Greeting({ name = "Guest", age = 18 }) {
  return <p>{name} is {age}</p>;
}

// Or using defaultProps object
Greeting.defaultProps = {
  name: "Guest",
  age: 18
};
```

**Best Practice**: Use destructuring with default values (cleaner and more modern).

---

#### 8. What is propTypes and how is it used?

**PropTypes** is a library for type-checking props at runtime. It validates that props match expected types.

```javascript
import PropTypes from 'prop-types';

function User({ name, age, email }) {
  return <div>{name}, {age}, {email}</div>;
}

User.propTypes = {
  name: PropTypes.string.isRequired,
  age: PropTypes.number,
  email: PropTypes.string.isRequired
};
```

**Common PropTypes:**
- `PropTypes.string`, `PropTypes.number`, `PropTypes.bool`
- `PropTypes.array`, `PropTypes.object`
- `PropTypes.func`, `PropTypes.node`
- `PropTypes.oneOf(['value1', 'value2'])`
- `PropTypes.isRequired` - prop must be provided

**Note**: PropTypes only works in development. Use TypeScript for production type safety.

---

#### 9. How do you pass children to a component?

**Children** are content placed between opening and closing component tags, accessed via `props.children`.

```javascript
// Using children
<Card>
  <h1>Title</h1>
  <p>Content</p>
</Card>

// Receiving children
function Card({ children }) {
  return <div className="card">{children}</div>;
}

// Multiple children
function Layout({ header, sidebar, main }) {
  return (
    <div>
      <header>{header}</header>
      <aside>{sidebar}</aside>
      <main>{main}</main>
    </div>
  );
}

<Layout 
  header={<Header />} 
  sidebar={<Sidebar />} 
  main={<Main />} 
/>
```

---

#### 10. What is the difference between props and state?

| Feature | Props | State |
|---------|-------|-------|
| **Source** | Passed from parent | Defined in component |
| **Mutability** | Immutable (read-only) | Mutable (can change) |
| **Triggers Re-render** | Yes | Yes |
| **Scope** | Parent to child | Local to component |
| **Default Values** | defaultProps | useState/constructor |
| **Use Case** | Pass data down | Store component data |

**Simple Rule**: Props are like function parameters, state is like local variables.

```javascript
function Counter({ initialValue = 0 }) { // initialValue is prop
  const [count, setCount] = useState(initialValue); // count is state
  
  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

---

## 3. State & Lifecycle

#### 1. What is state in React?

State is data that changes over time and triggers re-renders when updated. It's the component's internal data that determines what's displayed.

**Characteristics:**
- Mutable (can be changed)
- Local to component
- Triggers re-render when updated
- Initialized with default value
- Should not be modified directly

**State vs Props:**
- State: Internal, mutable, triggers re-render
- Props: External, immutable, passed from parent

---

#### 2. How do you update state correctly?

**Never mutate state directly.** Always create a new value.

**Wrong:**
```javascript
// DON'T do this
this.state.count = 5; // Direct mutation
state.array.push(item); // Mutating array
```

**Correct:**
```javascript
// Functional component
const [count, setCount] = useState(0);
setCount(count + 1); // Create new value

// Class component
this.setState({ count: this.state.count + 1 });

// For objects/arrays, create new references
setUser({ ...user, name: 'Alice' }); // Spread operator
setItems([...items, newItem]); // New array
```

**Why?** React compares old and new state by reference. Direct mutations prevent React from detecting changes.

---

#### 3. What is the difference between setState and useState?

| Feature | setState (Class) | useState (Hooks) |
|---------|-----------------|-----------------|
| **Component Type** | Class components | Functional components |
| **Syntax** | `this.setState({})` | `const [state, setState] = useState()` |
| **Batching** | Batches updates | Batches updates (React 18+) |
| **Merging** | Merges with existing state | Replaces entire state |
| **Async** | Asynchronous | Asynchronous |
| **Callback** | Accepts callback | Use useEffect for side effects |

**setState (Class):**
```javascript
this.setState({ count: 5 }, () => {
  console.log('State updated'); // Callback after update
});
```

**useState (Hooks):**
```javascript
const [count, setCount] = useState(0);
setCount(5);
// Use useEffect for side effects after state update
useEffect(() => {
  console.log('State updated');
}, [count]);
```

**Key Difference**: `setState` merges updates, `useState` replaces the entire state value.

---

#### 4. Explain the component lifecycle in class components

**Three phases:**

**1. Mounting** (component being created and inserted into DOM)
- `constructor()` → `getDerivedStateFromProps()` → `render()` → `componentDidMount()`

**2. Updating** (component being re-rendered due to props or state changes)
- `getDerivedStateFromProps()` → `shouldComponentUpdate()` → `render()` → `getSnapshotBeforeUpdate()` → `componentDidUpdate()`

**3. Unmounting** (component being removed from DOM)
- `componentWillUnmount()`

**Error Handling:**
- `componentDidCatch()` - Catches errors in child components

**Visual Flow:**
```
Mounting:
constructor → getDerivedStateFromProps → render → componentDidMount

Updating:
getDerivedStateFromProps → shouldComponentUpdate → render → getSnapshotBeforeUpdate → componentDidUpdate

Unmounting:
componentWillUnmount
```

---

#### 5. What are lifecycle methods and when are they used?

Lifecycle methods are special methods called at specific points in a component's life.

| Method | Phase | Use Case |
|--------|-------|----------|
| **constructor** | Mounting | Initialize state, bind methods |
| **getDerivedStateFromProps** | Mounting/Updating | Sync state with props |
| **render** | Mounting/Updating | Return JSX |
| **componentDidMount** | Mounting | Fetch data, setup subscriptions |
| **shouldComponentUpdate** | Updating | Optimize performance |
| **getSnapshotBeforeUpdate** | Updating | Capture DOM info before update |
| **componentDidUpdate** | Updating | React to updates, fetch data |
| **componentWillUnmount** | Unmounting | Cleanup, cancel subscriptions |
| **componentDidCatch** | Error | Handle errors in children |

---

#### 6. What is the significance of componentDidMount?

**componentDidMount** is called once after the component renders for the first time. It's the best place for initial setup.

**Significance:**
- Runs only once (perfect for initialization)
- DOM is ready (can access refs)
- Safe to make API calls
- Can update state without causing infinite loops

**Common uses:**
```javascript
componentDidMount() {
  // Fetch data
  fetch('/api/data').then(res => res.json()).then(data => {
    this.setState({ data });
  });
  
  // Setup subscriptions
  this.subscription = subscribe(this.handleUpdate);
  
  // Setup timers
  this.timer = setInterval(() => this.tick(), 1000);
  
  // Access DOM refs
  this.inputRef.focus();
}
```

**Functional equivalent:**
```javascript
useEffect(() => {
  // All the above code
}, []); // Empty dependency array = runs once on mount
```

---

#### 7. What is componentDidUpdate and how is it different from componentDidMount?

**componentDidUpdate** is called after every update (state or props change). It runs multiple times.

| Feature | componentDidMount | componentDidUpdate |
|---------|------------------|-------------------|
| **Frequency** | Once | Multiple times |
| **When** | After initial render | After every update |
| **Parameters** | None | prevProps, prevState, snapshot |
| **Use Case** | Initial setup | React to changes |
| **Infinite Loop Risk** | No | Yes (if not careful) |

**componentDidUpdate:**
```javascript
componentDidUpdate(prevProps, prevState, snapshot) {
  // React to prop changes
  if (prevProps.userId !== this.props.userId) {
    this.fetchUserData(this.props.userId);
  }
  
  // React to state changes
  if (prevState.count !== this.state.count) {
    console.log('Count changed to:', this.state.count);
  }
}
```

**Functional equivalent:**
```javascript
useEffect(() => {
  // Runs after every render
  console.log('Component updated');
}, []); // No dependency array

useEffect(() => {
  // Runs when userId changes
  fetchUserData(userId);
}, [userId]); // Dependency array
```

**Warning**: Without proper conditions, componentDidUpdate can cause infinite loops.

---

#### 8. What is componentWillUnmount and why is it important?

**componentWillUnmount** is called just before the component is removed from the DOM. It's the cleanup phase.

**Importance:**
- Prevents memory leaks
- Cancels pending requests
- Removes event listeners
- Clears timers and subscriptions

**Common cleanup tasks:**
```javascript
componentWillUnmount() {
  // Cancel API requests
  this.abortController.abort();
  
  // Remove subscriptions
  this.subscription.unsubscribe();
  
  // Clear timers
  clearInterval(this.timer);
  clearTimeout(this.timeout);
  
  // Remove event listeners
  window.removeEventListener('resize', this.handleResize);
  
  // Cleanup refs
  this.ref = null;
}
```

**Functional equivalent:**
```javascript
useEffect(() => {
  // Setup
  const subscription = subscribe();
  
  // Cleanup function (runs on unmount)
  return () => {
    subscription.unsubscribe();
  };
}, []);
```

**Why important?** Without cleanup, components can cause memory leaks, especially in SPAs where components mount/unmount frequently.

---

#### 9. Explain the getDerivedStateFromProps lifecycle method

**getDerivedStateFromProps** is a static method that syncs state with props. It runs before render during both mounting and updating.

**Characteristics:**
- Static method (no access to `this`)
- Returns new state or null
- Runs before render
- Rarely needed (usually use props directly)

**When to use:**
- When state depends on props
- When props change and state needs to update

**Example:**
```javascript
class EmailInput extends React.Component {
  state = { email: '' };
  
  static getDerivedStateFromProps(props, state) {
    // If email prop changes, update state
    if (props.email !== state.email) {
      return { email: props.email };
    }
    return null; // No state update needed
  }
  
  render() {
    return <input value={this.state.email} />;
  }
}
```

**Better alternative (modern approach):**
```javascript
function EmailInput({ email }) {
  const [value, setValue] = useState(email);
  
  useEffect(() => {
    setValue(email);
  }, [email]);
  
  return <input value={value} onChange={e => setValue(e.target.value)} />;
}
```

**Note**: Most use cases can be solved without getDerivedStateFromProps. Use it sparingly.

---

#### 10. What is the getSnapshotBeforeUpdate method?

**getSnapshotBeforeUpdate** is called right before DOM changes are applied. It captures information about the DOM before it updates.

**Characteristics:**
- Runs after render but before DOM update
- Returns a snapshot value
- Receives prevProps and prevState
- Snapshot is passed to componentDidUpdate

**Use case:** Capture scroll position before list updates.

**Example:**
```javascript
class ScrollingList extends React.Component {
  constructor(props) {
    super(props);
    this.listRef = React.createRef();
  }
  
  getSnapshotBeforeUpdate(prevProps, prevState) {
    // Capture scroll position before update
    if (prevProps.list.length < this.props.list.length) {
      return this.listRef.current.scrollHeight;
    }
    return null;
  }
  
  componentDidUpdate(prevProps, prevState, snapshot) {
    // Use snapshot to restore scroll position
    if (snapshot !== null) {
      this.listRef.current.scrollTop = 
        this.listRef.current.scrollHeight - snapshot;
    }
  }
  
  render() {
    return <div ref={this.listRef}>{/* list items */}</div>;
  }
}
```

**When to use:**
- Preserve scroll position during updates
- Capture DOM measurements before changes
- Maintain focus during re-renders

**Note**: Rarely used. Most cases can be solved with other approaches.

---

#### 11. How does state behave in functional vs class components?

| Aspect | Functional (Hooks) | Class Components |
|--------|-------------------|-----------------|
| **State Declaration** | `useState()` | `this.state = {}` |
| **State Update** | `setState()` function | `this.setState()` |
| **Multiple States** | Multiple `useState()` calls | Single state object |
| **State Merging** | Replaces entire state | Merges with existing state |
| **Closure** | Each render has its own state | Shared state reference |
| **Performance** | Slightly faster | Slightly slower |
| **Side Effects** | `useEffect()` | Lifecycle methods |

**Functional (Modern):**
```javascript
function Counter() {
  const [count, setCount] = useState(0);
  const [name, setName] = useState('');
  
  return (
    <div>
      <p>{count} - {name}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

**Class (Legacy):**
```javascript
class Counter extends React.Component {
  state = { count: 0, name: '' };
  
  render() {
    return (
      <div>
        <p>{this.state.count} - {this.state.name}</p>
        <button onClick={() => this.setState({ count: this.state.count + 1 })}>
          Increment
        </button>
      </div>
    );
  }
}
```

**Key Difference**: Functional components with hooks are the modern standard. Class components are legacy but still work.

---


---

## 4. Event Handling

#### 1. How are events handled in React?

Events in React are handled by attaching event handlers to JSX elements using camelCase event names.

**Basic syntax:**
```javascript
function Button() {
  const handleClick = () => console.log('Clicked');
  return <button onClick={handleClick}>Click me</button>;
}
```

**With inline handler:**
```javascript
<button onClick={() => console.log('Clicked')}>Click me</button>
```

**Common events:**
- Mouse: `onClick`, `onMouseEnter`, `onMouseLeave`, `onMouseOver`
- Keyboard: `onKeyDown`, `onKeyUp`, `onChange`
- Form: `onSubmit`, `onFocus`, `onBlur`
- Touch: `onTouchStart`, `onTouchEnd`

---

#### 2. What's the difference between handling events in React vs DOM?

| Feature | React | DOM |
|---------|-------|-----|
| **Syntax** | camelCase (onClick) | lowercase (onclick) |
| **Handler Type** | Function reference | String or function |
| **Event Object** | Synthetic event | Native event |
| **Binding** | Auto-bound in arrow functions | Manual binding needed |
| **Performance** | Event delegation | Direct attachment |

**DOM (Traditional):**
```javascript
// HTML
<button onclick="handleClick()">Click</button>

// JavaScript
function handleClick() {
  console.log('Clicked');
}
```

**React:**
```javascript
function Button() {
  const handleClick = () => console.log('Clicked');
  return <button onClick={handleClick}>Click</button>;
}
```

**Key differences:**
- React uses camelCase event names
- React passes function references, not strings
- React uses synthetic events (wrapped native events)
- React uses event delegation for better performance

---

#### 3. How do you pass arguments to event handlers?

**Method 1: Arrow function (recommended)**
```javascript
function List() {
  const handleDelete = (id) => console.log('Delete:', id);
  
  return (
    <button onClick={() => handleDelete(123)}>Delete</button>
  );
}
```

**Method 2: Bind in constructor (class components)**
```javascript
class List extends React.Component {
  handleDelete(id) {
    console.log('Delete:', id);
  }
  
  render() {
    return (
      <button onClick={() => this.handleDelete(123)}>Delete</button>
    );
  }
}
```

**Method 3: Partial application**
```javascript
const handleDelete = (id) => () => console.log('Delete:', id);
return <button onClick={handleDelete(123)}>Delete</button>;
```

**Best practice:** Use arrow functions for simplicity and clarity.

---

#### 4. What is event pooling in React?

Event pooling is an optimization where React reuses synthetic event objects to improve performance. After the event callback, the event object is reset and returned to the pool.

**Important:** Event pooling was removed in React 17+. This is mostly historical knowledge.

**Pre-React 17 issue:**
```javascript
function Form() {
  const handleChange = (e) => {
    setTimeout(() => {
      console.log(e.target.value); // null - event was pooled
    }, 0);
  };
  
  return <input onChange={handleChange} />;
}
```

**Solution (if needed):**
```javascript
const handleChange = (e) => {
  const value = e.target.value; // Capture immediately
  setTimeout(() => {
    console.log(value); // Works
  }, 0);
};
```

**Modern React (17+):** Event pooling is gone, so this is no longer an issue.

---

#### 5. How do you prevent default behavior in React events?

Use `e.preventDefault()` on the synthetic event object.

**Prevent form submission:**
```javascript
function Form() {
  const handleSubmit = (e) => {
    e.preventDefault(); // Prevent page reload
    console.log('Form submitted');
  };
  
  return <form onSubmit={handleSubmit}><button>Submit</button></form>;
}
```

**Prevent link navigation:**
```javascript
function Link() {
  const handleClick = (e) => {
    e.preventDefault(); // Prevent navigation
    console.log('Link clicked');
  };
  
  return <a href="/page" onClick={handleClick}>Click</a>;
}
```

**Prevent context menu:**
```javascript
const handleContextMenu = (e) => {
  e.preventDefault();
  console.log('Right-clicked');
};

return <div onContextMenu={handleContextMenu}>Right-click me</div>;
```

---

#### 6. What is synthetic event in React?

Synthetic events are React's cross-browser wrapper around the browser's native event. They have the same interface as native events but work consistently across all browsers.

**Characteristics:**
- Pooled for performance (React 16 and earlier)
- Consistent API across browsers
- Wraps native event in `e.nativeEvent`
- Automatically bound to component instance

**Accessing native event:**
```javascript
function Input() {
  const handleChange = (e) => {
    console.log(e); // Synthetic event
    console.log(e.nativeEvent); // Native event
    console.log(e.target.value); // Works on both
  };
  
  return <input onChange={handleChange} />;
}
```

**Why synthetic events?**
- Consistent behavior across browsers
- Better performance through event delegation
- Automatic cleanup and pooling (React 16)

---

#### 7. How do you bind event handlers in class components?

**Method 1: Arrow function in class field (recommended)**
```javascript
class Button extends React.Component {
  handleClick = () => {
    console.log('Clicked');
  };
  
  render() {
    return <button onClick={this.handleClick}>Click</button>;
  }
}
```

**Method 2: Bind in constructor**
```javascript
class Button extends React.Component {
  constructor(props) {
    super(props);
    this.handleClick = this.handleClick.bind(this);
  }
  
  handleClick() {
    console.log('Clicked');
  }
  
  render() {
    return <button onClick={this.handleClick}>Click</button>;
  }
}
```

**Method 3: Arrow function in JSX (not recommended)**
```javascript
class Button extends React.Component {
  handleClick() {
    console.log('Clicked');
  }
  
  render() {
    return <button onClick={() => this.handleClick()}>Click</button>;
  }
}
```

**Best practice:** Use arrow function class fields (Method 1) for cleaner code.

---

## 5. Conditional Rendering

#### 1. How many ways can you implement conditional rendering?

**5 main approaches:**

1. **If/else statement**
2. **Ternary operator**
3. **Logical AND (&&) operator**
4. **Switch statement**
5. **Conditional component**

---

#### 2. What are the common patterns for conditional rendering?

**Pattern 1: If/else (outside JSX)**
```javascript
function Greeting({ isLoggedIn }) {
  if (isLoggedIn) {
    return <h1>Welcome back!</h1>;
  }
  return <h1>Please log in</h1>;
}
```

**Pattern 2: Ternary operator**
```javascript
function Greeting({ isLoggedIn }) {
  return isLoggedIn ? <h1>Welcome!</h1> : <h1>Log in</h1>;
}
```

**Pattern 3: Logical AND (&&)**
```javascript
function Notification({ hasMessages }) {
  return (
    <div>
      {hasMessages && <p>You have new messages</p>}
    </div>
  );
}
```

**Pattern 4: Switch statement**
```javascript
function Status({ status }) {
  switch(status) {
    case 'loading':
      return <p>Loading...</p>;
    case 'error':
      return <p>Error occurred</p>;
    case 'success':
      return <p>Success!</p>;
    default:
      return null;
  }
}
```

**Pattern 5: Conditional component**
```javascript
const If = ({ condition, children }) => condition ? children : null;

function App() {
  return <If condition={isLoggedIn}><Dashboard /></If>;
}
```

---

#### 3. What is short-circuit evaluation in conditional rendering?

Short-circuit evaluation uses logical operators to conditionally render elements.

**Logical AND (&&):**
```javascript
// Only renders if condition is true
{isLoggedIn && <Dashboard />}

// Falsy values (0, '', false, null, undefined) won't render
{count && <p>Count: {count}</p>} // Won't render if count is 0
```

**Logical OR (||):**
```javascript
// Renders first truthy value
{user?.name || 'Guest'}

// Renders fallback if value is falsy
{data || <p>No data available</p>}
```

**Important caveat:**
```javascript
// WRONG - renders 0 if count is 0
{count && <p>Items: {count}</p>}

// CORRECT - check explicitly
{count > 0 && <p>Items: {count}</p>}
```

---

#### 4. How do you conditionally render components?

**Render different components based on condition:**
```javascript
function Dashboard({ userRole }) {
  if (userRole === 'admin') {
    return <AdminPanel />;
  }
  if (userRole === 'user') {
    return <UserPanel />;
  }
  return <GuestPanel />;
}
```

**Using ternary:**
```javascript
function Dashboard({ userRole }) {
  return userRole === 'admin' ? <AdminPanel /> : <UserPanel />;
}
```

**Using object map:**
```javascript
function Dashboard({ userRole }) {
  const components = {
    admin: <AdminPanel />,
    user: <UserPanel />,
    guest: <GuestPanel />
  };
  
  return components[userRole] || <GuestPanel />;
}
```

**Using switch:**
```javascript
function Dashboard({ userRole }) {
  switch(userRole) {
    case 'admin':
      return <AdminPanel />;
    case 'user':
      return <UserPanel />;
    default:
      return <GuestPanel />;
  }
}
```

---

## 6. Lists & Keys

#### 1. How do you render lists in React?

Use the `map()` function to transform an array into JSX elements.

**Basic list:**
```javascript
function TodoList({ todos }) {
  return (
    <ul>
      {todos.map((todo) => (
        <li key={todo.id}>{todo.text}</li>
      ))}
    </ul>
  );
}
```

**With index (not recommended as key):**
```javascript
function List({ items }) {
  return (
    <ul>
      {items.map((item, index) => (
        <li key={index}>{item}</li>
      ))}
    </ul>
  );
}
```

**Nested lists:**
```javascript
function Categories({ categories }) {
  return (
    <div>
      {categories.map((category) => (
        <div key={category.id}>
          <h3>{category.name}</h3>
          <ul>
            {category.items.map((item) => (
              <li key={item.id}>{item.name}</li>
            ))}
          </ul>
        </div>
      ))}
    </div>
  );
}
```

---

#### 2. What is the purpose of keys in lists?

Keys help React identify which items have changed, been added, or removed. They improve performance and maintain component state correctly.

**Purposes:**
- **Identify elements**: React uses keys to match old elements with new ones
- **Maintain state**: Preserves component state during re-renders
- **Optimize performance**: Prevents unnecessary re-renders
- **Preserve focus**: Maintains focus on correct input elements

**Without keys (problematic):**
```javascript
// If list reorders, component state gets mixed up
{items.map((item) => <Item item={item} />)} // No key!
```

**With keys (correct):**
```javascript
// React correctly tracks each item
{items.map((item) => <Item key={item.id} item={item} />)}
```

---

#### 3. What happens if you don't provide keys?

**Problems:**
1. **State gets mixed up**: Component state doesn't follow the correct item
2. **Performance issues**: React re-renders more than necessary
3. **Input focus lost**: Focus moves to wrong input during re-renders
4. **Animation bugs**: Animations may not work correctly

**Example of the problem:**
```javascript
// Without keys
function List({ items }) {
  return (
    <ul>
      {items.map((item, index) => (
        <li key={index}> {/* BAD - using index as key */}
          <input defaultValue={item.name} />
        </li>
      ))}
    </ul>
  );
}

// If items reorder, input values get mixed up!
// Item 1's input might show Item 2's value
```

**With proper keys:**
```javascript
{items.map((item) => (
  <li key={item.id}> {/* GOOD - unique, stable key */}
    <input defaultValue={item.name} />
  </li>
))}
```

---

#### 4. What should you use as a key and why?

**Best: Unique, stable identifier**
```javascript
// BEST - unique ID from data
{items.map((item) => <Item key={item.id} item={item} />)}
```

**Acceptable: UUID or generated ID**
```javascript
// GOOD - if no ID, generate one
{items.map((item) => <Item key={item.uuid} item={item} />)}
```

**Avoid: Index as key**
```javascript
// BAD - index changes when list reorders
{items.map((item, index) => <Item key={index} item={item} />)}
```

**Avoid: Random keys**
```javascript
// BAD - new key every render
{items.map((item) => <Item key={Math.random()} item={item} />)}
```

**Why use stable IDs?**
- Survives list reordering
- Maintains component state correctly
- Improves performance
- Prevents bugs with controlled inputs

---

#### 5. Can indexes be used as keys? When and why not?

**Short answer:** Avoid using indexes as keys in most cases.

**When indexes are acceptable:**
- List is static (no reordering, filtering, or adding/removing)
- List has no IDs
- List is never filtered or reordered

**Example (acceptable):**
```javascript
// Static list - OK to use index
const staticList = ['Apple', 'Banana', 'Orange'];
{staticList.map((item, index) => <li key={index}>{item}</li>)}
```

**When indexes are problematic:**
- List can be reordered
- Items can be added/removed
- List can be filtered
- Items have state (inputs, selections)

**Example (problematic):**
```javascript
// Dynamic list - DON'T use index
const [todos, setTodos] = useState([
  { id: 1, text: 'Learn React' },
  { id: 2, text: 'Build app' }
]);

// If user reorders todos, index keys break!
{todos.map((todo, index) => (
  <li key={index}> {/* BAD */}
    <input value={todo.text} />
  </li>
))}

// CORRECT
{todos.map((todo) => (
  <li key={todo.id}> {/* GOOD */}
    <input value={todo.text} />
  </li>
))}
```

**Why indexes fail:**
- When list reorders, index 0 now points to different item
- Component state (input value, selection) follows the index, not the item
- React can't tell if item was removed or just moved

**Best practice:** Always use a unique, stable identifier from your data.

---


---

## 7. Forms & Controlled Components

#### 1. What are controlled components?

Controlled components are form elements whose value is controlled by React state. The component's value is always in sync with state.

**Characteristics:**
- Value comes from state
- onChange handler updates state
- React is the "single source of truth"
- Predictable and easy to debug

**Example:**
```javascript
function Form() {
  const [name, setName] = useState('');
  
  return (
    <input 
      value={name} 
      onChange={(e) => setName(e.target.value)} 
    />
  );
}
```

**Why use controlled components?**
- Easy to validate input in real-time
- Can disable submit button based on state
- Can manipulate input value programmatically
- Easier to test

---

#### 2. What are uncontrolled components?

Uncontrolled components manage their own state internally. React doesn't control the value—the DOM does.

**Characteristics:**
- Value stored in DOM, not state
- Access value using refs
- React is not the "single source of truth"
- Similar to traditional HTML forms

**Example:**
```javascript
function Form() {
  const inputRef = useRef(null);
  
  const handleSubmit = () => {
    console.log(inputRef.current.value); // Get value from DOM
  };
  
  return (
    <>
      <input ref={inputRef} defaultValue="Initial" />
      <button onClick={handleSubmit}>Submit</button>
    </>
  );
}
```

**When to use uncontrolled components:**
- Simple forms with minimal validation
- Integrating with non-React code
- File inputs (always uncontrolled)

**Controlled vs Uncontrolled:**

| Feature | Controlled | Uncontrolled |
|---------|-----------|--------------|
| **State** | React state | DOM |
| **Value Access** | Via state | Via refs |
| **Validation** | Real-time | On submit |
| **Testing** | Easier | Harder |
| **Use Case** | Complex forms | Simple forms |

---

#### 3. How do you handle form submissions in React?

**Prevent default and handle submission:**
```javascript
function Form() {
  const [formData, setFormData] = useState({ name: '', email: '' });
  
  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };
  
  const handleSubmit = (e) => {
    e.preventDefault(); // Prevent page reload
    console.log('Form submitted:', formData);
    // Send to server
  };
  
  return (
    <form onSubmit={handleSubmit}>
      <input name="name" value={formData.name} onChange={handleChange} />
      <input name="email" value={formData.email} onChange={handleChange} />
      <button type="submit">Submit</button>
    </form>
  );
}
```

**Key points:**
- Always call `e.preventDefault()` to prevent page reload
- Use `onSubmit` on form, not `onClick` on button
- Access form data from state

---

#### 4. What are the different form elements and how are they handled?

**Text Input:**
```javascript
<input 
  type="text" 
  value={value} 
  onChange={(e) => setValue(e.target.value)} 
/>
```

**Textarea:**
```javascript
<textarea 
  value={value} 
  onChange={(e) => setValue(e.target.value)} 
/>
```

**Select:**
```javascript
<select value={selected} onChange={(e) => setSelected(e.target.value)}>
  <option value="option1">Option 1</option>
  <option value="option2">Option 2</option>
</select>
```

**Checkbox:**
```javascript
<input 
  type="checkbox" 
  checked={isChecked} 
  onChange={(e) => setIsChecked(e.target.checked)} 
/>
```

**Radio Button:**
```javascript
<input 
  type="radio" 
  value="option1" 
  checked={selected === 'option1'} 
  onChange={(e) => setSelected(e.target.value)} 
/>
```

**File Input (uncontrolled):**
```javascript
const fileRef = useRef(null);
<input type="file" ref={fileRef} />
// Access: fileRef.current.files[0]
```

---

#### 5. How do you handle multiple form inputs?

**Using single state object:**
```javascript
function Form() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    message: '',
    subscribe: false
  });
  
  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value
    }));
  };
  
  return (
    <form>
      <input name="name" value={formData.name} onChange={handleChange} />
      <input name="email" value={formData.email} onChange={handleChange} />
      <textarea name="message" value={formData.message} onChange={handleChange} />
      <input 
        type="checkbox" 
        name="subscribe" 
        checked={formData.subscribe} 
        onChange={handleChange} 
      />
    </form>
  );
}
```

**Using useReducer for complex forms:**
```javascript
const initialState = { name: '', email: '', message: '' };

function reducer(state, action) {
  return { ...state, [action.name]: action.value };
}

function Form() {
  const [formData, dispatch] = useReducer(reducer, initialState);
  
  const handleChange = (e) => {
    dispatch({ name: e.target.name, value: e.target.value });
  };
  
  return (
    <form>
      <input name="name" value={formData.name} onChange={handleChange} />
      <input name="email" value={formData.email} onChange={handleChange} />
    </form>
  );
}
```

---

#### 6. What is form validation in React?

Form validation checks if user input meets requirements before submission.

**Real-time validation:**
```javascript
function Form() {
  const [email, setEmail] = useState('');
  const [error, setError] = useState('');
  
  const handleChange = (e) => {
    const value = e.target.value;
    setEmail(value);
    
    // Validate email format
    if (value && !value.includes('@')) {
      setError('Invalid email');
    } else {
      setError('');
    }
  };
  
  return (
    <>
      <input value={email} onChange={handleChange} />
      {error && <p style={{ color: 'red' }}>{error}</p>}
    </>
  );
}
```

**On submit validation:**
```javascript
function Form() {
  const [formData, setFormData] = useState({ name: '', email: '' });
  const [errors, setErrors] = useState({});
  
  const validate = () => {
    const newErrors = {};
    if (!formData.name) newErrors.name = 'Name is required';
    if (!formData.email) newErrors.email = 'Email is required';
    return newErrors;
  };
  
  const handleSubmit = (e) => {
    e.preventDefault();
    const newErrors = validate();
    if (Object.keys(newErrors).length === 0) {
      console.log('Form valid, submit');
    } else {
      setErrors(newErrors);
    }
  };
  
  return (
    <form onSubmit={handleSubmit}>
      <input value={formData.name} onChange={(e) => setFormData({...formData, name: e.target.value})} />
      {errors.name && <p>{errors.name}</p>}
      <button type="submit">Submit</button>
    </form>
  );
}
```

**Using validation libraries (Formik, React Hook Form):**
- Simplify complex form validation
- Reduce boilerplate code
- Handle error messages automatically

---

## 8. Composition vs Inheritance

#### 1. What is composition in React?

Composition is building complex components by combining simpler components. It's the practice of assembling components together to create new functionality.

**Example:**
```javascript
function Card({ header, body, footer }) {
  return (
    <div className="card">
      <div className="header">{header}</div>
      <div className="body">{body}</div>
      <div className="footer">{footer}</div>
    </div>
  );
}

// Using composition
<Card 
  header={<h1>Title</h1>}
  body={<p>Content</p>}
  footer={<button>Action</button>}
/>
```

**Benefits:**
- Flexible and reusable
- Easy to understand
- Avoids deep inheritance hierarchies
- Easier to test

---

#### 2. How does React recommend using composition over inheritance?

React strongly recommends composition over inheritance. Most use cases can be solved with composition.

**Why composition over inheritance?**
- Simpler and more flexible
- Avoids fragile base class problem
- Easier to reason about
- Better code reuse

**Inheritance (not recommended):**
```javascript
class Button extends Component {
  render() {
    return <button>{this.props.children}</button>;
  }
}

class PrimaryButton extends Button {
  render() {
    return <button className="primary">{this.props.children}</button>;
  }
}
```

**Composition (recommended):**
```javascript
function Button({ variant, children }) {
  return <button className={variant}>{children}</button>;
}

// Use composition
<Button variant="primary">Click me</Button>
```

---

#### 3. What are the different composition patterns?

**Pattern 1: Component Composition**
```javascript
function Layout({ sidebar, main }) {
  return (
    <div className="layout">
      <aside>{sidebar}</aside>
      <main>{main}</main>
    </div>
  );
}

<Layout sidebar={<Sidebar />} main={<Content />} />
```

**Pattern 2: Children Composition**
```javascript
function Card({ children }) {
  return <div className="card">{children}</div>;
}

<Card>
  <h1>Title</h1>
  <p>Content</p>
</Card>
```

**Pattern 3: Higher-Order Components (HOC)**
```javascript
function withTheme(Component) {
  return (props) => (
    <ThemeProvider>
      <Component {...props} />
    </ThemeProvider>
  );
}

const ThemedButton = withTheme(Button);
```

**Pattern 4: Render Props**
```javascript
function DataProvider({ render }) {
  const [data, setData] = useState(null);
  return render(data);
}

<DataProvider render={(data) => <div>{data}</div>} />
```

---

#### 4. How do you achieve code reuse in React?

**Method 1: Custom Hooks**
```javascript
function useFormInput(initialValue) {
  const [value, setValue] = useState(initialValue);
  return {
    value,
    onChange: (e) => setValue(e.target.value)
  };
}

function Form() {
  const name = useFormInput('');
  const email = useFormInput('');
  
  return (
    <>
      <input {...name} />
      <input {...email} />
    </>
  );
}
```

**Method 2: Component Composition**
```javascript
function Button({ variant, size, children }) {
  return <button className={`btn btn-${variant} btn-${size}`}>{children}</button>;
}

// Reuse with different props
<Button variant="primary" size="lg">Large Primary</Button>
<Button variant="secondary" size="sm">Small Secondary</Button>
```

**Method 3: Utility Functions**
```javascript
const formatDate = (date) => new Date(date).toLocaleDateString();

function UserCard({ user }) {
  return <div>{formatDate(user.createdAt)}</div>;
}
```

---

## 9. Context API

#### 1. What is Context API and when should you use it?

Context API is a way to pass data through the component tree without manually passing props at every level (prop drilling).

**When to use:**
- Theme switching (light/dark mode)
- User authentication state
- Language/localization
- Global UI state
- Avoiding prop drilling

**When NOT to use:**
- Frequently changing data (performance issues)
- Complex state logic (use Redux instead)
- Simple prop passing (just use props)

---

#### 2. What are Provider and Consumer in Context?

**Provider:** Component that provides the context value to all descendants.

**Consumer:** Component that consumes the context value.

```javascript
const ThemeContext = React.createContext();

// Provider
function App() {
  const [theme, setTheme] = useState('light');
  
  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      <Header />
      <Main />
    </ThemeContext.Provider>
  );
}

// Consumer (class component)
class Button extends React.Component {
  render() {
    return (
      <ThemeContext.Consumer>
        {({ theme }) => (
          <button className={theme}>Click me</button>
        )}
      </ThemeContext.Consumer>
    );
  }
}

// Consumer (functional component with hook)
function Button() {
  const { theme } = useContext(ThemeContext);
  return <button className={theme}>Click me</button>;
}
```

---

#### 3. How do you create and use Context?

**Step 1: Create context**
```javascript
const UserContext = React.createContext();
```

**Step 2: Create provider component**
```javascript
function UserProvider({ children }) {
  const [user, setUser] = useState(null);
  
  return (
    <UserContext.Provider value={{ user, setUser }}>
      {children}
    </UserContext.Provider>
  );
}
```

**Step 3: Wrap app with provider**
```javascript
function App() {
  return (
    <UserProvider>
      <Header />
      <Main />
    </UserProvider>
  );
}
```

**Step 4: Use context in components**
```javascript
function Profile() {
  const { user } = useContext(UserContext);
  return <div>{user?.name}</div>;
}
```

---

#### 4. What is the difference between Context and props?

| Feature | Context | Props |
|---------|---------|-------|
| **Purpose** | Global state | Component communication |
| **Scope** | Entire subtree | Direct parent-child |
| **Prop Drilling** | Avoids it | Causes it |
| **Performance** | Can be slow | Fast |
| **Use Case** | Global data | Component customization |
| **Complexity** | More setup | Simple |

**Props (direct communication):**
```javascript
<Parent data={data} />
  → <Child data={data} />
    → <GrandChild data={data} />
```

**Context (global access):**
```javascript
<Provider value={data}>
  <Parent />
    → <Child />
      → <GrandChild /> // Can access data directly
</Provider>
```

---

#### 5. What are the limitations of Context API?

**Limitation 1: Performance**
- All consumers re-render when context value changes
- Even if they only use part of the value

```javascript
// All consumers re-render even if only theme changes
<ThemeContext.Provider value={{ theme, user, settings }}>
  {/* All components re-render */}
</ThemeContext.Provider>
```

**Limitation 2: Not ideal for frequently changing data**
```javascript
// DON'T use Context for this
<FormContext.Provider value={{ formData }}>
  {/* Re-renders on every keystroke */}
</FormContext.Provider>
```

**Limitation 3: Complex state logic**
- Context doesn't provide built-in tools for complex state management
- Use Redux or Zustand instead

**Limitation 4: Debugging**
- Harder to trace data flow
- DevTools support is limited

---

#### 6. How does Context API affect performance?

**Performance issue:**
```javascript
function App() {
  const [theme, setTheme] = useState('light');
  const [user, setUser] = useState(null);
  
  // All consumers re-render when ANY value changes
  return (
    <ThemeContext.Provider value={{ theme, setTheme, user, setUser }}>
      <Header /> {/* Re-renders even if only user changes */}
      <Main />
    </ThemeContext.Provider>
  );
}
```

**Solution 1: Split contexts**
```javascript
<ThemeProvider>
  <UserProvider>
    <App />
  </UserProvider>
</ThemeProvider>
```

**Solution 2: Memoize provider value**
```javascript
function App() {
  const [theme, setTheme] = useState('light');
  const value = useMemo(() => ({ theme, setTheme }), [theme]);
  
  return (
    <ThemeContext.Provider value={value}>
      <Header />
    </ThemeContext.Provider>
  );
}
```

**Solution 3: Use useCallback for setters**
```javascript
const setTheme = useCallback((newTheme) => {
  // Update theme
}, []);
```

---

## 10. Refs

#### 1. What are refs in React?

Refs provide a way to access DOM nodes or class component instances directly. They bypass the normal data flow.

**When to use refs:**
- Managing focus on input elements
- Triggering animations
- Integrating with third-party DOM libraries
- Selecting text or playing media

**When NOT to use refs:**
- Anything that can be done declaratively
- Updating component state
- Passing data between components

---

#### 2. How do you create refs in functional and class components?

**Functional component (useRef hook):**
```javascript
function TextInput() {
  const inputRef = useRef(null);
  
  const focusInput = () => {
    inputRef.current.focus();
  };
  
  return (
    <>
      <input ref={inputRef} />
      <button onClick={focusInput}>Focus</button>
    </>
  );
}
```

**Class component (createRef):**
```javascript
class TextInput extends React.Component {
  constructor(props) {
    super(props);
    this.inputRef = React.createRef();
  }
  
  focusInput = () => {
    this.inputRef.current.focus();
  };
  
  render() {
    return (
      <>
        <input ref={this.inputRef} />
        <button onClick={this.focusInput}>Focus</button>
      </>
    );
  }
}
```

---

#### 3. What are the use cases for refs?

**Use case 1: Managing focus**
```javascript
function TextInput() {
  const inputRef = useRef(null);
  
  return (
    <>
      <input ref={inputRef} />
      <button onClick={() => inputRef.current.focus()}>Focus</button>
    </>
  );
}
```

**Use case 2: Triggering animations**
```javascript
function Animation() {
  const divRef = useRef(null);
  
  const startAnimation = () => {
    divRef.current.classList.add('animate');
  };
  
  return (
    <>
      <div ref={divRef}>Animate me</div>
      <button onClick={startAnimation}>Start</button>
    </>
  );
}
```

**Use case 3: Integrating with third-party libraries**
```javascript
function Chart() {
  const chartRef = useRef(null);
  
  useEffect(() => {
    // Initialize third-party chart library
    new ChartLibrary(chartRef.current, options);
  }, []);
  
  return <div ref={chartRef} />;
}
```

**Use case 4: Selecting text or playing media**
```javascript
function MediaPlayer() {
  const videoRef = useRef(null);
  
  return (
    <>
      <video ref={videoRef} src="video.mp4" />
      <button onClick={() => videoRef.current.play()}>Play</button>
    </>
  );
}
```

---

#### 4. What is forwardRef and when would you use it?

**forwardRef** allows a component to forward a ref to its child DOM element.

**Problem:** Refs can't be passed as props to functional components.

```javascript
// This doesn't work
const Input = ({ ref }) => <input ref={ref} />;
<Input ref={inputRef} /> // ref is undefined
```

**Solution: forwardRef**
```javascript
const Input = React.forwardRef((props, ref) => (
  <input ref={ref} {...props} />
));

// Now ref works
<Input ref={inputRef} />
```

**Use case: Custom component library**
```javascript
const CustomButton = React.forwardRef((props, ref) => (
  <button ref={ref} className="custom-btn" {...props} />
));

function App() {
  const btnRef = useRef(null);
  
  return (
    <>
      <CustomButton ref={btnRef}>Click me</CustomButton>
      <button onClick={() => btnRef.current.focus()}>Focus button</button>
    </>
  );
}
```

---

#### 5. What are callback refs?

Callback refs are an alternative to createRef. Instead of a ref object, you pass a callback function.

```javascript
function TextInput() {
  let inputElement = null;
  
  const setInputRef = (element) => {
    inputElement = element;
  };
  
  const focusInput = () => {
    if (inputElement) inputElement.focus();
  };
  
  return (
    <>
      <input ref={setInputRef} />
      <button onClick={focusInput}>Focus</button>
    </>
  );
}
```

**Callback refs are called:**
- With the DOM element when component mounts
- With null when component unmounts

**Use case: Tracking multiple refs**
```javascript
function List() {
  const itemRefs = [];
  
  const setItemRef = (index, element) => {
    itemRefs[index] = element;
  };
  
  return (
    <ul>
      {items.map((item, index) => (
        <li ref={(el) => setItemRef(index, el)} key={item.id}>
          {item.name}
        </li>
      ))}
    </ul>
  );
}
```

---

#### 6. How do you use refs with functional components?

**Using useRef hook:**
```javascript
function Component() {
  const ref = useRef(null);
  
  useEffect(() => {
    // Access ref after mount
    console.log(ref.current);
  }, []);
  
  return <div ref={ref}>Content</div>;
}
```

**Storing mutable values:**
```javascript
function Timer() {
  const intervalRef = useRef(null);
  
  const startTimer = () => {
    intervalRef.current = setInterval(() => {
      // Timer logic
    }, 1000);
  };
  
  const stopTimer = () => {
    clearInterval(intervalRef.current);
  };
  
  return (
    <>
      <button onClick={startTimer}>Start</button>
      <button onClick={stopTimer}>Stop</button>
    </>
  );
}
```

**Key difference from state:**
- Updating ref doesn't trigger re-render
- Ref persists across renders
- Useful for storing mutable values

---

## 11. Fragments

#### 1. What are React Fragments?

Fragments allow you to group multiple elements without adding an extra DOM node. They're useful when a component needs to return multiple elements.

**Problem without fragments:**
```javascript
function List() {
  return (
    <div> {/* Extra div in DOM */}
      <h1>Title</h1>
      <p>Content</p>
    </div>
  );
}
```

**Solution with fragments:**
```javascript
function List() {
  return (
    <> {/* No extra DOM node */}
      <h1>Title</h1>
      <p>Content</p>
    </>
  );
}
```

---

#### 2. Why do we need fragments?

**Reason 1: Avoid extra DOM nodes**
```javascript
// Without fragment - adds wrapper div
<div>
  <h1>Title</h1>
  <p>Content</p>
</div>

// With fragment - no wrapper
<>
  <h1>Title</h1>
  <p>Content</p>
</>
```

**Reason 2: Return multiple elements**
```javascript
// This doesn't work
function Component() {
  return (
    <h1>Title</h1>
    <p>Content</p> // Error: Adjacent JSX elements must be wrapped
  );
}

// This works
function Component() {
  return (
    <>
      <h1>Title</h1>
      <p>Content</p>
    </>
  );
}
```

**Reason 3: Cleaner HTML structure**
- Fragments don't add unnecessary wrapper elements
- Keeps HTML semantic and clean
- Useful for CSS Grid and Flexbox layouts

---

#### 3. What is the difference between <></> and <Fragment>?

**Short syntax (<></>):**
```javascript
function Component() {
  return (
    <>
      <h1>Title</h1>
      <p>Content</p>
    </>
  );
}
```

**Long syntax (<Fragment>):**
```javascript
import { Fragment } from 'react';

function Component() {
  return (
    <Fragment>
      <h1>Title</h1>
      <p>Content</p>
    </Fragment>
  );
}
```

**Differences:**

| Feature | <></> | <Fragment> |
|---------|-------|-----------|
| **Syntax** | Short, clean | Verbose |
| **Keys** | Cannot use keys | Can use keys |
| **Attributes** | No attributes | Can have attributes |
| **Import** | Not needed | Need to import |

**When to use <Fragment>:**
```javascript
// When you need keys (in lists)
{items.map((item) => (
  <Fragment key={item.id}>
    <h1>{item.title}</h1>
    <p>{item.content}</p>
  </Fragment>
))}
```

---

#### 4. Can fragments have keys?

**Yes, but only with <Fragment> syntax:**

```javascript
// This works
{items.map((item) => (
  <Fragment key={item.id}>
    <h1>{item.title}</h1>
    <p>{item.content}</p>
  </Fragment>
))}

// This doesn't work - short syntax doesn't support keys
{items.map((item) => (
  <> {/* Error: Fragment cannot have keys */}
    <h1>{item.title}</h1>
    <p>{item.content}</p>
  </>
))}
```

**Use case: Rendering lists with multiple elements per item**
```javascript
function CommentList({ comments }) {
  return (
    <div>
      {comments.map((comment) => (
        <Fragment key={comment.id}>
          <h3>{comment.author}</h3>
          <p>{comment.text}</p>
          <hr />
        </Fragment>
      ))}
    </div>
  );
}
```

**Why keys matter:**
- React uses keys to identify which items have changed
- Without keys, React might re-render incorrectly
- Keys help maintain component state across re-renders

---


---

## 12. Portals

#### 1. What are React Portals?

Portals provide a way to render components outside their parent DOM hierarchy. They render content into a different part of the DOM tree.

**Normal rendering (inside parent):**
```javascript
function Modal() {
  return <div className="modal">Modal content</div>;
}

// Renders inside parent component
<div id="app">
  <Modal /> {/* Renders here */}
</div>
```

**Portal rendering (outside parent):**
```javascript
function Modal() {
  return ReactDOM.createPortal(
    <div className="modal">Modal content</div>,
    document.getElementById('modal-root')
  );
}

// Renders in different DOM location
<div id="app">
  <Modal /> {/* Code here, but renders in #modal-root */}
</div>
<div id="modal-root"></div> {/* Renders here */}
```

---

#### 2. When would you use portals?

**Use portals for:**
- Modals and dialogs
- Tooltips and popovers
- Dropdowns
- Notifications/alerts
- Lightboxes
- Anything that needs to escape CSS overflow/z-index issues

**Problem without portals:**
```javascript
// Parent has overflow: hidden, modal gets clipped
<div style={{ overflow: 'hidden' }}>
  <Modal /> {/* Gets clipped! */}
</div>
```

**Solution with portals:**
```javascript
// Modal renders outside, not affected by parent styles
<div style={{ overflow: 'hidden' }}>
  <Modal /> {/* Renders in #modal-root, not clipped */}
</div>
```

---

#### 3. How do you create a portal?

**Step 1: Create a DOM element in HTML**
```html
<div id="app"></div>
<div id="modal-root"></div>
```

**Step 2: Use ReactDOM.createPortal**
```javascript
import ReactDOM from 'react-dom';

function Modal({ children }) {
  return ReactDOM.createPortal(
    <div className="modal-overlay">
      <div className="modal-content">{children}</div>
    </div>,
    document.getElementById('modal-root')
  );
}
```

**Step 3: Use the component**
```javascript
function App() {
  const [showModal, setShowModal] = useState(false);
  
  return (
    <>
      <button onClick={() => setShowModal(true)}>Open Modal</button>
      {showModal && (
        <Modal>
          <h1>Modal Title</h1>
          <button onClick={() => setShowModal(false)}>Close</button>
        </Modal>
      )}
    </>
  );
}
```

---

#### 4. What are common use cases for portals?

**Use case 1: Modal dialogs**
```javascript
function ConfirmDialog({ onConfirm, onCancel }) {
  return ReactDOM.createPortal(
    <div className="dialog-overlay" onClick={onCancel}>
      <div className="dialog" onClick={(e) => e.stopPropagation()}>
        <p>Are you sure?</p>
        <button onClick={onConfirm}>Yes</button>
        <button onClick={onCancel}>No</button>
      </div>
    </div>,
    document.getElementById('modal-root')
  );
}
```

**Use case 2: Tooltips**
```javascript
function Tooltip({ text, children }) {
  const [show, setShow] = useState(false);
  
  return (
    <>
      <span onMouseEnter={() => setShow(true)} onMouseLeave={() => setShow(false)}>
        {children}
      </span>
      {show && ReactDOM.createPortal(
        <div className="tooltip">{text}</div>,
        document.body
      )}
    </>
  );
}
```

**Use case 3: Notifications**
```javascript
function Notification({ message, type }) {
  return ReactDOM.createPortal(
    <div className={`notification notification-${type}`}>
      {message}
    </div>,
    document.getElementById('notifications-root')
  );
}
```

---

## 13. Error Boundaries

#### 1. What are error boundaries?

Error boundaries are React components that catch JavaScript errors anywhere in the component tree, log those errors, and display a fallback UI instead of crashing the app.

**What they catch:**
- Rendering errors
- Lifecycle method errors
- Constructor errors

**What they DON'T catch:**
- Event handler errors (use try/catch)
- Async code errors
- Server-side rendering errors
- Errors in the error boundary itself

---

#### 2. How do you implement error boundaries?

Error boundaries must be class components using lifecycle methods.

```javascript
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false, error: null };
  }
  
  static getDerivedStateFromError(error) {
    return { hasError: true, error };
  }
  
  componentDidCatch(error, errorInfo) {
    console.log('Error caught:', error, errorInfo);
    // Log to error reporting service
  }
  
  render() {
    if (this.state.hasError) {
      return <h1>Something went wrong: {this.state.error.message}</h1>;
    }
    return this.props.children;
  }
}

// Usage
<ErrorBoundary>
  <MyComponent />
</ErrorBoundary>
```

---

#### 3. What errors do error boundaries NOT catch?

**Errors NOT caught:**

1. **Event handlers** (use try/catch)
```javascript
function Button() {
  const handleClick = () => {
    try {
      throw new Error('Error in handler');
    } catch (error) {
      console.log('Caught:', error);
    }
  };
  return <button onClick={handleClick}>Click</button>;
}
```

2. **Async code** (use try/catch in async function)
```javascript
useEffect(() => {
  const fetchData = async () => {
    try {
      const data = await fetch('/api');
    } catch (error) {
      console.log('Caught:', error);
    }
  };
  fetchData();
}, []);
```

3. **Server-side rendering**

4. **Errors in the error boundary itself**

---

#### 4. What is the lifecycle method for error boundaries?

**getDerivedStateFromError:**
- Called during render phase
- Returns new state
- Used to update state

**componentDidCatch:**
- Called during commit phase
- Used for side effects (logging, error reporting)
- Has access to error info

```javascript
static getDerivedStateFromError(error) {
  // Update state
  return { hasError: true };
}

componentDidCatch(error, errorInfo) {
  // Log error
  console.log(error, errorInfo);
}
```

---

#### 5. How do you implement error boundaries in functional components?

**Currently, error boundaries must be class components.** There's no hook equivalent yet.

**Workaround: Create a class component wrapper**
```javascript
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }
  
  static getDerivedStateFromError(error) {
    return { hasError: true };
  }
  
  render() {
    if (this.state.hasError) {
      return <h1>Error occurred</h1>;
    }
    return this.props.children;
  }
}

// Use with functional components
function App() {
  return (
    <ErrorBoundary>
      <MyFunctionalComponent />
    </ErrorBoundary>
  );
}
```

---

## 14. Higher-Order Components (HOCs)

#### 1. What are Higher-Order Components?

An HOC is a pattern for reusing component logic. It's a function that takes a component and returns an enhanced component.

**Pattern:**
```javascript
const EnhancedComponent = higherOrderComponent(OriginalComponent);
```

**Simple example:**
```javascript
function withTheme(Component) {
  return (props) => (
    <ThemeProvider>
      <Component {...props} />
    </ThemeProvider>
  );
}

const ThemedButton = withTheme(Button);
```

---

#### 2. How do you create an HOC?

**Step 1: Create a function that takes a component**
```javascript
function withSubscription(WrappedComponent) {
  // Step 2: Return a new component
  return (props) => {
    const [data, setData] = useState(null);
    
    useEffect(() => {
      // Subscribe to data
      const subscription = subscribe(setData);
      return () => subscription.unsubscribe();
    }, []);
    
    // Step 3: Pass props and data to wrapped component
    return <WrappedComponent data={data} {...props} />;
  };
}

// Usage
const EnhancedComponent = withSubscription(MyComponent);
```

---

#### 3. What are the common use cases for HOCs?

**Use case 1: Authentication**
```javascript
function withAuth(Component) {
  return (props) => {
    const [user, setUser] = useState(null);
    
    useEffect(() => {
      checkAuth().then(setUser);
    }, []);
    
    if (!user) return <Login />;
    return <Component user={user} {...props} />;
  };
}
```

**Use case 2: Theme provider**
```javascript
function withTheme(Component) {
  return (props) => (
    <ThemeProvider>
      <Component {...props} />
    </ThemeProvider>
  );
}
```

**Use case 3: Data fetching**
```javascript
function withData(url) {
  return (Component) => {
    return (props) => {
      const [data, setData] = useState(null);
      
      useEffect(() => {
        fetch(url).then(res => res.json()).then(setData);
      }, [url]);
      
      return <Component data={data} {...props} />;
    };
  };
}
```

---

#### 4. What are the best practices for HOCs?

**Best practice 1: Display name for debugging**
```javascript
function withSubscription(WrappedComponent) {
  function WithSubscription(props) {
    return <WrappedComponent {...props} />;
  }
  
  WithSubscription.displayName = `WithSubscription(${getDisplayName(WrappedComponent)})`;
  return WithSubscription;
}

function getDisplayName(WrappedComponent) {
  return WrappedComponent.displayName || WrappedComponent.name || 'Component';
}
```

**Best practice 2: Copy static methods**
```javascript
import hoistNonReactStatics from 'hoist-non-react-statics';

function enhance(Component) {
  class Enhance extends React.Component {}
  hoistNonReactStatics(Enhance, Component);
  return Enhance;
}
```

**Best practice 3: Forward refs**
```javascript
const withForwardRef = (Component) => {
  return React.forwardRef((props, ref) => (
    <Component {...props} forwardedRef={ref} />
  ));
};
```

---

#### 5. What are the limitations of HOCs?

**Limitation 1: Wrapper hell**
```javascript
// Multiple HOCs create deeply nested components
<WithRouter>
  <WithTheme>
    <WithAuth>
      <MyComponent />
    </WithAuth>
  </WithTheme>
</WithRouter>
```

**Limitation 2: Ref forwarding issues**
```javascript
// Refs don't automatically forward through HOCs
const EnhancedComponent = withTheme(MyComponent);
<EnhancedComponent ref={ref} /> // ref doesn't work!
```

**Limitation 3: Static method copying**
```javascript
// Static methods aren't automatically copied
class MyComponent {
  static staticMethod() {}
}
const Enhanced = withTheme(MyComponent);
Enhanced.staticMethod(); // undefined!
```

**Limitation 4: Performance**
- Creates new component on every render
- Can cause unnecessary re-renders

**Modern alternative: Hooks** (preferred over HOCs)

---

## 15. Render Props

#### 1. What is the render props pattern?

Render props is a pattern where a component accepts a function as a prop that returns JSX. The component calls this function to render content.

**Pattern:**
```javascript
<Component render={(data) => <div>{data}</div>} />
```

**Example:**
```javascript
function DataProvider({ render }) {
  const [data, setData] = useState(null);
  
  useEffect(() => {
    fetch('/api/data').then(res => res.json()).then(setData);
  }, []);
  
  return render(data);
}

// Usage
<DataProvider render={(data) => <div>{data}</div>} />
```

---

#### 2. How do you implement render props?

**Step 1: Create component that accepts render prop**
```javascript
function MouseTracker({ render }) {
  const [position, setPosition] = useState({ x: 0, y: 0 });
  
  const handleMouseMove = (e) => {
    setPosition({ x: e.clientX, y: e.clientY });
  };
  
  return (
    <div onMouseMove={handleMouseMove}>
      {render(position)}
    </div>
  );
}
```

**Step 2: Use the render prop**
```javascript
<MouseTracker render={(position) => (
  <p>Mouse is at ({position.x}, {position.y})</p>
)} />
```

**Alternative: Using children as render prop**
```javascript
function MouseTracker({ children }) {
  const [position, setPosition] = useState({ x: 0, y: 0 });
  
  return (
    <div onMouseMove={(e) => setPosition({ x: e.clientX, y: e.clientY })}>
      {children(position)}
    </div>
  );
}

// Usage
<MouseTracker>
  {(position) => <p>Mouse at ({position.x}, {position.y})</p>}
</MouseTracker>
```

---

#### 3. What are the advantages of render props?

**Advantage 1: Flexible composition**
```javascript
// Can compose multiple render props
<DataProvider render={(data) => (
  <MouseTracker render={(position) => (
    <div>{data} at {position.x}, {position.y}</div>
  )} />
)} />
```

**Advantage 2: Easy to understand**
- Clear what data is being passed
- Easy to debug

**Advantage 3: No wrapper hell**
- Avoids deeply nested HOCs
- More readable

---

#### 4. How do render props compare to HOCs?

| Feature | Render Props | HOCs |
|---------|-------------|------|
| **Syntax** | Prop function | Wrapper component |
| **Readability** | Clear data flow | Can be confusing |
| **Composition** | Flexible | Wrapper hell |
| **Performance** | Slightly slower | Slightly faster |
| **Debugging** | Easier | Harder |
| **Modern Alternative** | Hooks | Hooks |

**Render props:**
```javascript
<DataProvider render={(data) => <Component data={data} />} />
```

**HOC:**
```javascript
const Enhanced = withData(Component);
<Enhanced />
```

**Modern (Hooks):**
```javascript
function Component() {
  const data = useData();
  return <div>{data}</div>;
}
```

---

## 16. Pure Components

#### 1. What are Pure Components?

Pure Components are components that only re-render if their props or state actually change. They perform shallow comparison of props and state.

**Regular Component:**
```javascript
class Button extends React.Component {
  render() {
    return <button>{this.props.label}</button>;
  }
}
```

**Pure Component:**
```javascript
class Button extends React.PureComponent {
  render() {
    return <button>{this.props.label}</button>;
  }
}
```

---

#### 2. What is the difference between PureComponent and Component?

| Feature | Component | PureComponent |
|---------|-----------|---------------|
| **Re-render** | Always re-renders | Only if props/state change |
| **Comparison** | None | Shallow comparison |
| **Performance** | Slower | Faster |
| **shouldComponentUpdate** | Manual | Automatic |

**Component (always re-renders):**
```javascript
class Counter extends React.Component {
  render() {
    console.log('Rendering'); // Logs every time
    return <div>{this.props.count}</div>;
  }
}
```

**PureComponent (only re-renders if props change):**
```javascript
class Counter extends React.PureComponent {
  render() {
    console.log('Rendering'); // Only logs when count changes
    return <div>{this.props.count}</div>;
  }
}
```

---

#### 3. How do you implement pure components in functional components?

Use **React.memo** for functional components:

```javascript
function Button({ label }) {
  console.log('Rendering');
  return <button>{label}</button>;
}

export default React.memo(Button);
```

**With custom comparison:**
```javascript
function Button({ label, onClick }) {
  return <button onClick={onClick}>{label}</button>;
}

export default React.memo(Button, (prevProps, nextProps) => {
  // Return true if props are equal (don't re-render)
  return prevProps.label === nextProps.label;
});
```

---

#### 4. When should you use pure components?

**Use pure components when:**
- Component receives same props frequently
- Component is expensive to render
- Props are simple (primitives, not objects)

**Don't use pure components when:**
- Props are complex objects (shallow comparison fails)
- Props change frequently
- Component is already fast

**Example (good use case):**
```javascript
// List item that receives same props often
const ListItem = React.memo(({ id, name }) => (
  <li>{name}</li>
));
```

**Example (bad use case):**
```javascript
// Props are objects that change frequently
const UserCard = React.memo(({ user }) => (
  <div>{user.name}</div>
));

// user object changes every render, memo doesn't help
<UserCard user={{ name: 'Alice' }} />
```

---


---

## 17. useState Hook

#### 1. What is the useState hook?

useState is a hook that lets you add state to functional components. It returns an array with the current state value and a function to update it.

**Syntax:**
```javascript
const [state, setState] = useState(initialValue);
```

**Example:**
```javascript
function Counter() {
  const [count, setCount] = useState(0);
  
  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

---

#### 2. How do you update state based on previous state?

**Method 1: Using previous state in updater function**
```javascript
const [count, setCount] = useState(0);

// Correct - use updater function
setCount(prevCount => prevCount + 1);

// Wrong - might use stale state
setCount(count + 1);
```

**Why use updater function?**
- Ensures you're using the latest state
- Handles batched updates correctly
- Prevents race conditions

**Example with multiple updates:**
```javascript
function Counter() {
  const [count, setCount] = useState(0);
  
  const increment = () => {
    setCount(prev => prev + 1);
    setCount(prev => prev + 1); // Both updates work correctly
  };
  
  return (
    <div>
      <p>{count}</p>
      <button onClick={increment}>Increment twice</button>
    </div>
  );
}
```

---

#### 3. What is the difference between useState and this.setState?

| Feature | useState | this.setState |
|---------|----------|---------------|
| **Component Type** | Functional | Class |
| **Merging** | Replaces state | Merges with existing state |
| **Batching** | Batched | Batched |
| **Async** | Asynchronous | Asynchronous |
| **Callback** | Use useEffect | Accepts callback |

**useState (replaces):**
```javascript
const [state, setState] = useState({ count: 0, name: '' });

// Replaces entire state
setState({ count: 1 }); // name is lost!

// Correct - spread to merge
setState(prev => ({ ...prev, count: 1 }));
```

**this.setState (merges):**
```javascript
this.state = { count: 0, name: '' };

// Merges with existing state
this.setState({ count: 1 }); // name is preserved
```

---

#### 4. How does useState work with arrays and objects?

**With objects:**
```javascript
const [user, setUser] = useState({ name: '', email: '' });

// Update single property
setUser(prev => ({ ...prev, name: 'Alice' }));

// Or using object spread
setUser({ ...user, name: 'Alice' });
```

**With arrays:**
```javascript
const [items, setItems] = useState([]);

// Add item
setItems(prev => [...prev, newItem]);

// Remove item
setItems(prev => prev.filter(item => item.id !== id));

// Update item
setItems(prev => prev.map(item => 
  item.id === id ? { ...item, name: 'Updated' } : item
));
```

**Important: Always create new references**
```javascript
// WRONG - mutates original
items.push(newItem);
setItems(items);

// CORRECT - creates new array
setItems([...items, newItem]);
```

---

#### 5. What is the functional update form of useState?

The functional update form passes a function to setState instead of a value.

**Syntax:**
```javascript
setState(prevState => newState);
```

**Benefits:**
- Access to previous state
- Handles batched updates correctly
- Prevents stale state issues

**Example:**
```javascript
function Counter() {
  const [count, setCount] = useState(0);
  
  // Functional update
  const increment = () => setCount(prev => prev + 1);
  
  // Multiple updates work correctly
  const incrementTwice = () => {
    setCount(prev => prev + 1);
    setCount(prev => prev + 1);
  };
  
  return (
    <div>
      <p>{count}</p>
      <button onClick={increment}>+1</button>
      <button onClick={incrementTwice}>+2</button>
    </div>
  );
}
```

---

## 18. useEffect Hook

#### 1. What is the useEffect hook?

useEffect is a hook that lets you perform side effects in functional components. It runs after the component renders.

**Syntax:**
```javascript
useEffect(() => {
  // Side effect code
}, [dependencies]);
```

**Example:**
```javascript
function Component() {
  useEffect(() => {
    console.log('Component mounted or updated');
  });
  
  return <div>Content</div>;
}
```

---

#### 2. How do you mimic lifecycle methods with useEffect?

**componentDidMount (runs once on mount):**
```javascript
useEffect(() => {
  console.log('Mounted');
}, []); // Empty dependency array
```

**componentDidUpdate (runs after every update):**
```javascript
useEffect(() => {
  console.log('Updated');
}); // No dependency array
```

**componentDidUpdate with specific dependencies:**
```javascript
useEffect(() => {
  console.log('Count changed');
}, [count]); // Runs when count changes
```

**componentWillUnmount (cleanup):**
```javascript
useEffect(() => {
  return () => {
    console.log('Unmounting');
  };
}, []);
```

---

#### 3. What is the cleanup function in useEffect?

The cleanup function runs before the component unmounts or before the effect runs again.

**Syntax:**
```javascript
useEffect(() => {
  // Setup
  
  return () => {
    // Cleanup
  };
}, []);
```

**Common cleanup tasks:**
```javascript
useEffect(() => {
  // Subscribe to data
  const subscription = subscribe(handleUpdate);
  
  // Setup event listener
  window.addEventListener('resize', handleResize);
  
  // Setup timer
  const timer = setInterval(() => {}, 1000);
  
  // Cleanup function
  return () => {
    subscription.unsubscribe();
    window.removeEventListener('resize', handleResize);
    clearInterval(timer);
  };
}, []);
```

---

#### 4. How do you control when useEffect runs?

**No dependency array - runs after every render:**
```javascript
useEffect(() => {
  console.log('Runs after every render');
});
```

**Empty dependency array - runs once on mount:**
```javascript
useEffect(() => {
  console.log('Runs once on mount');
}, []);
```

**With dependencies - runs when dependencies change:**
```javascript
useEffect(() => {
  console.log('Runs when count or name changes');
}, [count, name]);
```

**Conditional execution:**
```javascript
useEffect(() => {
  if (count > 0) {
    console.log('Count is positive');
  }
}, [count]);
```

---

#### 5. What is the dependency array in useEffect?

The dependency array tells React when to run the effect.

**Rules:**
- Include all values from component scope that change
- Omit values that don't change
- Use ESLint plugin to catch missing dependencies

**Example:**
```javascript
function Component({ userId }) {
  const [user, setUser] = useState(null);
  
  useEffect(() => {
    fetch(`/api/users/${userId}`)
      .then(res => res.json())
      .then(setUser);
  }, [userId]); // Re-run when userId changes
}
```

**Common mistake:**
```javascript
// WRONG - missing dependency
useEffect(() => {
  fetch(`/api/users/${userId}`); // userId is used but not in dependencies
}, []);

// CORRECT
useEffect(() => {
  fetch(`/api/users/${userId}`);
}, [userId]);
```

---

#### 6. How do you handle async operations in useEffect?

**Method 1: Async function inside effect**
```javascript
useEffect(() => {
  const fetchData = async () => {
    const response = await fetch('/api/data');
    const data = await response.json();
    setData(data);
  };
  
  fetchData();
}, []);
```

**Method 2: Using .then()**
```javascript
useEffect(() => {
  fetch('/api/data')
    .then(res => res.json())
    .then(setData);
}, []);
```

**Method 3: With cleanup (abort request)**
```javascript
useEffect(() => {
  const controller = new AbortController();
  
  fetch('/api/data', { signal: controller.signal })
    .then(res => res.json())
    .then(setData)
    .catch(err => {
      if (err.name !== 'AbortError') {
        console.error(err);
      }
    });
  
  return () => controller.abort();
}, []);
```

---

#### 7. What are the common mistakes with useEffect?

**Mistake 1: Missing dependency array**
```javascript
// WRONG - runs after every render
useEffect(() => {
  fetch('/api/data').then(setData);
});

// CORRECT
useEffect(() => {
  fetch('/api/data').then(setData);
}, []);
```

**Mistake 2: Infinite loop**
```javascript
// WRONG - state update triggers effect, which updates state
useEffect(() => {
  setCount(count + 1);
}, [count]);

// CORRECT - use updater function
useEffect(() => {
  setCount(prev => prev + 1);
}, []);
```

**Mistake 3: Not cleaning up subscriptions**
```javascript
// WRONG - memory leak
useEffect(() => {
  const subscription = subscribe(handleUpdate);
});

// CORRECT
useEffect(() => {
  const subscription = subscribe(handleUpdate);
  return () => subscription.unsubscribe();
}, []);
```

**Mistake 4: Using stale state**
```javascript
// WRONG - uses stale count
useEffect(() => {
  const timer = setInterval(() => {
    console.log(count); // Always logs initial value
  }, 1000);
}, []);

// CORRECT - include count in dependencies
useEffect(() => {
  const timer = setInterval(() => {
    console.log(count);
  }, 1000);
}, [count]);
```

---

## 19. useContext Hook

#### 1. How do you use the useContext hook?

useContext is a hook that lets you subscribe to context without nesting.

**Syntax:**
```javascript
const value = useContext(MyContext);
```

**Example:**
```javascript
const ThemeContext = React.createContext();

function App() {
  const [theme, setTheme] = useState('light');
  
  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      <Header />
    </ThemeContext.Provider>
  );
}

function Header() {
  const { theme, setTheme } = useContext(ThemeContext);
  
  return (
    <header className={theme}>
      <button onClick={() => setTheme(theme === 'light' ? 'dark' : 'light')}>
        Toggle theme
      </button>
    </header>
  );
}
```

---

#### 2. What is the difference between useContext and Context Consumer?

| Feature | useContext | Consumer |
|---------|-----------|----------|
| **Syntax** | Hook | Render prop |
| **Readability** | Cleaner | More verbose |
| **Component Type** | Functional | Any |
| **Nesting** | No nesting | Nested JSX |

**useContext (modern):**
```javascript
function Component() {
  const value = useContext(MyContext);
  return <div>{value}</div>;
}
```

**Consumer (legacy):**
```javascript
function Component() {
  return (
    <MyContext.Consumer>
      {value => <div>{value}</div>}
    </MyContext.Consumer>
  );
}
```

---

#### 3. How does useContext affect re-renders?

**All consumers re-render when context value changes:**
```javascript
function App() {
  const [theme, setTheme] = useState('light');
  const [user, setUser] = useState(null);
  
  // All consumers re-render when ANY value changes
  return (
    <ThemeContext.Provider value={{ theme, setTheme, user, setUser }}>
      <Header /> {/* Re-renders even if only user changes */}
      <Main />
    </ThemeContext.Provider>
  );
}
```

**Solution: Split contexts**
```javascript
<ThemeProvider>
  <UserProvider>
    <App />
  </UserProvider>
</ThemeProvider>
```

**Solution: Memoize provider value**
```javascript
const value = useMemo(() => ({ theme, setTheme }), [theme]);

return (
  <ThemeContext.Provider value={value}>
    <App />
  </ThemeContext.Provider>
);
```

---

## 20. useReducer Hook

#### 1. What is the useReducer hook?

useReducer is a hook for managing complex state logic. It's similar to Redux but built into React.

**Syntax:**
```javascript
const [state, dispatch] = useReducer(reducer, initialState);
```

**Example:**
```javascript
function reducer(state, action) {
  switch(action.type) {
    case 'INCREMENT':
      return { count: state.count + 1 };
    case 'DECREMENT':
      return { count: state.count - 1 };
    default:
      return state;
  }
}

function Counter() {
  const [state, dispatch] = useReducer(reducer, { count: 0 });
  
  return (
    <div>
      <p>{state.count}</p>
      <button onClick={() => dispatch({ type: 'INCREMENT' })}>+</button>
      <button onClick={() => dispatch({ type: 'DECREMENT' })}>-</button>
    </div>
  );
}
```

---

#### 2. When would you use useReducer over useState?

**Use useReducer when:**
- State logic is complex (multiple related values)
- Next state depends on previous state
- Multiple actions update state
- State is an object with multiple properties

**Use useState when:**
- State is simple (single value)
- State updates are independent
- Few state updates

**Example (useReducer):**
```javascript
// Complex form with multiple fields
const [state, dispatch] = useReducer(formReducer, initialState);

dispatch({ type: 'SET_NAME', payload: 'Alice' });
dispatch({ type: 'SET_EMAIL', payload: 'alice@example.com' });
dispatch({ type: 'RESET' });
```

**Example (useState):**
```javascript
// Simple counter
const [count, setCount] = useState(0);
setCount(count + 1);
```

---

#### 3. How does useReducer compare to Redux?

| Feature | useReducer | Redux |
|---------|-----------|-------|
| **Setup** | Built-in | External library |
| **Complexity** | Simple | Complex |
| **DevTools** | Limited | Excellent |
| **Middleware** | No | Yes |
| **Scalability** | Small to medium | Large apps |
| **Learning Curve** | Easy | Steep |

**useReducer (local state):**
```javascript
const [state, dispatch] = useReducer(reducer, initialState);
```

**Redux (global state):**
```javascript
const state = useSelector(state => state);
const dispatch = useDispatch();
```

---

#### 4. What is a reducer function?

A reducer function takes current state and an action, and returns new state.

**Syntax:**
```javascript
function reducer(state, action) {
  switch(action.type) {
    case 'ACTION_TYPE':
      return newState;
    default:
      return state;
  }
}
```

**Example:**
```javascript
function todoReducer(state, action) {
  switch(action.type) {
    case 'ADD_TODO':
      return {
        ...state,
        todos: [...state.todos, action.payload]
      };
    case 'REMOVE_TODO':
      return {
        ...state,
        todos: state.todos.filter(todo => todo.id !== action.payload)
      };
    case 'TOGGLE_TODO':
      return {
        ...state,
        todos: state.todos.map(todo =>
          todo.id === action.payload
            ? { ...todo, completed: !todo.completed }
            : todo
        )
      };
    default:
      return state;
  }
}
```

---

## 21. useCallback Hook

#### 1. What is the useCallback hook?

useCallback is a hook that memoizes a function. It returns the same function reference if dependencies haven't changed.

**Syntax:**
```javascript
const memoizedCallback = useCallback(() => {
  // Function body
}, [dependencies]);
```

**Example:**
```javascript
function Parent() {
  const [count, setCount] = useState(0);
  
  // Without useCallback - new function every render
  const handleClick = () => console.log(count);
  
  // With useCallback - same function if count doesn't change
  const memoizedHandleClick = useCallback(() => {
    console.log(count);
  }, [count]);
  
  return <Child onClick={memoizedHandleClick} />;
}
```

---

#### 2. When should you use useCallback?

**Use useCallback when:**
- Passing callback to memoized child component
- Callback is used as dependency in other hooks
- Callback is expensive to create

**Don't use useCallback when:**
- Callback is simple
- Child component is not memoized
- Performance is not an issue

**Example (good use case):**
```javascript
function Parent() {
  const [count, setCount] = useState(0);
  
  const handleClick = useCallback(() => {
    setCount(prev => prev + 1);
  }, []);
  
  // Child is memoized, useCallback prevents unnecessary re-renders
  return <MemoizedChild onClick={handleClick} />;
}

const MemoizedChild = React.memo(({ onClick }) => (
  <button onClick={onClick}>Click</button>
));
```

---

#### 3. How does useCallback help with performance?

**Without useCallback (unnecessary re-renders):**
```javascript
function Parent() {
  const [count, setCount] = useState(0);
  
  // New function every render
  const handleClick = () => setCount(prev => prev + 1);
  
  return <MemoizedChild onClick={handleClick} />;
}

// Child re-renders because onClick reference changed
const MemoizedChild = React.memo(({ onClick }) => (
  <button onClick={onClick}>Click</button>
));
```

**With useCallback (prevents re-renders):**
```javascript
function Parent() {
  const [count, setCount] = useState(0);
  
  // Same function reference if dependencies don't change
  const handleClick = useCallback(() => {
    setCount(prev => prev + 1);
  }, []);
  
  return <MemoizedChild onClick={handleClick} />;
}

// Child doesn't re-render because onClick reference is stable
const MemoizedChild = React.memo(({ onClick }) => (
  <button onClick={onClick}>Click</button>
));
```

---

#### 4. What are the dependencies in useCallback?

Dependencies are values that the callback uses. If they change, the callback is recreated.

**Example:**
```javascript
function Component({ userId }) {
  const [count, setCount] = useState(0);
  
  // Callback depends on userId and count
  const handleClick = useCallback(() => {
    console.log(userId, count);
  }, [userId, count]); // Include all dependencies
  
  // If userId or count changes, new callback is created
}
```

**Common mistake:**
```javascript
// WRONG - missing dependency
const handleClick = useCallback(() => {
  console.log(userId); // userId is used but not in dependencies
}, []);

// CORRECT
const handleClick = useCallback(() => {
  console.log(userId);
}, [userId]);
```

---

## 22. useMemo Hook

#### 1. What is the useMemo hook?

useMemo is a hook that memoizes a computed value. It only recalculates if dependencies change.

**Syntax:**
```javascript
const memoizedValue = useMemo(() => {
  return expensiveCalculation(a, b);
}, [a, b]);
```

**Example:**
```javascript
function Component({ items }) {
  // Without useMemo - recalculates every render
  const sortedItems = items.sort((a, b) => a - b);
  
  // With useMemo - only recalculates if items change
  const memoizedSortedItems = useMemo(() => {
    return items.sort((a, b) => a - b);
  }, [items]);
  
  return <div>{memoizedSortedItems}</div>;
}
```

---

#### 2. When should you use useMemo?

**Use useMemo when:**
- Calculation is expensive
- Value is used as dependency in other hooks
- Value is passed to memoized child component

**Don't use useMemo when:**
- Calculation is simple
- Value doesn't change often
- Performance is not an issue

**Example (good use case):**
```javascript
function Component({ items }) {
  // Expensive calculation
  const filteredItems = useMemo(() => {
    return items.filter(item => item.active).sort((a, b) => a.name.localeCompare(b.name));
  }, [items]);
  
  return <MemoizedList items={filteredItems} />;
}
```

---

#### 3. What's the difference between useMemo and useCallback?

| Feature | useMemo | useCallback |
|---------|---------|-----------|
| **Memoizes** | Value | Function |
| **Returns** | Computed value | Function reference |
| **Use Case** | Expensive calculations | Callback functions |
| **Syntax** | `useMemo(() => value, deps)` | `useCallback(() => {}, deps)` |

**useMemo (memoizes value):**
```javascript
const expensiveValue = useMemo(() => {
  return complexCalculation(data);
}, [data]);
```

**useCallback (memoizes function):**
```javascript
const memoizedFunction = useCallback(() => {
  doSomething(data);
}, [data]);
```

**Relationship:**
```javascript
// useCallback is equivalent to useMemo for functions
const handleClick = useCallback(() => {}, []);

// Is the same as
const handleClick = useMemo(() => () => {}, []);
```

---

#### 4. How does useMemo help with performance optimization?

**Without useMemo (recalculates every render):**
```javascript
function Component({ items, filter }) {
  // Recalculates every render, even if items and filter don't change
  const filteredItems = items.filter(item => item.type === filter);
  
  return <List items={filteredItems} />;
}
```

**With useMemo (only recalculates when dependencies change):**
```javascript
function Component({ items, filter }) {
  // Only recalculates if items or filter changes
  const filteredItems = useMemo(() => {
    return items.filter(item => item.type === filter);
  }, [items, filter]);
  
  return <List items={filteredItems} />;
}
```

**Performance benefit:**
- Reduces unnecessary calculations
- Prevents child re-renders (if child is memoized)
- Improves app responsiveness

**When it matters:**
- Large datasets
- Complex calculations
- Frequent re-renders

---


---

## 23. useRef Hook

#### 1. What is the useRef hook?

useRef is a hook that returns a mutable ref object that persists across renders. Unlike state, updating a ref doesn't trigger a re-render.

**Syntax:**
```javascript
const ref = useRef(initialValue);
```

**Example:**
```javascript
function TextInput() {
  const inputRef = useRef(null);
  
  const focusInput = () => {
    inputRef.current.focus();
  };
  
  return (
    <>
      <input ref={inputRef} />
      <button onClick={focusInput}>Focus</button>
    </>
  );
}
```

---

#### 2. What are the different use cases for useRef?

**Use case 1: Accessing DOM elements**
```javascript
const inputRef = useRef(null);
inputRef.current.focus();
```

**Use case 2: Storing mutable values**
```javascript
function Timer() {
  const intervalRef = useRef(null);
  
  const start = () => {
    intervalRef.current = setInterval(() => {}, 1000);
  };
  
  const stop = () => {
    clearInterval(intervalRef.current);
  };
}
```

**Use case 3: Keeping track of previous values**
```javascript
function Component({ value }) {
  const prevValueRef = useRef();
  
  useEffect(() => {
    prevValueRef.current = value;
  }, [value]);
  
  return <div>Current: {value}, Previous: {prevValueRef.current}</div>;
}
```

**Use case 4: Storing instance variables**
```javascript
function Component() {
  const countRef = useRef(0);
  
  const handleClick = () => {
    countRef.current++;
    console.log(`Clicked ${countRef.current} times`);
  };
  
  return <button onClick={handleClick}>Click</button>;
}
```

---

#### 3. How is useRef different from useState?

| Feature | useRef | useState |
|---------|--------|----------|
| **Triggers Re-render** | No | Yes |
| **Mutable** | Yes | No (immutable) |
| **Persists** | Across renders | Across renders |
| **Use Case** | DOM access, mutable values | Component state |
| **Update** | Direct assignment | setState function |
| **Initial Value** | Stored in .current | Stored in state |

**useRef (no re-render):**
```javascript
const countRef = useRef(0);
countRef.current++; // No re-render
```

**useState (triggers re-render):**
```javascript
const [count, setCount] = useState(0);
setCount(count + 1); // Re-renders
```

---

#### 4. Can useRef be used for more than just DOM references?

**Yes, useRef can store any mutable value:**

**Storing timers:**
```javascript
const timerRef = useRef(null);
timerRef.current = setInterval(() => {}, 1000);
```

**Storing previous state:**
```javascript
const prevStateRef = useRef();
useEffect(() => {
  prevStateRef.current = state;
}, [state]);
```

**Storing API abort controller:**
```javascript
const abortRef = useRef(new AbortController());

useEffect(() => {
  return () => abortRef.current.abort();
}, []);
```

**Storing any mutable object:**
```javascript
const dataRef = useRef({ count: 0, name: '' });
dataRef.current.count++;
```

**Key point:** useRef is useful for any value that needs to persist across renders without causing re-renders.

---

## 24. Custom Hooks

#### 1. What are custom hooks?

Custom hooks are JavaScript functions that use React hooks. They let you extract component logic into reusable functions.

**Pattern:**
```javascript
function useCustomHook() {
  // Use React hooks
  const [state, setState] = useState();
  useEffect(() => {});
  
  // Return values
  return [state, setState];
}
```

---

#### 2. How do you create a custom hook?

**Step 1: Create a function starting with "use"**
```javascript
function useFormInput(initialValue) {
  const [value, setValue] = useState(initialValue);
  
  return {
    value,
    onChange: (e) => setValue(e.target.value)
  };
}
```

**Step 2: Use the custom hook**
```javascript
function Form() {
  const name = useFormInput('');
  const email = useFormInput('');
  
  return (
    <>
      <input {...name} />
      <input {...email} />
    </>
  );
}
```

**Example: useWindowSize**
```javascript
function useWindowSize() {
  const [size, setSize] = useState({
    width: window.innerWidth,
    height: window.innerHeight
  });
  
  useEffect(() => {
    const handleResize = () => {
      setSize({
        width: window.innerWidth,
        height: window.innerHeight
      });
    };
    
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);
  
  return size;
}
```

---

#### 3. What are the rules of hooks?

**Rule 1: Only call hooks at the top level**
```javascript
// WRONG - inside condition
if (condition) {
  const [state, setState] = useState();
}

// CORRECT - at top level
const [state, setState] = useState();
if (condition) {
  // Use state here
}
```

**Rule 2: Only call hooks from React functions**
```javascript
// WRONG - regular function
function regularFunction() {
  const [state, setState] = useState();
}

// CORRECT - React component or custom hook
function Component() {
  const [state, setState] = useState();
}

function useCustomHook() {
  const [state, setState] = useState();
}
```

**Rule 3: Use ESLint plugin**
- Install `eslint-plugin-react-hooks`
- Catches violations automatically

---

#### 4. What are some common custom hook patterns?

**Pattern 1: useAsync**
```javascript
function useAsync(asyncFunction, immediate = true) {
  const [status, setStatus] = useState('idle');
  const [data, setData] = useState(null);
  const [error, setError] = useState(null);
  
  const execute = useCallback(async () => {
    setStatus('pending');
    try {
      const response = await asyncFunction();
      setData(response);
      setStatus('success');
    } catch (error) {
      setError(error);
      setStatus('error');
    }
  }, [asyncFunction]);
  
  useEffect(() => {
    if (immediate) execute();
  }, [execute, immediate]);
  
  return { status, data, error, execute };
}
```

**Pattern 2: useFetch**
```javascript
function useFetch(url) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  useEffect(() => {
    fetch(url)
      .then(res => res.json())
      .then(setData)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [url]);
  
  return { data, loading, error };
}
```

**Pattern 3: useLocalStorage**
```javascript
function useLocalStorage(key, initialValue) {
  const [storedValue, setStoredValue] = useState(() => {
    const item = window.localStorage.getItem(key);
    return item ? JSON.parse(item) : initialValue;
  });
  
  const setValue = (value) => {
    setStoredValue(value);
    window.localStorage.setItem(key, JSON.stringify(value));
  };
  
  return [storedValue, setValue];
}
```

---

#### 5. How do custom hooks help with code reuse?

**Without custom hooks (duplicated logic):**
```javascript
function UserProfile() {
  const [user, setUser] = useState(null);
  
  useEffect(() => {
    fetch('/api/user').then(res => res.json()).then(setUser);
  }, []);
  
  return <div>{user?.name}</div>;
}

function UserList() {
  const [users, setUsers] = useState(null);
  
  useEffect(() => {
    fetch('/api/users').then(res => res.json()).then(setUsers);
  }, []);
  
  return <ul>{users?.map(u => <li key={u.id}>{u.name}</li>)}</ul>;
}
```

**With custom hooks (reusable logic):**
```javascript
function useFetch(url) {
  const [data, setData] = useState(null);
  
  useEffect(() => {
    fetch(url).then(res => res.json()).then(setData);
  }, [url]);
  
  return data;
}

function UserProfile() {
  const user = useFetch('/api/user');
  return <div>{user?.name}</div>;
}

function UserList() {
  const users = useFetch('/api/users');
  return <ul>{users?.map(u => <li key={u.id}>{u.name}</li>)}</ul>;
}
```

---

## 25. Additional Hooks

#### 1. What is useLayoutEffect and how is it different from useEffect?

| Feature | useEffect | useLayoutEffect |
|---------|-----------|-----------------|
| **Timing** | After paint | Before paint |
| **Performance** | Better | Slower |
| **Use Case** | Most cases | DOM measurements |
| **Blocking** | Non-blocking | Blocking |

**useEffect (after render):**
```javascript
useEffect(() => {
  console.log('After paint');
}, []);
```

**useLayoutEffect (before paint):**
```javascript
useLayoutEffect(() => {
  console.log('Before paint');
}, []);
```

**When to use useLayoutEffect:**
```javascript
function Component() {
  const ref = useRef(null);
  
  useLayoutEffect(() => {
    // Measure DOM before paint
    const height = ref.current.offsetHeight;
    console.log('Height:', height);
  }, []);
  
  return <div ref={ref}>Content</div>;
}
```

---

#### 2. When would you use useImperativeHandle?

useImperativeHandle customizes the instance value exposed when using forwardRef.

**Use case: Exposing custom methods**
```javascript
const TextInput = React.forwardRef((props, ref) => {
  const inputRef = useRef(null);
  
  useImperativeHandle(ref, () => ({
    focus: () => inputRef.current.focus(),
    clear: () => inputRef.current.value = '',
    getValue: () => inputRef.current.value
  }));
  
  return <input ref={inputRef} />;
});

function App() {
  const inputRef = useRef(null);
  
  return (
    <>
      <TextInput ref={inputRef} />
      <button onClick={() => inputRef.current.focus()}>Focus</button>
      <button onClick={() => inputRef.current.clear()}>Clear</button>
    </>
  );
}
```

---

#### 3. What is useDebugValue and when is it useful?

useDebugValue displays a label for custom hooks in React DevTools.

**Example:**
```javascript
function useFormInput(initialValue) {
  const [value, setValue] = useState(initialValue);
  
  useDebugValue(value); // Shows value in DevTools
  
  return [value, setValue];
}

// In DevTools: useFormInput: "input value"
```

**With formatter:**
```javascript
useDebugValue(value, value => `Value: ${value}`);
```

---

#### 4. How does useId work in React 18+?

useId generates a unique ID that's stable across server and client renders.

**Use case: Accessible form labels**
```javascript
function Form() {
  const emailId = useId();
  const passwordId = useId();
  
  return (
    <>
      <label htmlFor={emailId}>Email</label>
      <input id={emailId} type="email" />
      
      <label htmlFor={passwordId}>Password</label>
      <input id={passwordId} type="password" />
    </>
  );
}
```

**Benefits:**
- Unique across renders
- Stable for SSR
- No collisions in lists

---

## 26. Memoization

#### 1. What is React.memo?

React.memo is a higher-order component that memoizes a component. It only re-renders if props change.

**Syntax:**
```javascript
const MemoizedComponent = React.memo(Component);
```

**Example:**
```javascript
function Button({ label, onClick }) {
  console.log('Rendering');
  return <button onClick={onClick}>{label}</button>;
}

export default React.memo(Button);
```

---

#### 2. When should you use React.memo?

**Use React.memo when:**
- Component receives same props frequently
- Component is expensive to render
- Props are primitives (not objects)

**Don't use when:**
- Props change frequently
- Props are complex objects
- Component is already fast

**Example (good use case):**
```javascript
const ListItem = React.memo(({ id, name }) => (
  <li>{name}</li>
));

// Parent re-renders but ListItem doesn't if props are same
```

---

#### 3. What is the difference between React.memo and useMemo?

| Feature | React.memo | useMemo |
|---------|-----------|---------|
| **Memoizes** | Component | Value |
| **Prevents** | Component re-render | Value recalculation |
| **Use Case** | Expensive components | Expensive calculations |
| **Syntax** | HOC | Hook |

**React.memo (component):**
```javascript
const Button = React.memo(({ label }) => (
  <button>{label}</button>
));
```

**useMemo (value):**
```javascript
const sortedItems = useMemo(() => {
  return items.sort();
}, [items]);
```

---

#### 4. How do you optimize functional components?

**Technique 1: React.memo**
```javascript
const Component = React.memo(({ prop }) => (
  <div>{prop}</div>
));
```

**Technique 2: useMemo**
```javascript
const expensiveValue = useMemo(() => {
  return complexCalculation(data);
}, [data]);
```

**Technique 3: useCallback**
```javascript
const handleClick = useCallback(() => {
  doSomething();
}, []);
```

**Technique 4: Code splitting**
```javascript
const Component = React.lazy(() => import('./Component'));
```

**Technique 5: Avoid inline objects/functions**
```javascript
// WRONG - new object every render
<Component style={{ color: 'red' }} />

// CORRECT - stable reference
const style = { color: 'red' };
<Component style={style} />
```

---

## 27. Code Splitting

#### 1. What is code splitting?

Code splitting is breaking your bundle into smaller chunks that are loaded on demand. It reduces initial load time.

**Benefits:**
- Faster initial page load
- Load code only when needed
- Better performance on slow networks

---

#### 2. How do you implement code splitting in React?

**Using React.lazy and Suspense:**
```javascript
const Dashboard = React.lazy(() => import('./Dashboard'));

function App() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <Dashboard />
    </Suspense>
  );
}
```

**Using dynamic import:**
```javascript
import('./module').then(module => {
  // Use module
});
```

---

#### 3. What is dynamic import?

Dynamic import allows you to import modules at runtime instead of at build time.

**Syntax:**
```javascript
// Static import (loaded immediately)
import Component from './Component';

// Dynamic import (loaded on demand)
const Component = () => import('./Component');
```

---

#### 4. How does React.lazy work?

React.lazy takes a function that returns a dynamic import and returns a component.

**Syntax:**
```javascript
const Component = React.lazy(() => import('./Component'));
```

**How it works:**
1. Component is not loaded initially
2. When component is rendered, import is triggered
3. While loading, fallback is shown
4. Once loaded, component is rendered

---

#### 5. What are the benefits of code splitting?

**Benefit 1: Faster initial load**
- Smaller initial bundle
- Faster page load

**Benefit 2: Better performance**
- Load code only when needed
- Reduce memory usage

**Benefit 3: Improved UX**
- Faster time to interactive
- Better on slow networks

---

## 28. Lazy Loading

#### 1. What is lazy loading in React?

Lazy loading is loading components or data only when they're needed, not upfront.

**Types:**
- Component lazy loading (React.lazy)
- Image lazy loading
- Data lazy loading (pagination, infinite scroll)

---

#### 2. How do you lazy load components?

**Using React.lazy:**
```javascript
const HeavyComponent = React.lazy(() => import('./HeavyComponent'));

function App() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <HeavyComponent />
    </Suspense>
  );
}
```

**Lazy loading with route:**
```javascript
const Dashboard = React.lazy(() => import('./pages/Dashboard'));

function App() {
  return (
    <Routes>
      <Route path="/dashboard" element={
        <Suspense fallback={<div>Loading...</div>}>
          <Dashboard />
        </Suspense>
      } />
    </Routes>
  );
}
```

---

#### 3. What is the Suspense component?

Suspense is a component that lets you specify a loading state while a component is loading.

**Syntax:**
```javascript
<Suspense fallback={<LoadingSpinner />}>
  <LazyComponent />
</Suspense>
```

**Example:**
```javascript
function App() {
  return (
    <Suspense fallback={<p>Loading...</p>}>
      <Dashboard />
      <Settings />
    </Suspense>
  );
}
```

---

#### 4. How do you handle loading states with lazy loading?

**Method 1: Suspense fallback**
```javascript
<Suspense fallback={<LoadingSpinner />}>
  <Component />
</Suspense>
```

**Method 2: Error boundary**
```javascript
<ErrorBoundary>
  <Suspense fallback={<LoadingSpinner />}>
    <Component />
  </Suspense>
</ErrorBoundary>
```

**Method 3: Custom loading state**
```javascript
function useAsync(asyncFunction) {
  const [state, setState] = useState('idle');
  
  useEffect(() => {
    setState('pending');
    asyncFunction()
      .then(() => setState('success'))
      .catch(() => setState('error'));
  }, [asyncFunction]);
  
  return state;
}
```

---

## 29. Virtual DOM

#### 1. What is the Virtual DOM?

The Virtual DOM is an in-memory representation of the real DOM. React maintains a Virtual DOM tree and compares it with the previous one to determine what changed.

**How it works:**
1. React creates Virtual DOM tree
2. When state changes, new Virtual DOM is created
3. React compares old and new Virtual DOM (diffing)
4. React updates only changed parts in real DOM

---

#### 2. How does Virtual DOM improve performance?

**Without Virtual DOM (direct DOM manipulation):**
```javascript
// Each update directly manipulates DOM
for (let i = 0; i < 1000; i++) {
  document.body.innerHTML += `<div>${i}</div>`; // 1000 DOM operations!
}
```

**With Virtual DOM (batched updates):**
```javascript
// React batches updates and applies once
const items = Array.from({length: 1000}, (_, i) => <div key={i}>{i}</div>);
// React optimizes to minimal DOM operations
```

**Performance benefits:**
- Batches multiple updates
- Minimizes DOM operations
- Reduces reflow/repaint

---

#### 3. Explain the Virtual DOM diffing algorithm

**Diffing process:**
1. Compare old and new Virtual DOM trees
2. Identify differences (added, removed, changed nodes)
3. Create minimal set of changes
4. Apply changes to real DOM

**Algorithm:**
- Compares nodes level by level
- Uses keys to identify list items
- Stops comparing when structure changes

---

#### 4. What is reconciliation in React?

Reconciliation is the process of updating the DOM to match the Virtual DOM. React's reconciliation algorithm is called the "diffing algorithm."

**Steps:**
1. Create new Virtual DOM
2. Compare with previous Virtual DOM
3. Identify changes
4. Update real DOM

---

## 30. Reconciliation

#### 1. What is the reconciliation process?

Reconciliation is how React updates the DOM when state or props change.

**Process:**
1. Render phase: Create new Virtual DOM
2. Commit phase: Apply changes to real DOM

---

#### 2. How does React decide when to re-render?

React re-renders when:
- State changes
- Props change
- Parent component re-renders
- Context value changes

**Example:**
```javascript
function Component({ prop }) {
  const [state, setState] = useState(0);
  
  // Re-renders when prop or state changes
  return <div>{prop} {state}</div>;
}
```

---

#### 3. What are keys and how do they help with reconciliation?

Keys help React identify which items have changed in lists.

**Without keys (problematic):**
```javascript
{items.map((item, index) => (
  <li key={index}>{item}</li> // Index changes when list reorders
))}
```

**With keys (correct):**
```javascript
{items.map((item) => (
  <li key={item.id}>{item}</li> // Stable identifier
))}
```

---

#### 4. What is the diffing algorithm?

The diffing algorithm compares old and new Virtual DOM to find differences.

**Rules:**
- Different element types produce different trees
- Keys help identify elements across renders
- Compares elements level by level

---

## 31. Local State

#### 1. When should you use local state vs global state?

**Use local state when:**
- Data is only used in one component
- Data doesn't need to be shared
- Simple state (counter, form input)

**Use global state when:**
- Data is used in multiple components
- Data needs to be shared across app
- Complex state (user auth, theme)

**Example (local state):**
```javascript
function Form() {
  const [name, setName] = useState(''); // Local to this component
  return <input value={name} onChange={(e) => setName(e.target.value)} />;
}
```

**Example (global state):**
```javascript
// User data needed everywhere
const UserContext = createContext();

function App() {
  const [user, setUser] = useState(null);
  return (
    <UserContext.Provider value={user}>
      <Header />
      <Main />
    </UserContext.Provider>
  );
}
```

---

#### 2. How do you manage complex local state?

**Use useReducer:**
```javascript
function reducer(state, action) {
  switch(action.type) {
    case 'ADD_ITEM':
      return { ...state, items: [...state.items, action.payload] };
    case 'REMOVE_ITEM':
      return { ...state, items: state.items.filter(i => i.id !== action.payload) };
    default:
      return state;
  }
}

function Component() {
  const [state, dispatch] = useReducer(reducer, initialState);
  
  return (
    <button onClick={() => dispatch({ type: 'ADD_ITEM', payload: item })}>
      Add
    </button>
  );
}
```

---

#### 3. What are the patterns for organizing state?

**Pattern 1: Separate concerns**
```javascript
const [user, setUser] = useState(null);
const [loading, setLoading] = useState(false);
const [error, setError] = useState(null);
```

**Pattern 2: Group related state**
```javascript
const [state, setState] = useState({
  user: null,
  loading: false,
  error: null
});
```

**Pattern 3: Use useReducer for complex logic**
```javascript
const [state, dispatch] = useReducer(reducer, initialState);
```

---

## 32. Lifting State Up

#### 1. What is "lifting state up"?

Lifting state up means moving state from a child component to a parent component so it can be shared with siblings.

**Problem (state in child):**
```javascript
function Parent() {
  return (
    <>
      <Child1 />
      <Child2 />
    </>
  );
}

function Child1() {
  const [count, setCount] = useState(0); // State in child
  return <button onClick={() => setCount(count + 1)}>{count}</button>;
}

function Child2() {
  // Can't access count from Child1
}
```

**Solution (lift state to parent):**
```javascript
function Parent() {
  const [count, setCount] = useState(0); // State in parent
  
  return (
    <>
      <Child1 count={count} setCount={setCount} />
      <Child2 count={count} />
    </>
  );
}

function Child1({ count, setCount }) {
  return <button onClick={() => setCount(count + 1)}>{count}</button>;
}

function Child2({ count }) {
  return <p>Count: {count}</p>;
}
```

---

#### 2. When should you lift state up?

**Lift state when:**
- Multiple components need the same state
- Child components need to communicate
- State needs to be shared with siblings

**Don't lift when:**
- State is only used in one component
- Lifting creates prop drilling
- Use Context API instead

---

#### 3. How do you lift state in a React application?

**Step 1: Identify shared state**
- Find state used by multiple components

**Step 2: Move to common parent**
- Move state to lowest common ancestor

**Step 3: Pass as props**
- Pass state and setter to children

**Step 4: Update children**
- Children use props instead of local state

---

## 33. State Management Libraries

#### 1. When do you need a state management library?

**Use state management library when:**
- App has complex state
- State is used across many components
- Frequent state updates
- Need time-travel debugging
- Team needs standardized patterns

**Don't use when:**
- App is small
- State is mostly local
- Simple prop passing works

---

#### 2. What are the differences between Redux, MobX, and Context API?

| Feature | Redux | MobX | Context API |
|---------|-------|------|-------------|
| **Learning Curve** | Steep | Moderate | Easy |
| **Boilerplate** | High | Low | None |
| **Performance** | Excellent | Excellent | Good |
| **DevTools** | Excellent | Good | Limited |
| **Scalability** | Large apps | Medium apps | Small to medium |
| **Complexity** | Complex | Simple | Simple |

---

#### 3. How does Redux work with React?

**Redux flow:**
1. Component dispatches action
2. Action goes to reducer
3. Reducer updates store
4. Component subscribes to store changes
5. Component re-renders with new state

**Example:**
```javascript
// Action
const increment = () => ({ type: 'INCREMENT' });

// Reducer
function counterReducer(state = 0, action) {
  if (action.type === 'INCREMENT') return state + 1;
  return state;
}

// Store
const store = createStore(counterReducer);

// Component
function Counter() {
  const count = useSelector(state => state);
  const dispatch = useDispatch();
  
  return (
    <button onClick={() => dispatch(increment())}>
      {count}
    </button>
  );
}
```

---

#### 4. What is the Redux flow (actions, reducers, store)?

**Actions:** Objects describing what happened
```javascript
{ type: 'INCREMENT', payload: 1 }
```

**Reducers:** Functions that update state based on actions
```javascript
function reducer(state, action) {
  if (action.type === 'INCREMENT') {
    return state + action.payload;
  }
  return state;
}
```

**Store:** Holds the entire state tree
```javascript
const store = createStore(reducer);
```

**Flow:**
```
Component → dispatch(action) → Reducer → Store → Component (re-render)
```

---

#### 5. What are Redux middleware?

Middleware intercepts actions before they reach reducers. Used for logging, async operations, etc.

**Example:**
```javascript
const logger = store => next => action => {
  console.log('Dispatching:', action);
  const result = next(action);
  console.log('New state:', store.getState());
  return result;
};

const store = createStore(reducer, applyMiddleware(logger));
```

**Common middleware:**
- redux-thunk (async actions)
- redux-saga (side effects)
- redux-logger (logging)

---

#### 6. How does Zustand compare to Redux?

| Feature | Zustand | Redux |
|---------|---------|-------|
| **Setup** | Simple | Complex |
| **Boilerplate** | Minimal | High |
| **Learning Curve** | Easy | Steep |
| **DevTools** | Basic | Excellent |
| **Bundle Size** | Small | Large |
| **Scalability** | Medium | Large |

**Zustand (simpler):**
```javascript
const useStore = create((set) => ({
  count: 0,
  increment: () => set((state) => ({ count: state.count + 1 }))
}));

function Counter() {
  const { count, increment } = useStore();
  return <button onClick={increment}>{count}</button>;
}
```

**Redux (more complex):**
```javascript
// Actions, reducers, store setup required
// More boilerplate but more powerful
```

---


---

## 34. Global State Patterns

#### 1. What are the patterns for global state management?

**Pattern 1: Context API + useReducer**
```javascript
const StateContext = createContext();

function StateProvider({ children }) {
  const [state, dispatch] = useReducer(reducer, initialState);
  return (
    <StateContext.Provider value={{ state, dispatch }}>
      {children}
    </StateContext.Provider>
  );
}
```

**Pattern 2: Redux**
- Centralized store
- Actions and reducers
- Middleware support

**Pattern 3: Zustand**
- Simple store creation
- Minimal boilerplate
- Easy to use

**Pattern 4: Recoil**
- Atom-based state
- Fine-grained reactivity
- Experimental

---

#### 2. How do you avoid prop drilling?

**Problem (prop drilling):**
```javascript
<GrandParent data={data} />
  → <Parent data={data} />
    → <Child data={data} />
      → <GrandChild data={data} /> // Finally uses it
```

**Solution 1: Context API**
```javascript
const DataContext = createContext();

function GrandParent() {
  return (
    <DataContext.Provider value={data}>
      <Parent />
    </DataContext.Provider>
  );
}

function GrandChild() {
  const data = useContext(DataContext);
  return <div>{data}</div>;
}
```

**Solution 2: Component composition**
```javascript
function GrandParent() {
  return <Parent child={<GrandChild />} />;
}

function Parent({ child }) {
  return <div>{child}</div>;
}
```

**Solution 3: State management library**
```javascript
function GrandChild() {
  const data = useSelector(state => state.data);
  return <div>{data}</div>;
}
```

---

#### 3. What is the Flux architecture pattern?

Flux is an application architecture for building user interfaces. It emphasizes unidirectional data flow.

**Flux flow:**
```
Action → Dispatcher → Store → View → Action
```

**Components:**
- **Actions:** Describe what happened
- **Dispatcher:** Routes actions to stores
- **Stores:** Hold state and logic
- **Views:** React components

**Example:**
```javascript
// Action
const addTodo = (text) => ({
  type: 'ADD_TODO',
  payload: text
});

// Dispatcher
function dispatch(action) {
  store.handle(action);
}

// Store
const store = {
  todos: [],
  handle(action) {
    if (action.type === 'ADD_TODO') {
      this.todos.push(action.payload);
    }
  }
};

// View
function TodoList() {
  return (
    <button onClick={() => dispatch(addTodo('New todo'))}>
      Add Todo
    </button>
  );
}
```

---

## 35. React Router Basics

#### 1. How do you set up routing in React?

**Step 1: Install React Router**
```bash
npm install react-router-dom
```

**Step 2: Wrap app with router**
```javascript
import { BrowserRouter } from 'react-router-dom';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
      </Routes>
    </BrowserRouter>
  );
}
```

---

#### 2. What are the differences between BrowserRouter, HashRouter, and MemoryRouter?

| Router | URL | Use Case |
|--------|-----|----------|
| **BrowserRouter** | `/page` | Production apps |
| **HashRouter** | `/#/page` | Static hosting |
| **MemoryRouter** | No URL | Testing |

**BrowserRouter (modern):**
```javascript
<BrowserRouter>
  <Routes>
    <Route path="/page" element={<Page />} />
  </Routes>
</BrowserRouter>
// URL: example.com/page
```

**HashRouter (legacy):**
```javascript
<HashRouter>
  <Routes>
    <Route path="/page" element={<Page />} />
  </Routes>
</HashRouter>
// URL: example.com/#/page
```

**MemoryRouter (testing):**
```javascript
<MemoryRouter>
  <Routes>
    <Route path="/page" element={<Page />} />
  </Routes>
</MemoryRouter>
// No URL, useful for tests
```

---

#### 3. How do you create routes?

**Basic route:**
```javascript
<Route path="/about" element={<About />} />
```

**Route with parameters:**
```javascript
<Route path="/user/:id" element={<User />} />
```

**Nested routes:**
```javascript
<Route path="/dashboard" element={<Dashboard />}>
  <Route path="profile" element={<Profile />} />
  <Route path="settings" element={<Settings />} />
</Route>
```

**Catch-all route:**
```javascript
<Route path="*" element={<NotFound />} />
```

---

#### 4. What is the difference between Route, Switch, and Routes?

| Component | Purpose | Version |
|-----------|---------|---------|
| **Route** | Define a route | All |
| **Switch** | Render first matching route | v5 |
| **Routes** | Render first matching route | v6+ |

**Switch (v5):**
```javascript
<Switch>
  <Route path="/about" component={About} />
  <Route path="/contact" component={Contact} />
  <Route component={NotFound} />
</Switch>
```

**Routes (v6+, modern):**
```javascript
<Routes>
  <Route path="/about" element={<About />} />
  <Route path="/contact" element={<Contact />} />
  <Route path="*" element={<NotFound />} />
</Routes>
```

---

#### 5. How do you navigate between routes?

**Using Link component:**
```javascript
import { Link } from 'react-router-dom';

function Navigation() {
  return (
    <nav>
      <Link to="/">Home</Link>
      <Link to="/about">About</Link>
    </nav>
  );
}
```

**Using NavLink (active styling):**
```javascript
import { NavLink } from 'react-router-dom';

<NavLink to="/about" className={({ isActive }) => isActive ? 'active' : ''}>
  About
</NavLink>
```

**Using useNavigate hook:**
```javascript
import { useNavigate } from 'react-router-dom';

function Component() {
  const navigate = useNavigate();
  
  return (
    <button onClick={() => navigate('/about')}>
      Go to About
    </button>
  );
}
```

---

## 36. Advanced Routing

#### 1. How do you handle nested routes?

**Nested routes structure:**
```javascript
<Routes>
  <Route path="/dashboard" element={<Dashboard />}>
    <Route path="profile" element={<Profile />} />
    <Route path="settings" element={<Settings />} />
  </Route>
</Routes>
```

**Dashboard component with Outlet:**
```javascript
import { Outlet } from 'react-router-dom';

function Dashboard() {
  return (
    <div>
      <h1>Dashboard</h1>
      <Outlet /> {/* Renders nested route */}
    </div>
  );
}
```

---

#### 2. What are route parameters and how do you use them?

**Define route with parameter:**
```javascript
<Route path="/user/:id" element={<User />} />
```

**Access parameter:**
```javascript
import { useParams } from 'react-router-dom';

function User() {
  const { id } = useParams();
  return <div>User ID: {id}</div>;
}
```

**Multiple parameters:**
```javascript
<Route path="/user/:userId/post/:postId" element={<Post />} />

function Post() {
  const { userId, postId } = useParams();
  return <div>User {userId}, Post {postId}</div>;
}
```

---

#### 3. How do you implement protected routes?

**Protected route component:**
```javascript
function ProtectedRoute({ children }) {
  const { isAuthenticated } = useAuth();
  
  if (!isAuthenticated) {
    return <Navigate to="/login" />;
  }
  
  return children;
}
```

**Using protected route:**
```javascript
<Routes>
  <Route path="/login" element={<Login />} />
  <Route 
    path="/dashboard" 
    element={
      <ProtectedRoute>
        <Dashboard />
      </ProtectedRoute>
    } 
  />
</Routes>
```

---

#### 4. What is programmatic navigation?

Programmatic navigation is navigating without user clicking a link.

**Using useNavigate:**
```javascript
function LoginForm() {
  const navigate = useNavigate();
  
  const handleSubmit = async (credentials) => {
    const response = await login(credentials);
    if (response.success) {
      navigate('/dashboard'); // Programmatic navigation
    }
  };
  
  return <form onSubmit={handleSubmit}>...</form>;
}
```

**With state:**
```javascript
navigate('/dashboard', { state: { from: 'login' } });
```

---

#### 5. How do you handle 404 pages?

**Catch-all route:**
```javascript
<Routes>
  <Route path="/" element={<Home />} />
  <Route path="/about" element={<About />} />
  <Route path="*" element={<NotFound />} />
</Routes>
```

**NotFound component:**
```javascript
function NotFound() {
  return (
    <div>
      <h1>404 - Page Not Found</h1>
      <Link to="/">Go Home</Link>
    </div>
  );
}
```

---

## 37. Navigation & Guards

#### 1. How do you implement route guards?

**Authentication guard:**
```javascript
function ProtectedRoute({ children }) {
  const { user } = useAuth();
  
  if (!user) {
    return <Navigate to="/login" />;
  }
  
  return children;
}
```

**Role-based guard:**
```javascript
function AdminRoute({ children }) {
  const { user } = useAuth();
  
  if (user?.role !== 'admin') {
    return <Navigate to="/" />;
  }
  
  return children;
}
```

**Permission guard:**
```javascript
function PermissionRoute({ children, permission }) {
  const { user } = useAuth();
  
  if (!user?.permissions.includes(permission)) {
    return <Navigate to="/unauthorized" />;
  }
  
  return children;
}
```

---

#### 2. What is navigation blocking?

Navigation blocking prevents users from leaving a page without confirmation.

**Using useBlocker (experimental):**
```javascript
function Form() {
  const [isDirty, setIsDirty] = useState(false);
  
  useEffect(() => {
    if (isDirty) {
      window.onbeforeunload = () => true;
    }
    return () => {
      window.onbeforeunload = null;
    };
  }, [isDirty]);
  
  return <form>...</form>;
}
```

---

#### 3. How do you handle authentication with routing?

**Auth context:**
```javascript
const AuthContext = createContext();

function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    checkAuth().then(setUser).finally(() => setLoading(false));
  }, []);
  
  return (
    <AuthContext.Provider value={{ user, loading }}>
      {children}
    </AuthContext.Provider>
  );
}
```

**Protected routes:**
```javascript
function App() {
  const { user, loading } = useContext(AuthContext);
  
  if (loading) return <LoadingSpinner />;
  
  return (
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route 
        path="/dashboard" 
        element={user ? <Dashboard /> : <Navigate to="/login" />} 
      />
    </Routes>
  );
}
```

---

## 38. Styling Approaches

#### 1. What are the different ways to style React components?

**Inline styles:**
```javascript
const styles = { color: 'red', fontSize: '16px' };
<div style={styles}>Styled</div>
```

**CSS classes:**
```javascript
<div className="container">Styled</div>
```

**CSS Modules:**
```javascript
import styles from './Component.module.css';
<div className={styles.container}>Styled</div>
```

**CSS-in-JS (styled-components):**
```javascript
const StyledDiv = styled.div`
  color: red;
  font-size: 16px;
`;
<StyledDiv>Styled</StyledDiv>
```

**Sass/SCSS:**
```javascript
import './styles.scss';
<div className="container">Styled</div>
```

---

#### 2. What is CSS-in-JS?

CSS-in-JS is writing CSS directly in JavaScript. Styles are scoped to components.

**Benefits:**
- Component-scoped styles
- Dynamic styling
- No naming conflicts
- Easier maintenance

**Popular libraries:**
- styled-components
- Emotion
- Tailwind CSS

---

#### 3. What are CSS Modules?

CSS Modules are CSS files with locally scoped class names.

**CSS Module file (Button.module.css):**
```css
.button {
  background-color: blue;
  color: white;
  padding: 10px;
}

.primary {
  background-color: darkblue;
}
```

**Using CSS Module:**
```javascript
import styles from './Button.module.css';

function Button() {
  return <button className={styles.button}>Click</button>;
}
```

**Benefits:**
- Locally scoped styles
- No naming conflicts
- Easy to maintain

---

#### 4. How do you use Sass/SCSS with React?

**Install Sass:**
```bash
npm install sass
```

**Create SCSS file (styles.scss):**
```scss
$primary-color: blue;

.container {
  background-color: $primary-color;
  
  &:hover {
    background-color: darken($primary-color, 10%);
  }
}
```

**Import in component:**
```javascript
import './styles.scss';

function Component() {
  return <div className="container">Styled</div>;
}
```

---

#### 5. What are styled-components?

styled-components is a CSS-in-JS library for styling React components.

**Basic usage:**
```javascript
import styled from 'styled-components';

const Button = styled.button`
  background-color: blue;
  color: white;
  padding: 10px;
  
  &:hover {
    background-color: darkblue;
  }
`;

function Component() {
  return <Button>Click me</Button>;
}
```

**With props:**
```javascript
const Button = styled.button`
  background-color: ${props => props.primary ? 'blue' : 'gray'};
  color: white;
`;

<Button primary>Primary</Button>
<Button>Secondary</Button>
```

---

## 39. CSS-in-JS

#### 1. What are the benefits of CSS-in-JS?

**Benefit 1: Scoped styles**
- No global namespace pollution
- No naming conflicts

**Benefit 2: Dynamic styling**
- Styles based on props
- Runtime style changes

**Benefit 3: Component-based**
- Styles travel with components
- Easier to maintain

**Benefit 4: Automatic vendor prefixing**
- Cross-browser compatibility

---

#### 2. How do you use styled-components?

**Basic component:**
```javascript
import styled from 'styled-components';

const Container = styled.div`
  max-width: 1200px;
  margin: 0 auto;
`;

const Title = styled.h1`
  font-size: 32px;
  color: #333;
`;

function App() {
  return (
    <Container>
      <Title>Hello</Title>
    </Container>
  );
}
```

**With props:**
```javascript
const Button = styled.button`
  background-color: ${props => props.primary ? 'blue' : 'gray'};
  padding: ${props => props.size === 'large' ? '20px' : '10px'};
`;

<Button primary size="large">Click</Button>
```

**Extending styles:**
```javascript
const BaseButton = styled.button`
  padding: 10px;
  border: none;
`;

const PrimaryButton = styled(BaseButton)`
  background-color: blue;
  color: white;
`;
```

---

#### 3. What is Emotion and how does it compare to styled-components?

| Feature | Emotion | styled-components |
|---------|---------|------------------|
| **Bundle Size** | Smaller | Larger |
| **Performance** | Faster | Good |
| **API** | Flexible | Opinionated |
| **CSS Prop** | Yes | No |
| **Popularity** | Growing | Most popular |

**Emotion example:**
```javascript
import { css } from '@emotion/react';
import styled from '@emotion/styled';

const buttonStyles = css`
  background-color: blue;
  color: white;
`;

const Button = styled.button`
  padding: 10px;
  ${buttonStyles}
`;
```

---

#### 4. How do you handle theming with CSS-in-JS?

**Theme provider:**
```javascript
import { ThemeProvider } from 'styled-components';

const theme = {
  colors: {
    primary: 'blue',
    secondary: 'gray'
  },
  fonts: {
    main: 'Arial'
  }
};

function App() {
  return (
    <ThemeProvider theme={theme}>
      <Component />
    </ThemeProvider>
  );
}
```

**Using theme in component:**
```javascript
const Button = styled.button`
  background-color: ${props => props.theme.colors.primary};
  font-family: ${props => props.theme.fonts.main};
`;
```

---

## 40. CSS Modules

#### 1. What are CSS Modules?

CSS Modules are CSS files where class names are locally scoped by default.

**Benefits:**
- Locally scoped styles
- No naming conflicts
- Explicit dependencies
- Easy to maintain

---

#### 2. How do CSS Modules work?

**CSS Module (Button.module.css):**
```css
.button {
  background-color: blue;
  color: white;
  padding: 10px;
}
```

**Component:**
```javascript
import styles from './Button.module.css';

function Button() {
  return <button className={styles.button}>Click</button>;
}
```

**Compiled to:**
```javascript
// Unique class name generated
<button className="Button_button__a1b2c">Click</button>
```

---

#### 3. What are the advantages of CSS Modules?

**Advantage 1: No naming conflicts**
- Each module has its own namespace
- Safe to reuse class names

**Advantage 2: Explicit dependencies**
- CSS is imported like JavaScript
- Clear what styles are used

**Advantage 3: Easy to maintain**
- Styles are colocated with components
- Easy to delete unused styles

**Advantage 4: Composition**
```css
.button {
  padding: 10px;
}

.primary {
  composes: button;
  background-color: blue;
}
```

---

## 41. Testing Fundamentals

#### 1. Why is testing important in React?

**Reasons:**
- Catch bugs early
- Prevent regressions
- Document behavior
- Improve code quality
- Increase confidence

---

#### 2. What are the different types of testing for React applications?

**Unit tests:** Test individual components
```javascript
test('Button renders with label', () => {
  render(<Button label="Click" />);
  expect(screen.getByText('Click')).toBeInTheDocument();
});
```

**Integration tests:** Test multiple components together
```javascript
test('Form submission works', () => {
  render(<LoginForm />);
  fireEvent.change(screen.getByLabelText('Email'), { target: { value: 'test@example.com' } });
  fireEvent.click(screen.getByText('Submit'));
  expect(screen.getByText('Success')).toBeInTheDocument();
});
```

**E2E tests:** Test entire user flows
```javascript
test('User can login and view dashboard', () => {
  cy.visit('/login');
  cy.get('input[name="email"]').type('test@example.com');
  cy.get('button').click();
  cy.url().should('include', '/dashboard');
});
```

---

#### 3. What is the testing pyramid?

The testing pyramid shows the ideal distribution of tests:

```
        E2E Tests (few)
       /              \
      /                \
   Integration Tests (some)
   /                      \
  /                        \
Unit Tests (many)
```

**Ratio:**
- 70% unit tests
- 20% integration tests
- 10% E2E tests

---

## 42. Testing Tools

#### 1. What are Jest and React Testing Library?

**Jest:** JavaScript testing framework
- Fast test runner
- Built-in assertions
- Snapshot testing
- Mock support

**React Testing Library:** Testing utilities for React
- Query DOM like users do
- Encourages testing behavior, not implementation
- Accessible by default

---

#### 2. How do you test React components?

**Basic test:**
```javascript
import { render, screen } from '@testing-library/react';
import Button from './Button';

test('Button renders with text', () => {
  render(<Button>Click me</Button>);
  expect(screen.getByText('Click me')).toBeInTheDocument();
});
```

**Testing user interactions:**
```javascript
import { render, screen, fireEvent } from '@testing-library/react';

test('Button click handler is called', () => {
  const handleClick = jest.fn();
  render(<Button onClick={handleClick}>Click</Button>);
  fireEvent.click(screen.getByText('Click'));
  expect(handleClick).toHaveBeenCalled();
});
```

---

#### 3. What is Enzyme and how does it compare to React Testing Library?

| Feature | Enzyme | React Testing Library |
|---------|--------|----------------------|
| **Approach** | Implementation details | User behavior |
| **API** | Shallow, mount, render | render, screen |
| **Learning Curve** | Steep | Easy |
| **Best For** | Unit tests | Integration tests |
| **Modern** | Legacy | Modern |

**Enzyme (implementation-focused):**
```javascript
const wrapper = shallow(<Button />);
expect(wrapper.find('button')).toHaveLength(1);
```

**React Testing Library (behavior-focused):**
```javascript
render(<Button />);
expect(screen.getByRole('button')).toBeInTheDocument();
```

---

#### 4. How do you test hooks?

**Using renderHook:**
```javascript
import { renderHook, act } from '@testing-library/react';
import useCounter from './useCounter';

test('useCounter increments', () => {
  const { result } = renderHook(() => useCounter());
  
  act(() => {
    result.current.increment();
  });
  
  expect(result.current.count).toBe(1);
});
```

---

#### 5. How do you test async operations?

**Testing async data fetching:**
```javascript
test('Component fetches and displays data', async () => {
  render(<UserProfile userId="1" />);
  
  expect(screen.getByText('Loading...')).toBeInTheDocument();
  
  const user = await screen.findByText('John Doe');
  expect(user).toBeInTheDocument();
});
```

**Mocking fetch:**
```javascript
global.fetch = jest.fn(() =>
  Promise.resolve({
    json: () => Promise.resolve({ name: 'John' })
  })
);
```

---

## 43. Testing Strategies

#### 1. What are the best practices for testing React applications?

**Best practice 1: Test behavior, not implementation**
```javascript
// WRONG - testing implementation
expect(component.state.count).toBe(1);

// CORRECT - testing behavior
expect(screen.getByText('Count: 1')).toBeInTheDocument();
```

**Best practice 2: Use semantic queries**
```javascript
// WRONG
screen.getByTestId('submit-button');

// CORRECT
screen.getByRole('button', { name: /submit/i });
```

**Best practice 3: Test user interactions**
```javascript
fireEvent.click(screen.getByRole('button'));
userEvent.type(screen.getByRole('textbox'), 'text');
```

---

#### 2. How do you test user interactions?

**Using fireEvent:**
```javascript
fireEvent.click(button);
fireEvent.change(input, { target: { value: 'text' } });
fireEvent.submit(form);
```

**Using userEvent (recommended):**
```javascript
import userEvent from '@testing-library/user-event';

await userEvent.click(button);
await userEvent.type(input, 'text');
```

---

#### 3. How do you mock API calls in tests?

**Using jest.mock:**
```javascript
jest.mock('./api', () => ({
  fetchUser: jest.fn(() => Promise.resolve({ name: 'John' }))
}));
```

**Using MSW (Mock Service Worker):**
```javascript
import { rest } from 'msw';
import { setupServer } from 'msw/node';

const server = setupServer(
  rest.get('/api/user', (req, res, ctx) => {
    return res(ctx.json({ name: 'John' }));
  })
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());
```

---

#### 4. What is snapshot testing and when should you use it?

Snapshot testing captures the rendered output and compares it to future renders.

**Example:**
```javascript
test('Component renders correctly', () => {
  const { container } = render(<Component />);
  expect(container).toMatchSnapshot();
});
```

**When to use:**
- Testing UI structure
- Catching unintended changes
- Regression testing

**When NOT to use:**
- Frequently changing components
- Complex components
- As the only test

---

## 44. Design Patterns

#### 1. What are common React design patterns?

**Patterns:**
- Container/Presenter
- Provider
- Compound Components
- Render Props
- Higher-Order Components
- Custom Hooks

---

#### 2. What is the container/presenter pattern?

Container component handles logic, presenter component handles UI.

**Container (logic):**
```javascript
function UserContainer() {
  const [user, setUser] = useState(null);
  
  useEffect(() => {
    fetchUser().then(setUser);
  }, []);
  
  return <UserPresenter user={user} />;
}
```

**Presenter (UI):**
```javascript
function UserPresenter({ user }) {
  return <div>{user?.name}</div>;
}
```

---

#### 3. What is the provider pattern?

Provider pattern wraps components with context/state.

**Example:**
```javascript
function ThemeProvider({ children }) {
  const [theme, setTheme] = useState('light');
  
  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}

function App() {
  return (
    <ThemeProvider>
      <Header />
      <Main />
    </ThemeProvider>
  );
}
```

---

#### 4. What are compound components?

Compound components are components that work together to form a complete UI.

**Example:**
```javascript
function Tabs({ children }) {
  const [activeTab, setActiveTab] = useState(0);
  
  return (
    <div>
      {React.Children.map(children, (child, index) =>
        React.cloneElement(child, { isActive: index === activeTab })
      )}
    </div>
  );
}

function Tab({ isActive, children }) {
  return isActive ? <div>{children}</div> : null;
}

// Usage
<Tabs>
  <Tab>Tab 1</Tab>
  <Tab>Tab 2</Tab>
</Tabs>
```

---

#### 5. What is the render props pattern?

Render props is a pattern where a component accepts a function as a prop.

**Example:**
```javascript
function DataProvider({ render }) {
  const [data, setData] = useState(null);
  
  useEffect(() => {
    fetchData().then(setData);
  }, []);
  
  return render(data);
}

// Usage
<DataProvider render={(data) => <div>{data}</div>} />
```

---

## 45. Project Structure

#### 1. How do you structure a large React application?

**Feature-based structure:**
```
src/
  features/
    auth/
      components/
      hooks/
      services/
      types/
    dashboard/
      components/
      hooks/
      services/
    users/
      components/
      hooks/
      services/
  shared/
    components/
    hooks/
    utils/
  App.jsx
  main.jsx
```

**Type-based structure:**
```
src/
  components/
    Button/
    Card/
    Header/
  pages/
    Home/
    About/
    Dashboard/
  hooks/
  services/
  utils/
  types/
  App.jsx
  main.jsx
```

---

#### 2. What are the different ways to organize React projects?

**Approach 1: Feature-based (recommended for large apps)**
- Organize by feature/domain
- Each feature is self-contained
- Easier to scale
- Better for team collaboration

**Approach 2: Type-based**
- Organize by file type
- All components together
- Good for small apps
- Harder to scale

**Approach 3: Layered**
- Separate by layers (presentation, business, data)
- Clear separation of concerns
- Good for complex apps

---

#### 3. How do you decide between feature-based and type-based organization?

**Use feature-based when:**
- Large application (100+ components)
- Multiple teams working on different features
- Features are independent
- Long-term maintenance is important

**Use type-based when:**
- Small application (< 20 components)
- Single developer or small team
- Simple structure needed
- Quick prototyping

**Hybrid approach:**
```
src/
  features/
    auth/
      components/
      hooks/
      services/
  shared/
    components/
    hooks/
    utils/
```

---


---

## 46. Best Practices

#### 1. What are React best practices?

**Best practice 1: Use functional components with hooks**
```javascript
// GOOD
function Counter() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(count + 1)}>{count}</button>;
}

// AVOID
class Counter extends React.Component {
  state = { count: 0 };
  render() {
    return <button onClick={() => this.setState({ count: this.state.count + 1 })}>{this.state.count}</button>;
  }
}
```

**Best practice 2: Keep components small and focused**
```javascript
// GOOD - single responsibility
function UserCard({ user }) {
  return <div>{user.name}</div>;
}

// AVOID - too many responsibilities
function UserCard({ user, onDelete, onEdit, onBlock }) {
  // Too much logic
}
```

**Best practice 3: Lift state up when needed**
```javascript
// GOOD - shared state in parent
function Parent() {
  const [count, setCount] = useState(0);
  return (
    <>
      <Child1 count={count} setCount={setCount} />
      <Child2 count={count} />
    </>
  );
}
```

**Best practice 4: Use keys in lists**
```javascript
// GOOD
{items.map(item => <Item key={item.id} item={item} />)}

// AVOID
{items.map((item, index) => <Item key={index} item={item} />)}
```

**Best practice 5: Memoize expensive computations**
```javascript
const expensiveValue = useMemo(() => {
  return complexCalculation(data);
}, [data]);
```

---

#### 2. How do you optimize React application performance?

**Optimization 1: Code splitting**
```javascript
const Dashboard = React.lazy(() => import('./Dashboard'));

<Suspense fallback={<Loading />}>
  <Dashboard />
</Suspense>
```

**Optimization 2: Memoization**
```javascript
const Component = React.memo(({ prop }) => <div>{prop}</div>);
```

**Optimization 3: useCallback for callbacks**
```javascript
const handleClick = useCallback(() => {
  doSomething();
}, []);
```

**Optimization 4: useMemo for values**
```javascript
const sortedItems = useMemo(() => items.sort(), [items]);
```

**Optimization 5: Virtual lists for large lists**
```javascript
import { FixedSizeList } from 'react-window';

<FixedSizeList height={600} itemCount={1000} itemSize={35}>
  {Row}
</FixedSizeList>
```

**Optimization 6: Image optimization**
```javascript
<img src="image.jpg" loading="lazy" alt="description" />
```

---

#### 3. What are common anti-patterns in React?

**Anti-pattern 1: Mutating state directly**
```javascript
// WRONG
state.count = 5;

// CORRECT
setState({ count: 5 });
```

**Anti-pattern 2: Using index as key**
```javascript
// WRONG
{items.map((item, index) => <Item key={index} />)}

// CORRECT
{items.map(item => <Item key={item.id} />)}
```

**Anti-pattern 3: Initializing state from props**
```javascript
// WRONG
const [name, setName] = useState(props.name);

// CORRECT
const name = props.name;
```

**Anti-pattern 4: Missing dependencies in useEffect**
```javascript
// WRONG
useEffect(() => {
  console.log(count);
}, []); // count is missing

// CORRECT
useEffect(() => {
  console.log(count);
}, [count]);
```

**Anti-pattern 5: Inline object/function props**
```javascript
// WRONG - new object every render
<Component style={{ color: 'red' }} />

// CORRECT
const style = { color: 'red' };
<Component style={style} />
```

---

#### 4. How do you write clean React code?

**Clean code 1: Meaningful names**
```javascript
// GOOD
const isUserAuthenticated = true;
const handleFormSubmit = () => {};

// AVOID
const x = true;
const fn = () => {};
```

**Clean code 2: Single responsibility**
```javascript
// GOOD - each function does one thing
function validateEmail(email) { /* ... */ }
function formatDate(date) { /* ... */ }

// AVOID - multiple responsibilities
function processUserData(user) { /* validate, format, save */ }
```

**Clean code 3: DRY (Don't Repeat Yourself)**
```javascript
// GOOD - reusable hook
function useFormInput(initialValue) {
  const [value, setValue] = useState(initialValue);
  return { value, onChange: (e) => setValue(e.target.value) };
}

// AVOID - repeated code
const [name, setName] = useState('');
const [email, setEmail] = useState('');
```

**Clean code 4: Comments for why, not what**
```javascript
// GOOD - explains why
// We use debouncing to prevent excessive API calls
const debouncedSearch = useCallback(debounce(search, 300), []);

// AVOID - obvious from code
// Set count to 0
setCount(0);
```

---

## 47. SSR Basics

#### 1. What is Server-Side Rendering?

Server-Side Rendering (SSR) is rendering React components on the server and sending HTML to the client.

**How it works:**
1. Client requests page
2. Server renders React component to HTML
3. Server sends HTML to client
4. Client receives fully rendered HTML
5. React hydrates the page (attaches event listeners)

---

#### 2. What are the benefits of SSR?

**Benefit 1: Better SEO**
- Search engines see fully rendered HTML
- Better indexing

**Benefit 2: Faster initial page load**
- HTML is sent immediately
- No waiting for JavaScript to load and execute

**Benefit 3: Better performance on slow networks**
- Less JavaScript to download
- Faster time to interactive

**Benefit 4: Better user experience**
- Content visible immediately
- No blank page

---

#### 3. How do you implement SSR in React?

**Basic SSR setup:**
```javascript
// server.js
import express from 'express';
import React from 'react';
import ReactDOMServer from 'react-dom/server';
import App from './App';

const app = express();

app.get('/', (req, res) => {
  const html = ReactDOMServer.renderToString(<App />);
  res.send(`
    <!DOCTYPE html>
    <html>
      <body>
        <div id="root">${html}</div>
        <script src="/bundle.js"></script>
      </body>
    </html>
  `);
});

app.listen(3000);
```

**Client hydration:**
```javascript
// client.js
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';

ReactDOM.hydrate(<App />, document.getElementById('root'));
```

---

#### 4. What is the difference between SSR and CSR?

| Feature | SSR | CSR |
|---------|-----|-----|
| **Rendering** | Server | Client |
| **Initial Load** | Faster | Slower |
| **SEO** | Better | Worse |
| **Server Load** | Higher | Lower |
| **Interactivity** | Slower | Faster |
| **Complexity** | Higher | Lower |

**CSR (Client-Side Rendering):**
```javascript
// Client downloads JavaScript and renders
ReactDOM.render(<App />, document.getElementById('root'));
```

**SSR (Server-Side Rendering):**
```javascript
// Server renders HTML, client hydrates
ReactDOMServer.renderToString(<App />);
```

---

## 48. Next.js

#### 1. What is Next.js and how does it relate to React?

Next.js is a React framework that provides:
- Server-side rendering
- Static site generation
- API routes
- File-based routing
- Built-in optimization

**Relationship:** Next.js is built on top of React and adds server-side capabilities.

---

#### 2. What are the key features of Next.js?

**Feature 1: File-based routing**
```
pages/
  index.js → /
  about.js → /about
  blog/[id].js → /blog/:id
```

**Feature 2: Server-side rendering**
```javascript
export async function getServerSideProps() {
  const data = await fetch('/api/data');
  return { props: { data } };
}
```

**Feature 3: Static generation**
```javascript
export async function getStaticProps() {
  const data = await fetch('/api/data');
  return { props: { data }, revalidate: 60 };
}
```

**Feature 4: API routes**
```javascript
// pages/api/users.js
export default function handler(req, res) {
  res.status(200).json({ name: 'John' });
}
```

**Feature 5: Image optimization**
```javascript
import Image from 'next/image';
<Image src="/image.jpg" width={200} height={200} />
```

---

#### 3. How does Next.js handle routing?

**File-based routing:**
```
pages/
  index.js → /
  about.js → /about
  contact.js → /contact
  blog/
    index.js → /blog
    [id].js → /blog/:id
    [...slug].js → /blog/*
```

**Dynamic routes:**
```javascript
// pages/blog/[id].js
import { useRouter } from 'next/router';

export default function Post() {
  const router = useRouter();
  const { id } = router.query;
  return <div>Post {id}</div>;
}
```

**Catch-all routes:**
```javascript
// pages/blog/[...slug].js
export default function Page() {
  const router = useRouter();
  const { slug } = router.query; // Array of segments
}
```

---

#### 4. What are getStaticProps and getServerSideProps?

**getStaticProps (Static Generation):**
```javascript
export async function getStaticProps() {
  const data = await fetch('/api/data');
  return {
    props: { data },
    revalidate: 60 // Revalidate every 60 seconds
  };
}

export default function Page({ data }) {
  return <div>{data}</div>;
}
```

**getServerSideProps (Server-Side Rendering):**
```javascript
export async function getServerSideProps() {
  const data = await fetch('/api/data');
  return { props: { data } };
}

export default function Page({ data }) {
  return <div>{data}</div>;
}
```

**Differences:**

| Feature | getStaticProps | getServerSideProps |
|---------|----------------|-------------------|
| **When** | Build time | Request time |
| **Performance** | Faster | Slower |
| **Revalidation** | ISR | Every request |
| **Use Case** | Static content | Dynamic content |

---

## 49. Data Fetching in SSR

#### 1. How do you fetch data in SSR?

**Using getServerSideProps:**
```javascript
export async function getServerSideProps(context) {
  const { id } = context.params;
  const res = await fetch(`/api/user/${id}`);
  const user = await res.json();
  
  return { props: { user } };
}

export default function User({ user }) {
  return <div>{user.name}</div>;
}
```

**Using getStaticProps with revalidation:**
```javascript
export async function getStaticProps() {
  const res = await fetch('/api/posts');
  const posts = await res.json();
  
  return {
    props: { posts },
    revalidate: 3600 // Revalidate every hour
  };
}
```

---

#### 2. What is hydration in React?

Hydration is the process of attaching event listeners and state to server-rendered HTML.

**Process:**
1. Server renders HTML
2. Client receives HTML
3. React hydrates (attaches listeners)
4. Page becomes interactive

**Example:**
```javascript
// Server renders
const html = ReactDOMServer.renderToString(<App />);

// Client hydrates
ReactDOM.hydrate(<App />, document.getElementById('root'));
```

---

#### 3. How do you handle async data fetching in SSR?

**In getServerSideProps:**
```javascript
export async function getServerSideProps() {
  try {
    const res = await fetch('/api/data');
    const data = await res.json();
    
    return { props: { data } };
  } catch (error) {
    return { notFound: true };
  }
}
```

**With error handling:**
```javascript
export async function getServerSideProps() {
  const res = await fetch('/api/data');
  
  if (!res.ok) {
    return { notFound: true };
  }
  
  const data = await res.json();
  return { props: { data } };
}
```

---

## 50. Build Tools

#### 1. What is Create React App?

Create React App (CRA) is a tool for creating React applications with zero configuration.

**Features:**
- No build configuration needed
- Hot module reloading
- Testing setup
- Production build optimization

**Usage:**
```bash
npx create-react-app my-app
cd my-app
npm start
```

---

#### 2. What are the alternatives to Create React App?

**Vite:**
- Faster build times
- Modern tooling
- Better performance

```bash
npm create vite@latest my-app -- --template react
```

**Next.js:**
- Full-stack framework
- SSR support
- API routes

```bash
npx create-next-app@latest
```

**Remix:**
- Modern web framework
- Server-side focus
- Better data loading

---

#### 3. How do you configure Webpack for React?

**Basic webpack config:**
```javascript
module.exports = {
  entry: './src/index.js',
  output: {
    path: __dirname + '/dist',
    filename: 'bundle.js'
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        }
      },
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader']
      }
    ]
  }
};
```

---

#### 4. What is Babel and why is it needed for React?

Babel is a JavaScript compiler that transforms modern JavaScript and JSX into browser-compatible code.

**Why needed:**
- Transforms JSX to React.createElement()
- Transpiles ES6+ to ES5
- Enables modern JavaScript features

**Babel config (.babelrc):**
```json
{
  "presets": [
    "@babel/preset-env",
    "@babel/preset-react"
  ]
}
```

---

## 51. Dev Tools

#### 1. What are React DevTools?

React DevTools is a browser extension for debugging React applications.

**Features:**
- Inspect component hierarchy
- View props and state
- Track component updates
- Profile performance

---

#### 2. How do you use React DevTools for debugging?

**Inspecting components:**
1. Open DevTools
2. Click React tab
3. Hover over components to highlight
4. View props and state in sidebar

**Profiling performance:**
1. Go to Profiler tab
2. Click record
3. Interact with app
4. View performance metrics

---

#### 3. What are the features of React DevTools?

**Feature 1: Component tree**
- View component hierarchy
- See parent-child relationships

**Feature 2: Props and state inspection**
- View current props and state
- Edit values for testing

**Feature 3: Hooks inspection**
- View hook values
- Track hook dependencies

**Feature 4: Performance profiling**
- Measure render times
- Identify slow components

---

## 52. TypeScript with React

#### 1. How do you use TypeScript with React?

**Setup with Create React App:**
```bash
npx create-react-app my-app --template typescript
```

**Basic component:**
```typescript
interface Props {
  name: string;
  age: number;
}

function User({ name, age }: Props) {
  return <div>{name} is {age}</div>;
}
```

---

#### 2. What are the benefits of using TypeScript with React?

**Benefit 1: Type safety**
- Catch errors at compile time
- Better IDE support

**Benefit 2: Better documentation**
- Types serve as documentation
- Clear component contracts

**Benefit 3: Refactoring confidence**
- Compiler catches breaking changes
- Easier to refactor

**Benefit 4: Better developer experience**
- Autocomplete
- IntelliSense

---

#### 3. How do you type props and state?

**Typing props:**
```typescript
interface ButtonProps {
  label: string;
  onClick: () => void;
  disabled?: boolean;
}

function Button({ label, onClick, disabled }: ButtonProps) {
  return <button onClick={onClick} disabled={disabled}>{label}</button>;
}
```

**Typing state:**
```typescript
interface User {
  id: number;
  name: string;
}

function UserProfile() {
  const [user, setUser] = useState<User | null>(null);
  
  return <div>{user?.name}</div>;
}
```

**Typing events:**
```typescript
function Input() {
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    console.log(e.target.value);
  };
  
  return <input onChange={handleChange} />;
}
```

---

#### 4. What are common TypeScript patterns in React?

**Pattern 1: Generic components**
```typescript
interface ListProps<T> {
  items: T[];
  renderItem: (item: T) => React.ReactNode;
}

function List<T>({ items, renderItem }: ListProps<T>) {
  return <ul>{items.map(renderItem)}</ul>;
}
```

**Pattern 2: Discriminated unions**
```typescript
type Status = 
  | { state: 'loading' }
  | { state: 'success'; data: string }
  | { state: 'error'; error: Error };

function Component({ status }: { status: Status }) {
  if (status.state === 'success') {
    return <div>{status.data}</div>;
  }
}
```

**Pattern 3: Utility types**
```typescript
interface User {
  id: number;
  name: string;
}

type ReadonlyUser = Readonly<User>;
type PartialUser = Partial<User>;
type UserKeys = keyof User;
```

---


---

## 53. Advanced Patterns

#### 1. What is the compound components pattern?

Compound components are components that work together to form a complete UI.

**Example:**
```typescript
interface TabsContextType {
  activeTab: number;
  setActiveTab: (index: number) => void;
}

const TabsContext = createContext<TabsContextType | undefined>(undefined);

function Tabs({ children }: { children: React.ReactNode }) {
  const [activeTab, setActiveTab] = useState(0);
  
  return (
    <TabsContext.Provider value={{ activeTab, setActiveTab }}>
      {children}
    </TabsContext.Provider>
  );
}

function TabList({ children }: { children: React.ReactNode }) {
  return <div className="tab-list">{children}</div>;
}

function Tab({ index, children }: { index: number; children: React.ReactNode }) {
  const context = useContext(TabsContext);
  if (!context) throw new Error('Tab must be used within Tabs');
  
  return (
    <button 
      onClick={() => context.setActiveTab(index)}
      className={context.activeTab === index ? 'active' : ''}
    >
      {children}
    </button>
  );
}

function TabPanel({ index, children }: { index: number; children: React.ReactNode }) {
  const context = useContext(TabsContext);
  if (!context) throw new Error('TabPanel must be used within Tabs');
  
  return context.activeTab === index ? <div>{children}</div> : null;
}

// Usage
<Tabs>
  <TabList>
    <Tab index={0}>Tab 1</Tab>
    <Tab index={1}>Tab 2</Tab>
  </TabList>
  <TabPanel index={0}>Content 1</TabPanel>
  <TabPanel index={1}>Content 2</TabPanel>
</Tabs>
```

---

#### 2. How do you implement state machines in React?

**Using useReducer:**
```typescript
type State = 'idle' | 'loading' | 'success' | 'error';
type Action = 
  | { type: 'FETCH' }
  | { type: 'SUCCESS'; payload: any }
  | { type: 'ERROR'; payload: Error }
  | { type: 'RESET' };

function reducer(state: State, action: Action): State {
  switch (state) {
    case 'idle':
      return action.type === 'FETCH' ? 'loading' : 'idle';
    case 'loading':
      return action.type === 'SUCCESS' ? 'success' : 
             action.type === 'ERROR' ? 'error' : 'loading';
    case 'success':
    case 'error':
      return action.type === 'RESET' ? 'idle' : state;
    default:
      return state;
  }
}

function Component() {
  const [state, dispatch] = useReducer(reducer, 'idle');
  
  const fetchData = async () => {
    dispatch({ type: 'FETCH' });
    try {
      const data = await fetch('/api/data');
      dispatch({ type: 'SUCCESS', payload: data });
    } catch (error) {
      dispatch({ type: 'ERROR', payload: error });
    }
  };
  
  return (
    <div>
      {state === 'idle' && <button onClick={fetchData}>Fetch</button>}
      {state === 'loading' && <p>Loading...</p>}
      {state === 'success' && <p>Success!</p>}
      {state === 'error' && <p>Error</p>}
    </div>
  );
}
```

---

#### 3. What is the mediator pattern in React?

The mediator pattern centralizes communication between components.

**Example:**
```typescript
interface Message {
  from: string;
  to: string;
  content: string;
}

class ChatMediator {
  private messages: Message[] = [];
  private subscribers: ((msg: Message) => void)[] = [];
  
  subscribe(callback: (msg: Message) => void) {
    this.subscribers.push(callback);
  }
  
  send(message: Message) {
    this.messages.push(message);
    this.subscribers.forEach(cb => cb(message));
  }
}

const chatMediator = new ChatMediator();

function ChatWindow() {
  const [messages, setMessages] = useState<Message[]>([]);
  
  useEffect(() => {
    chatMediator.subscribe((msg) => {
      setMessages(prev => [...prev, msg]);
    });
  }, []);
  
  return <div>{messages.map(m => <p>{m.content}</p>)}</div>;
}
```

---

#### 4. How do you handle dependency injection in React?

**Using Context:**
```typescript
interface Services {
  api: ApiService;
  logger: LoggerService;
}

const ServicesContext = createContext<Services | undefined>(undefined);

function ServicesProvider({ children }: { children: React.ReactNode }) {
  const services: Services = {
    api: new ApiService(),
    logger: new LoggerService()
  };
  
  return (
    <ServicesContext.Provider value={services}>
      {children}
    </ServicesContext.Provider>
  );
}

function useServices() {
  const context = useContext(ServicesContext);
  if (!context) throw new Error('useServices must be used within ServicesProvider');
  return context;
}

function Component() {
  const { api, logger } = useServices();
  
  useEffect(() => {
    api.fetchData().then(data => {
      logger.log('Data fetched:', data);
    });
  }, [api, logger]);
  
  return <div>Component</div>;
}
```

---

## 54. React Internals

#### 1. How does React work internally?

**React rendering process:**
1. Component renders and returns JSX
2. JSX is converted to React elements
3. React creates Virtual DOM tree
4. React compares with previous Virtual DOM (diffing)
5. React calculates minimal changes
6. React updates real DOM (reconciliation)

---

#### 2. What is the Fiber architecture?

Fiber is React's internal architecture for scheduling and rendering.

**Key concepts:**
- **Fiber:** Unit of work representing a component
- **Work loop:** Processes fibers incrementally
- **Scheduling:** Prioritizes updates
- **Interruption:** Can pause and resume work

**Benefits:**
- Incremental rendering
- Priority-based updates
- Better performance

---

#### 3. How does React schedule updates?

**Priority levels:**
1. **Immediate:** Synchronous updates
2. **User-blocking:** High priority (input, animations)
3. **Normal:** Regular updates
4. **Low:** Background updates
5. **Idle:** When browser is idle

**Scheduling:**
```javascript
// High priority
flushSync(() => setState(value));

// Normal priority
setState(value);

// Low priority
startTransition(() => setState(value));
```

---

#### 4. What is the difference between render and commit phases?

| Phase | Render | Commit |
|-------|--------|--------|
| **Purpose** | Calculate changes | Apply changes |
| **Interruptible** | Yes | No |
| **Side effects** | None | Allowed |
| **DOM updates** | No | Yes |

**Render phase:**
- Calculate Virtual DOM
- Determine changes
- Can be paused/aborted

**Commit phase:**
- Apply DOM updates
- Run lifecycle methods
- Run effects
- Cannot be interrupted

---

## 55. Concurrent Features

#### 1. What is Concurrent React?

Concurrent React allows React to interrupt rendering to handle higher-priority updates.

**Benefits:**
- Better responsiveness
- Smoother animations
- Faster interactions

---

#### 2. What are concurrent features in React 18+?

**Feature 1: startTransition**
```javascript
const [isPending, startTransition] = useTransition();

const handleSearch = (query) => {
  startTransition(() => {
    setSearchResults(query);
  });
};
```

**Feature 2: useDeferredValue**
```javascript
const deferredValue = useDeferredValue(value);
```

**Feature 3: Suspense**
```javascript
<Suspense fallback={<Loading />}>
  <Component />
</Suspense>
```

---

#### 3. What is startTransition and when would you use it?

startTransition marks updates as non-urgent.

**Use case: Search with debouncing**
```javascript
function SearchResults() {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState([]);
  const [isPending, startTransition] = useTransition();
  
  const handleChange = (e) => {
    setQuery(e.target.value);
    startTransition(() => {
      setResults(search(e.target.value));
    });
  };
  
  return (
    <>
      <input onChange={handleChange} />
      {isPending && <p>Loading...</p>}
      {results.map(r => <div key={r.id}>{r.name}</div>)}
    </>
  );
}
```

---

#### 4. What is useDeferredValue?

useDeferredValue defers updating a value until more urgent updates are done.

**Example:**
```javascript
function Component() {
  const [value, setValue] = useState('');
  const deferredValue = useDeferredValue(value);
  
  return (
    <>
      <input value={value} onChange={(e) => setValue(e.target.value)} />
      <SearchResults query={deferredValue} />
    </>
  );
}
```

---

## 56. Suspense

#### 1. What is React Suspense?

Suspense is a component that lets you specify a loading state while a component is loading.

**Syntax:**
```javascript
<Suspense fallback={<Loading />}>
  <Component />
</Suspense>
```

---

#### 2. How does Suspense work with data fetching?

**With lazy loading:**
```javascript
const Component = React.lazy(() => import('./Component'));

<Suspense fallback={<Loading />}>
  <Component />
</Suspense>
```

**With data fetching (experimental):**
```javascript
const resource = fetchData();

function Component() {
  const data = resource.read();
  return <div>{data}</div>;
}

<Suspense fallback={<Loading />}>
  <Component />
</Suspense>
```

---

#### 3. What are Suspense boundaries?

Suspense boundaries are Suspense components that catch loading states.

**Multiple boundaries:**
```javascript
<Suspense fallback={<Loading />}>
  <Header />
  <Suspense fallback={<SidebarLoading />}>
    <Sidebar />
  </Suspense>
  <Suspense fallback={<MainLoading />}>
    <Main />
  </Suspense>
</Suspense>
```

---

#### 4. How do you implement error boundaries with Suspense?

**Combined error and loading handling:**
```javascript
<ErrorBoundary>
  <Suspense fallback={<Loading />}>
    <Component />
  </Suspense>
</ErrorBoundary>
```

---

## 57. Experimental APIs

#### 1. What are server components in React?

Server components are React components that run only on the server.

**Benefits:**
- Direct database access
- Keep secrets on server
- Reduce JavaScript sent to client

**Example:**
```javascript
// app/page.js (Server Component)
async function Page() {
  const data = await db.query('SELECT * FROM posts');
  return <div>{data.map(post => <Post key={post.id} post={post} />)}</div>;
}
```

---

#### 2. How do server components work?

**Process:**
1. Server renders component
2. Sends serialized result to client
3. Client renders interactive parts
4. Combines server and client rendering

---

#### 3. What is the use hook?

The use hook is an experimental hook for reading values from promises or contexts.

**Example:**
```javascript
function Component({ promise }) {
  const data = use(promise);
  return <div>{data}</div>;
}
```

---

#### 4. What are the future directions of React?

**Future features:**
- Server components maturity
- Better async support
- Improved performance
- Enhanced developer experience
- Better error handling

---

## Bonus: Practical Scenario-Based Questions

#### How would you optimize a slow React application?

**Steps:**
1. Profile with React DevTools
2. Identify slow components
3. Use React.memo for expensive components
4. Implement code splitting
5. Use useMemo and useCallback
6. Optimize images
7. Use virtual lists for large lists
8. Implement pagination

---

#### How would you implement real-time features in React?

**Using WebSocket:**
```javascript
function RealtimeComponent() {
  const [data, setData] = useState(null);
  
  useEffect(() => {
    const ws = new WebSocket('ws://localhost:8080');
    
    ws.onmessage = (event) => {
      setData(JSON.parse(event.data));
    };
    
    return () => ws.close();
  }, []);
  
  return <div>{data}</div>;
}
```

---

#### How would you handle authentication in a React app?

**Auth context:**
```javascript
const AuthContext = createContext();

function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  
  const login = async (email, password) => {
    const response = await fetch('/api/login', {
      method: 'POST',
      body: JSON.stringify({ email, password })
    });
    const data = await response.json();
    setUser(data.user);
    localStorage.setItem('token', data.token);
  };
  
  return (
    <AuthContext.Provider value={{ user, login }}>
      {children}
    </AuthContext.Provider>
  );
}
```

---

#### How would you implement pagination/infinite scroll?

**Pagination:**
```javascript
function PaginatedList() {
  const [page, setPage] = useState(1);
  const [items, setItems] = useState([]);
  
  useEffect(() => {
    fetch(`/api/items?page=${page}`)
      .then(res => res.json())
      .then(data => setItems(data));
  }, [page]);
  
  return (
    <>
      {items.map(item => <Item key={item.id} item={item} />)}
      <button onClick={() => setPage(page + 1)}>Next</button>
    </>
  );
}
```

**Infinite scroll:**
```javascript
function InfiniteList() {
  const [items, setItems] = useState([]);
  const [page, setPage] = useState(1);
  const observerTarget = useRef(null);
  
  useEffect(() => {
    const observer = new IntersectionObserver(([entry]) => {
      if (entry.isIntersecting) {
        setPage(p => p + 1);
      }
    });
    
    if (observerTarget.current) {
      observer.observe(observerTarget.current);
    }
    
    return () => observer.disconnect();
  }, []);
  
  useEffect(() => {
    fetch(`/api/items?page=${page}`)
      .then(res => res.json())
      .then(data => setItems(prev => [...prev, ...data]));
  }, [page]);
  
  return (
    <>
      {items.map(item => <Item key={item.id} item={item} />)}
      <div ref={observerTarget} />
    </>
  );
}
```

---

#### How would you handle file uploads in React?

**File upload:**
```javascript
function FileUpload() {
  const [file, setFile] = useState(null);
  const [uploading, setUploading] = useState(false);
  
  const handleUpload = async (e) => {
    const selectedFile = e.target.files[0];
    setFile(selectedFile);
    
    const formData = new FormData();
    formData.append('file', selectedFile);
    
    setUploading(true);
    const response = await fetch('/api/upload', {
      method: 'POST',
      body: formData
    });
    setUploading(false);
    
    const data = await response.json();
    console.log('Upload complete:', data);
  };
  
  return (
    <>
      <input type="file" onChange={handleUpload} />
      {uploading && <p>Uploading...</p>}
    </>
  );
}
```

---

#### How would you implement drag-and-drop functionality?

**Drag and drop:**
```javascript
function DragDropList() {
  const [items, setItems] = useState(['Item 1', 'Item 2', 'Item 3']);
  const [draggedIndex, setDraggedIndex] = useState(null);
  
  const handleDragStart = (index) => {
    setDraggedIndex(index);
  };
  
  const handleDragOver = (e) => {
    e.preventDefault();
  };
  
  const handleDrop = (index) => {
    if (draggedIndex === null) return;
    
    const newItems = [...items];
    [newItems[draggedIndex], newItems[index]] = [newItems[index], newItems[draggedIndex]];
    setItems(newItems);
    setDraggedIndex(null);
  };
  
  return (
    <ul>
      {items.map((item, index) => (
        <li
          key={index}
          draggable
          onDragStart={() => handleDragStart(index)}
          onDragOver={handleDragOver}
          onDrop={() => handleDrop(index)}
        >
          {item}
        </li>
      ))}
    </ul>
  );
}
```

---

#### How would you handle internationalization (i18n)?

**Using i18next:**
```javascript
import i18n from 'i18next';
import { useTranslation } from 'react-i18next';

i18n.init({
  resources: {
    en: { translation: { hello: 'Hello' } },
    es: { translation: { hello: 'Hola' } }
  },
  lng: 'en'
});

function Component() {
  const { t, i18n } = useTranslation();
  
  return (
    <>
      <p>{t('hello')}</p>
      <button onClick={() => i18n.changeLanguage('es')}>
        Español
      </button>
    </>
  );
}
```

---

#### How would you implement dark mode/theme switching?

**Theme context:**
```javascript
const ThemeContext = createContext();

function ThemeProvider({ children }) {
  const [theme, setTheme] = useState('light');
  
  const toggleTheme = () => {
    setTheme(t => t === 'light' ? 'dark' : 'light');
  };
  
  return (
    <ThemeContext.Provider value={{ theme, toggleTheme }}>
      <div className={`theme-${theme}`}>
        {children}
      </div>
    </ThemeContext.Provider>
  );
}

function Component() {
  const { theme, toggleTheme } = useContext(ThemeContext);
  
  return (
    <button onClick={toggleTheme}>
      Switch to {theme === 'light' ? 'dark' : 'light'} mode
    </button>
  );
}
```

---


---

#### How would you handle form validation across multiple steps?

**Multi-step form:**
```javascript
function MultiStepForm() {
  const [step, setStep] = useState(1);
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    password: '',
    address: ''
  });
  const [errors, setErrors] = useState({});
  
  const validateStep = (currentStep) => {
    const newErrors = {};
    
    if (currentStep === 1) {
      if (!formData.name) newErrors.name = 'Name required';
      if (!formData.email) newErrors.email = 'Email required';
    } else if (currentStep === 2) {
      if (!formData.password) newErrors.password = 'Password required';
      if (formData.password?.length < 8) newErrors.password = 'Min 8 characters';
    }
    
    return newErrors;
  };
  
  const handleNext = () => {
    const newErrors = validateStep(step);
    if (Object.keys(newErrors).length === 0) {
      setStep(step + 1);
    } else {
      setErrors(newErrors);
    }
  };
  
  return (
    <div>
      {step === 1 && (
        <>
          <input value={formData.name} onChange={(e) => setFormData({...formData, name: e.target.value})} />
          {errors.name && <p>{errors.name}</p>}
        </>
      )}
      {step === 2 && (
        <>
          <input type="password" value={formData.password} onChange={(e) => setFormData({...formData, password: e.target.value})} />
          {errors.password && <p>{errors.password}</p>}
        </>
      )}
      <button onClick={handleNext}>Next</button>
    </div>
  );
}
```

---

#### How would you implement undo/redo functionality?

**Undo/Redo with history:**
```javascript
function useHistory(initialState) {
  const [state, setState] = useState(initialState);
  const [history, setHistory] = useState([initialState]);
  const [historyStep, setHistoryStep] = useState(0);
  
  const updateState = (newState) => {
    const newHistory = history.slice(0, historyStep + 1);
    newHistory.push(newState);
    setHistory(newHistory);
    setHistoryStep(newHistory.length - 1);
    setState(newState);
  };
  
  const undo = () => {
    if (historyStep > 0) {
      const newStep = historyStep - 1;
      setHistoryStep(newStep);
      setState(history[newStep]);
    }
  };
  
  const redo = () => {
    if (historyStep < history.length - 1) {
      const newStep = historyStep + 1;
      setHistoryStep(newStep);
      setState(history[newStep]);
    }
  };
  
  return { state, updateState, undo, redo };
}

function Editor() {
  const { state, updateState, undo, redo } = useHistory('');
  
  return (
    <>
      <textarea value={state} onChange={(e) => updateState(e.target.value)} />
      <button onClick={undo}>Undo</button>
      <button onClick={redo}>Redo</button>
    </>
  );
}
```

---

#### How would you handle offline capabilities?

**Offline support with service workers:**
```javascript
function useOfflineSupport() {
  const [isOnline, setIsOnline] = useState(navigator.onLine);
  const [queue, setQueue] = useState([]);
  
  useEffect(() => {
    const handleOnline = () => setIsOnline(true);
    const handleOffline = () => setIsOnline(false);
    
    window.addEventListener('online', handleOnline);
    window.addEventListener('offline', handleOffline);
    
    return () => {
      window.removeEventListener('online', handleOnline);
      window.removeEventListener('offline', handleOffline);
    };
  }, []);
  
  const queueRequest = (request) => {
    if (!isOnline) {
      setQueue(prev => [...prev, request]);
      return;
    }
    
    executeRequest(request);
  };
  
  useEffect(() => {
    if (isOnline && queue.length > 0) {
      queue.forEach(executeRequest);
      setQueue([]);
    }
  }, [isOnline]);
  
  return { isOnline, queueRequest };
}
```

---

#### How would you implement search with debouncing?

**Debounced search:**
```javascript
function useDebounce(value, delay) {
  const [debouncedValue, setDebouncedValue] = useState(value);
  
  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value);
    }, delay);
    
    return () => clearTimeout(handler);
  }, [value, delay]);
  
  return debouncedValue;
}

function SearchComponent() {
  const [searchTerm, setSearchTerm] = useState('');
  const [results, setResults] = useState([]);
  const debouncedSearchTerm = useDebounce(searchTerm, 300);
  
  useEffect(() => {
    if (debouncedSearchTerm) {
      fetch(`/api/search?q=${debouncedSearchTerm}`)
        .then(res => res.json())
        .then(setResults);
    }
  }, [debouncedSearchTerm]);
  
  return (
    <>
      <input 
        value={searchTerm} 
        onChange={(e) => setSearchTerm(e.target.value)} 
        placeholder="Search..."
      />
      {results.map(result => <div key={result.id}>{result.name}</div>)}
    </>
  );
}
```

---

#### How would you handle WebSocket connections?

**WebSocket hook:**
```javascript
function useWebSocket(url) {
  const [data, setData] = useState(null);
  const [status, setStatus] = useState('connecting');
  
  useEffect(() => {
    const ws = new WebSocket(url);
    
    ws.onopen = () => setStatus('connected');
    ws.onmessage = (event) => setData(JSON.parse(event.data));
    ws.onerror = () => setStatus('error');
    ws.onclose = () => setStatus('disconnected');
    
    return () => ws.close();
  }, [url]);
  
  return { data, status };
}

function RealtimeComponent() {
  const { data, status } = useWebSocket('ws://localhost:8080');
  
  return (
    <div>
      <p>Status: {status}</p>
      {data && <p>Data: {JSON.stringify(data)}</p>}
    </div>
  );
}
```

---

#### How would you implement a complex dashboard with multiple widgets?

**Dashboard with widgets:**
```javascript
function Dashboard() {
  const [widgets, setWidgets] = useState([
    { id: 1, type: 'chart', title: 'Sales' },
    { id: 2, type: 'table', title: 'Users' },
    { id: 3, type: 'metric', title: 'Revenue' }
  ]);
  
  const removeWidget = (id) => {
    setWidgets(widgets.filter(w => w.id !== id));
  };
  
  const reorderWidgets = (fromIndex, toIndex) => {
    const newWidgets = [...widgets];
    [newWidgets[fromIndex], newWidgets[toIndex]] = [newWidgets[toIndex], newWidgets[fromIndex]];
    setWidgets(newWidgets);
  };
  
  return (
    <div className="dashboard">
      {widgets.map((widget, index) => (
        <Widget 
          key={widget.id} 
          widget={widget}
          onRemove={() => removeWidget(widget.id)}
          onReorder={(toIndex) => reorderWidgets(index, toIndex)}
        />
      ))}
    </div>
  );
}

function Widget({ widget, onRemove, onReorder }) {
  return (
    <div className="widget">
      <h3>{widget.title}</h3>
      <button onClick={onRemove}>Remove</button>
      {widget.type === 'chart' && <Chart />}
      {widget.type === 'table' && <Table />}
      {widget.type === 'metric' && <Metric />}
    </div>
  );
}
```

---

#### How would you handle memory leaks in React applications?

**Common memory leak patterns and fixes:**

```javascript
// LEAK 1: Event listeners not cleaned up
function Component() {
  useEffect(() => {
    const handleResize = () => console.log('resized');
    window.addEventListener('resize', handleResize);
    // LEAK: forgot to remove listener
  }, []);
}

// FIX
function Component() {
  useEffect(() => {
    const handleResize = () => console.log('resized');
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);
}

// LEAK 2: Subscriptions not unsubscribed
function Component() {
  useEffect(() => {
    const subscription = subscribe(handleUpdate);
    // LEAK: forgot to unsubscribe
  }, []);
}

// FIX
function Component() {
  useEffect(() => {
    const subscription = subscribe(handleUpdate);
    return () => subscription.unsubscribe();
  }, []);
}

// LEAK 3: Timers not cleared
function Component() {
  useEffect(() => {
    const timer = setInterval(() => {}, 1000);
    // LEAK: forgot to clear interval
  }, []);
}

// FIX
function Component() {
  useEffect(() => {
    const timer = setInterval(() => {}, 1000);
    return () => clearInterval(timer);
  }, []);
}

// LEAK 4: Async operations after unmount
function Component() {
  useEffect(() => {
    fetch('/api/data').then(setData);
    // LEAK: setData called after unmount
  }, []);
}

// FIX
function Component() {
  useEffect(() => {
    let isMounted = true;
    
    fetch('/api/data')
      .then(data => {
        if (isMounted) setData(data);
      });
    
    return () => {
      isMounted = false;
    };
  }, []);
}
```

---

## System Design Questions

#### How would you design a component library?

**Component library structure:**
```
component-library/
  src/
    components/
      Button/
        Button.tsx
        Button.stories.tsx
        Button.test.tsx
        Button.module.css
      Input/
      Card/
    hooks/
    utils/
    types/
    index.ts
  storybook/
  tests/
  package.json
```

**Key considerations:**
- Consistent API across components
- Accessibility (a11y)
- TypeScript support
- Storybook documentation
- Unit tests
- Semantic versioning
- Tree-shaking support

---

#### How would you architect a large-scale React application?

**Architecture layers:**
```
Presentation Layer (Components, Pages)
  ↓
Business Logic Layer (Hooks, Services)
  ↓
Data Layer (API, State Management)
  ↓
Infrastructure Layer (Utils, Config)
```

**Folder structure:**
```
src/
  features/
    auth/
      components/
      hooks/
      services/
      types/
      store/
    dashboard/
      components/
      hooks/
      services/
  shared/
    components/
    hooks/
    utils/
    types/
  core/
    api/
    config/
    store/
  App.tsx
  main.tsx
```

---

#### How would you design a real-time chat application in React?

**Architecture:**
```javascript
// WebSocket connection
const useChat = () => {
  const [messages, setMessages] = useState([]);
  const [users, setUsers] = useState([]);
  const ws = useRef(null);
  
  useEffect(() => {
    ws.current = new WebSocket('ws://localhost:8080');
    
    ws.current.onmessage = (event) => {
      const data = JSON.parse(event.data);
      if (data.type === 'message') {
        setMessages(prev => [...prev, data.payload]);
      } else if (data.type === 'users') {
        setUsers(data.payload);
      }
    };
    
    return () => ws.current?.close();
  }, []);
  
  const sendMessage = (text) => {
    ws.current?.send(JSON.stringify({
      type: 'message',
      payload: { text, timestamp: Date.now() }
    }));
  };
  
  return { messages, users, sendMessage };
};
```

---

#### How would you design an e-commerce platform in React?

**Key features:**
- Product catalog with filtering
- Shopping cart
- Checkout process
- Payment integration
- Order history
- User reviews

**State management:**
```javascript
// Redux store structure
{
  products: {
    items: [],
    loading: false,
    filters: {}
  },
  cart: {
    items: [],
    total: 0
  },
  user: {
    authenticated: false,
    profile: null
  },
  orders: {
    items: [],
    loading: false
  }
}
```

---

#### How would you handle micro-frontends with React?

**Micro-frontend approach:**
```javascript
// Module Federation (Webpack 5)
// Host app
const RemoteApp = React.lazy(() => import('remote-app/App'));

function HostApp() {
  return (
    <Suspense fallback={<Loading />}>
      <RemoteApp />
    </Suspense>
  );
}

// Remote app (separate build)
export default function RemoteApp() {
  return <div>Remote App</div>;
}
```

**Benefits:**
- Independent deployment
- Technology flexibility
- Team autonomy
- Scalability

---

## Behavioral & Experience Questions

#### What has been your most challenging React project and why?

**Good answer structure:**
1. Describe the project
2. Explain the challenge
3. Show your approach
4. Highlight the solution
5. Mention learnings

**Example:**
"I worked on a real-time dashboard with 100+ widgets. The challenge was performance—rendering all widgets caused significant lag. I solved this by:
- Implementing code splitting for widgets
- Using React.memo for expensive components
- Implementing virtual scrolling
- Optimizing re-renders with useCallback and useMemo

This reduced initial load time by 60% and improved responsiveness significantly."

---

#### How do you stay updated with React changes?

**Good practices:**
- Follow React blog and official documentation
- Read React RFCs (Request for Comments)
- Follow React team members on Twitter
- Participate in React community
- Contribute to open source
- Attend React conferences
- Read technical articles and tutorials
- Experiment with new features

---

#### How do you approach debugging complex React issues?

**Debugging approach:**
1. **Reproduce the issue** - Understand when it happens
2. **Isolate the problem** - Narrow down the component
3. **Use DevTools** - Inspect props, state, and renders
4. **Check console** - Look for errors and warnings
5. **Add logging** - Trace execution flow
6. **Review recent changes** - What changed before the issue?
7. **Test hypothesis** - Make targeted changes
8. **Verify fix** - Ensure it works and doesn't break other things

---

#### What React patterns do you commonly use and why?

**Common patterns:**
- **Custom hooks** - Code reuse and logic extraction
- **Context API** - Global state management
- **Compound components** - Flexible component composition
- **Render props** - Flexible data sharing
- **Container/Presenter** - Separation of concerns
- **Error boundaries** - Error handling
- **Suspense** - Loading states

---

#### How do you mentor junior developers on React best practices?

**Mentoring approach:**
1. **Lead by example** - Write clean, well-structured code
2. **Code reviews** - Provide constructive feedback
3. **Pair programming** - Work together on complex tasks
4. **Documentation** - Create guides and examples
5. **Encourage questions** - Create safe environment
6. **Share resources** - Recommend articles and courses
7. **Gradual responsibility** - Increase complexity over time
8. **Celebrate wins** - Acknowledge progress and improvements

**Key topics to teach:**
- Component design principles
- State management patterns
- Performance optimization
- Testing strategies
- Debugging techniques
- Code organization
- Best practices and anti-patterns

---

## Summary

This comprehensive React.js interview guide covers:

✓ **57 major topics** with detailed explanations
✓ **200+ interview questions** with practical answers
✓ **Code examples** for every concept
✓ **Comparison tables** for quick reference
✓ **Best practices** and anti-patterns
✓ **Practical scenarios** and real-world applications
✓ **System design** considerations
✓ **Behavioral questions** for experience assessment

**How to use this guide:**
1. Read through each section thoroughly
2. Understand the concepts, not just memorize
3. Practice coding the examples
4. Prepare your own examples from your experience
5. Review before interviews
6. Use as a reference during learning

**Good luck with your React interviews!**

---

