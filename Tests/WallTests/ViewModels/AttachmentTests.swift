import Foundation
import XCTest

class AttachmentTests: XCTestCase {

  func testURLConvertable() {
    let url = "https://github.com/hyperoslo/Wall/blob/master/Images/logo-v2.png"
    let attachment = Attachment(url, .Image)

    XCTAssertEqual(attachment.source.url, url)
    XCTAssertEqual(attachment.type, .Image)
    XCTAssertTrue(attachment.source.url.isKindOfClass(NSURL.classForCoder()))
  }

}
