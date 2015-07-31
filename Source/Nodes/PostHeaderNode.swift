import UIKit
import AsyncDisplayKit

public class PostHeaderNode: WallPostHeaderNode {

  struct Dimensions {
    static let avatarSize: CGFloat = 32
    static let authorHorizontalPadding: CGFloat = 5
    static let authorVerticalPadding: CGFloat = 1
  }

  // MARK: - Configuration

  public var enabled = true
  public var height: CGFloat = 40

  public lazy var dateFormatter: NSDateFormatter = {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM-dd"
    return dateFormatter
    }()

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

        if let thumbnail = Config.thumbnailForAttachment(
          attachment: avatar,
          size: CGSize(width: Dimensions.avatarSize, height: Dimensions.avatarSize)) {
            authorAvatarNode?.fetchImage(thumbnail.url)
        }

        addSubnode(authorAvatarNode)
      }
    }

    dateNode = ASTextNode()
    dateNode!.attributedString = NSAttributedString(
      string: dateFormatter.stringFromDate(post.publishDate),
      attributes: [
        NSFontAttributeName: UIFont.systemFontOfSize(12),
        NSForegroundColorAttributeName: UIColor.grayColor()
      ])
    dateNode!.userInteractionEnabled = true

    addSubnode(dateNode)
  }

  // MARK: - Layout

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    return CGSizeMake(width, height)
  }

  override public func layout() {
    var x: CGFloat = 0
    var maxWidth = width

    if let authorAvatarNode = authorAvatarNode {
      authorAvatarNode.frame = CGRect(
        x: x,
        y: centerY(Dimensions.avatarSize),
        width: Dimensions.avatarSize,
        height: Dimensions.avatarSize)
      x += Dimensions.avatarSize + Dimensions.authorHorizontalPadding
    }

    var authorNameX = x

    let size = authorNameNode.measure(
      CGSize(
        width: CGFloat(FLT_MAX),
        height: height))

    authorNameNode.frame = CGRect(
      origin: CGPoint(x: x, y: centerY(size.height)),
      size: size)
    x += size.width + Dimensions.authorHorizontalPadding

    if let dateNode = dateNode {
      let size = dateNode.measure(
        CGSize(
          width: CGFloat(FLT_MAX),
          height: height))
      dateNode.frame = CGRect(
        origin: CGPoint(x: width - size.width, y: centerY(size.height)),
        size: size)
      maxWidth -= size.width + Dimensions.authorHorizontalPadding
    }
  }

  // MARK: - Private Methods

  private func centerY(height: CGFloat) -> CGFloat {
    return (self.height - height) / 2
  }
}
