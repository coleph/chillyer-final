//
//  NetworkManager.swift
//  Cate Sports App
//
//  Created by Cole Hillyer on 5/28/20.
//  Copyright © 2020 Ian Mabon. All rights reserved.
//

import Foundation

class SportManager: ObservableObject {
    
    let serverLocation = "https://locahost/"
    
    @Published var sportName = String()
    @Published var lat = String()
    @Published var long = String()
    @Published var notes = String()
    @Published var time = String()
    @Published var location = String()
    // these variables will be observed by the content view but first they must be retrieved from the server
    

    
    func fetchData(sportSearched: String) {
        
        print("beginning to fetch data")
        
        if let url = URL(string: "\(serverLocation)&q=\(sportSearched)") {
            print("url:\(url)")
            // check to see if url is created correctly
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                print("intask")
                print("error:\(error)")
                if error == nil {
                    let decoder = JSONDecoder()
                    print("abouttodecode")
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(SportData.self, from: safeData)
                            DispatchQueue.main.async {
                                print("help")
                                self.sportName = (results.Sport)
                                self.lat = (results.Lat)
                                self.long = (results.Long)
                                self.time = (results.Time)
                                self.location = (results.Location)
                                // after the json from the server is decoded the varaibles in the app can be updated
                                
                                
                                
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
            // im honestly not sure what this does
        }
}
}
