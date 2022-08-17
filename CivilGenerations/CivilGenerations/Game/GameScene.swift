//
//  GameScene.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import SpriteKit
import Combine

protocol GameSceneDelegate {
    func update()
}

class GameScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        print("You are in the game scene!")
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
    }
}
