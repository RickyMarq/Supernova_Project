//
//  RocketItemUI.swift
//  Supernova
//
//  Created by Henrique Marques on 23/06/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct RocketItemUI: View {
    
    var data: SupernovaRocketModel
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    //                Text("Hello World")
                    HStack {
                        // Não usar RoundRectangle, é melhor usar uma VStack que eu posso colocar conteúdo sem ter que usar .overlay que é exclusivo do iOS 16.
                        VStack(alignment: .center, spacing: 10) {
                            Text(data.name ?? "")
                                .font(.system(.title, design: .rounded))
                                .foregroundColor(Color.primary)
                                .fontWeight(.black)
                            Text("Mass: " + (data.mass ?? ""))
                                .font(.system(.headline, design: .rounded))
                                .foregroundColor(Color.secondary)
                            VStack(alignment: .leading) {
                            Text("Manufacture: " + (data.company ?? ""))
  //                              .font(.system(.headline, design: .rounded))
                                .foregroundColor(Color.secondary)
                            
                            }
                            .padding()
  //                          .background(Color.orange)
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Mass: " + (data.mass ?? ""))
                                    .font(.system(.headline, design: .rounded))
                                    .foregroundColor(Color.secondary)
                                Divider()
                                Text("Diameter: " + (data.diameter ?? ""))
                                    .font(.headline)
                                    .foregroundColor(Color.secondary)
 //                               Spacer()
                            }
                            .padding(10)
                            .background(Color.secondary)
                             .cornerRadius(12)
                            
                            Spacer()
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width/3, minHeight: UIScreen.main.bounds.height * 0.7)
                        .padding(30)
  //                      .background(Color.red)
                        .cornerRadius(20)
                        
                        VStack {
                            WebImage(url: URL(string: data.image ?? ""))
                                .resizable()
                                .scaledToFill()
                                .frame(height: UIScreen.main.bounds.height * 0.7)
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width/3, minHeight: UIScreen.main.bounds.height * 0.7)
                        .padding(30)
                        //                    .background(Color.red)
                        .cornerRadius(20)
                        //                    RoundedRectangle(cornerRadius: 10)
                        //                        .foregroundColor(Color.green)
                        //                        .padding()
                        
                        
                    }
                        
                 
                    
                    
                }

//                .background(Color.orange)
                
            }
            
            VStack {
                HStack {
                    Text("DEBUG MODE")
                }
                .frame(width: UIScreen.main.bounds.width - 10, height: 150)
            }
            .background(Color.secondary)
            .cornerRadius(15)
            
            
        }
    }
}

struct RocketItemUI_Previews: PreviewProvider {
    static var previews: some View {
        RocketItemUI(data: SupernovaRocketModel(name: "Falcon Heavy", company: "SpaceEx", description: "Falcon Heavy is composed of three reusable Falcon 9 nine-engine cores whose 27 Merlin engines together generate more than 5 million pounds of thrust at liftoff, equal to approximately eighteen 747 aircraft. As one of the world’s most powerful operational rockets, Falcon Heavy can lift nearly 64 metric tons (141,000 lbs) to orbit.", year: 1, image: "https://i.ebayimg.com/images/g/5~sAAOSwlS1hnTI-/s-l1600.png", height: 70, diameter: "3,66", mass: "1 420 788 kg"))
    }
}
