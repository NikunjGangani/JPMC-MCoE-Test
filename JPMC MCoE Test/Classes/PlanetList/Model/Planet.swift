//
//  Planet.swift
//  JPMC MCoE Test
//
//  Created by Nikunj Gangani on 18/04/2023.
//

import Foundation

struct PlanetResult: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Planet]?
}

struct Planet: Codable {
    let name: String?
    let rotation_period: String?
    let orbital_period: String?
    let diameter: String?
    let climate: String?
    let gravity: String?
    let terrain: String?
    let surface_water: String?
    let population: String?
    let residents: [String]?
    let films: [String]?
    let created: String?
    let edited: String?
    let url: String?
}
