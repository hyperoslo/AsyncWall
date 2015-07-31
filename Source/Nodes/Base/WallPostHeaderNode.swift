import UIKit
import AsyncDisplayKit

public protocol PostableHeaderCellNode {
  init(config: Config, post: Post, width: CGFloat)
}

public class WallPostHeaderNode: ASDisplayNode, PostableHeaderCellNode {

  public var post: Post
  public let width: CGFloat

  // MARK: - Initialization

  public required init(post: Post, width: CGFloat) {
    self.post = post
    self.width = width

    super.init()
  }
}
