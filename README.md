# TKSequenceTextField

[![CI Status](http://img.shields.io/travis/tokenlab/TKSequenceTextField.svg?style=flat)](https://travis-ci.org/tokenlab/TKSequenceTextField)
[![Semver](http://img.shields.io/SemVer/2.0.0.png)](http://semver.org/spec/v2.0.0.html)

**TKSequenceTextField** is an UITextField component that takes multiple masks and applies them in real-time on the user's input, based on the input's length.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

TKSequenceTextField is available through Tokenlab's [TKPodSpec](https://github.com/tokenlab/TKPodSpecs). To install
it, simply add the following lines to your Podfile:

```ruby
source 'https://github.com/tokenlab/TKPodSpecs'
pod 'TKSequenceTextField', '~> 0.1'
```

If you want to use it along with other **CocoaPods** components, you
may need to add both sources. e.g:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/tokenlab/TKPodSpecs'

target 'CustomProject' do
  pod 'Alamofire', '~> 4.0'
  pod 'TKSequenceTextField', '~> 0.1'
end
```

>note: "~> 0.1" means that we want version 0.1 and the versions up to 1.0, not including 1.0 and higher.

## How to use
TKSequenceTextField can be used with a list of masks.
e.g:

```swift
let sequenceTextField = TKSequenceTextField()
sequenceTextField.setMaskSequence(["**.**", "***-***", "$$-$$$"])
```

If you want no masks at all:
```swift
let sequenceTextField = TKSequenceTextField()

sequenceTextField.setMaskSequence([])
//or
sequenceTextField.setMaskSequence([""])
```

>Use $ for digits: ($$-$$$$)  
>And * for characters: [a-zA-Z] (\*\*-\*\*\*\*)

This custom TextField will reorder its maskSequence by mask length (smaller to bigger)

## Author

Eduardo Domene Junior, eduardodomene@tokenlab.com.br

## License

TKSequenceTextField is available under the MIT license. See the LICENSE file for more info.
