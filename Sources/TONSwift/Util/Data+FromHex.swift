//
//  Data+FromHex.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import Foundation

extension Data {
    public init?(hex: String) {
        let len = hex.count / 2
        var data = Data(capacity: len)
        var i = hex.startIndex
        
        for _ in 0 ..< len {
            let j = hex.index(i, offsetBy: 2)
            let bytes = hex[i ..< j]
            
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
            
            i = j
        }
        
        self = data
    }
}
