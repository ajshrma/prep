# TypeScript Decorators

## Basic Decorators

### 1. Class Decorators

```typescript
// Simple class decorator
function sealed(constructor: Function) {
	Object.seal(constructor);
	Object.seal(constructor.prototype);
}

@sealed
class BugReport {
	type = "report";
	title: string;

	constructor(t: string) {
		this.title = t;
	}
}

// Decorator Factory
function reportable(isReportable: boolean) {
	return function (constructor: Function) {
		constructor.prototype.isReportable = isReportable;
	};
}

@reportable(true)
class Car {
	brand: string;
	constructor(brand: string) {
		this.brand = brand;
	}
}
```

### 2. Method Decorators

```typescript
function log(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
	let originalMethod = descriptor.value;

	descriptor.value = function (...args: any[]) {
		console.log(`Calling ${propertyKey} with args: ${args}`);
		const result = originalMethod.apply(this, args);
		console.log(`Result: ${result}`);
		return result;
	};

	return descriptor;
}

class Calculator {
	@log
	add(x: number, y: number) {
		return x + y;
	}
}
```

### 3. Property Decorators

```typescript
function format(formatString: string) {
	return function (target: any, propertyKey: string) {
		let value: string;

		const getter = function () {
			return `${formatString} ${value}`;
		};

		const setter = function (newVal: string) {
			value = newVal;
		};

		Object.defineProperty(target, propertyKey, {
			get: getter,
			set: setter,
			enumerable: true,
			configurable: true,
		});
	};
}

class Greeter {
	@format("Hello")
	name: string;
}
```

### 4. Parameter Decorators

```typescript
function required(
	target: Object,
	propertyKey: string | symbol,
	parameterIndex: number
) {
	const existingRequired: number[] =
		Reflect.getOwnMetadata("required", target, propertyKey) || [];
	existingRequired.push(parameterIndex);
	Reflect.defineMetadata("required", existingRequired, target, propertyKey);
}

class UserService {
	login(@required username: string, @required password: string) {
		// Method implementation
	}
}
```

## Advanced Decorator Patterns

### 1. Composition of Decorators

```typescript
function first() {
	console.log("first(): factory evaluated");
	return function (
		target: any,
		propertyKey: string,
		descriptor: PropertyDescriptor
	) {
		console.log("first(): called");
	};
}

function second() {
	console.log("second(): factory evaluated");
	return function (
		target: any,
		propertyKey: string,
		descriptor: PropertyDescriptor
	) {
		console.log("second(): called");
	};
}

class Example {
	@first()
	@second()
	method() {}
}
```

### 2. Metadata Decorators

```typescript
import "reflect-metadata";

const formatMetadataKey = Symbol("format");

function format(formatString: string) {
	return Reflect.metadata(formatMetadataKey, formatString);
}

class Greeter {
	@format("Hello, %s")
	greeting: string;
}
```

### 3. Validation Decorators

```typescript
function validate(
	target: any,
	propertyName: string,
	descriptor: PropertyDescriptor
) {
	let method = descriptor.value;

	descriptor.value = function (...args: any[]) {
		args.forEach((arg, index) => {
			if (arg === undefined || arg === null) {
				throw new Error(`Parameter at index ${index} is invalid.`);
			}
		});

		return method.apply(this, args);
	};
}

class UserController {
	@validate
	createUser(username: string, email: string) {
		// Method implementation
	}
}
```

## NestJS-Style Decorators

### 1. Controller Decorators

```typescript
function Controller(prefix: string) {
	return function (target: Function) {
		Reflect.defineMetadata("prefix", prefix, target);
	};
}

@Controller("/api")
class UserController {
	// Controller implementation
}
```

### 2. Route Decorators

```typescript
function Get(path: string) {
	return function (target: any, propertyKey: string) {
		Reflect.defineMetadata("path", path, target, propertyKey);
		Reflect.defineMetadata("method", "GET", target, propertyKey);
	};
}

@Controller("/users")
class UserController {
	@Get("/:id")
	getUser(id: string) {
		// Method implementation
	}
}
```

## Best Practices

1. Use decorators for cross-cutting concerns
2. Keep decorators focused and single-purpose
3. Use decorator factories when configuration is needed
4. Properly handle metadata reflection
5. Document decorator behavior and requirements
6. Consider performance implications
7. Test decorated components thoroughly

## Common Pitfalls to Avoid

1. Overusing decorators for simple operations
2. Not handling decorator composition correctly
3. Ignoring decorator execution order
4. Mutating the original object/method unnecessarily
5. Not considering the performance impact

## Exercises

1. Create a timing decorator for method execution
2. Implement a caching decorator
3. Build a validation system using decorators
4. Create a role-based access control decorator
5. Implement a retry mechanism decorator

## Additional Resources

- [TypeScript Decorators Documentation](https://www.typescriptlang.org/docs/handbook/decorators.html)
- [NestJS Custom Decorators](https://docs.nestjs.com/custom-decorators)
- [Reflect Metadata](https://rbuckton.github.io/reflect-metadata/)
