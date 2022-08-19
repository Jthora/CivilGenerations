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
        Debug.log("inc: [\(LifeNode(h: h).gridPointString):\(counts[h]!)]")
    }
    
    // decrease count at LifeNode
    func dec(_ h: LifeNodeHash) {
        Debug.log("dec: count: \(counts.count)")
        guard let c = counts[h] else {
            Debug.log("dec: count not found")
            return
        }
        if c != 0 {
            Debug.log("dec: dec [\(h):\(counts[h]!)]")
            counts[h] = c-1
        }
        Debug.log("dec: count inc: [\(h):\(counts[h]!)]")
        if counts[h]! <= 0 {
            Debug.log("dec: remove")
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
        Debug.log("set: \(w.string)")
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
        Debug.log("reset: \(w.string)")
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
        Debug.log("step")
        var toReset = [LifeNodeHash:LifeNode]()
        var toSet = [LifeNodeHash:LifeNode]()
        
        for (_,w) in field {
            if let c = counts[w.h] {
                Debug.log("toReset: \(w.gridPointString)")
                if c < 2 || 3 < c {
                    toReset[w.h] = w
                }
            } else {
                toReset[w.h] = w
            }
        }
        
        for (h,c) in counts {
            if c == 3,
                field[h] == nil {
                Debug.log("toSet: c: \(c)")
                toSet[h] = LifeNode(h: h)
            }
        }
        
//        for (Point w : counts.keySet ()) {
//            if (counts.get (w) == 3 && ! field.contains (w)) toSet.add (w);
//        }
        
        for (_,w) in toReset {
            reset(w)
        }
        
        for (_,w) in toSet {
            set(w)
        }
    }
//
//    public void step ()
//    {
//        ArrayList<Point> toReset = new ArrayList<Point> ();
//        ArrayList<Point> toSet = new ArrayList<Point> ();
//        for (Point w : field) {
//            Integer c = counts.get (w);
//            if (c == null || c < 2 || c > 3) toReset.add (w);
//        }
//        for (Point w : counts.keySet ()) {
//            if (counts.get (w) == 3 && ! field.contains (w)) toSet.add (w);
//        }
//        for (Point w : toReset) {
//            reset (w);
//        }
//        for (Point w : toSet) {
//            set (w);
//        }
//    }
}
