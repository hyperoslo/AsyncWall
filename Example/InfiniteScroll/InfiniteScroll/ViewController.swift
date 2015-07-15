import UIKit
import Wall
import Faker
import Sugar

class ViewController: WallController {

  let faker = Faker()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Infinite Scroll"

    config.wall.post.text.textAttributes[NSForegroundColorAttributeName] = UIColor.darkTextColor()
    config.wall.thumbnailForAttachment = {
      (attachment: Attachable, size: CGSize) -> URLStringConvertible? in
      var string: URLStringConvertible?
      
      if let thumbnail = attachment.thumbnail {
        string = String(format: thumbnail.string, Int(size.width), Int(size.height))
      }

      return string
    }

    self.tapDelegate = self
    self.scrollDelegate = self

    delay(0.1) {
      self.posts = self.generatePosts(1, to: 50)
    }
  }

  func generatePosts(from: Int, to: Int) -> [Postable] {
    var posts = [Post]()
    var startFrom = self.posts.count
    for i in from...to {
      let user = User(
        fullName: faker.name.name(),
        avatar: Image("http://lorempixel.com/%d/%d?type=avatar&id=\(i)"))
      var attachments = [Attachable]()
      var comments = [Post]()
      var attachmentCount = 0
      var likes = 0
      var commentCount = 0
      var seen = 0
      var group = Group(name: faker.team.name())
      var location = Location(name:faker.address.city())

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
        attachments.append(Image("http://lorempixel.com/%d/%d/?type=attachment&id=\(i)\(x)"))
      }

      let sencenceCount = Int(arc4random_uniform(8) + 1)
      let post = Post(
        text: faker.lorem.sentences(amount: sencenceCount),
        date: NSDate(timeIntervalSinceNow: -Double(arc4random_uniform(60000))),
        author: user,
        attachments: attachments
      )

      post.group = group
      post.location = location
      post.likeCount = likes
      post.seenCount = seen
      post.commentCount = commentCount

      for x in 0..<commentCount {
        let commentUser = User(
          fullName: faker.name.name(),
          avatar: Image("http://lorempixel.com/%d/%d/?type=avatar&id=\(i)\(x)"))
        var comment = Post(
          text: faker.lorem.sentences(amount: sencenceCount),
          date: NSDate(timeIntervalSinceNow: -4),
          author: commentUser
        )
      }

      posts.append(post)
    }

    return posts
  }
}

extension ViewController: WallTapDelegate {

  func wallPostWasTapped(element: TappedElement, index: Int?) {
    let post = self.postAtIndex(index!)

    if element == .Text || element == .Attachment {
      let detailView = DetailViewController(post: post!)
      self.navigationController?.pushViewController(detailView, animated: true)
    }
  }
}

extension ViewController: WallScrollDelegate {

  func wallDidScrollToEnd(completion: () -> Void) {
    var newPosts = generatePosts(0, to: 20)
    var updatedPosts = self.posts
    updatedPosts.extend(newPosts)

    self.posts = updatedPosts

    let delayTime = dispatch_time(DISPATCH_TIME_NOW,
      Int64(1 * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      completion()
    }
  }
}
