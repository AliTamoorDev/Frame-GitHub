//
//  AddRowButton.swift
//  Frame
//
//  Created by Ali Tamoor on 28/10/2023.
//

import SwiftUI

// MARK: - Add Row

struct AddRowButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Add Row")
                .fontWeight(.semibold)
                .font(.title3)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0))) // Dark Blue
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
        .padding([.leading, .trailing, .bottom ,.top], 16)
        .padding(.trailing, 20)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4) // Increased opacity for a subtle shadow effect
    }
}

//#Preview {
//    AddRowButton()
//}
