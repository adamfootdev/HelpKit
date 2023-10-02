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
        #if os(tvOS) || os(watchOS)
        navigationView
        #else
        switch displayMode {
        case .inline:
            inlineView
        case .navigation:
            navigationView
        }
        #endif
    }

    #if !os(tvOS) && !os(watchOS)
    private var inlineView: some View {
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
    }
    #endif

    private var navigationView: some View {
        NavigationLink {
            HelpTopicView(topic)
        } label: {
            titleLabel
                .lineLimit(titleLineLimit)
        }
    }

    @ViewBuilder
    private var titleLabel: some View {
        if let systemImage = topic.iconSystemImage {
            Label {
                Text(topic.title)
                    .padding(.leading, titleLabelPadding)
            } icon: {
                Image(systemName: systemImage)
                    .foregroundStyle(topic.iconTint)
            }

        } else {
            Text(topic.title)
        }
    }

    private var titleLineLimit: Int {
        #if os(tvOS)
        return 1
        #elseif os(watchOS)
        return 3
        #else
        return 2
        #endif
    }
    private var titleLabelPadding: CGFloat {
        #if os(watchOS)
        return 4
        #else
        return 0
        #endif
    }
}

#Preview {
    NavigationView {
        Form {
            HelpTopicRow(.example, displayMode: .navigation)
        }
    }
}
