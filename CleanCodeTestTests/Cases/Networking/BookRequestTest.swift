//
//  BookRequestTest.swift
//  CleanCodeTestTests
//
//  Created by ricardo silva on 29/04/2024.
//

import XCTest
@testable import CleanCodeTest

final class BookRequestTest: XCTestCase {

    var sut: NetworkTarget!

    override func setUp() {
        sut = DummyTarget()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testNetworkTarget_WhenBaseURl_ShouldReturnString() {
        XCTAssertTrue(sut.baseURL.desc as Any is URL)
    }
    
    func testNetworkTarget_WhenBaseURl_ShouldReturnURL() {
        XCTAssertEqual(sut.baseURL.desc, URL("https://gutendex.com/"))
    }
    
    func testNetworkTarget_WhenVersion_ShouldReturnString() {
        XCTAssertTrue(sut.version.desc as Any is String)
    }
    
    func testNetworkTarget_WhenVersion_ShouldReturnVersion() {
        XCTAssertEqual(sut.version.desc, .empty)
    }
    
    func testNetworkTarget_WhenPath_ShouldBeRequestType() {
        XCTAssertTrue(sut.path as Any is String)
    }
    
    func testNetworkTarget_WhenPath_ShouldReturnPath() {
        XCTAssertEqual(sut.path, "test/test")
    }

    func testNetworkTarget_WhenMethod_ShouldReturnType() {
        XCTAssertEqual(sut.methodType, .get)
    }
    
    func testNetworkTarget_QueryParam_ShouldReturnType() {
        XCTAssertEqual(sut.queryParamsEncoding, .default)
    }
}

