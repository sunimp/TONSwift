//
//  RandomBytes.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import Foundation

public enum RandomBytes {
    // MARK: Nested Types

    public enum Error: Swift.Error {
        case failedGenerate(statusCode: Int)
        case other
    }
  
    // MARK: Static Functions

    public static func generate(length: Int) throws -> Data {
        var outputBuffer = Data(count: length)
        let resultCode = try outputBuffer.withUnsafeMutableBytes {
            guard let baseAddress = $0.baseAddress else {
                throw Error.other
            }
            return SecRandomCopyBytes(kSecRandomDefault, length, baseAddress)
        }
        guard resultCode == errSecSuccess else {
            throw Error.failedGenerate(statusCode: Int(resultCode))
        }
        return outputBuffer
    }
}
