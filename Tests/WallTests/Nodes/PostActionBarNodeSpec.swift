import Quick
import Nimble

class PostActionBarNodeSpec: QuickSpec {

  override func spec() {
    describe("PostActionBarNode") {
      let config = Config()
      let width: CGFloat = 320
      var node: PostActionBarNode!

      beforeEach {
        node = PostActionBarNode(width: width)
      }

      describe("#init") {
        it("sets a width") {
          expect(node.width).to(equal(width))
        }

        context("with like button and comment button enabled") {
          it("adds a like control node") {
            let title = NSLocalizedString("Like", comment: "")

            expect(node.likeControlNode).notTo(beNil())
            expect(node.likeControlNode.titleNode).notTo(beNil())
            expect(node.likeControlNode.titleNode!.attributedString.string).to(equal(title))
            expect(node.likeControlNode.imageNode).to(beNil())
            expect(node.likeControlNode.userInteractionEnabled).to(beTrue())
            expect(node.likeControlNode.supernode).notTo(beNil())
            expect(node.likeControlNode.supernode).to(equal(node))
          }

          it("adds a comment control node") {
            let title = NSLocalizedString("Comment", comment: "")

            expect(node.commentControlNode).notTo(beNil())
            expect(node.commentControlNode.titleNode).notTo(beNil())
            expect(node.commentControlNode.titleNode!.attributedString.string).to(equal(title))
            expect(node.commentControlNode.imageNode).to(beNil())
            expect(node.commentControlNode.userInteractionEnabled).to(beTrue())
            expect(node.commentControlNode.supernode).notTo(beNil())
            expect(node.commentControlNode.supernode).to(equal(node))
          }
        }
      }
    }
  }
}
