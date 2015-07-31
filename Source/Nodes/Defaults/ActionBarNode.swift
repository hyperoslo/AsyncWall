import UIKit
import AsyncDisplayKit

public class ActionBarNode: PostComponentNode {

  // MARK: - Configuration

  public var height: CGFloat = 40
  public var dividerHeight: CGFloat = 1

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
