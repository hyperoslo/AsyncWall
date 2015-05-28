import UIKit
import AsyncDisplayKit

public class WallDataSource: NSObject, ASCollectionViewDataSource {

  struct Constants {
    static let cellIdentifier = "PostCell"
  }

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
    let cellNode = PostCellNode(post: data[indexPath.row],
        width: collectionView.frame.width)

    return cellNode
  }
}
