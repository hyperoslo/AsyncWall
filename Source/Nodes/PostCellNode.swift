import UIKit
import AsyncDisplayKit

public class PostCellNode: ASCellNode {

  struct Dimensions {
    static let dividerHeight: CGFloat = 1
  }

  let width: CGFloat
  var delegate: PostCellNodeDelegate?
  var post: Post

  var authorNameNode: ASTextNode?
  var authorAvatarNode: ASImageNode?
  var dateTextNode: ASTextNode?
  var textNode: ASTextNode?
  var likesTextNode: ASTextNode?
  var commentsTextNode: ASTextNode?
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
      authorNameNode = ASTextNode()
      authorNameNode!.attributedString = NSAttributedString(string: author.name,
        attributes: Config.Wall.TextAttributes.authorName)
      addSubnode(authorNameNode)

      if let avatar = author.avatar {
        authorAvatarNode = ASImageNode()
        authorAvatarNode?.backgroundColor = UIColor.grayColor()
        addSubnode(authorAvatarNode)
      }
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

    if let textNode = textNode {
      let textSize = textNode.measure(CGSize(width: contentWidth,
        height: CGFloat(FLT_MAX)))
      height += textSize.height + Config.Wall.padding
    }

    if Config.Wall.useDivider {
      height += Dimensions.dividerHeight
    }

    return CGSizeMake(width, height)
  }

  override public func layout() {
    let padding = Config.Wall.padding
    var y = padding

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
