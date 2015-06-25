import UIKit
import AsyncDisplayKit

public class PostActionBarNode: ASDisplayNode {

  public let config: Config
  public let width: CGFloat

  public var likeControlNode: ControlNode?
  public var commentControlNode: ControlNode?
  public var divider: ASDisplayNode?

  public var height: CGFloat {
    return actionBarConfig.height
  }

  private var actionBarConfig: Config.Wall.Post.ActionBar {
    return config.wall.post.actionBar
  }

  // MARK: - Initialization

  public init(config: Config, width: CGFloat) {
    self.width = width
    self.config = config

    super.init()

    if actionBarConfig.dividerEnabled {
      divider = ASDisplayNode()
      divider!.backgroundColor = config.wall.post.divider.backgroundColor
      addSubnode(divider)
    }

    if actionBarConfig.likeButton.enabled {
      var title: NSAttributedString?
      var image = actionBarConfig.likeButton.image

      if let controlTitle = actionBarConfig.likeButton.title {
        title = NSAttributedString(
          string: controlTitle,
          attributes: actionBarConfig.likeButton.textAttributes)
      }

      likeControlNode = ControlNode(config: config, title: title, image: image)
      likeControlNode!.userInteractionEnabled = true

      addSubnode(likeControlNode)
    }

    if actionBarConfig.commentButton.enabled {
      var title: NSAttributedString?
      var image = actionBarConfig.commentButton.image

      if let controlTitle = actionBarConfig.commentButton.title {
        title = NSAttributedString(
          string: controlTitle,
          attributes: actionBarConfig.commentButton.textAttributes)
      }

      commentControlNode = ControlNode(config: config, title: title, image: image)
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

    if let divider = divider {
      divider.frame = CGRect(
        x: 0,
        y: 0,
        width: width,
        height: config.wall.post.divider.height)
    }

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
