import UIKit

@objc public protocol WallTapDelegate {

  optional func wallPostWasTapped(element: TappedElement, sender: AnyObject)

}

@objc public protocol WallScrollDelegate {

	func wallDidScrollToEnd(completion: () -> Void)

}
