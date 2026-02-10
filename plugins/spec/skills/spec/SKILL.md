---
name: spec
description: Analyze requirements, ask clarifying questions, and produce a clear specification. Invoke with /spec before starting non-trivial implementation work.
user-invocable: true
---

# Spec — Requirements Specification Skill

Produce a clear, unambiguous requirements spec before implementation begins. This skill answers "what exactly should we build?" — not "how do we build it?"

## When to Use

- **Before non-trivial implementation** — any task that touches multiple files or has ambiguous requirements
- **Unfamiliar codebases** — when you need to understand existing patterns before deciding what to build
- **Ambiguous requirements** — when the task description leaves room for interpretation
- **Cross-cutting changes** — features that interact with multiple existing systems

## Usage

Provide the task description after the command:

```
/spec Add pagination to the users API
```

```
/spec Implement rate limiting for the webhook endpoint
```

## Workflow

### Phase 1: Requirements Analysis & Clarifying Questions

The agent analyzes the task description, identifies ambiguities, and asks targeted questions grouped by:

- **Requirements clarity** — expected behavior for the primary use case
- **Edge cases** — unusual inputs, failure modes
- **Scope boundaries** — what's in and out of scope
- **Backward compatibility** — potential breakage
- **Acceptance criteria** — definition of done

When a question benefits from concrete context, the agent looks up relevant code to make the question specific rather than generic.

Answer each question. The agent will proceed once ambiguities are resolved.

### Phase 2: Spec Output

The agent produces a structured specification:

- **Context** — problem statement and motivation
- **Requirements** — numbered, testable requirements
- **Constraints** — technical constraints (looked up from the codebase as needed)
- **Edge Cases & Error Handling** — identified edge cases with expected behavior
- **Acceptance Criteria** — concrete, verifiable criteria
- **Open Questions** — any remaining uncertainties

## Tips

- The more context you provide in the initial task description, the fewer questions the agent needs to ask.
- If the task is small and unambiguous, the agent will skip questions and produce the spec directly.
- Use the spec output as input for implementation planning or hand it to an implementation agent.
