//
//  GameScene.swift
//  Project17
//
//  Created by Леонид Хабибуллин on 09.11.2020.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    
    var possibleEnemies = ["ball", "hammer", "tv"]
    var gamerTimer: Timer?
    var isGameOver = false
    
    var enemies = 0 // Challenge 2
    var counts = 1.0 // Challenge 2
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    override func didMove(to view: SKView) {
        backgroundColor = .black
        starfield = SKEmitterNode(fileNamed: "starfield")!
        starfield.position = CGPoint(x: 1024, y: 384)
        starfield.advanceSimulationTime(10)
        addChild(starfield)
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        score = 0
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
       
        
        gamerTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        

    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
        if enemies == 20 { // Challenge 2
            gamerTimer?.invalidate()
            gamerTimer = Timer.scheduledTimer(timeInterval: 1 - counts * 0.1, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            counts += 1
            enemies = 0
        }
        
        if !isGameOver {

            score += 1
        } else { // Challenge 3
            gamerTimer?.invalidate()
        }
    }
    
    @objc func createEnemy(){
        guard let enemy = possibleEnemies.randomElement() else {return}
        
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.contactTestBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
        
        enemies += 1
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        var location = touch.location(in: self)
        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }
        
        player.position = location
    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else {return}
//        var location = touch.location(in: self)
//        player.physicsBody?.velocity = CGVector(dx: location.x, dy: location.y)
//        player.physicsBody?.linearDamping = 10
//    }
//
    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)
        
        player.removeFromParent()
        isGameOver = true
    }
}
 
