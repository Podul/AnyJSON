//
//  AnyJSON.swift
//  AnyJSON
//
//  Created by Podul on 2021/9/30.
//

import Foundation
import JSONValue


@dynamicMemberLookup
public struct AnyJSON {
    private let _value: JSONValue
    
    private init(value: JSONValue) {
        _value = value
    }
}

// MARK: - Encodable
extension AnyJSON: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(_value)
    }
}

// MARK: - Decodable
extension AnyJSON: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        _value = try container.decode(JSONValue.self)
    }
}

// MARK: - Subscript
extension AnyJSON {
    public subscript(dynamicMember value: String) -> Self {
        self[value]
    }
    
    public subscript(_ key: String) -> Self {
        switch _value {
            case .object(let dictionary):
                return AnyJSON(value: dictionary[key] ?? .null)
            default: return AnyJSON(value: .null)
        }
    }
}

// MARK: - Value
extension AnyJSON {
    public var stringValue: String? {
        switch _value {
            case .null: return nil
            case .bool(let value): return value.description
            case .number(let value): return value.description
            case .string(let value): return value
            case .array: return nil
            case .object: return nil
        }
    }
    
    public var boolValue: Bool? {
        switch _value {
            case .null: return nil
            case .bool(let value): return value
            case .number(let value):
                switch value {
                    case .int(let int):
                        return Bool(truncating: NSNumber(value: int))
                    case .double(let double):
                        return Bool(truncating: NSNumber(value: double))
                }
            case .string(let value): return Bool(value)
            case .array: return nil
            case .object: return nil
        }
    }
    
    public var intValue: Int? {
        switch _value {
            case .null: return nil
            case .bool(let value): return Int(truncating: NSNumber(booleanLiteral: value))
            case .number(let value):
                switch value {
                    case .int(let int): return int
                    case .double(let double): return Int(double)
                }
            case .string(let value): return Int(value)
            case .array: return nil
            case .object: return nil
        }
    }
    
    public var doubleValue: Double? {
        switch _value {
            case .null: return nil
            case .bool(let value): return Double(exactly: NSNumber(value: value))
            case .number(let value):
                switch value {
                    case .int(let int): return Double(int)
                    case .double(let double): return double
                }
            case .string(let value): return Double(value)
            case .array: return nil
            case .object: return nil
        }
    }
    
    public var arrayValue: [Any]? {
        switch _value {
            case .array(let value):
                return value.compactMap(\.anyValue)
            default: return nil
        }
    }
    
    public var dictValue: [String: Any]? {
        switch _value {
            case .object(let value):
                return value.compactMapValues(\.anyValue)
            default: return nil
        }
    }
    
    public var anyValue: Any? {
        _value.anyValue
    }
}

// MARK: -
extension AnyJSON: CustomStringConvertible {
    public var description: String {
        _value.description
    }
}

extension AnyJSON: Equatable {}
