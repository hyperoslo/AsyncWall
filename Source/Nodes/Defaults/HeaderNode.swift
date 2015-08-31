import UIKit
import AsyncDisplayKit

public class HeaderNode: PostComponentNode {

  // MARK: - Configuration

  public var avatarSize: CGFloat = 32
  public var authorHorizontalPadding: CGFloat = 10
  public var authorVerticalPadding: CGFloat = 1

  public override var height: CGFloat {
    return 40
  }

  public lazy var dateFormatter: NSDateFormatter = {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM-dd"

    return dateFormatter
    }()

  // MARK: - Nodes

  public lazy var authorNameNode: ASTextNode = { [unowned self] in
    let node = ASTextNode()

    if let author = self.post.author?.wallModel {
      node.attributedString = NSAttributedString(
        string: author.name,
        attributes: [
          NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
          NSForegroundColorAttributeName: UIColor.blackColor()
        ])
      node.userInteractionEnabled = true
    }

    return node
    }()

  public lazy var authorAvatarNode: ASNetworkImageNode = { [unowned self] in
    let node = ASNetworkImageNode()

    if let author = self.post.author, avatar = author.wallModel.image {
      node.backgroundColor = .grayColor()
      node.cornerRadius = self.avatarSize / 2
      node.clipsToBounds = true
      node.userInteractionEnabled = true
      node.frame.size = CGSize(width: self.avatarSize, height: self.avatarSize)
      node.URL = avatar.thumbnail.url
    }

    return node
    }()

  public lazy var dateNode: ASTextNode = { [unowned self] in
    let node = ASTextNode()

    node.attributedString = NSAttributedString(
      string: self.dateFormatter.stringFromDate(self.post.publishDate),
      attributes: [
        NSFontAttributeName: UIFont.systemFontOfSize(12),
        NSForegroundColorAttributeName: UIColor.grayColor()
      ])
    node!.userInteractionEnabled = true

    return node
    }()

  public override var actionNodes: [TappedNode] {
    return [(node: authorNameNode, element: .Author),
      (node: authorAvatarNode, element: .Author),
      (node: dateNode, element: .Date)]
  }

  private var secondRowY: CGFloat {
    return height / 2 + authorVerticalPadding
  }

  // MARK: - ConfigurableNode

  public override func configureNode() {
    [authorNameNode, authorAvatarNode, dateNode].map { self.addSubnode($0) }
  }

  // MARK: - Layout

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    return CGSizeMake(width, height)
  }

  override public func layout() {
    var x: CGFloat = 0

    authorAvatarNode.frame = CGRect(
      x: x,
      y: centerY(avatarSize),
      width: avatarSize,
      height: avatarSize)
    x += avatarSize + authorHorizontalPadding

    let authorNameSize = authorNameNode.measure(
      CGSize(
        width: CGFloat(FLT_MAX),
        height: height))

    authorNameNode.frame = CGRect(
      origin: CGPoint(x: x, y: centerY(authorNameSize.height)),
      size: authorNameSize)
    x += authorNameSize.width + authorHorizontalPadding

    let dateNodesize = dateNode.measure(
      CGSize(
        width: CGFloat(FLT_MAX),
        height: height))
    dateNode.frame = CGRect(
      origin: CGPoint(
        x: width - dateNodesize.width,
        y: centerY(dateNodesize.height)),
      size: dateNodesize)
  }

  // MARK: - Private Methods

  private func centerY(height: CGFloat) -> CGFloat {
    return (self.height - height) / 2
  }
}
