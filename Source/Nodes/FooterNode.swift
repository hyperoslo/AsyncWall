import UIKit
import AsyncDisplayKit

public class FooterNode: PostComponentNode {

  // MARK: - Configuration

  public var height: CGFloat = 40
  public var horizontalPadding: CGFloat = 10

  // MARK: - Nodes

  public lazy var likesNode = ASTextNode()
  public var commentsNode = ASTextNode()
  public var seenNode = ASTextNode()

  // MARK: - Initialization

  public required init(post: Post, width: CGFloat) {
    super.init(post: post, width: width)

    let likeCountString = String.localizedStringWithFormat(
      NSLocalizedString("%d like(s)", comment: ""),
      post.likeCount)

    likesNode = ASTextNode()
    likesNode.attributedString = NSAttributedString(
      string: likeCountString,
      attributes: [
        NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
        NSForegroundColorAttributeName: UIColor.blackColor()
      ])
    likesNode.userInteractionEnabled = true

    addSubnode(likesNode)

    let commentCountString = String.localizedStringWithFormat(
      NSLocalizedString("%d comment(s)", comment: ""),
      post.commentCount)

    commentsNode = ASTextNode()
    commentsNode.attributedString = NSAttributedString(
      string: commentCountString,
      attributes: [
        NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
        NSForegroundColorAttributeName: UIColor.blackColor()
      ])
    commentsNode.userInteractionEnabled = true

    addSubnode(commentsNode)

    let seenString = NSLocalizedString("Seen by", comment: "")
      + "\(post.seenCount)"

    seenNode = ASTextNode()
    seenNode.attributedString = NSAttributedString(
      string: seenString,
      attributes: [
        NSFontAttributeName: UIFont.italicSystemFontOfSize(12),
        NSForegroundColorAttributeName: UIColor.grayColor()
      ])
    seenNode.userInteractionEnabled = true

    addSubnode(seenNode)
  }

  // MARK: - Layout

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    return CGSizeMake(width, height)
  }

  override public func layout() {
    var x: CGFloat = 0

    if !likesNode.hidden {
      let size = likesNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: height))

      likesNode.frame = CGRect(
        origin: CGPoint(x: x, y: centerY(size.height)),
        size: size)
      x += size.width + horizontalPadding
    }

    if !commentsNode.hidden {
      let size = commentsNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: height))

      commentsNode.frame = CGRect(
        origin: CGPoint(x: x, y: centerY(size.height)),
        size: size)
      x += size.width + horizontalPadding
    }

    if !seenNode.hidden {
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
