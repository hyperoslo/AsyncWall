import UIKit

public enum TappedElement {
  case Post, Author, Date, Text, Attachment,
    Likes, Seen, Comments, LikeButton, CommentButton
}

public protocol WallTapDelegate {

  func wallPostWasTapped(element: TappedElement, index: Int?)
}

public protocol WallScrollDelegate {

  func wallDidScrollToEnd(completion: () -> Void)
}
