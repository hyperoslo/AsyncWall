public protocol GroupConvertible {

  var wallModel: Group { get }
}

public struct Group {

  public var name: String
  public var image: AttachmentConvertible?

  public init(name: String, image: AttachmentConvertible? = nil) {
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
