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
        options: .None,
        progressBlock:
        { receivedSize, totalSize in
          dispatch_async(callbackQueue, {
            downloadProgressBlock(CGFloat(receivedSize / totalSize))
          })
        })
        { image, error, cacheType, imageURL in
          dispatch_async(callbackQueue, {
            completion(image!.CGImage, error)
          })
      }
      return task
  }

  public func cancelImageDownloadForIdentifier(downloadIdentifier: AnyObject!) {
    if let task = downloadIdentifier as? RetrieveImageTask {
      task.cancel()
    }
  }
}
