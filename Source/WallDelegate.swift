import UIKit

@objc public protocol WallDelegate {

  // MARK: Scrolling

  optional func wallDidScrollToEnd(completion: () -> Void)

  // MARK: Touch

  optional func wallPostAuthorWasTapped()
  optional func wallPostDateWasTapped()
  optional func wallPostTextWasTapped()
  optional func wallPostAttachmentWasTapped()
  optional func wallPostLikesWasTapped()
  optional func wallPostViewsWasTapped()
  optional func wallPostCommentsWasTapped()

}
