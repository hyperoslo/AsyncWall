import UIKit
import AsyncDisplayKit

public class ControlNode: ASControlNode {

  // MARK: - Nodes

  public var titleNode: ASTextNode?
  public var imageNode: ASImageNode?
  public var nodes: [ASDisplayNode] = [ASDisplayNode]()

  // MARK: - Initialization

  public init(title: NSAttributedString?, image: UIImage? = nil) {
    super.init()

    if let title = title {
      titleNode = ASTextNode()
      titleNode!.attributedString = title
      nodes.append(titleNode!)
    }

    if let image = image {
      imageNode = ASImageNode()
      imageNode?.image = image
      nodes.append(imageNode!)
    }
    for node in nodes {
      addSubnode(node)
    }
  }

  // MARK: - Layout

  public override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {
    return ASStackLayoutSpec(direction: .Horizontal,
      spacing: 10, justifyContent: .Center,
      alignItems: .Center,
      children: nodes)
  }
}
