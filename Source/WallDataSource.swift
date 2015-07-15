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

    if let delegate = delegate as? WallController,
      post = delegate.post {
        if indexPath.row > 0 {
          cellNode = CommentCellNode(
            post: posts[indexPath.row],
            width: collectionView.frame.width,
            delegate: self)
        } else {
          cellNode = PostCellNode(
            post: posts[indexPath.row],
            width: collectionView.frame.width,
            delegate: self)
        }
    } else {
      cellNode = PostCellNode(
        post: posts[indexPath.row],
        width: collectionView.frame.width,
        delegate: self)
    }

    return cellNode
  }
}
