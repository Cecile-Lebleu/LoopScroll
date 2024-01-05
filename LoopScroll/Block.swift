//
//  Block.swift
//  LoopScroll
//
//  Created by Cécile Lebleu on 5/1/24.
//

import SwiftUI

struct Block: View {
	@State private var active = false
	
	var body: some View {
		RoundedRectangle(cornerRadius: 15)
			.fill(active ? Color.yellow.gradient : Color.blue.gradient)
			.frame(width: 400, height: 150)
			.onTapGesture {
				active.toggle()
			}
	}
}

#Preview {
	Block()
}
