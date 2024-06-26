//
//  RequestBuilderTest.swift
//  CleanCodeTestTests
//
//  Created by ricardo silva on 29/04/2024.
//

import XCTest
@testable import CleanCodeTest

final class RequestBuilderTest: XCTestCase {

    var sut: HttpRequest!

    override func setUp() {
        sut = HttpRequest(request: MockNetworkTarget())
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testRequestBuilder_WhenBaseURl_ShouldReturnType() {
        XCTAssertEqual(sut.baseURL, .baseApi)
    }
    
    func testRequestBuilder_WhenVersion_ShouldReturnType() {
        XCTAssertEqual(sut.version, .none)
    }
    
    func testRequestBuilder_WhenPath_ShouldReturnString() {
        XCTAssertEqual(sut.path, "book")
    }
    
    func testRequestBuilder_WhenMethodType_ShouldReturnType() {
        XCTAssertEqual(sut.methodType, .get)
    }
    
    func testRequestBuilder_WhenMethodQuery_ShouldReturnStringDictionary() {
        XCTAssertEqual(sut.queryParams, ["test":"test"])
    }
    
    func testRequestBuilder_WhenEncoding_ShouldReturnEncoding() {
        XCTAssertEqual(sut.queryParamsEncoding, .default)
    }
    
    func testRequestBuilder_WhenPathAppender_ShouldReturnString() {
        XCTAssertEqual(sut.pathAppendedURL, URL("https://gutendex.com/book"))
    }
    
    func testRequestBuilder_WhenBuildURL_ShouldBeURLRequest() {
        XCTAssertTrue(sut.buildURLRequest() as Any is URLRequest)
    }
}
