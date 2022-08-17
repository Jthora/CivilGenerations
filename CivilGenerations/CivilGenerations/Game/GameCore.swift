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
                switch self.iconMode {
                case .numbers:
                    self.iconSpriteParent.isHidden = true
                    self.numberSpriteParent.isHidden = false
                case .icons:
                    self.iconSpriteParent.isHidden = false
                    self.numberSpriteParent.isHidden = true
                }
                self.updateSprites()
            }
        }
    }
    
    @Published var numberSpriteParent = SKSpriteNode()
    @Published var iconSpriteParent = SKSpriteNode()
    @Published var numberSprites: [LifeNodeHash:GameCountSpriteNode] = [:]
    @Published var iconSprites: [LifeNodeHash:GameLifeSpriteNode] = [:]
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
        scene.removeAllChildren()
        
        numberSpriteParent.removeAllChildren()
        iconSpriteParent.removeAllChildren()
        
        scene.addChild(numberSpriteParent)
        scene.addChild(iconSpriteParent)
        
        iconMode = iconMode // Reset
    }
    
    func click(_ point:CGPoint) {
        
        let x = Int((point.x + (CONVERSION_SCALE/2)) / CONVERSION_SCALE)
        let y = Int((point.y + (CONVERSION_SCALE/2)) / CONVERSION_SCALE)
        let w = LifeNode(x: Int32(x), y: Int32(y))
        let h = w.h
        print("Click \(w.string) \(point)")
        if lifeNodeField.check(w) {
            lifeNodeField.reset(w)
            iconSprites[w.h]?.removeFromParent()
            iconSprites[w.h] = nil
        } else {
            
            lifeNodeField.set(w)
            
            if let sprite = iconSprites[h] {
                guard let c = lifeNodeField.counts[h],
                        sprite.iconType.rawValue != c  else {return}
                sprite.iconType = GameLifeSpriteNode.IconType(c)
            } else {
                let sprite = GameLifeSpriteNode()
                sprite.position = h.position
                print("Sprite \(w.string) \(h.position)")
                sprite.iconType = GameLifeSpriteNode.IconType(1)
                iconSprites[h] = sprite
                iconSpriteParent.addChild(sprite)
            }
        }
        print("Nodes: \(lifeNodeField.field.count)")
        print("Count: \(lifeNodeField.counts.count)")
        updateSprites()
    }
    
    func updateSprites() {
        var iconSpritesToRemove:[LifeNodeHash] = []
        
        // Update Existing Icon Sprites
        for (h,sprite) in iconSprites {
            guard lifeNodeField.field[h] != nil else {
                iconSpritesToRemove.append(h)
                continue
            }
            guard let c = lifeNodeField.counts[h] else {
                continue
            }
            
            iconSprites[h]?.iconType = GameLifeSpriteNode.IconType(c)
        }
        
        // New Icon Sprites
        for (h,_) in lifeNodeField.field {
            if iconSprites[h] != nil {
                guard let c = lifeNodeField.counts[h] else {
                    continue
                }
                iconSprites[h]?.iconType = GameLifeSpriteNode.IconType(c)
            } else {
                guard let c = lifeNodeField.counts[h] else {
                    continue
                }
                let newSprite = GameLifeSpriteNode()
                newSprite.iconType = GameLifeSpriteNode.IconType(c)
                newSprite.position = h.position
                iconSprites[h] = newSprite
            }
        }
        
        // Remove Leftover Icon Sprites
        for h in iconSpritesToRemove {
            iconSprites[h]?.removeFromParent()
            iconSprites[h] = nil
        }
        
        // Update Number Sprites
        
        // Update Existing Number Sprites
        var numberSpritesToRemove:[LifeNodeHash] = []
        for (h,sprite) in numberSprites {
            guard let c = lifeNodeField.counts[h] else {
                numberSpritesToRemove.append(h)
                continue
            }
            
            sprite.numberValue = c
        }
        
        // New Number Sprites
        for (h,c) in lifeNodeField.counts {
            if let sprite = numberSprites[h] {
                sprite.numberValue = c
            } else {
                let newSprite = GameCountSpriteNode()
                newSprite.numberValue = c
                numberSprites[h] = newSprite
                newSprite.position = h.position
                numberSpriteParent.addChild(newSprite)
            }
        }
        
        // Remove Number Sprites
        for h in numberSpritesToRemove {
            numberSprites[h]?.removeFromParent()
            numberSprites[h] = nil
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
