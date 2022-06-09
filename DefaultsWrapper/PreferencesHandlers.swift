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
public extension String: PlistCompatible { }
public extension Int: PlistCompatible { }
public extension Double: PlistCompatible { }
public extension Float: PlistCompatible { }
public extension Bool: PlistCompatible { }
public extension Date: PlistCompatible { }
public extension Data: PlistCompatible { }
public extension Array: PlistCompatible where Element: PlistCompatible { }
public extension Dictionary: PlistCompatible where Key: PlistCompatible, Value: PlistCompatible { }

/// Handles saving and retrieving of a user default's value safely
/// Always valid, if value is nil in defaults, it returns the default value
@propertyWrapper
public struct Storage<Value: PlistCompatible> {
    
    let key: String
    let defaultValue: Value
    let storage: UserDefaults = .standard
    
    var wrappedValue: Value {
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
    
    let key: String
    let storage: UserDefaults = .standard
    
    var wrappedValue: Value? {
        get {
            storage.object(forKey: key) as? Value
        }
        set {
            storage.set(newValue, forKey: key)
            storage.synchronize()
        }
    }
}
