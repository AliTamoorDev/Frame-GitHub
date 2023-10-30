//
//  ContentView.swift
//  DrawingEX
//
//  Created by Johnny Mascali on 10/6/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{}
                .navigationTitle("Scan OCR")
                .navigationBarItems(trailing:
                                        Button(action: {}, label: {Image })
                )
        }
    }
}

#Preview {
    ContentView()
}
