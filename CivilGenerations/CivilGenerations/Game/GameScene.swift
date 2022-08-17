//
//  GameScene.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import SpriteKit
import Combine

protocol GameSceneDelegate {
    func updateGame()
    func onTouch(point: CGPoint)
}

class GameScene: SKScene {
    
    var gameDelegate: GameSceneDelegate? = nil
    
    override func didMove(to view: SKView) {
        print("You are in the game scene!")
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        gameDelegate?.updateGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        gameDelegate?.onTouch(point: point)
    }
}
