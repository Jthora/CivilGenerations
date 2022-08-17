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
    func inc(_ h: LifeNodeHash) {
        let c = counts[h]
        counts[h] = c == nil ? 1 : c! + 1
        print("inc: [\(h):\(counts[h]!)]")
    }
    
    // decrease count at LifeNode
    func dec(_ h: LifeNodeHash) {
        print("dec: count: \(counts.count)")
        guard let c = counts[h] else {
            print("dec: count not found")
            return
        }
        if c != 0 {
            print("dec: dec [\(h):\(counts[h]!)]")
            counts[h] = c-1
        }
        print("dec: count inc: [\(h):\(counts[h]!)]")
        if counts[h]! <= 0 {
            print("dec: remove")
            counts.removeValue(forKey: h)
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
        print("set: \(w.string)")
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
        print("reset: \(w.string)")
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
        print("step")
        var toReset = [LifeNodeHash:LifeNode]()
        var toSet = [LifeNodeHash:LifeNode]()
        
        for (_,w) in field {
            if let c = counts[w.h],
               c < 2 || 3 < c {
                print("toReset: \(w.gridPointString)")
                toReset[w.h] = w
            } else {
                print("toSet: \(w.gridPointString)")
                toSet[w.h] = w
            }
        }
        
        for (_,w) in toReset {
            reset(w)
        }
        
        for (_,w) in toSet {
            set(w)
        }
    }
}
