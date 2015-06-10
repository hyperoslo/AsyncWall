import UIKit
import AsyncDisplayKit

public class ControlNode: ASControlNode {

  var titleNode: ASTextNode?
  var imageNode: ASImageNode?

  private var ControlConfig: Config.Wall.Post.Control.Type {
    return Config.Wall.Post.Control.self
  }

  public init(title: NSAttributedString?, image: UIImage?) {
    super.init()

    if let title = title {
      titleNode = ASTextNode()
      titleNode!.attributedString = title

      addSubnode(titleNode)
    }

    if let image = image {
      imageNode = ASImageNode()
      imageNode?.image = image

      addSubnode(imageNode)
    }
  }

  // MARK: - Layout

  override public func layout() {
    var x: CGFloat = ControlConfig.padding
    var y: CGFloat = ControlConfig.padding

    if let imageNode = imageNode {
      let size = ControlConfig.imageSize

      imageNode.frame = CGRect(
        origin: CGPoint(x: x, y: y + centerY(size.height)),
        size: size)
      x += size.width + ControlConfig.padding
    }

    if let titleNode = titleNode {
      let size = CGSize(
        width: CGFloat(FLT_MAX),
        height: frame.size.height - 2 * ControlConfig.padding)

      titleNode.frame = CGRect(
        origin: CGPoint(x: x, y: y + centerY(size.height)),
        size: size)
    }
  }

  // MARK: - Private Methods

  func centerY(height: CGFloat) -> CGFloat {
    return (frame.size.height - height) / 2
  }
}
