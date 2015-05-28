import UIKit
import Wall

class ViewController: WallController, WallDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Infinite Scroll"

    self.delegate = self
    let delayTime = dispatch_time(DISPATCH_TIME_NOW,
      Int64(1 * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      self.posts = self.generatePosts(1, to: 20)
    }
  }

  func generatePosts(from: Int, to: Int) -> [AnyObject] {
    var posts: [AnyObject] = []
    var startFrom = self.posts.count
    for i in from...to {
      posts.append(["title":"Hello world -> \(i+startFrom)"])
    }
    return posts
  }

  func wallDidScrollToEnd(completion: () -> Void) {
    var newPosts = generatePosts(0, to: 20)
    var updatedPosts = self.posts
    updatedPosts.extend(newPosts)

    self.posts = updatedPosts
    println("update")

    let delayTime = dispatch_time(DISPATCH_TIME_NOW,
      Int64(1 * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      completion()
    }
  }

}
