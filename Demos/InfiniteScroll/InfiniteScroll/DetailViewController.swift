import Foundation
import Wall
import Faker

class DetailViewController: WallController {

  let faker = Faker()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = post!.text

    let delayTime = dispatch_time(DISPATCH_TIME_NOW,
      Int64(0.1 * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      self.posts = self.generatePosts(1, to: 3)
    }
  }

  func generatePosts(from: Int, to: Int) -> [Post] {
    var posts = [Post]()
    var startFrom = self.posts.count

    for i in from...to {
      let sencenceCount = Int(arc4random_uniform(8) + 1)
      posts.append(Post(text: faker.lorem.sentences(amount: sencenceCount),
        date: NSDate()))
    }
    return posts
  }

}
