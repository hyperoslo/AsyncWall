import Quick
import Nimble

class FooterNodeSpec: QuickSpec {

  override func spec() {
    describe("PostFooterNode") {
      let width: CGFloat = 320
      let post = SpecHelper.post

      var node: PostFooterNode!

      beforeEach {
        node = PostFooterNode(post: post, width: width)
      }

      describe("#init") {
        context("with width and post") {
          it ("sets a width") {
            expect(node.width).to(equal(width))
          }
        }
      }
    }
  }
}
