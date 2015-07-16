public protocol GroupConvertible {

  var wallModel: Group { get }
}

public struct Group {

  public var name: String
  public var image: Image?

  public init(name: String, image: Image? = nil) {
    self.name = name
    self.image = image
  }
}

// MARK: - GroupConvertible

extension Group: GroupConvertible {

  public var wallModel: Group {
    return self
  }
}
