import BlueSight
import SpriteKit

class GameScene: SKScene {

    private var sightNode: SKShapeNode?

    private var targetNode: SKNode?
    private var blueSight = BlueSight()

    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }

        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill

        return scene
    }

    func setUpScene() {
        physicsWorld.gravity = CGVector.zero

        targetNode = TargetNode()

        sightNode = SKShapeNode(circleOfRadius: 10.0)
        sightNode?.fillColor = .red
        if let sightNode {
            addChild(sightNode)
        }

        self.blueSight.start()
    }

    override func didMove(to view: SKView) {
        self.setUpScene()
    }

    override func update(_ currentTime: TimeInterval) {
        var point = blueSight.location
        point.x *= self.size.width / 2.0
        point.y *= self.size.height / 2.0

        if let sightNode {
            let action = SKAction.move(to: point, duration: 0.0)
            sightNode.run(action)
        }
    }
}

#if os(iOS) || os(tvOS)
    // Touch-based event handling
    extension GameScene {

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let label = self.label {
                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            }

            for t in touches {
                self.makeSpinny(at: t.location(in: self), color: SKColor.green)
            }
        }

        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches {
                self.makeSpinny(at: t.location(in: self), color: SKColor.blue)
            }
        }

        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches {
                self.makeSpinny(at: t.location(in: self), color: SKColor.red)
            }
        }

        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches {
                self.makeSpinny(at: t.location(in: self), color: SKColor.red)
            }
        }

    }
#endif

#if os(OSX)
    // Mouse-based event handling
    extension GameScene {

        override func mouseDown(with event: NSEvent) {
            if let targetNode = self.targetNode {
                if targetNode.contains(event.location(in: self)) {
                    print("Hit")
                }
            }
        }

        override func mouseDragged(with event: NSEvent) {
        }

        override func mouseUp(with event: NSEvent) {
        }

    }
#endif
