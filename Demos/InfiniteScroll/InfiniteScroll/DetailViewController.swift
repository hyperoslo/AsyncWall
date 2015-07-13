import Foundation
import Wall
import Faker

class DetailViewController: WallController {

  let faker = Faker()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = post!.text
    collectionView.backgroundColor = config.wall.comment.backgroundColor
    config.wall.thumbnailForAttachment = {
      (attachment: Attachment, size: CGSize) -> URLStringConvertible? in
      var string: URLStringConvertible?

      if let thumbnail = attachment.thumbnail {
        string = String(format: thumbnail.string, Int(size.width), Int(size.height))
      }

      return string
    }

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
