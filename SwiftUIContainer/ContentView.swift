//
//  ContentView.swift
//  SwiftUIContainer
//
//  Created by Marcus Wu on 2024/6/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MyCustomContainer {
            Section("1...12") {
                ForEach(1...12, id: \.self) {
                    Text("\($0)")
                        .rejected(isRejected: $0 % 3 == 0)
                }
            }
            
            Section("13...16") {
                ForEach(13...16, id: \.self) {
                    Text("\($0)")
                }
            }
            .rejected(isRejected: true)
            
            Section("17...30") {
                ForEach(17...30, id: \.self) {
                    Text("\($0)")
                        .rejected(isRejected: $0 % 4 == 0)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct MyCustomContainer<Content: View>: View {
    
    @ViewBuilder var content: Content
    
    var body: some View {
        HStack {
            ForEach(sectionOf: content) { section in
                VStack {
                    if !section.header.isEmpty {
                        section.header
                            .background(
                                Color.blue
                            )
                    }

                    MyCustomSectionContainer {
                        section.content
                    }
                }
            }
        }
    }
    
}

struct MyCustomSectionContainer<Content: View>: View {
    
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack {
            Group(subviewsOf: content) { subviews in
                ForEach(subviewOf: subviews) { subview in
                    let values = subview.containerValues
                    subview
                        .font(.system(size: subviews.count > 10 ? 10 : 20))
                        .foregroundColor(values.isRejected ? .red : .black)
                }
            }
        }
    }
    
}

extension ContainerValues {
    @Entry var isRejected = true
}

extension View {
    func rejected(isRejected: Bool) -> some View {
        containerValue(\.isRejected, isRejected)
    }
}
