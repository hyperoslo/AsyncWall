import UIKit
import AsyncDisplayKit

public enum NodeType { case Post, Comment }

public class WallDataSource: NSObject, ASCollectionViewDataSource {

  var delegate: AnyObject?

  lazy public var data = { return [Post]() }()
}

extension WallDataSource: ASCollectionViewDataSource {

  public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }

  public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  public func collectionView(collectionView: ASCollectionView!, nodeForItemAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {
    let cellNode: ASCellNode

    if let delegate = delegate as? WallController,
      post = delegate.post {
        if indexPath.row > 0 {
          cellNode = CommentCellNode(post: data[indexPath.row],
            width: collectionView.frame.width, delegate)
        } else {
          cellNode = PostCellNode(post: data[indexPath.row],
            width: collectionView.frame.width, delegate)
        }
    } else {
      cellNode = PostCellNode(post: data[indexPath.row],
        width: collectionView.frame.width, delegate)
    }

    return cellNode
  }

}
