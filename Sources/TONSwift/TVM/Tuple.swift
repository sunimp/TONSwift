//
//  Tuple.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import BigInt
import Foundation

public enum Tuple {
    case tuple(items: [Tuple])
    case null
    case int(value: BigInt)
    case nan
    case cell(cell: Cell)
    case slice(cell: Cell)
    case builder(cell: Cell)
}
