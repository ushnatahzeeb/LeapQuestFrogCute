import SpriteKit
import GameplayKit

class LeapQuestGameScene: SKScene {
    
    private var leapQuestFrog: LeapQuestFrogNode!
    private var leapQuestScoreLabel: SKLabelNode!
    private var leapQuestLivesLabel: SKLabelNode!
    private var leapQuestGameOverLabel: SKLabelNode!
    private var leapQuestRestartButton: SKSpriteNode!
    private var leapQuestAchievementManager: LeapQuestAchievementManager!
    
    private var leapQuestScore: Int = 0
    private var leapQuestLives: Int = 3
    private var leapQuestIsGameOver: Bool = false
    
    private var leapQuestLastSpawnTime: TimeInterval = 0
    private var leapQuestSpawnInterval: TimeInterval = 1.5
    
    private var leapQuestTouchStartPosition: CGPoint?
    private var leapQuestAimIndicator: SKShapeNode?
    private var leapQuestIsAiming: Bool = false
    
    override func didMove(to view: SKView) {
        leapQuestAchievementManager = LeapQuestAchievementManager.shared
        setupLeapQuestGameScene()
        setupLeapQuestBackground()
        setupLeapQuestFrog()
        setupLeapQuestUI()
        startLeapQuestGame()
    }
    
    private func setupLeapQuestGameScene() {
        backgroundColor = LeapQuestColorTheme.Primary.waterBlue
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
    }
    
    private func setupLeapQuestBackground() {
        let leapQuestBackground = SKSpriteNode(texture: SKTexture.createLeapQuestWaterBackgroundTexture())
        leapQuestBackground.size = size
        leapQuestBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
        leapQuestBackground.zPosition = -10
        addChild(leapQuestBackground)
        
        createLeapQuestWaterEffect()
    }
    
    private func createLeapQuestWaterEffect() {
        let leapQuestWaterParticles = SKEmitterNode()
        leapQuestWaterParticles.particleTexture = SKTexture.createLeapQuestWaterDropTexture()
        leapQuestWaterParticles.particleBirthRate = 80
        leapQuestWaterParticles.particleLifetime = 4.0
        leapQuestWaterParticles.particleSpeed = 40
        leapQuestWaterParticles.particleSpeedRange = 30
        leapQuestWaterParticles.emissionAngle = CGFloat.pi * 3 / 2
        leapQuestWaterParticles.emissionAngleRange = CGFloat.pi / 3
        leapQuestWaterParticles.particleScale = 0.15
        leapQuestWaterParticles.particleScaleRange = 0.08
        leapQuestWaterParticles.particleColor = UIColor.white
        leapQuestWaterParticles.particleColorBlendFactor = 0.8
        leapQuestWaterParticles.particleAlpha = 0.8
        leapQuestWaterParticles.particleAlphaRange = 0.3
        leapQuestWaterParticles.position = CGPoint(x: size.width / 2, y: size.height)
        leapQuestWaterParticles.zPosition = -5
        addChild(leapQuestWaterParticles)
        
        let leapQuestBubbleParticles = SKEmitterNode()
        leapQuestBubbleParticles.particleTexture = SKTexture.createLeapQuestBubbleTexture()
        leapQuestBubbleParticles.particleBirthRate = 20
        leapQuestBubbleParticles.particleLifetime = 6.0
        leapQuestBubbleParticles.particleSpeed = 15
        leapQuestBubbleParticles.particleSpeedRange = 10
        leapQuestBubbleParticles.emissionAngle = CGFloat.pi / 2
        leapQuestBubbleParticles.emissionAngleRange = CGFloat.pi / 6
        leapQuestBubbleParticles.particleScale = 0.2
        leapQuestBubbleParticles.particleScaleRange = 0.1
        leapQuestBubbleParticles.particleColor = UIColor.cyan
        leapQuestBubbleParticles.particleColorBlendFactor = 0.7
        leapQuestBubbleParticles.particleAlpha = 0.6
        leapQuestBubbleParticles.particleAlphaRange = 0.3
        leapQuestBubbleParticles.position = CGPoint(x: size.width / 2, y: 0)
        leapQuestBubbleParticles.zPosition = -4
        addChild(leapQuestBubbleParticles)
    }
    
    private func setupLeapQuestFrog() {
        leapQuestFrog = LeapQuestFrogNode()
        leapQuestFrog.position = CGPoint(x: size.width / 2, y: 100)
        leapQuestFrog.zPosition = 10
        addChild(leapQuestFrog)
    }
    
    private func setupLeapQuestUI() {
        leapQuestScoreLabel = SKLabelNode(fontNamed: "Arial-Bold")
        leapQuestScoreLabel.text = "Score: 0"
        leapQuestScoreLabel.fontSize = 24
        leapQuestScoreLabel.fontColor = LeapQuestColorTheme.Text.primary
        leapQuestScoreLabel.position = CGPoint(x: 100, y: size.height - 50)
        leapQuestScoreLabel.zPosition = 100
        addChild(leapQuestScoreLabel)
        
        leapQuestLivesLabel = SKLabelNode(fontNamed: "Arial-Bold")
        leapQuestLivesLabel.text = "Lives: 3"
        leapQuestLivesLabel.fontSize = 24
        leapQuestLivesLabel.fontColor = LeapQuestColorTheme.Secondary.starGold
        leapQuestLivesLabel.position = CGPoint(x: size.width - 100, y: size.height - 50)
        leapQuestLivesLabel.zPosition = 100
        addChild(leapQuestLivesLabel)
        
        setupLeapQuestGameOverUI()
    }
    
    private func setupLeapQuestGameOverUI() {
        leapQuestGameOverLabel = SKLabelNode(fontNamed: "Arial-Bold")
        leapQuestGameOverLabel.text = "GAME OVER"
        leapQuestGameOverLabel.fontSize = 48
        leapQuestGameOverLabel.fontColor = LeapQuestColorTheme.Secondary.starGold
        leapQuestGameOverLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 + 50)
        leapQuestGameOverLabel.zPosition = 100
        leapQuestGameOverLabel.isHidden = true
        addChild(leapQuestGameOverLabel)
        
        leapQuestRestartButton = SKSpriteNode(color: LeapQuestColorTheme.Primary.frogGreen, size: CGSize(width: 150, height: 50))
        leapQuestRestartButton.position = CGPoint(x: size.width / 2, y: size.height / 2 - 50)
        leapQuestRestartButton.zPosition = 100
        leapQuestRestartButton.name = "restart"
        leapQuestRestartButton.isHidden = true
        
        let leapQuestRestartLabel = SKLabelNode(fontNamed: "Arial-Bold")
        leapQuestRestartLabel.text = "RESTART"
        leapQuestRestartLabel.fontSize = 20
        leapQuestRestartLabel.fontColor = LeapQuestColorTheme.Text.primary
        leapQuestRestartLabel.position = CGPoint(x: 0, y: -8)
        leapQuestRestartButton.addChild(leapQuestRestartLabel)
        
        addChild(leapQuestRestartButton)
    }
    
    func startLeapQuestGame() {
        leapQuestScore = 0
        leapQuestLives = 3
        leapQuestIsGameOver = false
        updateLeapQuestUI()
        
        leapQuestGameOverLabel.isHidden = true
        leapQuestRestartButton.isHidden = true
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if leapQuestIsGameOver { return }
        
        if currentTime - leapQuestLastSpawnTime > leapQuestSpawnInterval {
            spawnLeapQuestObjects()
            leapQuestLastSpawnTime = currentTime
        }
        
        removeLeapQuestOffScreenObjects()
    }
    
    private func spawnLeapQuestObjects() {
        let leapQuestRandom = Double.random(in: 0...1)
        
        if leapQuestRandom < 0.6 {
            spawnLeapQuestWorm()
        } else if leapQuestRandom < 0.8 {
            spawnLeapQuestFish()
        } else {
            spawnLeapQuestBomb()
        }
    }
    
    private func spawnLeapQuestWorm() {
        let leapQuestWorm = LeapQuestWormNode()
        let leapQuestMinX: CGFloat = 50
        let leapQuestMaxX = max(leapQuestMinX + 10, size.width - 50)
        let leapQuestRandomX = CGFloat.random(in: leapQuestMinX...leapQuestMaxX)
        leapQuestWorm.position = CGPoint(x: leapQuestRandomX, y: size.height + 50)
        leapQuestWorm.zPosition = 5
        addChild(leapQuestWorm)
    }
    
    private func spawnLeapQuestFish() {
        let leapQuestFish = LeapQuestFishNode()
        let leapQuestMinX: CGFloat = 50
        let leapQuestMaxX = max(leapQuestMinX + 10, size.width - 50)
        let leapQuestRandomX = CGFloat.random(in: leapQuestMinX...leapQuestMaxX)
        leapQuestFish.position = CGPoint(x: leapQuestRandomX, y: size.height + 50)
        leapQuestFish.zPosition = 5
        addChild(leapQuestFish)
    }
    
    private func spawnLeapQuestBomb() {
        let leapQuestBomb = LeapQuestBombNode()
        let leapQuestMinX: CGFloat = 50
        let leapQuestMaxX = max(leapQuestMinX + 10, size.width - 50)
        let leapQuestRandomX = CGFloat.random(in: leapQuestMinX...leapQuestMaxX)
        leapQuestBomb.position = CGPoint(x: leapQuestRandomX, y: size.height + 50)
        leapQuestBomb.zPosition = 5
        addChild(leapQuestBomb)
    }
    
    private func removeLeapQuestOffScreenObjects() {
        enumerateChildNodes(withName: "worm") { node, _ in
            if node.position.y < -50 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "fish") { node, _ in
            if node.position.y < -50 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "bomb") { node, _ in
            if node.position.y < -50 {
                node.removeFromParent()
            }
        }
    }
    
    private func updateLeapQuestUI() {
        leapQuestScoreLabel.text = "Score: \(leapQuestScore)"
        leapQuestLivesLabel.text = "Lives: \(leapQuestLives)"
        
        // Track score achievement
        leapQuestAchievementManager.leapQuestHandleScoreUpdate(leapQuestScore)
    }
    
    private func leapQuestGameOver() {
        leapQuestIsGameOver = true
        leapQuestGameOverLabel.isHidden = false
        leapQuestRestartButton.isHidden = false
        
        let leapQuestFinalScoreLabel = SKLabelNode(fontNamed: "Arial-Bold")
        leapQuestFinalScoreLabel.text = "Final Score: \(leapQuestScore)"
        leapQuestFinalScoreLabel.fontSize = 24
        leapQuestFinalScoreLabel.fontColor = LeapQuestColorTheme.Text.primary
        leapQuestFinalScoreLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 - 10)
        leapQuestFinalScoreLabel.zPosition = 100
        addChild(leapQuestFinalScoreLabel)
    }
    
    func restartLeapQuestGame() {
        leapQuestGameOverLabel.isHidden = true
        leapQuestRestartButton.isHidden = true
        
        enumerateChildNodes(withName: "worm") { node, _ in
            node.removeFromParent()
        }
        enumerateChildNodes(withName: "fish") { node, _ in
            node.removeFromParent()
        }
        enumerateChildNodes(withName: "bomb") { node, _ in
            node.removeFromParent()
        }
        
        enumerateChildNodes(withName: "finalScore") { node, _ in
            node.removeFromParent()
        }
        
        startLeapQuestGame()
    }
}

extension LeapQuestGameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let leapQuestBodyA = contact.bodyA
        let leapQuestBodyB = contact.bodyB
        
        let leapQuestNodeA = leapQuestBodyA.node
        let leapQuestNodeB = leapQuestBodyB.node
        
        if (leapQuestNodeA?.name == "frog" && leapQuestNodeB?.name == "worm") ||
           (leapQuestNodeA?.name == "worm" && leapQuestNodeB?.name == "frog") {
            leapQuestCatchWorm()
            leapQuestNodeA?.name == "worm" ? leapQuestNodeA?.removeFromParent() : leapQuestNodeB?.removeFromParent()
        }
        
        if (leapQuestNodeA?.name == "frog" && leapQuestNodeB?.name == "fish") ||
           (leapQuestNodeA?.name == "fish" && leapQuestNodeB?.name == "frog") {
            leapQuestHitFish()
            leapQuestNodeA?.name == "fish" ? leapQuestNodeA?.removeFromParent() : leapQuestNodeB?.removeFromParent()
        }
        
        if (leapQuestNodeA?.name == "frog" && leapQuestNodeB?.name == "bomb") ||
           (leapQuestNodeA?.name == "bomb" && leapQuestNodeB?.name == "frog") {
            leapQuestHitBomb()
            leapQuestNodeA?.name == "bomb" ? leapQuestNodeA?.removeFromParent() : leapQuestNodeB?.removeFromParent()
        }
    }
    
    private func leapQuestCatchWorm() {
        leapQuestScore += 10
        updateLeapQuestUI()
        
        let leapQuestParticleEffect = SKEmitterNode()
        leapQuestParticleEffect.particleTexture = SKTexture.createLeapQuestStarTexture()
        leapQuestParticleEffect.particleBirthRate = 100
        leapQuestParticleEffect.particleLifetime = 0.5
        leapQuestParticleEffect.particleSpeed = 50
        leapQuestParticleEffect.particleSpeedRange = 30
        leapQuestParticleEffect.emissionAngleRange = CGFloat.pi * 2
        leapQuestParticleEffect.particleScale = 0.2
        leapQuestParticleEffect.particleColor = LeapQuestColorTheme.Text.accent
        leapQuestParticleEffect.position = leapQuestFrog.position
        leapQuestParticleEffect.zPosition = 20
        addChild(leapQuestParticleEffect)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            leapQuestParticleEffect.removeFromParent()
        }
    }
    
    private func leapQuestHitFish() {
        leapQuestLives -= 1
        updateLeapQuestUI()
        
        if leapQuestLives <= 0 {
            leapQuestGameOver()
        }
        
        let leapQuestShakeAction = SKAction.sequence([
            SKAction.moveBy(x: -10, y: 0, duration: 0.1),
            SKAction.moveBy(x: 20, y: 0, duration: 0.1),
            SKAction.moveBy(x: -10, y: 0, duration: 0.1)
        ])
        leapQuestFrog.run(leapQuestShakeAction)
    }
    
    private func leapQuestHitBomb() {
        leapQuestLives -= 2
        updateLeapQuestUI()
        
        let leapQuestExplosion = SKEmitterNode()
        leapQuestExplosion.particleTexture = SKTexture.createLeapQuestFireTexture()
        leapQuestExplosion.particleBirthRate = 200
        leapQuestExplosion.particleLifetime = 1.0
        leapQuestExplosion.particleSpeed = 100
        leapQuestExplosion.particleSpeedRange = 50
        leapQuestExplosion.emissionAngleRange = CGFloat.pi * 2
        leapQuestExplosion.particleScale = 0.3
        leapQuestExplosion.particleColor = LeapQuestColorTheme.Secondary.starGold
        leapQuestExplosion.position = leapQuestFrog.position
        leapQuestExplosion.zPosition = 20
        addChild(leapQuestExplosion)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            leapQuestExplosion.removeFromParent()
        }
        
        if leapQuestLives <= 0 {
            leapQuestGameOver()
        }
    }
}

// MARK: - Touch Input System
extension LeapQuestGameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let leapQuestTouchLocation = touch.location(in: self)
        
        if leapQuestIsGameOver {
            let leapQuestNodesAtPoint = nodes(at: leapQuestTouchLocation)
            for node in leapQuestNodesAtPoint {
                if node.name == "restart" {
                    restartLeapQuestGame()
                    return
                }
            }
        } else {
            startLeapQuestAiming(at: leapQuestTouchLocation)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, leapQuestIsAiming else { return }
        let leapQuestTouchLocation = touch.location(in: self)
        updateLeapQuestAimIndicator(to: leapQuestTouchLocation)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, leapQuestIsAiming else { return }
        let leapQuestTouchLocation = touch.location(in: self)
        performLeapQuestJump(to: leapQuestTouchLocation)
        endLeapQuestAiming()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        endLeapQuestAiming()
    }
    
    private func startLeapQuestAiming(at position: CGPoint) {
        leapQuestTouchStartPosition = position
        leapQuestIsAiming = true
        createLeapQuestAimIndicator(at: position)
    }
    
    private func updateLeapQuestAimIndicator(to position: CGPoint) {
        guard let startPosition = leapQuestTouchStartPosition,
              let indicator = leapQuestAimIndicator else { return }
        
        let leapQuestDirection = CGVector(
            dx: position.x - startPosition.x,
            dy: position.y - startPosition.y
        )
        
        let leapQuestDistance = sqrt(leapQuestDirection.dx * leapQuestDirection.dx + leapQuestDirection.dy * leapQuestDirection.dy)
        let leapQuestMaxDistance: CGFloat = 100
        let leapQuestClampedDistance = min(leapQuestDistance, leapQuestMaxDistance)
        
        let leapQuestNormalizedDirection = CGVector(
            dx: leapQuestDirection.dx / max(leapQuestDistance, 1),
            dy: leapQuestDirection.dy / max(leapQuestDistance, 1)
        )
        
        let leapQuestEndPosition = CGPoint(
            x: startPosition.x + leapQuestNormalizedDirection.dx * leapQuestClampedDistance,
            y: startPosition.y + leapQuestNormalizedDirection.dy * leapQuestClampedDistance
        )
        
        let leapQuestPath = UIBezierPath()
        leapQuestPath.move(to: startPosition)
        leapQuestPath.addLine(to: leapQuestEndPosition)
        
        indicator.path = leapQuestPath.cgPath
        
        let leapQuestIntensity = leapQuestClampedDistance / leapQuestMaxDistance
        let leapQuestAlpha = 0.3 + (leapQuestIntensity * 0.7)
        indicator.alpha = leapQuestAlpha
        
        let leapQuestLineWidth = 2 + (leapQuestIntensity * 6)
        indicator.lineWidth = leapQuestLineWidth
    }
    
    private func performLeapQuestJump(to position: CGPoint) {
        guard let startPosition = leapQuestTouchStartPosition else { return }
        
        let leapQuestDirection = CGVector(
            dx: position.x - startPosition.x,
            dy: position.y - startPosition.y
        )
        
        let leapQuestDistance = sqrt(leapQuestDirection.dx * leapQuestDirection.dx + leapQuestDirection.dy * leapQuestDirection.dy)
        let leapQuestMaxDistance: CGFloat = 100
        let leapQuestClampedDistance = min(leapQuestDistance, leapQuestMaxDistance)
        
        let leapQuestNormalizedDirection = CGVector(
            dx: leapQuestDirection.dx / max(leapQuestDistance, 1),
            dy: leapQuestDirection.dy / max(leapQuestDistance, 1)
        )
        
        let leapQuestJumpStrength = leapQuestClampedDistance / leapQuestMaxDistance
        let leapQuestJumpDistance = 50 + (leapQuestJumpStrength * 150)
        
        let leapQuestTargetPosition = CGPoint(
            x: leapQuestFrog.position.x + leapQuestNormalizedDirection.dx * leapQuestJumpDistance,
            y: leapQuestFrog.position.y + leapQuestNormalizedDirection.dy * leapQuestJumpDistance
        )
        
        let leapQuestClampedTargetPosition = CGPoint(
            x: max(50, min(size.width - 50, leapQuestTargetPosition.x)),
            y: max(100, min(size.height - 100, leapQuestTargetPosition.y))
        )
        
        leapQuestFrog.moveTo(position: leapQuestClampedTargetPosition)
        
        createLeapQuestJumpEffect(at: leapQuestClampedTargetPosition)
        
        // Track jump achievement
        leapQuestAchievementManager.leapQuestHandleJump()
        
        // Track first jump achievement
        let currentJumps = leapQuestAchievementManager.leapQuestGetAchievement(.jumpMaster)?.leapQuestCurrentProgress ?? 0
        if currentJumps == 1 {
            leapQuestAchievementManager.leapQuestHandleFirstJump()
        }
    }
    
    private func createLeapQuestJumpEffect(at position: CGPoint) {
        let leapQuestJumpEffect = SKEmitterNode()
        leapQuestJumpEffect.particleTexture = SKTexture.createLeapQuestStarTexture()
        leapQuestJumpEffect.particleBirthRate = 100
        leapQuestJumpEffect.particleLifetime = 0.8
        leapQuestJumpEffect.particleSpeed = 80
        leapQuestJumpEffect.particleSpeedRange = 40
        leapQuestJumpEffect.emissionAngle = CGFloat.pi / 2
        leapQuestJumpEffect.emissionAngleRange = CGFloat.pi
        leapQuestJumpEffect.particleScale = 0.15
        leapQuestJumpEffect.particleScaleRange = 0.08
        leapQuestJumpEffect.particleColor = LeapQuestColorTheme.Text.accent
        leapQuestJumpEffect.particleColorBlendFactor = 0.9
        leapQuestJumpEffect.particleAlpha = 0.8
        leapQuestJumpEffect.position = position
        leapQuestJumpEffect.zPosition = 10
        
        let leapQuestStopEffect = SKAction.sequence([
            SKAction.wait(forDuration: 0.2),
            SKAction.run { leapQuestJumpEffect.particleBirthRate = 0 }
        ])
        leapQuestJumpEffect.run(leapQuestStopEffect)
        
        addChild(leapQuestJumpEffect)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            leapQuestJumpEffect.removeFromParent()
        }
    }
    
    private func createLeapQuestAimIndicator(at position: CGPoint) {
        let leapQuestPath = UIBezierPath()
        leapQuestPath.move(to: position)
        leapQuestPath.addLine(to: position)
        
        leapQuestAimIndicator = SKShapeNode(path: leapQuestPath.cgPath)
        leapQuestAimIndicator?.strokeColor = LeapQuestColorTheme.Text.accent
        leapQuestAimIndicator?.lineWidth = 3
        leapQuestAimIndicator?.alpha = 0.5
        leapQuestAimIndicator?.zPosition = 15
        
        if let indicator = leapQuestAimIndicator {
            addChild(indicator)
        }
    }
    
    private func endLeapQuestAiming() {
        leapQuestIsAiming = false
        leapQuestTouchStartPosition = nil
        leapQuestAimIndicator?.removeFromParent()
        leapQuestAimIndicator = nil
    }
}
