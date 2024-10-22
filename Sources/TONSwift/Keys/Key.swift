//
//  Key.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import Foundation

// MARK: - Key

public protocol Key {
    var data: Data { get }
    var hexString: String { get }
}

extension Key {
    public var hexString: String { data.hexString() }
}
