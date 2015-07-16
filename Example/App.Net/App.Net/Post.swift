import Wall
import Sugar

class Post: Postable {

  var id = 0
  var publishDate = NSDate()
  var text = ""
  var liked = false
  var seen = false
  var likeCount = 0
  var seenCount = 0
  var commentCount = 0
  var author: Profileable?
  var group: Groupable?
  var location: Location?
  var parent: Postable?
  var attachments = [Attachable]()
  var comments = [Postable]()

  init(text: String = "", date: NSDate = NSDate()) {
    self.text = text
    self.publishDate = date
  }
}
