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

  public override func calculateLayoutThatFits(constrainedSize: ASSizeRange) -> ASLayout! {
    let size = CGSize(width: constrainedSize.max.width, height: height)
    let dividerSize = CGSize(width: size.width, height: dividerHeight)
    let subnodeSize = CGSize(width: size.width / 2, height: height)

    let likeOrigin = likeControlNode.size.centerInSize(subnodeSize)
    let commentOrigin = CGPoint(x: likeOrigin.x + subnodeSize.width, y: likeOrigin.y)

    let dividerLayout = ASLayout(layoutableObject: divider, size: dividerSize, position: CGPoint.zero, sublayouts: nil)
    let like = ASLayout(layoutableObject: likeControlNode, size: subnodeSize, position: likeOrigin, sublayouts: nil)
    let comment = ASLayout(layoutableObject: commentControlNode, size: subnodeSize, position: commentOrigin, sublayouts: nil)

    let layout = ASLayout(layoutableObject: self, size: size, sublayouts: [like, comment, dividerLayout])

    return layout
  }
}
