//
//  ContentView.swift
//  LoopScroll
//
//  Created by Cécile Lebleu on 5/1/24.
//

import SwiftUI

struct ContentView: View {
	@State private var items: [Item] = [Item.init()]

	var body: some View {
		VStack {
			VStack(alignment: .leading) {
				Text("This scrollview has one item inside.")
				Text("Initial state: blue")
				Text("Toggled state: yellow")
			}
			
			InfiniteHorizontalScrollView2(
				width: 400,
				items: items
			) { item in
				HStack(spacing: 0) {
					Block(item: $items[0])
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
