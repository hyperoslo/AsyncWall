import Foundation
import Wall

class DetailViewController: WallController {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = post!.text

    let delayTime = dispatch_time(DISPATCH_TIME_NOW,
      Int64(0.1 * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      self.posts = self.generatePosts(1, to: 20)
    }
  }

  func generatePosts(from: Int, to: Int) -> [Post] {
    var posts = [Post]()
    var startFrom = self.posts.count
    for i in from...to {
      posts.append(Post(text: "Comment -> \(i+startFrom)", date: NSDate()))
    }
    return posts
  }

}
