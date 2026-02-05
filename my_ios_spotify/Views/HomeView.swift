//
//  HomeView.swift
//  my_ios_spotify
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var playerVM: PlayerViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    greetingHeader
                    
                    recentlyPlayedGrid
                    
                    playlistSection(title: "Made For You", playlists: Array(MockData.playlists.prefix(4)))
                    
                    artistSection
                    
                    playlistSection(title: "Popular Playlists", playlists: Array(MockData.playlists.suffix(4)))
                }
                .padding(.bottom, 100)
            }
            .background(
                LinearGradient(
                    colors: [Color.spotifyDarkGray, Color.spotifyBlack],
                    startPoint: .top,
                    endPoint: .center
                )
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        Button {
                            // Notifications
                        } label: {
                            Image(systemName: "bell")
                                .foregroundColor(.white)
                        }
                        
                        Button {
                            // History
                        } label: {
                            Image(systemName: "clock.arrow.circlepath")
                                .foregroundColor(.white)
                        }
                        
                        Button {
                            // Settings
                        } label: {
                            Image(systemName: "gearshape")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
    
    private var greetingHeader: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(greeting)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
    
    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default: return "Good evening"
        }
    }
    
    private var recentlyPlayedGrid: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(MockData.recentlyPlayed) { playlist in
                RecentPlaylistRow(playlist: playlist)
            }
        }
        .padding(.horizontal)
    }
    
    private func playlistSection(title: String, playlists: [Playlist]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(playlists) { playlist in
                        NavigationLink {
                            PlaylistDetailView(playlist: playlist)
                        } label: {
                            PlaylistCard(playlist: playlist, size: 150)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var artistSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Top Artists")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(MockData.artists) { artist in
                        ArtistCard(artist: artist)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ArtistCard: View {
    let artist: Artist
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 150, height: 150)
                
                Image(systemName: "person.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.gray)
            }
            
            Text(artist.name)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .lineLimit(1)
            
            Text("Artist")
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .frame(width: 150)
    }
}

#Preview {
    HomeView()
        .environmentObject(PlayerViewModel())
}
