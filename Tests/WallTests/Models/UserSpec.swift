import Quick
import Nimble
import Faker

class UserSpec: QuickSpec {

  let faker = Faker()

  override func spec() {
    describe("User") {
      let url = Faker().internet.url()
      let name = Faker().name.name()
      let avatar = Image(url)

      var user: User!

      beforeEach {
        user = User(name: name, avatar: avatar)
      }

      describe("#init") {
        context("with avatar") {
          it("sets a name") {
            expect(user.name).to(equal(name))
          }

          it("has the correct source URL") {
            expect(user.avatar!.thumbnail.string).to(equal(url))
            expect(user.avatar!.thumbnail.url).to(beAKindOf(NSURL.classForCoder()))
          }
        }

        context("without avatar") {
          beforeEach {
            user = User(name: name)
          }

          it("sets a name") {
            expect(user.name).to(equal(name))
          }

          it("has no avatar") {
            expect(user.avatar).to(beNil())
          }
        }
      }
    }
  }
}

