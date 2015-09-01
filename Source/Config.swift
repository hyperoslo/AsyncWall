import Foundation
import UIKit
import Sugar

public class Config {

  public static var thumbnailForAttachment: (attachment: Attachable, size: CGSize) -> URLStringConvertible? = {
    (attachment: Attachable, size: CGSize) -> URLStringConvertible? in
    return attachment.thumbnail
  }

  public var post = Post()
  public var comment = Comment()

  public struct Post {
    public var CellClass: PostCellNode.Type = CellNode.self
    public var HeaderClass: PostComponentNode.Type = HeaderNode.self
    public var AttachmentGridClass: PostComponentNode.Type = AttachmentGridNode.self
    public var FooterClass: PostComponentNode.Type = FooterNode.self
    public var ActionBarClass: PostComponentNode.Type = ActionBarNode.self
  }

  public struct Comment {
    public var CellClass: PostCellNode.Type = CellNode.self
  }

  public init() {}
}
