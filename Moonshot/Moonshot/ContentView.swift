//
//  ContentView.swift
//  Moonshot
//
//  Created by Loi Pham on 6/8/21.
//

import SwiftUI

struct ContentView: View {
    @State var showingDates = true
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(
                    destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                    
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            if showingDates {
                                Text(mission.formattedLaunchDate)
                            } else {
                                VStack(alignment: .leading) {
                                    ForEach(mission.crew, id: \.name) { member in
                                        Text(member.name.capitalized)
                                    }
                                }
                            }
                        }
                    }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Toggle(isOn: $showingDates) {
                
                Text("Show launch dates")
                
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
