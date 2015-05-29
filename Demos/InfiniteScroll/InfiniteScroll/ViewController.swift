import UIKit
import Wall

class ViewController: WallController, WallTapDelegate, WallScrollDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Infinite Scroll"

    Config.Wall.TextAttributes.postText[NSForegroundColorAttributeName] = UIColor.orangeColor()
    Config.Wall.thumbnailForAttachment = {
      (attachment: Attachment, size: CGSize) -> URLStringConvertible in
      return String(format: attachment.thumbnail.string, Int(size.width), Int(size.height))
    }

    self.delegate = self
    let delayTime = dispatch_time(DISPATCH_TIME_NOW,
      Int64(1 * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      self.posts = self.generatePosts(1, to: 20)
    }
  }

  func generatePosts(from: Int, to: Int) -> [Post] {
    var posts = [Post]()
    var startFrom = self.posts.count
    for i in from...to {
      let post = Post(
        text: "Hello world -> \(i+startFrom)",
        date: NSDate(timeIntervalSinceNow: -4),
        author: User(name: "Author \(i+startFrom)", avatar: Image("http://lorempixel.com/%d/%d/")))

      posts.append(post)
    }
    return posts
  }

  func wallPostWasTapped(element: TappedElement, index: Int?) {
    println("\(element): \(index), \(self.postAtIndex(index!))")
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
