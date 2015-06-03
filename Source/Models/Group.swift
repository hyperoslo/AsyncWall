public struct Group {

  public var name: String?
  public var image: Image?

  public init(name: String, image: Image? = nil) {
    self.name = name
    self.image = image
  }
}
