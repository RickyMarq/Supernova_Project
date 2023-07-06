//
//  PictureOfTheDay.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 27/06/23.
//

import SwiftUI
import SDWebImageSwiftUI
//import SkeletonUI

struct PictureOfTheDay: View {
    
    var data: PictureOfTheDayModel
    @State var dataObjc: [PictureOfTheDayModel] = []
    @State var isLoading = true
    
    var body: some View {
                ScrollView {
                VStack(alignment: .leading) {
                    ForEach(dataObjc) { datum in
                        
                        
                        Text(datum.title ?? "")
//                            .skeleton(with: dataObjc.isEmpty)
//                            .animation(type: .pulse())
//                            .appearance(type: .solid(color: .red, background: .blue))
                            .bold()
                        
                        WebImage(url: URL(string: datum.url ?? ""))
                            .resizable()
                            .placeholder(content: {
                                Rectangle().foregroundColor(Color.gray)
                            })
                            .transition(.fade(duration: 0.5))
                            .cornerRadius(10)
                            .scaledToFill()
                        //       .border(Color.accentColor)
                        
                          
                            .shadow(color: Color.accentColor, radius: 0.5, x: 0, y: 0.5)
                        
                        
                        Text(datum.explanation ?? "")
                            .foregroundColor(Color.secondary)
                        
                            .padding(.bottom)
                                      
                        HStack {
                            Spacer()
                            Text("Nasa Picture of The Day")
                                .foregroundColor(Color.primary)
                                .bold()
                                .multilineTextAlignment(.trailing)
                        }
//                        HStack {
//                            Spacer()
//                            Text(data.newsSite ?? "")
//                                .foregroundColor(Color.primary)
//                                .bold()
//                                .multilineTextAlignment(.trailing)
//                        }
//                        .padding()
                    }
                }
            }
            .padding(.horizontal, 5)
            .navigationTitle("Picture of The Day")
//            .background(Color.red)
 //           .cornerRadius(10)
            
            .onAppear {
                
            // WatchOS 8
//            .navigationBarTitleDisplayMode(.inline)
 //           .navigationTitle("Picture of The Day")
        }
     
        .onAppear {
            getPictureOfTheDay()
        }
    }
    
    func getPictureOfTheDay() {
        AppleWatchService.sharedObjc.getPictureOfTheDay { data, error in
            guard let data = data else {return}
            dataObjc.append(data)
            isLoading = false
        }
    }
}

struct PictureOfTheDay_Previews: PreviewProvider {
    static var previews: some View {
        PictureOfTheDay(data: PictureOfTheDayModel(date: "2023-06-27", explanation: "hese two global views of Mars were captured at ultraviolet wavelengths, beyond the spectrum visible to human eyes. Recorded by the MAVEN spacecraft's Imaging Ultraviolet Spectrograph instrument in July 2022 (left) and January 2023, three otherwise invisible ultraviolet bands are mapped into red, green, and blue colors. That color scheme presents the Red Planet's surface features in shades of tan and green. Haze and clouds appear white or blue, while high altitude ozone takes on a dramatic purple hue. On the left, Mars' south polar ice cap is in brilliant white at the bottom but shrinking during the southern hemisphere's summer season. On the right, the northern hemisphere's polar region is seen shrouded in clouds and atmospheric ozone. Known to some as the Mars Atmosphere and Volatile EvolutioN spacecraft, MAVEN has been exploring Mars' tenuous upper atmosphere, ionosphere, and its interactions with the Sun and solar wind since 2014.", title: "MAVEN's Ultraviolet Mars", url: "https://apod.nasa.gov/apod/image/2306/MavenMars2panel.png", hdurl: ""))
    }
}
