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
    var title = ""
    if let rowTitle = data[indexPath.row]["title"] as? String {
      title = rowTitle
    }

    return PostCellNode(title: title, width: collectionView.frame.width)
  }
}
