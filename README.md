# CodeChallenge
This project has been developed as part of a CodeChallenge from a company.
Left it public as a small sample of MVP (architecture pattern) on iOS.
I'll be uploading a "complete" MVP project soon (with explanation why I use MVP like that on iOS, a slightly better design and no 3rd party libs {if I need it I'll build it}).

## Build Instructions:
- Follow CocoaPods installation instructions from: https://cocoapods.org
- Run 'pod install' on project folder (from Terminal)
- Open the project from the .xcworkspace file (the white one)

## Third-party Libraries:
### Kingfisher:
Used to download and cache images from the web. It extends UIImageView, NSImage and UIButton, and is used on this project to load images asynchronously and keep a cache of it.
