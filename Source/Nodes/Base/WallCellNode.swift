import UIKit
import AsyncDisplayKit

public protocol PostableCellNode {
  init(post: Post, index: Int, width: CGFloat, delegate: PostCellNodeDelegate?)
}

public class WallCellNode: ASCellNode, PostableCellNode {

  public var post: Post
  public let index: Int
  public let width: CGFloat
  public var config: Config?
  weak public var delegate: PostCellNodeDelegate?

  public required init(post: Post, index: Int, width: CGFloat, delegate: PostCellNodeDelegate? = nil) {
    self.post = post
    self.index = index
    self.width = width
    self.delegate = delegate
    self.config = self.delegate?.config

    super.init()
  }
}
