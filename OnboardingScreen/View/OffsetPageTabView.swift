//
//  OffsetPageTabView.swift
//  OnboardingScreen
//
//  Created by Sree Sai Raghava Dandu on 06/08/21.
//

import SwiftUI

// Custom view that will return offset for paging control
struct OffsetPageTabView<Content: View>: UIViewRepresentable {
    var content: Content
      @Binding var offset: CGFloat
    
    func makeCoordinator() -> Coordinator {
        return OffsetPageTabView.Coordinator(parent: self)
    }
    
    init(offset: Binding<CGFloat>,@ViewBuilder content: @escaping ()->Content) {
        self.content = content()
        self._offset = offset
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollview = UIScrollView()
        // Extracting SwiftUI View and embedding into UIKit
        let hostview = UIHostingController(rootView: content)
        hostview.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostview.view.topAnchor.constraint(equalTo: scrollview.topAnchor),
            hostview.view.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            hostview.view.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
            hostview.view.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
            
            // Don't declare height constraint if using vertical pagin
            hostview.view.heightAnchor.constraint(equalTo: scrollview.heightAnchor)
        ]
        // Enabling Paging
        scrollview.isPagingEnabled = true
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        // Setting Delegate
        scrollview.delegate = context.coordinator
        scrollview.addSubview(hostview.view)
        scrollview.addConstraints(constraints)
        return scrollview
    }
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // Update only when offset changed manually
        // Check the current nad scrollView offsets..
        let currentOffset = uiView.contentOffset.x
        if currentOffset != offset{
            uiView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        }
    }
    //Pager Offset
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: OffsetPageTabView
        init(parent: OffsetPageTabView) {
            self.parent = parent
        }
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.x
            parent.offset = offset
        }
    }
}

struct OffsetPageTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
