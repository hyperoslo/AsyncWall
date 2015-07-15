import UIKit
import AsyncDisplayKit

public class PostFooterNode: ASDisplayNode {

  public let width: CGFloat
  public let config: Config

  public var likesNode: ASTextNode?
  public var commentsNode: ASTextNode?
  public var seenNode: ASTextNode?

  public var height: CGFloat {
    return footerConfig.height
  }

  private var footerConfig: Config.Wall.Post.Footer {
    return config.wall.post.footer
  }

  // MARK: - Initialization

  public init(config: Config, post: Postable, width: CGFloat) {
    self.width = width
    self.config = config

    super.init()

    if footerConfig.likes.enabled {
      let string = String.localizedStringWithFormat(
        NSLocalizedString("%d like(s)", comment: ""),
        post.likeCount)

      likesNode = ASTextNode()
      likesNode!.attributedString = NSAttributedString(
        string: string,
        attributes: footerConfig.likes.textAttributes)
      likesNode!.userInteractionEnabled = true

      addSubnode(likesNode)
    }

    if footerConfig.comments.enabled {
      let string = String.localizedStringWithFormat(
        NSLocalizedString("%d comment(s)", comment: ""),
        post.commentCount)

      commentsNode = ASTextNode()
      commentsNode!.attributedString = NSAttributedString(
        string: string,
        attributes: footerConfig.comments.textAttributes)
      commentsNode!.userInteractionEnabled = true

      addSubnode(commentsNode)
    }

    if footerConfig.seen.enabled {
      let string = "\(footerConfig.seen.text) \(post.seen)"

      seenNode = ASTextNode()
      seenNode!.attributedString = NSAttributedString(
        string: string,
        attributes: footerConfig.seen.textAttributes)
      seenNode!.userInteractionEnabled = true

      addSubnode(seenNode)
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
      x += size.width + footerConfig.horizontalPadding
    }

    if let commentsNode = commentsNode {
      let size = commentsNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: height))

      commentsNode.frame = CGRect(
        origin: CGPoint(x: x, y: centerY(size.height)),
        size: size)
      x += size.width + footerConfig.horizontalPadding
    }

    if let seenNode = seenNode {
      let size = seenNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: height))

      seenNode.frame = CGRect(
        origin: CGPoint(x: width - size.width, y: centerY(size.height)),
        size: size)
    }
  }

  // MARK: - Private Methods

  func centerY(height: CGFloat) -> CGFloat {
    return (self.height - height) / 2
  }
}
