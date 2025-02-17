# TypeScript Classes and Inheritance

## Class Basics

### 1. Class Declaration

```typescript
class Person {
	// Properties
	name: string;
	age: number;

	// Constructor
	constructor(name: string, age: number) {
		this.name = name;
		this.age = age;
	}

	// Method
	greet() {
		return `Hello, my name is ${this.name}`;
	}
}

// Creating an instance
const person = new Person("John", 30);
console.log(person.greet()); // "Hello, my name is John"
```

### 2. Access Modifiers

```typescript
class Employee {
	// Public - accessible everywhere (default)
	public name: string;

	// Private - only accessible within the class
	private salary: number;

	// Protected - accessible within class and subclasses
	protected department: string;

	constructor(name: string, salary: number, department: string) {
		this.name = name;
		this.salary = salary;
		this.department = department;
	}

	// Private method
	private calculateBonus(): number {
		return this.salary * 0.1;
	}

	// Public method accessing private member
	public getAnnualSalary(): number {
		return this.salary * 12 + this.calculateBonus();
	}
}
```

### 3. Readonly Properties

```typescript
class Config {
	readonly apiKey: string;
	readonly maxRetries: number = 3;

	constructor(key: string) {
		this.apiKey = key;
		// After initialization, apiKey cannot be changed
	}
}
```

## Inheritance

### 1. Basic Inheritance

```typescript
class Animal {
	name: string;

	constructor(name: string) {
		this.name = name;
	}

	makeSound(): void {
		console.log("Some sound");
	}
}

class Dog extends Animal {
	breed: string;

	constructor(name: string, breed: string) {
		super(name); // Call parent constructor
		this.breed = breed;
	}

	makeSound(): void {
		console.log("Woof!");
	}
}

const dog = new Dog("Rex", "German Shepherd");
dog.makeSound(); // "Woof!"
```

### 2. Abstract Classes

```typescript
abstract class Shape {
	color: string;

	constructor(color: string) {
		this.color = color;
	}

	abstract calculateArea(): number;

	displayColor(): void {
		console.log(`This shape is ${this.color}`);
	}
}

class Circle extends Shape {
	radius: number;

	constructor(color: string, radius: number) {
		super(color);
		this.radius = radius;
	}

	calculateArea(): number {
		return Math.PI * this.radius ** 2;
	}
}
```

### 3. Interface Implementation

```typescript
interface Printable {
	print(): void;
}

interface Loggable {
	log(): void;
}

class Document implements Printable, Loggable {
	content: string;

	constructor(content: string) {
		this.content = content;
	}

	print(): void {
		console.log(`Printing: ${this.content}`);
	}

	log(): void {
		console.log(`Logging: ${this.content}`);
	}
}
```

## Advanced Class Features

### 1. Static Members

```typescript
class MathOperations {
	static PI: number = 3.14159;

	static add(x: number, y: number): number {
		return x + y;
	}

	static multiply(x: number, y: number): number {
		return x * y;
	}
}

console.log(MathOperations.PI);
console.log(MathOperations.add(5, 3));
```

### 2. Getters and Setters

```typescript
class BankAccount {
	private _balance: number;

	constructor(initialBalance: number) {
		this._balance = initialBalance;
	}

	// Getter
	get balance(): number {
		return this._balance;
	}

	// Setter
	set balance(value: number) {
		if (value < 0) {
			throw new Error("Balance cannot be negative");
		}
		this._balance = value;
	}
}

const account = new BankAccount(1000);
console.log(account.balance); // 1000
account.balance = 2000; // Using setter
```

### 3. Parameter Properties

```typescript
class User {
	// Shorthand for declaring and initializing class properties
	constructor(
		public username: string,
		private password: string,
		protected email: string
	) {}
}

// Equivalent to:
class UserLong {
	public username: string;
	private password: string;
	protected email: string;

	constructor(username: string, password: string, email: string) {
		this.username = username;
		this.password = password;
		this.email = email;
	}
}
```

## Best Practices

1. Use PascalCase for class names
2. Use access modifiers appropriately
3. Implement interfaces when sharing behavior across classes
4. Use abstract classes for base classes that shouldn't be instantiated
5. Keep classes focused and single-responsibility
6. Use parameter properties for simpler constructor definitions
7. Prefer composition over inheritance when possible

## Common Pitfalls to Avoid

1. Forgetting to call super() in derived class constructors
2. Overusing inheritance
3. Not properly handling access modifiers
4. Creating deeply nested inheritance hierarchies
5. Not implementing all abstract methods

## Exercises

1. Create a class hierarchy for a shape system
2. Implement multiple interfaces in a single class
3. Create an abstract class with both abstract and concrete methods
4. Use static members for utility functions
5. Implement getters and setters with validation

## Additional Resources

- [TypeScript Handbook - Classes](https://www.typescriptlang.org/docs/handbook/classes.html)
- [TypeScript Handbook - Inheritance](https://www.typescriptlang.org/docs/handbook/classes.html#inheritance)
- [TypeScript Deep Dive - Classes](https://basarat.gitbook.io/typescript/future-javascript/classes)
