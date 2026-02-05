//
//  PlayerViewModel.swift
//  my_ios_spotify
//

import SwiftUI
import Combine

final class PlayerViewModel: ObservableObject {
    @Published var currentTrack: Track?
    @Published var isPlaying: Bool = false
    @Published var currentTime: TimeInterval = 0
    @Published var showNowPlaying: Bool = false
    @Published var queue: [Track] = []
    @Published var shuffleEnabled: Bool = false
    @Published var repeatMode: RepeatMode = .off
    
    enum RepeatMode {
        case off, all, one
        
        var icon: String {
            switch self {
            case .off: return "repeat"
            case .all: return "repeat"
            case .one: return "repeat.1"
            }
        }
        
        var isActive: Bool {
            self != .off
        }
    }
    
    private var timer: AnyCancellable?
    
    var progress: Double {
        guard let track = currentTrack else { return 0 }
        return currentTime / track.duration
    }
    
    func play(track: Track) {
        currentTrack = track
        isPlaying = true
        currentTime = 0
        startTimer()
    }
    
    func play(playlist: Playlist) {
        queue = shuffleEnabled ? playlist.tracks.shuffled() : playlist.tracks
        if let first = queue.first {
            play(track: first)
        }
    }
    
    func togglePlayPause() {
        isPlaying.toggle()
        if isPlaying {
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    func skipForward() {
        guard let current = currentTrack,
              let index = queue.firstIndex(where: { $0.id == current.id }),
              index + 1 < queue.count else {
            if repeatMode == .all, let first = queue.first {
                play(track: first)
            }
            return
        }
        play(track: queue[index + 1])
    }
    
    func skipBackward() {
        if currentTime > 3 {
            currentTime = 0
            return
        }
        
        guard let current = currentTrack,
              let index = queue.firstIndex(where: { $0.id == current.id }),
              index > 0 else {
            currentTime = 0
            return
        }
        play(track: queue[index - 1])
    }
    
    func seek(to progress: Double) {
        guard let track = currentTrack else { return }
        currentTime = progress * track.duration
    }
    
    func toggleShuffle() {
        shuffleEnabled.toggle()
    }
    
    func cycleRepeatMode() {
        switch repeatMode {
        case .off: repeatMode = .all
        case .all: repeatMode = .one
        case .one: repeatMode = .off
        }
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTime()
            }
    }
    
    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    private func updateTime() {
        guard let track = currentTrack, isPlaying else { return }
        
        if currentTime >= track.duration {
            if repeatMode == .one {
                currentTime = 0
            } else {
                skipForward()
            }
            return
        }
        
        currentTime += 0.1
    }
}
