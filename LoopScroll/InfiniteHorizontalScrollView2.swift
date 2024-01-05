//
//  InfiniteHorizontalScrollView2.swift
//  LoopScroll
//
//  Based on this tutorial: https://www.youtube.com/watch?v=lyuo59840qs
//

import SwiftUI

struct Item: Identifiable {
	var id: UUID = .init()
}

struct InfiniteHorizontalScrollView2<Content: View, Item: RandomAccessCollection>: View where Item.Element: Identifiable {
	var width: CGFloat
	var items: Item
	var repeatingCount = 1
	@ViewBuilder var content: (Item.Element) -> Content
	
	var body: some View {
		ScrollView(.horizontal) {
			LazyHStack(spacing: 0) {
				ForEach(items) { item in
					content(item)
				}
				
				ForEach(0..<repeatingCount, id: \.self) { index in
					let item = Array(items)[index % items.count]
					content(item)
				}
			}
			.background {
				ScrollViewHelper(
					width: width,
					itemsCount: items.count
				)
			}
		}
	}
}

struct ScrollViewHelper: UIViewRepresentable {
	var width: CGFloat
	var itemsCount: Int
	
	func makeCoordinator() -> Coordinator {
		return Coordinator(
			width: width,
			itemsCount: itemsCount
		)
	}
	
	func makeUIView(context: Context) -> some UIView {
		return .init()
	}
	
	func updateUIView(_ uiView: UIViewType, context: Context) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
			if let scrollView = uiView.superview?.superview?.superview as? UIScrollView, !context.coordinator.isAdded {
				scrollView.delegate = context.coordinator
				context.coordinator.isAdded = true
			}
		}
	}
	
	class Coordinator: NSObject, UIScrollViewDelegate {
		var width: CGFloat
		var itemsCount: Int
		
		init(
			width: CGFloat,
			itemsCount: Int
		) {
			self.width = width
			self.itemsCount = itemsCount
		}
		
		var isAdded: Bool = false
		
		func scrollViewDidScroll(_ scrollView: UIScrollView) {
			let minX = scrollView.contentOffset.x
			let mainContentSize = CGFloat(itemsCount) * width
			
			if minX > mainContentSize {
				scrollView.contentOffset.x -= mainContentSize
			}
			
			if minX < 0 {
				scrollView.contentOffset.x += mainContentSize
			}
		}
	}
}

#Preview {
	ContentView()
}
