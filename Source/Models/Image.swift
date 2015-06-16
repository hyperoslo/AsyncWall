public class Image: Attachment {

  public var thumbnail: URLStringConvertible?

  public init() {}

  public init(_ thumbnail: URLStringConvertible?) {
    self.thumbnail = thumbnail
  }
}
