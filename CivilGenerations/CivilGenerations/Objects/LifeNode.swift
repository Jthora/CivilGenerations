//
//  LifeNode.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import UIKit

let X_HASH_MULTI = 3
let Y_HASH_MULTI = 5

typealias LifeNodeHash = Int

struct LifeNode
{
    var point:CGPoint {
        return CGPoint(x: x, y: y)
    }
    
    var x: Int
    var y: Int
    
    init(_ point:CGPoint)
    {
        self.x = Int(point.x)
        self.y = Int(point.y)
    }
    
    init(x: Int, y: Int)
    {
        self.x = x
        self.y = y
    }
    
    var string:String {
        return "(\(x),\(y))";
    }
    
    var neighbours:[LifeNode] {
        return [LifeNode(x: x-1, y: y-1),
                LifeNode(x: x-1, y: y),
                LifeNode(x: x-1, y: y+1),
                LifeNode(x: x, y: y-1),
                LifeNode(x: x, y: y+1),
                LifeNode(x: x+1, y: y-1),
                LifeNode(x: x+1, y: y),
                LifeNode(x: x+1, y: y+1)]
    }
}

extension LifeNode: Equatable {
    static func == (lhs: LifeNode, rhs: LifeNode) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y;
    }
}

extension LifeNode: Hashable {
    var hashValue: Int {
        return (x*X_HASH_MULTI) + (y*Y_HASH_MULTI)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x*3)
        hasher.combine(y*5)
    }
}
