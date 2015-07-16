public protocol UserConvertible {

  var wallModel: User { get }
}

public struct User {

  public var name: String
  public var avatar: Image?

  public init(name: String, avatar: Image? = nil) {
    self.name = name
    self.avatar = avatar
  }
}

// MARK: - UserConvertible

extension User: UserConvertible {

  public var wallModel: User {
    return self
  }
}
