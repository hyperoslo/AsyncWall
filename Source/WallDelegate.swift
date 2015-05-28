import UIKit

@objc public protocol WallDelegate {

  optional func wallDidScrollToEnd(completion: () -> Void)

}
