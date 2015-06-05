import UIKit
import Wall
import Faker

class ViewController: WallController, WallTapDelegate, WallScrollDelegate {

  let faker = Faker()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Infinite Scroll"

    Config.Wall.Post.Text.textAttributes[NSForegroundColorAttributeName] = UIColor.darkTextColor()
    Config.Wall.thumbnailForAttachment = {
      (attachment: Attachment, size: CGSize) -> URLStringConvertible in
      return String(format: attachment.thumbnail.string, Int(size.width), Int(size.height))
    }

    self.delegate = self
    let delayTime = dispatch_time(DISPATCH_TIME_NOW,
      Int64(0.1 * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      self.posts = self.generatePosts(1, to: 50)
    }
  }

  func generatePosts(from: Int, to: Int) -> [Post] {
    var posts = [Post]()
    var startFrom = self.posts.count
    for i in from...to {
      let user = User(
        name: faker.name.name(),
        avatar: Image("http://lorempixel.com/%d/%d?type=avatar&id=\(i)"))
      var attachments = [Attachment]()
      var comments = [Post]()
      var attachmentCount = 0
      var commentCount = 0
      var group = Group(name: faker.team.name())
      var location = Location(name:faker.address.city())

      if i % 4 == 0 {
        attachmentCount = 4
        commentCount = 3
      } else if i % 3 == 0 {
        attachmentCount = 2
        commentCount = 1
      } else if i % 2 == 0 {
        attachmentCount = 1
        commentCount = 4
      }

      for x in 0..<attachmentCount {
        attachments.append(Image("http://lorempixel.com/%d/%d/?type=attachment&id=\(i)\(x)"))
      }

      let sencenceCount = Int(arc4random_uniform(8) + 1)
      let post = Post(
        text: faker.lorem.sentences(amount: sencenceCount),
        date: NSDate(timeIntervalSinceNow: -4),
        author: user,
        attachments: attachments
      )
      post.group = group
      post.location = location

      for x in 0..<commentCount {
        let commentUser = User(
          name: faker.name.name(),
          avatar: Image("http://lorempixel.com/%d/%d/?type=avatar&id=\(i)\(x)"))
        var comment = Post(
          text: faker.lorem.sentences(amount: sencenceCount),
          date: NSDate(timeIntervalSinceNow: -4),
          author: commentUser
        )
        post.comments.append(comment)
      }

      posts.append(post)
    }

    return posts
  }

  func wallPostWasTapped(element: TappedElement, index: Int?) {
    let post = self.postAtIndex(index!)

    if element == .Text || element == .Attachment {
      let detailView = DetailViewController(post: post!)
      self.navigationController?.pushViewController(detailView, animated: true)
    }
  }

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
