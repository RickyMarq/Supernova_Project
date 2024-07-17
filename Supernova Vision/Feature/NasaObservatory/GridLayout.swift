//
//  GridLayout.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 09/01/24.
//

import SwiftUI

struct StackGridItem: Identifiable {
    let id = UUID()
    let height: CGFloat
    let title: String
    let description: String
    let imgString: String
}


struct GridLayout: View {
    struct StackColumn: Identifiable {
        let id = UUID()
        var gridItem = [StackGridItem]()
    }
    
    var columns: [StackColumn] = [StackColumn(gridItem: [StackGridItem(height: 200, title: "", description: "", imgString: ""),
                                                         StackGridItem(height: 50, title: "", description: "", imgString: ""),
                                                         StackGridItem(height: 100, title: "", description: "", imgString: "")
                                                        ]),
                                  StackColumn(gridItem: [StackGridItem(height: 50, title: "", description: "", imgString: ""),
                                                         StackGridItem(height: 300, title: "", description: "", imgString: "")])]
    
    var spacing: CGFloat = 10
    var horizontalPadding: CGFloat = 10
    
    var picturesOfTheDayData: [PictureOfTheDay]
    
    init(gridItems: [StackGridItem], numberofColumns: Int, spacing: CGFloat = 20, horizontalPadding: CGFloat = 20, picturesOfTheDay: [PictureOfTheDay]) {
        self.spacing = spacing
        self.horizontalPadding = horizontalPadding
        self.picturesOfTheDayData = picturesOfTheDay
        
        print("DEBUG MODE PIC: \(picturesOfTheDay.count)")
        
        var columns = [StackColumn]()
        for _ in 0..<numberofColumns {
            columns.append(StackColumn())
        }
        
        var columnsHeight = Array<CGFloat>(repeating: 0, count: numberofColumns)
        
        for gridItem in gridItems {
            var smallestColumnIndex = 0
            var smallestHeight = columnsHeight.first!
            
            for i in 1..<columnsHeight.count {
                let colHeight = columnsHeight[i]
                if colHeight < smallestHeight {
                    smallestHeight = colHeight
                    smallestColumnIndex = i
                }
            }
            
            columns[smallestColumnIndex].gridItem.append(gridItem)
            columnsHeight[smallestColumnIndex] += gridItem.height
        }
        self.columns = columns
    }
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .top, spacing: spacing) {
                ForEach(columns) { col in
                    LazyVStack(spacing: spacing) {
                        ForEach(col.gridItem) { gridItem in
                            ZStack {
                                NavigationLink(destination: NasaObItem(data: PictureOfTheDay(date: "", explanation: gridItem.description, title: gridItem.title, url: gridItem.imgString))) {
                                    GeometryReader { reader in
                                        AsyncImage(url: URL(string: gridItem.imgString)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
                                        } placeholder: {
                                            
                                        }
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                .onTapGesture {
                                    print("DEBUG MODE: Poggers")
                                }
                            }
                            .frame(height: gridItem.height)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, horizontalPadding)
    }
}

