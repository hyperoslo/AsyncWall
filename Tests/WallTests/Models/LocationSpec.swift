import Quick
import Nimble

class LocationSpec: QuickSpec {

  override func spec() {
    describe("Location") {
      let name = "Greece"
      let coordinate = Coordinate(latitude: 3.14, longitude: 3.14)

      var location : Location!

      beforeEach {
        location = Location(name: name, coordinate: coordinate)
      }

      describe("#init") {
        context("with location") {
          it("sets a name") {
            expect(location.name).to(equal(name))
          }

          it ("has a coordinate") {
            expect(location.coordinate).notTo(beNil())
          }
        }

        context("without location") {
          beforeEach {
            location = Location(name: name, coordinate: nil)
          }

          it("sets a name") {
            expect(location.name).to(equal(name))
          }

          it ("has a coordinate") {
            expect(location.coordinate).to(beNil())
          }
        }
      }
    }
  }
}
