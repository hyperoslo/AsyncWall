import Foundation

public struct Attachment {

  public enum Type {
    case Image, Video
  }

  public var type: Type
  public var src: NSURL

  public init(type: Type, src: NSURL) {
    self.type = type
    self.src = src
  }
}
