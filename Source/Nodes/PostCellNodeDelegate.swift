import Foundation

public protocol PostCellNodeDelegate: class {

  func cellNodeElementWasTapped(elementType: TappedElement, index: Int)
  var config: Config { get }
}
