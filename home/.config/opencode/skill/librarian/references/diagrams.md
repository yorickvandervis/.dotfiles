# Creating Diagrams

Use mermaid diagrams to visualize architecture and code flow.

## When to Use Diagrams

- Explaining component relationships
- Showing data flow
- Illustrating architecture
- Mapping dependencies

## Common Diagram Types

### Flowchart (Code Flow)

```mermaid
flowchart TD
    A[Request] --> B{Validate}
    B -->|Valid| C[Process]
    B -->|Invalid| D[Error]
    C --> E[Response]
```

### Sequence (Interactions)

```mermaid
sequenceDiagram
    Client->>API: POST /users
    API->>DB: INSERT user
    DB-->>API: user_id
    API-->>Client: 201 Created
```

### Class (Structure)

```mermaid
classDiagram
    class Parser {
        +parse(input)
        +validate()
    }
    class Schema {
        +type: string
        +validate(data)
    }
    Parser --> Schema
```

### Graph (Dependencies)

```mermaid
graph LR
    A[core] --> B[utils]
    A --> C[types]
    D[api] --> A
    E[cli] --> A
```

## Best Practices

1. **Keep it simple** - Focus on key relationships
2. **Label clearly** - Use descriptive node names
3. **Limit nodes** - 5-10 nodes per diagram
4. **Show direction** - Use arrows consistently

## Integration

When explaining code architecture:

1. Explore with opensrc
2. Identify key components
3. Create diagram showing relationships
4. Link to source files

```markdown
The validation flow:

```mermaid
flowchart LR
    Input --> Parser --> Schema --> Result
```

See [parser.ts](https://github.com/...) for implementation.
```
