//
//  MotorcycleName.swift
//  Transforming
//
//  Created by Sanny on 2025/12/4.
//
// ducati
import UIKit

enum MotorcycleName: String, CaseIterable {
    case Streetfighter_V4_SP2, Diavel_V4, DesertX, XDiavel_V4, Monster_Plus_Re, Panigale_V2_MM93, Monster_Plus_Wh, DesertX_Rally
    
    var color: UIColor {
        switch self {
        case .Streetfighter_V4_SP2:
            return .black
        case .Diavel_V4:
            return .green
        case .DesertX:
            return .systemGray
        case .XDiavel_V4:
            return .systemPink
        case .Monster_Plus_Re:
            return .systemCyan
        case .Panigale_V2_MM93:
            return .orange
        case .Monster_Plus_Wh:
            return .blue
        case .DesertX_Rally:
            return .init(red: 0.7, green: 0.4, blue: 0.3, alpha: 1.0)
        }
    }
    
    var horsepower: Int {
        switch self {
        case .Streetfighter_V4_SP2:
            return 153
        case .Diavel_V4:
            return 168
        case .DesertX:
            return 0
        case .XDiavel_V4:
            return 168
        case .Monster_Plus_Re:
            return 111
        case .Panigale_V2_MM93:
            return 120
        case .Monster_Plus_Wh:
            return 111
        case .DesertX_Rally:
            return 110
        }
    }
    
    var weightNoFuel: Double {
        switch self {
        case .Streetfighter_V4_SP2:
            return 190
        case .Diavel_V4:
            return 223
        case .DesertX:
            return 0
        case .XDiavel_V4:
            return 229
        case .Monster_Plus_Re:
            return 175
        case .Panigale_V2_MM93:
            return 1755
        case .Monster_Plus_Wh:
            return 175
        case .DesertX_Rally:
            return 211
        }
    }
    
    var engineDescription: String {
        switch self {
        case .Streetfighter_V4_SP2:
            "Desmosedici Stradale 90° V4, rearward-rotating crankshaft, 4 Desmodromically actuated valves per cylinder, liquid cooled"
        case .Diavel_V4:
            "V4 Granturismo, V4 - 90°, 4 valves per cylinder, counter-rotating rankshaft, Twin Pulse firing order, liquid cooled"
        case .DesertX:
            "The new DesertX at EICMA 2026, available in dealerships from May 2026."
        case .XDiavel_V4:
            "V4 Granturismo, V4 - 90°, 4 valves per cylinder, counter-rotating crankshaft, Twin Pulse firing order, liquid cooled"
        case .Monster_Plus_Re:
            "Ducati V2 engine: 90° V2, 4 valves per cylinder, intake variable valves timing system, liquid cooled"
        case .Panigale_V2_MM93:
            "Ducati V2 engine: 90° V2, 4 valves per cylinder, intake variable valves timing system, liquid cooled"
        case .Monster_Plus_Wh:
            "Ducati V2 engine: 90° V2, 4 valves per cylinder, intake variable valves timing system, liquid cooled"
        case .DesertX_Rally:
            "Ducati Testastretta 11°, L-Twin cylinders, Desmodromic valvetrain, 4 valves per cylinder, liquid cooled"
        }
    }
}
