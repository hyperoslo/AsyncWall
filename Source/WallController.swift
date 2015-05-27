import UIKit
import AsyncDisplayKit

public class WallController: UIViewController {

  public lazy var collectionView: ASCollectionView = { [unowned self] in
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

  public var delegate: WallDelegate?

  public lazy var flowLayout: UICollectionViewFlowLayout = {
    return UICollectionViewFlowLayout()
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

    view.addSubview(self.collectionView)
  }

  public override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    collectionView.frame = view.bounds
  }
}

extension WallController {
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let offsetTreshold = contentHeight - scrollView.bounds.size.height

        if scrollView.contentOffset.y > offsetTreshold {
            delegate?.wallDidScrollToEnd?()
        }
    }
}

extension WallController: ASCollectionViewDelegate {
}
