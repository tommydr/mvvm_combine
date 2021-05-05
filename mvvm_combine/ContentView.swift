//
//  ContentView.swift
//  mvvm_combine
//
//  Created by Tommy den Reijer on 04/05/2021.
//

import SwiftUI

struct ContentView: View {
	
	@StateObject var viewModel = ContentViewModel()
	
    var body: some View {
		VStack{
			Text(viewModel.time)
				.padding()
			List(viewModel.users){ user in
				Text(user.name)
			}
		}
		
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
