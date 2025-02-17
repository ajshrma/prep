# NestJS First Application

## Introduction to NestJS Applications

NestJS is a progressive Node.js framework for building efficient, reliable, and scalable server-side applications. This guide walks through creating your first NestJS application, covering all essential concepts and best practices.

### Key Concepts

1. **Application Structure**

   - Modular architecture
   - Dependency injection
   - Decorators and metadata

2. **Request Lifecycle**

   - Middleware
   - Guards
   - Interceptors
   - Pipes
   - Exception filters

3. **Data Flow**
   - DTOs (Data Transfer Objects)
   - Entities
   - Validation
   - Transformation

## Setting Up Your First Application

### 1. Project Creation

```bash
# Create new NestJS project
nest new first-nest-app

# Navigate to project directory
cd first-nest-app

# Install dependencies
npm install

# Start the application
npm run start:dev
```

### 2. Project Structure

```
src/
├── app.controller.ts    # Basic controller example
├── app.service.ts       # Basic service example
├── app.module.ts        # Root application module
└── main.ts             # Application entry point
```

### 3. Main Application File

```typescript
// main.ts
import { NestFactory } from "@nestjs/core";
import { ValidationPipe } from "@nestjs/common";
import { AppModule } from "./app.module";
import { DocumentBuilder, SwaggerModule } from "@nestjs/swagger";

async function bootstrap() {
	// Create NestJS application
	const app = await NestFactory.create(AppModule);

	// Enable validation
	app.useGlobalPipes(
		new ValidationPipe({
			whitelist: true,
			transform: true,
			forbidNonWhitelisted: true,
		})
	);

	// Configure Swagger documentation
	const config = new DocumentBuilder()
		.setTitle("First NestJS Application")
		.setDescription("API documentation")
		.setVersion("1.0")
		.build();
	const document = SwaggerModule.createDocument(app, config);
	SwaggerModule.setup("api", app, document);

	// Start the server
	await app.listen(3000);
	console.log(`Application is running on: ${await app.getUrl()}`);
}
bootstrap();
```

## Implementing Basic CRUD Operations

### 1. Creating a Module

```typescript
// items/items.module.ts
import { Module } from "@nestjs/common";
import { ItemsController } from "./items.controller";
import { ItemsService } from "./items.service";

@Module({
	controllers: [ItemsController],
	providers: [ItemsService],
	exports: [ItemsService], // Export if needed by other modules
})
export class ItemsModule {}
```

### 2. Implementing DTOs

```typescript
// items/dto/create-item.dto.ts
import { IsString, IsNumber, IsNotEmpty, Min } from "class-validator";
import { ApiProperty } from "@nestjs/swagger";

export class CreateItemDto {
	@ApiProperty({ description: "The name of the item" })
	@IsString()
	@IsNotEmpty()
	readonly name: string;

	@ApiProperty({ description: "The description of the item" })
	@IsString()
	readonly description: string;

	@ApiProperty({ description: "The price of the item" })
	@IsNumber()
	@Min(0)
	readonly price: number;
}

// items/dto/update-item.dto.ts
import { PartialType } from "@nestjs/swagger";
import { CreateItemDto } from "./create-item.dto";

export class UpdateItemDto extends PartialType(CreateItemDto) {}
```

### 3. Creating a Controller

```typescript
// items/items.controller.ts
import {
	Controller,
	Get,
	Post,
	Put,
	Delete,
	Body,
	Param,
	HttpStatus,
	HttpException,
} from "@nestjs/common";
import { ApiTags, ApiOperation, ApiResponse } from "@nestjs/swagger";
import { ItemsService } from "./items.service";
import { CreateItemDto } from "./dto/create-item.dto";
import { UpdateItemDto } from "./dto/update-item.dto";

@ApiTags("items")
@Controller("items")
export class ItemsController {
	constructor(private readonly itemsService: ItemsService) {}

	@Post()
	@ApiOperation({ summary: "Create a new item" })
	@ApiResponse({
		status: 201,
		description: "Item has been created successfully.",
	})
	@ApiResponse({ status: 400, description: "Bad Request." })
	async create(@Body() createItemDto: CreateItemDto) {
		try {
			return await this.itemsService.create(createItemDto);
		} catch (error) {
			throw new HttpException(error.message, HttpStatus.BAD_REQUEST);
		}
	}

	@Get()
	@ApiOperation({ summary: "Get all items" })
	@ApiResponse({ status: 200, description: "Return all items." })
	async findAll() {
		return await this.itemsService.findAll();
	}

	@Get(":id")
	@ApiOperation({ summary: "Get a specific item" })
	@ApiResponse({ status: 200, description: "Return the item." })
	@ApiResponse({ status: 404, description: "Item not found." })
	async findOne(@Param("id") id: string) {
		const item = await this.itemsService.findOne(id);
		if (!item) {
			throw new HttpException("Item not found", HttpStatus.NOT_FOUND);
		}
		return item;
	}

	@Put(":id")
	@ApiOperation({ summary: "Update an item" })
	@ApiResponse({
		status: 200,
		description: "Item has been updated successfully.",
	})
	@ApiResponse({ status: 404, description: "Item not found." })
	async update(@Param("id") id: string, @Body() updateItemDto: UpdateItemDto) {
		try {
			return await this.itemsService.update(id, updateItemDto);
		} catch (error) {
			throw new HttpException(error.message, HttpStatus.NOT_FOUND);
		}
	}

	@Delete(":id")
	@ApiOperation({ summary: "Delete an item" })
	@ApiResponse({
		status: 200,
		description: "Item has been deleted successfully.",
	})
	@ApiResponse({ status: 404, description: "Item not found." })
	async remove(@Param("id") id: string) {
		try {
			return await this.itemsService.remove(id);
		} catch (error) {
			throw new HttpException(error.message, HttpStatus.NOT_FOUND);
		}
	}
}
```

### 4. Creating a Service

```typescript
// items/items.service.ts
import { Injectable, NotFoundException } from "@nestjs/common";
import { CreateItemDto } from "./dto/create-item.dto";
import { UpdateItemDto } from "./dto/update-item.dto";

@Injectable()
export class ItemsService {
	private items = [];

	async create(createItemDto: CreateItemDto) {
		const item = {
			id: Date.now().toString(),
			...createItemDto,
		};
		this.items.push(item);
		return item;
	}

	async findAll() {
		return this.items;
	}

	async findOne(id: string) {
		const item = this.items.find((item) => item.id === id);
		if (!item) {
			throw new NotFoundException(`Item with ID "${id}" not found`);
		}
		return item;
	}

	async update(id: string, updateItemDto: UpdateItemDto) {
		const index = this.items.findIndex((item) => item.id === id);
		if (index === -1) {
			throw new NotFoundException(`Item with ID "${id}" not found`);
		}
		this.items[index] = {
			...this.items[index],
			...updateItemDto,
		};
		return this.items[index];
	}

	async remove(id: string) {
		const index = this.items.findIndex((item) => item.id === id);
		if (index === -1) {
			throw new NotFoundException(`Item with ID "${id}" not found`);
		}
		const [removedItem] = this.items.splice(index, 1);
		return removedItem;
	}
}
```

## Adding Validation and Error Handling

### 1. Global Validation Pipe

```typescript
// main.ts
app.useGlobalPipes(
	new ValidationPipe({
		whitelist: true,
		transform: true,
		forbidNonWhitelisted: true,
		transformOptions: {
			enableImplicitConversion: true,
		},
	})
);
```

### 2. Exception Filter

```typescript
// common/filters/http-exception.filter.ts
import {
	ExceptionFilter,
	Catch,
	ArgumentsHost,
	HttpException,
	HttpStatus,
} from "@nestjs/common";
import { Request, Response } from "express";

@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
	catch(exception: HttpException, host: ArgumentsHost) {
		const ctx = host.switchToHttp();
		const response = ctx.getResponse<Response>();
		const request = ctx.getRequest<Request>();
		const status = exception.getStatus();

		response.status(status).json({
			statusCode: status,
			timestamp: new Date().toISOString(),
			path: request.url,
			message: exception.message,
		});
	}
}
```

## Testing the Application

### 1. Unit Tests

```typescript
// items/items.service.spec.ts
import { Test, TestingModule } from "@nestjs/testing";
import { ItemsService } from "./items.service";
import { NotFoundException } from "@nestjs/common";

describe("ItemsService", () => {
	let service: ItemsService;

	beforeEach(async () => {
		const module: TestingModule = await Test.createTestingModule({
			providers: [ItemsService],
		}).compile();

		service = module.get<ItemsService>(ItemsService);
	});

	it("should be defined", () => {
		expect(service).toBeDefined();
	});

	it("should create an item", async () => {
		const createItemDto = {
			name: "Test Item",
			description: "Test Description",
			price: 100,
		};

		const item = await service.create(createItemDto);
		expect(item.name).toBe(createItemDto.name);
		expect(item.id).toBeDefined();
	});

	it("should throw NotFoundException when item not found", async () => {
		await expect(service.findOne("999")).rejects.toThrow(NotFoundException);
	});
});
```

### 2. E2E Tests

```typescript
// test/items.e2e-spec.ts
import { Test, TestingModule } from "@nestjs/testing";
import { INestApplication } from "@nestjs/common";
import * as request from "supertest";
import { AppModule } from "./../src/app.module";

describe("ItemsController (e2e)", () => {
	let app: INestApplication;

	beforeEach(async () => {
		const moduleFixture: TestingModule = await Test.createTestingModule({
			imports: [AppModule],
		}).compile();

		app = moduleFixture.createNestApplication();
		await app.init();
	});

	it("/items (POST)", () => {
		return request(app.getHttpServer())
			.post("/items")
			.send({
				name: "Test Item",
				description: "Test Description",
				price: 100,
			})
			.expect(201)
			.expect((res) => {
				expect(res.body.name).toBe("Test Item");
			});
	});
});
```

## Best Practices

1. **Code Organization**

   - Follow modular architecture
   - Use proper file naming conventions
   - Implement separation of concerns

2. **Error Handling**

   - Use built-in exception filters
   - Implement proper error responses
   - Handle async operations correctly

3. **Validation**

   - Use DTOs for data validation
   - Implement proper input sanitization
   - Use class-validator decorators

4. **Testing**
   - Write comprehensive unit tests
   - Implement E2E testing
   - Use proper test isolation

## Common Pitfalls to Avoid

1. **Architecture Issues**

   - Mixing business logic in controllers
   - Not using DTOs
   - Improper error handling

2. **Performance Problems**

   - Not implementing caching
   - Inefficient database queries
   - Memory leaks

3. **Security Concerns**
   - Missing input validation
   - Exposed sensitive data
   - Insufficient error handling

## Interview Questions

### Basic Level

1. What is NestJS and why would you use it?
2. Explain the basic structure of a NestJS application.
3. What are DTOs and why are they important?
4. How do you handle validation in NestJS?
5. What is dependency injection in NestJS?

### Intermediate Level

1. Explain the NestJS request lifecycle.
2. How do you implement custom pipes in NestJS?
3. What are interceptors and when would you use them?
4. How do you handle error responses in NestJS?
5. Explain the purpose of modules in NestJS.

### Advanced Level

1. How would you implement custom decorators in NestJS?
2. Explain the different scopes of providers in NestJS.
3. How would you implement caching in a NestJS application?
4. What strategies would you use for testing NestJS applications?
5. How would you handle file uploads in NestJS?

## Additional Resources

1. Official Documentation

   - [NestJS Documentation](https://docs.nestjs.com/)
   - [NestJS Fundamentals](https://docs.nestjs.com/first-steps)
   - [NestJS Techniques](https://docs.nestjs.com/techniques/database)

2. Community Resources

   - [NestJS GitHub Repository](https://github.com/nestjs/nest)
   - [NestJS Sample Applications](https://github.com/nestjs/nest/tree/master/sample)
   - [NestJS Courses](https://courses.nestjs.com/)

3. Additional Tools
   - [Swagger Documentation](https://docs.nestjs.com/openapi/introduction)
   - [Class Validator](https://github.com/typestack/class-validator)
   - [TypeORM Integration](https://docs.nestjs.com/techniques/database)
