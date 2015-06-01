import UIKit
import AsyncDisplayKit

public class CommentCellNode: PostCellNode {

  private var CommentConfig: Config.Wall.Comment.Type {
    return Config.Wall.Comment.self
  }

  // MARK: - Initialization

  public override init(post: Post, width: CGFloat, _ delegate: AnyObject? = nil) {
    super.init(post: post, width: width, delegate)

    backgroundColor = CommentConfig.backgroundColor
    divider!.backgroundColor = CommentConfig.Divider.backgroundColor
  }
}
