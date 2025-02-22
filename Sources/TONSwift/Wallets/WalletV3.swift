//
//  WalletV3.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import BigInt
import Foundation
import TweetNacl

// MARK: - WalletContractV3Revision

public enum WalletContractV3Revision {
    case r1
    case r2
}

// MARK: - WalletV3

public final class WalletV3: WalletContract {
    // MARK: Properties

    public let workchain: Int8
    public let stateInit: StateInit
    public let publicKey: Data
    public let walletID: UInt64
    public let revision: WalletContractV3Revision
    
    // MARK: Lifecycle

    public init(workchain: Int8, publicKey: Data, walletID: UInt64? = nil, revision: WalletContractV3Revision) throws {
        self.workchain = workchain
        self.publicKey = publicKey
        self.revision = revision
        
        if let walletID {
            self.walletID = walletID
        } else {
            self.walletID = 698983191 + UInt64(workchain)
        }
        
        let bocString =
            switch revision {
            case .r1:
                "te6cckEBAQEAYgAAwP8AIN0gggFMl7qXMO1E0NcLH+Ck8mCDCNcYINMf0x/TH/gjE7vyY+1E0NMf0x/T/9FRMrryoVFEuvKiBPkBVBBV+RDyo/gAkyDXSpbTB9QC+wDo0QGkyMsfyx/L/8ntVD++buA="
            
            case .r2:
                "te6cckEBAQEAcQAA3v8AIN0gggFMl7ohggEznLqxn3Gw7UTQ0x/THzHXC//jBOCk8mCDCNcYINMf0x/TH/gjE7vyY+1E0NMf0x/T/9FRMrryoVFEuvKiBPkBVBBV+RDyo/gAkyDXSpbTB9QC+wDo0QGkyMsfyx/L/8ntVBC9ba0="
            }
        
        let cell = try Cell.fromBoc(src: Data(base64Encoded: bocString)!)[0]
        let data = try Builder()
            .store(uint: UInt64(0), bits: 32) // Seqno
            .store(uint: self.walletID, bits: 32)
        try data.store(data: publicKey)
        
        stateInit = try StateInit(code: cell, data: data.endCell())
    }
    
    // MARK: Functions

    public func createTransfer(args: WalletTransferData, messageType _: MessageType = .ext) throws -> WalletTransfer {
        guard args.messages.count <= 4 else {
            throw TonError.custom("Maximum number of messages in a single transfer is 4")
        }
        
        let signingMessage = try Builder().store(uint: walletID, bits: 32)
        let defaultTimeout = UInt64(Date().timeIntervalSince1970) + 60 // Default timeout: 60 seconds
        try signingMessage.store(uint: args.timeout ?? defaultTimeout, bits: 32)
        
        try signingMessage.store(uint: args.seqno, bits: 32)
        for message in args.messages {
            try signingMessage.store(uint: UInt64(args.sendMode.rawValue), bits: 8)
            try signingMessage.store(ref: Builder().store(message))
        }
        
        return WalletTransfer(signingMessage: signingMessage, signaturePosition: .front)
    }
}
