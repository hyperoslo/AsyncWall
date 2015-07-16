import Wall
import Sugar

class Post {

  var id = 0
  var publishDate = NSDate()
  var text: String

  init(text: String, date: NSDate = NSDate()) {
    self.text = text
    self.publishDate = date
  }
}

extension Post: PostConvertible {

  var wallModel: Wall.Post {
    return Wall.Post(text: text, publishDate: publishDate)
  }
}
