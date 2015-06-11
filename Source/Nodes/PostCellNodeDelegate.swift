import Foundation

public protocol PostCellNodeDelegate {

  func cellNodeElementWasTapped(elementType: TappedElement, sender: PostCellNode)
  var config: Config { get }
}
