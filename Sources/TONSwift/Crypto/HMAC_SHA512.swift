//
//  HMAC_SHA512.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import CommonCrypto
import Foundation

public enum HMAC_SHA512 {
    public static func hmacSha512(message: Data, key: Data) -> Data {
        let count = Int(CC_SHA512_DIGEST_LENGTH)
        var outputBuffer = [UInt8](repeating: 0, count: count)
    
        key.withUnsafeBytes { bufferPointer in
            guard let keyPointer = bufferPointer.baseAddress else {
                return
            }
            message.withUnsafeBytes { bufferPointer in
                guard let messagePointer = bufferPointer.baseAddress else {
                    return
                }
                CCHmac(
                    CCHmacAlgorithm(
                        kCCHmacAlgSHA512
                    ),
                    keyPointer,
                    key.count,
                    messagePointer,
                    message.count,
                    &outputBuffer
                )
            }
        }
        return Data(bytes: outputBuffer, count: count)
    }
}
