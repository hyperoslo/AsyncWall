import UIKit
import AsyncDisplayKit

public class ControlNode: ASControlNode {

  var contentNode: ASDisplayNode
  var titleNode: ASTextNode?
  var imageNode: ASImageNode?

  var size: CGSize {
    return ControlConfig.size
  }

  private var ControlConfig: Config.Wall.Post.Control.Type {
    return Config.Wall.Post.Control.self
  }

  public init(title: NSAttributedString?, image: UIImage?) {
    contentNode = ASDisplayNode()

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
    var x: CGFloat = ControlConfig.padding
    var contentSize = size

    if let imageNode = imageNode {
      let size = ControlConfig.imageSize

      imageNode.frame = CGRect(
        origin: CGPoint(x: x, y: size.centerInSize(self.size).y),
        size: size)

      x += size.width + ControlConfig.padding
    }

    if let titleNode = titleNode {
      let titleHeight = self.size.height - 2 * ControlConfig.padding

      let size = titleNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: titleHeight < 0 ? 0 : titleHeight))

      titleNode.frame = CGRect(
        origin: CGPoint(x: x, y: size.centerInSize(self.size).y),
        size: size)

      x += size.width + ControlConfig.padding
    }

    contentSize.width = x
    contentNode.frame = CGRect(
      origin: CGPoint(x: contentSize.centerInSize(size).x, y: 0),
      size: contentSize)
  }
}
