//
//  LeaderBoardView.swift
//  Bullseye
//
//  Created by Vitalii Mudryk on 09/02/2024.
//

import SwiftUI

struct LeaderBoardView: View {
  @Binding var leaderboardIsShowing: Bool
  @Binding var game: Game
  
  var body: some View {
    ZStack {
      Color("BackgroundColor").ignoresSafeArea()
      VStack(spacing: 10) {
        HeaderView(leaderboardIsShowing: $leaderboardIsShowing)
        LabelView()
        ScrollView {
          VStack(spacing: 10) {
            ForEach(game.leaderboardEntries.indices, id: \.self) { index in
              let  leaderboardEntries = game.leaderboardEntries[index]
              RowView(index: index + 1, score: leaderboardEntries.score, date: leaderboardEntries.date)
            }
          }
        }
      }
    }
  }
}

struct HeaderView: View {
  @Environment(\.verticalSizeClass) var verticalSizeClass
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  @Binding var leaderboardIsShowing: Bool
  
  var body: some View {
    ZStack {
      HStack {
        BigBoldText(text: "Leaderboard")
        if verticalSizeClass == .regular && horizontalSizeClass == .compact {
          Spacer()
        }
      }
      HStack {
        Spacer()
        Button(action: {
          leaderboardIsShowing = false
        }, label: {
          RoundedImageViewsFilled(systemName: "xmark")
        })
      }
    }
    .padding([.horizontal, .top])
  }
}

struct LabelView: View {
  var body: some View {
    HStack {
      Spacer()
        .frame(width: Constants.General.roundedViewLength)
      Spacer()
      LabelText(text: "Score")
        .frame(width: Constants.LeaderBoard.scoreColumnWidth)
      Spacer()
      LabelText(text: "Date")
        .frame(width: Constants.LeaderBoard.dateColoumnWidth)
    }
    .padding(.horizontal)
    .frame(maxWidth: Constants.LeaderBoard.maxRowWidth)
  }
}

struct RowView: View {
  let index: Int
  let score: Int
  let date: Date
  
  var body: some View {
    HStack {
      RoundedTextView(text: String(index))
      Spacer()
      ScoreText(score: score)
      Spacer()
        .frame(width: Constants.LeaderBoard.scoreColumnWidth)
      DateText(date: date)
        .frame(width: Constants.LeaderBoard.dateColoumnWidth)
    }
    .background(
      RoundedRectangle(cornerRadius: .infinity)
        .strokeBorder(Color("LeaderboardRowColor"), lineWidth: Constants.General.strokeWidth)
    )
    .padding(.horizontal)
    .frame(maxWidth: Constants.LeaderBoard.maxRowWidth)
  }
}

struct LeaderBoardView_Preview: PreviewProvider {
  static private var leaderboardIsShowing  = Binding.constant(false)
  static private var game  = Binding.constant(Game(loadTestData: true))

  static var previews: some View {
    LeaderBoardView(leaderboardIsShowing: leaderboardIsShowing, game: game)
      .previewInterfaceOrientation(.landscapeRight)
    LeaderBoardView(leaderboardIsShowing: leaderboardIsShowing, game: game)
      .preferredColorScheme(.dark)
  }
}
