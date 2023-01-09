//
//  MapAnnotationView.swift
//  Recepti
//
//  Created by Digital Atrium on 15.11.22..
//

import SwiftUI

struct MapAnnotationView: View {
    
    // MARK: - PROPERTIES
    
    var location: RestorauntLocation
    @State private var animation: Double = 0.0
    
    // MARK: - BODY
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .fill(Color.accentColor)
                .frame(width: 54, height: 54, alignment: .center)
            
            Circle()
                .stroke(Color.accentColor, lineWidth: 2)
                .frame(width: 52, height: 52, alignment: .center)
                .scaleEffect(1 + CGFloat(animation))
                .opacity(1 - animation)
            
            AsyncImage(url: URL(string: location.image)!){ image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48, alignment: .center)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
                            
        }
        .onAppear {
            withAnimation(Animation.easeOut(duration: 2).repeatForever(autoreverses: false)) {
                animation = 1
            }
        }
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView(location: RestorauntLocation(id: "", name: "", image: "https://lh5.googleusercontent.com/p/AF1QipPN-59ZwSrGbEPk6Ut5GIXhHU6gFts6OMdG6gf1=w408-h269-k-no", latitude: 0, longitude: 0))
    }
}
