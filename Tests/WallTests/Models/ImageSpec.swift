import Quick
import Nimble
import Faker

class ImageSpec: QuickSpec {

  override func spec() {
    describe("Image") {
      let source = Faker().internet.url()
      let thumbnail = Faker().internet.url()
      var image: Image!

      beforeEach {
        image = Image(source)
      }

      describe("#thumbnail") {
        it("has the correct source") {
          expect(image.source?.string).to(equal(source))

        }

        it("does not have a thumbnail") {
          expect(image.thumbnail).to(beNil())
        }

        it("has thumbnail") {
          image.thumbnail = thumbnail
          expect(image.thumbnail?.string).to(equal(thumbnail))
        }

        it("has the correct source URL") {
          expect(image.source?.url).to(equal(source.url))
          expect(image.source?.url).to(beAKindOf(NSURL.classForCoder()))
        }
      }
    }
  }
}
