import Foundation

public class Image: Attachment {

  public var source: URLStringConvertible

  public init(_ source: URLStringConvertible) {
    self.source = source
  }
}
