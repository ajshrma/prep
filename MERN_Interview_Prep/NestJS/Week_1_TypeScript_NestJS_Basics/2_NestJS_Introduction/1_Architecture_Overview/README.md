# NestJS Architecture Overview

## Introduction to NestJS Architecture

NestJS is a progressive Node.js framework built with TypeScript that helps build efficient, reliable, and scalable server-side applications. Its architecture is heavily inspired by Angular, incorporating similar concepts and patterns.

### Key Architectural Principles

1. **Modularity**

   - NestJS applications are built around the concept of modules
   - Each module encapsulates related functionality
   - Promotes separation of concerns and maintainability

2. **Dependency Injection**

   - Core feature for managing dependencies
   - Promotes loose coupling between components
   - Enhances testability and maintainability

3. **Progressive Enhancement**
   - Can be used with pure Node.js
   - Integrates with other libraries and frameworks
   - Supports microservices architecture

## Core Building Blocks

### 1. Modules

Modules are the fundamental building blocks of NestJS applications. They help organize the application code into cohesive blocks of functionality.

#### Key Concepts:

- Each application has at least one root module
- Modules can import other modules
- Modules can export their providers
- Modules can be shared across the application

```typescript
// Example of a basic module
@Module({
	imports: [UsersModule, AuthModule],
	controllers: [AppController],
	providers: [AppService],
	exports: [AppService],
})
export class AppModule {}
```

### 2. Controllers

Controllers are responsible for handling incoming requests and returning responses to the client.

#### Key Features:

- Handle HTTP requests
- Define routes and endpoints
- Process request data
- Return responses
- Apply request validation

```typescript
// Example of a controller with different HTTP methods
@Controller("users")
export class UsersController {
	constructor(private readonly usersService: UsersService) {}

	@Get()
	findAll() {
		return this.usersService.findAll();
	}

	@Post()
	create(@Body() createUserDto: CreateUserDto) {
		return this.usersService.create(createUserDto);
	}
}
```

### 3. Providers

Providers are the backbone of NestJS dependency injection system. They can be injected as dependencies into controllers or other providers.

#### Types of Providers:

1. **Services**

   - Implement business logic
   - Handle data storage and retrieval
   - Process complex operations

2. **Repositories**

   - Handle database operations
   - Implement data access patterns

3. **Factories**

   - Create dynamic providers
   - Configure providers based on runtime conditions

4. **Custom Providers**
   - Implement custom provider patterns
   - Handle complex dependency scenarios

```typescript
// Example of a service provider
@Injectable()
export class UsersService {
	private readonly users: User[] = [];

	create(user: User) {
		this.users.push(user);
		return user;
	}

	findAll() {
		return this.users;
	}
}
```

### 4. Middleware

Middleware functions execute during the request-response cycle, before the route handler.

#### Key Features:

- Request/Response modification
- Execute code before route handlers
- End request-response cycle
- Call next middleware function

```typescript
// Example of custom middleware
@Injectable()
export class LoggerMiddleware implements NestMiddleware {
	use(req: Request, res: Response, next: NextFunction) {
		console.log("Request...");
		next();
	}
}
```

### 5. Guards

Guards determine whether a request should be handled by the route handler based on certain conditions.

#### Use Cases:

- Authentication
- Authorization
- Role-based access control
- Custom permission logic

```typescript
// Example of an authentication guard
@Injectable()
export class AuthGuard implements CanActivate {
	canActivate(context: ExecutionContext): boolean {
		const request = context.switchToHttp().getRequest();
		return validateRequest(request);
	}
}
```

### 6. Interceptors

Interceptors add extra logic before and after route handler execution.

#### Capabilities:

- Transform response data
- Handle errors
- Measure execution time
- Cache responses
- Log operations

```typescript
// Example of a logging interceptor
@Injectable()
export class LoggingInterceptor implements NestInterceptor {
	intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
		console.log("Before...");
		return next.handle().pipe(tap(() => console.log("After...")));
	}
}
```

### 7. Pipes

Pipes transform input data to desired format and validate input data.

#### Common Uses:

- Data transformation
- Data validation
- Type conversion
- Custom validation rules

```typescript
// Example of a validation pipe
@Injectable()
export class ValidationPipe implements PipeTransform {
	transform(value: any, metadata: ArgumentMetadata) {
		// validation logic
		return value;
	}
}
```

## Best Practices

1. **Module Organization**

   - Feature modules for specific functionality
   - Shared modules for common features
   - Core module for singleton services

2. **Dependency Injection**

   - Use constructor injection
   - Avoid circular dependencies
   - Use appropriate scope (DEFAULT, REQUEST, TRANSIENT)

3. **Error Handling**

   - Use exception filters
   - Implement proper error responses
   - Handle async operations correctly

4. **Configuration**
   - Use ConfigService for environment variables
   - Implement proper configuration validation
   - Use appropriate configuration patterns

## Common Pitfalls to Avoid

1. **Circular Dependencies**

   - Avoid mutual dependencies between modules
   - Use forwardRef() when necessary

2. **Memory Leaks**

   - Clean up subscriptions
   - Handle WebSocket connections properly
   - Manage file uploads correctly

3. **Performance Issues**
   - Avoid blocking operations
   - Use appropriate caching strategies
   - Implement proper database indexing

## Interview Questions

### Basic Level

1. What is NestJS and why would you use it?
2. Explain the main building blocks of NestJS architecture.
3. What is dependency injection in NestJS?
4. How do you create a new controller in NestJS?
5. What is the purpose of modules in NestJS?

### Intermediate Level

1. Explain the difference between providers and controllers.
2. How does middleware work in NestJS?
3. What are guards and when would you use them?
4. Explain the purpose of interceptors in NestJS.
5. How do you implement custom pipes in NestJS?

### Advanced Level

1. How would you handle circular dependencies in NestJS?
2. Explain the different scopes of providers in NestJS.
3. How would you implement custom decorators in NestJS?
4. Explain the execution context in NestJS.
5. How would you implement custom exception filters?

## Additional Resources

1. Official Documentation

   - [NestJS Documentation](https://docs.nestjs.com/)
   - [NestJS Fundamentals](https://docs.nestjs.com/first-steps)
   - [NestJS Techniques](https://docs.nestjs.com/techniques/database)

2. Community Resources
   - [NestJS GitHub Repository](https://github.com/nestjs/nest)
   - [NestJS Discord Community](https://discord.gg/nestjs)
   - [NestJS Courses and Tutorials](https://learn.nestjs.com/)
