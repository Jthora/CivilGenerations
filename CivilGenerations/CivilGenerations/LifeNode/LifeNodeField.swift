//
//  LifeNodeField.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import UIKit

let DX:Int64 = 0x100000000
let DY:Int64 = 1

typealias NeighborCount = Int

class LifeNodeField: ObservableObject {
    
    var field:[LifeNodeHash:LifeNode] = [:]
    var counts:[LifeNodeHash:NeighborCount] = [:]
    
    // increase count at LifeNode
    func inc(_ w: LifeNodeHash) {
        let c = counts[w]
        counts[w] = c == nil ? 1 : c! + 1
    }
    
    // decrease count at LifeNode
    func dec(_ w: LifeNodeHash) {
        guard let c = counts[w] else {return}
        if c != 0 {
            counts[w] = c-1
        } else {
            counts.removeValue(forKey: w)
        }
    }
    
//    func set(_ w:LifeNode) {
//        for p in w.neighbours {
//            inc(p.h)
//        }
//        field[w.h] = w
//    }
    
//    func reset(_ w:LifeNode) {
//        for p in w.neighbours {
//            dec(p.h)
//        }
//        field.removeValue(forKey: w.h)
//    }
    
    func set(_ point:CGPoint) {
        set(LifeNode(point))
    }
    
    func set(_ w:LifeNode) {
        print("set")
        inc(w.h-DX-DY)
        inc(w.h-DX)
        inc(w.h-DX+DY)
        inc(w.h-DY)
        inc(w.h+DY)
        inc(w.h+DX-DY)
        inc(w.h+DX)
        inc(w.h+DX+DY)
        field[w.h] = w
    }
    
    func reset(_ point:CGPoint) {
        reset(LifeNode(point))
    }
    
    func reset(_ w:LifeNode) {
        print("reset")
        dec(w.h-DX-DY)
        dec(w.h-DX)
        dec(w.h-DX+DY)
        dec(w.h-DY)
        dec(w.h+DY)
        dec(w.h+DX-DY)
        dec(w.h+DX)
        dec(w.h+DX+DY)
        field.removeValue(forKey: w.h)
    }
    
    func check(_ point:CGPoint) -> Bool {
        return field[LifeNodeHash(point)] != nil
    }
    
    func check(_ w:LifeNode) -> Bool {
        return field[w.h] != nil
    }
    
    func check(_ h:LifeNodeHash) -> Bool {
        return field[h] != nil
    }
    
    func clear() {
        field.removeAll()
        counts.removeAll()
    }
    
    func step() {
        var toReset = [LifeNode]()
        var toSet = [LifeNode]()
        
        for (_,w) in field {
            if let c = counts[w.h],
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
