import UIKit
import AsyncDisplayKit

extension WallController: ASCollectionViewDataSource {

  public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.count
  }

  public func collectionView(collectionView: ASCollectionView!, nodeForItemAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {
    var CellClass = config.post.CellClass
    var index = indexPath.row

    if let post = post {
      CellClass = indexPath.row > 0
        ? config.comment.CellClass
        : config.post.CellClass
      index = indexPath.row > 0 ? indexPath.row - 1 : 0
    }

    return CellClass(
      post: posts[indexPath.row].wallModel,
      index: index,
      width: collectionView.frame.width,
      delegate: self)
  }
}
