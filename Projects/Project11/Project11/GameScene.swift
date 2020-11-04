//
//  GameScene.swift
//  Project11
//
//  Created by Леонид Хабибуллин on 04.11.2020.
//

import SpriteKit
//import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLable: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLable.text = "Score is \(score)"
        }
    }
    var editLable: SKLabelNode!
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLable.text = "Done!"
            } else {
                editLable.text = "Edit"
            }
        }
    }
    
    var ballsLable: SKLabelNode! // Challenge 3
    var numberOfBalls = 5 { // Challenge 3
        didSet {
            ballsLable.text = "You have \(numberOfBalls) balls"
        }
    }
    
    var colourOfBall = ["Blue", "Cyan", "Green", "Grey", "Purple", "Red", "Yellow"] // challenge 1
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background") // создаём объект SKSpriteNode (картинка). Картинку берём по имени из ассетов
        background.position = CGPoint(x: 512, y: 384) // указываем куда поместить центр объекта
        background.blendMode = .replace // First, we're going to give it the blend mode .replace. Blend modes determine how a node is drawn, and SpriteKit gives you many options. The .replace option means "just draw it, ignoring any alpha values," which makes it fast for things without gaps such as our background. Так же ускоряет рисовку
        background.zPosition = -1 // We're also going to give the background a zPosition of -1, which in our game means "draw this behind everything else."
        addChild(background) // To add any node to the current screen, you use the addChild() method. As you might expect, SpriteKit doesn't use UIViewController like our UIKit apps have done. Yes, there is a view controller in your project, but it's there to host your SpriteKit game. The equivalent of screens in SpriteKit are called scenes. When you add a node to your scene, it becomes part of the node tree. Using addChild() you can add nodes to other nodes to make a more complicated tree, but in this game we're going to keep it simple.
        
        scoreLable = SKLabelNode(fontNamed: "Chalkduster")
        scoreLable.text = "Score is 0"
        scoreLable.horizontalAlignmentMode = .right
        scoreLable.position = CGPoint(x: 980, y: 700)
        addChild(scoreLable)
        
        editLable = SKLabelNode(fontNamed: "Chalkduster")
        editLable.text = "Edit"
        editLable.position = CGPoint(x: 80, y: 700)
        addChild(editLable)
        
        ballsLable = SKLabelNode(fontNamed: "Chalkduster")
        ballsLable.text = "You have \(numberOfBalls) balls"
        ballsLable.position = CGPoint(x: 530, y: 700)
        addChild(ballsLable)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame) // физика всей сцены
        
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        

        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return } // фиксируем одно нажатие
        let location = touch.location(in: self) // получаем координаты нажатия на экран
        
        let objects = nodes(at: location) // что находится в точке касания
        if objects.contains(editLable) {
            editingMode.toggle() // переворачивает значение переменной типа Bool
        } else {
            if editingMode {
                let size = CGSize(width: Int.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                box.name = "box"
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location
                
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false
                addChild(box)
            } else {
                if location.y >= CGFloat(500) { // Challenge 2
                    if numberOfBalls > 0 {
                colourOfBall.shuffle() // challenge 1
                let colour = colourOfBall[0] // challenge 1
                let ball = SKSpriteNode(imageNamed: "ball\(colour)") // challenge 1
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                ball.physicsBody?.restitution = 0.4 // отскакивание
                ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0 // The collisionBitMask bitmask means "which nodes should I bump into?" By default, it's set to everything, which is why our ball are already hitting each other and the bouncers. The contactTestBitMask bitmask means "which collisions do you want to know about?" and by default it's set to nothing. So by setting contactTestBitMask to the value of collisionBitMask we're saying, "tell me about every collision."
                ball.position = location
                ball.name = "ball"
                addChild(ball)
                numberOfBalls -= 1
                }
                }
                }
            }
//        let box = SKSpriteNode(color: .red, size: CGSize(width: 64, height: 64)) // создали объект SKSpriteNode с указанными характиристиками (красный квадрат)
//        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64)) //  добавили физику, основываясь на сторонах объекта
//        box.position = location // придали квадрату местоположение
//        addChild(box) // добавили на экран
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false // делаем объект неподвижным навсегда
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "Good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "Bad"
        }
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func collision(between ball: SKNode, object: SKNode) {
        if object.name == "Good" {
            destroy(ball: ball)
            score += 1
            numberOfBalls += 1
        } else if
            object.name == "Bad" {
                destroy(ball: ball)
            score -= 1
        } else if // Challenge 3
            object.name == "box"  {
//            ball.removeFromParent()
            object.removeFromParent()
               
            }
        }
    
    func collisionBox(between ball: SKNode, box: SKNode) { // Challenge 3
        ball.removeFromParent()
        box.removeFromParent()
    }
    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {
            return
        }
        guard let nodeB = contact.bodyB.node else {
            return
        }
        if nodeA.name == "ball" {
            collision(between: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collision(between: nodeB, object: nodeA)
        }
}
//    func checkWin() {
//        if score == 5 {
//            let ac = SK
//        }
//    }
}
