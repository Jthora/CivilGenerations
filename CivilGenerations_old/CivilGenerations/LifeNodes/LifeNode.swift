//
//  LifeNode.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import UIKit


let OFFSET:Int32 = Int32(truncatingIfNeeded: 0x80000000)

typealias LifeNodeHash = Int64

struct LifeNode
{
    // Coordinates Hash
    var h: LifeNodeHash
    
    // Coordinates
    var x: Int32 { return h.hi - OFFSET }
    var y: Int32 { return h.lo - OFFSET }
    
    init(_ point:CGPoint)
    {
        self.h = Int64(hi: Int32(point.x) + OFFSET, lo: Int32(point.y) + OFFSET)
    }
    
    init(x: Int32, y: Int32)
    {
        self.h = Int64(hi: x, lo: y)
    }
    
    var string:String {
        return "(\(x),\(y))";
    }
    
//    var neighbours:[LifeNode] {
//        return [LifeNode(x: x-1, y: y-1),
//                LifeNode(x: x-1, y: y),
//                LifeNode(x: x-1, y: y+1),
//                LifeNode(x: x, y: y-1),
//                LifeNode(x: x, y: y+1),
//                LifeNode(x: x+1, y: y-1),
//                LifeNode(x: x+1, y: y),
//                LifeNode(x: x+1, y: y+1)]
//    }
    
    var point:CGPoint {
        return CGPoint(x: Int(x), y: Int(y))
    }
}

extension LifeNode: Equatable {
    static func == (lhs: LifeNode, rhs: LifeNode) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y;
    }
}

extension LifeNode: Hashable {
    
    var hashValue: Int {
        return Int(h)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(h)
    }
}
