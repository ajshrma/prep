# TypeScript Types and Interfaces

## Basic Types

### 1. Primitive Types

```typescript
// String
let name: string = "John";

// Number
let age: number = 25;
let price: number = 99.99;

// Boolean
let isActive: boolean = true;

// Null and Undefined
let nullValue: null = null;
let undefinedValue: undefined = undefined;

// Symbol
let sym: symbol = Symbol("key");

// BigInt
let bigNumber: bigint = 100n;
```

### 2. Array Types

```typescript
// Array of numbers
let numbers: number[] = [1, 2, 3, 4, 5];
let numbers2: Array<number> = [1, 2, 3, 4, 5];

// Array of strings
let names: string[] = ["John", "Jane", "Bob"];

// Mixed array (tuple)
let tuple: [string, number] = ["age", 25];
```

### 3. Object Types

```typescript
// Object type annotation
let person: { name: string; age: number } = {
	name: "John",
	age: 25,
};

// Optional properties
let user: { name: string; age?: number } = {
	name: "John",
};
```

## Interfaces

### 1. Basic Interface

```typescript
interface Person {
	name: string;
	age: number;
}

let employee: Person = {
	name: "John",
	age: 25,
};
```

### 2. Optional Properties

```typescript
interface User {
	name: string;
	age?: number; // Optional property
	readonly id: number; // Read-only property
}

let user: User = {
	name: "John",
	id: 1,
};
```

### 3. Method Signatures

````typescript
interface Animal {
	name: string;
	makeSound(): void;
	eat(food: string): boolean;
}

class Dog implements Animal {
	name: string;

	constructor(name: string) {
		this.name = name;
	}

	makeSound(): void {
		console.log("Woof!");
	}

	eat(food: string): boolean {
		return true;
	}
}

// In this example, the `Animal` interface defines three methods:
// - `name: string`: A required property
// - `makeSound(): void`: A method that takes no arguments and returns void
// - `eat(food: string): boolean`: A method that takes a string argument and returns a boolean

// The `Dog` class implements the `Animal` interface. It must provide implementations for all three methods:

// - The `name` property is defined in the class implementation
// - The `makeSound` method is implemented as `console.log("Woof!")`
// - The `eat` method is implemented as `return true`

// This ensures that the `Dog` class adheres to the `Animal` interface contract.

// In TypeScript, interfaces can define method signatures that specify the structure of functions that implementing classes must provide. Let's examine this example in detail:

// 1. Define the interface with method signatures
interface Animal {
	name: string;
	makeSound(): void;
	eat(food: string): boolean;
}

// 2. Implement the interface in a class
class Dog implements Animal {
	name: string;

	constructor(name: string) {
		this.name = name;
	}

	// 3. Provide implementations for the required methods
	makeSound(): void {
		console.log("Woof!");
	}

	eat(food: string): boolean {
		return true;
	}
}

// 4. Use the class that implements the interface
const dog = new Dog("Buddy");
dog.makeSound(); // Output: "Woof!"
dog.eat("bone"); // Output: true

// 5. Type checking ensures method signatures match exactly
const animal: Animal = new Dog("Buddy");
animal.makeSound(); // Output: "Woof!"
animal.eat("bone"); // Output: true

// 6. TypeScript will enforce the interface contract
const animal2: Animal = {
	name: "Buddy",
	makeSound: () => console.log("Woof!"),
	eat: (food: string) => true,
};










### 4. Interface Extension

```typescript
interface Shape {
	color: string;
}

interface Square extends Shape {
	sideLength: number;
}

let square: Square = {
	color: "blue",
	sideLength: 10,
};
````

## Type Aliases

### 1. Basic Type Alias

```typescript
type Point = {
	x: number;
	y: number;
};

let point: Point = { x: 10, y: 20 };
```

### 2. Union Types

```typescript
type ID = string | number;

let userId: ID = 123; // Valid
userId = "ABC123"; // Also valid
```

### 3. Intersection Types

```typescript
type Employee = {
	name: string;
	id: number;
};

type Manager = {
	department: string;
	level: number;
};

type ManagerWithEmployee = Employee & Manager;

let manager: ManagerWithEmployee = {
	name: "John",
	id: 1,
	department: "IT",
	level: 2,
};
```

## Advanced Types

### 1. Mapped Types

```typescript
type Optional<T> = {
	[P in keyof T]?: T[P];
};

interface User {
	name: string;
	age: number;
}

type OptionalUser = Optional<User>;
// Equivalent to: { name?: string; age?: number; }
```

### 2. Conditional Types

```typescript
type IsString<T> = T extends string ? true : false;

type Result1 = IsString<string>; // true
type Result2 = IsString<number>; // false
```

### 3. Template Literal Types

```typescript
type Color = "red" | "blue" | "green";
type Size = "small" | "medium" | "large";

type Product = `${Size}-${Color}`;
// "small-red" | "small-blue" | "small-green" | "medium-red" | etc.
```

## Best Practices

1. Always define types for variables and function parameters
2. Use interfaces for object shapes that will be implemented by classes
3. Use type aliases for unions, intersections, and simple object types
4. Make properties optional when appropriate
5. Use readonly for immutable properties
6. Use union types instead of any when possible
7. Leverage TypeScript's type inference when it makes code clearer

## Common Pitfalls to Avoid

1. Overusing the `any` type
2. Not using strict mode
3. Ignoring TypeScript errors
4. Not properly typing function parameters and return values
5. Using type assertions unnecessarily

## Exercises

1. Create an interface for a complex object with nested properties
2. Implement a class that uses multiple interfaces
3. Create a generic type that works with different data types
4. Use mapped types to transform an existing interface
5. Create a union type with discriminated unions

## Additional Resources

- [TypeScript Handbook - Basic Types](https://www.typescriptlang.org/docs/handbook/basic-types.html)
- [TypeScript Handbook - Interfaces](https://www.typescriptlang.org/docs/handbook/interfaces.html)
- [TypeScript Handbook - Advanced Types](https://www.typescriptlang.org/docs/handbook/advanced-types.html)
