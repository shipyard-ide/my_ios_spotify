//
//  LibraryView.swift
//  my_ios_spotify
//

import SwiftUI

struct LibraryView: View {
    @State private var selectedFilter: LibraryFilter = .all
    @State private var viewMode: ViewMode = .list
    
    enum LibraryFilter: String, CaseIterable {
        case all = "All"
        case playlists = "Playlists"
        case artists = "Artists"
        case albums = "Albums"
    }
    
    enum ViewMode {
        case list, grid
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                filterBar
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        sortBar
                        
                        switch selectedFilter {
                        case .all, .playlists:
                            playlistsSection
                        case .artists:
                            artistsSection
                        case .albums:
                            albumsSection
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
            .background(Color.spotifyBlack)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 12) {
                        ProfileAvatar()
                        
                        Text("Your Library")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        Button {
                            // Search in library
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                        }
                        
                        Button {
                            // Add
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
    
    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(LibraryFilter.allCases, id: \.self) { filter in
                    FilterChip(
                        title: filter.rawValue,
                        isSelected: selectedFilter == filter
                    ) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedFilter = filter
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
    }
    
    private var sortBar: some View {
        HStack {
            Button {
                withAnimation {
                    viewMode = viewMode == .list ? .grid : .list
                }
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "arrow.up.arrow.down")
                    Text("Recents")
                }
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    viewMode = viewMode == .list ? .grid : .list
                }
            } label: {
                Image(systemName: viewMode == .list ? "square.grid.2x2" : "list.bullet")
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal)
    }
    
    private var playlistsSection: some View {
        VStack(spacing: 12) {
            createPlaylistRow
            likedSongsRow
            
            ForEach(MockData.playlists) { playlist in
                NavigationLink {
                    PlaylistDetailView(playlist: playlist)
                } label: {
                    LibraryPlaylistRow(playlist: playlist)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal)
    }
    
    private var createPlaylistRow: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.spotifyDarkGray)
                    .frame(width: 64, height: 64)
                
                Image(systemName: "plus")
                    .font(.system(size: 24))
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Create playlist")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
    }
    
    private var likedSongsRow: some View {
        HStack(spacing: 12) {
            ZStack {
                LinearGradient(
                    colors: [.purple, .blue],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(width: 64, height: 64)
                .cornerRadius(4)
                
                Image(systemName: "heart.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Liked Songs")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                
                HStack(spacing: 4) {
                    Image(systemName: "pin.fill")
                        .font(.caption2)
                        .foregroundColor(.spotifyGreen)
                    
                    Text("Playlist • \(MockData.tracks.count) songs")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
        }
    }
    
    private var artistsSection: some View {
        VStack(spacing: 12) {
            ForEach(MockData.artists) { artist in
                LibraryArtistRow(artist: artist)
            }
        }
        .padding(.horizontal)
    }
    
    private var albumsSection: some View {
        VStack(spacing: 12) {
            ForEach(MockData.playlists.prefix(4)) { playlist in
                LibraryAlbumRow(playlist: playlist)
            }
        }
        .padding(.horizontal)
    }
}

struct ProfileAvatar: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.spotifyDarkGray)
                .frame(width: 32, height: 32)
            
            Text("Z")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .black : .white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.spotifyGreen : Color.spotifyDarkGray)
                .cornerRadius(20)
        }
    }
}

struct LibraryPlaylistRow: View {
    let playlist: Playlist
    
    var body: some View {
        HStack(spacing: 12) {
            AlbumArtView(imageName: playlist.coverImage, size: 64, cornerRadius: 4)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(playlist.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text("Playlist • \(playlist.tracks.count) songs")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}

struct LibraryArtistRow: View {
    let artist: Artist
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.spotifyDarkGray)
                    .frame(width: 64, height: 64)
                
                Image(systemName: "person.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(artist.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                
                Text("Artist")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}

struct LibraryAlbumRow: View {
    let playlist: Playlist
    
    var body: some View {
        HStack(spacing: 12) {
            AlbumArtView(imageName: playlist.coverImage, size: 64, cornerRadius: 4)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(playlist.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text("Album • Various Artists")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}

#Preview {
    LibraryView()
        .environmentObject(PlayerViewModel())
}
