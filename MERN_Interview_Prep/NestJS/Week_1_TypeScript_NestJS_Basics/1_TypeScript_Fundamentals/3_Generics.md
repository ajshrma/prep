# TypeScript Generics

## Basic Generics

### 1. Generic Functions

```typescript
// Generic function
function identity<T>(arg: T): T {
	return arg;
}

// Usage
let result1 = identity<string>("hello"); // type: string
let result2 = identity<number>(42); // type: number
let result3 = identity("world"); // type inference

// Generic arrow function
const getArray = <T>(items: T[]): T[] => {
	return new Array<T>().concat(items);
};
```

### 2. Generic Interfaces

```typescript
interface GenericIdentityFn<T> {
	(arg: T): T;
}

interface Collection<T> {
	add(item: T): void;
	remove(item: T): void;
	getItems(): T[];
}

class List<T> implements Collection<T> {
	private items: T[] = [];

	add(item: T): void {
		this.items.push(item);
	}

	remove(item: T): void {
		const index = this.items.indexOf(item);
		if (index > -1) {
			this.items.splice(index, 1);
		}
	}

	getItems(): T[] {
		return [...this.items];
	}
}
```

### 3. Generic Classes

```typescript
class GenericNumber<T> {
	zeroValue: T;
	add: (x: T, y: T) => T;

	constructor(zero: T, addFn: (x: T, y: T) => T) {
		this.zeroValue = zero;
		this.add = addFn;
	}
}

// Usage with number
let myNumberClass = new GenericNumber<number>(
	0,
	(x: number, y: number) => x + y
);

// Usage with string
let myStringClass = new GenericNumber<string>(
	"",
	(x: string, y: string) => x + y
);
```

## Generic Constraints

### 1. Using extends

```typescript
interface Lengthwise {
	length: number;
}

function loggingIdentity<T extends Lengthwise>(arg: T): T {
	console.log(arg.length); // Now we know it has a .length property
	return arg;
}

loggingIdentity("hello"); // works, string has .length
loggingIdentity([1, 2, 3]); // works, array has .length
// loggingIdentity(3);        // error, number doesn't have .length
```

### 2. Using Type Parameters

```typescript
function getProperty<T, K extends keyof T>(obj: T, key: K) {
	return obj[key];
}

let x = { a: 1, b: 2, c: 3 };

getProperty(x, "a"); // okay
getProperty(x, "b"); // okay
// getProperty(x, "z");  // error: "z" is not in "a" | "b" | "c"
```

### 3. Using Class Types

```typescript
class BeeKeeper {
	hasMask: boolean = true;
}

class ZooKeeper {
	nametag: string = "Zookeeper";
}

class Animal {
	numLegs: number = 4;
}

class Bee extends Animal {
	keeper: BeeKeeper = new BeeKeeper();
}

class Lion extends Animal {
	keeper: ZooKeeper = new ZooKeeper();
}

function createInstance<A extends Animal>(c: new () => A): A {
	return new c();
}

createInstance(Lion).keeper.nametag; // typechecks!
createInstance(Bee).keeper.hasMask; // typechecks!
```

## Advanced Generic Patterns

### 1. Generic Type Aliases

```typescript
type Container<T> = { value: T };

type Tree<T> = {
	value: T;
	left?: Tree<T>;
	right?: Tree<T>;
};

// Usage
let numberTree: Tree<number> = {
	value: 42,
	left: { value: 13 },
	right: { value: 55 },
};
```

### 2. Generic Utility Types

```typescript
// Partial
interface Todo {
	title: string;
	description: string;
}

function updateTodo(todo: Todo, fieldsToUpdate: Partial<Todo>) {
	return { ...todo, ...fieldsToUpdate };
}

// Record
type PageInfo = {
	title: string;
	url: string;
};

type Pages = Record<string, PageInfo>;

// Pick and Omit
type TodoPreview = Pick<Todo, "title">;
type TodoWithoutDescription = Omit<Todo, "description">;
```

### 3. Conditional Types with Generics

```typescript
type TypeName<T> = T extends string
	? "string"
	: T extends number
	? "number"
	: T extends boolean
	? "boolean"
	: T extends undefined
	? "undefined"
	: T extends Function
	? "function"
	: "object";

type T0 = TypeName<string>; // "string"
type T1 = TypeName<number>; // "number"
type T2 = TypeName<() => void>; // "function"
```

## Best Practices

1. Use meaningful generic type names (T for type, K for key, V for value)
2. Constrain generic types when possible
3. Use generic constraints to ensure type safety
4. Avoid overcomplicating generic types
5. Use type inference when possible
6. Document complex generic types

## Common Pitfalls to Avoid

1. Over-generalizing when specific types would work
2. Not constraining generic types appropriately
3. Creating overly complex generic type hierarchies
4. Forgetting to specify generic types when needed
5. Using any instead of proper generic constraints

## Exercises

1. Create a generic Stack class
2. Implement a generic Queue with constraints
3. Build a generic Repository pattern
4. Create a generic factory function
5. Implement a generic event system

## Additional Resources

- [TypeScript Handbook - Generics](https://www.typescriptlang.org/docs/handbook/generics.html)
- [TypeScript Deep Dive - Generics](https://basarat.gitbook.io/typescript/type-system/generics)
- [TypeScript Generics Tutorial](https://www.typescriptlang.org/docs/handbook/2/generics.html)
