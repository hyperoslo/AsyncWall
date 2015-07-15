import Sugar

public protocol Attachable {

  var thumbnail: URLStringConvertible? { get }
  var source: URLStringConvertible? { get }
}

public protocol Displayable: Attachable { }

public protocol Playable: Attachable { }
