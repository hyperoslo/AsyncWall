import UIKit
import AsyncDisplayKit

public protocol ConfigurableNode {
  func configureNode()
}

public protocol PostableCellNode {
  init(post: Post, index: Int, width: CGFloat, delegate: PostCellNodeDelegate?)
}

public class PostCellNode: ASCellNode, PostableCellNode, ConfigurableNode {

  public var post: Post
  public let index: Int
  public let width: CGFloat
  weak public var delegate: PostCellNodeDelegate?

  // MARK: - Initialization

  public required init(post: Post, index: Int, width: CGFloat, delegate: PostCellNodeDelegate? = nil) {
    self.post = post
    self.index = index
    self.width = width
    self.delegate = delegate

    super.init()
  }

  // MARK: - ConfigurableNode

  public func configureNode() { }
}
