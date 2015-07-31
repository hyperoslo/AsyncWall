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
    return post.text.isEmpty
  }

  // MARK: - Nodes

  public lazy var headerNode: HeaderNode = { [unowned self] in
    let node = HeaderNode(post: self.post, width: self.contentWidth)
    node.userInteractionEnabled = true

    return node
  }()

  public lazy var attachmentGridNode: AttachmentGridNode = { [unowned self] in
    var gridWidth = self.gridWidthForAttachmentCount(self.post.attachments.count)

    let node = AttachmentGridNode(
      post: self.post,
      width: gridWidth)
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

  public lazy var footerNode: FooterNode = { [unowned self] in
    let node = FooterNode(post: self.post, width: self.contentWidth)
    node.userInteractionEnabled = true

    return node
  }()

  public lazy var actionBarNode: ActionBarNode = { [unowned self] in
    let node = ActionBarNode(post: self.post, width: self.contentWidth)
    return node
  }()

  public lazy var divider: ASDisplayNode = { [unowned self] in
    let divider = ASDisplayNode()
    divider.backgroundColor = .lightGrayColor()

    return divider
  }()

  // MARK: - ConfigurableNode

  public override func configureNode() {
    backgroundColor = .whiteColor()

    var actionNodes = [ASControlNode?]()

    [headerNode, footerNode, actionBarNode, divider].map {
      self.addSubnode($0)
    }

    [headerNode.authorNameNode, headerNode.authorAvatarNode, headerNode.dateNode,
      footerNode.likesNode, footerNode.commentsNode, footerNode.seenNode,
      actionBarNode.likeControlNode, actionBarNode.commentControlNode].map {
        actionNodes.append($0)
    }

    if hasAttachments {
      addSubnode(attachmentGridNode)
      actionNodes.append(attachmentGridNode)
    }

    if hasText {
      addSubnode(textNode)
      actionNodes.append(textNode)
    }

    for actionNode in actionNodes {
      actionNode?.addTarget(self,
        action: "tapAction:",
        forControlEvents: ASControlNodeEvent.TouchUpInside)
    }
  }

  // MARK: - Actions

  func tapAction(sender: ASDisplayNode) {
    if let delegate = delegate {
      var tappedElement: TappedElement?

      if sender.isEqual(headerNode.authorNameNode)
        || sender.isEqual(headerNode.authorAvatarNode) {
          tappedElement = .Author
      } else if sender.isEqual(headerNode.dateNode) {
        tappedElement = .Date
      } else if sender.isEqual(attachmentGridNode) {
        tappedElement = .Attachment
      } else if sender.isEqual(textNode) {
        tappedElement = .Text
      } else if sender.isEqual(footerNode.likesNode) {
        tappedElement = .Likes
      } else if sender.isEqual(footerNode.commentsNode) {
        tappedElement = .Comments
      } else if sender.isEqual(footerNode.seenNode) {
        tappedElement = .Seen
      } else if sender.isEqual(actionBarNode.likeControlNode) {
        tappedElement = .LikeButton
      } else if sender.isEqual(actionBarNode.commentControlNode) {
        tappedElement = .CommentButton
      }

      if let tappedElement = tappedElement {
        delegate.cellNodeElementWasTapped(tappedElement, index: index)
      }
    }
  }

  // MARK: - Layout

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    var height: CGFloat = 0
    var paddingCount = 0

    height += headerNode.height + footerNode.height + actionBarNode.height + dividerHeight
    paddingCount++

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

  // MARK: - Helper Methods

  private func gridWidthForAttachmentCount(count: Int) -> CGFloat {
    var gridWidth = contentWidth

    let gridType = attachmentGridNode.gridType

    if gridType == .FullWidth {
      gridWidth = width
    } else if gridType == .SingleFullWidth {
      gridWidth = count > 1 ? contentWidth : width
    }

    return gridWidth
  }
}
