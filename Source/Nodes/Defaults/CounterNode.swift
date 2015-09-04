import UIKit
import AsyncDisplayKit

public class CounterNode: ASDisplayNode {

  public let size: CGSize
  public var textNode: ASTextNode

  // MARK: - Initialization

  public init(size: CGSize, count: Int, totalCount: Int) {
    self.size = size

    textNode = ASTextNode()
    super.init()

    backgroundColor = UIColor(white: 0, alpha: 0.5)

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .Center

    let attributes = [
      NSFontAttributeName: UIFont.systemFontOfSize(34),
      NSForegroundColorAttributeName: UIColor.whiteColor(),
      NSParagraphStyleAttributeName: paragraphStyle
    ]

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
