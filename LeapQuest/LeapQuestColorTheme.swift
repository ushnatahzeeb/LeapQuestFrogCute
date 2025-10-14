import UIKit


struct LeapQuestColorTheme {
    

    struct Primary {

        static let cosmicBlue = UIColor(red: 0.1, green: 0.2, blue: 0.4, alpha: 1.0)
        

        static let waterBlue = UIColor(red: 0.2, green: 0.6, blue: 0.9, alpha: 1.0)
        

        static let frogGreen = UIColor(red: 0.3, green: 0.8, blue: 0.3, alpha: 1.0)

        static let cosmicPurple = UIColor(red: 0.6, green: 0.3, blue: 0.8, alpha: 1.0)
    }
    

    struct Secondary {

        static let lightWater = UIColor(red: 0.4, green: 0.8, blue: 1.0, alpha: 1.0)
        

        static let deepSpace = UIColor(red: 0.05, green: 0.1, blue: 0.2, alpha: 1.0)
        

        static let starGold = UIColor(red: 1.0, green: 0.8, blue: 0.3, alpha: 1.0)

        static let platformBrown = UIColor(red: 0.6, green: 0.4, blue: 0.2, alpha: 1.0)
    }

    struct Text {

        static let primary = UIColor.white
        
 
        static let secondary = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        

        static let accent = Primary.waterBlue
        

        static let success = Primary.frogGreen
        

        static let warning = Secondary.starGold
        

        static let error = UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0)
    }
    

    struct Background {

        static let primary = Secondary.deepSpace
        

        static let secondary = Primary.cosmicBlue
        

        static let card = Primary.cosmicBlue.withAlphaComponent(0.3)
        

        static let glass = UIColor.white.withAlphaComponent(0.1)
    }
    
    // MARK: - Interactive Colors
    struct Interactive {

        static let buttonPrimary = Primary.waterBlue


        static let buttonSecondary = Primary.cosmicPurple
        

        static let buttonSuccess = Primary.frogGreen
        

        static let buttonDanger = UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0)
        

        static let selected = Secondary.lightWater

        static let disabled = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
    }
    
    // MARK: - Border Colors
    struct Border {

        static let primary = Primary.waterBlue.withAlphaComponent(0.5)
        

        static let success = Primary.frogGreen.withAlphaComponent(0.5)
        

        static let warning = Secondary.starGold.withAlphaComponent(0.5)
        

        static let error = UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 0.5)
    }
    
    // MARK: - Shadow Colors
    struct Shadow {

        static let primary = Secondary.deepSpace.withAlphaComponent(0.3)
        

        static let glow = Primary.waterBlue.withAlphaComponent(0.2)
        

        static let success = Primary.frogGreen.withAlphaComponent(0.2)
    }
}

// MARK: - LeapQuest Gradient Themes
extension LeapQuestColorTheme {
    
    struct Gradients {

        static let cosmicWater: [UIColor] = [
            Secondary.deepSpace,
            Primary.cosmicBlue,
            Primary.waterBlue,
            Secondary.lightWater
        ]
        

        static let platform: [UIColor] = [
            Secondary.platformBrown,
            UIColor(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0),
            Secondary.starGold
        ]
        

        static let frog: [UIColor] = [
            UIColor(red: 0.2, green: 0.7, blue: 0.2, alpha: 1.0),
            Primary.frogGreen,
            UIColor(red: 0.4, green: 0.9, blue: 0.4, alpha: 1.0)
        ]

        static let success: [UIColor] = [
            Primary.frogGreen,
            Secondary.starGold,
            UIColor(red: 0.8, green: 0.9, blue: 0.3, alpha: 1.0)
        ]
        

        static let coins: [UIColor] = [
            Secondary.starGold,
            UIColor(red: 1.0, green: 0.9, blue: 0.4, alpha: 1.0),
            UIColor(red: 0.9, green: 0.8, blue: 0.2, alpha: 1.0)
        ]
    }
}

// MARK: - Utility Extensions
extension LeapQuestColorTheme {
    

    static func colorForFactCategory(_ category: LeapQuestFactCategory) -> UIColor {
        switch category {
        case .nature: return Primary.frogGreen
        case .science: return Primary.waterBlue
        case .technology: return Primary.cosmicPurple
        case .space: return Secondary.lightWater
        case .history: return Secondary.starGold
        }
    }
    

    static func colorForDifficulty(_ difficulty: LeapQuestPuzzleDifficulty) -> UIColor {
        switch difficulty {
        case .easy: return Primary.frogGreen
        case .medium: return Secondary.starGold
        case .hard: return UIColor(red: 1.0, green: 0.6, blue: 0.3, alpha: 1.0)
        case .expert: return Primary.cosmicPurple
        }
    }
    

    static func backgroundGradient(for screen: String) -> [UIColor] {
        switch screen {
        case "game": return Gradients.cosmicWater
        case "shop": return Gradients.coins
        case "achievements": return Gradients.success
        case "facts": return Gradients.cosmicWater
        case "puzzles": return Gradients.platform
        default: return Gradients.cosmicWater
        }
    }
}
