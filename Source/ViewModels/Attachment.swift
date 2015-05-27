import Foundation

public struct Attachment {

  public enum Type {
    case Image, Video
  }

  public var type: Type
  public var source: URLStringConvertible

  public init(_ source: URLStringConvertible, _ type: Type) {
    self.type = type
    self.source = source
  }
}
