//
//  GameCore.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import SpriteKit

final class GameCore: ObservableObject {
    
    static let shared = GameCore()
    private init() {}
    
    @Published var gameState: GameState = .paused
    @Published var sprites: [SKSpriteNode] = []
    @Published var lifeNodeField = LifeNodeField()
    
    @Published var scene: SKScene = {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width,
                            height: UIScreen.main.bounds.height)
        return scene
    }()
    
    
    func start() {
        gameState = .running
    }
    
    func pause() {
        gameState = .paused
    }
    
    func reset() {
        gameState = .paused
        lifeNodeField.clear()
    }
    
    func setup() {
        gameState = .paused
        lifeNodeField.clear()
    }
    
    func click(_ point:CGPoint) {
        
    }
}

extension GameCore: GameSceneDelegate {
    func update() {
        switch gameState {
        case .running:
            lifeNodeField.step()
            
        case .paused: ()
        }
    }
}
