import UIKit
import AsyncDisplayKit

public class WallDataSource: NSObject {

  struct Constants {
    static let cellIdentifier = "PostCell"
  }

  lazy public var data = { return [] }()
}


extension WallDataSource: ASCollectionViewDataSource {

  public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }

  public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  public func collectionView(collectionView: ASCollectionView!, nodeForItemAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {
    var cell: ASCellNode?

    if let rowTitle = data[indexPath.row]["title"] as? String {
      cell = PostCellNode(title: rowTitle, width: collectionView.frame.width)
    }

    return cell
  }
}
