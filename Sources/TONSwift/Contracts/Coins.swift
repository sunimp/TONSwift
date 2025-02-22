//
//  Coins.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import BigInt
import Foundation

// MARK: - Coins

/// 128-bit integer representing base TON currency: toncoins (aka `grams` in block.tlb).
public struct Coins {
    // MARK: Properties

    var amount: BigUInt
    
    // MARK: Lifecycle

    init(_ a: some BinaryInteger) {
        // we use signed integer here because of `0` literal is a signed Int.
        amount = BigUInt(a)
    }
}

// MARK: RawRepresentable

extension Coins: RawRepresentable {
    public typealias RawValue = BigUInt

    public init?(rawValue: BigUInt) {
        amount = rawValue
    }

    public var rawValue: BigUInt {
        return amount
    }
}

// MARK: CellCodable

extension Coins: CellCodable {
    public func storeTo(builder: Builder) throws {
        try builder.store(varuint: amount, limit: 16)
    }

    public static func loadFrom(slice: Slice) throws -> Coins {
        return try Coins(slice.loadVarUintBig(limit: 16))
    }
}

extension Slice {
    /// Loads Coins value
    public func loadCoins() throws -> Coins {
        return try loadType()
    }
    
    /// Preloads Coins value
    public func preloadCoins() throws -> Coins {
        return try preloadType()
    }
    
    /// Load optionals Coins value.
    public func loadMaybeCoins() throws -> Coins? {
        if try loadBoolean() {
            return try loadCoins()
        }
        return nil
    }
}

extension Builder {
    /// Write coins amount in varuint format
    @discardableResult
    func store(coins: Coins) throws -> Self {
        return try store(varuint: coins.amount, limit: 16)
    }
    
    /// Store optional coins value
    /// @param amount amount of coins, null or undefined
    /// @returns this builder
    @discardableResult
    public func storeMaybe(coins: Coins?) throws -> Self {
        if let coins {
            try store(bit: true)
            try store(coins: coins)
        } else {
            try store(bit: false)
        }
        return self
    }
}
