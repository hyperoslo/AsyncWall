public struct Location {

  public var name: String
  public var latitude: Float?
  public var longitude: Float?

  public init(name: String, latitude: Float, longitude: Float) {
    self.name = name
    self.latitude = latitude
    self.longitude = longitude
  }

}
