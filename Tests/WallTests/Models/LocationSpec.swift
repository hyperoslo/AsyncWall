import Quick
import Nimble

class LocationSpec: QuickSpec {

  override func spec() {
    describe("Location") {
      let name = "Greece"
      let coordinate = Coordinate(latitude: 3.14, longitude: 3.24)

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

          it ("has the right location") {
            expect(location.coordinate?.latitude).to(equal(coordinate.latitude))
            expect(location.coordinate?.longitude).to(equal(coordinate.longitude))
          }
        }

        context("without location") {
          beforeEach {
            location = Location(name: name)
          }

          it("sets a name") {
            expect(location.name).to(equal(name))
          }

          it ("does not have a coordinate") {
            expect(location.coordinate).to(beNil())
          }
        }
      }
    }
  }
}
