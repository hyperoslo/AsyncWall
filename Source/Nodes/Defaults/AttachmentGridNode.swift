import UIKit
import AsyncDisplayKit

public class AttachmentGridNode: PostComponentNode {

  public let attachments: [AttachmentConvertible]

  public var imageNodeCount = 0
  public var postAttachmentCount = 0

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

  public lazy var textNode: ASTextNode = { [unowned self] in
    let node = ASTextNode()

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .Center

    let attributes = [
      NSFontAttributeName: UIFont.systemFontOfSize(34),
      NSForegroundColorAttributeName: UIColor.whiteColor(),
      NSParagraphStyleAttributeName: paragraphStyle,
      //todo: center text in TextNode
      NSBaselineOffsetAttributeName: -34
    ]

    let text = "+\(self.postAttachmentCount - 3)"

    node.attributedString = NSAttributedString(string: text, attributes: attributes)
    node.userInteractionEnabled = false
    node.layerBacked = true
    node.shouldRasterizeDescendants = true
    return node
  }()

  // MARK: - Image Cache

  public lazy var downloader = ImageCache()

  // MARK: - Initialization

  public required init(post: Post, width: CGFloat) {
    attachments = Array(post.attachments.prefix(3))
    postAttachmentCount = post.attachments.count
    imageNodeCount = min(postAttachmentCount, 3)

    super.init(post: post, width: width)
  }

  // MARK: - ConfigurableNode

  public override func configureNode() {
    for attachment in attachments {
      let imageNode = ASNetworkImageNode(cache: nil, downloader: downloader)
      imageNode.backgroundColor = .grayColor()
      imageNode.URL = attachment.wallModel.thumbnail.url
      imageNode.layerBacked = true
//      imageNode.shouldRasterizeDescendants = true
      imageNodes.append(imageNode)
      addSubnode(imageNode)
    }

    if postAttachmentCount > 3 {
      let nodeToDarken = imageNodes.last!

      nodeToDarken.imageModificationBlock = { inputImage in
        if (inputImage.size.width < 1 || inputImage.size.height < 1) {
          print("*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", inputImage.size.width, inputImage.size.height, inputImage)
          return nil
        }

        if inputImage.CGImage == nil {
          print("*** error: inputImage must be backed by a CGImage: %@", inputImage)
          return nil
        }

        let inputCGImage = inputImage.CGImage
        let inputImageScale = inputImage.scale

        let outputImageSizeInPoints = inputImage.size
        let outputImageRectInPoints = CGRect(origin: CGPoint.zero, size: outputImageSizeInPoints)

        UIGraphicsBeginImageContextWithOptions(outputImageRectInPoints.size, false, inputImageScale)

        let outputContext = UIGraphicsGetCurrentContext()
        CGContextScaleCTM(outputContext, 1.0, -1.0)
        CGContextTranslateCTM(outputContext, 0, -outputImageRectInPoints.size.height)
        CGContextDrawImage(outputContext, outputImageRectInPoints, inputCGImage)
        CGContextSaveGState(outputContext)

        let blackTintColor = UIColor(white: 0, alpha: 0.5).CGColor
        CGContextSetFillColorWithColor(outputContext, blackTintColor)
        CGContextFillRect(outputContext, outputImageRectInPoints)
        CGContextRestoreGState(outputContext)

        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        //TODO: check if context is being end in all cases.

        return outputImage
      }

      addSubnode(textNode)
    }
  }

  public override func calculateLayoutThatFits(constrainedSize: ASSizeRange) -> ASLayout! {
    var position = CGPoint(x: 0, y: 0)
    var imageSize = CGSize.zero

    var layouts = [ASLayout]()

    for (index, imageNode) in imageNodes.enumerate() {
      imageSize = sizeForThumbnailAtIndex(index)

      let layout = ASLayout(layoutableObject: imageNode, size: imageSize, position: position, sublayouts: nil)
      layouts.append(layout)

      if index == 0 {
        position.x += imageSize.width + padding
      } else if index == 1 {
        position.y += imageSize.height + padding
      }
    }

    if postAttachmentCount > 3 {
      let layoutObj = ASLayout(layoutableObject: textNode, size: imageSize, position: position, sublayouts: nil)
      layouts.append(layoutObj)
    }

    return ASLayout(layoutableObject: self,
      size: CGSize(width: constrainedSize.max.width, height: contentHeight + padding), //TODO: fix padding issue - contentheight should be real content height, make SELF red to debug
      position: CGPoint.zero,
      sublayouts: layouts)
  }

   //MARK: - Private Methods

  func sizeForThumbnailAtIndex(index: Int) -> CGSize {
    var size = CGSize(width: width, height: height)

    switch index {
    case 0:
      if imageNodeCount == 2 {
        size.width = contentWidth / 2
      } else if imageNodeCount > 2 {
        size.width = contentWidth * 2 / 3
      }
    case 1:
      size.width = contentWidth / 2
      if imageNodeCount > 2 {
        size.width = contentWidth / 3
        size.height = contentHeight / 2
      }
    default:
      size.width = contentWidth / 3
      size.height = contentHeight / 2
    }

    return size
  }
}
