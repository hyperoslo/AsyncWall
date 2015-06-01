import UIKit
import AsyncDisplayKit

public class CommentCellNode: PostCellNode {

  public override init(post: Post, width: CGFloat, _ delegate: AnyObject? = nil) {
    super.init(post: post, width: width, delegate)

    backgroundColor = UIColor(red:0.969, green:0.973, blue:0.976, alpha: 1)
  }
}
