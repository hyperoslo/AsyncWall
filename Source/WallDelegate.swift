import UIKit

public enum TappedElement {
  case Author, Group, Date, Location, Text, Attachment, Likes, SeenCount, Comments
}

public protocol WallTapDelegate {

  func wallPostWasTapped(element: TappedElement, index: Int?)
}

public protocol WallScrollDelegate {

  func wallDidScrollToEnd(completion: () -> Void)
}
