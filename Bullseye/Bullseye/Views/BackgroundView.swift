//
//  BackgroundView.swift
//  Bullseye
//
//  Created by Vitalii Mudryk on 19/01/2024.
//

import SwiftUI

struct BackgroundView: View {
  @Binding var game: Game
  @State private var leaderboardIsShowing = false
  
  var body: some View {
    VStack {
      TopView(game: $game)
      Spacer()
      BottomView(game: $game)
    }
    .padding()
    .background(
      RingsView()
    )
  }
}

struct TopView: View {
  @Binding var game: Game
  @State private var leaderboardIsShowing = false
  
  var body: some View {
    HStack {
      Button(action: { game.restart() }, label: {
        RoundedImageViewsStroked(systemName: "arrow.counterclockwise")
      })
      Spacer()
      Button(action: { leaderboardIsShowing = true }, label: {
        RoundedImageViewsFilled(systemName: "list.dash")
      })
      .sheet(isPresented: $leaderboardIsShowing, content: {
        LeaderBoardView(leaderboardIsShowing: $leaderboardIsShowing, game: $game)
      })
    }
  }
}

struct NumberView: View{
  var title: String
  var text: String
  
  var body: some View {
    VStack(spacing: 5){
      LabelText(text: title)
      RoundRectTextView(text: text)
    }
  }
}

struct BottomView: View {
  @Binding var game: Game
  
  var body: some View {
    HStack {
      NumberView(title: "Score", text: String(game.score))
      Spacer()
      NumberView(title: "Round", text: String(game.round))
    }
  }
}

struct RingsView: View {
  @Environment(\.colorScheme) var colorScheme
  var body: some View {
    ZStack {
      Color("BackgroundColor")
        .ignoresSafeArea()
      ForEach(1..<6) { ring in
        let  size = CGFloat(ring * 100)
        let opacity = colorScheme == ColorScheme.dark ? 0.1 : 0.3
        Circle()
          .stroke(lineWidth: 20)
          .fill(
            RadialGradient(
              gradient: Gradient(colors: [Color("RingsColor").opacity(opacity * 0.8), Color("RingsColor").opacity(0)]),
              center: .center,
              startRadius: 100,
              endRadius: 300)
          )
          .frame(width: size, height: size)
      }
    }
  }
}

#Preview {
  BackgroundView(game: .constant(Game()))
}
