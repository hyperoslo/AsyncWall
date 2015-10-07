import Fakery
import Sugar

struct SpecHelper {

  static var post: Post {
    let faker = Faker()

    let user = User(
      name: faker.name.name(),
      avatar: Image(faker.internet.url()))

    let post = Post(
      text: faker.lorem.paragraph(sentencesAmount: 5),
      publishDate: NSDate(),
      author: user,
      attachments: [Image(faker.internet.url())])

    post.likeCount = 10
    post.seenCount = 10

    return post
  }
}
