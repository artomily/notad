# Notad

Receipt scanner and expense tracker for iOS. Point the camera at a receipt, and the merchant, total, and date are extracted and saved locally.

Built as a portfolio project to explore on-device text recognition, SwiftData persistence, and Swift 6 strict concurrency.

> **Status:** in development. Scanning is not wired up yet — see [Roadmap](#roadmap) for what is and isn't done.

## Screenshots

<!-- Ganti dengan screenshot asli setelah UI stabil -->
| List | Detail |
|------|--------|
| _coming soon_ | _coming soon_ |

## Features

- Local-first storage with SwiftData — no account, no network, no tracking
- Inline editing for every parsed field, because OCR gets things wrong
- Monthly spending summary
- Indonesian number format handling (`45.000,00` → `45000`)

## Why native

I already keep a transaction ledger in my personal web dashboard, but every entry was typed by hand. That friction is the whole problem, and it isn't one the web can solve — capturing a receipt needs a camera in your pocket at the moment you get it. So Notad is the capture layer, and the web app stays what it's good at: review and analysis.

## Architecture

```
notad/
├── Models/          Receipt (@Model)
├── Core/
│   ├── Theme.swift
│   └── Parsing/     ParsedReceipt, ReceiptParser
└── Features/
    ├── List/        ContentView, ReceiptRow
    ├── Detail/      ReceiptDetailView
    └── Scanner/     (planned)
```

### Two receipt types, on purpose

`ParsedReceipt` has optional fields. `Receipt` has none.

That split is the core design decision. Parser output is untrusted — OCR misreads `TOTAL` as `TOTAI`, some receipts split the amount across lines, and merchant names vary wildly. Everything is optional because everything can fail. `Receipt` is what gets persisted, so it's fully populated by definition. The user's edit is the bridge between them.

### The parser is a pure struct

`ReceiptParser` imports nothing but Foundation. No Vision, no SwiftUI, no camera. It takes `[String]` and returns `ParsedReceipt`.

This is what makes the hardest part of the app testable without hardware. Receipt fixtures are just string arrays in the test file, so parsing rules can be verified on any machine, including CI.

### Currency is `Int`, not `Double`

Floating point can't represent decimal fractions exactly, which is how rounding errors accumulate in financial software. Rupiah has no practical subunit, so amounts are stored as whole rupiah in an `Int`. If multi-currency is ever added, this becomes `Decimal`.

## Requirements

- iOS 26+
- Xcode 26+
- Swift 6 (strict concurrency enabled)
- A physical device (A12 Bionic or later) for camera scanning; the rest runs in the Simulator

## Getting started

```bash
git clone https://github.com/artomily/notad.git
cd notad
open notad.xcodeproj
```

Run tests with `Cmd+U`, or:

```bash
xcodebuild test -scheme notad -destination 'platform=iOS Simulator,name=iPhone 17 Pro'
```

## Testing

Unit tests use [Swift Testing](https://developer.apple.com/documentation/testing). Coverage focuses on `ReceiptParser`, where the real complexity lives.

Test cases are grown from actual failures. When a real receipt parses wrong, the failing text becomes a new fixture before the rule is changed.

## Roadmap

- [x] SwiftData model and persistence
- [x] Receipt list with monthly total
- [x] Detail view with inline editing
- [x] `ReceiptParser` with unit tests
- [ ] Vision OCR from photo library
- [ ] Live camera scanning via `DataScannerViewController`
- [ ] Rule-based merchant categorisation
- [ ] Home screen widget (WidgetKit)
- [ ] VoiceOver and Dynamic Type audit
- [ ] CI on GitHub Actions
- [ ] TestFlight build

### Not planned

On-device categorisation via Foundation Models was considered and dropped. Apple Intelligence requires an iPhone 15 Pro or newer, so it wouldn't run on the device this app is developed and tested on. Rule-based categorisation is deterministic, testable, and works everywhere.

## Author

Rakyavara Artomily — [github.com/artomily](https://github.com/artomily)
