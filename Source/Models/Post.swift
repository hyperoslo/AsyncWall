import Foundation

public class Post: NSObject {

  public var author: User?
  public var date: NSDate
  public var text: String?
  public var attachments: [Attachment]?
  public var likes: Int = 0
  public var views: Int = 0
  public var parent: Post?
  public var comments = [Post]()

  public init(text: String, date: NSDate, _ author: User? = nil, _ attachments: [Attachment]? = []) {
    self.text = text
    self.date = date
    self.author = author
    self.attachments = attachments
  }

}
