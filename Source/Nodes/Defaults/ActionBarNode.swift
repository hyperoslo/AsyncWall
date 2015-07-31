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
    [divider, likeControlNode, commentControlNode].map { self.addSubnode($0) }
  }

  // MARK: - Layout

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    return CGSizeMake(width, height)
  }

  override public func layout() {
    var x: CGFloat = 0
    let sideSize = CGSize(width: width / 2, height: height)

    divider.frame = CGRect(
      x: 0,
      y: 0,
      width: width,
      height: dividerHeight)

    if !likeControlNode.hidden {
      likeControlNode.frame = CGRect(
        origin: likeControlNode.size.centerInSize(sideSize),
        size: likeControlNode.size)

      x += sideSize.width
    }

    if !commentControlNode.hidden {
      var origin = commentControlNode.size.centerInSize(sideSize)
      origin.x += x
      commentControlNode.frame = CGRect(
        origin: origin,
        size: commentControlNode.size)
    }
  }
}
