import UIKit
import AsyncDisplayKit

public class AttachmentGridNode: ASDisplayNode {

  public let width: CGFloat
  public let attachments: [Attachment]

  var imageNodes = [ASImageNode]()

  public var height: CGFloat {
    return width / Config.Wall.thumbnailRatio
  }

  public var contentWidth: CGFloat {
    return width - Config.Wall.thumbnailPadding
  }

  public var contentHeight: CGFloat {
    return height - Config.Wall.thumbnailPadding
  }

  public init(attachments: [Attachment], width: CGFloat) {
    self.attachments = attachments.count < 4 ? attachments : Array(attachments[0..<3])
    self.width = width

    super.init()

    for (index, attachment) in enumerate(attachments) {
      let imageNode = ASImageNode()
      imageNode.backgroundColor = .grayColor()
      let imageSize = sizeForThumbnailAtIndex(index)
      imageNode.fetchImage(Config.Wall.thumbnailForAttachment(attachment: attachment,
        size: CGSize(width: imageSize.width, height: imageSize.height)).url)
      imageNodes.append(imageNode)
      addSubnode(imageNode)
    }
  }

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
        x += imageSize.width + Config.Wall.thumbnailPadding
      } else if index == 1 {
        y += imageSize.height + Config.Wall.thumbnailPadding
      }
    }
  }

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
