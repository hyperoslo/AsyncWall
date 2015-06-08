import UIKit
import AsyncDisplayKit

public class PostFooterNode: ASCellNode {

  let width: CGFloat

  var likesNode: ASTextNode?
  var commentsNode: ASTextNode?
  var seenCountNode: ASTextNode?

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
      let string = "\(post.likes) " +
        Config.pluralForSingular("like", count: post.likes)

      likesNode = ASTextNode()
      likesNode!.attributedString = NSAttributedString(
        string: "\(post.likes)",
        attributes: FooterConfig.Likes.textAttributes)
      likesNode!.userInteractionEnabled = true

      addSubnode(likesNode)
    }

    if FooterConfig.Comments.enabled {
      let string = "\(post.comments.count) " +
        Config.pluralForSingular("comment", count: post.comments.count)

      commentsNode = ASTextNode()
      commentsNode!.attributedString = NSAttributedString(
        string: string,
        attributes: FooterConfig.Comments.textAttributes)
      commentsNode!.userInteractionEnabled = true

      addSubnode(commentsNode)
    }

    if FooterConfig.SeenCount.enabled {
      let string = "\(FooterConfig.SeenCount.text) \(post.seenCount)"

      seenCountNode = ASTextNode()
      seenCountNode!.attributedString = NSAttributedString(
        string: string,
        attributes: FooterConfig.SeenCount.textAttributes)
      seenCountNode!.userInteractionEnabled = true

      addSubnode(seenCountNode)
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

    if let commentsNode = commentsNode {
      let size = commentsNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: height))

      commentsNode.frame = CGRect(
        origin: CGPoint(x: x, y: centerY(size.height)),
        size: size)
      x += size.width + FooterConfig.horizontalPadding
    }

    if let seenCountNode = seenCountNode {
      let size = seenCountNode.measure(
        CGSize(
          width: width - x,
          height: height))

      seenCountNode.frame = CGRect(
        origin: CGPoint(x: width - size.width, y: centerY(size.height)),
        size: size)
    }
  }

  // MARK: - Private Methods

  func centerY(height: CGFloat) -> CGFloat {
    return (self.height - height) / 2
  }
}
