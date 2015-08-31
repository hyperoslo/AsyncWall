import UIKit
import AsyncDisplayKit

public class WallController: UIViewController {

  private enum InfiniteScrolling {
    case Triggered, Loading, Stopped
  }

  public var config = Config()
  public weak var tapDelegate: WallTapDelegate?
  public weak var scrollDelegate: WallScrollDelegate?
  public var post: PostConvertible?
  public var posts: [PostConvertible] = []
  private var scrollingState: InfiniteScrolling = .Stopped

  public lazy var tableView: ASTableView = { [unowned self] in
    let tableView = ASTableView(frame: CGRectZero,
      style: .Plain, asyncDataFetching: true)
    tableView.alwaysBounceVertical = true
    tableView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
    tableView.backgroundColor = .whiteColor()
    tableView.bounces = true
    tableView.asyncDataSource = self
    tableView.asyncDelegate = self

    return tableView
    }()

  // MARK: - Initialization

  public convenience init(post: PostConvertible) {
    self.init()

    self.post = post
  }

  // MARK: - View Lifecycle

  public override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(tableView)
  }

  public override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    tableView.frame = view.bounds
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

extension WallController: ASTableViewDelegate {

  public func tableView(tableView: ASTableView!,
    willBeginBatchFetchWithContext context: ASBatchContext!) {
    scrollingState = .Loading
    scrollDelegate?.wallDidScrollToEnd {
      context.completeBatchFetching(true)
      self.scrollingState = .Stopped
    }
  }
}
