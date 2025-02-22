//
//  CommonMsgInfoRelaxed.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import Foundation

// MARK: - CommonMsgInfoRelaxedInternal

// Source:
// https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L132
// int_msg_info$0 ihr_disabled:Bool
//               bounce:Bool
//               bounced:Bool
//               src:MsgAddress
//               dest:MsgAddressInt
//               value:CurrencyCollection
//               ihr_fee:Grams
//               fwd_fee:Grams
//               created_lt:uint64
//               created_at:uint32 = CommonMsgInfoRelaxed;
//
//
//
//
// ext_out_msg_info$11 src:MsgAddress
//                    dest:MsgAddressExt
//                    created_lt:uint64
//                    created_at:uint32 = CommonMsgInfoRelaxed;

public struct CommonMsgInfoRelaxedInternal {
    public let ihrDisabled: Bool
    public let bounce: Bool
    public let bounced: Bool
    public let src: AnyAddress
    public let dest: Address
    public let value: CurrencyCollection
    public let ihrFee: Coins
    public let forwardFee: Coins
    public let createdLt: UInt64
    public let createdAt: UInt32
}

// MARK: - CommonMsgInfoRelaxedExternalOut

public struct CommonMsgInfoRelaxedExternalOut {
    public let src: AnyAddress
    public let dest: ExternalAddress?
    public let createdLt: UInt64
    public let createdAt: UInt32
}

// MARK: - CommonMsgInfoRelaxed

public enum CommonMsgInfoRelaxed: CellCodable {
    case internalInfo(info: CommonMsgInfoRelaxedInternal)
    case externalOutInfo(info: CommonMsgInfoRelaxedExternalOut)
    
    // MARK: Static Functions

    public static func loadFrom(slice: Slice) throws -> CommonMsgInfoRelaxed {
        // Internal message
        if try !(slice.loadBoolean()) {
            let ihrDisabled = try slice.loadBoolean()
            let bounce = try slice.loadBoolean()
            let bounced = try slice.loadBoolean()
            let src: AnyAddress = try slice.loadType()
            let dest: Address = try slice.loadType()
            let value: CurrencyCollection = try slice.loadType()
            let ihrFee = try slice.loadCoins()
            let forwardFee = try slice.loadCoins()
            let createdLt = try slice.loadUint(bits: 64)
            let createdAt = try UInt32(slice.loadUint(bits: 32))
            
            return CommonMsgInfoRelaxed.internalInfo(
                info: .init(
                    ihrDisabled: ihrDisabled,
                    bounce: bounce,
                    bounced: bounced,
                    src: src,
                    dest: dest,
                    value: value,
                    ihrFee: ihrFee,
                    forwardFee: forwardFee,
                    createdLt: createdLt,
                    createdAt: createdAt
                )
            )
        }
        
        // External In message
        if try !(slice.loadBoolean()) {
            throw TonError.custom("External In message is not possible for CommonMessageInfoRelaxed")
        } else {
            // External Out mesage
            let src: AnyAddress = try slice.loadType()
            let dest: AnyAddress = try slice.loadType()
            let createdLt = try slice.loadUint(bits: 64)
            let createdAt = try UInt32(slice.loadUint(bits: 32))
            
            return try CommonMsgInfoRelaxed.externalOutInfo(
                info: .init(
                    src: src,
                    dest: dest.asExternal(),
                    createdLt: createdLt,
                    createdAt: createdAt
                )
            )
        }
    }
    
    // MARK: Functions

    public func storeTo(builder: Builder) throws {
        switch self {
        case let .internalInfo(info):
            try builder.store(bit: false)
            try builder.store(bit: info.ihrDisabled)
            try builder.store(bit: info.bounce)
            try builder.store(bit: info.bounced)
            try builder.store(info.src)
            try builder.store(AnyAddress(info.dest))
            try builder.store(info.value)
            try builder.store(coins: info.ihrFee)
            try builder.store(coins: info.forwardFee)
            try builder.store(uint: info.createdLt, bits: 64)
            try builder.store(uint: UInt64(info.createdAt), bits: 32)
            
        case let .externalOutInfo(info):
            try builder.store(bit: true)
            try builder.store(bit: true)
            try builder.store(info.src)
            try builder.store(AnyAddress(info.dest))
            try builder.store(uint: info.createdLt, bits: 64)
            try builder.store(uint: UInt64(info.createdAt), bits: 32)
        }
    }
}
