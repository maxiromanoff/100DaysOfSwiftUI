//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Maxiromanoff on 28/10/2022.
//

import SwiftUI

//struct CapsuleText: View {
//    var content: String
//    var body: some View {
//        Text(content)
//            .font(.largeTitle)
//            .padding()
//            .background(.blue)
//            .clipShape(Capsule())
//    }
//}

//struct Watermark: ViewModifier {
//    var text: String
//
//    func body(content: Content) -> some View {
//        ZStack(alignment: .bottomTrailing) {
//            content
//            Text(text)
//                .font(.caption)
//                .foregroundColor(.white)
//                .padding(5)
//                .background(.black)
//        }
//    }
//}
//
//extension View {
//    func watermarked(with text: String) -> some View {
//        modifier(Watermark(text:text))
//    }
//}

struct ProminientTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func promTitle() -> some View {
        modifier(ProminientTitle())
    }
}

struct ContentView: View {
    var body: some View {
//        VStack(spacing: 10){
//            CapsuleText(content: "first")
//                .foregroundColor(.black)
//            CapsuleText(content: "second")
//                .foregroundColor(.red)
//        }
        
//        Color.blue
//            .frame(width: 300, height: 300)
//            .watermarked(with: "Hacking with Swift")
        
        VStack {
            Text("Prominient Title")
                .promTitle()
            Spacer()
        }
        .frame(minWidth: 200, minHeight: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
