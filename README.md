# OMDB UIKit App

## Description
OMDB is an iOS application built using UIKit. It allows users to search for movies and view details fetched from the OMDB API.

## Features
- Search movies by title.
- View detailed information about each movie including plot, cast, and ratings.
- Favorite movies for quick access.

## Setup and Run

1. **Clone the Repository:**
    ```sh
    git clone https://github.com/Medunan/OMDBMovieList.git
    cd OMDBMovieList
    ```

2. **Open the Project in Xcode:**
    - Double-click the `OMDB.xcodeproj` file to open the project in Xcode.

3. **Configure API Key:**
    - The app requires an API key from the OMDB API. Obtain your API key from [OMDB API](http://www.omdbapi.com/apikey.aspx).
    - Open `Constants.swift` and replace `YOUR_API_KEY` with your actual API key:
    ```swift
    struct Constants {
        static let APIKey = "YOUR_API_KEY"
    }
    ```

4. **Build and Run:**
    - Select a simulator or your connected device from the Xcode toolbar.
    - Press the `Run` button (or `Cmd+R`) to build and run the app.

## Improvements

1. **User Interface Enhancements:**
    - Improve the overall look and feel by using custom fonts and colors.
    - Add animations to transitions and loading states.

2. **Error Handling:**
    - Implement more robust error handling and user feedback for network errors or invalid API responses.

3. **Offline Support:**
    - Cache search results and movie details for offline access.
