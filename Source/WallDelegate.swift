import UIKit

@objc public protocol WallDelegate {

  optional func wallDidScrollToEnd(completion: () -> Void)
  optional func wallPostWasTapped(indexPath: NSIndexPath)

}
