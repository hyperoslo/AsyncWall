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
        it("sets a width") {
          expect(node.width).to(equal(width))
        }

        it("has the correct height") {
          expect(node.height).to(equal(Config.Wall.Post.Footer.height))
        }

        context("with likes, comments and seenCount enabled") {
          it("adds the node with the number of likes ") {
            expect(node.likesNode).notTo(beNil())
            expect(node.likesNode!.attributedString).to(equal(
              NSAttributedString(
                string: "\(post.likes)",
                attributes: Config.Wall.Post.Footer.Likes.textAttributes)))
            expect(node.likesNode!.userInteractionEnabled).to(beTrue())
            expect(node.likesNode!.supernode).notTo(beNil())
            expect(node.likesNode!.supernode).to(equal(node))
          }

          it("adds the node with the number of comments") {
            expect(node.commentsNode).notTo(beNil())
            expect(node.commentsNode!.attributedString).to(equal(
              NSAttributedString(
                string: "\(post.comments.count)",
                attributes: Config.Wall.Post.Footer.Comments.textAttributes)))
            expect(node.commentsNode!.userInteractionEnabled).to(beTrue())
            expect(node.commentsNode!.supernode).notTo(beNil())
            expect(node.commentsNode!.supernode).to(equal(node))
          }

          it("adds the node with the number of views") {
            expect(node.seenByNode).notTo(beNil())
            expect(node.commentsNode!.attributedString).to(equal(
              NSAttributedString(
                string: "\(post.comments.count)",
                attributes: Config.Wall.Post.Footer.Comments.textAttributes)))
            expect(node.commentsNode!.userInteractionEnabled).to(beTrue())
            expect(node.commentsNode!.supernode).notTo(beNil())
            expect(node.commentsNode!.supernode).to(equal(node))
          }
        }

        context("with likes, comments and seenCount disabled") {
          beforeEach {
            Config.Wall.Post.Footer.Likes.enabled = false
            Config.Wall.Post.Footer.Comments.enabled = false
            Config.Wall.Post.Footer.SeenBy.enabled = false

            node = PostFooterNode(post: post, width: width)
          }

          it("does not add the node with the number of likes ") {
            expect(node.likesNode).to(beNil())
          }

          it("does not add the node with the number of comments ") {
            expect(node.commentsNode).to(beNil())
          }

          it("does not add the node with the number of views ") {
            expect(node.seenByNode).to(beNil())
          }
        }
      }
    }
  }
}
