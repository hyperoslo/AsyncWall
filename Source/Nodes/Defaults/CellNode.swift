import UIKit
import AsyncDisplayKit

public class CellNode: PostCellNode {

  // MARK: - Configuration
  
  public var horizontalPadding: CGFloat = 10
  public var verticalPadding: CGFloat = 10
  public var dividerHeight: CGFloat = 1

  public var contentWidth: CGFloat {
    return width - 2 * horizontalPadding
  }

  public var hasAttachments: Bool {
    return post.attachments.count > 0
  }

  public var hasText: Bool {
    return !post.text.isEmpty
  }

  // MARK: - Nodes

  public lazy var headerNode: PostComponentNode = { [unowned self] in
    var HeaderClass: PostComponentNode.Type = HeaderNode.self
    if let ConfigClass = self.config?.post.HeaderClass {
      HeaderClass = ConfigClass
    }

    let node = HeaderClass.init(post: self.post, width: self.contentWidth)
    node.userInteractionEnabled = true

    return node
    }()

  public lazy var attachmentGridNode: PostComponentNode = { [unowned self] in
    var AttachmentGridClass: PostComponentNode.Type = AttachmentGridNode.self
    if let ConfigClass = self.config?.post.AttachmentGridClass {
      AttachmentGridClass = ConfigClass
    }

    let node = AttachmentGridClass.init(
      post: self.post,
      width: self.contentWidth)
    node.userInteractionEnabled = true

    return node
    }()

  public lazy var textNode: ASTextNode = { [unowned self] in
    let node = ASTextNode()

    node.attributedString = NSAttributedString(
      string: self.post.text,
      attributes: [
        NSFontAttributeName: UIFont.systemFontOfSize(14),
        NSForegroundColorAttributeName: UIColor.grayColor()
      ])
    node.userInteractionEnabled = true
    node.alignSelf = .Start

    return node
    }()

  public lazy var footerNode: PostComponentNode = { [unowned self] in
    var FooterClass: PostComponentNode.Type = HeaderNode.self
    if let ConfigClass = self.config?.post.FooterClass {
      FooterClass = ConfigClass
    }

    let node = FooterClass.init(post: self.post, width: self.contentWidth)
    node.userInteractionEnabled = true

    return node
    }()

  public lazy var actionBarNode: PostComponentNode = { [unowned self] in
    var ActionBarClass: PostComponentNode.Type = HeaderNode.self
    if let ConfigClass = self.config?.post.ActionBarClass {
      ActionBarClass = ConfigClass
    }

    let node = ActionBarClass.init(post: self.post, width: self.contentWidth)
    node.preferredFrameSize = CGSize(width: self.contentWidth, height: 40)

    return node
    }()

  public lazy var divider: ASDisplayNode = {
    let divider = ASDisplayNode()
    divider.backgroundColor = .lightGrayColor()
    divider.layerBacked = true

    return divider
    }()

  public var actionNodes: [TappedNode] = []

  // MARK: - ConfigurableNode

  public override func configureNode() {
    backgroundColor = .whiteColor()

    for node in [headerNode, footerNode, actionBarNode, divider] {
      addSubnode(node)
    }


    for node in [headerNode, footerNode, actionBarNode] {
      for actionNode in node.actionNodes {
        self.actionNodes.append(actionNode)
      }
    }

    if hasAttachments {
      addSubnode(attachmentGridNode)
      let tappedNode: TappedNode = (node: attachmentGridNode,
        element: TappedElement.Attachment)
      actionNodes.append(tappedNode)
    }

    if hasText {
      addSubnode(textNode)
      actionNodes.append((node: textNode, element: TappedElement.Text))
    }

    for actionNode in actionNodes {
      actionNode.node.addTarget(self,
        action: "tapAction:",
        forControlEvents: ASControlNodeEvent.TouchUpInside)
    }
  }

  // MARK: - Actions

  func tapAction(sender: ASControlNode) {
    if let delegate = delegate {
      let tappedElement = actionNodes.filter({ sender.isEqual($0.node) }).first?.element
      if let tappedElement = tappedElement {
        delegate.cellNodeElementWasTapped(tappedElement, post: post)
      }
    }
  }

  //MARK: - Layout

  public override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {

    actionBarNode.flexGrow = true

    let actionBarSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0), child: actionBarNode)

    var nodes = [headerNode, attachmentGridNode, textNode, footerNode, divider, actionBarSpec]

    if !hasText {
      nodes.removeAtIndex(2)
    }

    if !hasAttachments {
      nodes.removeAtIndex(1)
    }

    let stack = ASStackLayoutSpec(direction: .Vertical,
      spacing: verticalPadding,
      justifyContent: .Center,
      alignItems: .Center,
      children: nodes)

    let insets = UIEdgeInsets(top: verticalPadding,
      left: horizontalPadding,
      bottom: 0,
      right: horizontalPadding)

    let insetSpec = ASInsetLayoutSpec(insets: insets,
      child: stack)
    insetSpec.measureWithSizeRange(constrainedSize)
    
    return insetSpec
  }
}
