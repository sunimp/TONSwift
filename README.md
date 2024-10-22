# TONSwift

Pure Swift implementation of TON core data structures: integers, bitstrings, cells, bags of cells, contracts and messages.

The focus of the library is type safety and serialization. It does not support connectivity to TON p2p network, or Toncenter, Tonapi.io etc.

## Requirements

* Xcode 15.4+
* Swift 5.10+
* iOS 14.0+

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/sunimp/TONSwift", .upToNextMajor(from: "1.0.0"))
]
```

# License

The `TONSwift` toolkit is open source and available under the terms of the MIT License.
