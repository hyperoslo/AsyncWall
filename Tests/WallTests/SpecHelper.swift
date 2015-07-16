import Faker
import Sugar

class Image: Displayable {

  var source: URLStringConvertible
  var thumbnail: URLStringConvertible?

  init(_ source: URLStringConvertible, _ thumbnail: URLStringConvertible? = nil) {
    self.source = source
    self.thumbnail = thumbnail
  }
}


class Group: Groupable {

  var name: String
  var image: Displayable?

  init(name: String, image: Image? = nil) {
    self.name = name
    self.image = image
  }
}

class User: Profileable {

  var fullName: String
  var avatar: Displayable?

  init(fullName: String, avatar: Displayable? = nil) {
    self.fullName = fullName
    self.avatar = avatar
  }
}

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

  init(text: String = "", date: NSDate, author: Profileable? = nil,
    attachments: [Attachable] = []) {
      self.text = text
      self.publishDate = date
      self.author = author
      self.attachments = attachments
  }
}

struct SpecHelper {

  static var post: Post {
    let faker = Faker()

    let user = User(
      fullName: faker.name.name(),
      avatar: Image(faker.internet.url()))

    let coordinate = Coordinate(
      latitude: faker.address.latitude(),
      longitude: faker.address.longitude())

    var post = Post(
      text: faker.lorem.paragraph(sentencesAmount: 5),
      date: NSDate(),
      author: user,
      attachments: [Image(faker.internet.url())])

    post.group = Group(name: faker.team.name())
    post.location = Location(name: faker.address.city(), coordinate: coordinate)
    post.likeCount = 10
    post.seenCount = 10

    return post
  }
}
