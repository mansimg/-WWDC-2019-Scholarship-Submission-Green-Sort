import Foundation
import PlaygroundSupport
import SpriteKit


let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))

sceneView.presentScene(HomeScene(fileNamed: "HomeScene"))

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

