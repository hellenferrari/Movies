# Movies

## Requirements
- API: https://www.omdbapi.com/
- Each search should display a post, title, year of release and a button. Clicking the button should do nothing.
- Updates to the search term should update the result list

## What was used/done
- Time spent: ~7 hours. - split in 3 and 4 hours
- MVVM design pattern
- SwiftUI for the UI layer, but the code is adaptable for UIKit.
- Designed a high-level structure of the system.
- Separated the code to make it more scalable, flexible and testable.
- Cached Image
- Wrote some tests for ViewModel.

## System Design
- The App initializes the UI, the viewModel, and the type of httpClient for networking requests, in this scenario URLSession, the base URL.
![image](https://github.com/hellenferrari/Movies/assets/5003904/77ee98b5-50bf-4811-9275-5efb90d4c540)

## Movies App
![movies](https://github.com/hellenferrari/Movies/assets/5003904/c6fc4651-398a-4ec0-b65b-0cd30c453f95)


