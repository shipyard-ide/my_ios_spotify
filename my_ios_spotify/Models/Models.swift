//
//  Models.swift
//  my_ios_spotify
//

import Foundation

struct Track: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let albumArt: String
    let duration: TimeInterval
    
    var durationString: String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

struct Playlist: Identifiable {
    let id = UUID()
    let name: String
    let coverImage: String
    let description: String
    let tracks: [Track]
}

struct Album: Identifiable {
    let id = UUID()
    let name: String
    let artist: String
    let coverImage: String
    let year: Int
    let tracks: [Track]
}

struct Artist: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let monthlyListeners: Int
    
    var listenersString: String {
        if monthlyListeners >= 1_000_000 {
            return String(format: "%.1fM monthly listeners", Double(monthlyListeners) / 1_000_000)
        } else if monthlyListeners >= 1_000 {
            return String(format: "%.1fK monthly listeners", Double(monthlyListeners) / 1_000)
        }
        return "\(monthlyListeners) monthly listeners"
    }
}

struct SearchCategory: Identifiable {
    let id = UUID()
    let name: String
    let color: String
    let icon: String
}
