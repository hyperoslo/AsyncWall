import Foundation

public class Image: Attachment {

  public var thumbnail: URLStringConvertible

  public init(_ thumbnail: URLStringConvertible) {
    self.thumbnail = thumbnail
  }
}
