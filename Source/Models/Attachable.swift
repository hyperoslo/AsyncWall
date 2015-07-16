import Sugar

public protocol Attachable {

  var source: URLStringConvertible { get }
  var thumbnail: URLStringConvertible { get }
}

public class Image: Attachable {

  public var source: URLStringConvertible

  public var thumbnail: URLStringConvertible {
    return source
  }

  public init(_ source: URLStringConvertible) {
    self.source = source
  }
}

public class Video: Attachable {

  public var source: URLStringConvertible
  public var thumbnail: URLStringConvertible

  public init(source: URLStringConvertible, thumbnail: URLStringConvertible) {
    self.source = source
    self.thumbnail = thumbnail
  }
}
