import UIKit
import AsyncDisplayKit

public class PostCellNode: ASCellNode {

  struct Dimensions {
    static let dividerHeight: CGFloat = 1
    static let headerAvatarPadding: CGFloat = 5
  }

  let width: CGFloat
  var delegate: PostCellNodeDelegate?
  var post: Post
  var hasHeader = false
  var hasFooter = false

  var authorNameNode: ASTextNode?
  var authorAvatarNode: ASImageNode?
  var dateNode: ASTextNode?
  var attachmentGridNode: AttachmentGridNode?
  var textNode: ASTextNode?
  var likesNode: ASTextNode?
  var commentsNode: ASTextNode?
  var divider: ASDisplayNode?

  var contentWidth: CGFloat {
    return width - 2 * Config.Wall.padding
  }

  public init(post: Post, width: CGFloat, _ delegate: AnyObject? = nil) {
    self.post = post
    self.width = width
    self.delegate = delegate as? PostCellNodeDelegate

    super.init()

    if let author = post.author {
      hasHeader = true
      authorNameNode = ASTextNode()
      authorNameNode!.attributedString = NSAttributedString(string: author.name,
        attributes: Config.Wall.TextAttributes.authorName)
      addSubnode(authorNameNode)

      if let avatar = author.avatar {
        authorAvatarNode = ASImageNode()
        authorAvatarNode?.backgroundColor = UIColor.grayColor()
        if Config.Wall.roundedAuthorImage {
          authorAvatarNode?.cornerRadius = Config.Wall.authorImageSize / 2
          authorAvatarNode?.clipsToBounds = true
        }
        authorAvatarNode?.fetchImage(Config.Wall.thumbnailForAttachment(attachment: avatar,
          size: CGSize(width: Config.Wall.authorImageSize, height: Config.Wall.authorImageSize)).url)
        addSubnode(authorAvatarNode)
      }
    }

    if Config.Wall.showDate {
      hasHeader = true
      dateNode = ASTextNode()
      dateNode!.attributedString = NSAttributedString(string: Config.Wall.stringFromPostDate(date: post.date),
        attributes: Config.Wall.TextAttributes.date)

      addSubnode(dateNode)
    }

    if let attachments = post.attachments {
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
        attributes: Config.Wall.TextAttributes.postText)
      textNode!.userInteractionEnabled = true
      textNode!.addTarget(self,
        action: "tapAction:",
        forControlEvents: ASControlNodeEvent.TouchUpInside)

      addSubnode(textNode)
    }

    if Config.Wall.useDivider {
      divider = ASDisplayNode()
      divider!.backgroundColor = .lightGrayColor()
      addSubnode(divider)
    }
  }

  func tapAction(sender: AnyObject) {
    if let delegate = delegate {
      if sender.isEqual(textNode) {
        delegate.cellNodeElementWasTapped(.Text, sender: self)
      } else if sender.isEqual(attachmentGridNode) {
        delegate.cellNodeElementWasTapped(.Attachment, sender: self)
      }
    }
  }

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    var height: CGFloat = 0.0

    if let authorNameNode = authorNameNode {
      authorNameNode.measure(CGSize(width: CGFloat(FLT_MAX),
        height: Config.Wall.headerHeight))
    }

    if let dateNode = dateNode {
      dateNode.measure(CGSize(width: CGFloat(FLT_MAX),
        height: Config.Wall.headerHeight))
    }

    if let attachmentGridNode = attachmentGridNode {
      height += attachmentGridNode.height + 2 * Config.Wall.padding
    }

    if let textNode = textNode {
      let textSize = textNode.measure(CGSize(width: contentWidth,
        height: CGFloat(FLT_MAX)))
      height += textSize.height + Config.Wall.padding
    }

    if Config.Wall.useDivider {
      height += Dimensions.dividerHeight
    }

    if hasHeader {
      height += Config.Wall.headerHeight
    }

    return CGSizeMake(width, height)
  }

  override public func layout() {
    let padding = Config.Wall.padding
    var y = padding

    var headerX = padding
    let headerY: (height: CGFloat) -> CGFloat = { (height: CGFloat) -> CGFloat in
      return (Config.Wall.headerHeight - height) / 2
    }

    if let authorAvatarNode = authorAvatarNode {
      authorAvatarNode.frame = CGRect(
        x: headerX,
        y: y + headerY(height: Config.Wall.authorImageSize),
        width: Config.Wall.authorImageSize,
        height: Config.Wall.authorImageSize)
      headerX += CGRectGetMaxX(authorAvatarNode.frame) + Dimensions.headerAvatarPadding
    }

    if let authorNameNode = authorNameNode {
      let size = authorNameNode.calculatedSize
      authorNameNode.frame = CGRect(
        origin: CGPoint(x: headerX, y: y + headerY(height: size.height)),
        size: size)
    }

    if let dateNode = dateNode {
      let size = dateNode.calculatedSize
      dateNode.frame = CGRect(
        origin: CGPoint(x: contentWidth - size.width, y: y + headerY(height: size.height)),
        size: size)
    }

    if hasHeader {
      y += Config.Wall.headerHeight
    }

    if let attachmentGridNode = attachmentGridNode {
      attachmentGridNode.frame = CGRect(
        x: Config.Wall.padding,
        y: y + Config.Wall.padding,
        width: attachmentGridNode.width,
        height: attachmentGridNode.height)

      y += attachmentGridNode.height + Config.Wall.padding * 2
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
        width: contentWidth, height: Dimensions.dividerHeight)
    }
  }
}
