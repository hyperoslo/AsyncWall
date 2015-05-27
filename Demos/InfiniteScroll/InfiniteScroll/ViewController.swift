import UIKit
import Wall

class ViewController: WallController {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Infinite Scroll"

    self.collectionView.reloadDataWithCompletion { () -> Void in
      self.posts = self.generatePosts(1, to: 20)
    }
  }

  func generatePosts(from: Int, to: Int) -> [AnyObject] {
    var posts: [AnyObject] = []
    for i in from...to {
      posts.append(["title":"Hello world"])
    }
    return posts
  }
}
