# QDHeaderTabbarViewController

[![CI Status](https://img.shields.io/travis/244514311@qq.com/QDHeaderTabbarViewController.svg?style=flat)](https://travis-ci.org/244514311@qq.com/QDHeaderTabbarViewController)
[![Version](https://img.shields.io/cocoapods/v/QDHeaderTabbarViewController.svg?style=flat)](https://cocoapods.org/pods/QDHeaderTabbarViewController)
[![License](https://img.shields.io/cocoapods/l/QDHeaderTabbarViewController.svg?style=flat)](https://cocoapods.org/pods/QDHeaderTabbarViewController)
[![Platform](https://img.shields.io/cocoapods/p/QDHeaderTabbarViewController.svg?style=flat)](https://cocoapods.org/pods/QDHeaderTabbarViewController)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

QDHeaderTabbarViewController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'QDHeaderTabbarViewController'
```

## Usage
```swift
let vc = QDHeaderTabbarViewController()
vc.dataSources = [("关注", ViewController()), ("热门", ViewController()), ("关注", ViewController()), ("热门", ViewController()), ("关注", ViewController()), ("热门", ViewController())]

vc.headerItemWidth = 80
vc.headerHeight = 40
vc.selectedTitleFont = UIFont.systemFont(ofSize: 14)
vc.unSelectedTitleFont = UIFont.systemFont(ofSize: 11)
```

## Result
![结果](demo.gif)

## Author

244514311@qq.com, 244514311@qq.com

## License

QDHeaderTabbarViewController is available under the MIT license. See the LICENSE file for more info.
