import UIKit
import AsyncDisplayKit

public class PostHeaderNode: ASCellNode {

  struct Dimensions {
  }

  public let width: CGFloat

  public init(width: CGFloat) {
    self.width = width

    super.init()
  }
}
