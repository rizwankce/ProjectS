//
//  Files.swift
//  ProjectS
//
//  Created by Rizwan on 21/08/20.
//

import Foundation
import SwiftUI

struct File: Decodable {
    let name: String
    let lastModified: String
    let thumbnailUrl: String
    let version: String
    let role: String
    let schemaVersion: Int
    let document: Node
}

struct Node: Decodable {
    enum NodeType: String, Decodable {
        case vector = "VECTOR"
        case document = "DOCUMENT"
        case canvas = "CANVAS"
        case frame = "FRAME"
        case group = "GROUP"
        case booleanOperation = "BOOLEAN_OPERATION"
        case star = "STAR"
        case line = "LINE"
        case eclipse = "ECLIPSE"
        case regularPolygon = "REGULAR_POLYGON"
        case rectangle = "RECTANGLE"
        case text = "TEXT"
        case slice = "SLICE"
        case component = "COMPONENT"
        case instance = "INSTANCE"
    }
    let id: String
    let name: String
    let type: NodeType
    let children: [Node]?
    let fills: [Fills]?
    let backgroundColor: FillColor?
}

extension Node {
    func filter(by type: NodeType) -> [Node] {
        var nodes: [Node] = []
        if type == self.type {
            nodes.append(self)
        }

        if let childrens = children {
            for child in childrens {
                nodes.append(contentsOf: child.filter(by: type))
            }
        }

        return nodes
    }
}

struct Fills: Decodable {
    let type: String
    let visible: Bool?
    let opacity: Int?
    let color: FillColor?
    let blendMode: String?
}

struct FillColor: Decodable {
    let r: Double
    let g: Double
    let b: Double
    let a: Double

    var color: Color {
        #if os(iOS)
        return Color.init(red: r, green: g, blue: b, opacity: a)
        #endif
        #if os(macOS)
        let nsColor = NSColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
        return Color(nsColor)
        #endif
    }
}
