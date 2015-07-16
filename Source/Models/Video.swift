import Sugar

public class Video: Attachable {

  public var source: URLStringConvertible
  public var thumbnail: URLStringConvertible

  public init(source: URLStringConvertible, thumbnail: URLStringConvertible) {
    self.source = source
    self.thumbnail = thumbnail
  }
}

// MARK: - AttachmentConvertible

extension Video: AttachmentConvertible {

  public var wallModel: Attachable {
    return self
  }
}
