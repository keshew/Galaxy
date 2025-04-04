import SwiftUI
import SpriteKit

class GameData: ObservableObject {
    @Published var isPause = false
    @Published var isMenu = false
    @Published var isWin = false
    @Published var isLose = false
    @Published var isRules = false
    @Published var score = 0
    @Published var scene = SKScene()
    var startTime: TimeInterval?
    
    func startGame() {
        startTime = Date().timeIntervalSince1970
    }
}

class GameSpriteKit: SKScene, SKPhysicsContactDelegate {
    var game: GameData?
    var desc: SKSpriteNode!
    var mainBall: SKSpriteNode!
    var arrow: SKSpriteNode!
    var isTouching = false
    var touchPoint: CGPoint?
    var isBallsMoving = false
    var balls: [SKSpriteNode] = []
    var scoreCountLabel: SKLabelNode!
    var level: Int
    
    init(level: Int) {
        self.level = level
        super.init(size: UIScreen.main.bounds.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        createMainNode()
        createTable()
        createMutationNode()
        createProgressBar()
        createTappedNode()
        game?.startGame()
    }
    
    func createTappedNode() {
        let pause = SKSpriteNode(imageNamed: GalaxyImageName.pause.rawValue)
        pause.size = CGSize(width: 87, height: 100)
        pause.name = "pause"
        
        if size.width > 850 {
            pause.position = CGPoint(x: size.width / 15.15, y: size.height / 1.07)
        } else if size.width > 650 {
            pause.position = CGPoint(x: size.width / 15.15, y: size.height / 1.07)
          } else if size.width > 400 {
              pause.position = CGPoint(x: size.width / 8.15, y: size.height / 1.13)
          } else if size.width < 380 {
              pause.position = CGPoint(x: size.width / 8.15, y: size.height / 1.09)
          } else {
              pause.position = CGPoint(x: size.width / 8.15, y: size.height / 1.13)
          }
        addChild(pause)
    }
    
    func createProgressBar() {
        let parentNode = SKNode()
        if size.width > 850 {
            parentNode.position = CGPoint(x: size.width / 1.16, y: size.height / 1.25)
        } else if size.width > 650 {
            parentNode.position = CGPoint(x: size.width / 1.16, y: size.height / 1.25)
          } else if size.width > 400 {
              parentNode.position = CGPoint(x: size.width / 1.43, y: size.height / 1.32)
          } else if size.width < 380 {
              parentNode.position = CGPoint(x: size.width / 1.43, y: size.height / 1.32)
          } else {
              parentNode.position = CGPoint(x: size.width / 1.43, y: size.height / 1.32)
          }

        
        let time = SKSpriteNode(imageNamed: GalaxyImageName.time.rawValue)
        time.size = CGSize(width: 49, height: 49)
        time.position = CGPoint(x: -30, y: 0)
        parentNode.addChild(time)
        
        let levelLabel = SKLabelNode(fontNamed: "JosefinSans-Thin_Regular")
        levelLabel.attributedText = NSAttributedString(string: "Time:", attributes: [
            NSAttributedString.Key.font: UIFont(name: "JosefinSans-Thin_Regular", size: 30)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 151/255, green: 26/255, blue: 192/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -2.5
        ])
        levelLabel.position = CGPoint(x: 25, y: -13)
        parentNode.addChild(levelLabel)
        
        let progressBarBackground = SKShapeNode(rectOf: CGSize(width: 174, height: 18), cornerRadius: 10)
        progressBarBackground.fillColor = .white
        progressBarBackground.strokeColor = UIColor(red: 151/255, green: 26/255, blue: 192/255, alpha: 1)
        progressBarBackground.lineWidth = 2
        progressBarBackground.position = CGPoint(x: 15, y: -30)
        parentNode.addChild(progressBarBackground)
        
        let progressBar = SKShapeNode(rectOf: CGSize(width: 0, height: 16), cornerRadius: 10)
        progressBar.strokeColor = .clear
        progressBar.fillColor = UIColor(red: 151/255, green: 26/255, blue: 192/255, alpha: 1)
        progressBar.position = CGPoint(x: 0, y: 0)
        parentNode.addChild(progressBar)
        
        let duration: TimeInterval = 180
        let finalWidth: CGFloat = 174
        
        let resizeAction = SKAction.customAction(withDuration: duration) { node, elapsedTime in
            let progress = elapsedTime / duration
            let newWidth = finalWidth * progress
            progressBar.path = UIBezierPath(roundedRect: CGRect(x: -71.5, y: -39, width: newWidth, height: 18), cornerRadius: 10).cgPath
        }
        
        let completionAction = SKAction.run {
            self.game?.isLose = true
        }
        let sequenceAction = SKAction.sequence([resizeAction, completionAction])
        progressBar.run(sequenceAction)
        
        addChild(parentNode)
    }
    
    func createMutationNode() {
        let lifesNode = SKNode()
        if size.width > 850 {
            lifesNode.position = CGPoint(x: size.width / 1.1, y: size.height / 1.07)
        } else if size.width > 650 {
            lifesNode.position = CGPoint(x: size.width / 1.1, y: size.height / 1.07)
          } else if size.width > 400 {
              lifesNode.position = CGPoint(x: size.width / 1.25, y: size.height / 1.12)
          } else if size.width < 380 {
              lifesNode.position = CGPoint(x: size.width / 1.25, y: size.height / 1.07)
          } else {
              lifesNode.position = CGPoint(x: size.width / 1.25, y: size.height / 1.12)
          }
       
        
        let lifesBack = SKSpriteNode(imageNamed: GalaxyImageName.gameBack.rawValue)
        lifesBack.size = CGSize(width: 125, height: 60)
        lifesBack.position = CGPoint(x: 0, y: 0)
        
        let heart = SKSpriteNode(imageNamed: GalaxyImageName.lifes.rawValue)
        heart.size = CGSize(width: 77, height: 77)
        heart.position = CGPoint(x: -45, y: 0)
        
        let levelLabel = SKLabelNode(fontNamed: "JosefinSans-Thin_Regular")
        levelLabel.attributedText = NSAttributedString(string: "Lifes:", attributes: [
            NSAttributedString.Key.font: UIFont(name: "JosefinSans-Thin_Regular", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 151/255, green: 26/255, blue: 192/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -2.5
        ])
        levelLabel.position = CGPoint(x: 10, y: -3)
        
        let levelCountLabel = SKLabelNode(fontNamed: "JosefinSans-Thin_Regular")
        levelCountLabel.attributedText = NSAttributedString(string: "\(UserDefaultsManager.defaults.integer(forKey: Keys.life.rawValue))", attributes: [
            NSAttributedString.Key.font: UIFont(name: "JosefinSans-Thin_Regular", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 151/255, green: 26/255, blue: 192/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -2.5
        ])
        levelCountLabel.position = CGPoint(x: 10, y: -23)
        
        lifesNode.addChild(lifesBack)
        lifesNode.addChild(heart)
        lifesNode.addChild(levelLabel)
        lifesNode.addChild(levelCountLabel)
        
        addChild(lifesNode)
        
        let coinsNode = SKNode()
        
        if size.width > 850 {
            coinsNode.position = CGPoint(x: size.width / 1.1, y: size.height / 1.14)
        } else if size.width > 650 {
            coinsNode.position = CGPoint(x: size.width / 1.1, y: size.height / 1.14)
          } else if size.width > 400 {
              coinsNode.position = CGPoint(x: size.width / 1.25, y: size.height / 1.22)
          } else if size.width < 380 {
              coinsNode.position = CGPoint(x: size.width / 1.25, y: size.height / 1.2)
          } else {
              coinsNode.position = CGPoint(x: size.width / 1.25, y: size.height / 1.22)
          }
     
        
        let coinBack = SKSpriteNode(imageNamed: GalaxyImageName.gameBack.rawValue)
        coinBack.size = CGSize(width: 125, height: 60)
        coinBack.position = CGPoint(x: 0, y: 0)
        
        let coin = SKSpriteNode(imageNamed: GalaxyImageName.coin.rawValue)
        coin.size = CGSize(width: 71, height: 71)
        coin.position = CGPoint(x: -45, y: 0)
        
        let coinLabel = SKLabelNode(fontNamed: "JosefinSans-Thin_Regular")
        coinLabel.attributedText = NSAttributedString(string: "Coins:", attributes: [
            NSAttributedString.Key.font: UIFont(name: "JosefinSans-Thin_Regular", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 151/255, green: 26/255, blue: 192/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -2.5
        ])
        coinLabel.position = CGPoint(x: 14, y: -3)
        
        let coinCountLabel = SKLabelNode(fontNamed: "JosefinSans-Thin_Regular")
        coinCountLabel.attributedText = NSAttributedString(string: "\(UserDefaultsManager.defaults.integer(forKey: Keys.coin.rawValue))", attributes: [
            NSAttributedString.Key.font: UIFont(name: "JosefinSans-Thin_Regular", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 151/255, green: 26/255, blue: 192/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -2.5
        ])
        coinCountLabel.position = CGPoint(x: 14, y: -23)
        
        coinsNode.addChild(coinBack)
        coinsNode.addChild(coin)
        coinsNode.addChild(coinLabel)
        coinsNode.addChild(coinCountLabel)
        
        addChild(coinsNode)
        
        let scoreNode = SKNode()
        if size.width > 850 {
            scoreNode.position = CGPoint(x: size.width / 4.25, y: size.height / 1.26)
        } else if size.width > 650 {
            scoreNode.position = CGPoint(x: size.width / 4.25, y: size.height / 1.26)
          } else if size.width > 400 {
              scoreNode.position = CGPoint(x: size.width / 4.25, y: size.height / 1.32)
          } else if size.width < 380 {
              scoreNode.position = CGPoint(x: size.width / 4.26, y: size.height / 1.33)
          } else {
              scoreNode.position = CGPoint(x: size.width / 4.25, y: size.height / 1.32)
          }
        
        let scoreBack = SKSpriteNode(imageNamed: GalaxyImageName.gameBack.rawValue)
        scoreBack.size = CGSize(width: 159, height: 77)
        scoreBack.position = CGPoint(x: 0, y: 0)
        
        let score = SKSpriteNode(imageNamed: GalaxyImageName.records.rawValue)
        score.size = CGSize(width: 96, height: 96)
        score.position = CGPoint(x: -45, y: 0)
        
        let scoreLabel = SKLabelNode(fontNamed: "JosefinSans-Thin_Regular")
        scoreLabel.attributedText = NSAttributedString(string: "Score:", attributes: [
            NSAttributedString.Key.font: UIFont(name: "JosefinSans-Thin_Regular", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 151/255, green: 26/255, blue: 192/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -2.5
        ])
        scoreLabel.position = CGPoint(x: 20, y: -3)
        
        scoreCountLabel = SKLabelNode(fontNamed: "JosefinSans-Thin_Regular")
        scoreCountLabel.attributedText = NSAttributedString(string: "\(game?.score ?? 0)", attributes: [
            NSAttributedString.Key.font: UIFont(name: "JosefinSans-Thin_Regular", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 151/255, green: 26/255, blue: 192/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -2.5
        ])
        scoreCountLabel.position = CGPoint(x: 20, y: -23)
        
        scoreNode.addChild(scoreBack)
        scoreNode.addChild(score)
        scoreNode.addChild(scoreLabel)
        scoreNode.addChild(scoreCountLabel)
        
        addChild(scoreNode)
    }
    
    func createTable() {
        desc = SKSpriteNode(imageNamed: UserDefaultsManager().getSelectedDesk() ?? GalaxyImageName.desc.rawValue)
        if size.width > 850 {
            desc.size = CGSize(width: size.width * 0.8, height: size.height * 0.62)
        } else if size.width > 650 {
            desc.size = CGSize(width: size.width * 0.8, height: size.height * 0.6)
          } else if size.width > 400 {
              desc.size = CGSize(width: size.width * 0.9, height: size.height * 0.59)
          } else if size.width < 380 {
              desc.size = CGSize(width: size.width * 0.8, height: size.height * 0.5)
          } else {
              desc.size = CGSize(width: size.width * 0.8, height: size.height * 0.5)
          }
        desc.position = CGPoint(x: size.width / 2, y: size.height / 2.5)
        addChild(desc)
        
        let wallThickness: CGFloat = 10
        
        let topWall = SKSpriteNode(color: .clear, size: CGSize(width: desc.size.width, height: wallThickness))
        topWall.position = CGPoint(x: desc.position.x, y: desc.position.y + (desc.frame.height / 2) - (wallThickness / 2))
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.friction = 0.0
        topWall.physicsBody?.restitution = 1.0
        addChild(topWall)
        
        let bottomWall = SKSpriteNode(color: .clear, size: CGSize(width: desc.size.width, height: wallThickness))
        bottomWall.position = CGPoint(x: desc.position.x, y: desc.position.y - (desc.frame.height / 2) + (wallThickness / 2))
        bottomWall.physicsBody = SKPhysicsBody(rectangleOf: bottomWall.size)
        bottomWall.physicsBody?.isDynamic = false
        bottomWall.physicsBody?.friction = 0.0
        bottomWall.physicsBody?.restitution = 1.0
        addChild(bottomWall)
        
        let leftWall = SKSpriteNode(color: .clear, size: CGSize(width: wallThickness, height: desc.size.height))
        leftWall.position = CGPoint(x: desc.position.x - (desc.frame.width / 2) + (wallThickness / 2), y: desc.position.y)
        leftWall.physicsBody = SKPhysicsBody(rectangleOf: leftWall.size)
        leftWall.physicsBody?.isDynamic = false
        leftWall.physicsBody?.friction = 0.0
        leftWall.physicsBody?.restitution = 1.0
        addChild(leftWall)
        
        let rightWall = SKSpriteNode(color: .clear, size: CGSize(width: wallThickness, height: desc.size.height))
        rightWall.position = CGPoint(x: desc.position.x + (desc.frame.width / 2) - (wallThickness / 2), y: desc.position.y)
        rightWall.physicsBody = SKPhysicsBody(rectangleOf: rightWall.size)
        rightWall.physicsBody?.isDynamic = false
        rightWall.physicsBody?.friction = 0.0
        rightWall.physicsBody?.restitution = 1.0
        addChild(rightWall)
        
        let holeSize: CGFloat = 66
        let topLeftHole = SKSpriteNode(imageNamed: GalaxyImageName.hole.rawValue)
        topLeftHole.size = CGSize(width: holeSize, height: holeSize)
        topLeftHole.position = CGPoint(x: desc.position.x - (desc.frame.width / 2) + (holeSize / 3), y: desc.position.y + (desc.frame.height / 2) - (holeSize / 3))
        topLeftHole.physicsBody = SKPhysicsBody(circleOfRadius: holeSize / 4)
        topLeftHole.physicsBody?.isDynamic = false
        topLeftHole.physicsBody?.contactTestBitMask = 2
        topLeftHole.physicsBody?.categoryBitMask = 4
        addChild(topLeftHole)
        
        let topRightHole = SKSpriteNode(imageNamed: GalaxyImageName.hole.rawValue)
        topRightHole.size = CGSize(width: holeSize, height: holeSize)
        topRightHole.position = CGPoint(x: desc.position.x + (desc.frame.width / 2) - (holeSize / 3), y: desc.position.y + (desc.frame.height / 2) - (holeSize / 3))
        topRightHole.physicsBody = SKPhysicsBody(circleOfRadius: holeSize / 4)
        topRightHole.physicsBody?.isDynamic = false
        topRightHole.physicsBody?.contactTestBitMask = 2
        topRightHole.physicsBody?.categoryBitMask = 4
        addChild(topRightHole)
        
        let bottomLeftHole = SKSpriteNode(imageNamed: GalaxyImageName.hole.rawValue)
        bottomLeftHole.size = CGSize(width: holeSize, height: holeSize)
        bottomLeftHole.position = CGPoint(x: desc.position.x - (desc.frame.width / 2) + (holeSize / 3), y: desc.position.y - (desc.frame.height / 2) + (holeSize / 3))
        bottomLeftHole.physicsBody = SKPhysicsBody(circleOfRadius: holeSize / 4)
        bottomLeftHole.physicsBody?.isDynamic = false
        bottomLeftHole.physicsBody?.contactTestBitMask = 2
        bottomLeftHole.physicsBody?.categoryBitMask = 4
        addChild(bottomLeftHole)
        
        let bottomRightHole = SKSpriteNode(imageNamed: GalaxyImageName.hole.rawValue)
        bottomRightHole.size = CGSize(width: holeSize, height: holeSize)
        bottomRightHole.position = CGPoint(x: desc.position.x + (desc.frame.width / 2) - (holeSize / 3), y: desc.position.y - (desc.frame.height / 2) + (holeSize / 3))
        bottomRightHole.physicsBody = SKPhysicsBody(circleOfRadius: holeSize / 4)
        bottomRightHole.physicsBody?.isDynamic = false
        bottomRightHole.physicsBody?.contactTestBitMask = 2
        bottomRightHole.physicsBody?.categoryBitMask = 4
        addChild(bottomRightHole)
        
        mainBall = SKSpriteNode(imageNamed: UserDefaultsManager().getSelectedBall() ?? GalaxyImageName.mainBall.rawValue)
        mainBall.size = CGSize(width: 40, height: 40)
        
        mainBall.position = CGPoint(x: size.width / 2, y: size.height / 2)
        mainBall.physicsBody = SKPhysicsBody(circleOfRadius: mainBall.size.width / 2)
        mainBall.physicsBody?.friction = 0.0
        mainBall.physicsBody?.affectedByGravity = false
        mainBall.physicsBody?.restitution = 1.0
        mainBall.physicsBody?.linearDamping = 1
        mainBall.physicsBody?.contactTestBitMask = 4
        mainBall.physicsBody?.categoryBitMask = 1
        addChild(mainBall)
        
        let ballSize: CGFloat = 40
        let ballSpacing: CGFloat = 30
        
        if level == 1 {
            let rows = 5
            for row in 0..<rows {
                for column in 0..<row + 1 {
                    createBallAt(
                        x: desc.position.x + (CGFloat(column) - CGFloat(row)/2) * ballSpacing,
                        y: desc.position.y - CGFloat(row) * ballSpacing + (desc.frame.height/5 - 150)
                    )
                }
            }
        } else {
            let boardWidth = desc.size.width - ballSize * 2
            let boardHeight = desc.size.height - ballSize * 2
            
            for _ in 0..<15 {
                let randomX = CGFloat.random(
                    in: (desc.position.x - boardWidth/2)...(desc.position.x + boardWidth/2)
                )
                let randomY = CGFloat.random(
                    in: (desc.position.y - boardHeight/2)...(desc.position.y + boardHeight/2)
                )
                createBallAt(x: randomX, y: randomY)
            }
        }
    }
    
    func createBallAt(x: CGFloat, y: CGFloat) {
        let ball = SKSpriteNode(imageNamed: GalaxyImageName.balls.rawValue)
        ball.size = CGSize(width: 40, height: 40)
        ball.position = CGPoint(x: x, y: y)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 40/2)
        ball.physicsBody?.friction = 0.0
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.restitution = 1.0
        ball.physicsBody?.contactTestBitMask = 4
        ball.physicsBody?.linearDamping = 1
        ball.physicsBody?.categoryBitMask = 2
        balls.append(ball)
        addChild(ball)
    }
    
    func createMainNode() {
        let gameBackground = SKSpriteNode(imageNamed: GalaxyImageName.recordsBack1.rawValue)
        gameBackground.size = CGSize(width: size.width, height: size.height)
        gameBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(gameBackground)
        
        let levelLabel = SKLabelNode(fontNamed: "JosefinSans-Thin_Regular")
        levelLabel.attributedText = NSAttributedString(string: "Level \(level)", attributes: [
            NSAttributedString.Key.font: UIFont(name: "LorenzoSans-Regular", size: 44)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 151/255, green: 26/255, blue: 192/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -3.5
        ])
        levelLabel.position = CGPoint(x: size.width / 2 , y: size.height / 30)
        addChild(levelLabel)
    }
    
    func createArrow() {
        arrow = SKSpriteNode(imageNamed: GalaxyImageName.arrow.rawValue)
        arrow.size = CGSize(width: 30, height: 61)
        arrow.position = CGPoint(x: mainBall.position.x, y: mainBall.position.y - 42)
        arrow.zPosition = 1
        addChild(arrow)
    }
    
    func updateArrowRotation() {
        guard let touchPoint = touchPoint, let arrow = arrow else { return }
        let angle = atan2(touchPoint.y - mainBall.position.y, touchPoint.x - mainBall.position.x)
        arrow.zRotation = angle - CGFloat.pi / 2
    }
    
    func applyImpulse(to ball: SKSpriteNode, to touchPoint: CGPoint) {
        let dx = touchPoint.x - ball.position.x
        let dy = touchPoint.y - ball.position.y
        let impulse = CGVector(dx: -dx * 1, dy: -dy * 1)
        ball.physicsBody?.applyImpulse(impulse)
    }
    
    func pauseTapped(touchLocation: CGPoint) {
        if let tappedNode = self.atPoint(touchLocation) as? SKSpriteNode,
           tappedNode.name == "pause" {
            game!.isPause = true
            game!.scene = scene!
            scene?.isPaused = true
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        isBallsMoving = balls.contains { $0.physicsBody?.velocity != .zero } || mainBall.physicsBody?.velocity != .zero
        if isBallsMoving {
            arrow?.isHidden = true
        } else {
            arrow?.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        pauseTapped(touchLocation: touchLocation)
        if !isBallsMoving, let tappedNode = self.atPoint(touchLocation) as? SKSpriteNode, tappedNode.name != "pause" {
            isTouching = true
            touchPoint = touchLocation
            createArrow()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isTouching, let touch = touches.first, let _ = arrow else { return }
        let touchLocation = touch.location(in: self)
        touchPoint = touchLocation
        
        if !isBallsMoving {
            updateArrowRotation()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isTouching, let touchPoint = touchPoint, let arrow = arrow else { return }
        isTouching = false
        self.touchPoint = nil
        
        if !isBallsMoving {
            applyImpulse(to: mainBall, to: touchPoint)
            arrow.removeFromParent()
            self.arrow = nil
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
        case 1 | 4:
            if balls.count > 0 {
                scene?.isPaused = true
                game?.isLose = true
            } else {
                scene?.isPaused = true
                game?.isWin = true
            }
            
        case 2 | 4:
            let ballNode = contact.bodyA.categoryBitMask == 2 ? contact.bodyA.node : contact.bodyB.node
            let ball = ballNode as? SKSpriteNode
            let holeNode = contact.bodyA.categoryBitMask == 4 ? contact.bodyA.node : contact.bodyB.node
            let holePosition = holeNode?.position ?? .zero
            ball?.removeFromParent()
            
            let ballsss = SKSpriteNode(imageNamed: GalaxyImageName.balls.rawValue)
            ballsss.size = CGSize(width: 40, height: 40)
            withAnimation {
                ballsss.position = holePosition
            }
            addChild(ballsss)
            ball?.zPosition = 1
            
            let waitAction = SKAction.wait(forDuration: 0.5)
            let removeAction = SKAction.run {
                ballsss.removeFromParent()
                self.balls.removeLast()
            }
            
            ballsss.run(SKAction.sequence([waitAction, removeAction]))
            
            let baseScore: Int = 100
                 let bonusTime: TimeInterval = 10
                 let currentTime: TimeInterval = Date().timeIntervalSince1970
                 let startTime: TimeInterval = game?.startTime ?? 0
                 let timeElapsed: TimeInterval = currentTime - startTime
                 
                 var bonus: Int = 0
                 if timeElapsed < bonusTime {
                     bonus = Int((bonusTime - timeElapsed) / bonusTime * 200)
                     bonus = bonus - (bonus % 50)
                 } else {
                     bonus = 0
                 }
                 
                 game?.score += baseScore + bonus
                 scoreCountLabel.attributedText = NSAttributedString(string: "\(game?.score ?? 0)", attributes: [
                     NSAttributedString.Key.font: UIFont(name: "JosefinSans-Thin_Regular", size: 20)!,
                     NSAttributedString.Key.foregroundColor: UIColor.white,
                     NSAttributedString.Key.strokeColor: UIColor(red: 151/255, green: 26/255, blue: 192/255, alpha: 1),
                     NSAttributedString.Key.strokeWidth: -2.5
                 ])
        default:
            break
        }
    }
}


struct GalaxyGameView: View {
    @StateObject var galaxyGameModel =  GalaxyGameViewModel()
    @StateObject var gameModel = GameData()
    var level: Int
    var body: some View {
        ZStack {
            SpriteView(scene: galaxyGameModel.createGameScene(gameData: gameModel,
                                                              level: level))
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .onDisappear {
                gameModel.scene.removeAllActions()
                gameModel.scene.removeAllChildren()
            }
            
            if gameModel.isPause {
                GalaxyPauseView(game: gameModel, scene: gameModel.scene)
            }
            
            if gameModel.isWin {
                GalaxyWinView(level: level)
                    .onAppear() {
                        UserDefaultsManager().saveScore(level: level, score: gameModel.score)
                        if level >= UserDefaultsManager.defaults.integer(forKey: Keys.currentLevel.rawValue) {
                            UserDefaultsManager().increaseLevel()
                        }
                    }
            }
            
            if gameModel.isLose {
                GalaxyLoseView(level: level)
                    .onAppear() {
                        UserDefaultsManager().loseLevel()
                    }
            }
        }
    }
    
}

#Preview {
    GalaxyGameView(level: 12)
}

