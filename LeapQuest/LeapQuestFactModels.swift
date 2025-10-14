import Foundation
import UIKit

// MARK: - Fact Category
enum LeapQuestFactCategory: String, Codable, CaseIterable {
    case nature = "Nature"
    case science = "Science"
    case history = "History"
    case technology = "Technology"
    case space = "Space"
    
    var leapQuestEmoji: String {
        switch self {
        case .nature: return "🌿"
        case .science: return "🔬"
        case .history: return "📜"
        case .technology: return "💻"
        case .space: return "🚀"
        }
    }
    
    var leapQuestColor: UIColor {
        switch self {
        case .nature: return UIColor.systemGreen
        case .science: return UIColor.systemBlue
        case .history: return UIColor.systemOrange
        case .technology: return UIColor.systemPurple
        case .space: return UIColor.systemIndigo
        }
    }
}

// MARK: - Fact
struct LeapQuestFact: Codable, Identifiable {
    let id = UUID()
    let leapQuestCategory: LeapQuestFactCategory
    let leapQuestTitle: String
    let leapQuestShortDescription: String
    let leapQuestFullContent: String
    let leapQuestImageEmoji: String
    let leapQuestDifficulty: LeapQuestPuzzleDifficulty
    let leapQuestReadTime: Int // in minutes
    
    var leapQuestIsRead: Bool {
        get {
            return LeapQuestStorageManager.shared.leapQuestGetReadFacts().contains(id.uuidString)
        }
        set {
            if newValue {
                LeapQuestStorageManager.shared.leapQuestMarkFactAsRead(id.uuidString)
            } else {
                LeapQuestStorageManager.shared.leapQuestMarkFactAsUnread(id.uuidString)
            }
        }
    }
}

// MARK: - Fact Data
struct LeapQuestFactData {
    static let leapQuestFacts: [LeapQuestFact] = [
        // Nature Facts
        LeapQuestFact(
            leapQuestCategory: .nature,
            leapQuestTitle: "The Amazing Jumping Frog",
            leapQuestShortDescription: "Frogs can jump up to 20 times their body length!",
            leapQuestFullContent: """
            Frogs are incredible jumpers! The average frog can jump up to 20 times its body length, which is equivalent to a human jumping over a basketball court in a single leap. This amazing ability comes from their powerful hind legs, which contain large muscles and long bones that act like springs.
            
            The secret to a frog's jumping power lies in its anatomy:
            • Their hind legs are much longer than their front legs
            • They have elastic tendons that store energy
            • Their leg muscles can contract rapidly to generate explosive force
            
            Different species of frogs have different jumping abilities. The longest recorded frog jump was by a South African sharp-nosed frog that leaped 5.35 meters (17.5 feet) in a single bound!
            
            Scientists study frog jumping to improve robotics and understand biomechanics. The principles behind frog jumping are being used to design more efficient robots and prosthetic limbs.
            """,
            leapQuestImageEmoji: "🐸",
            leapQuestDifficulty: .easy,
            leapQuestReadTime: 2
        ),
        
        LeapQuestFact(
            leapQuestCategory: .nature,
            leapQuestTitle: "The Mysterious River Ecosystem",
            leapQuestShortDescription: "Rivers are home to 40% of all fish species on Earth!",
            leapQuestFullContent: """
            Rivers are incredibly diverse ecosystems that support a vast array of life forms. Despite covering only 0.8% of Earth's surface, rivers are home to approximately 40% of all fish species on our planet!
            
            Rivers provide essential ecosystem services:
            • Fresh water for drinking and irrigation
            • Habitat for countless species
            • Transportation routes for goods and people
            • Recreation and tourism opportunities
            
            The Amazon River alone contains over 3,000 fish species, including the famous piranha and the massive arapaima. Rivers also support complex food webs, from microscopic algae to large predators like crocodiles and bears.
            
            Unfortunately, many rivers face threats from pollution, dam construction, and climate change. Protecting these vital waterways is crucial for maintaining biodiversity and ensuring clean water for future generations.
            """,
            leapQuestImageEmoji: "🌊",
            leapQuestDifficulty: .medium,
            leapQuestReadTime: 3
        ),
        
        // Science Facts
        LeapQuestFact(
            leapQuestCategory: .science,
            leapQuestTitle: "The Physics of Jumping",
            leapQuestShortDescription: "Jumping involves complex physics of energy transfer and momentum!",
            leapQuestFullContent: """
            Jumping is a fascinating demonstration of physics in action! When you jump, several physical principles work together to propel you into the air.
            
            The Science Behind Jumping:
            • **Kinetic Energy**: Your muscles convert chemical energy into mechanical energy
            • **Potential Energy**: As you rise, kinetic energy converts to gravitational potential energy
            • **Momentum Conservation**: Your body's momentum must be conserved during the jump
            • **Newton's Third Law**: The ground pushes back with equal force
            
            The optimal jumping angle is approximately 45 degrees for maximum horizontal distance. This is because it balances the vertical and horizontal components of velocity.
            
            Factors that affect jumping ability:
            • Muscle strength and power
            • Body weight and composition
            • Joint flexibility and range of motion
            • Technique and coordination
            
            Athletes use these principles to improve their performance, and engineers apply similar concepts in designing everything from sports equipment to space vehicles!
            """,
            leapQuestImageEmoji: "⚡",
            leapQuestDifficulty: .hard,
            leapQuestReadTime: 4
        ),
        
        LeapQuestFact(
            leapQuestCategory: .science,
            leapQuestTitle: "The Amazing Human Brain",
            leapQuestShortDescription: "Your brain processes information faster than any computer!",
            leapQuestFullContent: """
            The human brain is one of the most complex and powerful organs in the known universe! It contains approximately 86 billion neurons, each capable of forming thousands of connections with other neurons.
            
            Incredible Brain Facts:
            • **Processing Speed**: Your brain can process information in as little as 13 milliseconds
            • **Memory Capacity**: Estimated to store 2.5 petabytes of information (equivalent to 3 million hours of TV shows)
            • **Energy Usage**: Uses about 20% of your body's total energy despite being only 2% of your body weight
            • **Neural Connections**: Contains over 100 trillion synaptic connections
            
            The brain is divided into specialized regions:
            • **Frontal Lobe**: Decision making and problem solving
            • **Temporal Lobe**: Memory and language processing
            • **Parietal Lobe**: Sensory information processing
            • **Occipital Lobe**: Visual processing
            
            Neuroplasticity allows your brain to reorganize itself throughout your life, forming new connections and pathways. This is why learning new skills like playing games or solving puzzles can actually change your brain structure!
            """,
            leapQuestImageEmoji: "🧠",
            leapQuestDifficulty: .medium,
            leapQuestReadTime: 3
        ),
        
        // Technology Facts
        LeapQuestFact(
            leapQuestCategory: .technology,
            leapQuestTitle: "The Evolution of Mobile Games",
            leapQuestShortDescription: "Mobile games have revolutionized how we play and interact!",
            leapQuestFullContent: """
            Mobile gaming has transformed the entertainment industry and changed how billions of people around the world play games. From simple puzzle games to complex multiplayer experiences, mobile games have become a cultural phenomenon.
            
            The Mobile Gaming Revolution:
            • **Global Reach**: Over 3 billion people play mobile games worldwide
            • **Revenue Growth**: Mobile games generate over $100 billion annually
            • **Accessibility**: Available to anyone with a smartphone
            • **Innovation**: Touch controls, augmented reality, and location-based gaming
            
            Key Milestones in Mobile Gaming:
            • **1994**: First mobile game "Tetris" released for Hagenuk MT-2000
            • **2007**: iPhone launch revolutionized touch gaming
            • **2012**: "Candy Crush Saga" popularized freemium model
            • **2016**: "Pokémon GO" introduced augmented reality to mainstream gaming
            
            Modern mobile games feature:
            • Advanced graphics and physics engines
            • Social features and multiplayer capabilities
            • Cross-platform compatibility
            • Innovative monetization strategies
            
            The future of mobile gaming includes virtual reality, cloud gaming, and AI-powered personalized experiences that adapt to individual players!
            """,
            leapQuestImageEmoji: "📱",
            leapQuestDifficulty: .easy,
            leapQuestReadTime: 3
        ),
        
        LeapQuestFact(
            leapQuestCategory: .technology,
            leapQuestTitle: "Artificial Intelligence in Gaming",
            leapQuestShortDescription: "AI is revolutionizing game development and player experiences!",
            leapQuestFullContent: """
            Artificial Intelligence has become an integral part of modern gaming, creating more immersive, challenging, and personalized experiences for players worldwide.
            
            AI Applications in Gaming:
            • **Non-Player Characters (NPCs)**: AI creates realistic and intelligent opponents
            • **Procedural Generation**: AI generates endless unique content and levels
            • **Player Behavior Analysis**: AI learns from player actions to improve gameplay
            • **Dynamic Difficulty**: AI adjusts game difficulty based on player skill
            
            Advanced AI Techniques:
            • **Machine Learning**: Algorithms that improve through experience
            • **Neural Networks**: Simulated brain networks for complex decision-making
            • **Reinforcement Learning**: AI learns through trial and error
            • **Natural Language Processing**: AI understands and responds to player input
            
            Real-World Examples:
            • Chess engines that can defeat world champions
            • NPCs that adapt to player strategies
            • Procedural worlds with billions of unique combinations
            • Personalized recommendations and difficulty adjustments
            
            The future of AI in gaming includes:
            • Fully procedural storytelling
            • Real-time emotion recognition
            • Advanced physics simulation
            • Personalized game creation
            
            AI is not just making games more challenging—it's making them more human, more creative, and more engaging than ever before!
            """,
            leapQuestImageEmoji: "🤖",
            leapQuestDifficulty: .hard,
            leapQuestReadTime: 4
        ),
        
        // Space Facts
        LeapQuestFact(
            leapQuestCategory: .space,
            leapQuestTitle: "The Vastness of Space",
            leapQuestShortDescription: "Space is so large that it would take billions of years to explore!",
            leapQuestFullContent: """
            The universe is unimaginably vast, containing billions of galaxies, each with billions of stars. The scale of space is so enormous that it challenges our ability to comprehend it.
            
            Mind-Blowing Space Facts:
            • **Observable Universe**: 93 billion light-years in diameter
            • **Galaxies**: Estimated 2 trillion galaxies in the observable universe
            • **Stars**: More stars than grains of sand on all Earth's beaches
            • **Distance**: Light from the nearest star (Proxima Centauri) takes 4.24 years to reach us
            
            The Scale of Space:
            • **Solar System**: Takes light 8 hours to cross
            • **Milky Way Galaxy**: Takes light 100,000 years to cross
            • **Local Group**: Contains 54 galaxies including our Milky Way
            • **Virgo Supercluster**: Contains thousands of galaxies
            
            Amazing Space Phenomena:
            • **Black Holes**: Regions where gravity is so strong that not even light can escape
            • **Neutron Stars**: Dense stellar remnants that can spin 700 times per second
            • **Dark Matter**: Invisible matter that makes up 27% of the universe
            • **Dark Energy**: Mysterious force causing the universe to expand faster
            
            Space exploration has taught us about:
            • The formation of planets and stars
            • The possibility of life elsewhere
            • The origins of the universe
            • The fundamental laws of physics
            
            Every time we look at the stars, we're looking back in time, seeing light that has traveled for millions or billions of years to reach our eyes!
            """,
            leapQuestImageEmoji: "🌌",
            leapQuestDifficulty: .medium,
            leapQuestReadTime: 4
        ),
        
        LeapQuestFact(
            leapQuestCategory: .space,
            leapQuestTitle: "The Search for Extraterrestrial Life",
            leapQuestShortDescription: "Scientists are actively searching for signs of life beyond Earth!",
            leapQuestFullContent: """
            The search for extraterrestrial life is one of the most exciting and important scientific endeavors of our time. With advanced technology and new discoveries, we're closer than ever to finding evidence of life beyond Earth.
            
            The Search Strategies:
            • **SETI (Search for Extraterrestrial Intelligence)**: Listening for radio signals from alien civilizations
            • **Exoplanet Studies**: Analyzing planets outside our solar system for signs of life
            • **Mars Exploration**: Searching for past or present life on the Red Planet
            • **Europa and Enceladus**: Investigating moons with subsurface oceans
            
            Promising Locations for Life:
            • **Mars**: Evidence of ancient water and current subsurface ice
            • **Europa**: Jupiter's moon with a subsurface ocean
            • **Enceladus**: Saturn's moon with water geysers
            • **Exoplanets**: Planets in the "habitable zone" around other stars
            
            What We're Looking For:
            • **Biosignatures**: Chemical signs of biological activity
            • **Technosignatures**: Evidence of advanced civilizations
            • **Liquid Water**: Essential for life as we know it
            • **Organic Molecules**: Building blocks of life
            
            Recent Discoveries:
            • Over 5,000 confirmed exoplanets
            • Water vapor detected on potentially habitable worlds
            • Organic molecules found in meteorites and comets
            • Extremophiles on Earth showing life can survive harsh conditions
            
            The Drake Equation estimates there could be thousands of communicating civilizations in our galaxy alone. With new telescopes and space missions, we may discover the answer to "Are we alone?" within our lifetime!
            """,
            leapQuestImageEmoji: "👽",
            leapQuestDifficulty: .hard,
            leapQuestReadTime: 4
        ),
        
        // History Facts
        LeapQuestFact(
            leapQuestCategory: .history,
            leapQuestTitle: "The Ancient Art of Navigation",
            leapQuestShortDescription: "Ancient civilizations navigated using stars, currents, and natural signs!",
            leapQuestFullContent: """
            Long before GPS and modern technology, ancient civilizations developed sophisticated methods to navigate across vast oceans and unknown territories. Their knowledge of astronomy, ocean currents, and natural phenomena was remarkable.
            
            Ancient Navigation Methods:
            • **Celestial Navigation**: Using stars, sun, and moon positions
            • **Dead Reckoning**: Calculating position based on speed and direction
            • **Natural Signs**: Reading clouds, birds, and ocean patterns
            • **Oral Traditions**: Passing navigation knowledge through generations
            
            Famous Ancient Navigators:
            • **Polynesian Voyagers**: Crossed the Pacific using star charts and wave patterns
            • **Viking Explorers**: Used sunstones and celestial navigation to reach North America
            • **Phoenician Traders**: Navigated Mediterranean and Atlantic using star constellations
            • **Chinese Sailors**: Used compass and astronomical observations for ocean voyages
            
            Navigation Tools:
            • **Astrolabe**: Ancient device for measuring star and sun angles
            • **Cross-staff**: For measuring angles between celestial objects
            • **Magnetic Compass**: First used by Chinese navigators
            • **Kamal**: Arabic navigation tool using star elevation angles
            
            The Polynesian Navigation System:
            • Memorized star paths for different seasons
            • Used wave patterns to detect land
            • Followed bird migration routes
            • Created detailed mental maps of the Pacific
            
            These ancient techniques were so effective that Polynesian navigators could find tiny islands in the vast Pacific Ocean without modern instruments. Their knowledge represents one of humanity's greatest intellectual achievements!
            """,
            leapQuestImageEmoji: "🧭",
            leapQuestDifficulty: .medium,
            leapQuestReadTime: 3
        ),
        
        LeapQuestFact(
            leapQuestCategory: .history,
            leapQuestTitle: "The Digital Revolution",
            leapQuestShortDescription: "The internet has connected the world in ways never imagined!",
            leapQuestFullContent: """
            The digital revolution has fundamentally transformed human society, creating connections and possibilities that were unimaginable just a few decades ago. From the first computer networks to today's global internet, this revolution continues to shape our world.
            
            Key Milestones in Digital History:
            • **1969**: ARPANET, the precursor to the internet, goes online
            • **1971**: First email sent between computers
            • **1989**: Tim Berners-Lee invents the World Wide Web
            • **1995**: Amazon and eBay launch, beginning e-commerce
            • **2004**: Facebook launches, starting social media era
            • **2007**: iPhone introduces mobile internet revolution
            
            The Impact of Digital Technology:
            • **Global Communication**: Instant connection with anyone worldwide
            • **Information Access**: Vast amounts of knowledge available instantly
            • **Economic Transformation**: New industries and business models
            • **Social Change**: New ways of forming communities and relationships
            
            Digital Revolution Statistics:
            • Over 5 billion people use the internet worldwide
            • 60% of global population has internet access
            • 4.8 billion people use social media
            • 90% of world's data was created in the last two years
            
            Emerging Technologies:
            • **Artificial Intelligence**: Machine learning and automation
            • **Virtual Reality**: Immersive digital experiences
            • **Blockchain**: Decentralized digital systems
            • **Internet of Things**: Connected everyday objects
            
            The digital revolution has democratized access to information, created new forms of entertainment and education, and enabled unprecedented global collaboration. As we continue this journey, the possibilities for human advancement seem limitless!
            """,
            leapQuestImageEmoji: "💻",
            leapQuestDifficulty: .easy,
            leapQuestReadTime: 3
        )
    ]
}
