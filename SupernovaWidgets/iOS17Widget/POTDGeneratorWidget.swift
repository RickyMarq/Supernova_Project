//
//  POTDGeneratorWidget.swift
//  SupernovaWidgetsExtension
//
//  Created by Henrique Marques on 13/06/23.
//

import SwiftUI
import WidgetKit

struct ModelPicturePOTD: TimelineEntry {
    let date: Date
    var widgetDate: PictureOfTheDay
}

struct POTDGeneratorWidgetMain: Widget {
    let kind: String = "PictureOfTheDayWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            POTDGeneratorWidget(entry: entry)
        }
        .configurationDisplayName("Nasa Picture of the Day")
        .description("Displays nasa picture of the day")
        .supportedFamilies([.systemSmall])
    }
}

private struct Provider: TimelineProvider {
    
    func getSnapshot(in context: Context, completion: @escaping (ModelPicture) -> Void) {
        let entry = ModelPicture(date: Date(), defaultImage: UIImage(), widgetDate: PictureOfTheDay(date: "", explanation: "", title: "", url: "", hdurl: ""))
        completion(entry)
    }
    
    func placeholder(in context: Context) -> ModelPicture {
        ModelPicture(date: Date(), defaultImage: UIImage() , widgetDate: PictureOfTheDay(date: "", explanation: "", title: "", url: "", hdurl: ""))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ModelPicture>) -> Void) {
        
    }
    
//    Button(intent: ButtonPOTD.init()) {
//
//    }
//    
}

private struct POTDGeneratorWidget: View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family

    var body: some View {
        
        switch family {
            
        case .systemSmall:
            ZStack {
                Text("Hello world")
                
                
            }
            if #available(iOSApplicationExtension 17.0, *) {
//                .containerBackground(for: .widget) {
//                    Color.primary
//                }
            } else {
                // Fallback on earlier versions
            }
            
        case .systemMedium:
            ZStack {
                
            }
        case .systemLarge:
            ZStack {
                
            }
        case .systemExtraLarge:
            ZStack {
                
            }
        case .accessoryCircular:
            ZStack {
                
            }
        case .accessoryRectangular:
            ZStack {
                
            }
        case .accessoryInline:
            ZStack {
                
            }
        @unknown default:
            ZStack {
                
            }
        }
        
    }
    
}
 



//#Preview {
//    POTDGeneratorWidget()
//}
