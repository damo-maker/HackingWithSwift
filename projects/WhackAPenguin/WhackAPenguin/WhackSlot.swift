//
//  WhackSlot.swift
//  WhackAPenguin
//
//  Created by Damian Johns on 17/06/2020.
//  Copyright © 2020 Damian Johns. All rights reserved.
//

import SpriteKit
import UIKit

class WhackSlot: SKNode {
    var charNode: SKSpriteNode!
    
    var visible = false
    var isHit = false
    
    func configureAtPosition(_ pos: CGPoint) {
        position = pos
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        
        addChild(cropNode)
        
    }
    
    func show(hideTime: Double) {
        if visible { return }
        
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        visible = true
        isHit = false
        
        if RandomInt(min: 0, max: 2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        charNode.xScale = 1
        charNode.yScale = 1
        
        RunAfterDelay(hideTime * 3.5) { [unowned self] in
            self.hide()
        }
    }
    
    func hide() {
        if !visible { return }
        
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        visible = false
    }
    
    func hit() {
        isHit = true
        
        let delay = SKAction.wait(forDuration: 0.25)
        let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        let notVisible = SKAction.run { [unowned self] in self.visible = false }
        let sequence = SKAction.sequence([delay, hide, notVisible])
        charNode.run(sequence)
    }
}















