import UIKit
import Wall

class ViewController: WallController {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "app.net"

    Networking.fetchPosts { (json, error) -> Void in
      if (json != nil && error == nil) {
        var posts = [PostConvertible]()

        for postData in json! as Array {
          if let text = postData["text"] as? String {
            let post = Post(text: text, date: NSDate())
            posts.append(post)
          }
        }

        self.posts = posts
      }
    }
  }
}
