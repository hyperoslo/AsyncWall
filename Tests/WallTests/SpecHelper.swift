import Faker
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


struct SpecHelper {

  static var post: Post {
    let faker = Faker()

    let user = User(
      name: faker.name.name(),
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
    post.likes = 10
    post.seen = 10

    return post
  }
}
