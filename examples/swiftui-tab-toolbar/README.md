# SwiftUI Tab and Toolbar Lab

Runnable iOS 26 examples behind two KahWee.com investigations:

- [I Built the TabView Examples Apple's Docs Were Missing](https://kahwee.com/2025/understanding-swiftui-tabview/)
- [SwiftUI Moved My Toolbar Buttons Without Asking](https://kahwee.com/2025/swiftui-declarative-toolbar-placement/)

The app opens to an index of focused examples. The TabView group covers basic tabs, search roles, badges, programmatic selection, sidebar adaptation and paging. The toolbar group covers adaptive placements, overflow, search, modal controls and visibility.

## Run it

Open `SwiftUITabToolbarLab.xcodeproj` in Xcode with an iOS 26 SDK installed, select an iPhone or iPad simulator, and run the `SwiftUITabToolbarLab` scheme.

The command-line build is:

```bash
xcodebuild \
  -project SwiftUITabToolbarLab.xcodeproj \
  -scheme SwiftUITabToolbarLab \
  -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

The examples intentionally use system behavior rather than recreating tabs or toolbars. Compare compact and regular widths to see how SwiftUI changes placement and overflow.
