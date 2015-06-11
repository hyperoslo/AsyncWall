import Quick
import Nimble
import Faker

class ControlNodeSpec: QuickSpec {

  override func spec() {
    describe("ControlNode") {
      let faker = Faker()
      let config = Config()

      let title = NSAttributedString(
        string: "Comment",
        attributes: config.wall.post.actionBar.commentButton.textAttributes)
      let url = Faker().internet.url()
      let image = UIImage()

      var node: ControlNode!

      beforeEach {
        node = ControlNode(config: config, title: title, image: image)
      }

      describe("#init") {

        it("returns a correct size") {
          expect(node.size).to(equal(config.wall.post.control.size))
        }

        it("adds a content node") {
          expect(node.contentNode).notTo(beNil())
          expect(node.contentNode.supernode).notTo(beNil())
          expect(node.contentNode.supernode).to(equal(node))
        }

        it("adds a title node") {
          expect(node.titleNode).notTo(beNil())
          expect(node.titleNode!.attributedString).to(equal(title))
          expect(node.titleNode!.supernode).notTo(beNil())
          expect(node.titleNode!.supernode).to(equal(node.contentNode))
        }

        it("adds an image node") {
          expect(node.imageNode).notTo(beNil())
          expect(node.imageNode!.image).to(equal(image))
          expect(node.imageNode!.supernode).notTo(beNil())
          expect(node.imageNode!.supernode).to(equal(node.contentNode))
        }

        context("with no title") {
          beforeEach {
            node = ControlNode(config: config, title: nil, image: image)
          }

          it("does not add a title node") {
            expect(node.titleNode).to(beNil())
          }
        }

        context("with no image") {
          beforeEach {
            node = ControlNode(config: config, title: title, image: nil)
          }

          it("does not add an image node") {
            expect(node.imageNode).to(beNil())
          }
        }
      }
    }
  }
}
