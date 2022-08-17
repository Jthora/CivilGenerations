//
//  LifeNode.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import UIKit


let OFFSET:Int32 = Int32(bitPattern: 0x80000000)
let CONVERSION_SCALE:CGFloat = 32

typealias LifeNodeHash = Int64

struct LifeNode
{
    // Coordinates Hash
    var h: LifeNodeHash
    
    // Coordinates
    var x: Int { return Int(h.hi) }
    var y: Int { return Int(h.lo) }
    
    init(_ point:CGPoint)
    {
        self.h = Int64(hi: Int32(point.x), lo: Int32(point.y))
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
    var gridPointString:String {
        return "(\(Int(CGFloat(x)/CONVERSION_SCALE)),\(Int(CGFloat(y)/CONVERSION_SCALE)))"
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


extension LifeNodeHash {
    init(_ point:CGPoint) {
        let x = Int(point.x / CONVERSION_SCALE)
        let y = Int(point.y / CONVERSION_SCALE)
        self = Int64(hi: Int32(x), lo: Int32(y))
    }
    var position:CGPoint {
        let x = hi //&+ OFFSET
        let y = lo //&+ OFFSET
        return CGPoint(x: Int(x)*Int(CONVERSION_SCALE), y: Int(y)*Int(CONVERSION_SCALE))
    }
}
