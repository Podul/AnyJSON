//
//  JSONValueConvertible.swift
//  
//
//  Created by Podul on 2021/9/30.
//

import Foundation


// MARK: - JSONValueConvertible
public protocol JSONValueConvertible: Encodable {
    func jsonValue() -> JSONValue
}




// MARK: - Extension
extension Optional: JSONValueConvertible where Wrapped: JSONValueConvertible {
    public func jsonValue() -> JSONValue {
        switch self {
            case .none: return .null
            case .some(let wrapped): return wrapped.jsonValue()
        }
    }
}

extension String: JSONValueConvertible {
    public func jsonValue() -> JSONValue { .string(self) }
}

extension Int: JSONValueConvertible {
    public func jsonValue() -> JSONValue { .number(.int(self)) }
}

extension Double: JSONValueConvertible {
    public func jsonValue() -> JSONValue { .number(.double(self)) }
}

extension Array: JSONValueConvertible where Element: JSONValueConvertible {
    public func jsonValue() -> JSONValue {
        .array(map { $0.jsonValue() })
    }
}

extension Dictionary: JSONValueConvertible where Key == String, Value: JSONValueConvertible {
    public func jsonValue() -> JSONValue {
        .object(mapValues { $0.jsonValue() })
    }
}
