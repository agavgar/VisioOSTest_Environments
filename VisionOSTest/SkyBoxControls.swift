//
//  SkyBoxControls.swift
//  VisionOSTest
//
//  Created by Alejandro Alberto Gavira García on 9/2/24.
//

import SwiftUI



struct SkyBoxControls: View {
    
    @EnvironmentObject var skyboxSettings: SkyboxSettings
    
    var body: some View {
        HStack {
            
            SkyBoxButton(onClick: {
                //Cambiar skybox
                skyboxSettings.currentSkyBox = "forest"
            }, iconName: "tree")
            
            SkyBoxButton(onClick: {
                //Cambiar
                skyboxSettings.currentSkyBox = "alien"
            }, iconName: "moon")
            
            SkyBoxButton(onClick: {
                
                skyboxSettings.currentSkyBox = "desert"
                
            }, iconName: "mountain.2")
            
            SkyBoxButton(onClick: {
                
                skyboxSettings.currentSkyBox = "manga"
                
            }, iconName: "beach.umbrella")
        }
    }
}

#Preview {
    SkyBoxControls()
}

struct SkyBoxButton: View {
    
    var onClick: () -> Void
    var iconName:String
    
    var body: some View {
        Button(action: {
            //Change Skybox
            onClick()
            
        }, label: {
            Image(systemName: iconName)
        })
    }
}
