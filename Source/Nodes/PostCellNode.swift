import UIKit
import AsyncDisplayKit

public class PostCellNode: ASCellNode {

  public let width: CGFloat
  public var delegate: PostCellNodeDelegate?
  public var post: Post
  public var config: Config?

  var headerNode: PostHeaderNode?
  var titleNode: ASTextNode?
  var attachmentGridNode: AttachmentGridNode?
  var textNode: ASTextNode?
  var footerNode: PostFooterNode?
  var actionBarNode: PostActionBarNode?
  var divider: ASDisplayNode?

  var contentWidth: CGFloat {
    var contentWidth = width
    if let config = delegate?.config {
      contentWidth = width - 2 * config.wall.padding
    }
    return contentWidth
  }

  // MARK: - Initialization

  public init(post: Post, width: CGFloat, _ delegate: AnyObject? = nil) {
    self.post = post
    self.width = width
    self.delegate = delegate as? PostCellNodeDelegate
    self.config = self.delegate?.config

    super.init()

    if let config = config {
      let postConfig = config.wall.post

      self.backgroundColor = postConfig.backgroundColor

      if postConfig.header.enabled {
        headerNode = PostHeaderNode(config: config, post: post, width: contentWidth)
        headerNode!.userInteractionEnabled = true

        addSubnode(headerNode)
      }

      if postConfig.title.enabled {
        if let title = post.title {
          titleNode = ASTextNode()
          titleNode!.attributedString = NSAttributedString(
            string: title,
            attributes: config.wall.post.title.textAttributes)
          titleNode!.userInteractionEnabled = true

          addSubnode(titleNode)
        }
      }

      if let attachments = post.attachments where attachments.count > 0 {
        attachmentGridNode = AttachmentGridNode(
          config: config,
          attachments: attachments,
          width: contentWidth)
        attachmentGridNode!.userInteractionEnabled = true

        addSubnode(attachmentGridNode)
      }

      if let text = post.text {
        textNode = ASTextNode()
        textNode!.attributedString = NSAttributedString(
          string: text,
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
    var padding: CGFloat = 0
    var dividerHeight: CGFloat = 0

    if let config = config {
      padding = config.wall.padding
      dividerHeight = config.wall.post.divider.height
    }

    if let headerNode = headerNode {
      height += headerNode.height
    }

    if let titleNode = titleNode {
      let size = titleNode.measure(CGSize(
        width: contentWidth,
        height: CGFloat(FLT_MAX)))
      height += size.height + padding
    }

    if let attachmentGridNode = attachmentGridNode {
      height += attachmentGridNode.height + 2 * padding
    }

    if let textNode = textNode {
      let size = textNode.measure(CGSize(
        width: contentWidth,
        height: CGFloat(FLT_MAX)))
      height += size.height + padding
    }

    if let footerNode = footerNode {
      height += footerNode.height
    } else {
      height += padding
    }

    if let actionBarNode = actionBarNode {
      height += actionBarNode.height
    }

    if let divider = divider {
      height += dividerHeight
    }

    return CGSizeMake(width, height)
  }

  override public func layout() {
    var padding: CGFloat = 0
    var dividerHeight: CGFloat = 0

    if let config = config {
      padding = config.wall.padding
      dividerHeight = config.wall.post.divider.height
    }

    var y = padding

    if let headerNode = headerNode {
      headerNode.frame = CGRect(
        x: padding,
        y: y,
        width: headerNode.width,
        height: headerNode.height)
      y += headerNode.height
    }

    if let titleNode = titleNode {
      let size = titleNode.calculatedSize
      titleNode.frame = CGRect(
        origin: CGPoint(x: padding, y: y),
        size: CGSize(width: contentWidth, height: size.height))

      y += size.height
    }

    if let attachmentGridNode = attachmentGridNode {
      attachmentGridNode.frame = CGRect(
        x: padding,
        y: y + padding,
        width: attachmentGridNode.width,
        height: attachmentGridNode.height)

      y += attachmentGridNode.height + padding * 2
    }

    if let textNode = textNode {
      let size = textNode.calculatedSize
      textNode.frame = CGRect(
        origin: CGPoint(x: padding, y: y),
        size: size)

      y += size.height
    }

    if let footerNode = footerNode {
      footerNode.frame = CGRect(
        x: padding,
        y: y,
        width: footerNode.width,
        height: footerNode.height)
      y += footerNode.height
    } else {
      y += padding
    }

    if let actionBarNode = actionBarNode {
      actionBarNode.frame = CGRect(
        x: padding,
        y: y,
        width: contentWidth,
        height: actionBarNode.height)
      y += actionBarNode.height
    }

    if let divider = divider {
      divider.frame = CGRect(
        x: padding,
        y: y,
        width: contentWidth,
        height: dividerHeight)
    }
  }
}
