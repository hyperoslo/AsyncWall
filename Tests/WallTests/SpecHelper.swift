import Faker

struct SpecHelper {

  static var post: Post {
    let faker = Faker()

    let user = User(
      name: faker.name.name(),
      avatar: Image(faker.internet.url()))

    let coordinate = Coordinate(
      latitude: (faker.address.latitude() as NSString).doubleValue,
      longitude: (faker.address.longitude() as NSString).doubleValue)

    var post = Post(
      text: faker.lorem.paragraph(sentencesAmount: 5),
      date: NSDate(),
      author: user,
      attachments: [Image(faker.internet.url())])

    post.group = Group(name: faker.team.name())
    post.location = Location(name: faker.address.city(), coordinate: coordinate)
    post.likes = 10
    post.seenCount = 10

    return post
  }
}
