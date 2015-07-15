import Quick
import Nimble

class PostFooterNodeSpec: QuickSpec {

  override func spec() {
    describe("PostFooterNode") {
      let config = Config()
      let footerConfig = config.wall.post.footer

      let width: CGFloat = 320
      let post = SpecHelper.post

      var node: PostFooterNode!

      beforeEach {
        node = PostFooterNode(config: config, post: post, width: width)
      }

      describe("#init") {
        it("sets a width") {
          expect(node.width).to(equal(width))
        }

        it("has the correct height") {
          expect(node.height).to(equal(footerConfig.height))
        }

        context("with likes, comments and seen enabled") {
          it("adds the node with the number of likes ") {
            let string = String.localizedStringWithFormat(
              NSLocalizedString("%d like(s)", comment: ""),
              post.likeCount)

            expect(node.likesNode).notTo(beNil())
            expect(node.likesNode!.attributedString).to(equal(
              NSAttributedString(
                string: string,
                attributes: footerConfig.likes.textAttributes)))
            expect(node.likesNode!.userInteractionEnabled).to(beTrue())
            expect(node.likesNode!.supernode).notTo(beNil())
            expect(node.likesNode!.supernode).to(equal(node))
          }

          it("adds the node with the number of comments") {
            let string = String.localizedStringWithFormat(
              NSLocalizedString("%d comment(s)", comment: ""),
              post.commentCount)

            expect(node.commentsNode).notTo(beNil())
            expect(node.commentsNode!.attributedString).to(equal(
              NSAttributedString(
                string: string,
                attributes: footerConfig.comments.textAttributes)))
            expect(node.commentsNode!.userInteractionEnabled).to(beTrue())
            expect(node.commentsNode!.supernode).notTo(beNil())
            expect(node.commentsNode!.supernode).to(equal(node))
          }

          it("adds the node with the number of views") {
            let string = "\(footerConfig.seen.text) \(post.seen)"

            expect(node.seenNode).notTo(beNil())
            expect(node.seenNode!.attributedString).to(equal(
              NSAttributedString(
                string: string,
                attributes: footerConfig.seen.textAttributes)))
            expect(node.seenNode!.userInteractionEnabled).to(beTrue())
            expect(node.seenNode!.supernode).notTo(beNil())
            expect(node.seenNode!.supernode).to(equal(node))
          }
        }

        context("with likes, comments and seen disabled") {
          beforeEach {
            var configDisabled = config

            configDisabled.wall.post.footer.likes.enabled = false
            configDisabled.wall.post.footer.comments.enabled = false
            configDisabled.wall.post.footer.seen.enabled = false

            node = PostFooterNode(config: configDisabled, post: post, width: width)
          }

          it("does not add the node with the number of likes ") {
            expect(node.likesNode).to(beNil())
          }

          it("does not add the node with the number of comments ") {
            expect(node.commentsNode).to(beNil())
          }

          it("does not add the node with the number of views ") {
            expect(node.seenNode).to(beNil())
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
