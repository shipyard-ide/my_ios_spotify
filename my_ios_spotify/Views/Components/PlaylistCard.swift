//
//  PlaylistCard.swift
//  my_ios_spotify
//

import SwiftUI

struct PlaylistCard: View {
    let playlist: Playlist
    let size: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AlbumArtView(imageName: playlist.coverImage, size: size, cornerRadius: 8)
            
            Text(playlist.name)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .lineLimit(2)
        }
        .frame(width: size)
    }
}

struct RecentPlaylistRow: View {
    let playlist: Playlist
    @EnvironmentObject var playerVM: PlayerViewModel
    
    var body: some View {
        Button {
            playerVM.play(playlist: playlist)
        } label: {
            HStack(spacing: 8) {
                AlbumArtView(imageName: playlist.coverImage, size: 56, cornerRadius: 4)
                
                Text(playlist.name)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .frame(height: 56)
            .background(Color.white.opacity(0.1))
            .cornerRadius(4)
        }
        .buttonStyle(.plain)
    }
}

struct TrackRow: View {
    let track: Track
    let index: Int?
    @EnvironmentObject var playerVM: PlayerViewModel
    
    init(track: Track, index: Int? = nil) {
        self.track = track
        self.index = index
    }
    
    var isPlaying: Bool {
        playerVM.currentTrack?.id == track.id && playerVM.isPlaying
    }
    
    var body: some View {
        Button {
            playerVM.play(track: track)
        } label: {
            HStack(spacing: 12) {
                if let index = index {
                    Text("\(index)")
                        .font(.subheadline)
                        .foregroundColor(isPlaying ? .spotifyGreen : .gray)
                        .frame(width: 24)
                }
                
                AlbumArtView(imageName: track.albumArt, size: 48)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(track.title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(isPlaying ? .spotifyGreen : .white)
                        .lineLimit(1)
                    
                    Text(track.artist)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                
                Spacer()
                
                Button {
                    // More options
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack {
        PlaylistCard(playlist: MockData.playlists[0], size: 150)
        RecentPlaylistRow(playlist: MockData.playlists[0])
        TrackRow(track: MockData.tracks[0], index: 1)
    }
    .padding()
    .background(Color.spotifyBlack)
    .environmentObject(PlayerViewModel())
}
