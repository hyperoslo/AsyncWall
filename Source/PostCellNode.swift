import UIKit
import AsyncDisplayKit

class PostCellNode: ASCellNode {

  struct Dimensions {
    static let padding: CGFloat = 10
    static let dividerHeight: CGFloat = 1
  }

  let width: CGFloat

  var contentWidth: CGFloat {
    return width - 2.0 * Dimensions.padding
  }

  lazy var titleNode: ASTextNode = {
    return ASTextNode()
    }()

  lazy var divider: ASDisplayNode = {
    return ASDisplayNode()
    }()

  init(title: String, width: CGFloat) {
    self.width = width

    super.init()

    let titleAttributes = [
      NSFontAttributeName: UIFont.systemFontOfSize(14),
      NSForegroundColorAttributeName: UIColor.blackColor()
    ]
    titleNode.attributedString = NSAttributedString(string: title,
      attributes: titleAttributes)
    addSubnode(titleNode)

    divider.backgroundColor = .lightGrayColor()
    addSubnode(divider)
  }

  override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    var height = Dimensions.padding * 2

    let titleSize = titleNode.measure(CGSize(width: contentWidth,
      height: CGFloat(FLT_MAX)))
    height += titleSize.height + Dimensions.padding + Dimensions.dividerHeight

    return CGSizeMake(width, height)
  }

  override func layout() {
    var y = Dimensions.padding

    let titleSize = titleNode.calculatedSize
    titleNode.frame = CGRect(
      origin: CGPoint(x: Dimensions.padding, y: y),
      size: titleSize)

    y += titleSize.height + Dimensions.padding

    divider.frame = CGRect(x: Dimensions.padding, y: y,
      width: contentWidth, height: Dimensions.dividerHeight)
  }
}
