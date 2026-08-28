# SwiftUI Tab and Toolbar Lab

Runnable examples for two KahWee.com investigations:

- [What SwiftUI's Tab APIs Actually Do](https://kahwee.com/2025/understanding-swiftui-tabview/)
- [SwiftUI Toolbar Placement Is Intent, Not Coordinates](https://kahwee.com/2025/swiftui-declarative-toolbar-placement/)

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

The `Tab` structure, search role and sidebar-adaptable style were introduced in iOS 18. This project targets iOS 26 to show how the same structure adopts Liquid Glass, toolbar grouping and the updated search presentation.

The examples intentionally use system behavior rather than recreating tabs or toolbars. Compare compact and regular widths to see how SwiftUI changes placement and overflow. The project currently proves iPhone and iPad behavior; it does not include a macOS target.
