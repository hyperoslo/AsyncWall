import Foundation
import XCTest

class AttachmentTests: XCTestCase {

  func testAttachmentCreation() {
    let source = "https://github.com/hyperoslo/Wall/blob/master/Images/logo-v2.png"
    let attachment = Image(source)

    XCTAssertEqual(attachment.thumbnail.string, source)
    XCTAssertEqual(attachment.thumbnail.url, source.url)
    XCTAssertTrue(attachment.thumbnail.url.isKindOfClass(NSURL.classForCoder()))
  }
}
