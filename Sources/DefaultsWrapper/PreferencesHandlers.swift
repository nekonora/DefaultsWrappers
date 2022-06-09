//
//  PreferencesHandlers.swift
//
//
//  Created by Filippo Zaffoni on 07/06/22.
//

import Foundation

public protocol PlistCompatible { }

// MARK: - UserDefaults Compatibile Types
// Enables us to accept compatible types to be stored in defaults, if needed
extension String: PlistCompatible { }
extension Int: PlistCompatible { }
extension Double: PlistCompatible { }
extension Float: PlistCompatible { }
extension Bool: PlistCompatible { }
extension Date: PlistCompatible { }
extension Data: PlistCompatible { }
extension Array: PlistCompatible where Element: PlistCompatible { }
extension Dictionary: PlistCompatible where Key: PlistCompatible, Value: PlistCompatible { }

/// Handles saving and retrieving of a user default's value safely
/// Always valid, if value is nil in defaults, it returns the default value
@propertyWrapper
public struct Storage<Value: PlistCompatible> {
    
    public let key: String
    public let defaultValue: Value
    public let storage: UserDefaults
    
    public init(key: String, defaultValue: Value, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
    
    public var wrappedValue: Value {
        get {
            storage.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            storage.setValue(newValue, forKey: key)
            storage.synchronize()
        }
    }
}

/// Handles saving and retrieving of a user default's value safely
/// Returns nil if value was never written to defaults
@propertyWrapper
public struct OptionalStorage<Value: PlistCompatible> {
    
    public let key: String
    public let storage: UserDefaults
    
    public init(key: String, storage: UserDefaults = .standard) {
        self.key = key
        self.storage = storage
    }
    
    public var wrappedValue: Value? {
        get {
            storage.object(forKey: key) as? Value
        }
        set {
            storage.set(newValue, forKey: key)
            storage.synchronize()
        }
    }
}
