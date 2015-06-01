import Foundation
import UIKit
import Haneke

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

    public static var useDivider = true
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
