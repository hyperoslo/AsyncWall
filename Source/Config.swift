import Foundation
import UIKit

public struct Config {

  public struct Wall {

    public static var useDivider = true
    public static var padding: CGFloat = 10
    public static var authorImageSize = 64

    public struct TextAttributes {

      public static var authorName = [
        NSFontAttributeName: UIFont.boldSystemFontOfSize(14),
        NSForegroundColorAttributeName: UIColor.blackColor()
      ]

      public static var date = [
        NSFontAttributeName: UIFont.italicSystemFontOfSize(12),
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

  public struct Detail {

  }
}
