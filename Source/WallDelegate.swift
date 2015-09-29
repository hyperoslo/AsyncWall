import UIKit

public enum TappedElement {
  case Post, Author, Date, Text, Attachment,
    Likes, Seen, Comments, LikeButton, CommentButton, UserDefined(String)
}

public protocol WallTapDelegate: class {

  func wallPostWasTapped(element: TappedElement, post: Post)
}

public protocol WallScrollDelegate: class {

  func wallDidScrollToEnd(completion: () -> Void)
}
