# NestJS Project Structure

## Introduction to NestJS Project Structure

NestJS follows a structured and organized approach to project organization that promotes maintainability, scalability, and code reusability. Understanding the project structure is crucial for developing efficient NestJS applications.

### Key Concepts

1. **Modular Structure**

   - Organized by feature modules
   - Clear separation of concerns
   - Scalable architecture

2. **Convention over Configuration**

   - Consistent file naming
   - Standard directory structure
   - Predictable code organization

3. **Domain-Driven Design**
   - Business logic separation
   - Domain-specific modules
   - Clear boundaries between features

## Standard Project Structure

### 1. Root Directory Layout

```
project-root/
├── src/
│   ├── app.module.ts
│   ├── app.controller.ts
│   ├── app.service.ts
│   ├── main.ts
│   ├── modules/
│   ├── common/
│   └── config/
├── test/
├── dist/
├── node_modules/
├── package.json
├── tsconfig.json
├── .env
└── README.md
```

#### Purpose of Each Directory:

1. **src/**

   - Contains application source code
   - Main application logic
   - Feature modules and components

2. **test/**

   - Unit tests
   - Integration tests
   - E2E tests

3. **dist/**

   - Compiled JavaScript code
   - Production-ready assets
   - Generated during build

4. **node_modules/**
   - External dependencies
   - NPM packages
   - Development tools

### 2. Source Directory Structure

```
src/
├── modules/
│   ├── users/
│   │   ├── dto/
│   │   │   ├── create-user.dto.ts
│   │   │   └── update-user.dto.ts
│   │   ├── entities/
│   │   │   └── user.entity.ts
│   │   ├── users.controller.ts
│   │   ├── users.service.ts
│   │   ├── users.module.ts
│   │   └── users.repository.ts
│   └── auth/
│       ├── strategies/
│       ├── guards/
│       ├── decorators/
│       └── auth.module.ts
├── common/
│   ├── filters/
│   ├── guards/
│   ├── interceptors/
│   ├── middleware/
│   └── pipes/
└── config/
    ├── database.config.ts
    ├── jwt.config.ts
    └── app.config.ts
```

## Feature Module Organization

### 1. Module Structure

```typescript
// users/users.module.ts
@Module({
	imports: [TypeOrmModule.forFeature([User])],
	controllers: [UsersController],
	providers: [UsersService, UsersRepository],
	exports: [UsersService],
})
export class UsersModule {}
```

### 2. Component Organization

#### DTOs (Data Transfer Objects)

```typescript
// users/dto/create-user.dto.ts
export class CreateUserDto {
	@IsString()
	@IsNotEmpty()
	readonly username: string;

	@IsEmail()
	readonly email: string;

	@IsString()
	@MinLength(6)
	readonly password: string;
}
```

#### Entities

```typescript
// users/entities/user.entity.ts
@Entity()
export class User {
	@PrimaryGeneratedColumn()
	id: number;

	@Column({ unique: true })
	username: string;

	@Column()
	@Exclude()
	password: string;

	@CreateDateColumn()
	createdAt: Date;
}
```

#### Controllers

```typescript
// users/users.controller.ts
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

## Common Directory Organization

### 1. Middleware Structure

```typescript
// common/middleware/logger.middleware.ts
@Injectable()
export class LoggerMiddleware implements NestMiddleware {
	use(req: Request, res: Response, next: NextFunction) {
		console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
		next();
	}
}
```

### 2. Guards Structure

```typescript
// common/guards/roles.guard.ts
@Injectable()
export class RolesGuard implements CanActivate {
	constructor(private reflector: Reflector) {}

	canActivate(context: ExecutionContext): boolean {
		const roles = this.reflector.get<string[]>("roles", context.getHandler());
		if (!roles) return true;

		const request = context.switchToHttp().getRequest();
		const user = request.user;
		return this.matchRoles(roles, user.roles);
	}
}
```

## Configuration Management

### 1. Environment Configuration

```typescript
// config/configuration.ts
export default () => ({
	port: parseInt(process.env.PORT, 10) || 3000,
	database: {
		host: process.env.DATABASE_HOST,
		port: parseInt(process.env.DATABASE_PORT, 10) || 5432,
		username: process.env.DATABASE_USER,
		password: process.env.DATABASE_PASSWORD,
	},
	jwt: {
		secret: process.env.JWT_SECRET,
		expiresIn: process.env.JWT_EXPIRES_IN,
	},
});
```

### 2. Module Configuration

```typescript
// config/database.config.ts
@Injectable()
export class DatabaseConfig {
	constructor(private configService: ConfigService) {}

	get host(): string {
		return this.configService.get<string>("database.host");
	}

	get port(): number {
		return this.configService.get<number>("database.port");
	}
}
```

## Best Practices

1. **File Naming Conventions**

   - Use kebab-case for files
   - Use descriptive names
   - Follow consistent patterns

2. **Module Organization**

   - Group related features
   - Maintain single responsibility
   - Use proper exports

3. **Code Organization**

   - Keep controllers thin
   - Implement business logic in services
   - Use repositories for data access

4. **Configuration Management**
   - Use environment variables
   - Implement configuration validation
   - Centralize configuration

## Common Pitfalls to Avoid

1. **Inconsistent Structure**

   - Mixed naming conventions
   - Inconsistent file organization
   - Unclear module boundaries

2. **Poor Separation of Concerns**

   - Business logic in controllers
   - Mixed responsibilities
   - Tight coupling

3. **Configuration Issues**
   - Hardcoded values
   - Insecure sensitive data
   - Missing validation

## Interview Questions

### Basic Level

1. What is the purpose of the `src` directory in a NestJS project?
2. Explain the basic structure of a NestJS module.
3. What are DTOs and why are they important?
4. How do you organize controllers in a NestJS project?
5. What is the purpose of the `common` directory?

### Intermediate Level

1. How would you structure a feature module in NestJS?
2. Explain the difference between entities and DTOs.
3. How do you handle configuration management in NestJS?
4. What is the purpose of the `providers` array in a module?
5. How do you organize middleware in a NestJS project?

### Advanced Level

1. How would you implement a microservices architecture in NestJS?
2. Explain the best practices for handling database connections in NestJS.
3. How would you structure a monorepo NestJS project?
4. What strategies do you use for testing organization in NestJS?
5. How do you handle circular dependencies in your project structure?

## Additional Resources

1. Official Documentation

   - [NestJS Project Structure](https://docs.nestjs.com/first-steps)
   - [NestJS Modules](https://docs.nestjs.com/modules)
   - [NestJS Architecture](https://docs.nestjs.com/techniques/database)

2. Community Resources
   - [NestJS Best Practices](https://github.com/nestjs/awesome-nestjs)
   - [NestJS Sample Applications](https://github.com/nestjs/nest/tree/master/sample)
   - [NestJS Starter Templates](https://github.com/nestjs/typescript-starter)
