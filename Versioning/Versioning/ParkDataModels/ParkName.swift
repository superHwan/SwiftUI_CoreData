//
//  ParkName.swift
//  Versioning
//
//  Created by Sanny on 2025/11/30.
//

enum ParkName: String, CaseIterable {
    case Abel_Tasman
    case Zion
    case Banff
    case Jasper
    case Bavarian_Forest
    case Dartmoor
    case Grand_Teton
    case Dolomites
    case Yellowstone
    case Jiuzhaigou
    case Swiss
    case Yosemite
    case Arches
    
    var parkLocation: (region: String, country: String) {
        switch self {
        case .Abel_Tasman:
            ("South Island", "New Zealand")
        case .Zion:
            ("Utah", "United States")
        case .Banff:
            ("Alberta", "Canada")
        case .Jasper:
            ("Alberta", "Canada")
        case .Bavarian_Forest:
            ("Bavaria", "Germany")
        case .Dartmoor:
            ("Devon", "United Kingdom")
        case .Grand_Teton:
            ("Wyoming", "United States")
        case .Dolomites:
            ("Belluno", "Italy")
        case .Yellowstone:
            ("Wyoming", "United States")
        case .Jiuzhaigou:
            ("Sichuan", "China")
        case .Swiss:
            ("Zernez", "Switzerland")
        case .Yosemite:
            ("California", "United States")
        case .Arches:
            ("Utah", "United States")
        }
    }
}

// Version 2
extension ParkName {
    var parkRating: Int {
        switch self {
        case .Abel_Tasman:
            10
        case .Zion:
            5
        case .Banff:
            3
        case .Jasper:
            2
        case .Bavarian_Forest:
            13
        case .Dartmoor:
            12
        case .Grand_Teton:
            11
        case .Dolomites:
            1
        case .Yellowstone:
            8
        case .Jiuzhaigou:
            6
        case .Swiss:
            4
        case .Yosemite:
            7
        case .Arches:
            9
        }
    }
}

// Version 3
extension ParkName {
    var detailImageNames: [String] {
        switch self {
        case .Abel_Tasman:
            return ["Abel_Tasman_Detail1", "Abel_Tasman_Detail2"]
        case .Zion:
            return ["Zion_D1", "Zion_D2"]
        case .Banff:
            return ["Banff_D1", "Banff_D2"]
        case .Jasper:
            return ["Jasper_D1"]
        case .Bavarian_Forest:
            return ["BF_D1", "BF_D2", "BF_D3"]
        case .Dartmoor:
            return ["Dartmoor_D1", "Dartmoor_D2"]
        case .Grand_Teton:
            return ["GT_D1", "GT_D2"]
        case .Dolomites:
            return ["Dolomites_D1", "Dolomites_D2"]
        case .Yellowstone:
            return ["Yellowstone_D1", "Yellowstone_D2"]
        case .Jiuzhaigou:
            return ["Jiuzhaigou_D1", "Jiuzhaigou_D2"]
        case .Swiss:
            return ["Swiss_D1"]
        case .Yosemite:
            return ["Yosemite_D1", "Yosemite_D2"]
        case .Arches:
            return ["Arches_D1", "Arches_D2"]
        }
    }
}
