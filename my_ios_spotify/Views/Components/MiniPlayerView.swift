//
//  MiniPlayerView.swift
//  my_ios_spotify
//

import SwiftUI

struct MiniPlayerView: View {
    @EnvironmentObject var playerVM: PlayerViewModel
    
    var body: some View {
        if let track = playerVM.currentTrack {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color.spotifyGreen)
                        .frame(width: geometry.size.width * playerVM.progress)
                }
                .frame(height: 2)
                
                HStack(spacing: 12) {
                    AlbumArtView(imageName: track.albumArt, size: 48)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(track.title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .lineLimit(1)
                        
                        Text(track.artist)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Button {
                            // Device/speaker selection
                        } label: {
                            Image(systemName: "hifispeaker.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.gray)
                        }
                        
                        Button {
                            playerVM.togglePlayPause()
                        } label: {
                            Image(systemName: playerVM.isPlaying ? "pause.fill" : "play.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
            }
            .background(Color.spotifyDarkGray)
            .onTapGesture {
                playerVM.showNowPlaying = true
            }
        }
    }
}

struct AlbumArtView: View {
    let imageName: String
    let size: CGFloat
    var cornerRadius: CGFloat = 4
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(
                    LinearGradient(
                        colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            Image(systemName: "music.note")
                .font(.system(size: size * 0.4))
                .foregroundColor(.gray)
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    MiniPlayerView()
        .environmentObject(PlayerViewModel())
        .background(Color.spotifyBlack)
}
