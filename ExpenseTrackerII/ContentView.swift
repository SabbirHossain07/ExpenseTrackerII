//
//  ContentView.swift
//  ExpenseTrackerII
//
//  Created by sabbir_iosdev on 22/5/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
