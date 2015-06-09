import UIKit
import AsyncDisplayKit

public class ControlNode: ASControlNode {

  var titleNode: ASTextNode?
  var imageNode: ASImageNode?

  public init(title: NSAttributedString?, image: UIImage?) {
    super.init()

    if let title = title {
      titleNode = ASTextNode()
      titleNode!.attributedString = title

      addSubnode(titleNode)
    }

    if let image = image {
      imageNode = ASImageNode()
      imageNode?.image = image

      addSubnode(imageNode)
    }
  }
}
