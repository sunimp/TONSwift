//
//  Contract.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import BigInt
import Foundation

// MARK: - Contract

/// Common interface for all contracts that allows computing contract addresses and messages
public protocol Contract {
    var workchain: Int8 { get }
    var stateInit: StateInit { get }
    func address() throws -> Address
}

extension Contract {
    public func address() throws -> Address {
        let hash = try Builder().store(stateInit).endCell().hash()
        return Address(workchain: workchain, hash: hash)
    }
}

// MARK: - ContractState

public struct ContractState {
    let balance: BigInt
    let last: ContractStateLast?
    let state: ContractStateStatus
}

// MARK: - ContractStateLast

public struct ContractStateLast {
    let lt: BigInt
    let hash: Data
}

// MARK: - ContractStateStatus

public enum ContractStateStatus {
    case uninit
    case active(code: Data?, data: Data?)
    case frozen(stateHash: Data?)
}

// MARK: - OpaqueContract

public struct OpaqueContract: Contract {
    // MARK: Properties

    public let workchain: Int8
    public let stateInit: StateInit
    
    // MARK: Lifecycle

    init(workchain: Int8, stateInit: StateInit) {
        self.workchain = workchain
        self.stateInit = stateInit
    }
}
