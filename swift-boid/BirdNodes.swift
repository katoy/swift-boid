//
//  BirdNodes.swift
//  swift-boid
//
//  Created by katoy on 2015/03/22.
//  Copyright (c) 2015年 Youichi Kato. All rights reserved.
//

// See http://qiita.com/tnantoka/items/5fd493300c39430443ff
//    SwiftとSprite Kitでボイド

import SpriteKit

class BirdNode: SKNode {

    let maxSpeed: CGFloat = 4.0
    let size: CGFloat = 20.0

    var velocity = CGPoint(x: 0.0, y: 0.0)
    let rules: [Rule]!
    
    override init() {
        super.init()

        self.rules = [
            CohesionRule(weight: 1.0),
            SeparationRule(weight: 0.8),
            AlignmentRule(weight: 0.1)
        ]

        self.addFireNode()
    }

    private func addFireNode() {
        let fireNode = NSKeyedUnarchiver.unarchiveObjectWithFile(NSBundle.mainBundle().pathForResource("fire", ofType: "sks")!) as SKEmitterNode
        fireNode.particleScale = 0.15
        fireNode.xScale = 0.7
        fireNode.yScale = 0.9

        fireNode.particleLifetime = 0.3
        fireNode.emissionAngle = -CGFloat(90.0 * M_PI / 180.0)
        fireNode.emissionAngleRange = 0.0
        fireNode.particlePositionRange = CGVector(dx: 0.0, dy: 0.1)

        fireNode.particleColor = SKColor.orangeColor()

        self.addChild(fireNode)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func update(#birdNodes: [BirdNode], frame: CGRect) {
        for rule in self.rules {
            rule.evaluate(targetNode: self, birdNodes: birdNodes)
        }
        self.move(frame)
        self.rotate()
    }

    private func move(frame: CGRect) {
        self.velocity.x += rules.reduce(0.0, combine: { sum, r in sum + r.weighted.x })
        self.velocity.y += rules.reduce(0.0, combine: { sum, r in sum + r.weighted.y })

        let vector = sqrt(self.velocity.x * self.velocity.x + self.velocity.y * self.velocity.y)
        if (vector > self.maxSpeed) {
            self.velocity.x = (self.velocity.x / vector) * self.maxSpeed
            self.velocity.y = (self.velocity.y / vector) * self.maxSpeed
        }

        self.position.x += self.velocity.x
        self.position.y += self.velocity.y

        if (self.position.x - self.size <= 0) {
            self.position.x = self.size
            self.velocity.x *= -1
        }
        if (self.position.x + self.size >= CGRectGetWidth(frame)) {
            self.position.x = CGRectGetWidth(frame) - self.size
            self.velocity.x *= -1
        }

        if (self.position.y - self.size <= 0) {
            self.position.y = self.size
            self.velocity.y *= -1
        }
        if (self.position.y + self.size >= CGRectGetHeight(frame)) {
            self.position.y = CGRectGetHeight(frame) - self.size
            self.velocity.y *= -1
        }
    }

    private func rotate() {
        var radian = -atan2(Double(velocity.x), Double(velocity.y))
        self.zRotation = CGFloat(radian)
    }
}
