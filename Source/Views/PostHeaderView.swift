import UIKit

public class PostHeaderView: UICollectionReusableView {

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.backgroundColor = UIColor.lightGrayColor()
  }

  public required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}
