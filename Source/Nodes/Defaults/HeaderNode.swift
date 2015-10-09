import UIKit
import AsyncDisplayKit

public class HeaderNode: PostComponentNode {

  // MARK: - Configuration

  public var avatarSize = CGSize(width: 32, height: 32)
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
    let node = ASNetworkImageNode(cache: nil, downloader: self.downloader)

    if let author = self.post.author, avatar = author.wallModel.image {
      node.backgroundColor = .grayColor()
      node.cornerRadius = self.avatarSize.height / 2
      node.clipsToBounds = true
      node.userInteractionEnabled = true
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
    node.userInteractionEnabled = true

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

  // MARK: - Image Cache

  public lazy var downloader = ImageCache()

  // MARK: - ConfigurableNode

  public override func configureNode() {
    for node in [authorNameNode, authorAvatarNode, dateNode] {
      addSubnode(node)
    }
  }

  // MARK: - Layout

  public override func calculateLayoutThatFits(constrainedSize: ASSizeRange) -> ASLayout! {
    var x: CGFloat = 0
    let avatarPosition = CGPoint(x: x, y: centerY(avatarSize.height))
    let avatarLayout = ASLayout(layoutableObject: authorAvatarNode, size: avatarSize, position: avatarPosition, sublayouts: nil)

    x += avatarSize.width + authorHorizontalPadding

    let authorNameLayout = authorNameNode.calculateLayoutThatFits(constrainedSize)
    authorNameLayout.position = CGPoint(x: x, y: centerY(authorNameLayout.size.height))

    let dateLayout = dateNode.calculateLayoutThatFits(constrainedSize)
    dateLayout.position = CGPoint(x: constrainedSize.max.width - dateLayout.size.width, y: centerY(dateLayout.size.height))


    let size = CGSize(width: constrainedSize.max.width, height: height)
    let layout = ASLayout(layoutableObject: self, size: size, position: CGPoint.zero, sublayouts: [avatarLayout, authorNameLayout, dateLayout])

    return layout
  }

  // MARK: - Private Methods

  private func centerY(height: CGFloat) -> CGFloat {
    return (self.height - height) / 2
  }
}
