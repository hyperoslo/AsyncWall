import UIKit

public class WallController: UITableViewController {

  public var posts: [AnyObject] = [] {
    willSet {
      dataSource.data = newValue
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        self.tableView.reloadData()
      })
    }
  }

  public lazy var dataSource: WallDataSource = {
    return WallDataSource()
    }()

  lazy var delegate: WallDelegate = {
    return WallDelegate()
    }()

  public required init!(coder aDecoder: NSCoder!) {
    super.init(coder: aDecoder)
  }

  override init!(nibName nibNameOrNil: String!,
    bundle nibBundleOrNil: NSBundle!) {
      super.init(nibName:
        nibNameOrNil, bundle:
        nibBundleOrNil)
  }

  public  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = dataSource
    tableView.delegate = delegate
  }

}

extension UITableViewController {

  public override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(red:0.839,
      green:0.859,
      blue:0.902,
      alpha: 1)

    tableView.registerClass(UITableViewCell.classForCoder(),
      forCellReuseIdentifier: "Post")
    tableView.separatorStyle = .None
  }

}
