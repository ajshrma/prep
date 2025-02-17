# TypeScript Utility Types

## Basic Utility Types

### 1. Partial<T>

```typescript
interface Todo {
	title: string;
	description: string;
	completed: boolean;
}

function updateTodo(todo: Todo, fieldsToUpdate: Partial<Todo>) {
	return { ...todo, ...fieldsToUpdate };
}

const todo1 = {
	title: "Learn TypeScript",
	description: "Study utility types",
	completed: false,
};

const todo2 = updateTodo(todo1, {
	description: "Master utility types",
});
```

### 2. Required<T>

```typescript
interface Props {
	name?: string;
	age?: number;
	email?: string;
}

const user: Required<Props> = {
	name: "John", // Must provide all properties
	age: 30,
	email: "john@example.com",
};
```

### 3. Readonly<T>

```typescript
interface Config {
	host: string;
	port: number;
}

const config: Readonly<Config> = {
	host: "localhost",
	port: 3000,
};

// Error: Cannot assign to 'host' because it is a read-only property
// config.host = "newhost";
```

### 4. Record<K,T>

```typescript
type PageInfo = {
	title: string;
	url: string;
};

const pages: Record<string, PageInfo> = {
	home: { title: "Home", url: "/" },
	about: { title: "About", url: "/about" },
	contact: { title: "Contact", url: "/contact" },
};
```

## Intermediate Utility Types

### 1. Pick<T,K>

```typescript
interface User {
	id: number;
	name: string;
	email: string;
	password: string;
}

type PublicUser = Pick<User, "id" | "name" | "email">;

const publicUser: PublicUser = {
	id: 1,
	name: "John",
	email: "john@example.com",
};
```

### 2. Omit<T,K>

```typescript
interface Article {
	title: string;
	content: string;
	author: string;
	createdAt: Date;
	updatedAt: Date;
}

type ArticlePreview = Omit<Article, "content" | "updatedAt">;

const preview: ArticlePreview = {
	title: "TypeScript Tips",
	author: "John Doe",
	createdAt: new Date(),
};
```

### 3. Exclude<T,U>

```typescript
type T0 = Exclude<"a" | "b" | "c", "a">; // "b" | "c"
type T1 = Exclude<string | number | (() => void), Function>; // string | number

type Shape = "circle" | "square" | "rectangle" | "triangle";
type BasicShape = Exclude<Shape, "rectangle" | "triangle">; // "circle" | "square"
```

### 4. Extract<T,U>

```typescript
type T2 = Extract<"a" | "b" | "c", "a" | "f">; // "a"
type T3 = Extract<string | number | (() => void), Function>; // () => void

type Shape = "circle" | "square" | "rectangle" | "triangle";
type RoundedShape = Extract<Shape, "circle">; // "circle"
```

## Advanced Utility Types

### 1. NonNullable<T>

```typescript
type T4 = NonNullable<string | number | undefined | null>; // string | number

function processValue<T>(value: NonNullable<T>) {
	// Process value knowing it's not null or undefined
}
```

### 2. ReturnType<T>

```typescript
function createUser(name: string, age: number) {
	return { name, age, createdAt: new Date() };
}

type User = ReturnType<typeof createUser>;

const user: User = {
	name: "John",
	age: 30,
	createdAt: new Date(),
};
```

### 3. Parameters<T>

```typescript
function fetchData(url: string, method: "GET" | "POST", body?: object) {
	// Implementation
}

type FetchParams = Parameters<typeof fetchData>;
// [url: string, method: "GET" | "POST", body?: object | undefined]
```

### 4. InstanceType<T>

```typescript
class HttpClient {
	constructor(public baseURL: string) {}
	get(path: string) {
		/* Implementation */
	}
}

type Client = InstanceType<typeof HttpClient>;

const client: Client = new HttpClient("https://api.example.com");
```

## Best Practices

1. Use utility types to avoid code duplication
2. Combine utility types for complex transformations
3. Use type inference with utility types when possible
4. Document complex utility type usage
5. Consider performance implications of deep utility types
6. Use meaningful names for derived types
7. Test utility type implementations

## Common Pitfalls to Avoid

1. Overcomplicating type transformations
2. Not considering null/undefined cases
3. Creating deeply nested utility types
4. Using utility types when simple interfaces would suffice
5. Not handling edge cases

## Exercises

1. Create a deep partial utility type
2. Implement a type-safe form state management system
3. Build a configuration validation system
4. Create a type-safe API response handler
5. Implement a state management store with utility types

## Additional Resources

- [TypeScript Handbook - Utility Types](https://www.typescriptlang.org/docs/handbook/utility-types.html)
- [TypeScript Deep Dive - Utility Types](https://basarat.gitbook.io/typescript/type-system/utility-types)
- [Advanced TypeScript Tips](https://www.typescriptlang.org/docs/handbook/advanced-types.html)
