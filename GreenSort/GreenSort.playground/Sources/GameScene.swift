import Foundation
import PlaygroundSupport
import SpriteKit


public class GameScene: SKScene {
    
    var points: Int = 0
    var pointsLabel = SKLabelNode(text: "Eco-Points: 0")
    
    var heaps: Int = 1
    var heapsLabel = SKLabelNode(text: "Heap #: 1")
    
    var trashAmt: Int = 0
    var recycleAmt: Int = 0
    var compostAmt: Int = 0
    
    var timerValue: Int = 60
    var timerLabel = SKLabelNode(text: "")
    
    var numberOfLives: Int = 3
    var livesSprites: [SKSpriteNode] = []
    
    let trashBin = SKSpriteNode(imageNamed: "trashbin")
    let recycleBin = SKSpriteNode(imageNamed: "recyclebin")
    let compostBin = SKSpriteNode(imageNamed: "compostbin")

    let trashLabel = SKLabelNode(text: "Landfill: 0")
    let recycleLabel = SKLabelNode(text: "Recycle: 0")
    let compostLabel = SKLabelNode(text: "Compost: 0")
    
    var sortObjects: [SKSpriteNode] = []
    
    var selectedNode: SKNode?
    
    var homeButton = SKSpriteNode(imageNamed: "home")
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    //adding the different trash bins
    func addBins() {
        
        trashBin.position = CGPoint(x: -size.width/2 + trashBin.size.width, y: -size.height/2 + trashBin.size.height / 2)
        recycleBin.position = CGPoint(x: 0, y: -size.height/2 + recycleBin.size.height / 2)
        compostBin.position = CGPoint(x: size.width/2 - compostBin.size.width, y: -size.height/2 + compostBin.size.height / 2)
        
        trashBin.physicsBody = SKPhysicsBody(rectangleOf: trashBin.size) // 1
        trashBin.physicsBody?.categoryBitMask = PhysicsCategory.trashBox // 3
        trashBin.physicsBody?.collisionBitMask = PhysicsCategory.box
        recycleBin.physicsBody = SKPhysicsBody(rectangleOf: recycleBin.size) // 1
        recycleBin.physicsBody?.categoryBitMask = PhysicsCategory.recycleBox // 3
        recycleBin.physicsBody?.collisionBitMask = PhysicsCategory.box
        compostBin.physicsBody = SKPhysicsBody(rectangleOf: compostBin.size) // 1
        compostBin.physicsBody?.categoryBitMask = PhysicsCategory.compostBox // 3
        compostBin.physicsBody?.collisionBitMask = PhysicsCategory.box
        
        addChild(trashBin)
        addChild(recycleBin)
        addChild(compostBin)
        
        trashLabel.position = CGPoint(x: -size.width/2 + trashBin.size.width, y: -size.height/2 + trashBin.size.height / 2)
        recycleLabel.position = CGPoint(x: 0, y: -size.height/2 + recycleBin.size.height / 2)
        compostLabel.position = CGPoint(x: size.width/2 - compostBin.size.width, y: -size.height/2 + compostBin.size.height / 2)
        trashLabel.fontName = "HelveticaNeue-Light"
        recycleLabel.fontName = "HelveticaNeue-Light"
        compostLabel.fontName = "HelveticaNeue-Light"
        trashLabel.fontSize = 16
        recycleLabel.fontSize = 16
        compostLabel.fontSize = 16
        
        addChild(trashLabel)
        addChild(recycleLabel)
        addChild(compostLabel)
        
    }
    
    //adding landfill to the trash heaps
    func addTrash() -> Trash{
        let trash = Trash(itemColor: UIColor.white, imageNamed: "plasticbag", scene: self)

        trash.physicsBody = SKPhysicsBody(circleOfRadius: trash.size.width/2) // 1
        trash.physicsBody?.isDynamic = true // 2
        trash.physicsBody?.categoryBitMask = PhysicsCategory.trash // 3
        trash.physicsBody?.contactTestBitMask = PhysicsCategory.trashBox | PhysicsCategory.recycleBox | PhysicsCategory.compostBox // 4
        trash.physicsBody?.collisionBitMask = PhysicsCategory.waste
        
        let beginX = random(min: -size.width/4, max: size.width/4)
        let beginY = random(min: -size.height/2 + trash.size.height + trashBin.size.height, max: size.height/2 - trash.size.height)
        
        trash.position = CGPoint(x: beginX, y: beginY)
        addChild(trash)
        
        return trash

    }
    
    //adding recycling objects to the trash heap
    func addRecycle() -> Trash{
        let recycle = Trash(itemColor: UIColor.white, imageNamed: "bottle", scene: self)
        
        recycle.physicsBody = SKPhysicsBody(circleOfRadius: recycle.size.width/2) // 1
        recycle.physicsBody?.isDynamic = true // 2
        recycle.physicsBody?.categoryBitMask = PhysicsCategory.recycle // 3
        recycle.physicsBody?.contactTestBitMask = PhysicsCategory.trashBox | PhysicsCategory.recycleBox | PhysicsCategory.compostBox // 4
        recycle.physicsBody?.collisionBitMask = PhysicsCategory.waste
        
        let beginX = random(min: -size.width/4, max: size.width/4)
        let beginY = random(min: -size.height/2 + recycle.size.height + recycleBin.size.height, max: size.height/2 - recycle.size.height)
        
        recycle.position = CGPoint(x: beginX, y: beginY)
        addChild(recycle)

        return recycle
        
    }
    
    //adding compost to the trash heaps
    func addCompost() -> Trash{
        let compost = Trash(itemColor: UIColor.white, imageNamed: "banana", scene: self)
        
        compost.physicsBody = SKPhysicsBody(circleOfRadius: compost.size.width/2) // 1
        compost.physicsBody?.isDynamic = true // 2
        compost.physicsBody?.categoryBitMask = PhysicsCategory.compost // 3
        compost.physicsBody?.contactTestBitMask = PhysicsCategory.trashBox | PhysicsCategory.recycleBox | PhysicsCategory.compostBox // 4
        compost.physicsBody?.collisionBitMask = PhysicsCategory.waste
        
        let beginX = random(min: -size.width/4, max: size.width/4)
        let beginY = random(min: -size.height/2 + compost.size.height + compostBin.size.height, max: size.height/2 - compost.size.height)
        
        compost.position = CGPoint(x: beginX, y: beginY)
        addChild(compost)
        
        return compost

    }
    
    //to add and update the timer with seconds
    func addTimer() {
        timerValue = 60
        timerLabel = SKLabelNode(text: "Seconds left: \(timerValue)")
        timerLabel.fontName = "HelveticaNeue-Light"
        timerLabel.fontSize = 20
        timerLabel.position = CGPoint(x: -175, y: 200)
        addChild(timerLabel)
        
        let waitAction = SKAction.wait(forDuration: TimeInterval(1))
        let timerChangeAction = SKAction.run {
            self.timerValue = self.timerValue - 1
            self.timerLabel.text = "Seconds left: \(self.timerValue)"
            if(self.timerValue == 0){
                self.removeAction(forKey: "timeChange")
            }
        }
        
        
        //still need to change this
        run(SKAction.repeatForever(SKAction.sequence([waitAction, timerChangeAction])), withKey: "timeChange")
        
        SKAction.run(gameOver)
        
        
    }
    
    //to add the points label during setup
    func addPoints() {
        pointsLabel.position = CGPoint(x: 175, y: 200)
        pointsLabel.fontName = "HelveticaNeue-Light"
        pointsLabel.fontSize = 20
        addChild(pointsLabel)
    }
    
    //to add heaps during setup
    func addHeaps(){
        heapsLabel.position = CGPoint(x: 175, y: 175)
        heapsLabel.fontName = "HelveticaNeue-Light"
        heapsLabel.fontSize = 20
        addChild(heapsLabel)
    }
    
    //changes the number of points
    func updatePoints() {
        pointsLabel.text = "Eco-Points: \(points)"
    }
    
    //changes the heap number
    func updateHeaps(){
        heapsLabel.text = "Heap #: \(heaps)"
    }
    
    //to add lives during setup
    func addLives(){
        for _ in 1...numberOfLives {
            livesSprites.append(SKSpriteNode(imageNamed: "heart"))
        }
        livesSprites[0].position = CGPoint(x: -30, y: 212)
        livesSprites[1].position = CGPoint(x: 0, y: 212)
        livesSprites[2].position = CGPoint(x: 30, y: 212)
                
        for i in 0...numberOfLives - 1 {
            addChild(livesSprites[i])
        }
    }
    
    //when the user loses the game
    func gameOver(){
        removeAllChildren()
        let gameOverLabel = SKLabelNode(text: "Game Over!")
        gameOverLabel.fontName = "HelveticaNeue-Light"
        gameOverLabel.position = CGPoint(x: 0, y: 30)
        addChild(gameOverLabel)
        
        let yourScoreLabel = SKLabelNode(text: "Your Score: \(points) Eco-Points")
        yourScoreLabel.position = CGPoint(x: 0, y: -20)
        addChild(yourScoreLabel)
        
        let trashLabel = SKLabelNode(text: "You threw away \(trashAmt) items, recycled \(recycleAmt) items, and composted \(compostAmt) items! Good job!")
        trashLabel.position = CGPoint(x: 0, y: -70)
        trashLabel.fontSize = 16
        addChild(trashLabel)
        
        homeButton.position = CGPoint(x: 0, y: -120)
        homeButton.name = "homeButton"
        addChild(homeButton)
        
        
    }
    
    //adding trash to the scene for every heap
    func addSprites(){
        for _ in 1...heaps {
            sortObjects.append(addTrash())
        }
        let recycleInt = random(min: CGFloat(heaps*2), max: CGFloat(heaps*3))
        let compostInt = random(min: CGFloat(heaps*2), max: CGFloat(heaps*3))
        
        for _ in 1...Int(recycleInt.rounded()) {
            sortObjects.append(addRecycle())
        }
        for _ in 1...Int(compostInt.rounded()) {
            sortObjects.append(addCompost())
        }
        
    }
    
    //the main method - where all of the actions can be run
    public override func didMove(to view: SKView) {
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        addTimer()
        addPoints()
        addBins()
        addLives()
        addHeaps()
        addSprites()
        
    }

    struct PhysicsCategory {
        static let none      : UInt32 = 0
        static let all       : UInt32 = UInt32.max
        static let trash   : UInt32 = 0b001       // 1
        static let recycle: UInt32 = 0b010      // 2
        static let compost: UInt32 = 0b011
        static let waste: UInt32 = 0b100
        static let trashBox: UInt32 = 0b110
        static let recycleBox: UInt32 = 0b101
        static let compostBox: UInt32 = 0b111
        static let box: UInt32 = 0b0
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        if (node.name == "homeButton") {
            let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
            
            sceneView.presentScene(HomeScene(fileNamed: "HomeScene"))
            
            PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    //to detect physics collisions between bins and trash
    public func didBegin(_ contact: SKPhysicsContact) {
        
        let trashPoint = CGPoint(x: -size.width/2 + trashBin.size.width, y: -size.height/2 + trashBin.size.height / 2 + 100)
        let recyclePoint = CGPoint(x: 0, y: -size.height/2 + trashBin.size.height / 2 + 100)
        let compostPoint = CGPoint(x: size.width/2 - trashBin.size.width, y: -size.height/2 + trashBin.size.height / 2 + 100)
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if(secondBody.categoryBitMask == PhysicsCategory.trash ||
            secondBody.categoryBitMask == PhysicsCategory.recycle ||
            secondBody.categoryBitMask == PhysicsCategory.compost){
            return
        }
        
        if(firstBody.categoryBitMask == PhysicsCategory.trash){
            if(secondBody.categoryBitMask == PhysicsCategory.trashBox){
                trashAmt = trashAmt + 1
                trashLabel.text = "Landfill: \(trashAmt)"
                
                let fadeInAction = SKAction.fadeIn(withDuration: 0.2)
                let fadeOutAction = SKAction.fadeOut(withDuration: 0.2)
                let waitAction = SKAction.wait(forDuration: TimeInterval(0.4))
                
                let pointsText = SKLabelNode(text: "+10")
                pointsText.fontName = "AvenirNext-Bold"
                pointsText.alpha = 0
                pointsText.position = trashPoint
                addChild(pointsText)
                
                pointsText.run(SKAction.sequence([fadeInAction, waitAction, fadeOutAction]))
                
                points = points + 10
                updatePoints()
                
                let item = firstBody.node as? SKSpriteNode
                item?.removeFromParent()
                
                sortObjects.remove(at: 0)
                if(sortObjects.count == 0) {
                    heaps = heaps + 1
                    timerValue = timerValue + 10
                    addSprites()
                    updateHeaps()
                }
                
            }
            else{
                
                numberOfLives = numberOfLives - 1
                livesSprites[numberOfLives].removeFromParent()
                let fadeInAction = SKAction.fadeIn(withDuration: 0.2)
                let fadeOutAction = SKAction.fadeOut(withDuration: 0.2)
                let waitAction = SKAction.wait(forDuration: TimeInterval(0.4))
                
                let pointsText = SKLabelNode(text: "-1 Life")
                pointsText.fontName = "AvenirNext-Bold"
                pointsText.color = UIColor.red
                pointsText.alpha = 0
                
                if(secondBody.categoryBitMask == PhysicsCategory.recycleBox) {
                    pointsText.position = recyclePoint
                }
                else{
                    pointsText.position = compostPoint
                }
                
                addChild(pointsText)
                
                pointsText.run(SKAction.sequence([fadeInAction, waitAction, fadeOutAction]))
                
                let item = firstBody.node as? SKSpriteNode
                let beginX = random(min: -size.width/4, max: size.width/4)
                let beginY = random(min: -size.height/2 + item!.size.height + trashBin.size.height, max: size.height/2 - item!.size.height)
                
                item?.position = CGPoint(x: beginX, y: beginY)
                
                if(numberOfLives == 0){
                    gameOver()
                }
            }
        }
        else if(firstBody.categoryBitMask == PhysicsCategory.recycle){
            if(secondBody.categoryBitMask == PhysicsCategory.recycleBox){
                recycleAmt = recycleAmt + 1
                recycleLabel.text = "Recycle: \(recycleAmt)"
                
                let fadeInAction = SKAction.fadeIn(withDuration: 0.2)
                let fadeOutAction = SKAction.fadeOut(withDuration: 0.2)
                let waitAction = SKAction.wait(forDuration: TimeInterval(0.4))
                
                let pointsText = SKLabelNode(text: "+20")
                pointsText.fontName = "AvenirNext-Bold"
                pointsText.alpha = 0
                pointsText.position = recyclePoint
                addChild(pointsText)
                
                pointsText.run(SKAction.sequence([fadeInAction, waitAction, fadeOutAction]))
                
                points = points + 20
                updatePoints()
                
                let item = firstBody.node as? SKSpriteNode
                item?.removeFromParent()
                
                sortObjects.remove(at: 0)
                if(sortObjects.count == 0) {
                    heaps = heaps + 1
                    timerValue = timerValue + 10
                    addSprites()
                    updateHeaps()
                }
            }
            else{
                
                numberOfLives = numberOfLives - 1
                livesSprites[numberOfLives].removeFromParent()
                let fadeInAction = SKAction.fadeIn(withDuration: 0.2)
                let fadeOutAction = SKAction.fadeOut(withDuration: 0.2)
                let waitAction = SKAction.wait(forDuration: TimeInterval(0.4))
                
                let pointsText = SKLabelNode(text: "-1 Life")
                pointsText.fontName = "AvenirNext-Bold"
                pointsText.color = UIColor.red
                pointsText.alpha = 0
                
                if(secondBody.categoryBitMask == PhysicsCategory.trashBox) {
                    pointsText.position = trashPoint
                }
                else{
                    pointsText.position = compostPoint
                }
                
                addChild(pointsText)
                
                pointsText.run(SKAction.sequence([fadeInAction, waitAction, fadeOutAction]))
                
                let item = firstBody.node as? SKSpriteNode
                let beginX = random(min: -size.width/4, max: size.width/4)
                let beginY = random(min: -size.height/2 + item!.size.height + trashBin.size.height, max: size.height/2 - item!.size.height)
                
                item?.position = CGPoint(x: beginX, y: beginY)
                
                if(numberOfLives == 0){
                    gameOver()
                }
            }
        }
        else if(firstBody.categoryBitMask == PhysicsCategory.compost){
            if(secondBody.categoryBitMask == PhysicsCategory.compostBox){
                compostAmt = compostAmt + 1
                compostLabel.text = "Compost: \(compostAmt)"
                
                let fadeInAction = SKAction.fadeIn(withDuration: 0.2)
                let fadeOutAction = SKAction.fadeOut(withDuration: 0.2)
                let waitAction = SKAction.wait(forDuration: TimeInterval(0.4))
                
                let pointsText = SKLabelNode(text: "+20")
                pointsText.fontName = "AvenirNext-Bold"
                pointsText.alpha = 0
                pointsText.position = compostPoint
                addChild(pointsText)
                
                pointsText.run(SKAction.sequence([fadeInAction, waitAction, fadeOutAction]))
                
                points = points + 20
                updatePoints()
                
                let item = firstBody.node as? SKSpriteNode
                item?.removeFromParent()
                
                sortObjects.remove(at: 0)
                if(sortObjects.count == 0) {
                    heaps = heaps + 1
                    timerValue = timerValue + 10
                    addSprites()
                    updateHeaps()
                }
            }
            else{
                
                numberOfLives = numberOfLives - 1
                livesSprites[numberOfLives].removeFromParent()
                let fadeInAction = SKAction.fadeIn(withDuration: 0.2)
                let fadeOutAction = SKAction.fadeOut(withDuration: 0.2)
                let waitAction = SKAction.wait(forDuration: TimeInterval(0.4))
                
                let pointsText = SKLabelNode(text: "-1 Life")
                pointsText.fontName = "AvenirNext-Bold"
                pointsText.color = UIColor.red
                pointsText.alpha = 0
                
                if(secondBody.categoryBitMask == PhysicsCategory.trashBox) {
                    pointsText.position = trashPoint
                }
                else{
                    pointsText.position = recyclePoint
                }
                
                addChild(pointsText)
                
                pointsText.run(SKAction.sequence([fadeInAction, waitAction, fadeOutAction]))
                
                let item = firstBody.node as? SKSpriteNode
                let beginX = random(min: -size.width/4, max: size.width/4)
                let beginY = random(min: -size.height/2 + item!.size.height + trashBin.size.height, max: size.height/2 - item!.size.height)
                
                item?.position = CGPoint(x: beginX, y: beginY)
                
                if(numberOfLives == 0){
                    gameOver()
                }
            }
        }
    }
}

class Trash : SKSpriteNode {
    
    var parkScene: GameScene = GameScene()
    var selectedNode: SKNode?
    
    init(itemColor: UIColor, imageNamed: String, scene: GameScene) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: itemColor, size: texture.size())
        isUserInteractionEnabled = true
        parkScene = scene
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isUserInteractionEnabled = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let node = self
        if let touch = touches.first {
            let touchLocation = touch.location(in: parkScene)
            node.position = touchLocation
        }
    }

}
