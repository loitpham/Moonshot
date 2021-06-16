//
//  AstronautView.swift
//  Moonshot
//
//  Created by Loi Pham on 6/15/21.
//

import SwiftUI

struct AstronautView: View {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    let astronaut: Astronaut
    let filteredMissions: [Mission]
    
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        var missionNamesTemp = [Mission]()
        
        for mission in AstronautView.missions {
            for crewMember in mission.crew {
                if crewMember.name == astronaut.id {
                    missionNamesTemp.append(mission)
                }
            }
        }
        self.filteredMissions = missionNamesTemp
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    Text(astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    Section(header: Text("Missions")) {
                        List(filteredMissions) { mission in
                            NavigationLink(
                                destination: MissionView(mission: mission, astronauts: AstronautView.astronauts)) {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                
                                    VStack(alignment: .leading) {
                                        Text(mission.displayName)
                                            .font(.headline)
                                        Text(mission.formattedLaunchDate)
                                    }
                                }
                        }
                    }
                    
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
