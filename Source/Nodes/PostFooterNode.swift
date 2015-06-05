import UIKit
import AsyncDisplayKit

public class PostFooterNode: ASCellNode {

  let width: CGFloat

  // MARK: - Initialization
  
  public init(post: Post, width: CGFloat) {
    self.width = width

    super.init()
  }
}
