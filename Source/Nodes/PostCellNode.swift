import UIKit
import AsyncDisplayKit

public class PostCellNode: ASCellNode {

  let width: CGFloat
  var delegate: PostCellNodeDelegate?
  var post: Post

  var headerNode: PostHeaderNode?
  var attachmentGridNode: AttachmentGridNode?
  var textNode: ASTextNode?
  var likesNode: ASTextNode?
  var commentsNode: ASTextNode?
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
      attachmentGridNode!.addTarget(self,
        action: "tapAction:",
        forControlEvents: ASControlNodeEvent.TouchUpInside)

      addSubnode(attachmentGridNode)
    }

    if let text = post.text {
      textNode = ASTextNode()
      textNode!.attributedString = NSAttributedString(string: text,
        attributes: Config.Wall.Post.Text.textAttributes)
      textNode!.userInteractionEnabled = true
      textNode!.addTarget(self,
        action: "tapAction:",
        forControlEvents: ASControlNodeEvent.TouchUpInside)

      addSubnode(textNode)
    }

    if Config.Wall.Post.Divider.enabled {
      divider = ASDisplayNode()
      divider!.backgroundColor = PostConfig.Divider.backgroundColor
      addSubnode(divider)
    }
  }

  // MARK: - Actions

  func tapAction(sender: AnyObject) {
    if let delegate = delegate {
      if sender.isEqual(textNode) {
        delegate.cellNodeElementWasTapped(.Text, sender: self)
      } else if sender.isEqual(attachmentGridNode) {
        delegate.cellNodeElementWasTapped(.Attachment, sender: self)
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
      let textSize = textNode.measure(CGSize(width: contentWidth,
        height: CGFloat(FLT_MAX)))
      height += textSize.height + Config.Wall.padding
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

      y += size.height + padding
    }

    if let divider = divider {
      divider.frame = CGRect(x: padding, y: y,
        width: contentWidth, height: PostConfig.Divider.height)
    }
  }
}
