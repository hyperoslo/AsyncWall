public struct User {

  public var name: String?
  public var avatar: Image?

  public init(name: String? = nil, avatar: Image? = nil) {
    self.name = name
    self.avatar = avatar
  }
}
