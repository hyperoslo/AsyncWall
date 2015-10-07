import UIKit
import Wall
import Faker
import Sugar

class ViewController: WallController {

  let faker = Faker()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Infinite Scroll"

    Config.thumbnailForAttachment = {
      (attachment: Attachable, size: CGSize) -> URLStringConvertible? in
      return String(format: attachment.source.string, Int(size.width), Int(size.height))
    }

    tapDelegate = self
    scrollDelegate = self
    posts = generatePosts(1, to: 50)


  }

  func generatePosts(from: Int, to: Int) -> [PostConvertible] {
    var posts = [PostConvertible]()
    for i in from...to {
      let user = User(
        name: faker.name.name(),
        avatar: Image("http://lorempixel.com/75/75?type=avatar&id=\(i)"))
      var attachments = [AttachmentConvertible]()
      var comments = [PostConvertible]()
      var attachmentCount = 0
      var likes = 0
      var commentCount = 0
      var seen = 0

      if i % 4 == 0 {
        attachmentCount = 4
        commentCount = 3
        likes = 3
        seen = 4
      } else if i % 3 == 0 {
        attachmentCount = 2
        commentCount = 1
        likes = 1
        seen = 2
      } else if i % 2 == 0 {
        attachmentCount = 1
        commentCount = 4
        likes = 4
        seen = 6
      }

      for x in 0..<attachmentCount {
        attachments.append(Image("http://lorempixel.com/250/250/?type=attachment&id=\(i)\(x)"))
      }

      let sencenceCount = Int(arc4random_uniform(8) + 1)
      let post = Post(
        text: faker.lorem.sentences(amount: sencenceCount),
        publishDate: NSDate(timeIntervalSinceNow: -Double(arc4random_uniform(60000))),
        author: user,
        attachments: attachments
      )

      post.likeCount = likes
      post.seenCount = seen
      post.commentCount = commentCount

      for x in 0..<commentCount {
        let commentUser = User(
          name: faker.name.name(),
          avatar: Image("http://lorempixel.com/75/75/?type=avatar&id=\(i)\(x)"))
        let comment = Post(
          text: faker.lorem.sentences(amount: sencenceCount),
          publishDate: NSDate(timeIntervalSinceNow: -4),
          author: commentUser
        )
        comments.append(comment)
      }
      post.comments = comments

      posts.append(post)
    }

    return posts
  }
}

extension ViewController: WallTapDelegate {

  func wallPostWasTapped(element: TappedElement, post: Post) {
    guard let index = posts.indexOf( { $0.wallModel.id == post.id } ), post = posts[index] as? Post else { return }

    switch element {
    case .Attachment:
      let detailView = DetailViewController(post: post)
      self.navigationController?.pushViewController(detailView, animated: true)
    case .Text:
      let detailView = DetailViewController(post: post)
      self.navigationController?.pushViewController(detailView, animated: true)
    default: break
    }
  }
}

extension ViewController: WallScrollDelegate {

  func wallDidScrollToEnd(completion: () -> Void) {
    let newPosts = generatePosts(0, to: 20)
    var updatedPosts = self.posts
    updatedPosts.appendContentsOf(newPosts)

    self.posts = updatedPosts

    let delayTime = dispatch_time(DISPATCH_TIME_NOW,
      Int64(1 * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      completion()
    }
  }
}
