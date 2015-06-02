import UIKit
import AsyncDisplayKit

public class PostHeaderNode: ASCellNode {

  let width: CGFloat

  var authorNameNode: ASTextNode?
  var authorAvatarNode: ASImageNode?
  var groupNode: ASTextNode?
  var locationNode: ASTextNode?
  var dateNode: ASTextNode?

  var height: CGFloat {
    return HeaderConfig.height
  }

  private var HeaderConfig: Config.Wall.Post.Header.Type {
    return Config.Wall.Post.Header.self
  }

  // MARK: - Initialization

  public init(post: Post, width: CGFloat) {
    self.width = width

    super.init()

    if HeaderConfig.Author.enabled {
      if let author = post.author {
        authorNameNode = ASTextNode()
        authorNameNode!.attributedString = NSAttributedString(
          string: author.name,
          attributes: HeaderConfig.Author.textAttributes)
        addSubnode(authorNameNode)

        if HeaderConfig.Author.Avatar.enabled {
          if let avatar = author.avatar {
            let avatarConfig = HeaderConfig.Author.Avatar.self
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

    if HeaderConfig.Group.enabled {
      if let group = post.group {
        groupNode = ASTextNode()
        groupNode!.attributedString = NSAttributedString(
          string: group,
          attributes: HeaderConfig.Group.textAttributes)

        addSubnode(groupNode)
      }
    }

    if HeaderConfig.Location.enabled {
      if let location = post.location {
        locationNode = ASTextNode()
        locationNode!.attributedString = NSAttributedString(
          string: location,
          attributes: HeaderConfig.Location.textAttributes)

        addSubnode(locationNode)
      }
    }

    if HeaderConfig.Date.enabled {
      dateNode = ASTextNode()
      dateNode!.attributedString = NSAttributedString(
        string: Config.Wall.stringFromPostDate(date: post.date),
        attributes: HeaderConfig.Date.textAttributes)

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

    let avatarConfig = HeaderConfig.Author.Avatar.self
    let authorConfig = HeaderConfig.Author.self

    let centerY: (height: CGFloat) -> CGFloat = { (height: CGFloat) -> CGFloat in
      return y + (self.height - height) / 2
    }

    let firstRowY: (height: CGFloat) -> CGFloat = { (height: CGFloat) -> CGFloat in
      let itemY = self.locationNode != nil ?
        self.height / 2 - height - authorConfig.verticalPadding :
        centerY(height: height)
      return y + itemY
    }

    let secondRowY: (height: CGFloat) -> CGFloat = { (height: CGFloat) -> CGFloat in
      let itemY = self.authorNameNode != nil ?
        self.height / 2 + authorConfig.verticalPadding :
        centerY(height: height)
      return y + itemY
    }

    if let authorAvatarNode = authorAvatarNode {
      authorAvatarNode.frame = CGRect(
        x: x,
        y: centerY(height: avatarConfig.size),
        width: avatarConfig.size,
        height: avatarConfig.size)
      x += avatarConfig.size + authorConfig.horizontalPadding
    }

    var maxWidth = width
    var authorNameX = x
    if let authorNameNode = authorNameNode {
      let size = authorNameNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: height))

      authorNameNode.frame = CGRect(
        origin: CGPoint(x: x, y: firstRowY(height: size.height)),
        size: size)
      maxWidth -= size.width
      x += size.width + authorConfig.horizontalPadding
    }

    if let dateNode = dateNode {
      let size = dateNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: height))
      dateNode.frame = CGRect(
        origin: CGPoint(x: width - size.width, y: centerY(height: size.height)),
        size: size)
      maxWidth -= size.width
    }

    if let groupNode = groupNode {
      let size = groupNode.measure(
        CGSize(
          width: maxWidth,
          height: height))

      groupNode.frame = CGRect(
        origin: CGPoint(x: x, y: firstRowY(height: size.height)),
        size: size)
    }

    if let locationNode = locationNode {
      let size = locationNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: height))

      locationNode.frame = CGRect(
        origin: CGPoint(x: authorNameX, y: secondRowY(height: size.height)),
        size: size)
    }
  }
}
