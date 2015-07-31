import UIKit
import AsyncDisplayKit

public class PostCellNode: WallCellNode {

  // MARK: - Configuration
  public var horizontalPadding: CGFloat = 10
  public var verticalPadding: CGFloat = 10

  // MARK: - Nodes

  public var headerNode: PostHeaderNode?
  public var attachmentGridNode: AttachmentGridNode?
  public var textNode: ASTextNode?
  public var footerNode: PostFooterNode?
  public var actionBarNode: PostActionBarNode?
  public var divider: ASDisplayNode?

  public var contentWidth: CGFloat {
    var contentWidth = width
    if let config = delegate?.config {
      contentWidth = width - 2 * horizontalPadding
    }
    return contentWidth
  }

  // MARK: - Initialization

  public required init(post: Post, index: Int, width: CGFloat, delegate: PostCellNodeDelegate? = nil) {
    super.init(post: post, index: index, width: width, delegate: delegate)

    headerNode = PostHeaderNode(post: post, width: contentWidth)
    headerNode!.userInteractionEnabled = true
    addSubnode(headerNode)

    if post.attachments.count > 0 {
      var gridWidth = gridWidthForAttachmentCount(post.attachments.count)

      attachmentGridNode = AttachmentGridNode(
        attachments: post.attachments,
        width: gridWidth)
      attachmentGridNode!.userInteractionEnabled = true

      addSubnode(attachmentGridNode)
    }

    if let config = config {
      let postConfig = config.wall.post

      self.backgroundColor = .whiteColor()





      if !post.text.isEmpty {
        textNode = ASTextNode()
        textNode!.attributedString = NSAttributedString(
          string: post.text,
          attributes: config.wall.post.text.textAttributes)
        textNode!.userInteractionEnabled = true

        addSubnode(textNode)
      }

      if postConfig.footer.enabled {
        footerNode = PostFooterNode(config: config, post: post, width: contentWidth)
        footerNode!.userInteractionEnabled = true

        addSubnode(footerNode)
      }

      if config.wall.post.actionBar.enabled {
        actionBarNode = PostActionBarNode(config: config, width: contentWidth)
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

      if config.wall.post.divider.enabled {
        divider = ASDisplayNode()
        divider!.backgroundColor = postConfig.divider.backgroundColor
        addSubnode(divider)
      }
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
        delegate.cellNodeElementWasTapped(tappedElement, sender: self)
      }
    }
  }

  // MARK: - Layout

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    var height: CGFloat = 0

    if let config = config {
      var dividerHeight = config.wall.post.divider.height
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
    }

    return CGSizeMake(width, height)
  }

  override public func layout() {
    if let config = config {
      var dividerHeight = config.wall.post.divider.height

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
  }

  // MARK: - Helper Methods

  private func gridWidthForAttachmentCount(count: Int) -> CGFloat {
    var gridWidth = contentWidth

    if let config = config {
      let gridType = attachmentGridNode?.gridType

      if gridType == .FullWidth {
        gridWidth = width
      } else if gridType == .SingleFullWidth {
        gridWidth = count > 1 ? contentWidth : width
      }
    }

    return gridWidth
  }
}
