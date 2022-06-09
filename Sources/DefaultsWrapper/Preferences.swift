//
//  Preferences.swift
//
//
//  Created by Filippo Zaffoni on 08/06/22.
//

import Foundation

public struct Preferences {
    
    private init() { }
    
    /// Reset all `userDefaults` values to nil (except for keys to be ignored)
    public static func resetAll(except notToDelete: [String] = []) {
        let defaults = UserDefaults.standard
        let dict = defaults.dictionaryRepresentation()
        
        dict.keys.forEach { key in
            guard !notToDelete.contains(key) else { return }
            defaults.removeObject(forKey: key)
        }
    }
}
