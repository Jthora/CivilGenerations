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
                case .land: return "🌳"
                case .farm: return "🏕"
                case .home: return "🏠"
                case .city: return "🏢"
                case .ruin: return "🔥"
            }
//            switch self {
//                case .land: return ["🌲","🌴","🌳","🌱","🌾","🌵","🌿","🏔","⛰","🗻"].randomElement()! as String
//                case .farm: return ["🏗","⛺️","🏕","🛖","🚧","🛠","⚒️","🔨","⛏","🪓","🚜"].randomElement()! as String
//                case .home: return ["🏠","🏡","🏘"].randomElement()! as String
//                case .city: return ["🏢","🏬","🏣","🏤","🏥","🏦","🏨","🏪","🏫","🏩","💒","⛪️","🏭","🏛","🕍","🕌","🏟"].randomElement()! as String
//                case .ruin: return ["🏚","🔥","🌋","🌪","💥","💣","☠️","💀","👻","☢️","☣️","⚠️","🚨","🦖"].randomElement()! as String
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
