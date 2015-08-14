import UIKit

public enum TappedElement {
  case Post, Author, Date, Text, Attachment,
    Likes, Seen, Comments, LikeButton, CommentButton, UserDefined(String)
}

public protocol WallTapDelegate: class {

  func wallPostWasTapped(element: TappedElement, index: Int?)
}

public protocol WallScrollDelegate: class {

  func wallDidScrollToEnd(completion: () -> Void)
}
