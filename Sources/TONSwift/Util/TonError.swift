//
//  TonError.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import Foundation

// MARK: - TonError

public enum TonError: Error, Equatable {
    case indexOutOfBounds(Int)
    case offsetOutOfBounds(Int)
    case custom(String)
    case varUIntOutOfBounds(limit: Int, actualBits: Int)
}

// MARK: CustomDebugStringConvertible

extension TonError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case let .indexOutOfBounds(index):
            return "Index \(index) is out of bounds"
            
        case let .offsetOutOfBounds(offset):
            return "Offset \(offset) is out of bounds"
        
        case let .varUIntOutOfBounds(limit, actualBits):
            return "VarUInteger is out of bounds: the (VarUInt \(limit)) specifies max size \((limit - 1) * 8) bits long, but the actual number is \(actualBits) bits long"
            
        case let .custom(text):
            return text
        }
    }
}
