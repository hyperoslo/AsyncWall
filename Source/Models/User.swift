import Foundation

public struct User {

  public var name: String
  public var avatar: URLStringConvertible?

  public init(name: String, avatar: URLStringConvertible? = nil) {
    self.name = name
    self.avatar = avatar
  }
}
