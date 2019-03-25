import Foundation
import PlaygroundSupport
import UIKit
import SceneKit
import GameKit
import SpriteKit

public class HomeScene: SKScene {
    
    let title = SKLabelNode(text: "Green Sort")
    let playButton = SKSpriteNode(imageNamed: "play")
    let howToPlayButton = SKSpriteNode(imageNamed: "howtoplay")
    let creditsButton = SKSpriteNode(imageNamed: "credits")
    let homeButton = SKSpriteNode(imageNamed: "home")
    let howToPlayTitle = SKLabelNode(text: "How To Play")
    var howToPlayText = SKLabelNode(text: "")
    let creditsTitle = SKLabelNode(text: "Credits")
    var creditsText = SKLabelNode(text: "")
    var pageName: String = ""

    public override func didMove(to view: SKView) {
        
        title.fontSize = 50
        title.fontColor = UIColor.black
        title.position = CGPoint(x: 0, y: 75)
        addChild(title)
        
        playButton.position = CGPoint(x: 0, y: 0)
        playButton.name = "playButton"; // set the name for your sprite
        playButton.isUserInteractionEnabled = false
        addChild(playButton)
        
        howToPlayButton.position = CGPoint(x: 0, y: -50)
        howToPlayButton.name = "howToPlayButton"; // set the name for your sprite
        howToPlayButton.isUserInteractionEnabled = false
        addChild(howToPlayButton)
        
        creditsButton.position = CGPoint(x: 0, y: -100)
        creditsButton.name = "creditsButton"; // set the name for your sprite
        creditsButton.isUserInteractionEnabled = false
        addChild(creditsButton)
        
        homeButton.position = CGPoint(x: 0, y: -100)
        homeButton.name = "homeButton"
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        if (node.name == "playButton") {
            let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
            
            sceneView.presentScene(GameScene(fileNamed: "GameScene"))
            
            PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

        }
        else if (node.name == "howToPlayButton"){
            title.removeFromParent()
            playButton.removeFromParent()
            howToPlayButton.removeFromParent()
            creditsButton.removeFromParent()
            
            howToPlayTitle.position = CGPoint(x: 0, y: 175)
            howToPlayTitle.fontSize = 50
            howToPlayTitle.fontColor = UIColor.black
            howToPlayText.text = "Large heaps of waste are infiltrating the Earth, in the form of landfill. However, some of this waste can be recycled or composted! Your job is to help sort out these heaps of waste into compost, recycling, and landfill.\nYou will be given a heap of waste as well as three sorting bins. You have to finish sorting through the waste within 60 seconds. To do so, drag each piece of waste into its correct bin.\nThrowing things correctly into the landfill will give you 10 eco-points, while throwing things into compost or recycling will give you 20 eco-points for each item.\nIf you incorrectly sort an item you will lose a life. Making 3 mistakes will result in game over.\nFinishing a heap of waste will result in a time bonus of 10 seconds.\nTry to earn as many points as you can! Remember, composting and recycling will give you more eco-points."
            howToPlayText.lineBreakMode = NSLineBreakMode.byWordWrapping
            howToPlayText.numberOfLines = 0
            howToPlayText.preferredMaxLayoutWidth = 500
            howToPlayText.fontSize = 16
            howToPlayText.fontName = "Helvetica-Neue Light"
            howToPlayText.verticalAlignmentMode = .center
            howToPlayText.position = CGPoint(x: 0, y: 0)
            howToPlayText.fontColor = UIColor.black

            addChild(howToPlayTitle)
            addChild(howToPlayText)
            pageName = "howtoplay"
            
            homeButton.position = CGPoint(x: 0, y: -200)
            addChild(homeButton)
            
        }
        else if (node.name == "creditsButton"){
            title.removeFromParent()
            playButton.removeFromParent()
            howToPlayButton.removeFromParent()
            creditsButton.removeFromParent()
            
            creditsText.text = "Made with love by Mansi Gandhi (WWDC 2019 scholarship submission). It was great to experiment with the Swift programming language for the first time! I really had a fun time with creating this game, and I hope you have a fun time playing it too!"
            creditsText.lineBreakMode = NSLineBreakMode.byWordWrapping
            creditsText.numberOfLines = 0
            creditsText.preferredMaxLayoutWidth = 400
            creditsText.fontSize = 16
            creditsText.fontName = "Helvetica-Neue Light"
            creditsText.verticalAlignmentMode = .center
            creditsText.position = CGPoint(x: 0, y: 0)
            
            creditsTitle.position = CGPoint(x: 0, y: 175)
            creditsTitle.fontSize = 50
            creditsTitle.fontColor = UIColor.black
            creditsText.position = CGPoint(x: 0, y: 0)
            creditsText.fontColor = UIColor.black
            
            addChild(creditsTitle)
            addChild(creditsText)
            pageName = "credits"
            
            
            addChild(homeButton)
            
        }
        else if (node.name == "homeButton"){
            if(pageName == "howtoplay"){
                howToPlayText.removeFromParent()
                howToPlayTitle.removeFromParent()
                homeButton.removeFromParent()
            }
            else if(pageName == "credits"){
                creditsText.removeFromParent()
                creditsTitle.removeFromParent()
                homeButton.removeFromParent()
            }
            
            addChild(title)
            addChild(playButton)
            addChild(howToPlayButton)
            addChild(creditsButton)
        }
    }

    
}

