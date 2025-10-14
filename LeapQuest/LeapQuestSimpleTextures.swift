import SpriteKit

extension SKTexture {
    
    static func createLeapQuestFrogTexture() -> SKTexture {
        let leapQuestSize = CGSize(width: 80, height: 80)
        let leapQuestRenderer = UIGraphicsImageRenderer(size: leapQuestSize)
        let leapQuestImage = leapQuestRenderer.image { context in
            let cgContext = context.cgContext
            
            let leapQuestGradientColors = [
                UIColor(red: 0.2, green: 0.8, blue: 0.3, alpha: 1.0).cgColor,
                UIColor(red: 0.1, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
            ]
            let leapQuestGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: leapQuestGradientColors as CFArray, locations: [0.0, 1.0])!
            
            let leapQuestFrogPath = UIBezierPath(ovalIn: CGRect(x: 10, y: 10, width: 60, height: 60))
            cgContext.addPath(leapQuestFrogPath.cgPath)
            cgContext.clip()
            cgContext.drawRadialGradient(leapQuestGradient, startCenter: CGPoint(x: 40, y: 40), startRadius: 0, endCenter: CGPoint(x: 40, y: 40), endRadius: 40, options: [])
            cgContext.resetClip()
            
            UIColor.white.setFill()
            cgContext.fillEllipse(in: CGRect(x: 25, y: 55, width: 12, height: 12))
            cgContext.fillEllipse(in: CGRect(x: 43, y: 55, width: 12, height: 12))
            
            UIColor.black.setFill()
            cgContext.fillEllipse(in: CGRect(x: 28, y: 58, width: 6, height: 6))
            cgContext.fillEllipse(in: CGRect(x: 46, y: 58, width: 6, height: 6))
            
            UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0).setFill()
            cgContext.fillEllipse(in: CGRect(x: 37, y: 45, width: 6, height: 6))
            
            UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).setFill()
            cgContext.fillEllipse(in: CGRect(x: 38, y: 46, width: 2, height: 2))
        }
        return SKTexture(image: leapQuestImage)
    }
    
    static func createLeapQuestWormTexture() -> SKTexture {
        let leapQuestSize = CGSize(width: 40, height: 40)
        let leapQuestRenderer = UIGraphicsImageRenderer(size: leapQuestSize)
        let leapQuestImage = leapQuestRenderer.image { context in
            let cgContext = context.cgContext
            
            let leapQuestWormColors = [
                UIColor(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0).cgColor,
                UIColor(red: 0.6, green: 0.4, blue: 0.2, alpha: 1.0).cgColor
            ]
            let leapQuestWormGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: leapQuestWormColors as CFArray, locations: [0.0, 1.0])!
            
            let leapQuestWormPath = UIBezierPath(ovalIn: CGRect(x: 5, y: 10, width: 30, height: 25))
            cgContext.addPath(leapQuestWormPath.cgPath)
            cgContext.clip()
            cgContext.drawLinearGradient(leapQuestWormGradient, start: CGPoint(x: 20, y: 10), end: CGPoint(x: 20, y: 35), options: [])
            cgContext.resetClip()
            
            UIColor.black.setFill()
            cgContext.fillEllipse(in: CGRect(x: 12, y: 18, width: 4, height: 4))
            cgContext.fillEllipse(in: CGRect(x: 24, y: 18, width: 4, height: 4))
            
            UIColor.white.setFill()
            cgContext.fillEllipse(in: CGRect(x: 13, y: 19, width: 1.5, height: 1.5))
            cgContext.fillEllipse(in: CGRect(x: 25, y: 19, width: 1.5, height: 1.5))
            
            UIColor(red: 0.9, green: 0.7, blue: 0.5, alpha: 1.0).setFill()
            cgContext.fillEllipse(in: CGRect(x: 18, y: 25, width: 4, height: 4))
        }
        return SKTexture(image: leapQuestImage)
    }
    
    static func createLeapQuestFishTexture() -> SKTexture {
        let leapQuestSize = CGSize(width: 50, height: 50)
        let leapQuestRenderer = UIGraphicsImageRenderer(size: leapQuestSize)
        let leapQuestImage = leapQuestRenderer.image { context in
            let cgContext = context.cgContext
            
            let leapQuestFishColors = [
                UIColor(red: 0.2, green: 0.4, blue: 0.9, alpha: 1.0).cgColor,
                UIColor(red: 0.1, green: 0.3, blue: 0.7, alpha: 1.0).cgColor
            ]
            let leapQuestFishGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: leapQuestFishColors as CFArray, locations: [0.0, 1.0])!
            
            let leapQuestFishPath = UIBezierPath(ovalIn: CGRect(x: 5, y: 15, width: 40, height: 25))
            cgContext.addPath(leapQuestFishPath.cgPath)
            cgContext.clip()
            cgContext.drawLinearGradient(leapQuestFishGradient, start: CGPoint(x: 25, y: 15), end: CGPoint(x: 25, y: 40), options: [])
            cgContext.resetClip()
            
            UIColor.white.setFill()
            cgContext.fillEllipse(in: CGRect(x: 18, y: 28, width: 8, height: 8))
            
            UIColor.black.setFill()
            cgContext.fillEllipse(in: CGRect(x: 20, y: 30, width: 4, height: 4))
            
            UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).setFill()
            cgContext.fillEllipse(in: CGRect(x: 20.5, y: 30.5, width: 1.5, height: 1.5))
            
            let leapQuestFinPath = UIBezierPath()
            leapQuestFinPath.move(to: CGPoint(x: 25, y: 27))
            leapQuestFinPath.addLine(to: CGPoint(x: 35, y: 25))
            leapQuestFinPath.addLine(to: CGPoint(x: 25, y: 32))
            leapQuestFinPath.close()
            
            UIColor(red: 0.1, green: 0.2, blue: 0.6, alpha: 1.0).setFill()
            cgContext.addPath(leapQuestFinPath.cgPath)
            cgContext.fillPath()
        }
        return SKTexture(image: leapQuestImage)
    }
    
    static func createLeapQuestBombTexture() -> SKTexture {
        let leapQuestSize = CGSize(width: 45, height: 45)
        let leapQuestRenderer = UIGraphicsImageRenderer(size: leapQuestSize)
        let leapQuestImage = leapQuestRenderer.image { context in
            let cgContext = context.cgContext
            
            let leapQuestBombColors = [
                UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0).cgColor,
                UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0).cgColor
            ]
            let leapQuestBombGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: leapQuestBombColors as CFArray, locations: [0.0, 1.0])!
            
            let leapQuestBombPath = UIBezierPath(ovalIn: CGRect(x: 5, y: 5, width: 35, height: 35))
            cgContext.addPath(leapQuestBombPath.cgPath)
            cgContext.clip()
            cgContext.drawRadialGradient(leapQuestBombGradient, startCenter: CGPoint(x: 22.5, y: 22.5), startRadius: 0, endCenter: CGPoint(x: 22.5, y: 22.5), endRadius: 20, options: [])
            cgContext.resetClip()
            
            UIColor.red.setFill()
            cgContext.fillEllipse(in: CGRect(x: 18, y: 18, width: 9, height: 9))
            
            UIColor.orange.setFill()
            cgContext.fillEllipse(in: CGRect(x: 20, y: 20, width: 5, height: 5))
            
            UIColor.yellow.setFill()
            cgContext.fillEllipse(in: CGRect(x: 21, y: 21, width: 3, height: 3))
            
            UIColor.black.setStroke()
            cgContext.setLineWidth(2)
            cgContext.strokeEllipse(in: CGRect(x: 18, y: 18, width: 9, height: 9))
        }
        return SKTexture(image: leapQuestImage)
    }
    
    static func createLeapQuestWaterBackgroundTexture() -> SKTexture {
        let leapQuestSize = CGSize(width: 400, height: 600)
        let leapQuestRenderer = UIGraphicsImageRenderer(size: leapQuestSize)
        let leapQuestImage = leapQuestRenderer.image { context in
            let cgContext = context.cgContext
            
            let leapQuestColors = [
                UIColor(red: 0.05, green: 0.3, blue: 0.6, alpha: 1.0).cgColor,
                UIColor(red: 0.1, green: 0.5, blue: 0.8, alpha: 1.0).cgColor,
                UIColor(red: 0.15, green: 0.7, blue: 0.9, alpha: 1.0).cgColor,
                UIColor(red: 0.2, green: 0.8, blue: 1.0, alpha: 1.0).cgColor
            ]
            
            let leapQuestGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                             colors: leapQuestColors as CFArray,
                                             locations: [0.0, 0.3, 0.7, 1.0])!
            
            cgContext.drawLinearGradient(leapQuestGradient,
                                       start: CGPoint(x: 0, y: leapQuestSize.height),
                                       end: CGPoint(x: 0, y: 0),
                                       options: [])
            
            for _ in 0..<30 {
                let x = CGFloat.random(in: 0...leapQuestSize.width)
                let y = CGFloat.random(in: 0...leapQuestSize.height)
                let radius = CGFloat.random(in: 3...12)
                let alpha = CGFloat.random(in: 0.1...0.4)
                
                cgContext.setFillColor(UIColor.white.withAlphaComponent(alpha).cgColor)
                cgContext.fillEllipse(in: CGRect(x: x - radius, y: y - radius, width: radius * 2, height: radius * 2))
            }
            
            for _ in 0..<15 {
                let x = CGFloat.random(in: 0...leapQuestSize.width)
                let y = CGFloat.random(in: 0...leapQuestSize.height)
                let size = CGFloat.random(in: 20...60)
                
                cgContext.setFillColor(UIColor(red: 0.1, green: 0.4, blue: 0.7, alpha: 0.3).cgColor)
                cgContext.fillEllipse(in: CGRect(x: x - size/2, y: y - size/2, width: size, height: size))
            }
        }
        return SKTexture(image: leapQuestImage)
    }
    
    static func createLeapQuestStarTexture() -> SKTexture {
        let leapQuestSize = CGSize(width: 20, height: 20)
        let leapQuestRenderer = UIGraphicsImageRenderer(size: leapQuestSize)
        let leapQuestImage = leapQuestRenderer.image { context in
            let cgContext = context.cgContext
            
            let leapQuestStarColors = [
                UIColor.yellow.withAlphaComponent(0.9).cgColor,
                UIColor.orange.withAlphaComponent(0.7).cgColor
            ]
            let leapQuestStarGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: leapQuestStarColors as CFArray, locations: [0.0, 1.0])!
            
            let leapQuestStarPath = UIBezierPath()
            let leapQuestCenter = CGPoint(x: 10, y: 10)
            let leapQuestOuterRadius: CGFloat = 8
            let leapQuestInnerRadius: CGFloat = 3
            
            for i in 0..<10 {
                let angle = CGFloat(i) * CGFloat.pi / 5 - CGFloat.pi / 2
                let radius = i % 2 == 0 ? leapQuestOuterRadius : leapQuestInnerRadius
                let x = leapQuestCenter.x + cos(angle) * radius
                let y = leapQuestCenter.y + sin(angle) * radius
                
                if i == 0 {
                    leapQuestStarPath.move(to: CGPoint(x: x, y: y))
                } else {
                    leapQuestStarPath.addLine(to: CGPoint(x: x, y: y))
                }
            }
            leapQuestStarPath.close()
            
            cgContext.addPath(leapQuestStarPath.cgPath)
            cgContext.clip()
            cgContext.drawRadialGradient(leapQuestStarGradient, startCenter: leapQuestCenter, startRadius: 0, endCenter: leapQuestCenter, endRadius: leapQuestOuterRadius, options: [])
        }
        return SKTexture(image: leapQuestImage)
    }
    
    static func createLeapQuestFireTexture() -> SKTexture {
        let leapQuestSize = CGSize(width: 20, height: 20)
        let leapQuestRenderer = UIGraphicsImageRenderer(size: leapQuestSize)
        let leapQuestImage = leapQuestRenderer.image { context in
            UIColor.orange.setFill()
            context.cgContext.fillEllipse(in: CGRect(origin: .zero, size: leapQuestSize))
        }
        return SKTexture(image: leapQuestImage)
    }
    
    static func createLeapQuestWaterDropTexture() -> SKTexture {
        let leapQuestSize = CGSize(width: 10, height: 10)
        let leapQuestRenderer = UIGraphicsImageRenderer(size: leapQuestSize)
        let leapQuestImage = leapQuestRenderer.image { context in
            let cgContext = context.cgContext
            
            let leapQuestDropColors = [
                UIColor.white.withAlphaComponent(0.8).cgColor,
                UIColor.cyan.withAlphaComponent(0.6).cgColor
            ]
            let leapQuestDropGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: leapQuestDropColors as CFArray, locations: [0.0, 1.0])!
            
            cgContext.drawRadialGradient(leapQuestDropGradient, startCenter: CGPoint(x: 5, y: 8), startRadius: 0, endCenter: CGPoint(x: 5, y: 8), endRadius: 5, options: [])
        }
        return SKTexture(image: leapQuestImage)
    }
    
    static func createLeapQuestBubbleTexture() -> SKTexture {
        let leapQuestSize = CGSize(width: 15, height: 15)
        let leapQuestRenderer = UIGraphicsImageRenderer(size: leapQuestSize)
        let leapQuestImage = leapQuestRenderer.image { context in
            let cgContext = context.cgContext
            
            let leapQuestBubbleColors = [
                UIColor.white.withAlphaComponent(0.4).cgColor,
                UIColor.cyan.withAlphaComponent(0.2).cgColor
            ]
            let leapQuestBubbleGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: leapQuestBubbleColors as CFArray, locations: [0.0, 1.0])!
            
            cgContext.drawRadialGradient(leapQuestBubbleGradient, startCenter: CGPoint(x: 7.5, y: 7.5), startRadius: 0, endCenter: CGPoint(x: 7.5, y: 7.5), endRadius: 7.5, options: [])
            
            UIColor.white.withAlphaComponent(0.6).setStroke()
            cgContext.setLineWidth(1)
            cgContext.strokeEllipse(in: CGRect(x: 2, y: 2, width: 11, height: 11))
        }
        return SKTexture(image: leapQuestImage)
    }
}
