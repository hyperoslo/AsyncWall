import UIKit
import AsyncDisplayKit

public class PostHeaderNode: ASDisplayNode {

  let config: Config
  let width: CGFloat

  var authorNameNode: ASTextNode?
  var authorAvatarNode: ASImageNode?
  var groupNode: ASTextNode?
  var groupDivider: ASTextNode?
  var locationIconNode: ASImageNode?
  var locationNode: ASTextNode?
  var dateNode: ASTextNode?

  var height: CGFloat {
    return headerConfig.height
  }

  private var headerConfig: Config.Wall.Post.Header {
    return config.wall.post.header
  }

  // MARK: - Initialization

  public init(config: Config, post: Post, width: CGFloat) {
    self.config = config
    self.width = width

    super.init()

    if headerConfig.author.enabled {
      if let author = post.author {
        if let name = author.name {
          authorNameNode = ASTextNode()
          authorNameNode!.attributedString = NSAttributedString(
            string: name,
            attributes: headerConfig.author.textAttributes)
          authorNameNode!.userInteractionEnabled = true

          addSubnode(authorNameNode)
        }

        if headerConfig.author.avatar.enabled {
          if let avatar = author.avatar {
            let avatarConfig = headerConfig.author.avatar
            let imageSize = avatarConfig.size

            authorAvatarNode = ASImageNode()
            authorAvatarNode?.backgroundColor = avatarConfig.placeholderColor
            if avatarConfig.rounded {
              authorAvatarNode?.cornerRadius = imageSize / 2
              authorAvatarNode?.clipsToBounds = true
            }
            authorAvatarNode!.userInteractionEnabled = true

            if let thumbnail = config.wall.thumbnailForAttachment(
              attachment: avatar,
              size: CGSize(width: imageSize, height: imageSize)) {
                authorAvatarNode?.fetchImage(thumbnail.url)
            }

            addSubnode(authorAvatarNode)
          }
        }
      }
    }

    if headerConfig.group.enabled {
      if let group = post.group {
        groupNode = ASTextNode()
        groupNode!.attributedString = NSAttributedString(
          string: group.name!,
          attributes: headerConfig.group.textAttributes)
        groupNode!.userInteractionEnabled = true

        addSubnode(groupNode)

        let dividerConfig = headerConfig.group.divider
        if dividerConfig.enabled {
          groupDivider = ASTextNode()
          groupDivider!.attributedString = NSAttributedString(
            string: dividerConfig.text,
            attributes: dividerConfig.textAttributes)

          addSubnode(groupDivider)
        }
      }
    }

    if headerConfig.location.enabled {
      if let location = post.location {
        if let name = location.name {
          locationNode = ASTextNode()
          locationNode!.attributedString = NSAttributedString(
            string: name,
            attributes: headerConfig.location.textAttributes)
          locationNode!.userInteractionEnabled = true

          addSubnode(locationNode)
        }

        if headerConfig.location.icon.enabled {
          locationIconNode = ASImageNode()
          locationIconNode?.backgroundColor = headerConfig.author.avatar.placeholderColor
          locationIconNode?.image = headerConfig.location.icon.image

          addSubnode(locationIconNode)
        }
      }
    }

    if headerConfig.date.enabled {
      if let date = post.date {
        dateNode = ASTextNode()
        dateNode!.attributedString = NSAttributedString(
          string: config.wall.stringFromPostDate(date: date),
          attributes: headerConfig.date.textAttributes)
        dateNode!.userInteractionEnabled = true

        addSubnode(dateNode)
      }
    }
  }

  // MARK: - Layout

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    return CGSizeMake(width, height)
  }

  override public func layout() {
    var x: CGFloat = 0
    var maxWidth = width

    let avatarConfig = headerConfig.author.avatar
    let authorConfig = headerConfig.author

    if let authorAvatarNode = authorAvatarNode {
      authorAvatarNode.frame = CGRect(
        x: x,
        y: centerY(avatarConfig.size),
        width: avatarConfig.size,
        height: avatarConfig.size)
      x += avatarConfig.size + authorConfig.horizontalPadding
    }

    var authorNameX = x
    if let authorNameNode = authorNameNode {
      let size = authorNameNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: height))

      authorNameNode.frame = CGRect(
        origin: CGPoint(x: x, y: firstRowY(size.height)),
        size: size)
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
      maxWidth -= size.width + authorConfig.horizontalPadding
    }

    if let groupNode = groupNode {
      if let groupDivider = groupDivider {
        let dividerSize = groupDivider.measure(
          CGSize(
            width: CGFloat(FLT_MAX),
            height: height))

        let groupSize = groupNode.measure(
          CGSize(
            width: CGFloat(FLT_MAX),
            height: height))
        let dividerY = firstRowY(groupSize.height) +
          (groupSize.height - dividerSize.height) / 2

        groupDivider.frame = CGRect(
          origin: CGPoint(x: x, y: dividerY),
          size: dividerSize)
        x += dividerSize.width + authorConfig.horizontalPadding
      }

      maxWidth -= x

      let size = groupNode.measure(
        CGSize(
          width: maxWidth,
          height: height))
      let textSize = groupNode.attributedString.size()
      let groupY = textSize.width > size.width ? centerY(size.height) :
        firstRowY(size.height)

      groupNode.frame = CGRect(
        origin: CGPoint(x: x, y: groupY),
        size: size)
    }

    if let locationNode = locationNode {
      let size = locationNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: height))

      let rowY = secondRowY(size.height)
      if let locationIconNode = locationIconNode {
        let iconConfig = headerConfig.location.icon

        let iconY = rowY + (size.height - iconConfig.size) / 2

        locationIconNode.frame = CGRect(x: authorNameX, y: iconY,
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
      self.height / 2 - height - headerConfig.author.verticalPadding :
      centerY(height)
  }

  func secondRowY(height: CGFloat) -> CGFloat {
    return self.authorNameNode != nil ?
      self.height / 2 + headerConfig.author.verticalPadding :
      centerY(height)
  }
}
