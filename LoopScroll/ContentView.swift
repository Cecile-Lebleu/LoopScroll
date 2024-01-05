//
//  ContentView.swift
//  LoopScroll
//
//  Created by Cécile Lebleu on 5/1/24.
//

import SwiftUI

struct ContentView: View {
	// For InfiniteHorizontalScrollView2
	@State private var items: [Item] = [Item.init()]

	var body: some View {
		VStack {
			Text("Infinite Horizontal ScrollView 1")
			InfiniteHorizontalScrollView1 {
				HStack(spacing: 0) {
					Block()
					Block()
				}
			}
			
			Spacer()
			
			VStack(alignment: .leading) {
				Text("This scrollview has one item inside.")
				Text("Initial state: blue")
				Text("Toggled state: yellow")
			}
			
			InfiniteHorizontalScrollView2(
				width: 400,
				items: items
			) { _ in
				HStack(spacing: 0) {
					Block()
				}
			}
			.frame(height: 170)
			
			Spacer()
		}
		.padding()
	}
}

#Preview {
	ContentView()
}
