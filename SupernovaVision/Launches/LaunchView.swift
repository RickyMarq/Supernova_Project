//
//  LaunchView.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 08/01/24.
//

import SwiftUI
import RealityKit

struct LaunchViewItem: View {
    
    var data: ResultedModel
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        
        GeometryReader { proxy in
            let textWidth = min(max(proxy.size.width * 0.4, 300), 500)
            let imageWidth = min(max(proxy.size.width - textWidth, 300), 700)
            ZStack {
                HStack(spacing: 60) {
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer()
                        Text("#\(data.pad?.agencyID ?? 0)")
                            .font(.callout)
                            .padding()
                        
                        Text(data.name ?? "")
                            .font(.extraLargeTitle)
                            .multilineTextAlignment(.leading)
                            .padding()
                        
                        Text("A batch of satellites for the Starlink mega-constellation - SpaceX's project for space-based Internet communication system")
                            .font(.headline)
                            .padding()
                        
                        Spacer()
                    }
//                    .glassBackgroundEffect()
                    .frame(width: textWidth, alignment: .leading)

                    AsyncImage(url: URL(string: data.image ?? "")) { image in
                        image
                            .resizable()
                            .cornerRadius(10)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 500, alignment: .center)
                            .shadow(radius: 10)
                            .glassBackgroundEffect()
                    } placeholder: {
                        
                    }
                }

                Spacer()
            }
        }
        .background(Image("SolarBackground")
            .resizable()
            .scaledToFill()
        
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Upcoming Launch")
        .navigationBarItems(trailing:
        
    Button(action: {
            
            openWindow(id: "ImmersiveRocketSpace")
            
        }) {
            Image(systemName: "view.3d")
                .font(.title)
                .frame(width: 44, height: 44)
            }
        )
        
        .onDisappear {
            dismissWindow(id: "ImmersiveRocketSpace")
        }
    }
}

#Preview {
    LaunchViewItem(data: ResultedModel(id: "123", name: "Falcon 9 Block 5 | Starlink Group 6-35", image: "https://static.wikia.nocookie.net/thelastofus/images/2/2f/Part_I_Bill_infobox.png/revision/latest?cb=20230215182523", lastUpdated: "", windowStart: "", weatherConcerns: "", pad: Pad(name: "", WikiUrl: "", MapImage: "", latitude: "", longitude: "", launchCount: 0, orbitalLaunchCount: 0, agencyID: 0, location: Location(name: "")), locationLaunchAttemptCount: 0, padLaunchAttemptCount: 0, orbitalLaunchAttemptCount: 0))
}
