//
//  GameViewController.swift
//  pong
//
//  Created by liam mulcahy on 5/16/19.
//  Copyright © 2019 liam mulcahy. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
var currentGameType = gameType.easy
struct GlobalData {
    
}

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let taps = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        func tapper(){
            taps.delegate = self as? UIGestureRecognizerDelegate
            taps.numberOfTapsRequired = 2
            taps.delaysTouchesBegan = true
            taps.delaysTouchesBegan = true
            view.addGestureRecognizer(taps)
        }
        
        tapper()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.size = view.bounds.size
                // Present the scene
                view.addGestureRecognizer(taps)
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
        
    }
    var doubleTapper: UITapGestureRecognizer!{
        self.doubleTapper.numberOfTouchesRequired = 2
        self.goToScene(SKView)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer){
            sender.numberOfTapsRequired = 2
                if let view = self.view as! SKView?{
                    if let menuScene = MenuVC.view {
                        goToScene(newScene: menuScene)
                        
                }
                    
            }
        }
    

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func goToScene(_ newScene: SKView?){
        weak let sceneToLoad = SKScene(fileNamed: newScene)
        let currentScene = SKScene(fileNamed: "GameScene")
        if (sceneToLoad != nil) {
            _ = SKTransition.fade(withDuration: 3)
            currentScene?.view?.isPaused=true
            currentScene?.view?.isHidden=true
            sceneToLoad?.view?.isPaused=false
            sceneToLoad?.view?.isHidden=false
            self.present(self.storyboard?.instantiateViewController(withIdentifier:"gameVC") as! GameViewController, animated: false)
            
        }
    
}
    func presentScene(_ scene: SKScene?){}
}
