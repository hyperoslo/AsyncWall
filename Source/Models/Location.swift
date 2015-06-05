public struct Location {

  public var name: String
  public var coordinate: Coordinate?

  public init(name: String, coordinate: Coordinate?) {
    self.name = name
    self.coordinate = coordinate
  }

}
