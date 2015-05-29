import Foundation
import XCTest

class UserTests: XCTestCase {

  func testUserCreation() {
    let url = "https://avatars2.githubusercontent.com/u/1340892?v=3&s=200"
    let name = "John Hyperseed"
    let avatar = Image(url)
    let user = User(name: name, avatar: avatar)

    XCTAssertEqual(user.name, name)
    XCTAssertEqual(user.avatar!.thumbnail.string, url)
    XCTAssertTrue(user.avatar!.thumbnail.url.isKindOfClass(NSURL.classForCoder()))
  }
}
