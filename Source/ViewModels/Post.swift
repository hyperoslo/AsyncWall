import Foundation

public class Post {

  var author: User
  var publishedAt: NSDate
  var text: String?
  var attachments: [Attachment]?
  var likesAmount: Int = 0
  var viewsAmount: Int = 0
  var parent: Post?
  var comments = [Post]()

  public init(author: User, publishedAt: NSDate, text: String) {
    self.author = author
    self.publishedAt = publishedAt
    self.text = text
  }
}
