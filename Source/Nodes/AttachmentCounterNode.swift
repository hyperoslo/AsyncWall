import UIKit
import AsyncDisplayKit

public class AttachmentCounterNode: ASCellNode {

  struct Dimensions {
    static let boxSize: CGFloat = 40
    static let padding: CGFloat = 10
  }

  var textNode: ASTextNode
  var boxNode: ASDisplayNode
  var backBoxNode: ASDisplayNode

  public var size: CGFloat {
    return Dimensions.boxSize + Dimensions.padding * 2
  }

  public init(count: Int, totalCount: Int) {
    backBoxNode = ASDisplayNode()
    backBoxNode.backgroundColor = .whiteColor()
    backBoxNode.alpha = 0.4

    boxNode = ASDisplayNode()
    boxNode.backgroundColor = .whiteColor()
    boxNode.alpha = 0.9

    let text = "\(count)/\(totalCount)"
    textNode = ASTextNode()
    textNode.attributedString = NSAttributedString(string: text,
      attributes: Config.Wall.TextAttributes.postText)

    super.init()

    addSubnode(backBoxNode)
    addSubnode(boxNode)
    addSubnode(textNode)
  }

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    addSubnode(textNode)

    let textSize = textNode.measure(
      CGSize(width: Dimensions.boxSize, height: CGFloat(FLT_MAX)))

    return CGSizeMake(size, size)
  }

  override public func layout() {
    backBoxNode.frame = CGRect(x: 0, y: 0,
      width: Dimensions.boxSize, height: Dimensions.boxSize)

    boxNode.frame = CGRect(x: Dimensions.padding, y: Dimensions.padding,
      width: Dimensions.boxSize, height: Dimensions.boxSize)

    let textSize = textNode.calculatedSize
    textNode.frame = CGRect(
      origin: CGPoint(x: 0, y: 0),
      size: textSize)
  }
}
