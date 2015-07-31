import Foundation
import UIKit
import Haneke
import Sugar

public class Config {

  public static var thumbnailForAttachment: (attachment: Attachable, size: CGSize) -> URLStringConvertible? = {
    (attachment: Attachable, size: CGSize) -> URLStringConvertible? in
    return attachment.thumbnail
  }

  public var post = Post()
  public var comment = Comment()
  public var imageCache = ImageCache()

  public struct Post {
    public var CellClass: WallCellNode.Type = PostCellNode.self
    public var HeaderClass: WallPostHeaderNode.Type = PostHeaderNode.self
    public var FooterClass: WallPostFooterNode.Type = PostFooterNode.self
  }

  public struct Comment {
    public var CellClass: WallCellNode.Type = PostCellNode.self
  }

  public init() {}

  public struct ImageCache {
    public static var format = "wall-thumbnails"
    public static var storage: Haneke.Cache<UIImage> {
      let cache = Shared.imageCache
      let format = Format<UIImage>(name: self.format, diskCapacity: 20 * 1024 * 1024)
      cache.addFormat(format)

      return cache
    }
  }
}
