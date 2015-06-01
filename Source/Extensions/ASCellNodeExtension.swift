import UIKit
import AsyncDisplayKit
import Haneke

extension ASImageNode {

  func fetchImage(imageURL: NSURL) {
    let cache = Config.Cache.Thumbnails.storage
    cache.fetch(URL: imageURL, formatName: Config.Cache.Thumbnails.format).onSuccess { image in
      self.image = image
    }
  }
}
