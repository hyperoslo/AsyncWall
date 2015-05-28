import UIKit
import AsyncDisplayKit

public class PostCellNode: ASCellNode {

  struct Dimensions {
    static let dividerHeight: CGFloat = 1
  }

  let width: CGFloat

  var contentWidth: CGFloat {
    return width - 2 * Config.Wall.padding
  }

  var textNode: ASTextNode?

  var divider: ASDisplayNode?

  public init(post: Post, width: CGFloat) {
    self.width = width

    super.init()

    if let text = post.text {
      textNode = ASTextNode()
      textNode!.attributedString = NSAttributedString(string: text,
        attributes: Config.Wall.TextAttributes.postText)
      addSubnode(textNode)
    }

    if Config.Wall.useDivider {
      divider = ASDisplayNode()
      divider!.backgroundColor = .lightGrayColor()
      addSubnode(divider)
    }
  }

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    var height = Config.Wall.padding * 2

    if let textNode = textNode {
      let textSize = textNode.measure(CGSize(width: contentWidth,
        height: CGFloat(FLT_MAX)))
      height += textSize.height + Config.Wall.padding
    }

    if Config.Wall.useDivider {
      height += Dimensions.dividerHeight
    }

    return CGSizeMake(width, height)
  }

  override public func layout() {
    let padding = Config.Wall.padding
    var y = padding

    if let textNode = textNode {
      let textSize = textNode.calculatedSize
      textNode.frame = CGRect(
        origin: CGPoint(x: padding, y: y),
        size: textSize)

      y += textSize.height + padding
    }

    if let divider = divider {
      divider.frame = CGRect(x: padding, y: y,
        width: contentWidth, height: Dimensions.dividerHeight)
    }
  }
}
