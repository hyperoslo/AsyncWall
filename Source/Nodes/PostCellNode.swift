import UIKit
import AsyncDisplayKit
import DateTools

public class PostCellNode: ASCellNode {

  struct Dimensions {
    static let dividerHeight: CGFloat = 1
  }

  let width: CGFloat
  var delegate: PostCellNodeDelegate?
  var post: Post
  var hasHeader = false
  var hasFooter = false

  var authorNameNode: ASTextNode?
  var authorAvatarNode: ASImageNode?
  var dateNode: ASTextNode?
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
        authorAvatarNode?.fetchImage(Config.Wall.thumbnailForAttachment(attachment: avatar,
          size: CGSize(width: Config.Wall.authorImageSize, height: Config.Wall.authorImageSize)).url)
        addSubnode(authorAvatarNode)
      }
    }

    if Config.Wall.showDate {
      hasHeader = true
      dateNode = ASTextNode()
      dateNode!.attributedString = NSAttributedString(string: post.date.timeAgoSinceNow(),
        attributes: Config.Wall.TextAttributes.date)
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
      }
    }
  }

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    var height = Config.Wall.padding * 2

    if let authorNameNode = authorNameNode {
      authorNameNode.measure(CGSize(width: CGFloat(FLT_MAX),
        height: Config.Wall.headerHeight))
    }
    if let dateNode = dateNode {
      dateNode.measure(CGSize(width: CGFloat(FLT_MAX),
        height: Config.Wall.headerHeight))
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
    if let authorAvatarNode = authorAvatarNode {
      authorAvatarNode.frame = CGRect(x: headerX, y: y,
        width: Config.Wall.authorImageSize, height: Config.Wall.authorImageSize)
      headerX += CGRectGetMaxX(authorAvatarNode.frame) + Config.Wall.padding
    }

    if let authorNameNode = authorNameNode {
      let size = authorNameNode.calculatedSize
      authorNameNode.frame = CGRect(
        origin: CGPoint(x: headerX, y: y),
        size: size)
    }

    if let dateNode = dateNode {
      let size = dateNode.calculatedSize
      dateNode.frame = CGRect(
        origin: CGPoint(x: contentWidth - size.width, y: y),
        size: size)
    }

    if hasHeader {
      y += Config.Wall.headerHeight
    }

    if let textNode = textNode {
      let textSize = textNode.calculatedSize
      textNode.frame = CGRect(
        origin: CGPoint(x: padding, y: y),
        size: textSize)

      y += textSize.height + padding
    }

    if let divider = divider {
      divider.frame = CGRect(x: padding, y: y,
        width: contentWidth, height: Dimensions.dividerHeight)
    }
  }
}
