import Wall
import Sugar

class Image: Displayable {

  var source: URLStringConvertible?
  var thumbnail: URLStringConvertible?

  init(_ source: URLStringConvertible?, _ thumbnail: URLStringConvertible? = nil) {
    self.source = source
    self.thumbnail = thumbnail
  }
}

class Group: Groupable {

  var name: String?
  var image: Displayable?

  init(name: String? = nil, image: Image? = nil) {
    self.name = name
    self.image = image
  }
}

class User: Profileable {

  var fullName: String?
  var avatar: Displayable?

  init(fullName: String? = nil, avatar: Displayable? = nil) {
    self.fullName = fullName
    self.avatar = avatar
  }
}

class Post: Postable {

  var id = 0
  var publishDate: NSDate?
  var text: String?
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

  init(text: String? = nil, date: NSDate? = nil, author: Profileable? = nil,
    attachments: [Attachable] = []) {
      self.text = text
      self.publishDate = date
      self.author = author
      self.attachments = attachments
  }
}
