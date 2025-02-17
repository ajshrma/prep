# NestJS Development Environment Setup

## Introduction to Development Environment

A properly configured development environment is crucial for efficient NestJS application development. This guide covers all aspects of setting up a professional NestJS development environment.

### Key Components

1. **Development Tools**

   - Node.js and npm
   - TypeScript
   - IDE/Code Editor
   - Version Control

2. **Project Configuration**

   - TypeScript configuration
   - ESLint and Prettier
   - Testing framework
   - Debugging tools

3. **Environment Management**
   - Environment variables
   - Configuration files
   - Development/Production settings

## Prerequisites Installation

### 1. Node.js Setup

```bash
# Check Node.js version (should be >= 12.x)
node --version

# Check npm version (should be >= 6.x)
npm --version

# Install Node Version Manager (nvm)
# Windows
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Install specific Node.js version
nvm install 16
nvm use 16

# Verify installation
node --version
npm --version
```

### 2. TypeScript Installation

```bash
# Install TypeScript globally
npm install -g typescript

# Verify TypeScript installation
tsc --version

# Initialize TypeScript configuration
tsc --init
```

### 3. NestJS CLI Installation

```bash
# Install NestJS CLI globally
npm install -g @nestjs/cli

# Verify NestJS CLI installation
nest --version
```

## IDE Setup

### 1. VS Code Configuration

```json
// settings.json
{
	"editor.formatOnSave": true,
	"editor.codeActionsOnSave": {
		"source.fixAll.eslint": true
	},
	"typescript.preferences.importModuleSpecifier": "relative",
	"typescript.updateImportsOnFileMove.enabled": "always",
	"[typescript]": {
		"editor.defaultFormatter": "esbenp.prettier-vscode"
	}
}
```

### 2. Essential Extensions

1. **ESLint**

   ```json
   {
   	"eslint.validate": ["javascript", "typescript"]
   }
   ```

2. **Prettier**

   ```json
   {
   	"prettier.singleQuote": true,
   	"prettier.trailingComma": "all"
   }
   ```

3. **NestJS Snippets**

   - Provides code snippets for NestJS development
   - Enhances development productivity

4. **Debug Configuration**
   ```json
   {
   	"version": "0.2.0",
   	"configurations": [
   		{
   			"type": "node",
   			"request": "launch",
   			"name": "Debug NestJS",
   			"args": ["${workspaceFolder}/src/main.ts"],
   			"runtimeArgs": ["--nolazy", "-r", "ts-node/register"],
   			"sourceMaps": true,
   			"cwd": "${workspaceRoot}",
   			"protocol": "inspector"
   		}
   	]
   }
   ```

## Project Configuration

### 1. TypeScript Configuration

```json
// tsconfig.json
{
	"compilerOptions": {
		"module": "commonjs",
		"declaration": true,
		"removeComments": true,
		"emitDecoratorMetadata": true,
		"experimentalDecorators": true,
		"allowSyntheticDefaultImports": true,
		"target": "es2017",
		"sourceMap": true,
		"outDir": "./dist",
		"baseUrl": "./",
		"incremental": true,
		"skipLibCheck": true,
		"strictNullChecks": true,
		"noImplicitAny": true,
		"strictBindCallApply": true,
		"forceConsistentCasingInFileNames": true,
		"noFallthroughCasesInSwitch": true,
		"paths": {
			"@app/*": ["src/app/*"],
			"@config/*": ["src/config/*"],
			"@shared/*": ["src/shared/*"]
		}
	}
}
```

### 2. ESLint Configuration

```javascript
// .eslintrc.js
module.exports = {
	parser: "@typescript-eslint/parser",
	parserOptions: {
		project: "tsconfig.json",
		sourceType: "module",
	},
	plugins: ["@typescript-eslint/eslint-plugin"],
	extends: [
		"plugin:@typescript-eslint/recommended",
		"plugin:prettier/recommended",
	],
	root: true,
	env: {
		node: true,
		jest: true,
	},
	ignorePatterns: [".eslintrc.js"],
	rules: {
		"@typescript-eslint/interface-name-prefix": "off",
		"@typescript-eslint/explicit-function-return-type": "off",
		"@typescript-eslint/explicit-module-boundary-types": "off",
		"@typescript-eslint/no-explicit-any": "off",
	},
};
```

### 3. Prettier Configuration

```json
// .prettierrc
{
	"singleQuote": true,
	"trailingComma": "all",
	"printWidth": 80,
	"tabWidth": 2,
	"semi": true,
	"bracketSpacing": true,
	"arrowParens": "avoid"
}
```

## Testing Setup

### 1. Jest Configuration

```javascript
// jest.config.js
module.exports = {
	moduleFileExtensions: ["js", "json", "ts"],
	rootDir: "src",
	testRegex: ".*\\.spec\\.ts$",
	transform: {
		"^.+\\.(t|j)s$": "ts-jest",
	},
	collectCoverageFrom: ["**/*.(t|j)s"],
	coverageDirectory: "../coverage",
	testEnvironment: "node",
	moduleNameMapper: {
		"^@app/(.*)$": "<rootDir>/app/$1",
		"^@config/(.*)$": "<rootDir>/config/$1",
		"^@shared/(.*)$": "<rootDir>/shared/$1",
	},
};
```

### 2. E2E Testing Setup

```typescript
// test/app.e2e-spec.ts
import { Test, TestingModule } from "@nestjs/testing";
import { INestApplication } from "@nestjs/common";
import * as request from "supertest";
import { AppModule } from "./../src/app.module";

describe("AppController (e2e)", () => {
	let app: INestApplication;

	beforeEach(async () => {
		const moduleFixture: TestingModule = await Test.createTestingModule({
			imports: [AppModule],
		}).compile();

		app = moduleFixture.createNestApplication();
		await app.init();
	});

	it("/ (GET)", () => {
		return request(app.getHttpServer())
			.get("/")
			.expect(200)
			.expect("Hello World!");
	});
});
```

## Environment Configuration

### 1. Environment Variables

```typescript
// config/configuration.ts
export default () => ({
	port: parseInt(process.env.PORT, 10) || 3000,
	database: {
		host: process.env.DATABASE_HOST,
		port: parseInt(process.env.DATABASE_PORT, 10) || 5432,
		username: process.env.DATABASE_USERNAME,
		password: process.env.DATABASE_PASSWORD,
		database: process.env.DATABASE_NAME,
	},
	jwt: {
		secret: process.env.JWT_SECRET,
		expiresIn: process.env.JWT_EXPIRES_IN || "1h",
	},
});
```

### 2. Environment Files

```env
# .env.development
PORT=3000
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=password
DATABASE_NAME=nestjs_dev
JWT_SECRET=dev_secret

# .env.production
PORT=80
DATABASE_HOST=production_host
DATABASE_PORT=5432
DATABASE_USERNAME=prod_user
DATABASE_PASSWORD=prod_password
DATABASE_NAME=nestjs_prod
JWT_SECRET=prod_secret
```

## Best Practices

1. **Version Control**

   - Use .gitignore properly
   - Exclude sensitive information
   - Maintain clean repository

2. **Code Organization**

   - Follow consistent structure
   - Use proper naming conventions
   - Implement modular design

3. **Development Workflow**

   - Use proper branching strategy
   - Implement code review process
   - Maintain documentation

4. **Security**
   - Secure environment variables
   - Implement proper authentication
   - Follow security best practices

## Common Pitfalls to Avoid

1. **Environment Issues**

   - Hardcoded configuration
   - Exposed sensitive data
   - Inconsistent environments

2. **Development Problems**

   - Incorrect TypeScript configuration
   - Missing dependencies
   - Improper error handling

3. **Testing Issues**
   - Insufficient test coverage
   - Improper test setup
   - Missing integration tests

## Interview Questions

### Basic Level

1. What are the prerequisites for setting up a NestJS development environment?
2. How do you configure TypeScript for a NestJS project?
3. What is the purpose of ESLint and Prettier in NestJS development?
4. How do you handle environment variables in NestJS?
5. What are the essential VS Code extensions for NestJS development?

### Intermediate Level

1. How would you set up a debugging configuration for NestJS?
2. Explain the different testing configurations in NestJS.
3. How do you handle different environment configurations?
4. What is the purpose of path aliases in tsconfig.json?
5. How do you configure JWT authentication in NestJS?

### Advanced Level

1. How would you set up a CI/CD pipeline for NestJS?
2. Explain the process of configuring microservices in NestJS.
3. How would you implement custom decorators in NestJS?
4. What strategies do you use for database migrations?
5. How do you handle security in different environments?

## Additional Resources

1. Official Documentation

   - [NestJS Setup Guide](https://docs.nestjs.com/first-steps)
   - [NestJS Configuration](https://docs.nestjs.com/techniques/configuration)
   - [NestJS Testing](https://docs.nestjs.com/fundamentals/testing)

2. Development Tools

   - [TypeScript Documentation](https://www.typescriptlang.org/docs)
   - [VS Code NestJS Guide](https://code.visualstudio.com/docs/nodejs/nodejs-debugging)
   - [ESLint Documentation](https://eslint.org/docs/user-guide/getting-started)

3. Community Resources
   - [NestJS Discord Community](https://discord.gg/nestjs)
   - [NestJS GitHub Discussions](https://github.com/nestjs/nest/discussions)
   - [NestJS Stack Overflow](https://stackoverflow.com/questions/tagged/nestjs)
