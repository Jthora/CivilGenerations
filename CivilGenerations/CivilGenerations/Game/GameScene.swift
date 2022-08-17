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
    
    @Published var cameraNode = SKCameraNode()
    var gameDelegate: GameSceneDelegate? = nil
    
    override func didMove(to view: SKView) {
        print("SpriteKit Scene Loaded")
        
        // camera
        cameraNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(cameraNode)
        camera = cameraNode
        
        // Create the gesture recognizer for panning
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanFrom))
        let pinchGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePinchFrom))
        
        // Add the gesture recognizer to the scene's view
        view.addGestureRecognizer(panGestureRecognizer)
        view.addGestureRecognizer(pinchGestureRecognizer)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        gameDelegate?.updateGame()
    }
    
    // Touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        gameDelegate?.onTouch(point: point)
    }
    
    // Drag
    @objc func handlePanFrom(_ recognizer: UIPanGestureRecognizer) {
        // This function is called when a pan gesture is recognized.
        if recognizer.numberOfTouches == 2 {
            let deltaX = recognizer.translation(in: view).x
            let deltaY = recognizer.translation(in: view).y

            cameraNode.position.x -= deltaX
            cameraNode.position.y += deltaY

            recognizer.setTranslation(CGPoint(x: 0, y: 0), in: view)
        }
    }
    
    // Zoom
    @objc func handlePinchFrom(_ recognizer: UIPinchGestureRecognizer) {
        // This function is called when a pinch gesture is recognized.
        if recognizer.numberOfTouches == 2 {
            let locationInView = recognizer.location(in: self.view)
            let location = self.convertPoint(fromView: locationInView)
            if recognizer.state == .changed {
                let deltaScale = (recognizer.scale - 1.0)*2
                let convertedScale = recognizer.scale - deltaScale
                let newScale = cameraNode.xScale*convertedScale
                cameraNode.setScale(newScale)
               
                let locationAfterScale = self.convertPoint(fromView: locationInView)
                let locationDelta = location - locationAfterScale //pointSubtract(location, pointB: locationAfterScale)
                let newPoint = cameraNode.position + locationDelta //pointAdd(cameraNode.position, pointB: locationDelta)
                cameraNode.position = newPoint
                recognizer.scale = 1.0
            }
        }
    }
}
