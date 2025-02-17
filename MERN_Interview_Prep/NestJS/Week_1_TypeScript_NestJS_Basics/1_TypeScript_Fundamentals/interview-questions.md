# Interview Questions - TypeScript Fundamentals & NestJS Introduction

## TypeScript Fundamentals

### Types and Interfaces

#### Basic Level

1. What are the basic types in TypeScript?
2. What is the difference between `type` and `interface` in TypeScript?
3. How do you define optional properties in an interface?
4. What is type inference in TypeScript?
5. How do you define an array type in TypeScript?
6. What is the purpose of the `any` type?
7. What is the difference between `null` and `undefined` in TypeScript?
8. How do you define a tuple type in TypeScript?

#### Intermediate Level

1. Explain union and intersection types with examples.
2. How does interface inheritance work in TypeScript?
3. What are literal types in TypeScript?
4. How do you use type guards with interfaces?
5. What is the `keyof` operator and how is it used?
6. Explain how to use mapped types in TypeScript.
7. What are index signatures in TypeScript?
8. How do conditional types work?

#### Advanced Level

1. Explain how to implement polymorphic interfaces in TypeScript.
2. How do you use discriminated unions with interfaces?
3. What are recursive types and when would you use them?
4. How do you implement generic constraints with interfaces?
5. Explain how to use the `infer` keyword in conditional types.
6. How do you implement branded types for type safety?
7. What are template literal types and how are they used?
8. How do you implement higher-order types?

### Classes and Inheritance

#### Basic Level

1. How do you define a class in TypeScript?
2. What are access modifiers in TypeScript?
3. How do you implement inheritance in TypeScript?
4. What is the purpose of the `constructor` in a class?
5. How do you define class properties?
6. What is method overriding?
7. How do you implement an interface in a class?
8. What is the difference between `public`, `private`, and `protected`?

#### Intermediate Level

1. What are abstract classes and when should you use them?
2. How do you implement multiple interfaces in a class?
3. What are static members in a class?
4. How do you use getters and setters?
5. What is method overloading in TypeScript?
6. How do you implement mixins in TypeScript?
7. What are parameter properties in TypeScript classes?
8. How do you use decorators with classes?

#### Advanced Level

1. How do you implement the singleton pattern in TypeScript?
2. Explain how to use generic classes with constraints.
3. How do you implement factory patterns in TypeScript?
4. What are declaration merging techniques for classes?
5. How do you implement immutable classes?
6. Explain advanced inheritance patterns in TypeScript.
7. How do you handle circular dependencies in class inheritance?
8. Implement a dependency injection container in TypeScript.

### Generics

#### Basic Level

1. What are generics in TypeScript?
2. How do you define a generic function?
3. What is the syntax for generic interfaces?
4. How do you use generic classes?
5. What is type inference in generics?
6. How do you specify default types in generics?
7. What are generic constraints?
8. How do you use multiple type parameters?

#### Intermediate Level

1. How do you use generic type aliases?
2. Explain generic utility types like `Partial<T>` and `Record<K,V>`.
3. How do you implement generic factories?
4. What are bounded type parameters?
5. How do you use generic type guards?
6. Explain generic mapped types.
7. How do you implement generic method overloading?
8. What are generic parameter defaults?

#### Advanced Level

1. How do you implement higher-order generic types?
2. Explain variance in generic types.
3. How do you implement generic type inference?
4. What are generic distributive conditional types?
5. How do you implement generic type recursion?
6. Explain advanced generic constraints patterns.
7. How do you implement generic type inference with promises?
8. Implement a generic state management system.

### Decorators

#### Basic Level

1. What are decorators in TypeScript?
2. How do you create a class decorator?
3. What are method decorators?
4. How do you create property decorators?
5. What are parameter decorators?
6. How do you enable decorator support in TypeScript?
7. What is the execution order of decorators?
8. How do you pass parameters to decorators?

#### Intermediate Level

1. How do you implement method decorators with parameters?
2. What are decorator factories?
3. How do you use multiple decorators?
4. Explain how to use property decorators with validation.
5. How do you implement caching decorators?
6. What are accessor decorators?
7. How do you implement logging decorators?
8. Explain how to use decorators with inheritance.

#### Advanced Level

1. How do you implement dependency injection using decorators?
2. Explain how to implement metadata reflection with decorators.
3. How do you create composable decorators?
4. Implement a validation system using decorators.
5. How do you handle decorator composition order?
6. Explain how to implement aspect-oriented programming with decorators.
7. How do you implement decorators for mixins?
8. Create a custom routing system using decorators.

### Type Guards

#### Basic Level

1. What are type guards in TypeScript?
2. How do you use the `typeof` type guard?
3. What is the `instanceof` type guard?
4. How do you create user-defined type guards?
5. What is type narrowing?
6. How do you use the `in` operator as a type guard?
7. What are predicate functions?
8. How do you use type guards with unions?

#### Intermediate Level

1. How do you implement discriminated unions?
2. What are exhaustiveness checks?
3. How do you use type guards with generics?
4. Explain control flow analysis in type guards.
5. How do you implement custom type guard functions?
6. What are assertion functions?
7. How do you use type guards with interfaces?
8. Explain branded type guards.

#### Advanced Level

1. How do you implement recursive type guards?
2. Explain advanced discriminated unions patterns.
3. How do you implement generic type guard factories?
4. What are higher-order type guards?
5. How do you handle complex type hierarchies with guards?
6. Implement a type-safe event system using guards.
7. How do you use type guards with conditional types?
8. Create a type-safe validation system using guards.

### Utility Types

#### Basic Level

1. What are utility types in TypeScript?
2. How do you use `Partial<T>`?
3. What is `Readonly<T>`?
4. How do you use `Pick<T,K>`?
5. What is `Record<K,V>`?
6. How do you use `Omit<T,K>`?
7. What is `Exclude<T,U>`?
8. How do you use `Extract<T,U>`?

#### Intermediate Level

1. How do you use `NonNullable<T>`?
2. What is `ReturnType<T>`?
3. How do you use `Parameters<T>`?
4. What is `InstanceType<T>`?
5. How do you create custom utility types?
6. Explain `ThisType<T>`.
7. How do you combine utility types?
8. What is `Required<T>`?

#### Advanced Level

1. How do you implement recursive utility types?
2. Create a deep partial utility type.
3. Implement a type-safe form state utility type.
4. How do you create conditional utility types?
5. Implement a deep readonly utility type.
6. Create a utility type for API responses.
7. How do you handle union types in utility types?
8. Implement a type-safe state management utility.

### Module System

#### Basic Level

1. What are modules in TypeScript?
2. How do you export and import modules?
3. What is the difference between default and named exports?
4. How do you re-export modules?
5. What are namespace imports?
6. How do you use path aliases?
7. What is module resolution?
8. How do you handle circular dependencies?

#### Intermediate Level

1. What are dynamic imports?
2. How do you use barrel files?
3. What are ambient modules?
4. How do you use module augmentation?
5. What are declaration merging techniques?
6. How do you handle external module declarations?
7. What are the different module resolution strategies?
8. How do you configure module paths?

#### Advanced Level

1. How do you implement plugin systems with modules?
2. Explain advanced module bundling techniques.
3. How do you handle code splitting with modules?
4. Implement a module federation system.
5. How do you handle cross-cutting concerns in modules?
6. Explain advanced module resolution patterns.
7. How do you implement lazy loading with modules?
8. Create a dynamic module loading system.
