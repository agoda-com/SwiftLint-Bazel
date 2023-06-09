//
//  ThrowableTestCasesRule.swift
//  SwiftLintExtraRules
//
//  Created by Stepanyan, Hovhannes (Agoda) on 8/6/23.
//

import SwiftSyntax
import SwiftLintCore

struct ThrowableTestCasesRule: ConfigurationProviderRule, SwiftSyntaxRule, SwiftSyntaxCorrectableRule {
    var configuration = UnitTestRuleConfiguration()

    init() {}

    static let description = RuleDescription(
        identifier: "throwable_test_cases",
        name: "Throwable test cases rule",
        description: "All test cases must be throwable functions",
        kind: .idiomatic,
        nonTriggeringExamples: [
            Example("""
            final class MyTestCase: XCTestCase {
                func testMyAwesomeFeature() throws {
                    // Test Something
                }
            }
            """),
            Example("""
            final class MyTestCase: XCTestCase {
                func testMyAwesomeFeature() async throws {
                    // Test something
                }
            }
            """),
            Example("""
            final class MyTestCase: XCTestCase {
                func testMyAwesomeFeatureHelper(arg: Arg) {
                    // Do something
                }
            }
            """),
            Example("""
            final class MyCase: BaseClass {
                func testMyAwesomeFeature() throws {
                    helperFunc(instance as? MyClass)
                }

                func anotherAwesomeFeature(config: [String: Any]) {
                    // Do Something
                }
            }
            """)
        ],
        triggeringExamples: [
            Example("""
            final class MyTestCase: XCTestCase {
                func testMyAwesomeFeature() async ↓{
                    // Test something
                }
            }
            """),
            Example("""
            final class MyTestCase: XCTestCase {
                func testMyAwesomeFeature() ↓{
                    // Test something
                }
            }
            """)
        ]
    )

    func makeVisitor(file: SwiftLintFile) -> ViolationsSyntaxVisitor {
        return Visitor(testParentClasses: configuration.testParentClasses)
    }

    func makeRewriter(file: SwiftLintFile) -> ViolationsSyntaxRewriter? {
        Rewriter(locationConverter: file.locationConverter,
                 disabledRegions: disabledRegions(file: file))
    }
}

private extension ThrowableTestCasesRule {

    final class Visitor: ViolationsSyntaxVisitor {
        override var skippableDeclarations: [DeclSyntaxProtocol.Type] { .all }
        private let testParentClasses: Set<String>

        init(testParentClasses: Set<String>) {
            self.testParentClasses = testParentClasses
            super.init(viewMode: .sourceAccurate)
        }

        override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
            return node.isXCTestCase(testParentClasses) ? .visitChildren : .skipChildren
        }

        override func visitPost(_ node: FunctionDeclSyntax) {
            guard let violationPosition = node.violationPosition else { return }
            violations.append(violationPosition)
        }
    }
}

private extension ThrowableTestCasesRule {
    final class Rewriter: SyntaxRewriter, ViolationsSyntaxRewriter {
        private(set) var correctionPositions: [AbsolutePosition] = []
        let locationConverter: SourceLocationConverter
        let disabledRegions: [SourceRange]

        init(locationConverter: SourceLocationConverter, disabledRegions: [SourceRange]) {
            self.locationConverter = locationConverter
            self.disabledRegions = disabledRegions
        }

        override func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
            guard let violationPosition = node.violationPosition else {
                return super.visit(node)
            }
            correctionPositions.append(violationPosition)

            var newEffectSpecifier: FunctionEffectSpecifiersSyntax
            if let effectSpecifiers = node.signature.effectSpecifiers {
                newEffectSpecifier = effectSpecifiers.with(\.throwsSpecifier,
                                                            TokenSyntax(.keyword(.throws),
                                                                        trailingTrivia: .spaces(1),
                                                                        presence: .present))
            } else {
                newEffectSpecifier = FunctionEffectSpecifiersSyntax(
                    throwsSpecifier: TokenSyntax(.keyword(.throws),
                                                 trailingTrivia: .spaces(1),
                                                 presence: .present)
                )
            }
            let newNode = node.with(\.signature.effectSpecifiers, newEffectSpecifier)
            return super.visit(newNode)

        }
    }
}

private extension FunctionDeclSyntax {
    var hasEmptyBody: Bool {
        if let body {
            return body.statements.isEmpty
        }
        return false
    }

    var isTestMethod: Bool {
        identifier.text.hasPrefix("test") && signature.input.parameterList.isEmpty
    }

    var violationPosition: AbsolutePosition? {
        guard isTestMethod else { return nil }
        if signature.effectSpecifiers?.throwsSpecifier == nil,
           let body = self.body {
            return body.leftBrace.positionAfterSkippingLeadingTrivia
        } else {
            return nil
        }
    }
}

