import Foundation

// MARK: - Puzzle Type
enum LeapQuestPuzzleType: String, Codable, CaseIterable {
    case ticTacToe = "Tic Tac Toe"
    case memorySequence = "Memory Sequence"
    
    var leapQuestEmoji: String {
        switch self {
        case .ticTacToe: return "🎯"
        case .memorySequence: return "🧠"
        }
    }
    
    var leapQuestDescription: String {
        switch self {
        case .ticTacToe: return "Classic 3x3 grid game. Get three in a row to win!"
        case .memorySequence: return "Watch the sequence and repeat it back. Test your memory!"
        }
    }
    
    var leapQuestDifficulty: LeapQuestPuzzleDifficulty {
        switch self {
        case .ticTacToe: return .medium
        case .memorySequence: return .hard
        }
    }
    
    var leapQuestRewardCoins: Int {
        switch self {
        case .ticTacToe: return 50
        case .memorySequence: return 100
        }
    }
}


// MARK: - Puzzle State
enum LeapQuestPuzzleState: String, Codable {
    case locked = "Locked"
    case available = "Available"
    case completed = "Completed"
    case perfect = "Perfect"
}

// MARK: - Puzzle
struct LeapQuestPuzzle: Codable, Identifiable {
    let id = UUID()
    let leapQuestType: LeapQuestPuzzleType
    var leapQuestState: LeapQuestPuzzleState
    var leapQuestBestScore: Int
    var leapQuestAttempts: Int
    var leapQuestCompletionDate: Date?
    
    init(leapQuestType: LeapQuestPuzzleType) {
        self.leapQuestType = leapQuestType
        self.leapQuestState = .available
        self.leapQuestBestScore = 0
        self.leapQuestAttempts = 0
        self.leapQuestCompletionDate = nil
    }
    
    var leapQuestIsUnlocked: Bool {
        return leapQuestState != .locked
    }
    
    var leapQuestIsCompleted: Bool {
        return leapQuestState == .completed || leapQuestState == .perfect
    }
    
    mutating func leapQuestComplete(with score: Int) {
        leapQuestAttempts += 1
        if score > leapQuestBestScore {
            leapQuestBestScore = score
        }
        
        if score >= leapQuestType.leapQuestRewardCoins {
            leapQuestState = .perfect
        } else if score > 0 {
            leapQuestState = .completed
        }
        
        leapQuestCompletionDate = Date()
    }
}

// MARK: - Tic Tac Toe Game State
struct LeapQuestTicTacToeState: Codable {
    var leapQuestBoard: [String] // "X", "O", or ""
    var leapQuestCurrentPlayer: String // "X" or "O"
    var leapQuestGameStatus: LeapQuestTicTacToeStatus
    var leapQuestPlayerScore: Int
    var leapQuestComputerScore: Int
    
    init() {
        leapQuestBoard = Array(repeating: "", count: 9)
        leapQuestCurrentPlayer = "X"
        leapQuestGameStatus = .playing
        leapQuestPlayerScore = 0
        leapQuestComputerScore = 0
    }
}

enum LeapQuestTicTacToeStatus: String, Codable {
    case playing = "Playing"
    case playerWon = "Player Won"
    case computerWon = "Computer Won"
    case draw = "Draw"
}

// MARK: - Memory Sequence Game State
struct LeapQuestMemorySequenceState: Codable {
    var leapQuestSequence: [Int]
    var leapQuestPlayerSequence: [Int]
    var leapQuestCurrentLevel: Int
    var leapQuestMaxLevel: Int
    var leapQuestGameStatus: LeapQuestMemorySequenceStatus
    var leapQuestShowSequence: Bool
    var leapQuestSequenceIndex: Int
    
    init() {
        leapQuestSequence = []
        leapQuestPlayerSequence = []
        leapQuestCurrentLevel = 1
        leapQuestMaxLevel = 1
        leapQuestGameStatus = .waiting
        leapQuestShowSequence = false
        leapQuestSequenceIndex = 0
    }
}

enum LeapQuestMemorySequenceStatus: String, Codable {
    case waiting = "Waiting"
    case showing = "Showing"
    case playing = "Playing"
    case correct = "Correct"
    case wrong = "Wrong"
    case completed = "Completed"
}
