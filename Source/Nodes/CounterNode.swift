import UIKit
import AsyncDisplayKit

public class CounterNode: ASDisplayNode {

  let config: Config

  var textNode: ASTextNode
  var boxNode: ASDisplayNode
  var backBoxNode: ASDisplayNode

  private var counterConfig: Config.Wall.Post.Attachments.Counter {
    return config.wall.post.attachments.counter
  }

  var size: CGSize {
    let width = counterConfig.boxSize.width + counterConfig.padding * 2
    let height = counterConfig.boxSize.height + counterConfig.padding * 2
    return CGSize(width: width, height: height)
  }

  // MARK: - Initialization

  public init(config: Config, count: Int, totalCount: Int) {
    self.config = config

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
    var attributes = counterConfig.textAttributes
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
    textNode.measure(CGSize(width: counterConfig.boxSize.width,
      height: CGFloat(FLT_MAX)))

    return CGSizeMake(size.width, size.height)
  }

  override public func layout() {
    backBoxNode.frame = CGRect(
      origin: CGPoint(x: counterConfig.boxGap, y: counterConfig.boxGap),
      size: counterConfig.boxSize)

    boxNode.frame = CGRect(
      origin: CGPoint(x: 0, y: 0),
      size: counterConfig.boxSize)

    let textSize = textNode.calculatedSize
    let textOrigin = CGPoint(
      x: CGRectGetMidX(boxNode.frame) - textSize.width / 2,
      y: CGRectGetMidY(boxNode.frame) - textSize.height / 2)
    textNode.frame = CGRect(
      origin: textOrigin,
      size: textSize)
  }
}
