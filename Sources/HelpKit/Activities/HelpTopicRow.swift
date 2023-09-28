//
//  HelpTopicRow.swift
//  HelpKit
//
//  Created by Adam Foot on 28/09/2023.
//

import SwiftUI

struct HelpTopicRow: View {
    private let topic: HKTopic
    private let displayMode: HKDisplayMode

    init(_ topic: HKTopic, displayMode: HKDisplayMode) {
        self.topic = topic
        self.displayMode = displayMode
    }

    var body: some View {
        switch displayMode {
        case .inline:
            DisclosureGroup {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 12) {
                        if let image = topic.contentImage {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }

                        Text(topic.content)
                            .font(.subheadline)
                    }

                    if let links = topic.links {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Links")
                                .font(.subheadline.bold())

                            ForEach(links) { link in
                                Link(link.title, destination: link.url)
                            }
                            .buttonStyle(.plain)
                            .font(.subheadline)
                            .foregroundStyle(Color.accentColor)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

            } label: {
                titleLabel
            }

        case .navigation:
            NavigationLink {
                HelpTopicView(topic)
            } label: {
                titleLabel
                    .lineLimit(2)
            }
        }
    }

    @ViewBuilder
    private var titleLabel: some View {
        if let systemImage = topic.iconSystemImage {
            Label {
                Text(topic.title)
            } icon: {
                Image(systemName: systemImage)
                    .foregroundStyle(topic.iconTint)
            }

        } else {
            Text(topic.title)
        }
    }
}

#Preview {
    NavigationStack {
        Form {
            HelpTopicRow(.example, displayMode: .navigation)
        }
    }
}
