import UIKit
import AsyncDisplayKit

public class PostHeaderNode: ASCellNode {

  public let width: CGFloat

  var authorNameNode: ASTextNode?
  var authorAvatarNode: ASImageNode?
  var dateNode: ASTextNode?

  public var height: CGFloat {
    return config.height
  }

  private var config: Config.Wall.Post.Header.Type {
    return Config.Wall.Post.Header.self
  }

  // MARK: - Initialization

  public init(post: Post, width: CGFloat) {
    self.width = width

    super.init()

    if config.Author.enabled {
      if let author = post.author {
        authorNameNode = ASTextNode()
        authorNameNode!.attributedString = NSAttributedString(
          string: author.name,
          attributes: config.Author.textAttributes)
        addSubnode(authorNameNode)

        if config.Author.Avatar.enabled {
          if let avatar = author.avatar {
            let avatarConfig = config.Author.Avatar.self
            let imageSize = avatarConfig.size

            authorAvatarNode = ASImageNode()
            authorAvatarNode?.backgroundColor = avatarConfig.placeholderColor
            if avatarConfig.rounded {
              authorAvatarNode?.cornerRadius = imageSize / 2
              authorAvatarNode?.clipsToBounds = true
            }

            authorAvatarNode?.fetchImage(
              Config.Wall.thumbnailForAttachment(
                attachment: avatar,
                size: CGSize(width: imageSize, height: imageSize)).url)

            addSubnode(authorAvatarNode)
          }
        }
      }
    }

    if config.Date.enabled {
      dateNode = ASTextNode()
      dateNode!.attributedString = NSAttributedString(
        string: Config.Wall.stringFromPostDate(date: post.date),
        attributes: config.Date.textAttributes)

      addSubnode(dateNode)
    }
  }

  // MARK: - Layout

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    return CGSizeMake(width, height)
  }

  override public func layout() {
    var x: CGFloat = 0
    var y: CGFloat = 0

    let headerY: (height: CGFloat) -> CGFloat = { (height: CGFloat) -> CGFloat in
      return (self.height - height) / 2
    }

    if let authorAvatarNode = authorAvatarNode {
      let avatarConfig = config.Author.Avatar.self
      authorAvatarNode.frame = CGRect(
        x: x,
        y: y + headerY(height: avatarConfig.size),
        width: avatarConfig.size,
        height: avatarConfig.size)
      x += CGRectGetMaxX(authorAvatarNode.frame) + avatarConfig.padding
    }

    if let authorNameNode = authorNameNode {
      let size = authorNameNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: height))
      authorNameNode.frame = CGRect(
        origin: CGPoint(x: x, y: y + headerY(height: size.height)),
        size: size)
    }

    if let dateNode = dateNode {
      let size = dateNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: height))
      dateNode.frame = CGRect(
        origin: CGPoint(x: width - size.width, y: y + headerY(height: size.height)),
        size: size)
    }
  }
}
