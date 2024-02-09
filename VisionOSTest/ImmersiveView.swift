//
//  ImmersiveView.swift
//  VisionOSTest
//
//  Created by Alejandro Alberto Gavira García on 9/2/24.
//

import SwiftUI
import RealityKit
import AVFoundation

struct ImmersiveView: View {
    
    @Environment(\.openWindow) var openWindow
    @EnvironmentObject var skyboxSettings: SkyboxSettings
    
    var body: some View {
        RealityView { content in
            
            /*
             
             // Dynamic Skyybox
             guard let dynamicSkyBox = createDynamicSkybox() else { return }
             //Add skybox
             content.add(dynamicSkyBox)
             
            */
            
            guard let staticSkyBox = createStaticSkybox() else { return }
            //Add skybox
            content.add(staticSkyBox)
            
        } update: { content in
            
            // print(skyboxSettings.currentSkyBox)
            updateStaticSkybox(with: skyboxSettings.currentSkyBox, content: content)
            
        }
        .onAppear(perform: {
            //open Window
            openWindow(id: "SkyBoxControls")
        })
    }
    
    //MARK: - Static changes
    private func createStaticSkybox() -> Entity? {
        let skyboxMesh = MeshResource.generateSphere(radius: 1000)
        
        var skyBoxMaterial = UnlitMaterial()
        guard let skyBoxTexture = try? TextureResource.load(named: "desert") else { return nil }
        
        skyBoxMaterial.color = .init(texture: .init(skyBoxTexture))
        
        let skyBoxEntity = Entity()
        skyBoxEntity.components.set(ModelComponent(mesh: skyboxMesh, materials: [skyBoxMaterial]))
        
        skyBoxEntity.scale = .init(x: -1, y: 1, z: 1)
        skyBoxEntity.name = "SkyBox"
        
        return skyBoxEntity
    }
    
    private func updateStaticSkybox(with newName: String, content: RealityViewContent){
        
        let skyBoxEntity = content.entities.first { entity in
            entity.name == "SkyBox"
        }
        
        guard let updatedSkyBoxTexture  = try? TextureResource.load(named: newName) else { return }
        var updatedBoxMaterial = UnlitMaterial()
        updatedBoxMaterial.color = .init(texture: .init(updatedSkyBoxTexture))
        
        skyBoxEntity?.components.set(
            ModelComponent(mesh: MeshResource.generateSphere(radius: 1000), materials: [updatedBoxMaterial]))
        
    }
    //MARK: - Dinamic 360Video
    private func createDynamicSkybox() -> Entity? {
        // Mesh
        let skyboxMesh = MeshResource.generateSphere(radius: 1000)
        
        //Video Material
        guard let videoMaterial = createVideoMaterial() else { return nil }
        
        //Entity
        let skyBoxEntity = ModelEntity(mesh: skyboxMesh, materials: [videoMaterial])
        skyBoxEntity.scale = .init(x: -1, y: 1, z: 1)
        
        
        return skyBoxEntity
    }

    
    private func createVideoMaterial() -> VideoMaterial? {
        // Video url
        guard let url = Bundle.main.url(forResource: "beach", withExtension: "mp4") else { return nil }
        //AVPlayer
        let avPlayer = AVPlayer(url:url)
        //
        let videoMaterial = VideoMaterial(avPlayer: avPlayer)
        avPlayer.play()
        
        return videoMaterial
    }
    
}

#Preview {
    ImmersiveView()
}
