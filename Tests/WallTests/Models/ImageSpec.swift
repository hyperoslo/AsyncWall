import Quick
import Nimble
import Faker

class ImageSpec: QuickSpec {

  override func spec() {
    describe("Image") {
      let source = Faker().internet.url()
      var image: Image!

      beforeEach {
        image = Image(source)
      }

      describe("#thumbnail") {
        it("has the correct source") {
          expect(image.thumbnail?.string).to(equal(source))
        }

        it("has the correct source URL") {
          expect(image.thumbnail?.url).to(equal(source.url))
          expect(image.thumbnail?.url).to(beAKindOf(NSURL.classForCoder()))
        }
      }
    }
  }
}
