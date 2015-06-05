import Quick
import Nimble

class CoordinateSpec: QuickSpec {

  override func spec() {
    describe("Coordinate") {
      let latitude = 3.14
      let longitude = 3.24

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
