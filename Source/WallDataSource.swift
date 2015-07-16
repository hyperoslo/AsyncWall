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
    let cellNode: ASCellNode

    if let post = post {
      if indexPath.row > 0 {
        cellNode = CommentCellNode(
          post: posts[indexPath.row].wallModel,
          index: indexPath.row - 1,
          width: collectionView.frame.width,
          delegate: self)
      } else {
        cellNode = PostCellNode(
          post: posts[indexPath.row].wallModel,
          index: 0,
          width: collectionView.frame.width,
          delegate: self)
      }
    } else {
      cellNode = PostCellNode(
        post: posts[indexPath.row].wallModel,
        index: indexPath.row,
        width: collectionView.frame.width,
        delegate: self)
    }

    return cellNode
  }
}
