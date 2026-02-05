//
//  SearchView.swift
//  my_ios_spotify
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var isSearching = false
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    if searchText.isEmpty {
                        browseSection
                    } else {
                        searchResultsSection
                    }
                }
                .padding(.bottom, 100)
            }
            .background(Color.spotifyBlack)
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "What do you want to listen to?")
        }
    }
    
    private var browseSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Browse all")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(MockData.searchCategories) { category in
                    CategoryCard(category: category)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var searchResultsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Top results")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            let filteredTracks = MockData.tracks.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.artist.localizedCaseInsensitiveContains(searchText)
            }
            
            if filteredTracks.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 48))
                        .foregroundColor(.gray)
                    
                    Text("No results found for \"\(searchText)\"")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("Check your spelling or try different keywords")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 60)
            } else {
                VStack(spacing: 8) {
                    ForEach(filteredTracks) { track in
                        TrackRow(track: track)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct CategoryCard: View {
    let category: SearchCategory
    
    var color: Color {
        switch category.color {
        case "pink": return .pink
        case "orange": return .orange
        case "red": return .red
        case "purple": return .purple
        case "blue": return .blue
        case "brown": return .brown
        case "gray": return .gray
        case "yellow": return .yellow
        case "green": return .green
        case "teal": return .teal
        case "indigo": return .indigo
        case "mint": return .mint
        default: return .gray
        }
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
            
            VStack(alignment: .leading) {
                Text(category.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(12)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: category.icon)
                        .font(.system(size: 40))
                        .foregroundColor(.white.opacity(0.5))
                        .rotationEffect(.degrees(25))
                        .offset(x: 10, y: 10)
                }
            }
        }
        .frame(height: 100)
        .clipped()
    }
}

#Preview {
    SearchView()
        .environmentObject(PlayerViewModel())
}
