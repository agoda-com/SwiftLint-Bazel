import XCTest

final class MyAwesomeTest: XCTestCase {
    var mySwesomeVar: MyAwesomeType!

    func setUp() async {
        mySwesomeVar = MyAwesomeType()
    }
    
    func testSomething() {
        let x = _x as? Int;
    }

    func testSomethingAsync() async {
        let x = _x as? Int;
    }

    func testSomethingElse() async throws {
        let x = _x as? Int;
    }

    func testAnotherThing() throws {
        let x = _x as? Int;
    }
}

final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() {
        let myClassInstance = instance as? MyClass
    }

    func helper() {

    }

    func testHelper(arg1: Arg1) {
        
    }
}