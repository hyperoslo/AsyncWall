import UIKit
import AsyncDisplayKit
import Haneke

public extension ASNetworkImageNode {

  public func fetchImage(imageURL: NSURL) {
    let cache = Config.ImageCache.storage
    cache.fetch(URL: imageURL, formatName: Config.ImageCache.format).onSuccess { image in
      self.image = image
    }
  }
}
