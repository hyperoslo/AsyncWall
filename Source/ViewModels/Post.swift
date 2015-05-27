import Foundation

public class Post {

  var author: User
  var publishedAt: NSDate
  var text: String?
  var attachments: [Attachment]?
  var likes: Int = 0
  var views: Int = 0
  var parent: Post?
  var comments = [Post]()

  public init(author: User, publishedAt: NSDate, text: String, _ attachments: [Attachment]? = []) {
    self.author = author
    self.publishedAt = publishedAt
    self.text = text
  }
}
