# NestJS CLI Tools

## Introduction to NestJS CLI

The NestJS CLI (Command Line Interface) is a powerful tool that helps developers create, develop, and manage NestJS applications efficiently. It provides a set of commands for scaffolding applications, generating components, and managing the development workflow.

### Key Features

1. **Project Scaffolding**

   - Create new projects
   - Generate boilerplate code
   - Set up project structure

2. **Code Generation**

   - Generate modules, controllers, services
   - Create DTOs, entities, and interfaces
   - Scaffold complete CRUD resources

3. **Development Workflow**
   - Build and compile projects
   - Run applications in different modes
   - Manage project configuration

## Installation & Setup

### 1. Global Installation

```bash
# Install NestJS CLI globally
npm install -g @nestjs/cli

# Verify installation
nest --version

# Get help
nest --help
```

### 2. Project Creation

```bash
# Create new project with default settings
nest new my-nest-project

# Create project with specific package manager
nest new my-project --package-manager npm
nest new my-project --package-manager yarn
nest new my-project --package-manager pnpm

# Create project with specific collection
nest new my-project --collection @nestjs/schematics
```

## Component Generation

### 1. Basic Generation Commands

```bash
# Generate module
nest generate module users

# Generate controller
nest generate controller users

# Generate service
nest generate service users

# Generate complete resource
nest generate resource users
```

### 2. Advanced Generation Options

```bash
# Generate with path specification
nest g controller admin/users

# Generate without tests
nest g controller users --no-spec

# Generate with dry run
nest g controller users --dry-run

# Generate with custom template
nest g controller users --template=custom
```

### 3. Available Schematics

```bash
# Modules
nest g mo users

# Controllers
nest g co users

# Services
nest g s users

# Resources (CRUD)
nest g res users

# Middleware
nest g middleware logger

# Guards
nest g guard auth

# Interceptors
nest g interceptor transform

# Pipes
nest g pipe validation

# Filters
nest g filter http-exception

# Interfaces
nest g interface user.interface

# Classes
nest g class user.entity
```

## Project Management

### 1. Build Commands

```bash
# Build project
nest build

# Build with watch mode
nest build --watch

# Build with webpack
nest build --webpack

# Build with tsc
nest build --tsc
```

### 2. Development Commands

```bash
# Start development server
nest start

# Start with watch mode
nest start --watch

# Start with debug mode
nest start --debug

# Start with specific configuration
nest start --config nest-cli.custom.json
```

## Custom Schematics

### 1. Creating Custom Schematics

```typescript
// custom.schematic.ts
import {
	Rule,
	SchematicContext,
	Tree,
	apply,
	mergeWith,
	template,
	url,
} from "@angular-devkit/schematics";

export function customSchematic(options: any): Rule {
	return (tree: Tree, context: SchematicContext) => {
		const templateSource = apply(url("./files"), [
			template({
				...options,
				...strings,
			}),
		]);

		return mergeWith(templateSource)(tree, context);
	};
}
```

### 2. Using Custom Schematics

```bash
# Generate using custom schematic
nest g custom-schematic my-component

# Generate with options
nest g custom-schematic my-component --option=value
```

## Configuration

### 1. nest-cli.json

```json
{
	"collection": "@nestjs/schematics",
	"sourceRoot": "src",
	"compilerOptions": {
		"plugins": ["@nestjs/swagger"],
		"assets": ["**/*.proto"],
		"watchAssets": true
	},
	"generateOptions": {
		"spec": true,
		"flat": false
	}
}
```

### 2. Project Configuration

```json
{
	"projects": {
		"api": {
			"type": "application",
			"root": "apps/api",
			"entryFile": "main",
			"sourceRoot": "apps/api/src",
			"compilerOptions": {
				"tsConfigPath": "apps/api/tsconfig.app.json"
			}
		}
	}
}
```

## Best Practices

1. **Code Generation**

   - Use consistent naming conventions
   - Generate tests with components
   - Follow project structure

2. **Project Organization**

   - Maintain modular structure
   - Use feature-based organization
   - Keep related files together

3. **Development Workflow**

   - Use watch mode during development
   - Implement proper testing
   - Follow version control practices

4. **Configuration Management**
   - Use environment-specific configs
   - Implement proper validation
   - Maintain security best practices

## Common Pitfalls to Avoid

1. **Generation Issues**

   - Inconsistent naming
   - Wrong directory structure
   - Missing dependencies

2. **Configuration Problems**

   - Invalid CLI configuration
   - Incorrect paths
   - Missing compiler options

3. **Development Workflow**
   - Not using watch mode
   - Skipping test generation
   - Ignoring TypeScript errors

## Interview Questions

### Basic Level

1. What is the NestJS CLI and why is it useful?
2. How do you create a new NestJS project using the CLI?
3. What are the basic generation commands in NestJS CLI?
4. How do you generate a CRUD resource using the CLI?
5. What is the purpose of the nest-cli.json file?

### Intermediate Level

1. How would you create custom schematics in NestJS?
2. Explain the different build options available in NestJS CLI.
3. How do you configure the CLI for different environments?
4. What are the available compiler options in nest-cli.json?
5. How do you handle assets in NestJS CLI?

### Advanced Level

1. How would you implement custom templates for generation?
2. Explain the process of creating a custom CLI plugin.
3. How would you set up a monorepo using NestJS CLI?
4. What strategies do you use for managing multiple projects?
5. How do you handle complex generation scenarios?

## Additional Resources

1. Official Documentation

   - [NestJS CLI Documentation](https://docs.nestjs.com/cli/overview)
   - [NestJS Schematics](https://docs.nestjs.com/cli/usages)
   - [Custom Schematics](https://docs.nestjs.com/cli/workspaces)

2. Community Resources

   - [NestJS CLI GitHub Repository](https://github.com/nestjs/nest-cli)
   - [NestJS Schematics Repository](https://github.com/nestjs/schematics)
   - [Community Schematics](https://github.com/nestjs/awesome-nestjs#schematics)

3. Tutorials and Guides
   - [NestJS CLI Tutorial](https://docs.nestjs.com/first-steps)
   - [Custom Schematics Guide](https://trilon.io/blog/nestjs-custom-schematics)
   - [CLI Best Practices](https://docs.nestjs.com/cli/scripts)
