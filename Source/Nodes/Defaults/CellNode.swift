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

    let node = HeaderClass(post: self.post, width: self.contentWidth)
    node.userInteractionEnabled = true

    return node
    }()

  public lazy var attachmentGridNode: PostComponentNode = { [unowned self] in
    var AttachmentGridClass: PostComponentNode.Type = AttachmentGridNode.self
    if let ConfigClass = self.config?.post.AttachmentGridClass {
      AttachmentGridClass = ConfigClass
    }

    let node = AttachmentGridClass(
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

    return node
    }()

  public lazy var footerNode: PostComponentNode = { [unowned self] in
    var FooterClass: PostComponentNode.Type = HeaderNode.self
    if let ConfigClass = self.config?.post.FooterClass {
      FooterClass = ConfigClass
    }

    let node = FooterClass(post: self.post, width: self.contentWidth)
    node.userInteractionEnabled = true

    return node
    }()

  public lazy var actionBarNode: PostComponentNode = { [unowned self] in
    var ActionBarClass: PostComponentNode.Type = HeaderNode.self
    if let ConfigClass = self.config?.post.ActionBarClass {
      ActionBarClass = ConfigClass
    }

    let node = ActionBarClass(post: self.post, width: self.contentWidth)
    return node
    }()

  public lazy var divider: ASDisplayNode = {
    let divider = ASDisplayNode()
    divider.backgroundColor = .lightGrayColor()

    return divider
    }()

  var actionNodes: [TappedNode] = []

  // MARK: - ConfigurableNode

  public override func configureNode() {
    backgroundColor = .whiteColor()

    [headerNode, footerNode, actionBarNode, divider].map {
      self.addSubnode($0)
    }

    [headerNode, footerNode, actionBarNode].map {
      $0.actionNodes.map {
        self.actionNodes.append($0)
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

    actionNodes.map { $0.node.addTarget(self,
      action: "tapAction:",
      forControlEvents: ASControlNodeEvent.TouchUpInside) }
  }

  // MARK: - Actions

  func tapAction(sender: ASControlNode) {
    if let delegate = delegate {
      var tappedElement = actionNodes.filter({ sender.isEqual($0.node) }).first?.element
      if let tappedElement = tappedElement {
        delegate.cellNodeElementWasTapped(tappedElement, index: index)
      }
    }
  }

  // MARK: - Layout

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    var height: CGFloat = headerNode.height + footerNode.height + actionBarNode.height + dividerHeight
    var paddingCount = 2

    if hasAttachments {
      height += attachmentGridNode.height
      paddingCount++
    }

    if hasText {
      let size = textNode.measure(
        CGSize(
          width: contentWidth,
          height: CGFloat(FLT_MAX)))
      height += size.height
      paddingCount++
    }

    height += CGFloat(paddingCount) * verticalPadding

    return CGSizeMake(width, height)
  }

  override public func layout() {
    var y = verticalPadding

    headerNode.frame = CGRect(
      x: horizontalPadding,
      y: y,
      width: headerNode.width,
      height: headerNode.height)
    y += headerNode.height + verticalPadding

    if hasAttachments {
      attachmentGridNode.frame = CGRect(
        x: attachmentGridNode.width < width ? horizontalPadding : 0,
        y: y,
        width: attachmentGridNode.width,
        height: attachmentGridNode.height)

      y += attachmentGridNode.height + verticalPadding
    }

    if hasText {
      let size = textNode.calculatedSize
      textNode.frame = CGRect(
        origin: CGPoint(x: horizontalPadding, y: y),
        size: size)

      y += size.height + verticalPadding
    }

    footerNode.frame = CGRect(
      x: horizontalPadding,
      y: y,
      width: footerNode.width,
      height: footerNode.height)
    y += footerNode.height

    actionBarNode.frame = CGRect(
      x: horizontalPadding,
      y: y,
      width: contentWidth,
      height: actionBarNode.height)
    y += actionBarNode.height

    divider.frame = CGRect(
      x: horizontalPadding,
      y: y,
      width: contentWidth,
      height: dividerHeight)
  }
}
