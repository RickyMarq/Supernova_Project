//
//  PictureOfTheDayWidget.swift
//  Supernova
//
//  Created by Henrique Marques on 12/06/23.
//

import SwiftUI
import WidgetKit

struct ModelPicture: TimelineEntry {
    let date: Date
    var defaultImage: UIImage
    var widgetDate: PictureOfTheDay
}

struct PictureOfTheDay: Codable {
    let date: String?
    let explanation: String?
    let title: String?
    let url: String?
    let hdurl: String?
}

struct PictureOfTheDayWidget: Widget {
    let kind: String = "PictureOfTheDayWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PictureOfTheDayWidgetView(entry: entry)
        }
        .configurationDisplayName("Nasa Picture of the Day")
        .description("Displays nasa picture of the day")
        .supportedFamilies([.systemMedium, .systemSmall])
    }
}

private struct Provider: TimelineProvider {
    
    func getSnapshot(in context: Context, completion: @escaping (ModelPicture) -> Void) {
        let entry = ModelPicture(date: Date(), defaultImage: UIImage(named: "supernovaDefaultImage") ?? UIImage(), widgetDate: PictureOfTheDay(date: "", explanation: "", title: "", url: "backgroundLaunching", hdurl: ""))
        completion(entry)
    }
    
    func placeholder(in context: Context) -> ModelPicture {
        ModelPicture(date: Date(), defaultImage: UIImage(named: "supernovaDefaultImage") ?? UIImage(), widgetDate: PictureOfTheDay(date: "", explanation: "", title: "", url: "", hdurl: ""))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ModelPicture>) -> Void) {
        getPictureOfTheDay { data, err in
            let midnight = Calendar.current.startOfDay(for: Date())
            let nextMidnight = Calendar.current.date(byAdding: .second, value: 1, to: midnight)
            let entries = [ModelPicture(date: Date(), defaultImage: UIImage(), widgetDate: data ?? PictureOfTheDay(date: "", explanation: "", title: "", url: "", hdurl: ""))]
            let timeline = Timeline(entries: entries, policy: .after(nextMidnight!))
            completion(timeline)
        } 
    }
}

private struct PictureOfTheDayWidgetView: View {
    var entry: Provider.Entry
        
        var body: some View {
            
            ZStack {
                Image(uiImage: entry.defaultImage)
    //                .resizable()
    //                .scaledToFill()
                
                if let imageURL, let data = try? Data(contentsOf: imageURL) {
                    URLImageView(data: data)
                        .scaledToFill()
                     //   .aspectRatio(contentMode: .fill)
                }
            }
            
//            .containerBackground(for: .widget) {
//                Color.clear
//            }
            
        }
    
    
    var imageURL: URL? {
        let path = entry.widgetDate.url ?? ""
        return URL(string: path)
    }
}

struct PictureOfTheDayWidget_Previews: PreviewProvider {
    static var previews: some View {
        PictureOfTheDayWidgetView(entry: ModelPicture(date: Date(), defaultImage: UIImage(named: "supernovaDefaultImage") ?? UIImage(), widgetDate: PictureOfTheDay(date: "", explanation: "", title: "", url: "", hdurl: "")))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}


func getPictureOfTheDay(completion: @escaping (PictureOfTheDay?, Error?) -> Void) {
    guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=w5JIaXjSdSutczlH7qd7LnKLY3nWZSQcEAFRPcNt") else {return}
    let session = URLSession.shared
    let request = URLRequest(url: url)
    
    session.dataTask(with: request) { data, response, error in
        guard let data = data else {
            completion(nil, error)
            return}
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(PictureOfTheDay.self, from: data)
            completion(model, nil)
        } catch {
            completion(nil, error)
        }
    }
    .resume()
}

extension UIImage {
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
