import UIKit

@objc public protocol WallDelegate {

  // MARK: Scrolling

  optional func wallDidScrollToEnd(completion: () -> Void)

  // MARK: Touch

  optional func wallPostAuthorWasTapped(sender: AnyObject)
  optional func wallPostDateWasTapped(sender: AnyObject)
  optional func wallPostTextWasTapped(sender: AnyObject)
  optional func wallPostAttachmentWasTapped(sender: AnyObject)
  optional func wallPostLikesWasTapped(sender: AnyObject)
  optional func wallPostViewsWasTapped(sender: AnyObject)
  optional func wallPostCommentsWasTapped(sender: AnyObject)

}
