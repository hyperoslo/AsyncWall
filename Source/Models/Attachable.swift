import Sugar

public protocol AttachmentConvertible {

  var wallModel: Attachable { get }
}

public protocol Attachable {

  var source: URLStringConvertible { get }
  var thumbnail: URLStringConvertible { get }
}
