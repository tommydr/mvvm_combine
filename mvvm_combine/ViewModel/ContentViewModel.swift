//
//  ContentViewModel.swift
//  mvvm_combine
//
//  Created by Tommy den Reijer on 05/05/2021.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject{
	
	@Published var time = ""
	@Published var users = [User]()
	
//	private var anyCancellable: AnyCancellable
	private var cancellables = Set<AnyCancellable>()
	
	let formatter: DateFormatter = {
		let df = DateFormatter()
		df.timeStyle = .medium
		return df
	}()
	
	init() {
		setupTimerPublishers()
		setupDataTaskPublishers()
	}
	
	private func setupDataTaskPublishers(){
		let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
		URLSession.shared.dataTaskPublisher(for: url)
			.tryMap{ (data, response) in
				guard let httpResponse = response as? HTTPURLResponse,
					  httpResponse.statusCode == 200 else{
					throw URLError(.badServerResponse)
				}
				return data
				
			}
			.decode(type: [User].self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { _ in }) {users in
				self.users = users
			}
			.store(in: &cancellables)
		
	}
	
	private func setupTimerPublishers(){
		  Timer.publish(every: 1, on: .main, in: .default)
			.autoconnect()
			.receive(on: RunLoop.main)
			.sink{value in
				self.time = self.formatter.string(from: value)
			}
			.store(in: &cancellables)
	}
	
	
	
}
