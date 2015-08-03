import UIKit
import AsyncDisplayKit

public class ControlNode: ASControlNode {

  // MARK: - Configuration

  public var size = CGSize(width: 100.0, height: 35.0)
  public var padding: CGFloat = 5
  public var imageSize = CGSize(width: 22, height: 22)

  // MARK: - Nodes

  public var contentNode = ASDisplayNode()
  public var titleNode: ASTextNode?
  public var imageNode: ASImageNode?

  // MARK: - Initialization

  public init(title: NSAttributedString?, image: UIImage? = nil) {
    super.init()

    if let title = title {
      titleNode = ASTextNode()
      titleNode!.attributedString = title

      contentNode.addSubnode(titleNode)
    }

    if let image = image {
      imageNode = ASImageNode()
      imageNode?.image = image

      contentNode.addSubnode(imageNode)
    }

    addSubnode(contentNode)
  }

  // MARK: - Layout

  override public func layout() {
    var x: CGFloat = padding
    var contentSize = size

    if let imageNode = imageNode {
      imageNode.frame = CGRect(
        origin: CGPoint(x: x, y: size.centerInSize(size).y),
        size: imageSize)

      x += imageSize.width + padding
    }

    if let titleNode = titleNode {
      let titleHeight = size.height - 2 * padding

      let titleSize = titleNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: titleHeight < 0 ? 0 : titleHeight))

      titleNode.frame = CGRect(
        origin: CGPoint(x: x, y: titleSize.centerInSize(size).y),
        size: titleSize)

      x += titleSize.width + padding
    }

    contentSize.width = x
    contentNode.frame = CGRect(
      origin: CGPoint(x: contentSize.centerInSize(size).x, y: 0),
      size: contentSize)
  }
}
