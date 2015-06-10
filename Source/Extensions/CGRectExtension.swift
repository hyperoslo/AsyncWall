import UIKit

extension CGRect {

  func centerInRect(rect: CGRect) -> CGPoint {
    return CGPoint(
      x: CGRectGetWidth(rect) - CGRectGetWidth(self),
      y: CGRectGetHeight(rect) - CGRectGetHeight(self))
  }
}
