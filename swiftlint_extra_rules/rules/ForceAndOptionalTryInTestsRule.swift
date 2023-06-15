//
//  ForceAndOptionalTryInTestsRule.swift
//  SwiftLintExtraRules
//
//  Created by Stepanyan, Hovhannes (Agoda) on 8/6/23.
//

import SwiftSyntax
import SwiftLintCore

struct ForceAndOptionalTryInTestsRule: ConfigurationProviderRule, SwiftSyntaxRule, SwiftSyntaxCorrectableRule {
    var configuration = UnitTestRuleConfiguration()

    init() {}

    static let description = RuleDescription(
        identifier: "force_and_optional_try_in_tests",
        name: "Missed Given/When/Then Rule",
        description: "Dont use try!/try? in test functions. Use just try instead",
        kind: .idiomatic,
        nonTriggeringExamples: [
            Example("""
            final class MyTestCase: XCTestCase {
                func testMyAwesomeFeature() throws {
                    try throwableFunt()
                }
            }
            """),
            Example("""
            final class MyTestCase: XCTestCase {
                func testMyAwesomeFeature() async throws {
                    try throwableFunt()
                    try await asyncThrowableFunt()
                }
            }
            """),
            Example("""
            final class MyTestCase: XCTestCase {
                func testMyAwesomeFeatureHelper(arg: Arg) throws {
                    try throwableFunt()
                }
            }
            """),
            Example("""
            final class MyCase: BaseClass {
                func testMyAwesomeFeature() throws {
                    try helperFunc(config: config)
                }

                func anotherAwesomeFeature(config: [String: Any]) throws {
                    try throwableFunt()
                }
            }
            """)
        ],
        triggeringExamples: [
            Example("""
            final class MyTestCase: XCTestCase {
                func testMyAwesomeFeature() async {
                    ↓try! throwableFunt()
                }
            }
            """),
            Example("""
            final class MyTestCase: XCTestCase {
                func helperFunc() async {
                    ↓try! throwableFunt()
                    ↓try? await asyncThrowableFunt()
                }
            }
            """),
            Example("""
            final class MyTestCase: XCTestCase {
                func testMyAwesomeFeature() throws {
                    ↓try? throwableFunt()
                }
            }
            """)
        ]
    )

    func makeVisitor(file: SwiftLintFile) -> ViolationsSyntaxVisitor {
        Visitor(testParentClasses: configuration.testParentClasses)
    }

    func makeRewriter(file: SwiftLintFile) -> ViolationsSyntaxRewriter? {
        Rewriter(locationConverter: file.locationConverter,
                 disabledRegions: disabledRegions(file: file))
    }
}

private extension ForceAndOptionalTryInTestsRule {

    final class Visitor: ViolationsSyntaxVisitor {
        override var skippableDeclarations: [DeclSyntaxProtocol.Type] { .allExcept(FunctionDeclSyntax.self) }
        private let testParentClasses: Set<String>

        init(testParentClasses: Set<String>) {
            self.testParentClasses = testParentClasses
            super.init(viewMode: .sourceAccurate)
        }

        override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
            node.isXCTestCase(testParentClasses) ? .visitChildren : .skipChildren
        }

        override func visitPost(_ node: TryExprSyntax) {
            guard let violationPosition = node.violationPosition else { return }
            violations.append(violationPosition)
        }
    }
}

private extension ForceAndOptionalTryInTestsRule {
    final class Rewriter: SyntaxRewriter, ViolationsSyntaxRewriter {
        private(set) var correctionPositions: [AbsolutePosition] = []
        let locationConverter: SourceLocationConverter
        let disabledRegions: [SourceRange]

        init(locationConverter: SourceLocationConverter, disabledRegions: [SourceRange]) {
            self.locationConverter = locationConverter
            self.disabledRegions = disabledRegions
        }

        override func visit(_ node: TryExprSyntax) -> ExprSyntax {
            guard let violationPosition = node.violationPosition else {
                return super.visit(node)
            }
            correctionPositions.append(violationPosition)

            let newNode = node.with(\.questionOrExclamationMark, nil)
                            .with(\.expression, node.expression
                                .with(\.leadingTrivia, .spaces(1)))
            return super.visit(newNode)

        }
    }
}

private extension TryExprSyntax {

    var violationPosition: AbsolutePosition? {
        if questionOrExclamationMark != nil {
            return positionAfterSkippingLeadingTrivia
        } else {
            return nil
        }
    }
}

