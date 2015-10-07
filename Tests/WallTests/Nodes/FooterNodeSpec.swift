import Quick
import Nimble

class FooterNodeSpec: QuickSpec {

  override func spec() {
    describe("PostFooterNode") {
      let width: CGFloat = 320
      let post = SpecHelper.post

      var node: FooterNode!

      beforeEach {
        node = FooterNode(post: post, width: width)
      }

      describe("#init") {
        it("sets a width") {
          expect(node.width).to(equal(width))
        }

        context("with likes, comments and seen") {
          it("adds the node with the number of likes ") {
            let string = String.localizedStringWithFormat(
              NSLocalizedString("%d like(s)", comment: ""),
              post.likeCount)

            expect(node.likesNode).notTo(beNil())
            expect(node.likesNode.attributedString.string).to(equal(string))
            expect(node.likesNode.userInteractionEnabled).to(beTrue())
            expect(node.likesNode.supernode).notTo(beNil())
            expect(node.likesNode.supernode).to(equal(node))
          }

          it("adds the node with the number of comments") {
            let string = String.localizedStringWithFormat(
              NSLocalizedString("%d comment(s)", comment: ""),
              post.commentCount)

            expect(node.commentsNode).notTo(beNil())
            expect(node.commentsNode.attributedString.string).to(equal(string))
            expect(node.commentsNode.userInteractionEnabled).to(beTrue())
            expect(node.commentsNode.supernode).notTo(beNil())
            expect(node.commentsNode.supernode).to(equal(node))
          }

          it("adds the node with the number of views") {
            let string = NSLocalizedString("Seen by", comment: "")
              + " \(post.seenCount)"

            expect(node.seenNode).notTo(beNil())
            expect(node.seenNode.attributedString.string).to(equal(string))
            expect(node.seenNode.userInteractionEnabled).to(beTrue())
            expect(node.seenNode.supernode).notTo(beNil())
            expect(node.seenNode.supernode).to(equal(node))
          }
        }
      }

      describe("#calculateSizeThatFits") {
        var size = CGSizeZero

        beforeEach {
          size = node.calculateSizeThatFits(CGSizeZero)
        }

        it("returns correct width") {
          expect(Double(size.width)) ≈ Double(node.width)
        }

        it("returns correct height") {
          expect(Double(size.height)) ≈ Double(node.height)
        }
      }
    }
  }
}
