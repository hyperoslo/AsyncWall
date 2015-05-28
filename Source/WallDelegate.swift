import UIKit

@objc public protocol WallDelegate {

  optional func wallDidScrollToEnd(completion: () -> Void)

  optional func wallPostAuthorWasTapped()
  optional func wallPostDateWasTapped()
  optional func wallPostTextWasTapped()
  optional func wallPostAttachmentWasTapped()
  optional func wallPostLikesWasTapped()
  optional func wallPostViewsWasTapped()
  optional func wallPostCommentsWasTapped()

}
