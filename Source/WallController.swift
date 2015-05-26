import UIKit
import AsyncDisplayKit

public class WallController: UIViewController {

  public lazy var collectionView: UICollectionView = { [unowned self] in
    var frame = self.view.bounds
    frame.origin.y += 20

    let collectionView = ASCollectionView(frame: CGRectZero,
      collectionViewLayout: self.flowLayout, asyncDataFetching: true)
    collectionView.alwaysBounceVertical = true
    collectionView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
    collectionView.backgroundColor = .whiteColor()
    collectionView.bounces = true
    collectionView.asyncDataSource = self.dataSource
    collectionView.asyncDelegate = self

    return collectionView
    }()

  public lazy var flowLayout: UICollectionViewFlowLayout = {
    var layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0)
    return layout
    }()

  public var posts: [AnyObject] = [] {
    willSet {
      dataSource.data = newValue
      dispatch_async(dispatch_get_main_queue(), { _ in
        self.collectionView.reloadData()
      })
    }
  }

  public lazy var dataSource: WallDataSource = {
    return WallDataSource()
    }()

  public  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .lightGrayColor()
    view.addSubview(self.collectionView)
  }

  public override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    collectionView.frame = view.bounds
  }
}

extension WallController: ASCollectionViewDelegate {
}
