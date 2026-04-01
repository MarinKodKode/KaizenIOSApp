//
//  MainTabView.swift
//  Kaizen
//
//  Created by Manuel Alejandro Hernandez Marín on 01/04/26.
//

import Foundation
import SwiftUI

struct MainTabView : View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            TodoHomeView()
                .tabItem{
                    Label("Home", systemImage : "house.fill")
                }
                .tag(0)
            
            ForumView()
                .tabItem{
                    Label("Forum", systemImage : "person.wave.2")
                }
                .tag(1)
            
            BuzzesView()
                .tabItem{
                    Label("Buzzes", systemImage : "iphone.gen2.radiowaves.left.and.right")
                }
                .tag(2)
            
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage : "person.fill")
                }
                .tag(3)
        }
    }
}
