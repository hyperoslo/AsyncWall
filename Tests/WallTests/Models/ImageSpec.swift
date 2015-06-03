import Quick
import Nimble

class ImageSpec: QuickSpec {

  override func spec() {
    describe("Image") {
      let source = "https://github.com/hyperoslo/Wall/blob/master/Images/logo-v2.png"
      var image: Image!

      beforeEach {
        image = Image(source)
      }

      describe("#thumbnail") {
        it("has the correct source") {
          expect(image.thumbnail.string).to(equal(source))
        }

        it("has the correct source URL") {
          expect(image.thumbnail.url).to(equal(source.url))
          expect(image.thumbnail.url).to(beAKindOf(NSURL.classForCoder()))
        }
      }
    }
  }
}
