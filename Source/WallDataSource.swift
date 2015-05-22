import UIKit

public class WallDataSource: NSObject {

  struct Constants {
    static let cellIdentifier = "PostCell"
  }

  lazy public var data = { return [] }()
}


extension WallDataSource: UICollectionViewDataSource {
  public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }

  public func collectionView(collectionView: UICollectionView,
    cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.cellIdentifier,
        forIndexPath: indexPath) as! PostViewCell

      if let title = data[indexPath.row]["title"] as? String {
        cell.setTitle(title)
      }

      return cell
  }

  public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
}
