////
////  CommentCellStyles.swift
////  Hermes
////
////  Created by Cory Ginsberg on 3/10/24.
////
//
// import SwiftUI
//
// private enum Constants {
//  static let indentAmount: CGFloat = 12.0
// }
//
// private struct CommentIndentViewModifier: ViewModifier {
//  @Binding var indent: Int
//
//  private let colors: [Color] = [
//    .red,
//    .orange,
//    .yellow,
//    .green,
//    .cyan,
//    .blue,
//    .purple,
//  ]
//
//  func body(content: Content) -> some View {
//    // Here we want to have no padding for the top-level comment, but then we need to compensate for that by
//    // subtracting the indent amount from each subsequent indent level.
//    let indentLeadingEdge =
//      indent > 0
//        ? (CGFloat(integerLiteral: indent) * Constants.indentAmount) - Constants.indentAmount : 0.0
//
//    HStack {
//      if indent > 0 {
//        colors[(indent - 1) % colors.count]
//          .frame(width: 1.5)
//          .clipShape(
//            RoundedRectangle(
//              cornerRadius: 24
//            )
//          )
//          .padding(.trailing, 3.0)
//          .padding(.bottom, 8.0)
//          .padding(.top, 2.0)
//      }
//      content.padding(.top, 4.0)
//    }.padding(.leading, indentLeadingEdge)
//  }
// }
//
//// MARK: - View extension to add indent support
//
// extension VStack {
//  /// Adds a colored bar to the side of each comment (after the top-level one) to show how far down the thread the
//  /// comment is.
//  ///
//  /// - Parameter indent: How far indented the comment is. Should correspond to how deep the comment is in the thread.
//  func indent(_ indent: Binding<Int>) -> some View {
//    modifier(CommentIndentViewModifier(indent: indent))
//  }
// }
