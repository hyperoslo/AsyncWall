import UIKit
import AsyncDisplayKit

public protocol PostableHeaderCellNode {
  init(config: Config, post: Post, width: CGFloat)
}

public class WallPostHeaderNode: ASDisplayNode, PostableHeaderCellNode {

  public var post: Post
  public let config: Config
  public let width: CGFloat

  // MARK: - Initialization

  public required init(config: Config, post: Post, width: CGFloat) {
    self.post = post
    self.config = config
    self.width = width

    super.init()
  }
}
