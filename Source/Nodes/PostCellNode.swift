import UIKit
import AsyncDisplayKit

public class PostCellNode: ASCellNode {

  let width: CGFloat
  var delegate: PostCellNodeDelegate?
  var post: Post

  var headerNode: PostHeaderNode?
  var attachmentGridNode: AttachmentGridNode?
  var textNode: ASTextNode?
  var footerNode: PostFooterNode?
  var actionBarNode: PostActionBarNode?
  var divider: ASDisplayNode?

  var contentWidth: CGFloat {
    return width - 2 * Config.Wall.padding
  }

  private var PostConfig: Config.Wall.Post.Type {
    return Config.Wall.Post.self
  }

  // MARK: - Initialization

  public init(post: Post, width: CGFloat, _ delegate: AnyObject? = nil) {
    self.post = post
    self.width = width
    self.delegate = delegate as? PostCellNodeDelegate

    super.init()

    self.backgroundColor = PostConfig.backgroundColor

    if PostConfig.Header.enabled {
      headerNode = PostHeaderNode(post: post, width: contentWidth)
      headerNode!.userInteractionEnabled = true

      addSubnode(headerNode)
    }

    if let attachments = post.attachments where attachments.count > 0 {
      attachmentGridNode = AttachmentGridNode(attachments: attachments, width: contentWidth)
      attachmentGridNode!.userInteractionEnabled = true

      addSubnode(attachmentGridNode)
    }

    if let text = post.text {
      textNode = ASTextNode()
      textNode!.attributedString = NSAttributedString(string: text,
        attributes: Config.Wall.Post.Text.textAttributes)
      textNode!.userInteractionEnabled = true

      addSubnode(textNode)
    }

    if PostConfig.Footer.enabled {
      footerNode = PostFooterNode(post: post, width: contentWidth)
      footerNode!.userInteractionEnabled = true

      addSubnode(footerNode)
    }

    if Config.Wall.Post.ActionBar.enabled {
      actionBarNode = PostActionBarNode(width: contentWidth)
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

    if Config.Wall.Post.Divider.enabled {
      divider = ASDisplayNode()
      divider!.backgroundColor = PostConfig.Divider.backgroundColor
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
        delegate.cellNodeElementWasTapped(tappedElement, sender: self)
      }
    }
  }

  // MARK: - Layout

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    var height: CGFloat = 0.0

    if let headerNode = headerNode {
      height += headerNode.height
    }

    if let attachmentGridNode = attachmentGridNode {
      height += attachmentGridNode.height + 2 * Config.Wall.padding
    }

    if let textNode = textNode {
      let textSize = textNode.measure(CGSize(
        width: contentWidth,
        height: CGFloat(FLT_MAX)))
      height += textSize.height + Config.Wall.padding
    }

    if let footerNode = footerNode {
      height += footerNode.height
    } else {
      height += Config.Wall.padding
    }

    if let actionBarNode = actionBarNode {
      height += PostConfig.ActionBar.height
    }

    if PostConfig.Divider.enabled {
      height += PostConfig.Divider.height
    }

    return CGSizeMake(width, height)
  }

  override public func layout() {
    let padding = Config.Wall.padding
    var y = padding

    if let headerNode = headerNode {
      headerNode.frame = CGRect(
        x: padding,
        y: y,
        width: headerNode.width,
        height: headerNode.height)
      y += headerNode.height
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
        height: PostConfig.Divider.height)
    }
  }
}
