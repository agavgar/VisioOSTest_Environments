//
//  VisionOSTestApp.swift
//  VisionOSTest
//
//  Created by Alejandro Alberto Gavira García on 9/2/24.
//

import SwiftUI

@main
struct VisionOSTestApp: App {
    
    @ObservedObject var skyboxSettings = SkyboxSettings()
    
    var body: some Scene {
        
        //VR
        ImmersiveSpace(id: "ImmersiveView"){
            // Immersive view
            ImmersiveView()
                .environmentObject(skyboxSettings)
        }.immersionStyle(selection: .constant(.full), in: .full)
        
        // Window
        WindowGroup(id: "SkyBoxControls"){
            SkyBoxControls()
                .environmentObject(skyboxSettings)
        }.defaultSize(width: 40, height: 30)
    }
}

class SkyboxSettings: ObservableObject {
    @Published var currentSkyBox = ""
}
