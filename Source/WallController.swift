import UIKit

public class WallController: UIViewController {

  public lazy var collectionView: UICollectionView = { [unowned self] in
    var frame = self.view.bounds
    frame.origin.y += 20

    let collectionView = UICollectionView(frame: frame, collectionViewLayout: self.flowLayout)
    collectionView.alwaysBounceVertical = true
    collectionView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
    collectionView.backgroundColor = .lightTextColor()
    collectionView.bounces = true
    collectionView.dataSource = self.dataSource
    collectionView.delegate = self

    collectionView.registerClass(PostViewCell.self,
      forCellWithReuseIdentifier: WallDataSource.Constants.cellIdentifier)

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
}

extension WallController: UICollectionViewDelegate {

  public func collectionView(collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

      let width: CGFloat = view.bounds.size.width * 0.98
      let height: CGFloat = 150.0

      return CGSizeMake(width, height)
  }
}
