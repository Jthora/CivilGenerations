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
    
    @Published var gameSpeed: GameSpeed = .normal
    @Published var gameState: GameState = .paused
    @Published var iconMode: GameIconMode = .icons {
        didSet {
            DispatchQueue.main.async {
                self.updateSprites()
            }
        }
    }
    @Published var sprites: [LifeNodeHash:GameLifeSpriteNode] = [:]
    @Published var ruins: [LifeNodeHash:GameLifeSpriteNode] = [:]
    
    @Published var lifeNodeField = LifeNodeField()
    
    
    var updateIter:TimeInterval = 0
    
    @Published var scene: GameScene = {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width,
                            height: UIScreen.main.bounds.height)
        return scene
    }()
    
    
    func start() {
        print("start")
        gameState = .running
    }
    
    func pause() {
        print("pause")
        gameState = .paused
    }
    
    func reset() {
        DispatchQueue.main.async {
            self.gameState = .paused
            self.lifeNodeField.clear()
            self.updateSprites()
        }
    }
    
    func setup() {
        gameState = .paused
        lifeNodeField.clear()
    }
    
    func click(_ point:CGPoint) {
        
        let x = Int((point.x + (CONVERSION_SCALE/2)) / CONVERSION_SCALE)
        let y = Int((point.y + (CONVERSION_SCALE/2)) / CONVERSION_SCALE)
        let w = LifeNode(x: Int32(x), y: Int32(y))
        let h = w.h
        print("Click \(w.string) \(point)")
        if lifeNodeField.check(w) {
            lifeNodeField.reset(w)
            sprites[w.h]?.removeFromParent()
            sprites[w.h] = nil
        } else {
            lifeNodeField.set(w)
            if let sprite = sprites[h] {
                guard let c = lifeNodeField.counts[h],
                        sprite.iconType.rawValue != c  else {return}
                sprite.iconType = GameLifeSpriteNode.IconType(c)
            } else {
                let sprite = GameLifeSpriteNode()
                sprite.position = h.position
                print("Sprite \(w.string) \(h.position)")
                sprite.iconType = GameLifeSpriteNode.IconType(1)
                sprites[h] = sprite
                scene.addChild(sprite)
            }
        }
        print("Nodes: \(lifeNodeField.field.count)")
        print("Count: \(lifeNodeField.counts.count)")
        updateSprites()
    }
    
    func updateSprites() {
        var spritesToRemove:[LifeNodeHash] = []
        
        for (h,sprite) in sprites {
            guard lifeNodeField.field[h] != nil else {
                spritesToRemove.append(h)
                continue
            }
            guard let c = lifeNodeField.counts[h] else {
                continue
            }
            switch iconMode {
            case .icons:
                sprite.iconType = GameLifeSpriteNode.IconType(c)
            case .numbers:
                sprite.numberValue = c
            }
        }
        
        for h in spritesToRemove {
            sprites[h]?.removeFromParent()
            sprites[h] = nil
        }
    }
}

extension GameCore: GameSceneDelegate {
    
    func updateGame() {
            switch gameState {
            case .running:
                updateIter += gameSpeed.updateRate
                if updateIter >= 1 {
                    updateIter = 0
                    lifeNodeField.step()
                    updateSprites()
                }
                
            case .paused: ()
            }
    }
    
    func onTouch(point: CGPoint) {
        click(point)
    }
}
