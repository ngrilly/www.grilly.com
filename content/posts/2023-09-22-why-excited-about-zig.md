---
title: Why I’m excited about the Zig programming language
updated: 2025-08-24
---

## A Go programmer’s perspective on Zig

For the past few years, I’ve been a happy user of Go, my main programming language alongside Python. I’ve also written my fair share of Pascal, C, C++, Java, JavaScript, and I’ve been toying with Rust, Erlang, TypeScript, Ruby, R, Dart, Lua, Clojure, and OCaml.

Recently, I’ve been looking at [Zig](https://ziglang.org/), a new and promising programming language, still in development, but already used with great success in ambitious projects like [Bun](https://bun.sh/), a JavaScript runtime and toolkit, [TigerBeetle](https://tigerbeetle.com/), a financial accounting database, and [Ghostty](https://ghostty.org/), a terminal emulator.

I’m pretty excited about Zig. But it made we wonder why I would use Zig instead of Go, considering that Go has served me well so far. 🤔 That’s what I hope to clarify by writing this post.

I need to mention upfront that I don’t think there is a perfect programming language. This post is about discussing the tradeoffs I’m seeing, not claiming that one language is superior to another. ❤️

## ⚡️ The joy of programming the computer, not the language

I think my interest for Zig comes down to a simple idea: With Zig, I’m rediscovering *the joy of programming in a minimalist low-level language like C*, but *with most of the perks of a modern high-level language*.

There is something refreshing about being able to write programs interacting directly with the hardware and the OS, skipping the middlemen: no interpreter, no JIT compiler, no VM, no runtime, no garbage collector, no user-space scheduler.

## 🔬 Comparing Zig and Go

### Zig == Go

Let’s start with what Go and Zig have in common. They both are general-purpose, imperative, statically typed, ahead-of-time compiled, and relatively simple programming languages, with a built-in code formatter, test runner, and cross-compiler.

### Zig > Go

Now let’s look at some of the key features of Zig that don’t exist in Go:

- Comptime (compile-time metaprogramming)
- Explicit memory management using custom allocators and `defer/errdefer` to free memory
- Excellent error handling (using error values, `try`, `catch`, `errdefer`, and Error Return Traces)
- Immutable variables (using `const`)
- Optional types (no null pointers/references)
- Sum types (tagged unions) with exhaustive switch
- if/for/while/switch expressions
- Anonymous struct and tuple literals (automatically coerced to the destination type)
- Seamless interoperability with C, with no FFI overhead, and built-in C compiler
- Reusable code (important for bare metal, embedded, libraries, WebAssembly) enabled by:
    - No hidden memory allocations
    - No hidden control flow (like panic/restore)
    - No runtime
    - Fully optional standard library

### Zig ≠ Go

Now let’s look at the key areas where Go and Zig do things differently:

- **Generics → Comptime.** Go supports generic programming using type parameters since Go 1.18. Zig has comptime, a new and powerful form of compile-time metaprogramming.
- **Run-time reflection → Compile-time reflection.** Go offers run-time reflection, via the reflect package. It is used for formatting and serialization/deserialization. Zig’s solution is based on compile-time reflection, and compile-time metaprogramming.
- **Goroutines → Native threads & async/await.** Go relies on goroutines for concurrency and parallelism. Zig offers native threads, and “colourblind” async/await (momentarily unavailable in Zig 0.11) [^1]
- **Variadic arguments → Anonymous tuple literals.** Go supports variadic arguments to function calls:
  ```
  fmt.Printf("%v + %v = %v\n", 1, 10, 11)
  ```
  Zig uses anonymous tuple literals to solve the same problem:
  ```
  std.debug.print("{} + {} = {}\n", .{1, 10, 11});
  ````

### Zig < Go

But nothing comes for free. Zig has:

- **No temporal memory safety** (no garbage collector or borrow checker), which means a higher risk of use-after-free and double-free errors.
- No closures. Closures are anonymous functions capturing variables defined in the enclosing scope. They are typically implemented using some form of automatic memory management, not present in Zig because this would defeat the goals of the language. [^2]
- No interfaces (or traits in Rust). Use `anytype`.
- A syntax that occasionally feels a bit awkward (to me at least):
    - Struct declarations where fields are separated by commas while declarations are terminated by semicolons. ([example](https://github.com/ziglang/zig/blob/00f42909adf23a92905aa7211d74ed5b5397b397/lib/std/mem/Allocator.zig#L13))

[^1]: [What is Zig's “Colorblind” Async/Await?](https://kristoff.it/blog/zig-colorblind-async-await/)
[^2]: [Closure (computer programming), Implementation and theory](https://en.wikipedia.org/wiki/Closure_(computer_programming)#Implementation_and_theory)