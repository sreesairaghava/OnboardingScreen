//
//  IntroModel.swift
//  OnboardingScreen
//
//  Created by Sree Sai Raghava Dandu on 06/08/21.
//

import SwiftUI

//Intro model and sample intro's

struct Intro: Identifiable{
    var id = UUID().uuidString
    var image: String
    var title: String
    var description: String
    var color: Color
}


//Sample data

var intros: [Intro] = [
    Intro(image: "food1", title: "Choose Your fav resturant", description: "Anything near by is better to choose", color: Color("blue")),
    Intro(image: "food2", title: "Compare prices", description: "Get the lowest price possible", color: Color("yellow")),
    Intro(image: "food3", title: "Super fast delivery", description: "Get safe, secure delivery by our trusted partners", color: Color("green")),
    Intro(image: "food1", title: "Choose Your fav resturant", description: "Anything near by is better to choose", color: Color("blue"))
]
