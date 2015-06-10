import UIKit
import AsyncDisplayKit

public class ControlNode: ASControlNode {

  var titleNode: ASTextNode?
  var imageNode: ASImageNode?

  var size: CGSize {
    return ControlConfig.size
  }

  var contentSize = CGSizeZero

  private var ControlConfig: Config.Wall.Post.Control.Type {
    return Config.Wall.Post.Control.self
  }

  public init(title: NSAttributedString?, image: UIImage?) {
    super.init()

    backgroundColor = .redColor()

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

    if let imageNode = imageNode {
      let size = ControlConfig.imageSize

      imageNode.frame = CGRect(
        origin: CGPoint(x: x, y: centerY(size.height)),
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
        origin: CGPoint(x: x, y: centerY(size.height)),
        size: size)
    }
  }

  // MARK: - Private Methods

  func centerY(height: CGFloat) -> CGFloat {
    return (size.height - height) / 2
  }
}
