//
//  MessageRelaxedTest.swift
//  TONSwiftTests
//
//  Created by Sun on 2024/10/22.
//

@testable import TONSwift
import XCTest

final class MessageRelaxedTest: XCTestCase {
    func testMessageRelaxed() throws {
        // should parse message relaxed
        let state =
            "te6ccsEBAgEAkQA3kQFoYgBgSQkXjXbkhpC1sju4zUJsLIAoavunKbfNsPFbk9jXL6BfXhAAAAAAAAAAAAAAAAAAAQEAsA+KfqUAAAAAAAAAAEO5rKAIAboVCXedy2J0RCseg4yfdNFtU8/BfiaHVEPkH/ze1W+fABicYUqh1j9Lnqv9ZhECm0XNPaB7/HcwoBb3AJnYYfqByAvrwgCqR2XE"
        let cell = try Cell.fromBoc(src: Data(base64Encoded: state)!)[0]
        let relaxed = try MessageRelaxed.loadFrom(slice: cell.beginParse())
        let stored = try Builder().store(relaxed).endCell()
        XCTAssertEqual(stored, cell)
    }
}
