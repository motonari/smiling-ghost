//
import SpriteKit

class TargetNode: SKNode {

    override init() {
        super.init()
        
        let circle = SKShapeNode(circleOfRadius: 136)
        circle.fillColor = .white
        addChild(circle)

        for radius in stride(from: 16, through: 128, by: 32) {
            let redCircle = SKShapeNode(circleOfRadius: CGFloat(radius))
            redCircle.strokeColor = .red
            redCircle.lineWidth = 16
            addChild(redCircle)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
