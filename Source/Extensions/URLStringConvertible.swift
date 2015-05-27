import Foundation

public protocol URLStringConvertible {
  var url: NSURL { get }
}

extension String: URLStringConvertible {

  public var url: NSURL {
    return NSURL(string: self)!
  }

}
