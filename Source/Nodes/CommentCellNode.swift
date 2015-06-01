import UIKit
import AsyncDisplayKit

public class CommentCellNode: PostCellNode {

  // MARK: - Initialization

  public override init(post: Post, width: CGFloat, _ delegate: AnyObject? = nil) {
    super.init(post: post, width: width, delegate)

    backgroundColor = Config.Wall.Comment.backgroundColor
    divider!.backgroundColor = Config.Wall.Comment.Divider.backgroundColor
  }
}
