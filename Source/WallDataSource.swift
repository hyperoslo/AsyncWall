import UIKit
import AsyncDisplayKit

public enum NodeType { case Post, Comment }

public class WallDataSource: NSObject, ASCollectionViewDataSource {

  var delegate: AnyObject?
  var dataSourceNodeType: NodeType = .Post

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

    switch dataSourceNodeType {
    case .Post:
      cellNode = PostCellNode(post: data[indexPath.row],
        width: collectionView.frame.width, delegate)
    case .Comment:
      cellNode = CommentCellNode(post: data[indexPath.row],
        width: collectionView.frame.width, delegate)
    }

    return cellNode
  }

  public func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView? {

    var reusableView: UICollectionReusableView? = nil

    if kind == UICollectionElementKindSectionHeader {
      reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "PostHeaderView", forIndexPath: indexPath) as? UICollectionReusableView
    }

    return reusableView
  }

}

extension WallDataSource {

  convenience init(type: NodeType) {
    self.init()

    dataSourceNodeType = type
  }

}
