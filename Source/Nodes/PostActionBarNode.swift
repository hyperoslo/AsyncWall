import UIKit
import AsyncDisplayKit

public class PostActionBarNode: ASCellNode {

  let width: CGFloat

  var likeControlNode: ControlNode?
  var commentControlNode: ControlNode?

  var height: CGFloat {
    return ActionBarConfig.height
  }

  private var ActionBarConfig: Config.Wall.Post.ActionBar.Type {
    return Config.Wall.Post.ActionBar.self
  }

  // MARK: - Initialization

  public init(width: CGFloat) {
    self.width = width

    super.init()

    if ActionBarConfig.LikeButton.enabled {
      var title: NSAttributedString?
      var image = ActionBarConfig.LikeButton.image

      if let controlTitle = ActionBarConfig.LikeButton.title {
        title = NSAttributedString(
          string: controlTitle,
          attributes: ActionBarConfig.LikeButton.textAttributes)
      }

      likeControlNode = ControlNode(title: title, image: image)
      likeControlNode!.userInteractionEnabled = true

      addSubnode(likeControlNode)
    }

    if ActionBarConfig.CommentButton.enabled {
      var title: NSAttributedString?
      var image = ActionBarConfig.CommentButton.image

      if let controlTitle = ActionBarConfig.CommentButton.title {
        title = NSAttributedString(
          string: controlTitle,
          attributes: ActionBarConfig.CommentButton.textAttributes)
      }

      commentControlNode = ControlNode(title: title, image: image)
      commentControlNode!.userInteractionEnabled = true

      addSubnode(commentControlNode)
    }
  }

  // MARK: - Layout

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    return CGSizeMake(width, height)
  }

  override public func layout() {
    var x: CGFloat = 0
    let sideSize = CGSize(width: width / 2, height: height)

    if let likeControlNode = likeControlNode {
      likeControlNode.frame = CGRect(
        origin: likeControlNode.size.centerInSize(sideSize),
        size: likeControlNode.size)

      x += sideSize.width
    }

    if let commentControlNode = commentControlNode {
      var origin = commentControlNode.size.centerInSize(sideSize)
      origin.x += x
      commentControlNode.frame = CGRect(
        origin: origin,
        size: commentControlNode.size)
    }
  }
}
