//
//  SeparationRule.swift
//  swift-boid
//
//  Created by katoy on 2015/03/22.
//  Copyright (c) 2015年 Youichi Kato. All rights reserved.
//

import UIKit

class SeparationRule: Rule {
    let threshold = 30.0

    override func evaluate(#targetNode: BirdNode, birdNodes: [BirdNode]) {
        super.evaluate(targetNode: targetNode, birdNodes: birdNodes)

        for birdNode in birdNodes {
            if birdNode != targetNode {
                if self.distanceBetween(targetNode.position, birdNode.position) < self.threshold {
                    self.velocity.x -= birdNode.position.x - targetNode.position.x
                    self.velocity.y -= birdNode.position.y - targetNode.position.y
                }
            }
        }
    }

    private func distanceBetween(pointA: CGPoint, _ pointB: CGPoint) -> Double {
        let x = Double(pointA.x - pointB.x)
        let y = Double(pointA.y - pointB.y)
        return sqrt(x * x  + y * y)
    }
}
