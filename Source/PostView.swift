import UIKit

class PostView: UIView {

  var label: UILabel

  override init(frame: CGRect) {
    label = UILabel()
    label.font = UIFont.systemFontOfSize(14)
    label.textAlignment = NSTextAlignment.Center
    super.init(frame: frame)

    addSubview(label)
    backgroundColor = UIColor.whiteColor()
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    label.frame = bounds
  }
}
