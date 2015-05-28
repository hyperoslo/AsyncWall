import Foundation
import XCTest

class UserTests: XCTestCase {

  func testUserCreation() {
    let url = "https://avatars2.githubusercontent.com/u/1340892?v=3&s=200"
    let name = "John Hyperseed"
    let user = User(name: name, avatar: url)

    XCTAssertEqual(user.name, name)
    XCTAssertEqual(user.avatar!.string, url)
    XCTAssertEqual(user.avatar!.url, NSURL(string: url)!)
    XCTAssertTrue(user.avatar!.url.isKindOfClass(NSURL.classForCoder()))
  }

}
