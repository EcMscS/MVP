//
//  DataService.swift
//  CrowdScoreDemoApp
//
//  Created by Ben Sullivan on 15/11/2018.
//  Copyright © 2018 Ben Sullivan. All rights reserved.
//

import Foundation

struct DataService {
    
    func createCompetitions(matchModels: [MatchesResultModel]) -> [Competition] {
        var competitions = [Competition]()
        
        let matchModelsSortedByCompetition = matchModels.sorted { $0.competition.ordering < $1.competition.ordering }
        
        matchModelsSortedByCompetition.forEach { match in
            let newMatch = Match(
                homeTeam: Team(shortName: match.homeTeam.shortName),
                awayTeam: Team(shortName: match.awayTeam.shortName),
                kickOffTime: match.kickOffTime.asTimeString())
            
            if competitions.isEmpty {
                let competition = Competition(ordering: match.competition.ordering, matches: [newMatch], name: match.competition.name)
                competitions.append(competition)
                return
            }
            
            if let ordering = competitions.last?.ordering, match.competition.ordering == ordering {
                var comp = competitions.last!
                comp.matches?.append(newMatch)
                competitions.removeLast()
                competitions.append(comp)
            } else {
                let competition = Competition(ordering: match.competition.ordering, matches: [newMatch], name: match.competition.name)
                competitions.append(competition)
            }
            
        }
        
        return competitions
    }
}
