//
//  Rocket.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 08/01/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct Rocket: View {
    
    @State var rocketEntity: Entity = {
        let headAnchor = AnchorEntity()
        headAnchor.position = [0.70, -0.35, -1]
        return headAnchor
    }()
    
    @State var rotateBy: Double = 0.0
        
    var body: some View {
        RealityView { content in
            
            do {
                let immersiveEntity = try await Entity(named: "Falcon9")
                immersiveEntity.position = SIMD3<Float>(x: 0, y: -0.5, z: 0)
                
                immersiveEntity.components.set(RotationComponent(speed: 1.0))
                
                immersiveEntity.scale *= SIMD3<Float>(0.3, 0.3, 0.3)
                content.add(immersiveEntity)
            } catch {
                print("Error, this rocket it's not available in a 3D model")
            }
        }
        .gesture(TapGesture().targetedToAnyEntity().onEnded({ value in
            print("Tap")
        }))
        
        .toolbar {
            ToolbarItemGroup(placement: .bottomOrnament) {
                HStack {
                    Button(action: {
                            print("Rotate Objc")
                             
                        }) {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(.title)
                                .frame(width: 44, height: 44)
                    }
                }
            }
        }
        .rotation3DEffect(.radians(rotateBy), axis: .y)
        .gesture(
            DragGesture(minimumDistance: 0.0)
                .targetedToAnyEntity()
                .onChanged({ value in
                    let location3d = value.convert(value.location3D, from: .local, to: .scene)
                    let startLocation = value.convert(value.startLocation3D, from: .local, to: .scene)
                    
                    let delta = location3d - startLocation
                    rotateBy = Double(atan(delta.x * 200))
                    
                })
            
        
        )
    }
//    
//    func createSkyBox() -> Entity? {
//        let skyBoxMesh = MeshResource.generateSphere(radius: 1000)
//        let skyBoxMaterial = UnlitMaterial()
//        guard let skyBoxTexture = try? TextureResource.load(named: "SkyBox") else {return nil}
//        skyBoxMaterial.color = .init(texture: skyBoxTexture)
//        
//    }
}

#Preview {
    Rocket()
}
