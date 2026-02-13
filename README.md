# Personal Inventory (SwiftUI)

This is a SwiftUI starter app for tracking personal inventory and organizing custom item lists.

## Features
- Add, edit, delete inventory items
- Categorize items and track quantities
- Mark favorites and quickly see low-stock items
- Search by name, notes, tags, and location
- Create custom lists and assign items to those lists
- Local persistence using JSON in the app's documents directory

## Project Structure
- `PersonalInventory/PersonalInventoryApp.swift`: App entry point
- `PersonalInventory/Models`: Item and list models
- `PersonalInventory/Services/InventoryStore.swift`: Local data load/save
- `PersonalInventory/ViewModels/InventoryViewModel.swift`: App state and actions
- `PersonalInventory/Views`: Dashboard, items tab, lists tab, and editors

## Run In Xcode
1. Create a new iOS App project in Xcode (Swift + SwiftUI).
2. Remove the default generated Swift files.
3. Copy the files from this repo's `PersonalInventory` folder into your project.
4. Ensure all copied files are part of your app target.
5. Build and run on simulator or device.

## Suggested Next Improvements
- Add photos per item
- Add barcode scanning
- Add reminders for restocking
- Add iCloud sync
