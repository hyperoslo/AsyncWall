import Quick
import Nimble

class PostActionBarNodeSpec: QuickSpec {

  override func spec() {
    describe("PostActionBarNode") {
      let width: CGFloat = 320
      let config = Config()
      let actionBarConfig = config.wall.post.actionBar

      var node: PostActionBarNode!

      beforeEach {
        node = PostActionBarNode(width: width, config: config)
      }

      describe("#init") {
        it("sets a width") {
          expect(node.width).to(equal(width))
        }

        it("returns a correct height") {
          expect(node.height).to(equal(actionBarConfig.height))
        }

        context("with like button and comment button enabled") {
          it("adds a like control node") {
            let image = actionBarConfig.likeButton.image
            let title = NSAttributedString(
              string: actionBarConfig.likeButton.title!,
              attributes: actionBarConfig.likeButton.textAttributes)

            expect(node.likeControlNode).notTo(beNil())
            expect(node.likeControlNode!.titleNode).notTo(beNil())
            expect(node.likeControlNode!.titleNode!.attributedString).to(equal(title))
            expect(node.likeControlNode!.imageNode).to(beNil())
            expect(node.likeControlNode!.userInteractionEnabled).to(beTrue())
            expect(node.likeControlNode!.supernode).notTo(beNil())
            expect(node.likeControlNode!.supernode).to(equal(node))
          }

          it("adds a comment control node") {
            let image = actionBarConfig.commentButton.image
            let title = NSAttributedString(
              string: actionBarConfig.commentButton.title!,
              attributes: actionBarConfig.commentButton.textAttributes)

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
            var configDisabled = config
            configDisabled.wall.post.actionBar.likeButton.enabled = false
            configDisabled.wall.post.actionBar.commentButton.enabled = false

            node = PostActionBarNode(width: width, config: config)
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
            var configDisabled = config
            configDisabled.wall.post.actionBar.likeButton.enabled = true
            configDisabled.wall.post.actionBar.commentButton.enabled = false

            node = PostActionBarNode(width: width, config: config)
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
