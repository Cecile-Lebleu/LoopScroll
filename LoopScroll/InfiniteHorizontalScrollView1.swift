//
//  InfiniteHorizontalScrollView.swift
//  LoopScroll
//
//  Based on this: https://github.com/Dev1an/SwiftUI-InfiniteScroll/
//

import SwiftUI

struct InfiniteHorizontalScrollView1<Content: View>: UIViewRepresentable {
	private var content: Content
	
	init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}
	
	func makeUIView(context: Context) -> InfiniteScrollViewRenderer {
		let tiledContent = content
			.float(content, alignment: .leading)
			.float(content, alignment: .trailing)
		let contentController = UIHostingController(rootView: tiledContent)
		let hostedView = contentController.view!
		hostedView.frame.size.width = hostedView.intrinsicContentSize.width
		hostedView.frame.size.height = hostedView.intrinsicContentSize.height
		hostedView.frame.origin.x = 0
		
		let scrollview = InfiniteScrollViewRenderer()
		scrollview.addSubview(hostedView)
		scrollview.contentSize.height = hostedView.intrinsicContentSize.height
		scrollview.contentSize.width = hostedView.intrinsicContentSize.width * 2
		
		scrollview.contentOffset.x = 0
		
		return scrollview
	}
	
	func makeCoordinator() -> Coordinator {
		return Coordinator(
			hostingController: UIHostingController(rootView: self.content)
		)
	}
	
	func updateUIView(_ uiView: InfiniteScrollViewRenderer, context: Context) {
		context.coordinator.hostingController.rootView = self.content
	}
	
	class Coordinator: NSObject, UIScrollViewDelegate {
		var hostingController: UIHostingController<Content>
		
		init(hostingController: UIHostingController<Content>) {
			self.hostingController = hostingController
		}
	}
}

class InfiniteScrollViewRenderer: UIScrollView {
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let halfSize = contentSize.width / 2
		
		if contentOffset.x < 0 {
			contentOffset.x += halfSize
		} else if contentOffset.x > halfSize + 0 {
			contentOffset.x -= halfSize
		}
	}
}


#Preview {
    ContentView()
}
