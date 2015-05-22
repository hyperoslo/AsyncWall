import UIKit

class PostView: UIView {

  var label: UILabel = {
    let label = UILabel()
    label.font = .systemFontOfSize(14)
    label.textAlignment = .Center

    return label
    }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(label)
    backgroundColor = .whiteColor()
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    label.frame = bounds
  }
}
