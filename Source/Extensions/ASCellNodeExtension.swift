import UIKit
import AsyncDisplayKit

extension ASImageNode {

  func fetchImage(imageURL: NSURL) {
    let queue = NSOperationQueue()
    NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: imageURL),
      queue: queue,
      completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
        if error != nil || data == nil || data.length == 0 {
          return
        }

        if let image = UIImage(data: data) {
          self.image = image
        }
    })
  }
}
