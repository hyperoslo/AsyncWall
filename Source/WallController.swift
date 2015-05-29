import UIKit
import AsyncDisplayKit

public class WallController: UIViewController {

  public enum TappedElement {
    case Author, Date, Text, Attachment, Likes, Views, Comments
  }

  private enum InfiniteScrolling {
    case Triggered, Loading, Stopped
  }

  private var scrollingState: InfiniteScrolling = .Stopped

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

    public var delegate: AnyObject? {
        didSet {
            self.dataSource.delegate = delegate
        }
    }

  public lazy var flowLayout: UICollectionViewFlowLayout = {
    return UICollectionViewFlowLayout()
    }()

  public var posts: [Post] = [] {
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

extension WallController: ASCollectionViewDelegate {

  public func collectionView(collectionView: ASCollectionView!,
    willBeginBatchFetchWithContext context: ASBatchContext!) {
      scrollingState = .Loading
      if let delegate = delegate as? WallScrollDelegate {
          delegate.wallDidScrollToEnd {
            context.completeBatchFetching(true)
            self.scrollingState = .Stopped
          }
      }
  }
}
