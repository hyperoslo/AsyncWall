import Foundation
import UIKit

public struct Config {

  private static var dateFormatter: NSDateFormatter = {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM-dd"
    return dateFormatter
    }()

  public struct Wall {

    public static var padding: CGFloat = 10
    public static var headerHeight: CGFloat = 40
    public static var authorImageSize: CGFloat = 32
    public static var thumbnailRatio: CGFloat = 3 / 2
    public static var thumbnailPadding: CGFloat = 10
    public static var showAttachmentsCounter = true

    public static var roundedAuthorImage = true
    public static var showDate = true

    public static var thumbnailForAttachment: (attachment: Attachment, size: CGSize) -> URLStringConvertible = {
      (attachment: Attachment, size: CGSize) -> URLStringConvertible in
      return attachment.thumbnail
    }

    public static var stringFromPostDate: (date: NSDate) -> String = {
      (date: NSDate) -> String in
      return Config.dateFormatter.stringFromDate(date)
    }

    public struct Post {
        public static var backgroundColor = UIColor.whiteColor()

        public struct Divider {
            public static var enabled = true
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

    public struct TextAttributes {

      public static var authorName = [
        NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
        NSForegroundColorAttributeName: UIColor.blackColor()
      ]

      public static var date = [
        NSFontAttributeName: UIFont.italicSystemFontOfSize(12),
        NSForegroundColorAttributeName: UIColor.grayColor()
      ]

      public static var attachmentCounter = [
        NSFontAttributeName: UIFont.systemFontOfSize(14),
        NSForegroundColorAttributeName: UIColor.grayColor()
      ]

      public static var postText = [
        NSFontAttributeName: UIFont.systemFontOfSize(14),
        NSForegroundColorAttributeName: UIColor.grayColor()
      ]

      public static var likes = [
        NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
        NSForegroundColorAttributeName: UIColor.blackColor()
      ]

      public static var comments = [
        NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
        NSForegroundColorAttributeName: UIColor.blackColor()
      ]

      public static var views = [
        NSFontAttributeName: UIFont.italicSystemFontOfSize(12),
        NSForegroundColorAttributeName: UIColor.grayColor()
      ]
    }
  }
}
