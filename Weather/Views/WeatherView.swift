//
//  WeatherView.swift
//  Weather
//
//  Created by Soorya Narayanan Sanand on 7/10/2022.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    let Rain = "cloud.rain.fill"
    let Clear = "sun.max"
    let Clouds = "cloud.fill"
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .center, spacing: 5) {
                    Text(weather.name)
                        .bold().font(.title)
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))").fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                VStack{
                    Text(weather.main.feelsLike.roundDouble() + "°")
                        .font(.system(size: 100))
                        .fontWeight(.light)
                    
                    let currentWeather = weather.weather[0].main
                    
                    if currentWeather == "Rain" {
                        HStack {
                            Image(systemName: Rain)
                            Text(weather.weather[0].main)
                                .font(.system(size: 20)).textCase(.uppercase)
                        }
                    } else if currentWeather == "Clear" {
                        HStack {
                            Image(systemName: Clear)
                            Text(weather.weather[0].main)
                                .font(.system(size: 20)).textCase(.uppercase)
                        }
                    } else if currentWeather == "Clouds" {
                        HStack {
                            Image(systemName: Clouds)
                            Text(weather.weather[0].main)
                                .font(.system(size: 20)).textCase(.uppercase)
                        }
                    } else {
                        HStack {
                            Text(weather.weather[0].main)
                                .font(.system(size: 20)).textCase(.uppercase)
                        }
                    }
                    
                    Spacer().frame(height: 30)
                    
                    AsyncImage(url: URL(string:"https://cdn.pixabay.com/photo/2020/04/18/01/04/cityscape-5057263_1280.png")) {
                        image in image.resizable().aspectRatio(contentMode: .fit).frame(width: 400)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                    
                }
                .frame(width: .infinity)
            }.padding().frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather Now")
                        .fontWeight(.bold).font(.title2)
                    
                    HStack{
                        WeatherRow(logo: "thermometer.low", name: "Min temp", value: (weather.main.tempMin.roundDouble() + "°"))
                        Spacer()
                        WeatherRow(logo: "thermometer.high", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                    }
                    
                    HStack{
                        WeatherRow(logo: "wind", name: "Wind Speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: (weather.main.humidity.roundDouble() + "%"))
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30.0)
                .padding()
                .padding(.trailing, 30.0)
                .padding(.bottom, 20)
                .foregroundColor(Color(red: 0.184, green: 0.552, blue: 0.845))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(red: 0.184, green: 0.552, blue: 0.845))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
