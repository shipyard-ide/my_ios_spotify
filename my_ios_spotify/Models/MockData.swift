//
//  MockData.swift
//  my_ios_spotify
//

import Foundation

struct MockData {
    static let tracks: [Track] = [
        Track(title: "Blinding Lights", artist: "The Weeknd", albumArt: "album1", duration: 200),
        Track(title: "Shape of You", artist: "Ed Sheeran", albumArt: "album2", duration: 234),
        Track(title: "Dance Monkey", artist: "Tones and I", albumArt: "album3", duration: 210),
        Track(title: "Someone You Loved", artist: "Lewis Capaldi", albumArt: "album4", duration: 182),
        Track(title: "Watermelon Sugar", artist: "Harry Styles", albumArt: "album5", duration: 174),
        Track(title: "Don't Start Now", artist: "Dua Lipa", albumArt: "album6", duration: 183),
        Track(title: "Circles", artist: "Post Malone", albumArt: "album7", duration: 215),
        Track(title: "Sunflower", artist: "Post Malone", albumArt: "album8", duration: 158),
    ]
    
    static let playlists: [Playlist] = [
        Playlist(name: "Today's Top Hits", coverImage: "playlist1", description: "The hottest tracks right now", tracks: Array(tracks.prefix(5))),
        Playlist(name: "Chill Vibes", coverImage: "playlist2", description: "Kick back and relax", tracks: Array(tracks.suffix(5))),
        Playlist(name: "Workout Mix", coverImage: "playlist3", description: "Get pumped!", tracks: tracks.shuffled()),
        Playlist(name: "Road Trip", coverImage: "playlist4", description: "Songs for the open road", tracks: tracks.shuffled()),
        Playlist(name: "Late Night Jazz", coverImage: "playlist5", description: "Smooth jazz for late nights", tracks: Array(tracks.prefix(4))),
        Playlist(name: "Indie Discoveries", coverImage: "playlist6", description: "Fresh indie tracks", tracks: Array(tracks.suffix(4))),
    ]
    
    static let recentlyPlayed: [Playlist] = Array(playlists.prefix(4))
    
    static let artists: [Artist] = [
        Artist(name: "The Weeknd", image: "artist1", monthlyListeners: 85_000_000),
        Artist(name: "Ed Sheeran", image: "artist2", monthlyListeners: 78_000_000),
        Artist(name: "Dua Lipa", image: "artist3", monthlyListeners: 65_000_000),
        Artist(name: "Post Malone", image: "artist4", monthlyListeners: 60_000_000),
        Artist(name: "Harry Styles", image: "artist5", monthlyListeners: 55_000_000),
    ]
    
    static let searchCategories: [SearchCategory] = [
        SearchCategory(name: "Pop", color: "pink", icon: "music.note"),
        SearchCategory(name: "Hip-Hop", color: "orange", icon: "mic.fill"),
        SearchCategory(name: "Rock", color: "red", icon: "guitars.fill"),
        SearchCategory(name: "R&B", color: "purple", icon: "music.mic"),
        SearchCategory(name: "Electronic", color: "blue", icon: "waveform"),
        SearchCategory(name: "Jazz", color: "brown", icon: "pianokeys"),
        SearchCategory(name: "Classical", color: "gray", icon: "music.quarternote.3"),
        SearchCategory(name: "Country", color: "yellow", icon: "music.note.house.fill"),
        SearchCategory(name: "Podcasts", color: "green", icon: "mic.circle.fill"),
        SearchCategory(name: "Audiobooks", color: "teal", icon: "book.fill"),
        SearchCategory(name: "Charts", color: "indigo", icon: "chart.line.uptrend.xyaxis"),
        SearchCategory(name: "New Releases", color: "mint", icon: "sparkles"),
    ]
}
