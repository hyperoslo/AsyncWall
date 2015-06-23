import Foundation

public protocol PostCellNodeDelegate: class {

  func cellNodeElementWasTapped(elementType: TappedElement, sender: PostCellNode)
  var config: Config { get }
}
