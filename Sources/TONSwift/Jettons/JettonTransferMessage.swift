//
//  JettonTransferMessage.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import BigInt
import Foundation

public enum JettonTransferMessage {
    public static func internalMessage(
        jettonAddress: Address,
        amount: BigInt,
        bounce: Bool,
        to: Address,
        from: Address,
        comment: String? = nil,
        customPayload: Cell? = nil,
        stateInit: StateInit? = nil
    ) throws
        -> MessageRelaxed {
        let forwardAmount = BigUInt(stringLiteral: "1")
        let jettonTransferAmount = BigUInt(stringLiteral: "640000000")
        let queryID = UInt64(Date().timeIntervalSince1970)
      
        var commentCell: Cell?
        if comment != nil, comment != "" {
            commentCell = try Builder().store(int: 0, bits: 32).writeSnakeData(Data(comment!.utf8)).endCell()
        }
        
        let jettonTransferData = JettonTransferData(
            queryID: queryID,
            amount: amount.magnitude,
            toAddress: to,
            responseAddress: from,
            forwardAmount: forwardAmount,
            forwardPayload: commentCell,
            customPayload: customPayload
        )
        
        return try MessageRelaxed.internal(
            to: jettonAddress,
            value: jettonTransferAmount,
            bounce: bounce,
            stateInit: stateInit,
            body: Builder().store(jettonTransferData).endCell()
        )
    }
}
