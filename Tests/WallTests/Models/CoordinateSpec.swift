import Quick
import Nimble
import Faker

class CoordinateSpec: QuickSpec {

  override func spec() {
    describe("Coordinate") {
      let latitude = (Faker().address.latitude() as NSString).doubleValue
      let longitude = (Faker().address.longitude() as NSString).doubleValue

      var coordinate: Coordinate!

      beforeEach {
        coordinate = Coordinate(latitude: latitude, longitude: longitude)
      }

      describe("#init") {
        context("with latitude and longitude") {
          it ("has the right location") {
            expect(coordinate.latitude).to(equal(latitude))
            expect(coordinate.longitude).to(equal(longitude))
          }
        }
      }
    }
  }
}
