import Foundation

public class Post {

  var author: User
  var date: NSDate
  var text: String?
  var attachments: [Attachment]?
  var likes: Int = 0
  var views: Int = 0
  var parent: Post?
  var comments = [Post]()

  public init(author: User, date: NSDate, text: String, _ attachments: [Attachment]? = []) {
    self.author = author
    self.date = date
    self.text = text
  }
}
