import UIKit
import AsyncDisplayKit

public protocol PostableComponentNode {
  init(post: Post, width: CGFloat)
}

public class PostComponentNode: ASControlNode, PostableComponentNode, ConfigurableNode {

  public var post: Post
  public let width: CGFloat

  // MARK: - Initialization

  public required init(post: Post, width: CGFloat) {
    self.post = post
    self.width = width
    super.init()

    configureNode()
  }

  // MARK: - ConfigurableNode

  public func configureNode() { }
}
