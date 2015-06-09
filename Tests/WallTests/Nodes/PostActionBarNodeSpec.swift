import Quick
import Nimble

class PostActionBarNodeSpec: QuickSpec {

  override func spec() {
    describe("PostActionBarNode") {
      let width: CGFloat = 320

      var node: PostActionBarNode!

      beforeEach {
        node = PostActionBarNode(width: width)
      }

      describe("#init") {
        it("sets a width") {
          expect(node.width).to(equal(width))
        }
      }
    }
  }
}
