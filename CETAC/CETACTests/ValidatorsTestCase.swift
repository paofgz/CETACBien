//
//  ValidatorsTestCase.swift
//  CETACTests
//
//  Created by Yus Molina on 07/10/21.
//

import XCTest
@testable import CETAC

class ValidatorsTestCase: XCTestCase {
    var validators = Validators()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidPass() throws {
        let res = validators.isPasswordValid("abcde151%")
        XCTAssertTrue(res)

    }
    func testShortPass() throws {
        let res = validators.isPasswordValid("abp/1")
        XCTAssertFalse(res)

    }
    func testNumbersPass() throws {
        let res = validators.isPasswordValid("12345%789")
        XCTAssertFalse(res)

    }
    func testLettersPass() throws {
        let res = validators.isPasswordValid("abkck@jsjfolfs")
        XCTAssertFalse(res)

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
