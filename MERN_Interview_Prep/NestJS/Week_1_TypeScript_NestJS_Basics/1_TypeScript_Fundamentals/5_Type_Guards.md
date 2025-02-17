# TypeScript Type Guards

## Basic Type Guards

### 1. typeof Type Guards

```typescript
function processValue(value: string | number) {
	if (typeof value === "string") {
		// TypeScript knows value is a string here
		console.log(value.toUpperCase());
	} else {
		// TypeScript knows value is a number here
		console.log(value.toFixed(2));
	}
}

// Usage
processValue("hello"); // HELLO
processValue(42.123); // 42.12
```

### 2. instanceof Type Guards

```typescript
class Dog {
	bark() {
		return "Woof!";
	}
}

class Cat {
	meow() {
		return "Meow!";
	}
}

function makeSound(animal: Dog | Cat) {
	if (animal instanceof Dog) {
		// TypeScript knows animal is Dog
		return animal.bark();
	} else {
		// TypeScript knows animal is Cat
		return animal.meow();
	}
}

// Usage
const dog = new Dog();
const cat = new Cat();
console.log(makeSound(dog)); // Woof!
console.log(makeSound(cat)); // Meow!
```

### 3. in Operator Type Guards

```typescript
interface Bird {
	fly(): void;
	layEggs(): void;
}

interface Fish {
	swim(): void;
	layEggs(): void;
}

function move(pet: Fish | Bird) {
	if ("swim" in pet) {
		// TypeScript knows pet is Fish
		return pet.swim();
	} else {
		// TypeScript knows pet is Bird
		return pet.fly();
	}
}
```

## Custom Type Guards

### 1. User-Defined Type Guards

```typescript
interface Car {
	make: string;
	model: string;
	year: number;
}

interface Motorcycle {
	make: string;
	model: string;
	cc: number;
}

function isCar(vehicle: Car | Motorcycle): vehicle is Car {
	return "year" in vehicle;
}

function processVehicle(vehicle: Car | Motorcycle) {
	if (isCar(vehicle)) {
		// TypeScript knows vehicle is Car
		console.log(`Car year: ${vehicle.year}`);
	} else {
		// TypeScript knows vehicle is Motorcycle
		console.log(`Motorcycle cc: ${vehicle.cc}`);
	}
}
```

### 2. Type Predicates

```typescript
interface Rectangle {
	width: number;
	height: number;
}

interface Circle {
	radius: number;
}

function isRectangle(shape: Rectangle | Circle): shape is Rectangle {
	return (shape as Rectangle).width !== undefined;
}

function calculateArea(shape: Rectangle | Circle) {
	if (isRectangle(shape)) {
		// TypeScript knows shape is Rectangle
		return shape.width * shape.height;
	} else {
		// TypeScript knows shape is Circle
		return Math.PI * shape.radius ** 2;
	}
}
```

## Advanced Type Guards

### 1. Discriminated Unions

```typescript
interface Square {
	kind: "square";
	size: number;
}

interface Rectangle {
	kind: "rectangle";
	width: number;
	height: number;
}

interface Circle {
	kind: "circle";
	radius: number;
}

type Shape = Square | Rectangle | Circle;

function getArea(shape: Shape) {
	switch (shape.kind) {
		case "square":
			return shape.size * shape.size;
		case "rectangle":
			return shape.width * shape.height;
		case "circle":
			return Math.PI * shape.radius ** 2;
	}
}
```

### 2. Exhaustiveness Checking

```typescript
function assertNever(x: never): never {
	throw new Error("Unexpected object: " + x);
}

function getShapeName(shape: Shape) {
	switch (shape.kind) {
		case "square":
			return "Square";
		case "rectangle":
			return "Rectangle";
		case "circle":
			return "Circle";
		default:
			return assertNever(shape); // Error if new shape is added
	}
}
```

### 3. Type Guards with Generics

```typescript
function isArray<T>(value: T | T[]): value is T[] {
	return Array.isArray(value);
}

function processItems<T>(items: T | T[]) {
	if (isArray(items)) {
		// TypeScript knows items is T[]
		items.forEach((item) => console.log(item));
	} else {
		// TypeScript knows items is T
		console.log(items);
	}
}
```

## Best Practices

1. Use type guards to narrow down union types
2. Prefer discriminated unions when possible
3. Implement exhaustiveness checking for switch statements
4. Create reusable type guard functions
5. Use descriptive names for type guard functions
6. Document complex type guards
7. Test type guards thoroughly

## Common Pitfalls to Avoid

1. Not handling all possible cases
2. Using type assertions instead of type guards
3. Forgetting to use exhaustiveness checking
4. Creating overly complex type guards
5. Not considering null or undefined values

## Exercises

1. Create a type guard for handling API responses
2. Implement a type guard system for form validation
3. Build a type-safe event handling system
4. Create a type guard for parsing JSON data
5. Implement exhaustive type checking for a state machine

## Additional Resources

- [TypeScript Handbook - Type Guards](https://www.typescriptlang.org/docs/handbook/advanced-types.html#type-guards-and-differentiating-types)
- [TypeScript Deep Dive - Type Guards](https://basarat.gitbook.io/typescript/type-system/typeguard)
- [TypeScript Type Guards Tutorial](https://www.typescriptlang.org/docs/handbook/2/narrowing.html)
