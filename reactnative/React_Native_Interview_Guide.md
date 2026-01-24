# React Native Interview Guide: Basic to Advanced

## Table of Contents
1. [React Native Basics](#react-native-basics)
2. [Components](#components)
3. [Navigation](#navigation)
4. [State Management](#state-management)
5. [Styling](#styling)
6. [Networking](#networking)
7. [Native Modules](#native-modules)
8. [Performance](#performance)
9. [Testing](#testing)
10. [Advanced Concepts](#advanced-concepts)

---

## REACT NATIVE BASICS

### Q1: What is React Native and what are its key features?

**Answer:**
React Native is a framework for building native mobile applications using JavaScript and React. Key features include:

- **Write once, run anywhere**: Single codebase for iOS and Android
- **Native performance**: Compiles to native code
- **Hot reloading**: See changes instantly
- **Large community**: Extensive libraries and tools
- **Code reuse**: Share code between web and mobile
- **Native modules**: Access native APIs

```javascript
// Basic React Native app
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

export default function App() {
  return (
    <View style={styles.container}>
      <Text style={styles.text}>Hello React Native</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
  text: {
    fontSize: 20,
    fontWeight: 'bold'
  }
});
```

### Q2: What is the difference between React and React Native?

**Answer:**

| Feature | React | React Native |
|---------|-------|--------------|
| Platform | Web | Mobile (iOS/Android) |
| Components | HTML elements | Native components |
| Styling | CSS | StyleSheet |
| Navigation | React Router | React Navigation |
| Performance | Browser dependent | Native performance |
| Deployment | Web server | App store |

```javascript
// React (Web)
import React from 'react';

function App() {
  return (
    <div className="container">
      <h1>Hello Web</h1>
      <button onClick={() => alert('Clicked')}>Click me</button>
    </div>
  );
}

// React Native (Mobile)
import React from 'react';
import { View, Text, Button, StyleSheet } from 'react-native';

export default function App() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Hello Mobile</Text>
      <Button title="Click me" onPress={() => alert('Clicked')} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold'
  }
});
```

### Q3: What are the core components in React Native?

**Answer:**
React Native provides core components that map to native components.

```javascript
import React from 'react';
import {
  View,
  Text,
  ScrollView,
  FlatList,
  Image,
  Button,
  TextInput,
  TouchableOpacity,
  StyleSheet
} from 'react-native';

export default function App() {
  // View - container component
  return (
    <View style={styles.container}>
      {/* Text - display text */}
      <Text style={styles.title}>React Native Components</Text>
      
      {/* ScrollView - scrollable container */}
      <ScrollView>
        <Text>Scrollable content</Text>
      </ScrollView>
      
      {/* FlatList - efficient list */}
      <FlatList
        data={[{ id: '1', title: 'Item 1' }]}
        renderItem={({ item }) => <Text>{item.title}</Text>}
        keyExtractor={(item) => item.id}
      />
      
      {/* Image - display images */}
      <Image
        source={{ uri: 'https://example.com/image.jpg' }}
        style={{ width: 200, height: 200 }}
      />
      
      {/* TextInput - input field */}
      <TextInput
        placeholder="Enter text"
        style={styles.input}
      />
      
      {/* Button - clickable button */}
      <Button title="Press me" onPress={() => alert('Pressed')} />
      
      {/* TouchableOpacity - touchable component */}
      <TouchableOpacity onPress={() => alert('Touched')}>
        <Text>Tap me</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20
  },
  input: {
    borderWidth: 1,
    borderColor: '#ccc',
    padding: 10,
    marginVertical: 10
  }
});
```

### Q4: How do you handle navigation in React Native?

**Answer:**
React Navigation is the most popular navigation library for React Native.

```javascript
import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';

const Stack = createNativeStackNavigator();
const Tab = createBottomTabNavigator();

// Stack navigation
function HomeStack() {
  return (
    <Stack.Navigator>
      <Stack.Screen name="Home" component={HomeScreen} />
      <Stack.Screen name="Details" component={DetailsScreen} />
    </Stack.Navigator>
  );
}

// Tab navigation
function TabNavigator() {
  return (
    <Tab.Navigator>
      <Tab.Screen name="Home" component={HomeScreen} />
      <Tab.Screen name="Profile" component={ProfileScreen} />
      <Tab.Screen name="Settings" component={SettingsScreen} />
    </Tab.Navigator>
  );
}

// App with navigation
export default function App() {
  return (
    <NavigationContainer>
      <TabNavigator />
    </NavigationContainer>
  );
}

// Navigation between screens
import { useNavigation } from '@react-navigation/native';
import { Button } from 'react-native';

function HomeScreen() {
  const navigation = useNavigation();
  
  return (
    <Button
      title="Go to Details"
      onPress={() => navigation.navigate('Details', { id: 1 })}
    />
  );
}

// Receiving parameters
function DetailsScreen({ route }) {
  const { id } = route.params;
  
  return <Text>Details for item {id}</Text>;
}
```

### Q5: How do you style components in React Native?

**Answer:**
React Native uses StyleSheet for styling with flexbox layout.

```javascript
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

export default function App() {
  return (
    <View style={styles.container}>
      <View style={styles.box}>
        <Text style={styles.text}>Styled Component</Text>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5f5f5'
  },
  box: {
    width: 200,
    height: 200,
    backgroundColor: '#007AFF',
    borderRadius: 10,
    padding: 20,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
    elevation: 5
  },
  text: {
    color: '#fff',
    fontSize: 18,
    fontWeight: 'bold',
    textAlign: 'center'
  }
});

// Flexbox layout
const flexStyles = StyleSheet.create({
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center'
  },
  column: {
    flexDirection: 'column',
    justifyContent: 'flex-start',
    alignItems: 'stretch'
  },
  flex1: {
    flex: 1
  },
  flex2: {
    flex: 2
  }
});

// Inline styles
function InlineStyleExample() {
  return (
    <View style={{ flex: 1, backgroundColor: 'blue' }}>
      <Text style={{ color: 'white', fontSize: 20 }}>
        Inline styled text
      </Text>
    </View>
  );
}
```



---

## STATE MANAGEMENT & HOOKS

### Q6: How do you manage state in React Native?

**Answer:**
State management in React Native uses useState and useReducer hooks.

```javascript
import React, { useState, useReducer } from 'react';
import { View, Text, Button } from 'react-native';

// useState
function Counter() {
  const [count, setCount] = useState(0);
  
  return (
    <View>
      <Text>Count: {count}</Text>
      <Button title="+" onPress={() => setCount(count + 1)} />
      <Button title="-" onPress={() => setCount(count - 1)} />
    </View>
  );
}

// useReducer for complex state
function TodoApp() {
  const [todos, dispatch] = useReducer(todoReducer, []);
  
  function todoReducer(state, action) {
    switch (action.type) {
      case 'ADD':
        return [...state, { id: Date.now(), text: action.payload }];
      case 'REMOVE':
        return state.filter(todo => todo.id !== action.payload);
      default:
        return state;
    }
  }
  
  return (
    <View>
      <Button
        title="Add Todo"
        onPress={() => dispatch({ type: 'ADD', payload: 'New Todo' })}
      />
      {todos.map(todo => (
        <View key={todo.id}>
          <Text>{todo.text}</Text>
          <Button
            title="Delete"
            onPress={() => dispatch({ type: 'REMOVE', payload: todo.id })}
          />
        </View>
      ))}
    </View>
  );
}

// Context for global state
const AppContext = React.createContext();

export function AppProvider({ children }) {
  const [user, setUser] = useState(null);
  
  return (
    <AppContext.Provider value={{ user, setUser }}>
      {children}
    </AppContext.Provider>
  );
}

export function useAppContext() {
  return React.useContext(AppContext);
}

// Using context
function UserProfile() {
  const { user } = useAppContext();
  
  return <Text>{user?.name}</Text>;
}
```

### Q7: How do you handle async operations in React Native?

**Answer:**
Async operations use async/await and useEffect.

```javascript
import React, { useState, useEffect } from 'react';
import { View, Text, ActivityIndicator } from 'react-native';

function UserData({ userId }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  useEffect(() => {
    const fetchUser = async () => {
      try {
        setLoading(true);
        const response = await fetch(`https://api.example.com/users/${userId}`);
        const data = await response.json();
        setUser(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    
    fetchUser();
  }, [userId]);
  
  if (loading) return <ActivityIndicator />;
  if (error) return <Text>Error: {error}</Text>;
  
  return <Text>{user?.name}</Text>;
}

// Fetch with timeout
function fetchWithTimeout(url, timeout = 5000) {
  return Promise.race([
    fetch(url),
    new Promise((_, reject) =>
      setTimeout(() => reject(new Error('Timeout')), timeout)
    )
  ]);
}

// Retry logic
async function fetchWithRetry(url, retries = 3) {
  for (let i = 0; i < retries; i++) {
    try {
      const response = await fetch(url);
      return response.json();
    } catch (error) {
      if (i === retries - 1) throw error;
      await new Promise(resolve => setTimeout(resolve, 1000 * (i + 1)));
    }
  }
}
```

### Q8: How do you handle permissions in React Native?

**Answer:**
Permissions are handled using react-native-permissions library.

```javascript
import { request, PERMISSIONS, RESULTS } from 'react-native-permissions';
import { Platform } from 'react-native';

// Request camera permission
async function requestCameraPermission() {
  const permission = Platform.OS === 'ios'
    ? PERMISSIONS.IOS.CAMERA
    : PERMISSIONS.ANDROID.CAMERA;
  
  const result = await request(permission);
  
  if (result === RESULTS.GRANTED) {
    console.log('Camera permission granted');
  } else {
    console.log('Camera permission denied');
  }
}

// Request multiple permissions
async function requestMultiplePermissions() {
  const permissions = Platform.OS === 'ios'
    ? [PERMISSIONS.IOS.CAMERA, PERMISSIONS.IOS.PHOTO_LIBRARY]
    : [PERMISSIONS.ANDROID.CAMERA, PERMISSIONS.ANDROID.READ_EXTERNAL_STORAGE];
  
  const results = await request(permissions);
  
  return results;
}

// Check permission status
import { check } from 'react-native-permissions';

async function checkCameraPermission() {
  const result = await check(PERMISSIONS.IOS.CAMERA);
  
  switch (result) {
    case RESULTS.GRANTED:
      console.log('Permission granted');
      break;
    case RESULTS.DENIED:
      console.log('Permission denied');
      break;
    case RESULTS.BLOCKED:
      console.log('Permission blocked');
      break;
  }
}
```

### Q9: How do you handle deep linking in React Native?

**Answer:**
Deep linking allows opening specific screens from URLs.

```javascript
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import * as Linking from 'expo-linking';

const Stack = createNativeStackNavigator();

const linking = {
  prefixes: ['myapp://', 'https://myapp.com'],
  config: {
    screens: {
      Home: '',
      Profile: 'profile/:id',
      Settings: 'settings',
      NotFound: '*'
    }
  }
};

function Navigation() {
  return (
    <NavigationContainer linking={linking}>
      <Stack.Navigator>
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Profile" component={ProfileScreen} />
        <Stack.Screen name="Settings" component={SettingsScreen} />
        <Stack.Screen name="NotFound" component={NotFoundScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

// Handle deep link in component
function ProfileScreen({ route }) {
  const { id } = route.params;
  
  return <Text>Profile ID: {id}</Text>;
}

// Open deep link programmatically
function App() {
  const handleDeepLink = async () => {
    await Linking.openURL('myapp://profile/123');
  };
  
  return <Button title="Open Profile" onPress={handleDeepLink} />;
}
```

### Q10: How do you optimize performance in React Native?

**Answer:**
Performance optimization techniques for React Native.

```javascript
import React, { useMemo, useCallback, memo } from 'react';
import { FlatList, View, Text } from 'react-native';

// Memoize components
const UserItem = memo(function UserItem({ user, onPress }) {
  return (
    <TouchableOpacity onPress={onPress}>
      <Text>{user.name}</Text>
    </TouchableOpacity>
  );
});

// Use useMemo for expensive computations
function UserList({ users }) {
  const sortedUsers = useMemo(() => {
    return users.sort((a, b) => a.name.localeCompare(b.name));
  }, [users]);
  
  return (
    <FlatList
      data={sortedUsers}
      renderItem={({ item }) => <UserItem user={item} />}
      keyExtractor={item => item.id}
    />
  );
}

// Use useCallback for callbacks
function UserListWithCallback({ users }) {
  const handlePress = useCallback((userId) => {
    console.log('User pressed:', userId);
  }, []);
  
  return (
    <FlatList
      data={users}
      renderItem={({ item }) => (
        <UserItem user={item} onPress={() => handlePress(item.id)} />
      )}
      keyExtractor={item => item.id}
    />
  );
}

// Optimize FlatList
function OptimizedList({ items }) {
  return (
    <FlatList
      data={items}
      renderItem={({ item }) => <Item item={item} />}
      keyExtractor={item => item.id}
      removeClippedSubviews={true}
      maxToRenderPerBatch={10}
      updateCellsBatchingPeriod={50}
      initialNumToRender={10}
      windowSize={10}
    />
  );
}

// Image optimization
import { Image } from 'react-native';

function OptimizedImage() {
  return (
    <Image
      source={{ uri: 'https://example.com/image.jpg' }}
      style={{ width: 200, height: 200 }}
      resizeMode="contain"
    />
  );
}

// Lazy loading
function LazyLoadedList() {
  const [items, setItems] = React.useState([]);
  const [page, setPage] = React.useState(1);
  
  const loadMore = async () => {
    const newItems = await fetchItems(page);
    setItems([...items, ...newItems]);
    setPage(page + 1);
  };
  
  return (
    <FlatList
      data={items}
      renderItem={({ item }) => <Item item={item} />}
      keyExtractor={item => item.id}
      onEndReached={loadMore}
      onEndReachedThreshold={0.5}
    />
  );
}
```

### Q11: How do you test React Native applications?

**Answer:**
Testing React Native apps using Jest and React Native Testing Library.

```javascript
import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react-native';
import { Counter } from './Counter';

// Basic test
test('renders counter', () => {
  render(<Counter />);
  expect(screen.getByText('Count: 0')).toBeTruthy();
});

// Test user interaction
test('increments counter', () => {
  render(<Counter />);
  const button = screen.getByText('+');
  fireEvent.press(button);
  expect(screen.getByText('Count: 1')).toBeTruthy();
});

// Test async operations
test('fetches user data', async () => {
  render(<UserProfile userId={1} />);
  
  await waitFor(() => {
    expect(screen.getByText('John')).toBeTruthy();
  });
});

// Mock API calls
jest.mock('react-native/Libraries/Networking/fetch', () => ({
  fetch: jest.fn(() =>
    Promise.resolve({
      json: () => Promise.resolve({ name: 'John' })
    })
  )
}));

// Snapshot testing
test('matches snapshot', () => {
  const tree = render(<Counter />).toJSON();
  expect(tree).toMatchSnapshot();
});

// Component testing
test('renders with props', () => {
  render(<UserItem user={{ id: 1, name: 'John' }} />);
  expect(screen.getByText('John')).toBeTruthy();
});
```

### Q12: How do you handle native modules in React Native?

**Answer:**
Native modules allow calling native code from JavaScript.

```javascript
// JavaScript side
import { NativeModules } from 'react-native';

const { NativeModule } = NativeModules;

// Call native method
NativeModule.nativeMethod('argument', (error, result) => {
  if (error) {
    console.error(error);
  } else {
    console.log(result);
  }
});

// Promise-based native module
NativeModule.nativePromiseMethod('argument')
  .then(result => console.log(result))
  .catch(error => console.error(error));

// Native module with events
import { NativeEventEmitter } from 'react-native';

const eventEmitter = new NativeEventEmitter(NativeModule);

const subscription = eventEmitter.addListener(
  'eventName',
  (event) => console.log(event)
);

// Cleanup
subscription.remove();

// Example: Camera native module
import { CameraRoll } from '@react-native-camera-roll/camera-roll';

async function savePhoto(photoUri) {
  try {
    const result = await CameraRoll.save(photoUri, { type: 'photo' });
    console.log('Photo saved:', result);
  } catch (error) {
    console.error('Error saving photo:', error);
  }
}
```

