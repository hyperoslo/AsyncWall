import Quick
import Nimble
import Faker

class LocationSpec: QuickSpec {

  override func spec() {
    describe("Location") {
      let name = Faker().address.city()
      let coordinate = Coordinate(
        latitude: Faker().address.latitude(),
        longitude: Faker().address.longitude())

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
