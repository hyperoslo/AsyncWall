import Foundation
import Wall
import Faker

class DetailViewController: WallController {

  let faker = Faker()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = post!.text

    if let comments = post?.comments {
      let delayTime = dispatch_time(DISPATCH_TIME_NOW,
        Int64(0.1 * Double(NSEC_PER_SEC)))
      dispatch_after(delayTime, dispatch_get_main_queue()) {
        var posts = [Post]()
        posts.append(self.post!)
        comments.map { posts.append($0) }
        self.posts = posts
      }
    }
  }

}
