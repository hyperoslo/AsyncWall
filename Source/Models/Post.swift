import Foundation

public protocol Postable {

  var id: Int { get }
  var publishDate: NSDate? { get }
  var text: String? { get }
  var liked: Bool { get }
  var seen: Bool { get }
  var likeCount: Int { get }
  var seenCount: Int { get }
  var commentCount: Int { get }
  var author: Profileable? { get }
  var group: Groupable? { get }
  var location: Location? { get }
  var parent: Postable? { get }
  var attachments: [Attachable] { get }
}
