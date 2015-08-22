import UIKit
import AsyncDisplayKit

public protocol WallControllerDelegate: class {

  func updateInterface()
}

public class WallController: UIViewController {

  private enum InfiniteScrolling {
    case Triggered, Loading, Stopped
  }

  public var config = Config()
  public weak var tapDelegate: WallTapDelegate?
  public weak var scrollDelegate: WallScrollDelegate?
  public weak var delegate: WallControllerDelegate?
  public var post: PostConvertible?

  private var scrollingState: InfiniteScrolling = .Stopped

  public var posts: [PostConvertible] = [] {
    willSet {
      dispatch_async(dispatch_get_main_queue(), { _ in
        self.collectionView.performBatchAnimated(true, updates: {
          self.collectionView.reloadData()
          }, completion: { _ in
            self.delegate?.updateInterface()
        })
      })
    }
  }

  public lazy var collectionView: ASCollectionView = { [unowned self] in
    var frame = self.view.bounds
    frame.origin.y += 20

    let collectionView = ASCollectionView(frame: CGRectZero,
      collectionViewLayout: self.flowLayout, asyncDataFetching: true)
    collectionView.alwaysBounceVertical = true
    collectionView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
    collectionView.backgroundColor = .whiteColor()
    collectionView.bounces = true
    collectionView.asyncDataSource = self
    collectionView.asyncDelegate = self

    return collectionView
    }()

  public lazy var flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    return layout
    }()

  // MARK: - Initialization

  public convenience init(post: PostConvertible) {
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

  public func postAtIndex(index: Int) -> PostConvertible? {
    return posts[index]
  }
}

// MARK: - PostCellNodeDelegate

extension WallController: PostCellNodeDelegate {

  public func cellNodeElementWasTapped(elementType: TappedElement, index: Int) {
    tapDelegate?.wallPostWasTapped(elementType, index: index)
  }
}

// MARK: - ASCollectionViewDelegate

extension WallController: ASCollectionViewDelegate {

  public func collectionView(collectionView: ASCollectionView!,
    willBeginBatchFetchWithContext context: ASBatchContext!) {
      scrollingState = .Loading
      scrollDelegate?.wallDidScrollToEnd {
        context.completeBatchFetching(true)
        self.scrollingState = .Stopped
      }
  }
}
