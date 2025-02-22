//
//  StonfiConstants.swift
//  TONSwift
//
//  Created by Sun on 2024/10/22.
//

import BigInt

// MARK: - DEX_VERSION

enum DEX_VERSION: String {
    case v1
}

// MARK: - STONFI_CONSTANTS

public enum STONFI_CONSTANTS {
    // MARK: Nested Types

    public enum SWAP_JETTON_TO_JETTON {
        public static var GasAmount: BigUInt {
            BigUInt("265000000")
        }

        public static var ForwardGasAmount: BigUInt {
            BigUInt("205000000")
        }
    }
  
    public enum SWAP_JETTON_TO_TON {
        public static var GasAmount: BigUInt {
            BigUInt("185000000")
        }

        public static var ForwardGasAmount: BigUInt {
            BigUInt("125000000")
        }
    }
  
    public enum SWAP_TON_TO_JETTON {
        public static var ForwardGasAmount: BigUInt {
            BigUInt("215000000")
        }
    }

    // MARK: Static Computed Properties

    public static var RouterAddress: String {
        "0:779dcc815138d9500e449c5291e7f12738c23d575b5310000f6a253bd607384e"
    }
  
    public static var TONProxyAddress: String {
        "0:8cdc1d7640ad5ee326527fc1ad0514f468b30dc84b0173f0e155f451b4e11f7c"
    }
}
