//
//  BitMathTests.swift
//  CivilGenerationsTests
//
//  Created by Jordan Trana on 8/16/22.
//

import XCTest

class BitMathTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test32to64andBack() throws {
        var hi = Int32(2501)
        var lo = Int32(22)
        var hash = Int64(hi: hi, lo: lo)
        var returnedHi = hash.hi
        var returnedLo = hash.lo
        XCTAssertTrue(hi == returnedHi)
        XCTAssertTrue(lo == returnedLo)
        
        hi = Int32(0)
        lo = Int32(0)
        hash = Int64(hi: hi, lo: lo)
        returnedHi = hash.hi
        returnedLo = hash.lo
        XCTAssertTrue(hi == returnedHi)
        XCTAssertTrue(lo == returnedLo)
        
        hi = Int32(1)
        lo = Int32(1)
        hash = Int64(hi: hi, lo: lo)
        returnedHi = hash.hi
        returnedLo = hash.lo
        XCTAssertTrue(hi == returnedHi)
        XCTAssertTrue(lo == returnedLo)
        
        hi = Int32(42)
        lo = Int32(24)
        hash = Int64(hi: hi, lo: lo)
        returnedHi = hash.hi
        returnedLo = hash.lo
        XCTAssertTrue(hi == returnedHi)
        XCTAssertTrue(lo == returnedLo)
        
        hi = Int32(111111)
        lo = Int32(111111)
        hash = Int64(hi: hi, lo: lo)
        returnedHi = hash.hi
        returnedLo = hash.lo
        XCTAssertTrue(hi == returnedHi)
        XCTAssertTrue(lo == returnedLo)
        
        hi = Int32.max
        lo = Int32(0)
        hash = Int64(hi: hi, lo: lo)
        returnedHi = hash.hi
        returnedLo = hash.lo
        XCTAssertTrue(hi == returnedHi)
        XCTAssertTrue(lo == returnedLo)
        
        hi = Int32(0)
        lo = Int32.max
        hash = Int64(hi: hi, lo: lo)
        returnedHi = hash.hi
        returnedLo = hash.lo
        XCTAssertTrue(hi == returnedHi)
        XCTAssertTrue(lo == returnedLo)
        
        hi = Int32.max
        lo = Int32.max
        hash = Int64(hi: hi, lo: lo)
        returnedHi = hash.hi
        returnedLo = hash.lo
        XCTAssertTrue(hi == returnedHi)
        XCTAssertTrue(lo == returnedLo)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
