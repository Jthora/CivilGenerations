//
//  GameLifeSpriteNodeIconType.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import Foundation
import SpriteKit

extension GameLifeSpriteNode {
    enum IconType: Int {
        case land = 0
        case farm = 1
        case home = 2
        case city = 3
        case ruin = 4
        
        init(_ c: Int) {
            guard c < 4 else {
                self = .ruin
                return
            }
            self = IconType(rawValue: c) ?? .land
        }
        
        var text: String {
            switch self {
                case .land: return "Land"
                case .farm: return "Farm"
                case .home: return "Home"
                case .city: return "City"
                case .ruin: return "Ruin"
            }
        }
        
        var labelNode: SKLabelNode {
            return SKLabelNode(text: emoji)
        }
        
        var emoji: String {
            switch self {
                case .land: return "π³"
                case .farm: return "π"
                case .home: return "π "
                case .city: return "π’"
                case .ruin: return "π₯"
            }
//            switch self {
//                case .land: return ["π²","π΄","π³","π±","πΎ","π΅","πΏ","π","β°","π»"].randomElement()! as String
//                case .farm: return ["π","βΊοΈ","π","π","π§","π ","βοΈ","π¨","β","πͺ","π"].randomElement()! as String
//                case .home: return ["π ","π‘","π"].randomElement()! as String
//                case .city: return ["π’","π¬","π£","π€","π₯","π¦","π¨","πͺ","π«","π©","π","βͺοΈ","π­","π","π","π","π"].randomElement()! as String
//                case .ruin: return ["π","π₯","π","πͺ","π₯","π£","β οΈ","π","π»","β’οΈ","β£οΈ","β οΈ","π¨","π¦"].randomElement()! as String
//            }
        }
        
        var lifeNodeState: LifeNode.State {
            switch self {
                case .land, .ruin: return .dead
                default: return .live
            }
        }
    }
}
