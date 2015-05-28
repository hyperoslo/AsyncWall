![Wall logo](https://raw.githubusercontent.com/hyperoslo/Wall/master/Images/logo-v2.png)

[![CI Status](http://img.shields.io/travis/hyperoslo/Wall.svg?style=flat)](https://travis-ci.org/hyperoslo/Wall)
[![Version](https://img.shields.io/cocoapods/v/Wall.svg?style=flat)](http://cocoadocs.org/docsets/Wall)
[![License](https://img.shields.io/cocoapods/l/Wall.svg?style=flat)](http://cocoadocs.org/docsets/Wall)
[![Platform](https://img.shields.io/cocoapods/p/Wall.svg?style=flat)](http://cocoadocs.org/docsets/Wall)

## Usage

### View Models

#### Post

```swift
let post = Post(author: user, date: NSDate(), text: "Hello World!")

let postWithAttachments = Post(author: user, date: NSDate(), text: "Hello World!", [Attachment, Attachment])

#### Attachment
```swift
let url = "https://github.com/hyperoslo/Wall/blob/master/Images/logo-v2.png"
let attachment = Attachment(url, .Image)
```

#### User
```swift
let url = "https://avatars2.githubusercontent.com/u/1340892?v=3&s=200"
let user = User(name: "John Hyperseed", avatar: url)
```

## Installation

**Wall** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Wall'
```

## Author

Hyper, ios@hyper.no

## License

**Wall** is available under the MIT license. See the LICENSE file for more info.
