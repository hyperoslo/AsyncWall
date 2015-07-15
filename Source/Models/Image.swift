import Sugar

public class Image: Attachable {

  public var thumbnail: URLStringConvertible?
  public var source: URLStringConvertible?

  public init() {}

  public init(_ source: URLStringConvertible, thumbnail: URLStringConvertible? = nil) {
    self.source = source
    self.thumbnail = thumbnail
  }
}
