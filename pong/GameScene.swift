//
//  GameScene.swift
//  pong
//
//  Created by liam mulcahy on 5/16/19.
//  Copyright © 2019 liam mulcahy. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var ball = SKSpriteNode(imageNamed: "ball")
    var enemy = SKSpriteNode(imageNamed: "airhockeyshits")
    var main = SKSpriteNode(imageNamed: "airhockeyshits")
    var score = [Int]()
    var enemyLabel = SKLabelNode()
    var mainLabel = SKLabelNode()
    var background = SKSpriteNode(imageNamed: "background")
    func setupSprites() {
        //background
        background.size.width = UIScreen.main.bounds.size.width
        background.size.height = UIScreen.main.bounds.size.height
        background.zPosition = -1
        self.addChild(background)
        //main
        main.zPosition = 2
        main.position.y = -self.frame.height/2 + 50
        main.size = CGSize(width: 100, height: 100)
        main.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        main.physicsBody?.affectedByGravity = false
        main.physicsBody?.allowsRotation = false
        main.physicsBody?.friction = 0
        main.physicsBody?.isDynamic = false
        main.physicsBody?.restitution = 0
        main.physicsBody?.linearDamping = 0
        main.physicsBody?.fieldBitMask = 0
        main.physicsBody?.categoryBitMask = 1
        main.physicsBody?.collisionBitMask = 2
        main.physicsBody?.contactTestBitMask = 2
        main.physicsBody?.mass = 0.666666746139526
        main.physicsBody?.linearDamping = 0.1
        main.physicsBody?.angularDamping = 0.1
        self.addChild(main)
        //enemy
        enemy.position.y = self.frame.height/2 - 50
        enemy.zPosition = 2
        enemy.size = CGSize(width: 100, height: 100)
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.allowsRotation = false
        enemy.physicsBody?.friction = 0
        enemy.physicsBody?.isDynamic = false
        enemy.physicsBody?.restitution = 0
        enemy.physicsBody?.linearDamping = 0
        enemy.physicsBody?.fieldBitMask = 0
        enemy.physicsBody?.categoryBitMask = 1
        enemy.physicsBody?.collisionBitMask = 2
        enemy.physicsBody?.contactTestBitMask = 2
        enemy.physicsBody?.mass = 0.666666746139526
        enemy.physicsBody?.linearDamping = 0.1
        enemy.physicsBody?.angularDamping = 0.1
        self.addChild(enemy)
        
        //ball
        ball.position = CGPoint(x: 0, y: 0)
        ball.size = CGSize(width: 30, height: 30)
        ball.zPosition = 2
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.friction = 0
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.fieldBitMask = 0
        ball.physicsBody?.categoryBitMask = 2
        ball.physicsBody?.collisionBitMask = 1
        ball.physicsBody?.contactTestBitMask = 1
        ball.physicsBody?.mass = 0.0314159281551838
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.angularDamping = 0
        self.addChild(ball)
        
        //labels
        mainLabel.fontColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        enemyLabel.fontColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        mainLabel.position = CGPoint(x:0,y:-80)
        enemyLabel.position = CGPoint(x:0,y:80)
        enemyLabel.physicsBody?.pinned = true
        mainLabel.physicsBody?.pinned = true
        enemyLabel.zRotation =  .pi
        mainLabel.zPosition = 3
        enemyLabel.zPosition = 3
        self.addChild(mainLabel)
        self.addChild(enemyLabel)
      
    }
    
    
    override func didMove(to view: SKView) {
        let myBorder = SKPhysicsBody(edgeLoopFrom: self.frame)
        myBorder.friction = 0
        myBorder.restitution = 1
        setupSprites()
        self.physicsBody = myBorder
        startGame()
    }
    func startGame() {
        score = [0,0]
        enemyLabel.text = "\(score[1])"
        mainLabel.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
    }
    func addScore(playerWhoWon: SKSpriteNode){
        ball.position = CGPoint(x: 0, y:0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        }else if playerWhoWon == enemy{
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
        enemyLabel.text = "\(score[1])"
        mainLabel.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            if currentGameType == .player2{
                if location.y>0{
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y<0{
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else{
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            if currentGameType == .player2{
                if location.y>40{
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                    enemy.run(SKAction.moveTo(y: location.y, duration: 0.2))
                }
                if location.y < -40{
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                    main.run(SKAction.moveTo(y: location.y, duration: 0.2))
                }
                
            }else if location.y < -40 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                    main.run(SKAction.moveTo(y: location.y, duration: 0.2))
            }else if location.y > -20 && currentGameType != .player2{
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.6))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.3))
            break
        case .player2:
            break
        }
        if ball.position.y <= -310 {
            addScore(playerWhoWon: enemy)
        }else if ball.position.y >= 310 {
            addScore(playerWhoWon: main)
        }
    }
    func resetGame() {
        score = [0,0]
        enemyLabel.text = "\(score[1])"
        mainLabel.text = "\(score[0])"
    }
    

    func handleDoubleTap(sender: AnyObject?) {
        resetGame()
    }
    

    
}

// Double Tap

