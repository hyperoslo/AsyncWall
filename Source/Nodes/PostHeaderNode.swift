import UIKit
import AsyncDisplayKit

public class PostHeaderNode: WallPostHeaderNode {

  struct Dimensions {
    static let avatarSize: CGFloat = 32
    static let authorHorizontalPadding: CGFloat = 5
    static let authorVerticalPadding: CGFloat = 1
  }


  // MARK: - Configuration

  public struct Author {

    public var avatar = Avatar()

    public struct Avatar {
      public var size: CGFloat = 32
      public var rounded = true
      public var placeholderColor = UIColor.lightGrayColor()
    }
  }

  public struct Group {
    public var textAttributes = [
      NSFontAttributeName: UIFont.boldSystemFontOfSize(12),
      NSForegroundColorAttributeName: UIColor.blackColor()
    ]
  }

  public struct Location {
    public var textAttributes = [
      NSFontAttributeName: UIFont.systemFontOfSize(12),
      NSForegroundColorAttributeName: UIColor.grayColor()
    ]
    public var icon = Icon()

    public struct Icon {
      public var enabled = true
      public var padding: CGFloat = 3
      public var size: CGFloat = 12
      public var image: UIImage?
    }
  }

  public struct Date {
    public var enabled = true
    public var textAttributes = [
      NSFontAttributeName: UIFont.systemFontOfSize(12),
      NSForegroundColorAttributeName: UIColor.grayColor()
    ]
  }

  public var enabled = true
  public var height: CGFloat = 40
  public var authorConfig = Author()
  public var groupConfig = Group()
  public var locationConfig = Location()
  public var dateConfig = Date()

  // MARK: - Nodes

  public var authorNameNode = ASTextNode()
  public var authorAvatarNode: ASImageNode?
  public var groupNode: ASTextNode?
  public var locationNode: ASTextNode?
  public var dateNode: ASTextNode?

  private var secondRowY: CGFloat {
    return height / 2 + Dimensions.authorVerticalPadding
  }

  // MARK: - Initialization

  public required init(post: Post, width: CGFloat) {
    super.init(post: post, width: width)

    if let author = post.author {
      let user = author.wallModel

      authorNameNode.attributedString = NSAttributedString(
        string: user.name,
        attributes: [
          NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
          NSForegroundColorAttributeName: UIColor.blackColor()
        ])
      authorNameNode.userInteractionEnabled = true

      addSubnode(authorNameNode)

      if let avatar = user.image {
        authorAvatarNode = ASImageNode()
        authorAvatarNode?.backgroundColor = .grayColor()
        authorAvatarNode?.cornerRadius = Dimensions.avatarSize / 2
        authorAvatarNode?.clipsToBounds = true
        authorAvatarNode!.userInteractionEnabled = true

        if let thumbnail = Config.Wall.thumbnailForAttachment(
          attachment: avatar,
          size: CGSize(width: Dimensions.avatarSize, height: Dimensions.avatarSize)) {
            authorAvatarNode?.fetchImage(thumbnail.url)
        }

        addSubnode(authorAvatarNode)
      }
    }

    if headerConfig.group.enabled {
      if let group = post.group {
        let group = group.wallModel

        groupNode = ASTextNode()
        groupNode!.attributedString = NSAttributedString(
          string: group.name,
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
        locationNode = ASTextNode()
        locationNode!.attributedString = NSAttributedString(
          string: location.name,
          attributes: headerConfig.location.textAttributes)
        locationNode!.userInteractionEnabled = true

        addSubnode(locationNode)

        if headerConfig.location.icon.enabled {
          locationIconNode = ASImageNode()
          locationIconNode?.backgroundColor = headerConfig.author.avatar.placeholderColor
          locationIconNode?.image = headerConfig.location.icon.image

          addSubnode(locationIconNode)
        }
      }
    }

    if headerConfig.date.enabled {
      dateNode = ASTextNode()
      dateNode!.attributedString = NSAttributedString(
        string: config.wall.stringFromPostDate(date: post.publishDate),
        attributes: headerConfig.date.textAttributes)
      dateNode!.userInteractionEnabled = true

      addSubnode(dateNode)
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

    let size = authorNameNode.measure(
      CGSize(
        width: CGFloat(FLT_MAX),
        height: height))

    authorNameNode.frame = CGRect(
      origin: CGPoint(x: x, y: firstRowY(size.height)),
      size: size)
    x += size.width + authorConfig.horizontalPadding

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

      let rowY = secondRowY
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

  private func centerY(height: CGFloat) -> CGFloat {
    return (self.height - height) / 2
  }

  private func firstRowY(height: CGFloat) -> CGFloat {
    return self.locationNode != nil ?
      self.height / 2 - height - headerConfig.author.verticalPadding :
      centerY(height)
  }
}
