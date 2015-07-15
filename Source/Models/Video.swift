import Sugar

public class Video: Attachable {

  public var source: URLStringConvertible?
  public var thumbnail: URLStringConvertible?

  public init() {}

  public init(_ source: URLStringConvertible?, _ thumbnail: URLStringConvertible?) {
    self.source = source
    self.thumbnail = thumbnail
  }
}
