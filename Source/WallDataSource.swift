import UIKit

public class WallDataSource: NSObject, UITableViewDataSource {

  lazy public var data = { return [] }()

  public func tableView(tableView: UITableView,
    cellForRowAtIndexPath
    indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("Post", forIndexPath: indexPath) as! UITableViewCell

      if let title = data[indexPath.row]["title"] as? String {
        cell.textLabel?.text = title
      }

      return cell
  }

  public func tableView(tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      return data.count
  }

}
