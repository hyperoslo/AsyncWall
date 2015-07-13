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

    public lazy var dateFormatter: NSDateFormatter = {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "MM-dd"
      return dateFormatter
      }()

    public var thumbnailForAttachment: (attachment: Attachment, size: CGSize) -> URLStringConvertible? = {
      (attachment: Attachment, size: CGSize) -> URLStringConvertible? in
      return attachment.thumbnail
    }

    public lazy var stringFromPostDate: (date: NSDate) -> String = {
      (date: NSDate) -> String in
      return self.dateFormatter.stringFromDate(date)
    }

    public var post = Post()
    public var comment = Comment()

    public struct Post {
      public var horizontalPadding: CGFloat = 10
      public var verticalPadding: CGFloat = 10
      public var backgroundColor = UIColor.whiteColor()
      public var header = Header()
      public var title = Title()
      public var attachments = Attachments()
      public var text = Text()
      public var footer = Footer()
      public var actionBar = ActionBar()
      public var control = Control()
      public var divider = Divider()

      public struct Header {
        public var enabled = true
        public var height: CGFloat = 40
        public var author = Author()
        public var group = Group()
        public var location = Location()
        public var date = Date()

        public struct Author {
          public var enabled = true
          public var horizontalPadding: CGFloat = 5
          public var verticalPadding: CGFloat = 1
          public var textAttributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
            NSForegroundColorAttributeName: UIColor.blackColor()
          ]
          public var avatar = Avatar()

          public struct Avatar {
            public var enabled = true
            public var size: CGFloat = 32
            public var rounded = true
            public var placeholderColor = UIColor.lightGrayColor()
          }
        }

        public struct Group {
          public var enabled = true
          public var textAttributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(12),
            NSForegroundColorAttributeName: UIColor.blackColor()
          ]
          public var divider = Divider()

          public struct Divider {
            public var enabled = true
            public var textAttributes = [
              NSFontAttributeName: UIFont.systemFontOfSize(12),
              NSForegroundColorAttributeName: UIColor.grayColor()
            ]
            public var text = ">"
          }
        }

        public struct Location {
          public var enabled = true
          public var textAttributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(12),
            NSForegroundColorAttributeName: UIColor.grayColor()
          ]
          public var icon = Icon()

          public struct Icon {
            public var enabled = true
            public var padding: CGFloat = 3
            public var size: CGFloat = 12
            public var image: UIImage?
          }
        }

        public struct Date {
          public var enabled = true
          public var textAttributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(12),
            NSForegroundColorAttributeName: UIColor.grayColor()
          ]
        }
      }

      public struct Title {
        public var enabled = false
        public var uppercase = false
        public var textAttributes = [
          NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
          NSForegroundColorAttributeName: UIColor.blackColor(),
          NSParagraphStyleAttributeName: {
            var style = NSMutableParagraphStyle()
            style.alignment = .Center
            return style
            }()
        ]
      }

      public struct Attachments {
        public enum GridType {
          case Regular, FullWidth, SingleFullWidth
        }

        public var ratio: CGFloat = 3 / 2
        public var padding: CGFloat = 10
        public var gridType = GridType.Regular
        public var counter = Counter()

        public struct Counter {
          public var enabled = true
          public var backgroundColor = UIColor(white: 0, alpha: 0.5)
          public var textAttributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(34),
            NSForegroundColorAttributeName: UIColor.whiteColor()
          ]
        }
      }

      public struct Text {
        public var textAttributes = [
          NSFontAttributeName: UIFont.systemFontOfSize(14),
          NSForegroundColorAttributeName: UIColor.grayColor()
        ]
      }

      public struct Footer {
        public var enabled = true
        public var height: CGFloat = 40
        public var horizontalPadding: CGFloat = 10
        public var likes = Likes()
        public var comments = Comments()
        public var seen = Seen()

        public struct Likes {
          public var enabled = true
          public var textAttributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
            NSForegroundColorAttributeName: UIColor.blackColor()
          ]
        }

        public struct Comments {
          public var enabled = true
          public var textAttributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
            NSForegroundColorAttributeName: UIColor.blackColor()
          ]
        }

        public struct Seen {
          public var enabled = true
          public var text = NSLocalizedString("Seen by", comment: "")
          public var textAttributes = [
            NSFontAttributeName: UIFont.italicSystemFontOfSize(12),
            NSForegroundColorAttributeName: UIColor.grayColor()
          ]
        }
      }

      public struct ActionBar {
        public var enabled = true
        public var dividerEnabled = true
        public var height: CGFloat = 40
        public var backgroundColor = UIColor.clearColor()
        public var likeButton = LikeButton()
        public var commentButton = CommentButton()

        public struct LikeButton {
          public var enabled = true
          public var title: String? = NSLocalizedString("Like", comment: "")
          public var image: UIImage?
          public var textAttributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
            NSForegroundColorAttributeName: UIColor.lightGrayColor()
          ]
        }

        public struct CommentButton {
          public var enabled = true
          public var title: String? = NSLocalizedString("Comment", comment: "")
          public var image: UIImage?
          public var textAttributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
            NSForegroundColorAttributeName: UIColor.lightGrayColor()
          ]
        }
      }

      public struct Control {
        public var size = CGSize(width: 100.0, height: 35.0)
        public var padding: CGFloat = 5
        public var imageSize = CGSize(width: 22, height: 22)
      }

      public struct Divider {
        public var enabled = true
        public var height: CGFloat = 1
        public var backgroundColor = UIColor.lightGrayColor()
      }
    }

    public struct Comment {
      public var backgroundColor =  UIColor(red:0.969, green:0.973, blue:0.976, alpha: 1)
      public var divider = Divider()

      public struct Divider {
        public var enabled = true
        public var backgroundColor = UIColor(red:0.925, green:0.933, blue:0.941, alpha: 1)
      }
    }
  }
}
