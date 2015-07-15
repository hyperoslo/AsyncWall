import Sugar

public protocol Attachable {

  var thumbnail: URLStringConvertible? { get }
  var source: URLStringConvertible? { get }
}
