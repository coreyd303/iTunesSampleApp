# Overview

This is a sample app demonstrating implementation of MVVM-C architecture, Dependency Injection, Protocol Wrapping, and Unit Testing. This app is intended to provide a code sample.

## I have provided a short preview video here . . .
[Preview on Youtube](https://youtu.be/QKDO98mTHSE)

# Notes on Development
* **Architecture:** The overarching design of this app uses the MVVM-C architecture, also known as the Coordinator pattern. There are many different valid patterns that could have been used to accomplish the required tasks, and some of them would have been must faster to complete, however I believe that the sacrifices would not have justified them. I prefer the Coordinator pattern in the majority of implementations for a number of reasons. The first being that it creates a robust code base that has an inherently low cost of change. Where this to become a production app it would be very easy to change, remove, or add features owing largely to the component style layout of Coordinator based apps. 

The greatest trade off when using this pattern is speed of development, there is simply more code to write. However, the benefits far outweigh this sacrifice. Coordinator patterned apps utilize delegate as a native trait, this lends itself to a strong adherence to SRP and very easy code maintenance. Further improving the Coordinator implementation through the practice of protocols and dependency injection creates a code base that is testable to a degree not often see in software. The current test coverage for this app is just over 87%, this is entirely due to a simple choice to constrain my development time. You will notice some notes in testing files, and some files that were excluded from testing. These exclusions are not due to an inability to test, but instead a desire to provide a well implemented project in a timely manor; it would be very easy to provide testing coverage at or near 100%.

It is possible to implement this pattern with Storyboards, however I personally prefer not to use storyboards for a couple of reasons. First, there continue to be bugs in storyboards that live deep in Apples ecosystem. I have come across them time and again, and historically lost too much time to trying to chase them down. I have found that they can be avoided by simply using a code based implementation for all views.  Second, storyboards work in contrast to maintaining a low cost of change. Due to the potential complexities related to implementing auto-layout within the storyboard GUI I have often felt that using the storyboard editor actually makes it more difficult to make simple UI changes. The last being that code-wise implementation of UI is a standard across software, I have always felt that these types of industry standards should be respected.

A simple underlying support structure is provided within the app; see specifically “[Base]”. Here you will see a collection of object wrapping UIKit navigation. This is done for two reasons. The first being to provide an easy solution for managing navigation within the Coordinator architecture. The second reason being to allow mocking of navigation within the testing target. This means that we are able to test navigation calls without relying on heavy handed and arduous UITests within the code base.

Inline documentation is provided, I support this practice to further enhance a dedication to a lowered cost of change, and to provide a low barrier of entry to understanding code.

* **Testing:** In this app I have used a unit only testing strategy. I prefer to leverage the Quick/Nimble testing framework because of its very human readable syntax and its ease of implementation. Testing relies heavily on mocking and dependency injection enabled by the generous use of protocols within the app. I subscribe to a standard of one declaration to one expectation, meaning that each test is very simple, easy to read, and works to provide documentation for the code. Using this testing strategy creates a robust testing suite that offers a very high degree of code confidence, and greatly lowers the probability of bugs.

* **Test Automation:** Test automation is best provided at the time of code deliver and I would generally manage this through an implementation of Circle CI or a similar tool. This can be subscribed to the code repo and can allow an easy way to run tests as a part of the acceptance protocol. If a more localized implementation where required a combination of Fastlane and Xcode server could be configured for this purpose as well.

# Additional Testing Notes
### Tests are developed to support a high level of code confidence and can be run from Xcode via
_cmd + u_

* Mocks and stubs are found in their respective folders within the testing target. Mocks are generally generated using Swift Mock Generator.
[SwiftMockGeneratorForXcode](https://github.com/seanhenry/SwiftMockGeneratorForXcode)

# System Requirements
* Catalina
* Xcode 11 +
* Swift 5
* Carthage

# Dependencies
### This project contains dependencies compiled with Carthage
You will need to install Carthage if you don't already have in on your system. This is easiest with HomeBrew

## - Carthage
Should you need to install Carthage it can be done via Homebrew

1. install Carthage via homebrew
```
$ brew install Carthage
```

If Homebrew is not your preferred method you can find additional documentation to support installation here...
[Intalling Carthage](https://github.com/Carthage/Carthage#installing-carthage)

2. Framework binaries should be included with the project, however should you need to compile them locally they can be added using
```
$ carthage update --no-use-binaries --platform iOS
```