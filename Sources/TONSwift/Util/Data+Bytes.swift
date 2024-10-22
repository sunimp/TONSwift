//
//  Data+Bytes.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import Foundation

extension Data {
    var bytes: Data {
        return Data(map { UInt8($0) })
    }
}
