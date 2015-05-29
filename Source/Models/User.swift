import Foundation

public struct User {

  public var name: String
  public var avatar: Image?

  public init(name: String, avatar: Image? = nil) {
    self.name = name
    self.avatar = avatar
  }
}
