import UIKit
import AsyncDisplayKit

public class CounterNode: ASDisplayNode {

  let config: Config

  var size: CGSize
  var textNode: ASTextNode

  private var counterConfig: Config.Wall.Post.Attachments.Counter {
    return config.wall.post.attachments.counter
  }

  // MARK: - Initialization

  public init(config: Config, size: CGSize, count: Int, totalCount: Int) {
    self.config = config
    self.size = size

    textNode = ASTextNode()
    super.init()

    backgroundColor = counterConfig.backgroundColor

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .Center
    var attributes = counterConfig.textAttributes
    attributes[NSParagraphStyleAttributeName] = paragraphStyle
    let text = "+\(totalCount - count)"

    textNode.attributedString = NSAttributedString(
      string: text,
      attributes: attributes)

    addSubnode(textNode)
  }

  // MARK: - Layout

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    textNode.measure(CGSize(
      width: size.width,
      height: CGFloat(FLT_MAX)))

    return CGSizeMake(size.width, size.height)
  }

  override public func layout() {
    let textSize = textNode.calculatedSize
    let textOrigin = textSize.centerInSize(size)
    textNode.frame = CGRect(
      origin: textOrigin,
      size: textSize)
  }
}
