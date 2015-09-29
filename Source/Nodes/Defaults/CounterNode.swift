import UIKit
import AsyncDisplayKit

public class CounterNode: ASDisplayNode {

  public var textNode: ASTextNode

  // MARK: - Initialization

  public init(count: Int, totalCount: Int) {
    textNode = ASTextNode()
    super.init()

    shouldRasterizeDescendants = true
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

  override public func layout() {
    let textSize = textNode.measure(CGSize(
      width: bounds.width,
      height: CGFloat(FLT_MAX)))
    let textOrigin = textSize.centerInSize(bounds.size)
    textNode.frame = CGRect(
      origin: textOrigin,
      size: textSize)
  }
}
