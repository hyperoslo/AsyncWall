public class Image: Attachment {

  public var thumbnail: URLStringConvertible?

  public init(_ thumbnail: URLStringConvertible? = nil) {
    self.thumbnail = thumbnail
  }
}
