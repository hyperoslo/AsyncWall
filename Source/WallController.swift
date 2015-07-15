import UIKit
import AsyncDisplayKit

public class WallController: UIViewController {

  private enum InfiniteScrolling {
    case Triggered, Loading, Stopped
  }

  private var scrollingState: InfiniteScrolling = .Stopped

  public var post: Postable?
  public var config = Config()

  public var tapDelegate: WallTapDelegate?
  public var scrolldelegate: WallScrollDelegate?

  public lazy var collectionView: ASCollectionView = { [unowned self] in
    var frame = self.view.bounds
    frame.origin.y += 20

    let collectionView = ASCollectionView(frame: CGRectZero,
      collectionViewLayout: self.flowLayout, asyncDataFetching: true)
    collectionView.alwaysBounceVertical = true
    collectionView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
    collectionView.backgroundColor = .whiteColor()
    collectionView.bounces = true
    collectionView.asyncDataSource = self
    collectionView.asyncDelegate = self

    return collectionView
    }()

  public lazy var flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    return layout
    }()

  public var posts: [Postable] = [] {
    willSet {
      dispatch_async(dispatch_get_main_queue(), { _ in
        self.collectionView.reloadData()
      })
    }
  }

  // MARK: - Initialization

  public convenience init(post: Postable) {
    self.init()

    self.post = post
  }

  // MARK: - View Lifecycle

  public override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(collectionView)
  }

  public override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    collectionView.frame = view.bounds
  }

  // MARK: - Public Methods

  public func postAtIndex(index: Int) -> Postable? {
    return posts[index]
  }
}

// MARK: - PostCellNodeDelegate

extension WallController: PostCellNodeDelegate {

  public func cellNodeElementWasTapped(elementType: TappedElement, sender: PostCellNode) {
    tapDelegate?.wallPostWasTapped(elementType, index: sender.index)
  }
}

// MARK: - ASCollectionViewDelegate

extension WallController: ASCollectionViewDelegate {

  public func collectionView(collectionView: ASCollectionView!,
    willBeginBatchFetchWithContext context: ASBatchContext!) {
      scrollingState = .Loading
      scrolldelegate?.wallDidScrollToEnd {
        context.completeBatchFetching(true)
        self.scrollingState = .Stopped
      }
  }
}
