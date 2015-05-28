public class Video: Attachment {

  public var source: URLStringConvertible
  public var thumbnail: URLStringConvertible

  public init(_ source: URLStringConvertible, _ thumbnail: URLStringConvertible) {
    self.source = source
    self.thumbnail = thumbnail
  }
}
