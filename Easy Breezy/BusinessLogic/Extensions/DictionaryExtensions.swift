//
//  DictionaryExtensions.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 29.04.2023.
//

import Foundation

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
