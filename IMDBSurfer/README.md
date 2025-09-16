# IMDBSurfer 🎬

A modern iOS app for browsing movies and TV shows using The Movie Database (TMDB) API. Built with SwiftUI and following MVVM architecture patterns.

## Features

### 🎯 Core Functionality
- **Browse Popular Content**: Discover trending movies and TV shows
- **Search**: Find any movie or TV show with real-time search
- **Favorites Management**: Save your favorite content with persistent storage
- **Detailed Views**: Rich detail pages with ratings, overviews, and metadata
- **Trailer Integration**: Watch trailers directly from YouTube
- **High-Quality Images**: Optimized image loading with Kingfisher

### 🎨 User Experience
- **Clean Interface**: Modern SwiftUI design with smooth animations
- **Dark/Light Mode**: Toggle between themes with persistent preference storage
- **Tab Navigation**: Easy switching between Movies, TV Shows, and Favorites
- **Responsive Grid Layouts**: Optimized for different screen sizes
- **Icon-Based Actions**: Intuitive heart, share, and play buttons
- **Loading States**: Proper loading indicators and error handling

### 🏗️ Technical Features
- **MVVM Architecture**: Clean separation of concerns
- **Protocol-Oriented Design**: Flexible ContentItem protocol
- **Unit Tests**: Comprehensive test coverage (7 test cases)
- **Persistent Storage**: UserDefaults-based favorites management
- **Image Caching**: Optimized Kingfisher configuration
- **API Integration**: RESTful TMDB API integration

## Requirements

- **iOS 18.2+**
- **Xcode 16.0+**
- **Swift 5.9+**
- **TMDB API Key** (free registration required)

## Installation

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/IMDBSurfer.git
cd IMDBSurfer
```

### 2. Get TMDB API Key
1. Visit [The Movie Database (TMDB)](https://www.themoviedb.org/)
2. Create a free account
3. Go to Settings → API → Create API Key
4. Copy your API key

### 3. Configure API Key
Create a `.env` file in the `IMDBSurfer/` directory:
```bash
# Create the .env file
touch IMDBSurfer/.env
```

Add your API key to the `.env` file:
```env
TMDB_API_KEY=your_api_key_here
```

**⚠️ Important**: Never commit your `.env` file to version control. It's already included in `.gitignore`.


### 4. Open in Xcode
```bash
open IMDBSurfer.xcodeproj
```

### 5. Run the App
- Select your target device or simulator
- Press `⌘ + R` to build and run

## Project Structure

```
IMDBSurfer/
├── IMDBSurfer/
│   ├── Models/                 # Data models
│   │   ├── ContentItem.swift   # Protocol for shared content
│   │   ├── Movie.swift         # Movie data model
│   │   ├── TVShow.swift        # TV show data model
│   │   ├── Search.swift        # Search result model
│   │   ├── ContentResponse.swift
│   │   └── SearchResponse.swift
│   ├── Views/                  # SwiftUI views
│   │   ├── ContentView.swift   # Main tab view
│   │   ├── MovieDetailsView.swift
│   │   ├── TVShowDetailsView.swift
│   │   ├── FavoritesView.swift
│   │   ├── SearchView.swift
│   │   ├── ResultsView.swift
│   │   ├── MovieCard.swift     # Reusable content card
│   │   └── HorizontalMovieList.swift
│   ├── TMDBService/            # API service layer
│   │   └── TMDBService.swift   # TMDB API integration
│   ├── Utilities/              # Helper classes
│   │   ├── Constants.swift     # App constants & API config
│   │   ├── FavoritesManager.swift # Favorites persistence
│   │   ├── ImageConfiguration.swift # Kingfisher setup
│   │   └── ThemeManager.swift  # Dark/Light mode management
│   ├── Assets.xcassets/        # App assets
│   ├── IMDBSurferApp.swift     # App entry point
│   └── .env                    # API keys (create this)
├── IMDBSurferTests/            # Unit tests
├── IMDBSurferUITests/          # UI tests
└── README.md
```

## Architecture

### MVVM Pattern
- **Models**: Data structures for movies, TV shows, and search results
- **Views**: SwiftUI views handling UI presentation
- **ViewModels**: `ContentService` and `FavoritesManager` managing business logic

### Key Components

#### ContentService
Handles all TMDB API interactions:
- Fetches popular, top-rated, and now-playing content
- Manages search functionality
- Retrieves trailer URLs
- Handles network errors gracefully

#### FavoritesManager
Manages user's favorite content:
- Persistent storage using UserDefaults
- Type-safe operations for movies, TV shows, and search results
- Duplicate prevention
- Observable for real-time UI updates

#### ThemeManager
Handles app-wide theme switching:
- Persistent dark/light mode preference
- Singleton pattern for global access
- SwiftUI ColorScheme integration
- Automatic theme persistence across app launches

#### ContentItem Protocol
Unified interface for different content types:
```swift
protocol ContentItem: Codable, Identifiable {
    var id: Int { get }
    var title: String? { get }
    var name: String? { get }
    var overview: String? { get }
    var posterPath: String? { get }
    var releaseDate: String? { get }
    var voteAverage: Double? { get }
    var fullPosterURL: URL? { get }
}
```

## API Integration

### TMDB Endpoints Used
- `/movie/popular` - Popular movies
- `/movie/top_rated` - Top rated movies  
- `/movie/now_playing` - Now playing movies
- `/tv/popular` - Popular TV shows
- `/tv/top_rated` - Top rated TV shows
- `/tv/on_the_air` - On air TV shows
- `/search/multi` - Multi-search (movies & TV)
- `/movie/{id}/videos` - Movie trailers
- `/tv/{id}/videos` - TV show trailers

### Rate Limiting
The app respects TMDB's rate limits and includes proper error handling for API failures.


### Test Coverage
The app includes 7 comprehensive unit tests covering:
- Model URL generation and validation
- Search result media type identification  
- Favorites manager operations
- Duplicate prevention logic
- Service initialization

### Test Files
- `IMDBSurferTests.swift` - Unit tests for core functionality
- `IMDBSurferUITests.swift` - UI automation tests

## Dependencies

### Kingfisher
Used for efficient image loading and caching:
```swift
// Configured in ImageConfiguration.swift
- Memory cache: 100MB limit, 5-minute expiration
- Disk cache: 500MB limit, 1-day expiration  
- Download timeout: 15 seconds
- Image downsampling for performance
```

## Configuration

### Build Configurations
- **Debug**: Full logging, no optimizations
- **Release**: Optimized for App Store distribution

### Info.plist Settings
- Network security settings for TMDB API
- App Transport Security configured for HTTPS

## Contributing

### Code Style
- Follow Swift API Design Guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Maintain consistent indentation (4 spaces)

### Pull Request Process
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## Troubleshooting

### Common Issues

#### "Could not load .env file" Error
- Ensure `.env` file exists in `IMDBSurfer/` directory
- Verify the file contains `TMDB_API_KEY=your_key_here`
- Check file permissions

#### Images Not Loading
- Verify internet connection
- Check TMDB API key validity
- Review network security settings

#### Search Not Working  
- Confirm API key has search permissions
- Check for rate limiting
- Verify query encoding

### Debug Mode
Enable debug logging by adding to your `.env` file:
```env
DEBUG_MODE=true
```

## Acknowledgments

- [The Movie Database (TMDB)](https://www.themoviedb.org/) for the comprehensive API
- [Kingfisher](https://github.com/onevcat/Kingfisher) for excellent image loading
- Apple's SwiftUI framework for the modern UI toolkit

## Contact

**Developer**: Hadi Samara  
**Email**: hadi.sam1998@gmail.com
**GitHub**: Hadisam23

---

**⭐ If you found this project helpful, please give it a star!**
