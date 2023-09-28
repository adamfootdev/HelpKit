//
//  HelpTopicView.swift
//  HelpKit
//
//  Created by Adam Foot on 28/09/2023.
//

import SwiftUI

struct HelpTopicView: View {
    private let topic: HKTopic

    init(_ topic: HKTopic) {
        self.topic = topic
    }

    var body: some View {
        Form {
            if let image = topic.contentImage {
                Section {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowBackground(Color.clear)
                }
            }

            Section {
                VStack(alignment: .leading, spacing: 16) {
                    Text(topic.title)
                        .font(.title3.bold())

                    Text(topic.content)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            if let links = topic.links {
                Section {
                    ForEach(links) { link in
                        Link(link.title, destination: link.url)
                    }
                } header: {
                    Text("Links")
                }
            }
        }
        .navigationTitle("Help")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HelpTopicView(.example)
}
