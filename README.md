# HelpKit

![Platform](https://img.shields.io/badge/platforms-iOS%2FiPadOS%2015.0%2B%20%7C%20macOS%2013.0%2B%20%7C%20tvOS%2015.0%2B%20%7C%20visionOS%201.0%2B%20%7C%20watchOS%208.0%2B-blue)

HelpKit provides developers for Apple platforms with the ability to add a Help screen to their apps. This is built using SwiftUI so can be displayed natively from a SwiftUI app or using a UIHostingController in a UIKit app.

This has been localised into multiple languages and the buttons will automatically adapt to your appʼs accent color.

1. [Requirements](#requirements)
2. [Integration](#integration)
3. [Usage](#usage)
    - [HKConfiguration](#hkconfiguration)
    - [HKTopicSection](#hktopicsection)
    - [HKTopic](#hktopic)
    - [HKLink](#hklink)
    - [HelpView](#helpview)
4. [Other Packages](#other-packages)
    - [AboutKit](https://github.com/adamfootdev/AboutKit)
    - [FeaturesKit](https://github.com/adamfootdev/FeaturesKit)

## Requirements

- iOS/iPadOS 15.0+
- macOS 13.0+
- tvOS 16.0+
- visionOS 1.0+
- watchOS 8.0+
- Xcode 15.0+

## Integration

### Swift Package Manager

HelpKit can be added to your app via Swift Package Manager in Xcode. Add to your project like so:

```swift
dependencies: [
    .package(url: "https://github.com/adamfootdev/HelpKit.git", from: "1.0.0")
]
```

## Usage

To start using the framework, you'll need to import it first:

```swift
import HelpKit
```

### HKConfiguration

This is a struct containing all of the relevant details required to configure HelpKit. It can be created like so:

```swift
let configuration = HKConfiguration(
    displayMode: .navigation,
    topicSections: topicSections
) {
    print("Get Support")
}
```

### HKTopicSection

This is a struct containing details about a help topic section. It can be created like so:

```swift
let topicSection = HKTopicSection(
    "Topic Section",
    topics: topics
)
```

### HKTopic

This is a struct containing details about a help topic. It can be created like so:

```swift
let topic = HKTopic(
    "Topic",
    iconSystemImage: "questionmark.circle",
    iconTint: .red,
    content: "Some content here…",
    contentImage: Image("image"),
    links: links,
    keywords: ["keyword"]
)
```

### HKLink

This is a struct containing details about a help link. It can be created like so:

```swift
let topic = HKLink(
    "Website",
    url: URL(string: "https://www.example.com")!
)
```

### HelpView

Create an instance of the view using the following:

```swift
HelpView(configuration: configuration)
```

## Other Packages

### [AboutKit](https://github.com/adamfootdev/AboutKit)

Add an about screen to your app.

### [FeaturesKit](https://github.com/adamfootdev/FeaturesKit)

Add a features list screen to your app.

### [HapticsKit](https://github.com/adamfootdev/HapticsKit)

Add haptic feedback to your app.
