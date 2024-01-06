//
//  Block.swift
//  LoopScroll
//
//  Created by Cécile Lebleu on 5/1/24.
//

import SwiftUI

struct Block: View {
	@Binding var item: Item
	
	var body: some View {
		RoundedRectangle(cornerRadius: 15)
			.fill(item.active ? Color.yellow.gradient : Color.blue.gradient)
			.frame(width: 400, height: 150)
			.onTapGesture {
				item.active.toggle()
			}
	}
}

#Preview {
	Block(item: .constant(Item()))
}
