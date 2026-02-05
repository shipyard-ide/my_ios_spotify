//
//  PlaylistDetailView.swift
//  my_ios_spotify
//

import SwiftUI

struct PlaylistDetailView: View {
    let playlist: Playlist
    @EnvironmentObject var playerVM: PlayerViewModel
    @Environment(\.dismiss) var dismiss
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                headerSection
                
                actionBar
                
                trackList
            }
            .padding(.bottom, 100)
        }
        .background(
            LinearGradient(
                colors: [Color.gray.opacity(0.4), Color.spotifyBlack, Color.spotifyBlack],
                startPoint: .top,
                endPoint: .center
            )
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // More options
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            AlbumArtView(imageName: playlist.coverImage, size: 220, cornerRadius: 4)
                .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
            
            VStack(spacing: 8) {
                Text(playlist.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text(playlist.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                HStack(spacing: 4) {
                    Image(systemName: "music.note.list")
                        .font(.caption2)
                    Text("Spotify")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("• \(playlist.tracks.count) songs")
                        .font(.caption)
                }
                .foregroundColor(.gray)
            }
            .padding(.horizontal)
        }
        .padding(.top, 20)
    }
    
    private var actionBar: some View {
        HStack(spacing: 20) {
            HStack(spacing: 16) {
                Button {
                    // Like playlist
                } label: {
                    Image(systemName: "heart")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                }
                
                Button {
                    // Download
                } label: {
                    Image(systemName: "arrow.down.circle")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                }
                
                Button {
                    // More
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                Button {
                    playerVM.toggleShuffle()
                    if !playerVM.shuffleEnabled {
                        playerVM.toggleShuffle()
                    }
                    playerVM.play(playlist: playlist)
                } label: {
                    Image(systemName: "shuffle")
                        .font(.system(size: 24))
                        .foregroundColor(.spotifyGreen)
                }
                
                Button {
                    playerVM.play(playlist: playlist)
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.spotifyGreen)
                            .frame(width: 56, height: 56)
                        
                        Image(systemName: "play.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 16)
    }
    
    private var trackList: some View {
        VStack(spacing: 0) {
            ForEach(Array(playlist.tracks.enumerated()), id: \.element.id) { index, track in
                TrackRow(track: track, index: index + 1)
                    .padding(.vertical, 8)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    NavigationStack {
        PlaylistDetailView(playlist: MockData.playlists[0])
            .environmentObject(PlayerViewModel())
    }
}
