import UIKit
import AsyncDisplayKit

public class WallDataSource: NSObject, ASCollectionViewDataSource {

  var delegate: AnyObject?

  struct Constants {
    static let cellIdentifier = "PostCell"
  }

  lazy public var data = { return [Post]() }()

  func textTapped(sender: AnyObject) {
    if let delegate = delegate as? WallTapDelegate,
      delegateMethod = delegate.wallPostTextWasTapped {
        delegateMethod(sender)
    }
  }
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
        width: collectionView.frame.width, self)

    return cellNode
  }
}
