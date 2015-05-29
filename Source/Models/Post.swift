import Foundation

public class Post: NSObject {

  var author: User?
  var date: NSDate
  var text: String?
  var attachments: [Attachment]?
  var likes: Int = 0
  var views: Int = 0
  var parent: Post?
  var comments = [Post]()

  public init(text: String, date: NSDate, _ author: User? = nil, _ attachments: [Attachment]? = []) {
    self.text = text
    self.date = date
    self.author = author
    self.attachments = attachments
  }

}
