# TypeScript Module System

## Basic Module Concepts

### 1. ES Modules Export/Import

```typescript
// math.ts
export const add = (x: number, y: number): number => x + y;
export const subtract = (x: number, y: number): number => x - y;

// Default export
export default class Calculator {
	add(x: number, y: number): number {
		return x + y;
	}
}

// main.ts
import Calculator, { add, subtract } from "./math";
import * as MathUtils from "./math";

const calc = new Calculator();
console.log(calc.add(5, 3)); // 8
console.log(add(5, 3)); // 8
console.log(MathUtils.subtract(5, 3)); // 2
```

### 2. CommonJS Modules

```typescript
// logger.ts
module.exports = {
	log: (message: string) => console.log(message),
	error: (message: string) => console.error(message),
};

// app.ts
const logger = require("./logger");
logger.log("Hello, TypeScript!");
```

### 3. Module Re-export

```typescript
// models/index.ts
export { User } from "./user";
export { Post } from "./post";
export { Comment } from "./comment";

// models/user.ts
export interface User {
	id: number;
	name: string;
}

// app.ts
import { User, Post, Comment } from "./models";
```

## Module Resolution

### 1. Classic Resolution

```typescript
// tsconfig.json
{
    "compilerOptions": {
        "moduleResolution": "classic"
    }
}

// Usage
import { SomeType } from './types';  // Looks for types.ts, types.d.ts
```

### 2. Node Resolution

```typescript
// tsconfig.json
{
    "compilerOptions": {
        "moduleResolution": "node"
    }
}

// Resolves in following order:
// 1. /root/src/module.ts
// 2. /root/src/module.tsx
// 3. /root/src/module.d.ts
// 4. /root/src/module/package.json (with "types" field)
// 5. /root/src/module/index.ts
// 6. /root/src/module/index.tsx
// 7. /root/src/module/index.d.ts
```

### 3. Path Mapping

```typescript
// tsconfig.json
{
    "compilerOptions": {
        "baseUrl": ".",
        "paths": {
            "@app/*": ["src/app/*"],
            "@models/*": ["src/models/*"],
            "@utils/*": ["src/utils/*"]
        }
    }
}

// Usage
import { User } from '@models/user';
import { formatDate } from '@utils/date';
```

## Advanced Module Features

### 1. Ambient Modules

```typescript
// types.d.ts
declare module "my-library" {
	export function doSomething(): void;
	export interface Options {
		debug: boolean;
	}
}

// usage.ts
import { doSomething, Options } from "my-library";
```

### 2. Module Augmentation

```typescript
// original.ts
export interface User {
	name: string;
}

// augmentation.ts
import { User } from "./original";

declare module "./original" {
	interface User {
		age: number;
	}
}

// usage.ts
import { User } from "./original";
const user: User = {
	name: "John",
	age: 30, // Now valid due to augmentation
};
```

### 3. Dynamic Imports

```typescript
// Dynamic module loading
async function loadModule() {
	const module = await import("./dynamic-module");
	module.doSomething();
}

// With type checking
type ModuleType = typeof import("./dynamic-module");
async function loadTypedModule(): Promise<ModuleType> {
	return import("./dynamic-module");
}
```

## Module Organization

### 1. Barrel Pattern

```typescript
// components/index.ts
export * from "./Button";
export * from "./Input";
export * from "./Form";

// app.ts
import { Button, Input, Form } from "./components";
```

### 2. Feature Modules

```typescript
// feature/
//   ├── index.ts
//   ├── feature.component.ts
//   ├── feature.service.ts
//   ├── feature.model.ts
//   └── feature.utils.ts

// feature/index.ts
export * from "./feature.component";
export * from "./feature.service";
export * from "./feature.model";
```

## Best Practices

1. Use ES Modules over CommonJS
2. Implement proper path mapping
3. Use barrel files for clean exports
4. Organize modules by feature
5. Use explicit imports over namespace imports
6. Keep modules focused and cohesive
7. Implement proper type declarations

## Common Pitfalls to Avoid

1. Circular dependencies
2. Namespace pollution
3. Inconsistent module patterns
4. Missing type declarations
5. Improper path resolution

## Exercises

1. Create a modular application structure
2. Implement path aliases
3. Create and use barrel files
4. Implement dynamic module loading
5. Create custom type declarations

## Additional Resources

- [TypeScript Handbook - Modules](https://www.typescriptlang.org/docs/handbook/modules.html)
- [TypeScript Module Resolution](https://www.typescriptlang.org/docs/handbook/module-resolution.html)
- [TypeScript Namespaces and Modules](https://www.typescriptlang.org/docs/handbook/namespaces-and-modules.html)
