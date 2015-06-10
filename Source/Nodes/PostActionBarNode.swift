import UIKit
import AsyncDisplayKit

public class PostActionBarNode: ASCellNode {

  var likeControlNode: ControlNode?
  var commentControlNode: ControlNode?

  var halfOfFrame: CGRect {
    return CGRect(
      x: 0,
      y: 0,
      width: CGRectGetWidth(self.frame),
      height: CGRectGetHeight(self.frame))
  }

  private var ActionBarConfig: Config.Wall.Post.ActionBar.Type {
    return Config.Wall.Post.ActionBar.self
  }

  // MARK: - Initialization

  public override init() {
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

  override public func layout() {
    var x: CGFloat = 0

    if let likeControlNode = likeControlNode {
      let size = Config.Wall.Post.Control.size

      likeControlNode.frame = CGRect(
        origin: likeControlNode.frame.centerInRect(halfOfFrame),
        size: size)

      x += CGRectGetWidth(likeControlNode.frame)
    }

    if let commentControlNode = commentControlNode {
      let size = Config.Wall.Post.Control.size

      var origin = commentControlNode.frame.centerInRect(halfOfFrame)
      origin.x += x
      commentControlNode.frame = CGRect(
        origin: origin,
        size: size)
      commentControlNode.frame.centerInRect(halfOfFrame)
    }
  }
}
