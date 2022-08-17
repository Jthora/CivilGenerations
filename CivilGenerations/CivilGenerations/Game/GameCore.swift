//
//  GameCore.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import SpriteKit

final class GameCore: ObservableObject {
    
    static let shared = GameCore()
    private init() {
        scene.gameDelegate = self
        setup()
    }
    
    @Published var gameState: GameState = .paused
    @Published var sprites: [LifeNodeHash:GameLifeSpriteNode] = [:]
    @Published var ruins: [LifeNodeHash:GameLifeSpriteNode] = [:]
    
    @Published var lifeNodeField = LifeNodeField()
    
    @Published var scene: GameScene = {
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
        let w = LifeNode(point)
        if lifeNodeField.check(w) {
            lifeNodeField.reset(w)
        } else {
            lifeNodeField.set(w)
        }
        updateSprites()
    }
    
    func updateSprites() {
        for (h,c) in lifeNodeField.counts {
            if let sprite = sprites[h] {
                sprite.iconType = GameLifeSpriteNode.IconType(c)
            } else {
                let sprite = GameLifeSpriteNode()
                sprite.position = h.position
                print(h.position)
                sprite.iconType = GameLifeSpriteNode.IconType(c)
                sprites[h] = sprite
                scene.addChild(sprite)
            }
        }
    }
}

extension GameCore: GameSceneDelegate {
    
    func updateGame() {
        switch gameState {
        case .running:
            lifeNodeField.step()
            updateSprites()
            
        case .paused: ()
        }
    }
    
    func onTouch(point: CGPoint) {
        click(point)
    }
}
