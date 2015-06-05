import UIKit
import AsyncDisplayKit

public class PostFooterNode: ASCellNode {

  let width: CGFloat

  var likesNode: ASTextNode?

  var height: CGFloat {
    return FooterConfig.height
  }

  private var FooterConfig: Config.Wall.Post.Footer.Type {
    return Config.Wall.Post.Footer.self
  }

  // MARK: - Initialization

  public init(post: Post, width: CGFloat) {
    self.width = width

    super.init()

    if FooterConfig.Likes.enabled {
      likesNode = ASTextNode()
      likesNode!.attributedString = NSAttributedString(
        string: "\(post.likes)",
        attributes: FooterConfig.Likes.textAttributes)
      likesNode!.userInteractionEnabled = true

      addSubnode(likesNode)
    }
  }

  // MARK: - Layout

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    return CGSizeMake(width, height)
  }

  override public func layout() {
    var x: CGFloat = 0

    if let likesNode = likesNode {
      let size = likesNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: height))

      likesNode.frame = CGRect(
        origin: CGPoint(x: x, y: centerY(size.height)),
        size: size)
      x += size.width + FooterConfig.horizontalPadding
    }
  }

  // MARK: - Private Methods

  func centerY(height: CGFloat) -> CGFloat {
    return (self.height - height) / 2
  }
}
