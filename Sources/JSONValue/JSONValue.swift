//
//  JSONValue.swift
//  JSONValue
//
//  Created by Podul on 2021/9/30.
//

import Foundation


// MARK: - JSONValue
public enum JSONValue {
    case null
    case bool(Bool)
    case number(JSONNumber)
    case string(String)
    case array([JSONValue])
    case object([String: JSONValue])
}

extension JSONValue {
    public var anyValue: Any? {
        switch self {
            case .null: return nil
            case .bool(let value): return value
            case .number(let value): return value.anyValue
            case .string(let value): return value
            case .array(let value): return value.compactMap(\.anyValue)
            case .object(let value): return value.compactMapValues(\.anyValue)
        }
    }
}

// MARK: -
extension JSONValue: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .null:
                try container.encodeNil()
            case .bool(let value):
                try container.encode(value)
            case .number(let value):
                try container.encode(value)
            case .string(let value):
                try container.encode(value)
            case .array(let value):
                try container.encode(value)
            case .object(let value):
                try container.encode(value)
        }
    }
}

extension JSONValue: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .null
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode(JSONNumber.self) {
            self = .number(value)
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode([JSONValue].self) {
            self = .array(value)
        } else {
            self = .object(try container.decode([String: JSONValue].self))
        }
    }
}

extension JSONValue: Equatable {
    
}

extension JSONValue: CustomStringConvertible {
    public var description: String {
        switch self {
            case .null: return "null"
            case .bool(let value): return value.description
            case .number(let value): return value.description
            case .string(let value): return value.description
            case .array(let value): return value.description
            case .object(let value): return value.description
        }
    }
}
