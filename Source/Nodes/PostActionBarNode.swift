import UIKit
import AsyncDisplayKit

public class PostActionBarNode: ASCellNode {

  var likeControlNode: ControlNode?
  var commentControlNode: ControlNode?

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
}
