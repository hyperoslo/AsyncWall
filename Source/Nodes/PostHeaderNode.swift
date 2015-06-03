import UIKit
import AsyncDisplayKit

public class PostHeaderNode: ASCellNode {

  let width: CGFloat

  var authorNameNode: ASTextNode?
  var authorAvatarNode: ASImageNode?
  var groupNode: ASTextNode?
  var locationIconNode: ASImageNode?
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

        if HeaderConfig.Location.Icon.enabled {
          locationIconNode = ASImageNode()
          locationIconNode?.backgroundColor = HeaderConfig.Author.Avatar.placeholderColor
          locationIconNode?.image = HeaderConfig.Location.Icon.image

          addSubnode(locationIconNode)
        }
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

    let avatarConfig = HeaderConfig.Author.Avatar.self
    let authorConfig = HeaderConfig.Author.self

    if let authorAvatarNode = authorAvatarNode {
      authorAvatarNode.frame = CGRect(
        x: x,
        y: centerY(avatarConfig.size),
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
        origin: CGPoint(x: x, y: firstRowY(size.height)),
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
        origin: CGPoint(x: width - size.width, y: centerY(size.height)),
        size: size)
      maxWidth -= size.width
    }

    if let groupNode = groupNode {
      let size = groupNode.measure(
        CGSize(
          width: maxWidth,
          height: height))

      groupNode.frame = CGRect(
        origin: CGPoint(x: x, y: firstRowY(size.height)),
        size: size)
    }

    if let locationNode = locationNode {
      let size = locationNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: height))

      let rowY = secondRowY(size.height)
      if let locationIconNode = locationIconNode {
        let iconConfig = HeaderConfig.Location.Icon.self

        locationIconNode.frame = CGRect(x: authorNameX, y: rowY,
          width: iconConfig.size, height: iconConfig.size)
        authorNameX += iconConfig.size + iconConfig.padding
      }

      locationNode.frame = CGRect(
        origin: CGPoint(x: authorNameX, y: rowY),
        size: size)
    }
  }

  // MARK: - Private Methods

  func centerY(height: CGFloat) -> CGFloat {
    return (self.height - height) / 2
  }

  func firstRowY(height: CGFloat) -> CGFloat {
    return self.locationNode != nil ?
      self.height / 2 - height - HeaderConfig.Author.verticalPadding :
      centerY(height)
  }

  func secondRowY(height: CGFloat) -> CGFloat {
    return self.authorNameNode != nil ?
      self.height / 2 + HeaderConfig.Author.verticalPadding :
      centerY(height)
  }
}
