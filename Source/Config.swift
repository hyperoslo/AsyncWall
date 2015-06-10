import Foundation
import UIKit
import Haneke
import TimeAgo

public struct Config {

  private static var dateFormatter: NSDateFormatter = {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM-dd"
    return dateFormatter
    }()

  public struct Cache {

    public struct Thumbnails {
      public static var format = "wall-thumbnails"
      public static var storage: Haneke.Cache<UIImage> {
        let cache = Shared.imageCache
        let format = Format<UIImage>(name: Cache.Thumbnails.format, diskCapacity: 20 * 1024 * 1024)
        cache.addFormat(format)

        return cache
      }
    }
  }

  public struct Wall {
    public static var padding: CGFloat = 10

    public static var thumbnailForAttachment: (attachment: Attachment, size: CGSize) -> URLStringConvertible = {
      (attachment: Attachment, size: CGSize) -> URLStringConvertible in
      return attachment.thumbnail
    }

    public static var stringFromPostDate: (date: NSDate) -> String = {
      (date: NSDate) -> String in
      return date.timeAgo
    }

    public struct Post {
      public static var backgroundColor = UIColor.whiteColor()

      public struct Header {
        public static var enabled = true
        public static var height: CGFloat = 40

        public struct Author {
          public static var enabled = true
          public static var horizontalPadding: CGFloat = 5
          public static var verticalPadding: CGFloat = 1
          public static var textAttributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
            NSForegroundColorAttributeName: UIColor.blackColor()
          ]

          public struct Avatar {
            public static var enabled = true
            public static var size: CGFloat = 32
            public static var rounded = true
            public static var placeholderColor = UIColor.lightGrayColor()
          }
        }

        public struct Group {
          public static var enabled = true
          public static var textAttributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
            NSForegroundColorAttributeName: UIColor.blackColor()
          ]

          public struct Divider {
            public static var enabled = true
            public static var textAttributes = [
              NSFontAttributeName: UIFont.systemFontOfSize(12),
              NSForegroundColorAttributeName: UIColor.grayColor()
            ]
            public static var text = ">"
          }
        }

        public struct Location {
          public static var enabled = true
          public static var textAttributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(12),
            NSForegroundColorAttributeName: UIColor.grayColor()
          ]

          public struct Icon {
            public static var enabled = true
            public static var padding: CGFloat = 3
            public static var size: CGFloat = 12
            public static var image: UIImage?
          }
        }

        public struct Date {
          public static var enabled = true
          public static var textAttributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(12),
            NSForegroundColorAttributeName: UIColor.grayColor()
          ]
        }
      }

      public struct Attachments {
        public static var ratio: CGFloat = 3 / 2
        public static var padding: CGFloat = 10

        public struct Counter {
          public static var enabled = true
          public static var padding: CGFloat = 3
          public static var boxSize = CGSize(width: 40.0, height: 30.0)
          public static var boxGap: CGFloat = 3
          public static var textAttributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(14),
            NSForegroundColorAttributeName: UIColor.grayColor()
          ]
        }
      }

      public struct Text {
        public static var textAttributes = [
          NSFontAttributeName: UIFont.systemFontOfSize(14),
          NSForegroundColorAttributeName: UIColor.grayColor()
        ]
      }

      public struct Footer {
        public static var enabled = true
        public static var height: CGFloat = 40
        public static var horizontalPadding: CGFloat = 10

        public struct Likes {
          public static var enabled = true
          public static var textAttributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
            NSForegroundColorAttributeName: UIColor.blackColor()
          ]
        }

        public struct Comments {
          public static var enabled = true
          public static var textAttributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
            NSForegroundColorAttributeName: UIColor.blackColor()
          ]
        }

        public struct Seen {
          public static var enabled = true
          public static var text = NSLocalizedString("Seen by", comment: "")
          public static var textAttributes = [
            NSFontAttributeName: UIFont.italicSystemFontOfSize(12),
            NSForegroundColorAttributeName: UIColor.grayColor()
          ]
        }
      }

      public struct ActionBar {
        public static var enabled = true
        public static var dividerEnabled = true
        public static var height: CGFloat = 40
        public static var backgroundColor = UIColor.clearColor()

        public struct LikeButton {
          public static var enabled = true
          public static var title: String? = NSLocalizedString("Like", comment: "")
          public static var image: UIImage?
          public static var textAttributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
            NSForegroundColorAttributeName: UIColor.lightGrayColor()
          ]
        }

        public struct CommentButton {
          public static var enabled = true
          public static var title: String? = NSLocalizedString("Comment", comment: "")
          public static var image: UIImage?
          public static var textAttributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
            NSForegroundColorAttributeName: UIColor.lightGrayColor()
          ]
        }
      }

      public struct Control {
        public static var size = CGSize(width: 100.0, height: 35.0)
        public static var padding: CGFloat = 5
        public static var imageSize = CGSize(width: 22, height: 22)
      }

      public struct Divider {
        public static var enabled = true
        public static var height: CGFloat = 1
        public static var backgroundColor = UIColor.lightGrayColor()
      }
    }

    public struct Comment {
      public static var backgroundColor =  UIColor(red:0.969, green:0.973, blue:0.976, alpha: 1)

      public struct Divider {
        public static var enabled = true
        public static var backgroundColor = UIColor(red:0.925, green:0.933, blue:0.941, alpha: 1)
      }
    }
  }
}
