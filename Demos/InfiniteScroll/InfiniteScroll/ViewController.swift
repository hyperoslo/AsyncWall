import UIKit
import Wall

class ViewController: WallController, WallDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Infinite Scroll"

    Config.Wall.TextAttributes.postText[NSForegroundColorAttributeName] = UIColor.orangeColor()

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
      posts.append(Post(text: "Hello world -> \(i+startFrom)", date: NSDate()))
    }
    return posts
  }

  func wallPostWasTapped(element: TappedElement, sender: AnyObject) {
    println("textWasTapped: \(sender)")
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
