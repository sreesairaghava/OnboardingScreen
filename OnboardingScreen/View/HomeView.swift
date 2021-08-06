//
//  HomeView.swift
//  OnboardingScreen
//
//  Created by Sree Sai Raghava Dandu on 06/08/21.
//

import SwiftUI

struct HomeView: View {
    @State var offset: CGFloat = 0
    var screenSize: CGSize
    var body: some View {
        VStack{
            Button{
                print("test")
            } label:{
                Image(systemName: "leaf.fill")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.green)
                    .frame(width: 30, height: 30)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            OffsetPageTabView(offset: $offset) {
                HStack(spacing:0){
                    ForEach(intros){ intro in
                        //Image
                        VStack{
                            Image(intro.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: screenSize.height / 3)
                            VStack(alignment:.leading,spacing:22){
                                // Text
                                Text(intro.title)
                                    .font(.largeTitle.bold())
                                // Description
                                Text(intro.description)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.top,50)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        //Setting max width
                        .frame(width:screenSize.width)
                    }
                }
            }
            //Animated Indicator
            HStack(alignment:.bottom){
                //Indicators
                HStack(spacing: 12){
                    ForEach(intros.indices, id: \.self){ index in
                        Capsule()
                            .fill(Color.blue)
                            .frame(width: getIndex() == index ? 20 : 7, height: 7)
                    }
                }
                .overlay(
                    Capsule()
                        .fill(Color.blue)
                        .frame(width: 20, height: 7)
                        .offset(x: getIndicatorOffset())
                    ,alignment: .leading
                )
                .offset(x: 10, y: -15)
                Spacer()
                Button{
                    // Updating offset
                    let index = min(getIndex() + 1, intros.count - 1)
                    offset = CGFloat(index) * screenSize.width
                } label:{
                    Image(systemName: "chevron.right")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(20)
                        .background(
                            Circle()
                                .foregroundColor(intros[getIndex()].color)
                        )
                }
            }
            .padding()
            .offset(y: -20)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        // Animating when index changes
        .animation(.easeInOut,value: getIndex())
    }
    // Offset for indicator
    func getIndicatorOffset() -> CGFloat{
        let progress = offset / screenSize.width
        // 12 = spacing + 7 = Circle size
        let maxWidth:CGFloat = 12 + 7
        return progress * maxWidth
    }
    
    //Expanding index based on offset..
    func getIndex() -> Int{
        let progress = round(offset / screenSize.width)
        //For safe side
        let index = min(Int(progress),intros.count - 1)
        return index
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
