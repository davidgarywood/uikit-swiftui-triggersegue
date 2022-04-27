//
//  HostedViewController.swift
//  StoryboardSwiftUISegue
//
//  Created by dave on 27/04/22.
//

import UIKit
import SwiftUI

class SwiftUIViewBridge {
    weak var parentViewController: HostedViewController?
    
    func buttonPressed() {
        self.parentViewController?.performSegue()
    }
}

struct SwiftUIView: View {
    
    var bridge: SwiftUIViewBridge
    
    var body: some View {
        VStack {
            Button {
                self.bridge.buttonPressed()
            } label: {
                Text("Perform Segue")
            }
        }
    }
}

class HostedViewController: UIHostingController<SwiftUIView> {
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        let bridge = SwiftUIViewBridge()
        super.init(coder: aDecoder, rootView: SwiftUIView(bridge: bridge))
        bridge.parentViewController = self
    }
    
    func performSegue() {
        self.performSegue(withIdentifier: "presentModal", sender: self)
    }
}
