import Foundation

public struct User {

  public var name: String
  public var avatarURL: NSURL?

  public init(name: String, avatarURL: NSURL? = nil) {
    self.name = name
    self.avatarURL = avatarURL
  }
}
