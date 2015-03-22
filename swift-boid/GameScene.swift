//
//  GameScene.swift
//  swift-boid
//
//  Created by katoy on 2015/03/22.
//  Copyright (c) 2015年 Youichi Kato. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let numberOfBirds = 10

    var birdNodes = [BirdNode]()

    override func didMoveToView(view: SKView) {
        let degree: Double = 360.0 / Double(self.numberOfBirds)
        let radius = 120.0
        for i in 0..<self.numberOfBirds {
            let birdNode = BirdNode()
            let radian = degree * Double(i) * M_PI / 180.0
            let x = Double(CGRectGetMidX(self.frame)) + cos(radian) * radius
            let y = Double(CGRectGetMidY(self.frame)) + sin(radian) * radius
            birdNode.position = CGPoint(x: x, y: y)

            self.addChild(birdNode)
            self.birdNodes.append(birdNode)
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        for birdNode in self.birdNodes {
            birdNode.update(birdNodes: self.birdNodes, frame: self.frame)
        }
    }
}
