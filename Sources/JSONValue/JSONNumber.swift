//
//  I am not responsible of this code.
//
//	JSONNumber.swift
//  
//	
//	Created by Podul on 2022/1/30
//	Copyright © 2022 Podul. All rights reserved.
//
//    ┌─┐       ┌─┐
// ┌──┘ ┴───────┘ ┴──┐
// │                 │
// │       ───       │
// │  ─┬┘       └┬─  │
// │                 │
// │       ─┴─       │
// │                 │
// └───┐         ┌───┘
//     │         │
//     │         │
//     │         │
//     │         └──────────────┐
//     │                        │
//     │                        ├─┐
//     │                        ┌─┘
//     │                        │
//     └─┐  ┐  ┌───────┬──┐  ┌──┘
//       │ ─┤ ─┤       │ ─┤ ─┤
//       └──┴──┘       └──┴──┘
// 
//
//


import Foundation

public enum JSONNumber {
    case int(Int)
    case double(Double)
}

// MARK: - Decodable
extension JSONNumber: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(Int.self) {
            self = .int(value)
        } else {
            self = .double(try container.decode(Double.self))
        }
    }
}

// MARK: - Encodable
extension JSONNumber: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .int(let value):
                try container.encode(value)
            case .double(let value):
                try container.encode(value)
        }
    }
}


extension JSONNumber {
    var anyValue: Any {
        switch self {
            case .int(let int): return int
            case .double(let double): return double
        }
    }
}


// MARK: - Extension
extension JSONNumber: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    public init(integerLiteral value: Int) {
        self = .int(value)
    }
}

extension JSONNumber: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .double(value)
    }
    
    public typealias FloatLiteralType = Double
}


extension JSONNumber: CustomStringConvertible {
    public var description: String {
        switch self {
            case .int(let value): return value.description
            case .double(let value): return value.description
        }
    }
}


extension JSONNumber: Equatable {}
