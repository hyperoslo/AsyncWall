public protocol UserConvertible {

  var wallModel: User { get }
}

public struct User {

  public var name: String
  public var avatar: AttachmentConvertible?

  public var image: Attachable? {
    return avatar?.wallModel
  }

  public init(name: String, avatar: AttachmentConvertible? = nil) {
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
