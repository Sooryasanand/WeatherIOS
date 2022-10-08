//
//  ContentView.swift
//  Weather
//
//  Created by Soorya Narayanan Sanand on 6/10/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherMananger = WeatherManager()
    @State var weather: ResponseBody?
    
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do{
                                weather = try await weatherMananger.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error fetching weather data")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
            
        }
        .background(Color(red: 0.184, green: 0.552, blue: 0.845))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
