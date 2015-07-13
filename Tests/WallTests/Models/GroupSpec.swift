import Quick
import Nimble
import Faker

class GroupSpec: QuickSpec {

  override func spec() {
    describe("Group") {
      let url = Faker().internet.url()
      let name = Faker().team.name()
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
            expect(group.image!.source?.string).to(equal(url))
            expect(group.image!.source?.url).to(beAKindOf(NSURL.classForCoder()))
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
