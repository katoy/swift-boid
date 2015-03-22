//
//  CohesionRule.swift
//  swift-boid
//
//  Created by katoy on 2015/03/22.
//  Copyright (c) 2015年 Youichi Kato. All rights reserved.
//

import UIKit

class CohesionRule: Rule {
    let factor: CGFloat = 300.0

    override func evaluate(#targetNode: BirdNode, birdNodes: [BirdNode]) {
        super.evaluate(targetNode: targetNode, birdNodes: birdNodes)

        for birdNode in birdNodes {
            if birdNode != targetNode {
                self.velocity.x += birdNode.position.x
                self.velocity.y += birdNode.position.y
            }
        }

        self.velocity.x /= CGFloat(birdNodes.count - 1)
        self.velocity.y /= CGFloat(birdNodes.count - 1)

        self.velocity.x = (self.velocity.x - targetNode.position.x) / self.factor
        self.velocity.y = (self.velocity.y - targetNode.position.y) / self.factor
    }
}
