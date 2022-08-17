//
//  LifeNodeField.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import UIKit


typealias NeighborCount = Int

final class LifeNodeField {
    
    static let shared = LifeNodeField()
    private init() {}
    
    var field:[LifeNodeHash:LifeNode] = [:]
    var counts:[LifeNodeHash:NeighborCount] = [:]
    
    // increase count at LifeNode
    func inc(_ w: LifeNode) {
        let c = counts[w.hashValue]
        counts[w.hashValue] = c == nil ? 1 : c! + 1
    }
    
    // decrease count at LifeNode
    func dec(_ w: LifeNode) {
        guard let c = counts[w.hashValue] else {return}
        if c != 0 {
            counts[w.hashValue] = c-1
        } else {
            counts.removeValue(forKey: w.hashValue)
        }
    }
    
    func set(_ w:LifeNode) {
        for p in w.neighbours {
            inc(p)
        }
        field[w.hashValue] = w
    }
    
    func reset(_ w:LifeNode) {
        for p in w.neighbours {
            inc(p)
        }
        field.removeValue(forKey: w.hashValue)
    }
    
    func step() {
        var toReset = [LifeNode]()
        var toSet = [LifeNode]()
        
        for (_,w) in field {
            if let c = counts[w.hashValue],
               c < 2 || c > 3 {
                toReset[w.hashValue] = w
            } else {
                toSet[w.hashValue] = w
            }
        }
        
        for w in toReset {
            reset(w)
        }
        
        for w in toSet {
            set(w)
        }
    }
}
