//
//  SupernovaWidgets.swift
//  SupernovaWidgets
//
//  Created by Henrique Marques on 08/06/23.
//

import WidgetKit
import SwiftUI

private struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> Model {
        Model(date: Date(), widgetDate: LastLauchesModel(results: [ResultedModel(name: "Falcon 9", image: "", lastUpdated: "", windowStart: "")]), lastUpdateTime: Calendar.current.date(bySettingHour: 22, minute: 39, second: 20, of: Date())!)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (Model) -> ()) {
        let entry = Model(date: Date(), widgetDate: LastLauchesModel(results: [ResultedModel(name: "Falcon 9", image: "", lastUpdated: "", windowStart: "")]), lastUpdateTime: Calendar.current.date(bySettingHour: 22, minute: 39, second: 20, of: Date())!)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Model>) -> ()) {
        
        WidgetsService.sharedObjc.getFutureLauches(limit: 1, startsAt: 0) { result in
            switch result {
                
            case .success(let model):
                let date = Date()
                var dateToDisplay = Date()
                var LaunchingIsClose = false
                let fullHours = convertHoursForCountDownLaunchesFormatter(model?[0].windowStart ?? "", outPut: "HH:mm:ss")
                dateToDisplay = fullHours
                let timeInterval = fullHours.timeIntervalSince(Date())
                
                let convertion = max(Int(timeInterval), 0)
                let hours = convertion / 3600
                let minutes = (convertion % 3600) / 60
                let seconds = (convertion % 3600) % 60
                
                if hours == 0 {
                    LaunchingIsClose = true
                }
                
                var data = Model(date: date, widgetDate: LastLauchesModel(results: model ?? []), lastUpdateTime: dateToDisplay, launchIsClose: LaunchingIsClose)
                
                
                data.hourCountDown = Int(hours)
                data.minuteCountDown = Int(minutes)
                data.secondCountDown = Int(seconds)
                                
                let nextUpdate = Calendar.current.date(byAdding: .hour, value: 3, to: date)
                
                
                let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))
                
                completion(timeline)
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct SupernovaWidgetsEntryView : View {
    var data: Model
    
    var body: some View {
        ZStack {
            Image("spacebackground")
                .resizable()
                .scaledToFill()
            VStack(alignment: .center, spacing: 2) {
                Text(data.widgetDate.results[0].name ?? "")
                    .foregroundColor(Color.white)
                    .bold()
                    .padding(.horizontal, 50)
                    .multilineTextAlignment(.center)
                    .cornerRadius(10)
                    .lineLimit(2)
                    .truncationMode(.middle)
                HStack(alignment: .center) {
                    VStack(alignment: .center) {
                        
                        HStack() {
                            if data.hourCountDown <= 0 {
                                Text("0:00:00")
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .padding(.all, 8)
                                    .foregroundColor(.white)
                                    .shadow(color: .purple, radius: 0.5, x: 0, y: 1)
                                    .padding(.horizontal, 3)
                            } else {
                                Text(data.lastUpdateTime, style: .timer)
                                    .font(.system(.subheadline, design: .rounded))
                                
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(data.launchIsClose ? .red : .white)
                                    .padding(.all, 8)
                                    .shadow(color: .purple, radius: 0.5, x: 0, y: 1)
                                    .padding(.horizontal, 3)
                                
                            }
                        }
                        .background(Color.secondary)
                        .cornerRadius(10)
                        .frame(maxWidth: 100, maxHeight: 25)
                    }
                }
                .padding()
            }
            .padding(.top)
        }
        .ignoresSafeArea()
    }
    
    var imageURL: URL? {
        let path = data.widgetDate.results[0].image ?? ""
        return URL(string: path)
    }
}

struct SupernovaWidgets: Widget {
    let kind: String = "SupernovaWidgets"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SupernovaWidgetsEntryView(data: entry)
        }
        .configurationDisplayName("Rocket Launching")
        .description("Shows how many time left for a launch.")
        .supportedFamilies([.systemMedium])
        .contentMarginsDisabled()
    }
}

struct SupernovaWidgets_Previews: PreviewProvider {
    static var previews: some View {
        SupernovaWidgetsEntryView(data: Model(date: Date(), widgetDate: LastLauchesModel(results: [ResultedModel(name: "Soyuz 2.1b/Fregat-M | Meteor-M No.2.3 and others", image: "", lastUpdated: "", windowStart: "")]), hourCountDown: 1, minuteCountDown: 22, secondCountDown: 20, lastUpdateTime: Calendar.current.date(bySettingHour: 22, minute: 39, second: 20, of: Date())!, launchIsClose: false))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
