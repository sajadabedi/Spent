//
//  ContentView.swift
//  Spent
//
//  Created by Sajad Abedi on 08.09.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24){
                        Text("Overview")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                .background(Color.background)
                .toolbar {
                    // MARK: Notification Icon
                    ToolbarItem {
                        Image(systemName: "bell.badge")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.icon, .primary)
                    }
                }
            }
            .navigationViewStyle(.stack)
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
