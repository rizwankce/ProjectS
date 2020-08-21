//
//  ContentView.swift
//  Shared
//
//  Created by Rizwan on 21/08/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ColorsView(defaults: AppDefaults.shared)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
