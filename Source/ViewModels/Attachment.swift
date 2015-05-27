import Foundation

public struct Attachment {

  public enum Type {
    case Image, Video
  }

  public var type: Type
  public var source: NSURL

  public init(type: Type, source: NSURL) {
    self.type = type
    self.source = source
  }
}
