import UIKit
import AsyncDisplayKit

public class ActionBarNode: PostComponentNode {

  // MARK: - Configuration

  public var dividerHeight: CGFloat = 1

  public override var height: CGFloat {
    return 40
  }

  // MARK: - Nodes

  public lazy var likeControlNode: ControlNode = {
    var title = NSAttributedString(
      string: NSLocalizedString("Like", comment: ""),
      attributes: [
        NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
        NSForegroundColorAttributeName: UIColor.lightGrayColor()
      ])

    let node = ControlNode(title: title)
    node.userInteractionEnabled = true

    return node
    }()

  public lazy var commentControlNode: ControlNode = {
    var title = NSAttributedString(
      string: NSLocalizedString("Comment", comment: ""),
      attributes: [
        NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
        NSForegroundColorAttributeName: UIColor.lightGrayColor()
      ])

    let node = ControlNode(title: title)
    node.userInteractionEnabled = true

    return node
    }()

  public lazy var divider: ASDisplayNode = {
    let divider = ASDisplayNode()
    divider!.backgroundColor = .lightGrayColor()

    return divider
    }()

  public override var actionNodes: [TappedNode] {
    return [(node: likeControlNode, element: .LikeButton),
      (node: commentControlNode, element: .CommentButton)]
  }

  // MARK: - ConfigurableNode

  public override func configureNode() {

    for node in [divider, likeControlNode, commentControlNode] {
      addSubnode(node)
    }
  }

//   MARK: - Layout

  public override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {
    let likeSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50), child: likeControlNode)
    let commentSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0), child: commentControlNode)

    let spec = ASStackLayoutSpec(direction: .Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Stretch, children: [likeSpec, commentSpec])
    return spec
  }
}
