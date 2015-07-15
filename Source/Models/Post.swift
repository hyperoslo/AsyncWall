import Foundation

public class Post: NSObject {

  public var author: Profileable?
  public var date: NSDate?
  public var group: Groupable?
  public var location: Location?
  public var title: String?
  public var text: String?
  public var attachments: [Attachable]?
  public var likes: Int = 0
  public var seen: Int = 0
  public var read = false
  public var parent: Post?
  public var comments = [Post]()

  public init(text: String? = nil, date: NSDate? = nil, author: Profileable? = nil,
    attachments: [Attachable]? = nil) {
      self.text = text
      self.date = date
      self.author = author
      self.attachments = attachments
  }
}
