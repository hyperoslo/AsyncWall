import UIKit
import AsyncDisplayKit

public class PostActionBarNode: ASCellNode {

  let width: CGFloat

  // MARK: - Initialization

  public init(width: CGFloat) {
    self.width = width

    super.init()
  }
}
