import Foundation

public protocol PostConvertible {
  var wallModel: Post { get }
}

public class Post {

  public var id = 0
  public var publishDate = NSDate()
  public var text = ""
  public var liked = false
  public var seen = false
  public var likeCount = 0
  public var seenCount = 0
  public var commentCount = 0
  public var author: UserConvertible?
  public var parent: PostConvertible?

  public var attachments = [AttachmentConvertible]()
  public var comments = [PostConvertible]()

  public init(text: String = "", publishDate: NSDate, author: UserConvertible? = nil,
    attachments: [AttachmentConvertible] = []) {
      self.text = text
      self.publishDate = publishDate
      self.author = author
      self.attachments = attachments
  }
}

// MARK: - PostConvertible

extension Post: PostConvertible {

  public var wallModel: Post {
    return self
  }
}
