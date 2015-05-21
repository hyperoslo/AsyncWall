import UIKit
import Wall
import DATAStack

class ViewController: WallController {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "app.net"

    Networking.fetchPosts { (json, error) -> Void in
      if (json != nil && error == nil) {
        var posts: [AnyObject] = []

        for post in json! as Array {
          if let text = post["text"] as? String {
            posts.append(["title": text])
          }
        }

        self.posts = posts
      }
    }
  }
}
