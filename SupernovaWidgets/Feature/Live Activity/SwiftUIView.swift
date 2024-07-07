//
//  SwiftUIView.swift
//  SupernovaWidgetsExtension
//
//  Created by Henrique Marques on 06/07/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct PomodoroLiveActivitiesWidget: Widget {
        
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: HomeLaunchActivity.self) { content in
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.black)
                
                VStack {
                    HStack {
                        
                        Image(systemName: "sparkles")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.yellow)
                            .frame(width: 40, height: 40)
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                        
                        HStack {

                            Text(timerInterval: Date()...Date().addingTimeInterval(content.attributes.minutesLeft), countsDown: true, showsHours: false)
                                        .font(.title)
                            
                            Spacer()
                            
                            Text("Supernova")
                                .foregroundStyle(.yellow)
                                .font(.subheadline)

                        }

                            Text("SP Rocket's")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        
                        Spacer()
                        
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)

                    
                }
                .padding(15)

            }
        } dynamicIsland: { context in
            
            DynamicIsland {

                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "sparkles")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.yellow)
                        .frame(width: 20, height: 20)
                }

                DynamicIslandExpandedRegion(.center) {
                    
                    VStack {
                        
                        HStack {
                            Text(timerInterval: Date()...Date().addingTimeInterval(context.attributes.minutesLeft), countsDown: true, showsHours: false)
                                .font(.title)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                            
                            Text(context.attributes.tagSelected)
                                .foregroundStyle(.yellow)
                                .font(.subheadline)
                        }
                        
                        Text(String(context.attributes.phrase))
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                        
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(0)

                    }
                }

            } compactLeading: {
                Image(systemName: "sparkles")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.yellow)
                    .frame(width: 20, height: 20)
            } compactTrailing: {
                Text(timerInterval: Date()...Date().addingTimeInterval(context.attributes.minutesLeft), countsDown: true, showsHours: false)
                    .multilineTextAlignment(.center)
                    .frame(width: 40)
                    .font(.caption2)
            } minimal: {
                Text(timerInterval: Date()...Date().addingTimeInterval(context.attributes.minutesLeft), countsDown: true, showsHours: false)
                    .multilineTextAlignment(.center)
                    .frame(width: 40)
                    .font(.caption2)
            }
            .keylineTint(Color.yellow)
        }
    }
}

func stopLiveActivities() {
    
    Task {
        if #available(iOSApplicationExtension 16.2, *) {
            for activity in Activity<HomeLaunchActivity>.activities {
                await activity.end(nil, dismissalPolicy: .immediate)
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
