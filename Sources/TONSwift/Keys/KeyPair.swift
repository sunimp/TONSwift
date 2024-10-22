//
//  KeyPair.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import Foundation

public struct KeyPair: Codable {
    // MARK: Properties

    public let publicKey: PublicKey
    public let privateKey: PrivateKey
    
    // MARK: Lifecycle

    public init(
        publicKey: PublicKey,
        privateKey: PrivateKey
    ) {
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
}
