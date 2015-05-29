import UIKit
import AsyncDisplayKit

public class WallController: UIViewController, PostCellNodeDelegate {

  private enum InfiniteScrolling {
    case Triggered, Loading, Stopped
  }

  private var scrollingState: InfiniteScrolling = .Stopped
  public var post: Post?

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

  public var delegate: AnyObject?

  public lazy var flowLayout: UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()

    if self.post != nil {
      flowLayout.headerReferenceSize = CGSizeMake(100, 200)
    }

    return flowLayout
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
    let nodeType: NodeType = self.post != nil ? .Comment : .Post
    let dataSource = WallDataSource(type: nodeType)
    dataSource.delegate = self
    return dataSource
    }()

  public  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.registerClass(PostHeaderView.classForCoder(),
      forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
      withReuseIdentifier: "PostHeaderView")

    view.addSubview(collectionView)
  }

  public override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    collectionView.frame = view.bounds
  }

  public func cellNodeElementWasTapped(elementType: TappedElement, sender: PostCellNode) {
    if let delegate = delegate as? WallTapDelegate {
      let index = find(dataSource.data, sender.post)
      delegate.wallPostWasTapped(elementType, index: index)
    }
  }

  public func postAtIndex(index: Int) -> Post? {
    return dataSource.data[index]
  }

  public convenience init(post: Post) {
    self.init()

    self.post = post
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
