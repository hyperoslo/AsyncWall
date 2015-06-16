public class Video: Attachment {

  public var source: URLStringConvertible?
  public var thumbnail: URLStringConvertible?

  public init(_ source: URLStringConvertible? = nil, _ thumbnail: URLStringConvertible? = nil) {
    self.source = source
    self.thumbnail = thumbnail
  }
}
