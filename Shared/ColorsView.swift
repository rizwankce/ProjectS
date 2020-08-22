//
//  ColorsView.swift
//  ProjectS
//
//  Created by Rizwan on 21/08/20.
//

import SwiftUI

class ColorsViewModel: ObservableObject {
    @Published var file: File? = nil
    @Published var nodes: [Node] = []
    @Published var fileKey: String = "wxc1NIgZj8FXeJmWTZhJCu"
    @Published var showSettings: Bool = false

    init (_ dummyData: Bool = false) {
        if dummyData {
            let fills = Fills.init(type: "SOLID", visible: true, opacity: 1, color: FillColor.init(r: 0.5843137502670288, g: 0.07058823853731155, b: 0.07058823853731155, a: 1), blendMode: "BLEND_MODE")
            let node = Node(id: "a", name: "Name Here", type: .vector, children: nil, fills: [fills, fills], backgroundColor: nil)
            let nodes: [Node] = [node, node, node, node, node]
            self.nodes = nodes
        }
    }
}

struct ColorsView: View {
    @StateObject var defaults: AppDefaults
    @StateObject var viewModel = ColorsViewModel()
    let columns = [
        GridItem(.adaptive(minimum: 500))
    ]

    var body: some View {
        #if os(iOS)
        NavigationView {
            contentView
                .navigationBarTitle("ProjectS")
                .navigationBarItems(trailing: settingsIcon)
                .sheet(isPresented: $viewModel.showSettings, content: {
                    SettingsView(defaults: defaults)
                })
        }
        #endif

        #if os(macOS)
        contentView
        #endif

    }

    var contentView: some View {
        VStack(spacing: 20) {
            if defaults.isFigmaConnected {
                HStack {
                    TextField("Enter File Key", text: $viewModel.fileKey)
                    Button("Fetch Colors", action: onTapFetchColors)
                }
                .padding()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0..<viewModel.nodes.count, id: \.hashValue , content: { i in
                            HStack {
                                Text(viewModel.nodes[i].name).font(.headline)
                                if let fills = viewModel.nodes[i].fills, fills.count > 0 {
                                    ForEach(0..<fills.count, content: { i in
                                        if let color = getColor(for: fills[i]) {
                                            Circle()
                                                .fill(color)
                                                .frame(width: 20, height: 20)
                                        }
                                    })
                                }
                                Spacer()
                            }
                            .padding()
                        })
                    }
                    .padding(.horizontal)
                }
                .background(Color.white)
            }
            else {
                Text("Connect with Figma on Preference")
            }
        }
    }

    var settingsIcon: some View {
        Button(action: {
            viewModel.showSettings = true
        }, label: {
            Image.init(systemName: "gear")
                .font(Font.system(.title2))
        })
    }

    func getColor(for fill: Fills) -> Color? {
        return fill.color?.color
    }

    func onTapFetchColors() {
        FigmaClient.shared.getFile(viewModel.fileKey) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                if let file = try? decoder.decode(File.self, from: response.data) {
                    self.viewModel.file = file
                    self.viewModel.nodes = file.document.filter(by: .vector)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct ColorsView_Previews: PreviewProvider {

    static var previews: some View {
        ColorsView(defaults: AppDefaults.shared, viewModel: ColorsViewModel.init(true))
    }
}
