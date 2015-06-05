import Quick
import Nimble

class FooterNodeSpec: QuickSpec {

  override func spec() {
    describe("PostFooterNode") {
      let width: CGFloat = 320
      let post = Post(text: "Test", date: NSDate(), author: User(name: "John Hyperseed"))
      post.likes = 10

      var node: PostFooterNode!

      beforeEach {
        node = PostFooterNode(post: post, width: width)
      }

      describe("#init") {
        context("with width") {
          it ("sets a width") {
            expect(node.width).to(equal(width))
          }
        }
      }
    }
  }
}
