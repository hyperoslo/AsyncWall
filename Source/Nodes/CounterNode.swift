import UIKit
import AsyncDisplayKit

public class CounterNode: ASCellNode {

  var textNode: ASTextNode
  var boxNode: ASDisplayNode
  var backBoxNode: ASDisplayNode

  private var CounterConfig: Config.Wall.Post.Attachments.Counter.Type {
    return Config.Wall.Post.Attachments.Counter.self
  }

  var size: CGSize {
    let width = CounterConfig.boxSize.width + CounterConfig.padding * 2
    let height = CounterConfig.boxSize.height + CounterConfig.padding * 2
    return CGSize(width: width, height: height)
  }

  // MARK: - Initialization

  public init(count: Int, totalCount: Int) {
    backBoxNode = ASDisplayNode()
    backBoxNode.backgroundColor = .whiteColor()
    backBoxNode.alpha = 0.4
    backBoxNode.cornerRadius = 2

    boxNode = ASDisplayNode()
    boxNode.backgroundColor = .whiteColor()
    boxNode.alpha = 0.9
    boxNode.cornerRadius = 2

    textNode = ASTextNode()
    super.init()

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .Center
    var attributes = CounterConfig.textAttributes
    attributes[NSParagraphStyleAttributeName] = paragraphStyle
    let text = "\(count)/\(totalCount)"

    textNode.attributedString = NSAttributedString(string: text,
      attributes: attributes)

    addSubnode(backBoxNode)
    addSubnode(boxNode)
    addSubnode(textNode)
  }

  // MARK: - Layout

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    textNode.measure(CGSize(width: CounterConfig.boxSize.width,
      height: CGFloat(FLT_MAX)))

    return CGSizeMake(size.width, size.height)
  }

  override public func layout() {
    backBoxNode.frame = CGRect(
      origin: CGPoint(x: CounterConfig.boxGap, y: CounterConfig.boxGap),
      size: CounterConfig.boxSize)

    boxNode.frame = CGRect(
      origin: CGPoint(x: 0, y: 0),
      size: CounterConfig.boxSize)

    let textSize = textNode.calculatedSize
    let textOrigin = CGPoint(
      x: CGRectGetMidX(boxNode.frame) - textSize.width / 2,
      y: CGRectGetMidY(boxNode.frame) - textSize.height / 2)
    textNode.frame = CGRect(
      origin: textOrigin,
      size: textSize)
  }
}
