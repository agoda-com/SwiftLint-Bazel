
# SwiftLint Bazel

This is the integration of the [SwiftLint][SwiftLint] with [Bazel][Bazel] extended with extra rules.

## Pre-Requisites

* Xcode 14 or later: https://developer.apple.com/xcode/
* macOS 12 or later

## Basic

You can run SwiftLint with this command:

```console
./bazelisk run -c opt @SwiftLint//:swiftlint
```

You can build SwiftLint with this command:

```console
./bazelisk build -c opt @SwiftLint//:swiftlint
```
check the output in the Terminal. You should see the path where you can find the executable
```console
Target @swiftlint~0.52.2//:swiftlint up-to-date:
  bazel-bin/external/swiftlint~0.52.2/swiftlint
INFO: Elapsed time: 0.193s, Critical Path: 0.00s
INFO: 1 process: 1 internal.
INFO: Build completed successfully, 1 total action
```

## Custom Rules

You can wire up SwiftLint to use some custom, private, native SwiftLint
rules. Check out this [tutorial][Tutorial] about how to write rules in Swift.

### Writing Rules

Any Swift sources you add in the `swiftlint_extra_rules/rules` directory
will be compiled as part of the `SwiftLintFramework` module just as if
those files had been in the official upstream SwiftLint git repository.

This means you have access to all the internal APIs in that module.
These internal APIs can and will change over time, so you may need to
adjust the custom code you write accordingly whenever you update the
version of SwiftLint you target.

Then build and run SwiftLint and you should see your rule being applied:

```console
$ ./bazelisk run -c opt @SwiftLint//:swiftlint
Linting Swift files in current working directory
Linting 'File.swift' (1/1)
File.swift:1:14: warning: New Awesome Rule Violation: Do not break New Asome Rule (new_awesome_rule)
Done linting! Found 1 violation, 0 serious in 1 file.
```

### Testing Rules

You can validate the triggering, non-triggering, and correction examples
in your rule's description by running SwiftLint's "extra rules" tests:

```console
./bazelisk test --test_output=streamed @SwiftLint//Tests:ExtraRulesTests
```

## Developing in Xcode

Using the excellent [rules_xcodeproj][rules_xcodeproj] project to
generate an Xcode project, gives you Xcode's IDE functionality to help
you develop your rules.

Simply running this command:

```console
./bazelisk run :swiftlint_xcodeproj && xed .
```
Will generate and open the Xcode project

At which point you should have access to most Xcode features you'd want
when developing.

## Documentation

With propert examples and rule descriptions Swiftlint can generate the documentation for all rules. Check [Rule Directory][Rule Directory] to see available rules.

[Rule Directory]: rule_docs/Rule%20Directory.md
[Tutorial]: https://vimeo.com/819268038
[SwiftLint]: https://github.com/realm/SwiftLint
[Bazel]: https://bazel.build
[swiftlint-bazel-instructions]: https://github.com/realm/SwiftLint#using-bazel
[rules_xcodeproj]: https://github.com/buildbuddy-io/rules_xcodeproj