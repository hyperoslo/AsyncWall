import UIKit

extension CGSize {

  func centerInSize(size: CGSize) -> CGPoint {
    let x = (size.width - width) / 2
    let y = (size.height - height) / 2
    return CGPoint(x: x, y: y)
  }
}
