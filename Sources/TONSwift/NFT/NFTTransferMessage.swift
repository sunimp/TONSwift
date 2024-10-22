//
//  NFTTransferMessage.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import BigInt
import Foundation

public enum NFTTransferMessage {
    public static func internalMessage(
        nftAddress: Address,
        nftTransferAmount: BigUInt,
        bounce: Bool,
        to: Address,
        from: Address,
        forwardPayload: Cell?
    ) throws
        -> MessageRelaxed {
        let forwardAmount = BigUInt(stringLiteral: "1")
        let queryID = UInt64(Date().timeIntervalSince1970)
        
        let nftTransferData = NFTTransferData(
            queryID: queryID,
            newOwnerAddress: to,
            responseAddress: from,
            forwardAmount: forwardAmount,
            forwardPayload: forwardPayload
        )
        
        return try MessageRelaxed.internal(
            to: nftAddress,
            value: nftTransferAmount,
            bounce: bounce,
            body: Builder().store(nftTransferData).endCell()
        )
    }
}
