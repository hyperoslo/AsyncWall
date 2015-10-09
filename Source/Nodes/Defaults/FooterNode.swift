import UIKit
import AsyncDisplayKit

public class FooterNode: PostComponentNode {

  // MARK: - Configuration

  public var horizontalPadding: CGFloat = 10

  public override var height: CGFloat {
    return 40
  }

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
      + " \(self.post.seenCount)"

    node.attributedString = NSAttributedString(
      string: seenString,
      attributes: [
        NSFontAttributeName: UIFont.italicSystemFontOfSize(12),
        NSForegroundColorAttributeName: UIColor.grayColor()
      ])
    node.userInteractionEnabled = true

    return node
    }()

  public override var actionNodes: [TappedNode] {
    return [(node: likesNode, element: .Likes),
      (node: commentsNode, element: .Comments),
      (node: seenNode, element: .Seen)]
  }

  // MARK: - ConfigurableNode

  public override func configureNode() {
    for node in [likesNode, commentsNode, seenNode] {
      addSubnode(node)
    }
  }

  // MARK: - Layout


  public override func calculateLayoutThatFits(constrainedSize: ASSizeRange) -> ASLayout! {
    var x: CGFloat = 0
    let likeLayout = likesNode.calculateLayoutThatFits(constrainedSize)
    likeLayout.position = CGPoint(x: x, y: centerY(likeLayout.size.height))

    x += likeLayout.size.width + horizontalPadding

    let commentLayout = commentsNode.calculateLayoutThatFits(constrainedSize)
    commentLayout.position = CGPoint(x: x, y: centerY(commentLayout.size.height))

    x += commentLayout.size.width + horizontalPadding

    let seenLayout = seenNode.calculateLayoutThatFits(constrainedSize)
    seenLayout.position = CGPoint(x: constrainedSize.max.width - seenLayout.size.width, y: centerY(seenLayout.size.height))

    let size = CGSize(width: constrainedSize.max.width, height: height)
    let layout = ASLayout(layoutableObject: self, size: size, position: CGPoint.zero, sublayouts: [likeLayout, commentLayout, seenLayout])

    return layout
  }

  public func centerY(height: CGFloat) -> CGFloat {
    return (self.height - height) / 2
  }
}
