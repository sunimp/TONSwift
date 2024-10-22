//
//  String+Subscript.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import Foundation

extension String {
    public subscript(_ idx: Int) -> Character {
        self[index(startIndex, offsetBy: idx)]
    }
}
