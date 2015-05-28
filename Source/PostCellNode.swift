import UIKit
import AsyncDisplayKit

class PostCellNode: ASCellNode {

  struct Dimensions {
    static let dividerHeight: CGFloat = 1
  }

  let width: CGFloat

  var contentWidth: CGFloat {
    return width - 2.0 * Config.Wall.padding
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

    titleNode.attributedString = NSAttributedString(string: title,
      attributes: Config.Wall.TextAttributes.postText)
    addSubnode(titleNode)

    divider.backgroundColor = .lightGrayColor()
    addSubnode(divider)
  }

  override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    var height = Config.Wall.padding * 2

    let titleSize = titleNode.measure(CGSize(width: contentWidth,
      height: CGFloat(FLT_MAX)))
    height += titleSize.height + Config.Wall.padding + Dimensions.dividerHeight

    return CGSizeMake(width, height)
  }

  override func layout() {
    let padding = Config.Wall.padding
    var y = padding

    let titleSize = titleNode.calculatedSize
    titleNode.frame = CGRect(
      origin: CGPoint(x: padding, y: y),
      size: titleSize)

    y += titleSize.height + padding

    divider.frame = CGRect(x: padding, y: y,
      width: contentWidth, height: Dimensions.dividerHeight)
  }
}
