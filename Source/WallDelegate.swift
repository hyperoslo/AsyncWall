import UIKit

public enum TappedElement {
  case Author, Date, Text, Attachment, Likes, Views, Comments
}

public protocol WallTapDelegate {

  func wallPostWasTapped(element: TappedElement, sender: AnyObject)

}

public protocol WallScrollDelegate {

  func wallDidScrollToEnd(completion: () -> Void)

}
