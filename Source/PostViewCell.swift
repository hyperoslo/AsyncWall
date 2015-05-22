import UIKit

class PostViewCell: UICollectionViewCell {

  var postView: PostView

  override init(frame: CGRect) {
    postView = PostView(frame: frame)
    super.init(frame: frame)

    contentView.addSubview(postView)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  func setTitle(title: String) {
    postView.label.text = title
  }

  override func layoutSubviews() {
    postView.frame = self.bounds
  }
}
