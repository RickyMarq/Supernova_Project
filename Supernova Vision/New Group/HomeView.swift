//
//  Home.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 09/01/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            ZStack {
                HStack(alignment: .top) {
                    AsyncImage(url: URL(string: "https://static.wikia.nocookie.net/thelastofus/images/2/2f/Part_I_Bill_infobox.png/revision/latest/scale-to-width-down/700?cb=20230215182523")) { image in
                        image
                            .resizable()
                            .cornerRadius(10)
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
