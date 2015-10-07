import Foundation
import Wall
import Sugar

class DetailViewController: WallController {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = post!.wallModel.text

    if let comments = post?.wallModel.comments {
      delay(0.1) {
        var posts = [PostConvertible]()
        posts.append(self.post!)
        for comment in comments { posts.append(comment) }
        self.posts = posts
      }
    }
  }
}
