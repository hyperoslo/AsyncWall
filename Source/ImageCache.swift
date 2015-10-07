import Foundation
import AsyncDisplayKit
import Kingfisher

public class ImageCache: NSObject, ASImageDownloaderProtocol {
  public func downloadImageWithURL(URL: NSURL!,
    callbackQueue: dispatch_queue_t!,
    downloadProgressBlock: ((CGFloat) -> Void)!,
    completion: ((CGImage!, NSError!) -> Void)!) -> AnyObject! {

      let manager = KingfisherManager.sharedManager

      let task = manager.retrieveImageWithURL(URL,
        optionsInfo: nil,
        progressBlock: { receivedSize, totalSize in
          if downloadProgressBlock != nil {
            let queue = callbackQueue != nil ?
              callbackQueue : dispatch_get_main_queue()
            dispatch_async(queue, {
              downloadProgressBlock(CGFloat(receivedSize / totalSize))
            })
          }
        },
        completionHandler: { image, error, cacheType, imageURL in
          if completion != nil && image != nil {
            let queue = callbackQueue != nil ?
              callbackQueue : dispatch_get_main_queue()
            dispatch_async(queue, {
              completion(image!.CGImage, error)
            })
          }
      })

      return task
  }

  public func cancelImageDownloadForIdentifier(downloadIdentifier: AnyObject!) {
    if let task = downloadIdentifier as? RetrieveImageTask {
      task.cancel()
    }
  }
}
