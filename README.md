# KahWee Labs

Runnable examples and benchmarks behind articles on
[KahWee.com](https://kahwee.com/). Each lab includes the source needed to repeat
its result.

Browse `examples/` for small apps and `benchmarks/` for measured experiments.
Benchmarks include their scripts and raw JSON or CSV output.

Use the pnpm version in [`package.json`](package.json). The JavaScript labs
require Node; the SwiftUI lab requires Xcode and an iOS 26 SDK.

```bash
pnpm install --frozen-lockfile
pnpm verify
```

Run the request-policy benchmark from the workspace root:

```bash
pnpm --filter @kahwee-labs/router-request-behavior benchmark
```

This writes new measurement evidence; review its output before committing it.
`pnpm verify` checks the JavaScript labs only. Build the SwiftUI lab separately
with its [Xcode instructions](examples/swiftui-tab-toolbar/README.md).

## Current investigations

- [React Router loaders and React Query](examples/react-router-loaders-vs-react-query/README.md):
  runnable loader, Query, and hybrid approaches.
- [SwiftUI tabs and toolbars](examples/swiftui-tab-toolbar/README.md):
  runnable iOS 26 examples.
- [Router request behavior](benchmarks/router-request-behavior/README.md):
  repeatable measurements for the routing comparison.

Each published article should link to the current lab and an immutable evidence tag. Each lab links back to the article, the writing hub, and [KahWee’s About page](https://kahwee.com/about/).
