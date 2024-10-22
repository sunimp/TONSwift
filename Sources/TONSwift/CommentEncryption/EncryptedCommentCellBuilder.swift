//
//  EncryptedCommentCellBuilder.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import Foundation

public enum EncryptedCommentCellBuilder {
    public static func buildCell(encryptedData: Data) throws -> Cell {
        let opCodeData = Data(withUnsafeBytes(of: OpCodes.ENCRYPTED_COMMENT.bigEndian, Array.init))
        let payloadData = opCodeData + encryptedData
    
        let builder = Builder()
        return try builder.writeSnakeData(payloadData).endCell()
    }
}
