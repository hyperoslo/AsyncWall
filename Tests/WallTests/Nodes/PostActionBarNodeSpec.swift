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

        it("returns a correct height") {
          expect(node.height).to(equal(Config.Wall.Post.ActionBar.height))
        }

        context("with like button and comment button enabled") {
          it("adds a like control node") {
            let image = Config.Wall.Post.ActionBar.LikeButton.image
            let title = NSAttributedString(
              string: Config.Wall.Post.ActionBar.LikeButton.title!,
              attributes: Config.Wall.Post.ActionBar.LikeButton.textAttributes)

            expect(node.likeControlNode).notTo(beNil())
            expect(node.likeControlNode!.titleNode).notTo(beNil())
            expect(node.likeControlNode!.titleNode!.attributedString).to(equal(title))
            expect(node.likeControlNode!.imageNode).to(beNil())
            expect(node.likeControlNode!.userInteractionEnabled).to(beTrue())
            expect(node.likeControlNode!.supernode).notTo(beNil())
            expect(node.likeControlNode!.supernode).to(equal(node))
          }

          it("adds a comment control node") {
            let image = Config.Wall.Post.ActionBar.CommentButton.image
            let title = NSAttributedString(
              string: Config.Wall.Post.ActionBar.CommentButton.title!,
              attributes: Config.Wall.Post.ActionBar.CommentButton.textAttributes)

            expect(node.commentControlNode).notTo(beNil())
            expect(node.commentControlNode!.titleNode).notTo(beNil())
            expect(node.commentControlNode!.titleNode!.attributedString).to(equal(title))
            expect(node.commentControlNode!.imageNode).to(beNil())
            expect(node.commentControlNode!.userInteractionEnabled).to(beTrue())
            expect(node.commentControlNode!.supernode).notTo(beNil())
            expect(node.commentControlNode!.supernode).to(equal(node))
          }
        }

        context("with like button disabled") {
          beforeEach {
            Config.Wall.Post.ActionBar.LikeButton.enabled = false
            Config.Wall.Post.ActionBar.CommentButton.enabled = true

            node = PostActionBarNode(width: width)
          }

          it("does not add a like control node") {
            expect(node.likeControlNode).to(beNil())
          }

          it("adds a comment control node") {
            expect(node.commentControlNode).notTo(beNil())
          }
        }

        context("with comment button disabled") {
          beforeEach {
            Config.Wall.Post.ActionBar.LikeButton.enabled = true
            Config.Wall.Post.ActionBar.CommentButton.enabled = false

            node = PostActionBarNode(width: width)
          }

          it("adds a like control node") {
            expect(node.likeControlNode).notTo(beNil())
          }

          it("does not add a comment control node") {
            expect(node.commentControlNode).to(beNil())
          }
        }
      }
    }
  }
}
