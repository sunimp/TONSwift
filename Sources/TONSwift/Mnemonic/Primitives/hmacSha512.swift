//
//  hmacSha512.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import CommonCrypto
import Foundation

public func hmacSha512(phrase: String, password: String) -> Data {
    let count = Int(CC_SHA512_DIGEST_LENGTH)
    var digest = [UInt8](repeating: 0, count: count)
    CCHmac(
        CCHmacAlgorithm(kCCHmacAlgSHA512),
        phrase,
        phrase.count,
        password,
        password.count,
        &digest
    )
    
    return Data(bytes: digest, count: count)
}
