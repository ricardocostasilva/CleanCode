//
//  Book.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Foundation

// MARK: - Books
struct Books: Decodable {
    let count: Int
    let next, previous: String?
    let results: [Book]
}

// MARK: - Result
struct Book: Decodable {
    let id: Int
    let title: String
    let authors, translators: [Author]
    let subjects, bookshelves: [String]
    let languages: [Language]?
    let copyright: Bool
    let mediaType: MediaType
    let formats: Formats
    let downloadCount: Int

    enum CodingKeys: String, CodingKey {
        case id, title, authors, translators, subjects, bookshelves, languages, copyright
        case mediaType = "media_type"
        case formats
        case downloadCount = "download_count"
    }
    
    // Provide a default initializer
     init(id: Int = 0, title: String = "", authors: [Author] = [], translators: [Author] = [], subjects: [String] = [], bookshelves: [String] = [], languages: [Language] = [], copyright: Bool = false, mediaType: MediaType = .text, formats: Formats = Formats(), downloadCount: Int = 0) {
         self.id = id
         self.title = title
         self.authors = authors
         self.translators = translators
         self.subjects = subjects
         self.bookshelves = bookshelves
         self.languages = languages
         self.copyright = copyright
         self.mediaType = mediaType
         self.formats = formats
         self.downloadCount = downloadCount
     }
}

// MARK: - Author
struct Author: Decodable {
    let name: String
    let birthYear, deathYear: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        case deathYear = "death_year"
    }
}

// MARK: - Formats
struct Formats: Decodable {
    let textHTML: String?
    let textHTMLCharsetUsASCII: String?
    let applicationEpubZip, applicationXMobipocketEbook: String?
    let textPlainCharsetISO88591: String?
    let applicationRDFXML: String?
    let imageJPEG: String?
    let textPlainCharsetUsASCII: String?
    let applicationOctetStream: String?
    let textPlainCharsetUTF8: String?
    let textHTMLCharsetUTF8: String?
    let textPlain: String?
    let audioOgg: String?
    let audioMp4: String?
    let audioMPEG: String?
    let textHTMLCharsetISO88591: String?
    let applicationPDF: String?
    let applicationPrsTei: String?

    enum CodingKeys: String, CodingKey {
        case textHTML = "text/html"
        case textHTMLCharsetUsASCII = "text/html; charset=us-ascii"
        case applicationEpubZip = "application/epub+zip"
        case applicationXMobipocketEbook = "application/x-mobipocket-ebook"
        case textPlainCharsetISO88591 = "text/plain; charset=iso-8859-1"
        case applicationRDFXML = "application/rdf+xml"
        case imageJPEG = "image/jpeg"
        case textPlainCharsetUsASCII = "text/plain; charset=us-ascii"
        case applicationOctetStream = "application/octet-stream"
        case textPlainCharsetUTF8 = "text/plain; charset=utf-8"
        case textHTMLCharsetUTF8 = "text/html; charset=utf-8"
        case textPlain = "text/plain"
        case audioOgg = "audio/ogg"
        case audioMp4 = "audio/mp4"
        case audioMPEG = "audio/mpeg"
        case textHTMLCharsetISO88591 = "text/html; charset=iso-8859-1"
        case applicationPDF = "application/pdf"
        case applicationPrsTei = "application/prs.tei"
    }
    
    init(textHTML: String = "", applicationEpubZip: String = "", applicationXMobipocketEbook: String = "", textPlainCharsetUsASCII: String = "", applicationRDFXML: String = "", imageJPEG: String = "", applicationOctetStream: String = "", textHTMLCharsetUTF8: String? = nil, textPlainCharsetUTF8: String? = nil, textHTMLCharsetISO88591: String? = nil, textPlainCharsetISO88591: String? = nil, textHTMLCharsetUsASCII: String? = nil, textPlain: String? = nil, audioOgg: String? = nil, audioMp4: String? = nil, audioMPEG: String? = nil, applicationPDF: String? = nil, applicationPrsTei: String? = nil) {
        self.textHTML = textHTML
        self.applicationEpubZip = applicationEpubZip
        self.applicationXMobipocketEbook = applicationXMobipocketEbook
        self.textPlainCharsetUsASCII = textPlainCharsetUsASCII
        self.applicationRDFXML = applicationRDFXML
        self.imageJPEG = imageJPEG
        self.applicationOctetStream = applicationOctetStream
        self.textHTMLCharsetUTF8 = textHTMLCharsetUTF8
        self.textPlainCharsetUTF8 = textPlainCharsetUTF8
        self.textHTMLCharsetISO88591 = textHTMLCharsetISO88591
        self.textPlainCharsetISO88591 = textPlainCharsetISO88591
        self.textHTMLCharsetUsASCII = textHTMLCharsetUsASCII
        self.textPlain = textPlain
        self.audioOgg = audioOgg
        self.audioMp4 = audioMp4
        self.audioMPEG = audioMPEG
        self.applicationPDF = applicationPDF
        self.applicationPrsTei = applicationPrsTei
        
    }
}

enum Language: String, Decodable {
    case en = "en"
    case fr = "fr"
    case es = "es"
    case tl = "tl"
    case zh = "zh"    
    case de = "de"
    case ru = "ru"
    case ar = "ar"
    case sl = "sl"
    case pt = "pt"
    case ja = "ja"
    case nl = "nl"
    case la = "la"
    case grc = "grc"
    case it = "it"
    case enm = "enm"
}

enum MediaType: String, Decodable {
    case text = "Text"
    case sound = "Sound"
    case collection = "Collection"
    case dataset = "Dataset"
}

extension Book: Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Formats: Equatable {
    static func == (lhs: Formats, rhs: Formats) -> Bool {
        return lhs.textHTML == rhs.textHTML && lhs.applicationEpubZip == rhs.applicationEpubZip && lhs.applicationXMobipocketEbook == rhs.applicationXMobipocketEbook && lhs.textPlainCharsetUsASCII == rhs.textPlainCharsetUsASCII && lhs.applicationRDFXML == rhs.applicationRDFXML && lhs.imageJPEG == rhs.imageJPEG && lhs.applicationOctetStream == rhs.applicationOctetStream && lhs.textHTMLCharsetUTF8 == rhs.textHTMLCharsetUTF8 && lhs.textPlainCharsetUsASCII == rhs.textPlainCharsetUsASCII && lhs.textHTMLCharsetISO88591 == rhs.textHTMLCharsetISO88591 && lhs.textPlainCharsetISO88591 == rhs.textPlainCharsetISO88591 && lhs.textHTMLCharsetUsASCII == rhs.textHTMLCharsetUsASCII
    }
}

extension Formats {
    // make image url safe
    func safeImageURL() -> String {
        guard let url = self.imageJPEG else {return .empty}
        let safeURL = url.trimmingString()
        return safeURL
    }
}


extension Book {
    
    static let formatMock = Formats(textHTML: "", applicationEpubZip: "", applicationXMobipocketEbook: "", textPlainCharsetUsASCII: "", applicationRDFXML: "", imageJPEG: "https://www.gutenberg.org/cache/epub/84/pg84.cover.medium.jpg", applicationOctetStream: "", textHTMLCharsetUTF8: "", textPlainCharsetUTF8: "", textHTMLCharsetISO88591: "", textPlainCharsetISO88591: "", textHTMLCharsetUsASCII: "")
    
    static let mock = Book(id: 0, title: "test1", authors: [Author(name: "Ricardo", birthYear: 1989, deathYear: 2024)], translators: [Author(name: "Ricardo", birthYear: 1989, deathYear: 2024)], subjects: ["Moro Tech Interview"], bookshelves: ["CleanCode"], languages: [.en], copyright: true, mediaType: .text, formats: formatMock, downloadCount: 100)
    
    
    static let mockArray: Books = Books(count: 1000, next: "", previous: "", results:[
        Book(id: 0, title: "test1", authors: [Author(name: "Ricardo", birthYear: 1989, deathYear: 2024)], translators: [Author(name: "Ricardo", birthYear: 1989, deathYear: 2024)], subjects: ["Moro Tech Interview"], bookshelves: ["CleanCode"], languages: [.en], copyright: true, mediaType: .text, formats: formatMock, downloadCount: 100),
        Book(id: 1, title: "test1", authors: [Author(name: "Ricardo", birthYear: 1989, deathYear: 2024)], translators: [Author(name: "Ricardo", birthYear: 1989, deathYear: 2024)], subjects: ["Moro Tech Interview"], bookshelves: ["CleanCode"], languages: [.en], copyright: true, mediaType: .text, formats: formatMock, downloadCount: 100),
        Book(id: 2, title: "test1", authors: [Author(name: "Ricardo", birthYear: 1989, deathYear: 2024)], translators: [Author(name: "Ricardo", birthYear: 1989, deathYear: 2024)], subjects: ["Moro Tech Interview"], bookshelves: ["CleanCode"], languages: [.en], copyright: true, mediaType: .text, formats: formatMock, downloadCount: 100)
    ])
}
