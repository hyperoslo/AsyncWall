import UIKit
import AsyncDisplayKit

extension WallController: ASTableViewDataSource {

  public func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
    return 1
  }

  public func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }

  public func tableView(tableView: ASTableView!, nodeForRowAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {
    var CellClass = config.post.CellClass
    var index = indexPath.row

    if let post = post {
      CellClass = indexPath.row > 0
        ? config.comment.CellClass
        : config.post.CellClass
      index = indexPath.row > 0 ? indexPath.row - 1 : 0
    }

    return CellClass(
      post: posts[indexPath.row].wallModel,
      index: index,
      width: tableView.frame.width,
      delegate: self)
  }
}
