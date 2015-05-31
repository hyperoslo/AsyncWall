import UIKit
import AsyncDisplayKit

public class AttachmentCounterNode: ASCellNode {

  struct Dimensions {
    static let boxSize = CGSize(width: 40.0, height: 30.0)
    static let padding: CGFloat = 3
    static let boxGap: CGFloat = 3
  }

  var textNode: ASTextNode
  var boxNode: ASDisplayNode
  var backBoxNode: ASDisplayNode

  public var size: CGSize {
    let width = Dimensions.boxSize.width + Dimensions.padding * 2
    let height = Dimensions.boxSize.height + Dimensions.padding * 2
    return CGSize(width: width, height: height)
  }

  public init(count: Int, totalCount: Int) {
    backBoxNode = ASDisplayNode()
    backBoxNode.backgroundColor = .whiteColor()
    backBoxNode.alpha = 0.4
    backBoxNode.cornerRadius = 2

    boxNode = ASDisplayNode()
    boxNode.backgroundColor = .whiteColor()
    boxNode.alpha = 0.9
    boxNode.cornerRadius = 2

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .Center
    var attributes = Config.Wall.TextAttributes.attachmentCounter
    attributes[NSParagraphStyleAttributeName] = paragraphStyle

    let text = "\(count)/\(totalCount)"
    textNode = ASTextNode()
    textNode.attributedString = NSAttributedString(string: text,
      attributes: attributes)
    super.init()

    addSubnode(backBoxNode)
    addSubnode(boxNode)
    addSubnode(textNode)
  }

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    textNode.measure(CGSize(width: Dimensions.boxSize.width,
      height: CGFloat(FLT_MAX)))

    return CGSizeMake(size.width, size.height)
  }

  override public func layout() {
    backBoxNode.frame = CGRect(
      origin: CGPoint(x: Dimensions.boxGap, y: Dimensions.boxGap),
      size: Dimensions.boxSize)

    boxNode.frame = CGRect(
      origin: CGPoint(x: 0, y: 0),
      size: Dimensions.boxSize)

    let textSize = textNode.calculatedSize
    let textOrigin = CGPoint(
      x: CGRectGetMidX(boxNode.frame) - textSize.width / 2,
      y: CGRectGetMidY(boxNode.frame) - textSize.height / 2)
    textNode.frame = CGRect(
      origin: textOrigin,
      size: textSize)
  }
}
