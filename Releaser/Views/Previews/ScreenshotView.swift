//
//  ScreenshotView.swift
//  Changelogger
//
//  Created by Jordi Bruin on 11/10/2024.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct ScreenshotView: View {
    
    let release: Release
    let app: Application
    
    @State var showAll = false
    
    var body: some View {
        VStack {
            screenshotView
                .onDrag {
                    if let image = renderAsImage(),
                       let imageData = image.tiffRepresentation,
                       let pngData = NSBitmapImageRep(data: imageData)?.representation(using: .png, properties: [:]) {
                        let provider = NSItemProvider(item: pngData as NSSecureCoding, typeIdentifier: UTType.png.identifier)
                        return provider
                    }
                    return NSItemProvider()
                }
            
            backgroundOptions
        }
        .onAppear {
            updateImage()
        }
        .onChange(of: release) { oldValue, newValue in
            updateImage()
        }
    }
    
    @State var selectedBackground: ScreenshotBackground  = .blue
    
    var backgroundOptions: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(ScreenshotBackground.allCases) { background in
                    Button {
                        selectedBackground = background
                    } label: {
                        ZStack {
                            if let image = background.image {
                                image
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                            } else {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .foregroundStyle(
                                        LinearGradient(colors: [
                                            background.color,
                                            background.color.opacity(0.9)
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                            }
                        }
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .padding(4)
                                .foregroundStyle(Color.black.opacity(0.15))
                                .opacity(selectedBackground == background ? 1 : 0)
                        })
                        .frame(width: 60, height: 60)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
    }
    
    var screenshotView: some View {
        ZStack {
            screenshotBackground
            screenshotText
                .padding(.horizontal, 40)
                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 0)
            
            VStack(alignment: .trailing) {
                Spacer()
                HStack {
                    Spacer()
                    Text("Made with Changelogger")
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
            .padding(8)
        }
        .frame(width: 500, height: 500)
    }
    
    var resultScreenshot: some View {
        ZStack {
            screenshotBackground
            screenshotText
                .padding(.horizontal, 40)
                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 0)
        }
        .frame(width: 1000, height: 1000)
    }
    
    @ViewBuilder
    var screenshotBackground: some View {
        if let image = selectedBackground.image {
            image
                .resizable()
        } else {
            selectedBackground.gradient
        }
    }
    
    var screenshotText: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(app.name) \(release.versionNumber)")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                if let imageUrl = app.imageUrl, let savedImage = NSImage(contentsOf: imageUrl) {
                    Image(nsImage: savedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                }
            }
            
            Text(release.normalText)
                .shadow(color: .clear, radius: 40, x: 0, y: 0)
        }
        .padding(24)
        .background(
            Color(.controlBackgroundColor)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
    @State var draggableImage: NSImage = NSImage()
    @Environment(\.displayScale) private var scale
    
    // Function to render the screenshot view as an image
    func renderAsImage() -> NSImage? {

        let renderer = ImageRenderer(content: screenshotView)
        renderer.scale = 4.0
        
        if let nsImage = renderer.nsImage {
            // use the rendered image somehow
            return nsImage
        } else {
            return NSImage()
        }
        //
        //        let controller = NSHostingController(rootView: screenshotView.frame(width: 400, height: 400))
        //
        //        guard let bitmapRep = controller.view.bitmapImageRepForCachingDisplay(in: controller.view.bounds) else {
        //            return nil
        //        }
        //
        //        controller.view.cacheDisplay(in: controller.view.bounds, to: bitmapRep)
        //
        //        let image = NSImage(size: controller.view.bounds.size)
        //        image.addRepresentation(bitmapRep)
        //        return image
    }
    
    func updateImage() {
        
        let renderer = ImageRenderer(content: screenshotView.frame(width: 400, height: 400))
        
        if let nsImage = renderer.nsImage {
            // use the rendered image somehow
            draggableImage = nsImage
        }
        
        //        let controller = NSHostingController(rootView: screenshotView.frame(width: 400, height: 400))
        //
        //        guard let bitmapRep = controller.view.bitmapImageRepForCachingDisplay(in: controller.view.bounds) else {
        //            return
        //        }
        //
        //        controller.view.cacheDisplay(in: controller.view.bounds, to: bitmapRep)
        //
        //        let image = NSImage(size: controller.view.bounds.size)
        //        image.addRepresentation(bitmapRep)
        //        self.draggableImage = image
    }
}

#Preview(
    body: {
        ScreenshotView(
            release: Release(
                id: UUID(),
                versionNumber: "10.0",
                features: [
                    Feature(
                        id: UUID(),
                        title: "Added support for Ollamadfsd dsfsd fdsfdsfsdfdsfd ",
                        tag: .new,
                        pro: true
                    ),
                    Feature(
                        id: UUID(),
                        title: "Added support for Ollamadfsd dsfsd fdsfdsfsdfdsfd ",
                        tag: .new,
                        pro: true
                    ),
                    Feature(
                        id: UUID(),
                        title: "Added support for Ollamadfsd dsfsd fdsfdsfsdfdsfd ",
                        tag: .new,
                        pro: true
                    ),
                    Feature(
                        id: UUID(),
                        title: "Added support for Ollamadfsd dsfsd fdsfdsfsdfdsfd ",
                        tag: .new,
                        pro: true
                    ),
                    Feature(
                        id: UUID(),
                        title: "Added support for Ollamadfsd dsfsd fdsfdsfsdfdsfd ",
                        tag: .new,
                        pro: true
                    ),
                    Feature(
                        id: UUID(),
                        title: "Added support for Ollamadfsd dsfsd fdsfdsfsdfdsfd ",
                        tag: .new,
                        pro: true
                    ),
                    Feature(
                        id: UUID(),
                        title: "Added support for Ollamadfsd dsfsd fdsfdsfsdfdsfd ",
                        tag: .new,
                        pro: true
                    ),
                    
                    Feature(
                        id: UUID(),
                        title: "Added support for Groq",
                        tag: .new,
                        pro: false
                    ),
                ],
                date: Date()
            ),
            app: Application(
                name: "test",
                releases: [],
                id: UUID(),
                imageUrl: Bundle.main.url(
                    forResource: "mw",
                    withExtension: "png"
                )!
            )
        )
        .frame(width: 600, height: 600)
    })

