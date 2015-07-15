public struct User {

  public var name: String?
  public var avatar: Displayable?

  public init(name: String? = nil, avatar: Displayable? = nil) {
    self.name = name
    self.avatar = avatar
  }
}
