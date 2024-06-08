//
//  BookTest.swift
//  CleanCodeTestTests
//
//  Created by ricardo silva on 29/04/2024.
//

import XCTest
@testable import CleanCodeTest

final class BookTest: XCTestCase {
    
    var sut: Book!
    var mockFormats: Formats!

    override func setUp() {
        // Arrange
        sut = Book.mock
        mockFormats = Formats(textHTML: "", applicationEpubZip: "", applicationXMobipocketEbook: "", textPlainCharsetUsASCII: "", applicationRDFXML: "", imageJPEG: "https://www.gutenberg.org/cache/epub/84/pg84.cover.medium.jpg", applicationOctetStream: "", textHTMLCharsetUTF8: "", textPlainCharsetUTF8: "", textHTMLCharsetISO88591: "", textPlainCharsetISO88591: "", textHTMLCharsetUsASCII: "")
        
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testConformTo_Decodable() {
        XCTAssertTrue(sut as Any is Decodable)
    }
    
    func testConformTo_Equtable() {
        XCTAssertEqual(sut, sut)
    }
    
    func testSafeImageURL_ShouldReturnValidType() {
        XCTAssertTrue(sut.formats.safeImageURL() as Any is String)
    }
    
    func testSafeImageURL_ShouldReturnString() {
        XCTAssertEqual(sut.formats.safeImageURL(), "https://www.gutenberg.org/cache/epub/84/pg84.cover.medium.jpg")
    }
    
    func testBook_ShouldReturnValidType() {
        XCTAssertTrue(sut.id as Any is Int)
        XCTAssertTrue(sut.id == 0)
        XCTAssertTrue(sut.title as Any is String)
        XCTAssertTrue(sut.title == "test1")
        XCTAssertTrue(sut.authors[0].name as Any is String)
        XCTAssertTrue(sut.authors[0].name == "Ricardo")
        XCTAssertTrue(sut.authors[0].birthYear as Any is Int)
        XCTAssertTrue(sut.authors[0].birthYear == 1989)
        XCTAssertTrue(sut.authors[0].deathYear as Any is Int)
        XCTAssertTrue(sut.authors[0].deathYear == 2024)
        XCTAssertTrue(sut.subjects as Any is [String])
        XCTAssertTrue(sut.subjects == ["Moro Tech Interview"])
        XCTAssertTrue(sut.bookshelves as Any is [String])
        XCTAssertTrue(sut.bookshelves == ["CleanCode"])
        XCTAssertTrue(sut.languages as Any is [Language])
        XCTAssertTrue(sut.languages == [.en])
        XCTAssertTrue(sut.copyright as Any is Bool)
        XCTAssertTrue(sut.copyright == true)
        XCTAssertTrue(sut.mediaType as Any is MediaType)
        XCTAssertTrue(sut.mediaType == .text)
        XCTAssertTrue(sut.formats as Any is Formats)
        XCTAssertTrue(sut.formats == mockFormats)        
        XCTAssertTrue(sut.downloadCount as Any is Int)
        XCTAssertTrue(sut.downloadCount == 100)
        
    }
}
