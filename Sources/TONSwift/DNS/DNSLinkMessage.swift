//
//  DNSLinkMessage.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import BigInt
import Foundation

public enum DNSLinkMessage {
    public static func internalMessage(
        nftAddress: Address,
        linkAddress: Address?,
        dnsLinkAmount: BigUInt,
        stateInit _: StateInit?
    ) throws
        -> MessageRelaxed {
        let queryID = UInt64(Date().timeIntervalSince1970)
        let data = DNSLinkData(
            queryID: queryID,
            linkAddress: linkAddress
        )
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
