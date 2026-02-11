---
name: tdd
description: TDD (Test-Driven Development) rules. Defines t-wada style Red-Green-Refactor cycle, triangulation, baby steps, and other practices. Reference when practicing TDD.
---

# TDD (Test-Driven Development) Rules

A skill that defines t-wada style test-driven development practices.

## Core Principles

- **Test First**: Always write tests before implementation
- **Red-Green-Refactor**: Follow the cycle of Fail → Pass → Improve
- **Baby Steps**: Progress in small increments
- **Express Intent**: Clearly express code intent through tests

## TDD Cycle

### 1. Red

Write a failing test first.

```
test "can add two numbers"
  calculator = new Calculator
  assert calculator.add(2, 3) == 5
// → test fails
```

> **Compiled languages**: Create an empty function/class skeleton first so the code compiles. The test should fail at the assertion level, not at compilation.

### 2. Green

Write the minimal code to make the test pass.

```
class Calculator
  function add(a, b)
    return 5  // fake implementation
```

### 3. Refactor

Eliminate duplication and improve the code.

```
class Calculator
  function add(a, b)
    return a + b  // generalized via triangulation
```

## Triangulation

```
// First test
test "2 + 3 = 5"
  assert calculator.add(2, 3) == 5
// Fake implementation: return 5

// Second test (triangulation)
test "3 + 4 = 7"
  assert calculator.add(3, 4) == 7
// → Generalization is required, leading to return a + b
```

## Test Granularity

```
// ❌ Too coarse
test "user management feature"   // tests everything

// ✅ Appropriate
test "can create a user"
test "can update a user"
```

## Clear Test Names

```
// ❌ Vague
test "user test"

// ✅ Clear
test "can create a user with a valid name"
test "throws an error when creating a user with an empty name"
```

## Execution Steps

1. Create an empty function/class skeleton (required for compiled languages)
2. Write a test
3. Run **only** the relevant test(s) to confirm the test fails (Red)
4. Implement the minimal code to make the test pass (Green)
5. Run **only** the relevant test(s) to confirm the test passes
6. Refactor as needed (Refactor)

## Daily Checklist

- [ ] Always start new features with a test
- [ ] Confirm the test fails before implementing
- [ ] Start with a fake implementation and generalize incrementally
- [ ] Consider refactoring once green
- [ ] Verify that tests serve as documentation
