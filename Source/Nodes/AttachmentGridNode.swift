import UIKit
import AsyncDisplayKit

public class AttachmentGridNode: ASControlNode {

  public let width: CGFloat
  public let attachments: [Attachment]

  var imageNodes = [ASImageNode]()
  var counterNode: CounterNode?

  private var config: Config.Wall.Post.Attachments.Type {
    return Config.Wall.Post.Attachments.self
  }

  public var height: CGFloat {
    return width / config.ratio
  }

  public var contentWidth: CGFloat {
    return width - config.padding
  }

  public var contentHeight: CGFloat {
    return height - config.padding
  }

  // MARK: - Initialization

  public init(attachments: [Attachment], width: CGFloat) {
    let totalCount = attachments.count
    self.attachments = totalCount < 4 ? attachments : Array(attachments[0..<3])
    self.width = width

    super.init()

    for (index, attachment) in enumerate(self.attachments) {
      let imageNode = ASImageNode()
      imageNode.backgroundColor = .grayColor()
      let imageSize = sizeForThumbnailAtIndex(index)
      imageNode.fetchImage(Config.Wall.thumbnailForAttachment(attachment: attachment,
        size: CGSize(width: imageSize.width, height: imageSize.height)).url)
      imageNodes.append(imageNode)
      addSubnode(imageNode)
    }

    if config.Counter.enabled && totalCount > 3 {
      counterNode = CounterNode(count: imageNodes.count, totalCount: totalCount)
      addSubnode(counterNode)
    }
  }

  // MARK: - Layout

  override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
    return CGSizeMake(width, height)
  }

  override public func layout() {
    var x: CGFloat = 0
    var y: CGFloat = 0

    for (index, imageNode) in enumerate(imageNodes) {
      let imageSize = sizeForThumbnailAtIndex(index)
      imageNode.frame = CGRect(
        x: x,
        y: y,
        width: imageSize.width,
        height: imageSize.height)
      if index == 0 {
        x += imageSize.width + config.padding
      } else if index == 1 {
        y += imageSize.height + config.padding
      }
    }

    if let counterNode = counterNode {
      let size = counterNode.calculateSizeThatFits(counterNode.size)
      counterNode.frame = CGRect(
        x: width - size.width,
        y: height - size.height,
        width: size.width,
        height: size.height)
    }
  }

  // MARK: - Private Methods

  func sizeForThumbnailAtIndex(index: Int) -> CGSize {
    var size = CGSize(width: width, height: height)

    switch index {
    case 0:
      if attachments.count == 2 {
        size.width = contentWidth * 1 / 2
      } else if attachments.count > 2 {
        size.width = contentWidth * 2 / 3
      }
    case 1:
      size.width = contentWidth * 1 / 2
      if attachments.count > 2 {
        size.width = contentWidth * 1 / 3
        size.height = contentHeight / 2
      }
    default:
      size.width = contentWidth * 1 / 3
      size.height = contentHeight / 2
    }

    return size
  }
}
