import UIKit
import AsyncDisplayKit

public class AttachmentGridNode: PostComponentNode {

  public let attachments: [AttachmentConvertible]

  public var attachmentCount = 0

  // MARK: - Configuration

  public var ratio: CGFloat = 3 / 2
  public var padding: CGFloat = 10

  public override var height: CGFloat {
    return width / ratio
  }

  public var contentWidth: CGFloat {
    return width - padding
  }

  public var contentHeight: CGFloat {
    return height - padding
  }

  // MARK: - Nodes

  public var imageNodes = [ASImageNode]()
  public var counterNode: CounterNode?

  // MARK: - Image Cache

  public lazy var downloader = ImageCache()

  // MARK: - Initialization

  public required init(post: Post, width: CGFloat) {
    attachments = Array(post.attachments.prefix(3))
    attachmentCount = attachments.count

    super.init(post: post, width: width)
  }

  // MARK: - ConfigurableNode

  public override func configureNode() {

    for attachment in attachments {
      let imageNode = ASNetworkImageNode(cache: nil, downloader: downloader)
      imageNode.backgroundColor = .grayColor()
      imageNode.URL = attachment.wallModel.thumbnail.url
      imageNode.layerBacked = true

      imageNodes.append(imageNode)
      addSubnode(imageNode)
    }

    let totalCount = post.attachments.count
    if totalCount > 3 {
        counterNode = CounterNode(
          count: imageNodes.count,
          totalCount: totalCount)
        
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

    for (index, imageNode) in imageNodes.enumerate() {
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
      counterNode.frame = imageNodes.last!.frame
    }
  }

  // MARK: - Private Methods

  func sizeForThumbnailAtIndex(index: Int) -> CGSize {
    var size = CGSize(width: width, height: height)

    switch index {
    case 0:
      if attachmentCount == 2 {
        size.width = contentWidth * 1 / 2
      } else if attachmentCount > 2 {
        size.width = contentWidth * 2 / 3
      }
    case 1:
      size.width = contentWidth * 1 / 2
      if attachmentCount > 2 {
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
