import UIKit

public enum TappedElement {
  case Author, Date, Text, Attachment, Likes, Views, Comments
}

public protocol WallDelegate {

  // MARK: Scrolling

  func wallDidScrollToEnd(completion: () -> Void)

  // MARK: Touch

  func wallPostWasTapped(element: TappedElement, sender: AnyObject)

}
