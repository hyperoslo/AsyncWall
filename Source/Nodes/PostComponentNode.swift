import UIKit
import AsyncDisplayKit

public typealias TappedNode = (node: ASControlNode, element: TappedElement)

public protocol TappableNode {
  var actionNodes: [TappedNode] { get }
}

public protocol PostableComponentNode {
  init(post: Post, width: CGFloat)
}

public class PostComponentNode: ASControlNode, PostableComponentNode, ConfigurableNode, TappableNode {

  public var post: Post
  public let width: CGFloat
  public var height: CGFloat {
    return 0
  }

  public var actionNodes: [TappedNode] {
    return []
  }

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
