//
//  DNSRenewMessage.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import BigInt
import Foundation

public enum DNSRenewMessage {
    public static func internalMessage(
        nftAddress: Address,
        dnsLinkAmount: BigUInt,
        stateInit _: StateInit?
    ) throws
        -> MessageRelaxed {
        let queryID = UInt64(Date().timeIntervalSince1970)
        let data = DNSRenewData(queryID: queryID)
        return try MessageRelaxed.internal(
            to: nftAddress,
            value: dnsLinkAmount,
            bounce: true,
            body: Builder().store(
                data
            ).endCell()
        )
    }
}
