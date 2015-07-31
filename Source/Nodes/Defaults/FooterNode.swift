import UIKit
import AsyncDisplayKit

public class FooterNode: PostComponentNode {

  // MARK: - Configuration

  public var height: CGFloat = 40
  public var horizontalPadding: CGFloat = 10

  // MARK: - Nodes

  public lazy var likesNode: ASTextNode = { [unowned self] in
    let node = ASTextNode()
    let likeCountString = String.localizedStringWithFormat(
      NSLocalizedString("%d like(s)", comment: ""),
      self.post.likeCount)

    node.attributedString = NSAttributedString(
      string: likeCountString,
      attributes: [
        NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
        NSForegroundColorAttributeName: UIColor.blackColor()
      ])
    node.userInteractionEnabled = true

    return node
  }()

  public lazy var commentsNode: ASTextNode = { [unowned self] in
    let node = ASTextNode()
    let commentCountString = String.localizedStringWithFormat(
      NSLocalizedString("%d comment(s)", comment: ""),
      self.post.commentCount)

    node.attributedString = NSAttributedString(
      string: commentCountString,
      attributes: [
        NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
        NSForegroundColorAttributeName: UIColor.blackColor()
      ])
    node.userInteractionEnabled = true

    return node
  }()

  public lazy var seenNode: ASTextNode = { [unowned self] in
    let node = ASTextNode()
    let seenString = NSLocalizedString("Seen by", comment: "")
      + "\(self.post.seenCount)"

    node.attributedString = NSAttributedString(
      string: seenString,
      attributes: [
        NSFontAttributeName: UIFont.italicSystemFontOfSize(12),
        NSForegroundColorAttributeName: UIColor.grayColor()
      ])
    node.userInteractionEnabled = true

    return node
  }()

  // MARK: - ConfigurableNode

  public override func configureNode() {
    [likesNode, commentsNode, seenNode].map { self.addSubnode($0) }
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
