import Foundation
import UIKit
import Haneke
import Sugar

public class Config {
  public var cache = Cache()
  public var wall = Wall()

  public init() {}

  public struct Cache {

    public struct Thumbnails {
      public static var format = "wall-thumbnails"
      public static var storage: Haneke.Cache<UIImage> {
        let cache = Shared.imageCache
        let format = Format<UIImage>(name: self.format, diskCapacity: 20 * 1024 * 1024)
        cache.addFormat(format)

        return cache
      }
    }
  }

  public struct Wall {

    

    public static var thumbnailForAttachment: (attachment: Attachable, size: CGSize) -> URLStringConvertible? = {
      (attachment: Attachable, size: CGSize) -> URLStringConvertible? in
      return attachment.thumbnail
    }

    public var post = Post()
    public var comment = Comment()

    public struct Post {
      public var CellClass: WallCellNode.Type = PostCellNode.self
      public var HeaderClass: WallPostHeaderNode.Type = PostHeaderNode.self

      public var text = Text()
      public var divider = Divider()

      public struct Text {
        public var textAttributes = [
          NSFontAttributeName: UIFont.systemFontOfSize(14),
          NSForegroundColorAttributeName: UIColor.grayColor()
        ]
      }


      

      public struct Divider {
        public var enabled = true
        public var height: CGFloat = 1
        public var backgroundColor = UIColor.lightGrayColor()
      }
    }

    public struct Comment {
      public var CellClass: WallCellNode.Type = CommentCellNode.self

      public var backgroundColor =  UIColor(red:0.969, green:0.973, blue:0.976, alpha: 1)
      public var divider = Divider()

      public struct Divider {
        public var enabled = true
        public var backgroundColor = UIColor(red:0.925, green:0.933, blue:0.941, alpha: 1)
      }
    }
  }
}
