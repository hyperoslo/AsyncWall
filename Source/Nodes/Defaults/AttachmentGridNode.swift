import UIKit
import AsyncDisplayKit

public class AttachmentGridNode: PostComponentNode {

  public enum GridType {
    case Regular, FullWidth, SingleFullWidth
  }

  public let attachments: [AttachmentConvertible]

  // MARK: - Configuration

  public var ratio: CGFloat = 3 / 2
  public var padding: CGFloat = 10
  public var gridType = GridType.Regular
  public var counterEnabled = true

  // MARK: - Nodes

  public var imageNodes = [ASImageNode]()
  public var counterNode: CounterNode?

  public var height: CGFloat {
    return width / ratio
  }

  public var contentWidth: CGFloat {
    return width - padding
  }

  public var contentHeight: CGFloat {
    return height - padding
  }

  // MARK: - Initialization

  public required init(post: Post, width: CGFloat) {
    let totalCount = post.attachments.count
    attachments = totalCount < 4 ? post.attachments : Array(post.attachments[0..<3])

    super.init(post: post, width: width)
  }

  // MARK: - ConfigurableNode

  public override func configureNode() {
    var lastImageSize: CGSize?
    for (index, attachment) in enumerate(self.attachments) {
      let imageNode = ASImageNode()
      imageNode.backgroundColor = .grayColor()
      let imageSize = sizeForThumbnailAtIndex(index)

      if let thumbnail = Config.thumbnailForAttachment(
        attachment: attachment.wallModel,
        size: CGSize(
          width: imageSize.width,
          height: imageSize.height)) {
            imageNode.fetchImage(thumbnail.url)
      }

      imageNodes.append(imageNode)
      addSubnode(imageNode)

      if index == 2 {
        lastImageSize = imageSize
      }
    }

    let totalCount = post.attachments.count
    if counterEnabled && totalCount > 3 {
      if let lastImageSize = lastImageSize {
        counterNode = CounterNode(
          size: lastImageSize,
          count: imageNodes.count,
          totalCount: totalCount)
        addSubnode(counterNode)
      }
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
        x += imageSize.width + padding
      } else if index == 1 {
        y += imageSize.height + padding
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
