//
//  GameLifeSpriteNode.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import SpriteKit

class GameLifeSpriteNode: SKSpriteNode {
    
    var generationsUntilDecay:Int = 2
    
    var labelNode:SKLabelNode? = nil
    
    private var _iconType:IconType = .land
    var iconType:IconType {
        set {
            //guard _iconType != newValue else {return}
            _iconType = newValue
            guard let labelNode = self.labelNode else {
                labelNode = iconType.labelNode
                addChild(labelNode!)
                return
            }
            labelNode.text = iconType.emoji
        }
        
        get {
            return _iconType
        }
    }
    
    func decay() {
        generationsUntilDecay -= 1
        if generationsUntilDecay <= 0 {
            iconType = .land
        }
    }
}
