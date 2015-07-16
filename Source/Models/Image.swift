import Sugar

public class Image: Attachable {

  public var source: URLStringConvertible

  public var thumbnail: URLStringConvertible {
    return source
  }

  public init(_ source: URLStringConvertible) {
    self.source = source
  }
}

// MARK: - GroupConvertible

extension Image: AttachmentConvertible {

  public var wallModel: Attachable {
    return self
  }
}
