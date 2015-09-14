import UIKit
import AsyncDisplayKit

public protocol ConfigurableNode {
  func configureNode()
}

public protocol PostableCellNode {
  init(post: Post, index: Int, width: CGFloat, delegate: PostCellNodeDelegate?)
}

public protocol PostCellNodeDelegate: class {

  func cellNodeElementWasTapped(elementType: TappedElement, postCellNode: PostCellNode)
  var config: Config { get }
}

public class PostCellNode: ASCellNode, PostableCellNode, ConfigurableNode {

  public var post: Post
  public let index: Int
  public let width: CGFloat
  public weak var delegate: PostCellNodeDelegate?
  public var config: Config?

  // MARK: - Initialization

  public required init(post: Post, index: Int, width: CGFloat, delegate: PostCellNodeDelegate? = nil) {
    self.post = post
    self.index = index
    self.width = width
    self.delegate = delegate
    config = delegate?.config

    super.init()

    configureNode()
  }

  // MARK: - ConfigurableNode

  public func configureNode() { }
}
