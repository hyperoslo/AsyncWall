import UIKit
import AsyncDisplayKit

public class CellNode: PostCellNode {

  // MARK: - Configuration
  
  public var horizontalPadding: CGFloat = 10
  public var verticalPadding: CGFloat = 10
  public var dividerHeight: CGFloat = 1

  public var footerEnabled = true
  public var actionBarEnabled = true
  public var dividerEnabled = true

  public var contentWidth: CGFloat {
    return width - 2 * horizontalPadding
  }

  // MARK: - Nodes

  public var headerNode: HeaderNode?
  public var attachmentGridNode: AttachmentGridNode?
  public var textNode: ASTextNode?
  public var footerNode: FooterNode?
  public var actionBarNode: ActionBarNode?
  public var divider: ASDisplayNode?

  // MARK: - Initialization

  public required init(post: Post, index: Int, width: CGFloat, delegate: PostCellNodeDelegate? = nil) {
    super.init(post: post, index: index, width: width, delegate: delegate)

    backgroundColor = .whiteColor()

    headerNode = HeaderNode(post: post, width: contentWidth)
    headerNode!.userInteractionEnabled = true
    addSubnode(headerNode)

    if post.attachments.count > 0 {
      var gridWidth = gridWidthForAttachmentCount(post.attachments.count)

      attachmentGridNode = AttachmentGridNode(
        post: post,
        width: gridWidth)
      attachmentGridNode!.userInteractionEnabled = true

      addSubnode(attachmentGridNode)
    }

    if !post.text.isEmpty {
      textNode = ASTextNode()
      textNode!.attributedString = NSAttributedString(
        string: post.text,
        attributes: [
          NSFontAttributeName: UIFont.systemFontOfSize(14),
          NSForegroundColorAttributeName: UIColor.grayColor()
        ])
      textNode!.userInteractionEnabled = true

      addSubnode(textNode)
    }

    if footerEnabled {
      footerNode = FooterNode(post: post, width: contentWidth)
      footerNode!.userInteractionEnabled = true

      addSubnode(footerNode)
    }

    if actionBarEnabled {
      actionBarNode = ActionBarNode(post: post, width: contentWidth)
      addSubnode(actionBarNode)
    }

    let actionNodes = [
      headerNode?.authorNameNode,
      headerNode?.authorAvatarNode,
      headerNode?.groupNode,
      headerNode?.dateNode,
      headerNode?.locationNode,
      attachmentGridNode,
      textNode,
      footerNode?.likesNode,
      footerNode?.commentsNode,
      footerNode?.seenNode,
      actionBarNode?.likeControlNode,
      actionBarNode?.commentControlNode
    ]

    for actionNode in actionNodes {
      actionNode?.addTarget(self,
        action: "tapAction:",
        forControlEvents: ASControlNodeEvent.TouchUpInside)
    }

    if dividerEnabled {
      divider = ASDisplayNode()
      divider!.backgroundColor = .lightGrayColor()
      addSubnode(divider)
    }
  }

  // MARK: - Actions

  func tapAction(sender: ASDisplayNode) {
    if let delegate = delegate {
      var tappedElement: TappedElement?

      if sender.isEqual(headerNode?.authorNameNode)
        || sender.isEqual(headerNode?.authorAvatarNode) {
          tappedElement = .Author
      } else if sender.isEqual(headerNode?.groupNode) {
        tappedElement = .Group
      } else if sender.isEqual(headerNode?.dateNode) {
        tappedElement = .Date
      } else if sender.isEqual(headerNode?.locationNode) {
        tappedElement = .Location
      } else if sender.isEqual(attachmentGridNode) {
        tappedElement = .Attachment
      } else if sender.isEqual(textNode) {
        tappedElement = .Text
      } else if sender.isEqual(footerNode?.likesNode) {
        tappedElement = .Likes
      } else if sender.isEqual(footerNode?.commentsNode) {
        tappedElement = .Comments
      } else if sender.isEqual(footerNode?.seenNode) {
        tappedElement = .Seen
      } else if sender.isEqual(actionBarNode?.likeControlNode) {
        tappedElement = .LikeButton
      } else if sender.isEqual(actionBarNode?.commentControlNode) {
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

    if let headerNode = headerNode {
      height += headerNode.height
      paddingCount++
    }

    if let attachmentGridNode = attachmentGridNode {
      height += attachmentGridNode.height
      paddingCount++
    }

    if let textNode = textNode {
      let size = textNode.measure(CGSize(
        width: contentWidth,
        height: CGFloat(FLT_MAX)))
      height += size.height
      paddingCount++
    }

    if let footerNode = footerNode {
      height += footerNode.height
    } else {
      paddingCount++
    }

    if let actionBarNode = actionBarNode {
      height += actionBarNode.height
    }

    if let divider = divider {
      height += dividerHeight
    }

    height += CGFloat(paddingCount) * verticalPadding

    return CGSizeMake(width, height)
  }

  override public func layout() {
    var y = verticalPadding

    if let headerNode = headerNode {
      headerNode.frame = CGRect(
        x: horizontalPadding,
        y: y,
        width: headerNode.width,
        height: headerNode.height)
      y += headerNode.height + verticalPadding
    }

    if let attachmentGridNode = attachmentGridNode {
      attachmentGridNode.frame = CGRect(
        x: attachmentGridNode.width < width ? horizontalPadding : 0,
        y: y,
        width: attachmentGridNode.width,
        height: attachmentGridNode.height)

      y += attachmentGridNode.height + verticalPadding
    }

    if let textNode = textNode {
      let size = textNode.calculatedSize
      textNode.frame = CGRect(
        origin: CGPoint(x: horizontalPadding, y: y),
        size: size)

      y += size.height + verticalPadding
    }

    if let footerNode = footerNode {
      footerNode.frame = CGRect(
        x: horizontalPadding,
        y: y,
        width: footerNode.width,
        height: footerNode.height)
      y += footerNode.height
    } else {
      y += verticalPadding
    }

    if let actionBarNode = actionBarNode {
      actionBarNode.frame = CGRect(
        x: horizontalPadding,
        y: y,
        width: contentWidth,
        height: actionBarNode.height)
      y += actionBarNode.height
    }

    if let divider = divider {
      divider.frame = CGRect(
        x: horizontalPadding,
        y: y,
        width: contentWidth,
        height: dividerHeight)
    }
  }

  // MARK: - Helper Methods

  private func gridWidthForAttachmentCount(count: Int) -> CGFloat {
    var gridWidth = contentWidth

    let gridType = attachmentGridNode?.gridType

    if gridType == .FullWidth {
      gridWidth = width
    } else if gridType == .SingleFullWidth {
      gridWidth = count > 1 ? contentWidth : width
    }

    return gridWidth
  }
}
