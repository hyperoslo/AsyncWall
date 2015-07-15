import Foundation

class Networking {

  private static let fetchURL = "https://api.app.net/posts/stream/global"

  static func fetchPosts(completion: (Array<AnyObject>?,NSError?) -> Void) {
    if let url = NSURL(string: fetchURL) {
      let request = NSURLRequest(URL: url)
      let operationQueue = NSOperationQueue()

      NSURLConnection.sendAsynchronousRequest(request, queue: operationQueue) {
        _, data, error in
        if let data = data,
          json = NSJSONSerialization.JSONObjectWithData(data,
            options: NSJSONReadingOptions.MutableContainers,
            error: nil) as? Dictionary<String, AnyObject> {
              completion(json["data"] as? Array, error)
        } else {
          completion(nil, error)
        }
      }
    }
  }

}
