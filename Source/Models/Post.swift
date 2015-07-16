import Foundation

public protocol PostConvertible {
  func toPost() -> Post
}

public struct Post {

  public var id = 0
  public var publishDate = NSDate()
  public var text = ""
  public var liked = false
  public var seen = false
  public var likeCount = 0
  public var seenCount = 0
  public var commentCount = 0
  public var author: UserConvertible?
  public var group: GroupConvertible?
  public var location: Location?
  public var parent: PostConvertible?

  public var attachments = [Attachable]()
  public var comments = [PostConvertible]()

  init(text: String = "", date: NSDate, author: UserConvertible? = nil,
    attachments: [Attachable] = []) {
      self.text = text
      self.publishDate = date
      self.author = author
      self.attachments = attachments
  }
}

// MARK: - PostConvertible

extension Post: PostConvertible {

  public func toPost() -> Post {
    return self
  }
}
