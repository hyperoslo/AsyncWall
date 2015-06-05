import Quick
import Nimble

class GroupSpec: QuickSpec {

  override func spec() {
    describe("Group") {
      let url = "https://avatars2.githubusercontent.com/u/1340892?v=3&s=200"
      let name = "Hyper"
      let image = Image(url)

      var group: Group!

      beforeEach {
        group = Group(name: name, image: image)
      }

      describe("#init") {
        context("with image") {
          it("sets name") {
            expect(group.name).to(equal(name))
          }

          it("has the correct source URL") {
            expect(group.image!.thumbnail.string).to(equal(url))
            expect(group.image!.thumbnail.url).to(beAKindOf(NSURL.classForCoder()))
          }
        }

        context("without image") {
          beforeEach {
            group = Group(name: name)
          }

          it("sets a name") {
            expect(group.name).to(equal(name))
          }

          it("has no avatar") {
            expect(group.image).to(beNil())
          }
        }
      }
    }
  }
}
