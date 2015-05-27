import Foundation
import XCTest

class AttachmentTests: XCTestCase {

  func testURLConvertable() {
    let source = "https://github.com/hyperoslo/Wall/blob/master/Images/logo-v2.png"
    let attachment = Attachment(source, .Image)

    XCTAssertEqual(attachment.source.string, source)
    XCTAssertEqual(attachment.source.url, source.url)
    XCTAssertEqual(attachment.type, .Image)
    XCTAssertTrue(attachment.source.url.isKindOfClass(NSURL.classForCoder()))
  }

}
