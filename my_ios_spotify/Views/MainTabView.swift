//
//  MainTabView.swift
//  my_ios_spotify
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var playerVM = PlayerViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        Text("Home")
                    }
                    .tag(0)
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .tag(1)
                
                LibraryView()
                    .tabItem {
                        Image(systemName: selectedTab == 2 ? "books.vertical.fill" : "books.vertical")
                        Text("Your Library")
                    }
                    .tag(2)
            }
            .tint(.white)
            
            VStack(spacing: 0) {
                Spacer()
                
                MiniPlayerView()
                    .padding(.bottom, 49)
            }
        }
        .environmentObject(playerVM)
        .preferredColorScheme(.dark)
        .fullScreenCover(isPresented: $playerVM.showNowPlaying) {
            NowPlayingView()
                .environmentObject(playerVM)
        }
        .onAppear {
            configureTabBarAppearance()
        }
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.spotifyBlack.opacity(0.95))
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    MainTabView()
}
