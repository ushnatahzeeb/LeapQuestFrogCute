import UIKit

class LeapQuestGradientView: UIView {
    
    enum LeapQuestGradientType {
        case water
        case sky
        case sunset
        case forest
        case cosmic
    }
    
    private var leapQuestGradientLayer: CAGradientLayer!
    private var leapQuestGradientType: LeapQuestGradientType
    
    init(leapQuestGradientType: LeapQuestGradientType) {
        self.leapQuestGradientType = leapQuestGradientType
        super.init(frame: .zero)
        setupLeapQuestGradient()
    }
    
    required init?(coder: NSCoder) {
        self.leapQuestGradientType = .water
        super.init(coder: coder)
        setupLeapQuestGradient()
    }
    
    private func setupLeapQuestGradient() {
        leapQuestGradientLayer = CAGradientLayer()
        layer.addSublayer(leapQuestGradientLayer)
        
        switch leapQuestGradientType {
        case .water:
            leapQuestGradientLayer.colors = LeapQuestColorTheme.Gradients.cosmicWater.map { $0.cgColor }
        case .sky:
            leapQuestGradientLayer.colors = [
                LeapQuestColorTheme.Secondary.lightWater.cgColor,
                LeapQuestColorTheme.Primary.waterBlue.cgColor,
                LeapQuestColorTheme.Primary.cosmicBlue.cgColor
            ]
        case .sunset:
            leapQuestGradientLayer.colors = LeapQuestColorTheme.Gradients.coins.map { $0.cgColor }
        case .forest:
            leapQuestGradientLayer.colors = LeapQuestColorTheme.Gradients.frog.map { $0.cgColor }
        case .cosmic:
            leapQuestGradientLayer.colors = LeapQuestColorTheme.Gradients.cosmicWater.map { $0.cgColor }
        }
        
        leapQuestGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        leapQuestGradientLayer.endPoint = CGPoint(x: 1, y: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leapQuestGradientLayer.frame = bounds
    }
    
    func leapQuestAnimateGradient() {
        let leapQuestAnimation = CABasicAnimation(keyPath: "colors")
        leapQuestAnimation.duration = 3.0
        leapQuestAnimation.autoreverses = true
        leapQuestAnimation.repeatCount = .infinity
        
        switch leapQuestGradientType {
        case .water:
            leapQuestAnimation.fromValue = leapQuestGradientLayer.colors
            leapQuestAnimation.toValue = [
                LeapQuestColorTheme.Primary.cosmicBlue.cgColor,
                LeapQuestColorTheme.Primary.waterBlue.cgColor,
                LeapQuestColorTheme.Secondary.lightWater.cgColor
            ]
        default:
            return
        }
        
        leapQuestGradientLayer.add(leapQuestAnimation, forKey: "gradientAnimation")
    }
}

class LeapQuestGlassmorphismView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLeapQuestGlassmorphism()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLeapQuestGlassmorphism()
    }
    
    private func setupLeapQuestGlassmorphism() {
        backgroundColor = UIColor.white.withAlphaComponent(0.1)
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = LeapQuestColorTheme.Border.primary.cgColor
        
        let leapQuestBlurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let leapQuestBlurView = UIVisualEffectView(effect: leapQuestBlurEffect)
        leapQuestBlurView.frame = bounds
        leapQuestBlurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        leapQuestBlurView.layer.cornerRadius = 16
        leapQuestBlurView.layer.masksToBounds = true
        insertSubview(leapQuestBlurView, at: 0)
        
        layer.shadowColor = LeapQuestColorTheme.Shadow.primary.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 12
        layer.shadowOpacity = 0.3
    }
}

class LeapQuestFloatingPlatformView: UIView {
    
    private var leapQuestPlatformImageView: UILabel!
    private var leapQuestGlowLayer: CALayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLeapQuestFloatingPlatform()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLeapQuestFloatingPlatform()
    }
    
    private func setupLeapQuestFloatingPlatform() {
        backgroundColor = UIColor.clear
        
        leapQuestPlatformImageView = UILabel()
        leapQuestPlatformImageView.font = UIFont.systemFont(ofSize: 32)
        leapQuestPlatformImageView.textAlignment = .center
        leapQuestPlatformImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leapQuestPlatformImageView)
        
        leapQuestGlowLayer = CALayer()
        leapQuestGlowLayer.backgroundColor = LeapQuestColorTheme.Shadow.glow.cgColor
        leapQuestGlowLayer.cornerRadius = 30
        layer.insertSublayer(leapQuestGlowLayer, at: 0)
        
        NSLayoutConstraint.activate([
            leapQuestPlatformImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            leapQuestPlatformImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            leapQuestPlatformImageView.widthAnchor.constraint(equalToConstant: 60),
            leapQuestPlatformImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leapQuestGlowLayer.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        leapQuestGlowLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    func configureLeapQuestPlatform(_ platform: LeapQuestPlatformModel) {
        leapQuestPlatformImageView.text = platform.leapQuestPlatformEmoji
        
        switch platform.leapQuestPlatformType {
        case .stable:
            leapQuestGlowLayer.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.3).cgColor
        case .swinging:
            leapQuestGlowLayer.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.3).cgColor
            startLeapQuestSwingingAnimation()
        case .falling:
            leapQuestGlowLayer.backgroundColor = UIColor.systemRed.withAlphaComponent(0.3).cgColor
            startLeapQuestFallingAnimation()
        case .moving:
            leapQuestGlowLayer.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.3).cgColor
            startLeapQuestMovingAnimation()
        }
    }
    
    private func startLeapQuestSwingingAnimation() {
        let leapQuestAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        leapQuestAnimation.fromValue = -0.1
        leapQuestAnimation.toValue = 0.1
        leapQuestAnimation.duration = 2.0
        leapQuestAnimation.autoreverses = true
        leapQuestAnimation.repeatCount = .infinity
        layer.add(leapQuestAnimation, forKey: "swinging")
    }
    
    private func startLeapQuestFallingAnimation() {
        let leapQuestAnimation = CABasicAnimation(keyPath: "position.y")
        leapQuestAnimation.fromValue = center.y
        leapQuestAnimation.toValue = center.y + 20
        leapQuestAnimation.duration = 1.5
        leapQuestAnimation.autoreverses = true
        leapQuestAnimation.repeatCount = .infinity
        layer.add(leapQuestAnimation, forKey: "falling")
    }
    
    private func startLeapQuestMovingAnimation() {
        let leapQuestAnimation = CABasicAnimation(keyPath: "position.x")
        leapQuestAnimation.fromValue = center.x - 15
        leapQuestAnimation.toValue = center.x + 15
        leapQuestAnimation.duration = 3.0
        leapQuestAnimation.autoreverses = true
        leapQuestAnimation.repeatCount = .infinity
        layer.add(leapQuestAnimation, forKey: "moving")
    }
    
    func leapQuestStopAnimations() {
        layer.removeAllAnimations()
    }
}

class LeapQuestAnimatedFrogView: UIView {
    
    private var leapQuestFrogImageView: UILabel!
    private var leapQuestJumpLayer: CALayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLeapQuestAnimatedFrog()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLeapQuestAnimatedFrog()
    }
    
    private func setupLeapQuestAnimatedFrog() {
        backgroundColor = UIColor.clear
        
        leapQuestFrogImageView = UILabel()
        leapQuestFrogImageView.font = UIFont.systemFont(ofSize: 48)
        leapQuestFrogImageView.text = "🐸"
        leapQuestFrogImageView.textAlignment = .center
        leapQuestFrogImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leapQuestFrogImageView)
        
        leapQuestJumpLayer = CALayer()
        leapQuestJumpLayer.backgroundColor = LeapQuestColorTheme.Shadow.success.cgColor
        leapQuestJumpLayer.cornerRadius = 30
        layer.insertSublayer(leapQuestJumpLayer, at: 0)
        
        NSLayoutConstraint.activate([
            leapQuestFrogImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            leapQuestFrogImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            leapQuestFrogImageView.widthAnchor.constraint(equalToConstant: 60),
            leapQuestFrogImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        startLeapQuestIdleAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leapQuestJumpLayer.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        leapQuestJumpLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private func startLeapQuestIdleAnimation() {
        let leapQuestAnimation = CABasicAnimation(keyPath: "transform.scale")
        leapQuestAnimation.fromValue = 1.0
        leapQuestAnimation.toValue = 1.1
        leapQuestAnimation.duration = 1.0
        leapQuestAnimation.autoreverses = true
        leapQuestAnimation.repeatCount = .infinity
        leapQuestFrogImageView.layer.add(leapQuestAnimation, forKey: "idle")
    }
    
    func leapQuestJumpTo(_ targetPoint: CGPoint, completion: @escaping () -> Void) {
        let leapQuestJumpAnimation = CAKeyframeAnimation(keyPath: "position")
        let leapQuestCurrentPosition = center
        let leapQuestMidPoint = CGPoint(
            x: (leapQuestCurrentPosition.x + targetPoint.x) / 2,
            y: min(leapQuestCurrentPosition.y, targetPoint.y) - 50
        )
        
        leapQuestJumpAnimation.values = [leapQuestCurrentPosition, leapQuestMidPoint, targetPoint]
        leapQuestJumpAnimation.keyTimes = [0.0, 0.5, 1.0]
        leapQuestJumpAnimation.duration = 0.8
        leapQuestJumpAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion()
        }
        layer.add(leapQuestJumpAnimation, forKey: "jump")
        center = targetPoint
        CATransaction.commit()
    }
}

class LeapQuestParticleEffectView: UIView {
    
    private var leapQuestParticleLayer: CAEmitterLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLeapQuestParticleEffect()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLeapQuestParticleEffect()
    }
    
    private func setupLeapQuestParticleEffect() {
        leapQuestParticleLayer = CAEmitterLayer()
        leapQuestParticleLayer.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        leapQuestParticleLayer.emitterSize = CGSize(width: 20, height: 20)
        leapQuestParticleLayer.emitterShape = .point
        layer.addSublayer(leapQuestParticleLayer)
        
        let leapQuestCell = CAEmitterCell()
        leapQuestCell.birthRate = 50
        leapQuestCell.lifetime = 1.0
        leapQuestCell.velocity = 50
        leapQuestCell.velocityRange = 30
        leapQuestCell.emissionRange = .pi * 2
        leapQuestCell.scale = 0.3
        leapQuestCell.scaleRange = 0.2
        leapQuestCell.contents = createLeapQuestParticleImage().cgImage
        
        leapQuestParticleLayer.emitterCells = [leapQuestCell]
    }
    
    private func createLeapQuestParticleImage() -> UIImage {
        let leapQuestSize = CGSize(width: 10, height: 10)
        let leapQuestRenderer = UIGraphicsImageRenderer(size: leapQuestSize)
        return leapQuestRenderer.image { context in
            LeapQuestColorTheme.Secondary.starGold.setFill()
            context.cgContext.fillEllipse(in: CGRect(origin: .zero, size: leapQuestSize))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leapQuestParticleLayer.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    func leapQuestStartParticles() {
        leapQuestParticleLayer.birthRate = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.leapQuestParticleLayer.birthRate = 0.0
        }
    }
}


