import Foundation

public class Post: NSObject {

  public var author: User?
  public var date: NSDate
  public var group: String?
  public var location: String?
  public var text: String?
  public var attachments: [Attachment]?
  public var likes: Int = 0
  public var views: Int = 0
  public var parent: Post?
  public var comments = [Post]()

  public init(text: String, date: NSDate, author: User? = nil,
    group: String? = nil, location: String? = nil, attachments: [Attachment]? = nil) {
      self.text = text
      self.date = date
      self.author = author
      self.group = group
      self.location = location
      self.attachments = attachments
  }
}
