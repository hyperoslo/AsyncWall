import UIKit
import AsyncDisplayKit

class PostCellNode: ASCellNode {

  struct Dimensions {
    static let padding:CGFloat = 10
  }

  let row: Int

  var width: CGFloat
  var contentWidth: CGFloat
  var imageSize: CGSize

  var titleNode: ASTextNode
  var divider: ASDisplayNode

  init(title: String, width: CGFloat, row: Int) {
    self.row = row

    self.width = width
    contentWidth = width - 2.0 * Dimensions.padding

    divider = ASDisplayNode()

    super.init()

    // Title
    titleNode = ASTextNode()
    let titleAttributes = [
      NSFontAttributeName: UIFont.systemFontOfSize(14),
      NSForegroundColorAttributeName: UIColor.lightGrayColor()
    ]
    titleNode.attributedString = NSAttributedString(string: title, attributes: titleAttributes)
    addSubnode(titleNode)

    // Divider
    divider.backgroundColor = UIColor.lightTextColor()
    addSubnode(divider)
  }

  override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    var height = Dimensions.padding * 2

    let titleSize = titleNode.measure(CGSize(width: contentWidth, height: CGFloat(FLT_MAX)))
    height += titleSize.height + Dimensions.padding

    return CGSizeMake(width, height)
  }

  override func layout() {
    var y:CGFloat = Dimensions.padding

    let titleSize = titleNode.calculatedSize
    titleNode.frame = CGRect(
      x: Dimensions.padding,
      y: y,
      width: titleSize.width,
      height: titleSize.height
    )
    y += titleSize.height + Dimensions.padding

    // Divider node
    divider.frame = CGRect(
      x: 0,
      y: y,
      width: width,
      height: Dimensions.padding
    )
  }

}
