//
//  NowPlayingView.swift
//  my_ios_spotify
//

import SwiftUI

struct NowPlayingView: View {
    @EnvironmentObject var playerVM: PlayerViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.gray.opacity(0.4), Color.spotifyBlack],
                startPoint: .top,
                endPoint: .center
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                headerView
                
                Spacer()
                
                albumArtSection
                
                trackInfoSection
                
                progressSection
                
                controlsSection
                
                bottomControls
                
                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }
    
    private var headerView: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.down")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            VStack(spacing: 2) {
                Text("PLAYING FROM PLAYLIST")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                Text("Today's Top Hits")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Button {
                // More options
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .padding(.top, 8)
    }
    
    private var albumArtSection: some View {
        AlbumArtView(
            imageName: playerVM.currentTrack?.albumArt ?? "",
            size: UIScreen.main.bounds.width - 80,
            cornerRadius: 8
        )
        .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
    }
    
    private var trackInfoSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(playerVM.currentTrack?.title ?? "Unknown")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(playerVM.currentTrack?.artist ?? "Unknown Artist")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button {
                // Like track
            } label: {
                Image(systemName: "heart")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
        }
    }
    
    private var progressSection: some View {
        VStack(spacing: 8) {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 4)
                    
                    Capsule()
                        .fill(Color.white)
                        .frame(width: geometry.size.width * playerVM.progress, height: 4)
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let progress = max(0, min(1, value.location.x / geometry.size.width))
                            playerVM.seek(to: progress)
                        }
                )
            }
            .frame(height: 4)
            
            HStack {
                Text(formatTime(playerVM.currentTime))
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text(playerVM.currentTrack?.durationString ?? "--:--")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var controlsSection: some View {
        HStack(spacing: 32) {
            Button {
                playerVM.toggleShuffle()
            } label: {
                Image(systemName: "shuffle")
                    .font(.system(size: 20))
                    .foregroundColor(playerVM.shuffleEnabled ? .spotifyGreen : .white)
            }
            
            Button {
                playerVM.skipBackward()
            } label: {
                Image(systemName: "backward.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
            }
            
            Button {
                playerVM.togglePlayPause()
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 64, height: 64)
                    
                    Image(systemName: playerVM.isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.black)
                }
            }
            
            Button {
                playerVM.skipForward()
            } label: {
                Image(systemName: "forward.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
            }
            
            Button {
                playerVM.cycleRepeatMode()
            } label: {
                Image(systemName: playerVM.repeatMode.icon)
                    .font(.system(size: 20))
                    .foregroundColor(playerVM.repeatMode.isActive ? .spotifyGreen : .white)
            }
        }
    }
    
    private var bottomControls: some View {
        HStack {
            Button {
                // Device picker
            } label: {
                Image(systemName: "hifispeaker.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button {
                // Share
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button {
                // Queue
            } label: {
                Image(systemName: "list.bullet")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 40)
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

#Preview {
    NowPlayingView()
        .environmentObject({
            let vm = PlayerViewModel()
            vm.play(track: MockData.tracks[0])
            return vm
        }())
}
