# Week 2: NestJS Core Concepts

## Modules

### Topics Covered:

1. Module Structure

   - Feature modules
   - Root module
   - Module decorators
   - Module metadata

2. Feature Modules

   - Creating feature modules
   - Organizing related components
   - Module encapsulation
   - Best practices

3. Shared Modules

   - Creating shared modules
   - Exporting providers
   - Importing shared modules
   - Global modules

4. Dynamic Modules

   - Dynamic module creation
   - Configuration options
   - Module factories
   - Async configuration

5. Module Re-exporting
   - Re-exporting modules
   - Module composition
   - Module hierarchy
   - Circular dependencies

## Controllers

### Topics Covered:

1. Request Handling

   - HTTP methods
   - Request lifecycle
   - Controller instantiation
   - Request processing

2. Route Parameters

   - Path parameters
   - Query parameters
   - Route wildcards
   - Parameter validation

3. Request Payload

   - Body parsing
   - DTO objects
   - Request validation
   - Type conversion

4. Response Handling

   - Response types
   - Status codes
   - Response formatting
   - Serialization

5. Headers and Status Codes

   - Custom headers
   - Response headers
   - HTTP status codes
   - Error responses

6. Route Decorators
   - @Controller()
   - @Get(), @Post(), etc.
   - @Param(), @Body()
   - Custom decorators

## Practical Exercises:

1. Create a feature module with controllers and services
2. Implement CRUD operations using controllers
3. Create shared modules for common functionality
4. Implement dynamic module configuration
5. Handle different types of request parameters and payloads

## Resources:

- [NestJS Modules](https://docs.nestjs.com/modules)
- [NestJS Controllers](https://docs.nestjs.com/controllers)
- [NestJS Provider Scopes](https://docs.nestjs.com/fundamentals/injection-scopes)
- [NestJS Dynamic Modules](https://docs.nestjs.com/fundamentals/dynamic-modules)

## Assignment:

Build a modular NestJS application with multiple feature modules, implementing proper request handling and response formatting.
