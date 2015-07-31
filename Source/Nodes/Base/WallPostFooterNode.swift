import UIKit
import AsyncDisplayKit

public protocol PostableFooterCellNode {
  init(post: Post, width: CGFloat)
}

public class WallPostFooterNode: ASDisplayNode, PostableFooterCellNode {

  public var post: Post
  public let width: CGFloat

  // MARK: - Initialization

  public required init(post: Post, width: CGFloat) {
    self.post = post
    self.width = width

    super.init()
  }
}
