import UIKit
import AsyncDisplayKit

public class CommentCellNode: PostCellNode {

  private var CommentConfig: Config.Wall.Comment.Type {
    return Config.Wall.Comment.self
  }

  // MARK: - Initialization

  public override init(post: Postable, width: CGFloat, delegate: AnyObject? = nil) {
    super.init(post: post, width: width, delegate: delegate)

    if let config = config {
      let commentConfig = config.wall.comment
      backgroundColor = commentConfig.backgroundColor
      divider!.backgroundColor = commentConfig.divider.backgroundColor
    }
  }
}
