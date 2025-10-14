import SpriteKit

class LeapQuestFrogNode: SKSpriteNode {
    
    private var leapQuestJumpAction: SKAction!
    private var leapQuestIdleAction: SKAction!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setupLeapQuestFrogNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLeapQuestFrogNode()
    }
    
    private func setupLeapQuestFrogNode() {
        texture = SKTexture.createLeapQuestFrogTexture()
        size = CGSize(width: 80, height: 80)
        name = "frog"
        
        physicsBody = SKPhysicsBody(circleOfRadius: 35)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = LeapQuestPhysicsCategory.frog
        physicsBody?.contactTestBitMask = LeapQuestPhysicsCategory.worm | LeapQuestPhysicsCategory.fish | LeapQuestPhysicsCategory.bomb
        physicsBody?.collisionBitMask = 0
        
        setupLeapQuestAnimations()
        startLeapQuestIdleAnimation()
    }
    
    private func setupLeapQuestAnimations() {
        let leapQuestJumpUp = SKAction.group([
            SKAction.scale(to: 1.3, duration: 0.15),
            SKAction.rotate(toAngle: 0.1, duration: 0.15)
        ])
        let leapQuestJumpDown = SKAction.group([
            SKAction.scale(to: 1.0, duration: 0.15),
            SKAction.rotate(toAngle: 0.0, duration: 0.15)
        ])
        leapQuestJumpAction = SKAction.sequence([leapQuestJumpUp, leapQuestJumpDown])
        
        let leapQuestIdleUp = SKAction.group([
            SKAction.scale(to: 1.08, duration: 1.5),
            SKAction.rotate(toAngle: 0.05, duration: 1.5)
        ])
        let leapQuestIdleDown = SKAction.group([
            SKAction.scale(to: 0.95, duration: 1.5),
            SKAction.rotate(toAngle: -0.05, duration: 1.5)
        ])
        leapQuestIdleAction = SKAction.repeatForever(SKAction.sequence([leapQuestIdleUp, leapQuestIdleDown]))
    }
    
    private func startLeapQuestIdleAnimation() {
        run(leapQuestIdleAction, withKey: "idle")
    }
    
    func moveTo(position: CGPoint) {
        let leapQuestMoveAction = SKAction.move(to: position, duration: 0.4)
        leapQuestMoveAction.timingMode = .easeInEaseOut
        
        let leapQuestDirection = CGVector(
            dx: position.x - self.position.x,
            dy: position.y - self.position.y
        )
        
        let leapQuestAngle = atan2(leapQuestDirection.dy, leapQuestDirection.dx)
        let leapQuestRotationAction = SKAction.rotate(toAngle: leapQuestAngle, duration: 0.2)
        leapQuestRotationAction.timingMode = .easeInEaseOut
        
        let leapQuestParticleEffect = createLeapQuestJumpEffect()
        addChild(leapQuestParticleEffect)
        
        let leapQuestJumpSequence = SKAction.sequence([
            leapQuestJumpAction,
            leapQuestMoveAction
        ])
        
        let leapQuestRotationSequence = SKAction.sequence([
            leapQuestRotationAction,
            SKAction.rotate(toAngle: 0, duration: 0.3)
        ])
        
        let leapQuestGroupAction = SKAction.group([
            leapQuestJumpSequence,
            leapQuestRotationSequence
        ])
        
        run(leapQuestGroupAction) {
            leapQuestParticleEffect.removeFromParent()
            self.startLeapQuestIdleAnimation()
        }
    }
    
    private func createLeapQuestJumpEffect() -> SKEmitterNode {
        let leapQuestJumpEffect = SKEmitterNode()
        leapQuestJumpEffect.particleTexture = SKTexture.createLeapQuestStarTexture()
        leapQuestJumpEffect.particleBirthRate = 200
        leapQuestJumpEffect.particleLifetime = 0.5
        leapQuestJumpEffect.particleSpeed = 50
        leapQuestJumpEffect.particleSpeedRange = 30
        leapQuestJumpEffect.emissionAngle = CGFloat.pi / 2
        leapQuestJumpEffect.emissionAngleRange = CGFloat.pi / 2
        leapQuestJumpEffect.particleScale = 0.1
        leapQuestJumpEffect.particleScaleRange = 0.05
        leapQuestJumpEffect.particleColor = UIColor.yellow
        leapQuestJumpEffect.particleColorBlendFactor = 0.8
        leapQuestJumpEffect.particleAlpha = 0.8
        leapQuestJumpEffect.position = CGPoint(x: 0, y: -40)
        leapQuestJumpEffect.zPosition = 5
        
        let leapQuestStopEffect = SKAction.sequence([
            SKAction.wait(forDuration: 0.1),
            SKAction.run { leapQuestJumpEffect.particleBirthRate = 0 }
        ])
        leapQuestJumpEffect.run(leapQuestStopEffect)
        
        return leapQuestJumpEffect
    }
    
    func leapQuestStopAnimations() {
        removeAction(forKey: "idle")
    }
}

class LeapQuestWormNode: SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setupLeapQuestWormNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLeapQuestWormNode()
    }
    
    private func setupLeapQuestWormNode() {
        texture = SKTexture.createLeapQuestWormTexture()
        size = CGSize(width: 40, height: 40)
        name = "worm"
        
        physicsBody = SKPhysicsBody(circleOfRadius: 18)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = LeapQuestPhysicsCategory.worm
        physicsBody?.contactTestBitMask = LeapQuestPhysicsCategory.frog
        physicsBody?.collisionBitMask = 0
        physicsBody?.linearDamping = 0.5
        
        let leapQuestFallAction = SKAction.moveBy(x: 0, y: -size.height - 100, duration: 3.0)
        run(leapQuestFallAction)
        
        setupLeapQuestWormAnimation()
    }
    
    private func setupLeapQuestWormAnimation() {
        let leapQuestWiggleLeft = SKAction.rotate(byAngle: 0.2, duration: 0.2)
        let leapQuestWiggleRight = SKAction.rotate(byAngle: -0.4, duration: 0.4)
        let leapQuestWiggleLeft2 = SKAction.rotate(byAngle: 0.2, duration: 0.2)
        let leapQuestWiggleSequence = SKAction.sequence([leapQuestWiggleLeft, leapQuestWiggleRight, leapQuestWiggleLeft2])
        let leapQuestRepeatWiggle = SKAction.repeatForever(leapQuestWiggleSequence)
        run(leapQuestRepeatWiggle)
    }
}

class LeapQuestFishNode: SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setupLeapQuestFishNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLeapQuestFishNode()
    }
    
    private func setupLeapQuestFishNode() {
        texture = SKTexture.createLeapQuestFishTexture()
        size = CGSize(width: 50, height: 50)
        name = "fish"
        
        physicsBody = SKPhysicsBody(circleOfRadius: 22)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = LeapQuestPhysicsCategory.fish
        physicsBody?.contactTestBitMask = LeapQuestPhysicsCategory.frog
        physicsBody?.collisionBitMask = 0
        physicsBody?.linearDamping = 0.3
        
        let leapQuestFallAction = SKAction.moveBy(x: 0, y: -size.height - 100, duration: 2.5)
        run(leapQuestFallAction)
        
        setupLeapQuestFishAnimation()
    }
    
    private func setupLeapQuestFishAnimation() {
        let leapQuestSwimLeft = SKAction.moveBy(x: -20, y: 0, duration: 0.5)
        let leapQuestSwimRight = SKAction.moveBy(x: 40, y: 0, duration: 1.0)
        let leapQuestSwimLeft2 = SKAction.moveBy(x: -20, y: 0, duration: 0.5)
        let leapQuestSwimSequence = SKAction.sequence([leapQuestSwimLeft, leapQuestSwimRight, leapQuestSwimLeft2])
        let leapQuestRepeatSwim = SKAction.repeatForever(leapQuestSwimSequence)
        run(leapQuestRepeatSwim)
        
        let leapQuestScaleUp = SKAction.scale(to: 1.1, duration: 0.5)
        let leapQuestScaleDown = SKAction.scale(to: 0.9, duration: 0.5)
        let leapQuestScaleSequence = SKAction.sequence([leapQuestScaleUp, leapQuestScaleDown])
        let leapQuestRepeatScale = SKAction.repeatForever(leapQuestScaleSequence)
        run(leapQuestRepeatScale)
    }
}

class LeapQuestBombNode: SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setupLeapQuestBombNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLeapQuestBombNode()
    }
    
    private func setupLeapQuestBombNode() {
        texture = SKTexture.createLeapQuestBombTexture()
        size = CGSize(width: 45, height: 45)
        name = "bomb"
        
        physicsBody = SKPhysicsBody(circleOfRadius: 20)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = LeapQuestPhysicsCategory.bomb
        physicsBody?.contactTestBitMask = LeapQuestPhysicsCategory.frog
        physicsBody?.collisionBitMask = 0
        physicsBody?.linearDamping = 0.2
        
        let leapQuestFallAction = SKAction.moveBy(x: 0, y: -size.height - 100, duration: 2.0)
        run(leapQuestFallAction)
        
        setupLeapQuestBombAnimation()
        
        scheduleLeapQuestExplosion()
    }
    
    private func setupLeapQuestBombAnimation() {
        let leapQuestRotate = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 1.0)
        let leapQuestRepeatRotate = SKAction.repeatForever(leapQuestRotate)
        run(leapQuestRepeatRotate)
        
        let leapQuestPulseUp = SKAction.scale(to: 1.2, duration: 0.3)
        let leapQuestPulseDown = SKAction.scale(to: 0.8, duration: 0.3)
        let leapQuestPulseSequence = SKAction.sequence([leapQuestPulseUp, leapQuestPulseDown])
        let leapQuestRepeatPulse = SKAction.repeatForever(leapQuestPulseSequence)
        run(leapQuestRepeatPulse)
    }
    
    private func scheduleLeapQuestExplosion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if self.parent != nil {
                self.explodeLeapQuestBomb()
            }
        }
    }
    
    private func explodeLeapQuestBomb() {
        let leapQuestExplosion = SKEmitterNode()
        leapQuestExplosion.particleTexture = SKTexture.createLeapQuestFireTexture()
        leapQuestExplosion.particleBirthRate = 300
        leapQuestExplosion.particleLifetime = 0.8
        leapQuestExplosion.particleSpeed = 150
        leapQuestExplosion.particleSpeedRange = 100
        leapQuestExplosion.emissionAngleRange = CGFloat.pi * 2
        leapQuestExplosion.particleScale = 0.4
        leapQuestExplosion.particleColor = UIColor.red
        leapQuestExplosion.position = position
        leapQuestExplosion.zPosition = 20
        parent?.addChild(leapQuestExplosion)
        
        let leapQuestShakeAction = SKAction.sequence([
            SKAction.moveBy(x: -15, y: 0, duration: 0.1),
            SKAction.moveBy(x: 30, y: 0, duration: 0.1),
            SKAction.moveBy(x: -15, y: 0, duration: 0.1)
        ])
        parent?.run(leapQuestShakeAction)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            leapQuestExplosion.removeFromParent()
        }
        
        removeFromParent()
    }
}

struct LeapQuestPhysicsCategory {
    static let frog: UInt32 = 0x1 << 0
    static let worm: UInt32 = 0x1 << 1
    static let fish: UInt32 = 0x1 << 2
    static let bomb: UInt32 = 0x1 << 3
}
