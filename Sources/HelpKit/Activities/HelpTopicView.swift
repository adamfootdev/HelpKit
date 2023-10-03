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
            imageSection
            contentSection
            linksSection
        }
        #if os(macOS)
        .formStyle(.grouped)
        #else
        .navigationTitle(String(
            localized: "help.title",
            bundle: .module
        ))
        #endif
        #if !os(macOS) && !os(tvOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }


    // MARK: - Image

    @ViewBuilder
    private var imageSection: some View {
        if let image = topic.contentImage {
            Section {
                image
                    .resizable()
                    .frame(height: imageHeight)
                    .scaledToFill()
                    #if os(macOS)
                    .padding(-12)
                    #elseif os(tvOS)
                    .frame(width: 600)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .focusable()
                    #elseif os(watchOS)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    #endif
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowBackground(Color.clear)
            }
        }
    }

    private var imageHeight: CGFloat {
        #if os(tvOS)
        return 300
        #elseif os(watchOS)
        return 100
        #else
        return 200
        #endif
    }


    // MARK: - Content

    private var contentSection: some View {
        Section {
            #if os(tvOS)
            // Adding an empty button here so that the row can be
            // highlighted in a SwiftUI form.
            Button(action: {}) {
                contentView
            }
            #else
            contentView
            #endif
        }
    }

    private var contentView: some View {
        VStack(alignment: .leading, spacing: contentSpacing) {
            Text(topic.title)
                .font(.title3.bold())

            Text(topic.content)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, verticalPadding)
    }

    private var contentSpacing: CGFloat {
        #if os(macOS) || os(watchOS)
        return 8
        #else
        return 16
        #endif
    }

    private var verticalPadding: CGFloat {
        #if os(tvOS)
        return 20
        #elseif os(watchOS)
        return 8
        #else
        return 0
        #endif
    }


    // MARK: - Links

    @ViewBuilder
    private var linksSection: some View {
        if let links = topic.links {
            Section {
                ForEach(links) { link in
                    #if os(macOS)
                    LabeledContent(link.title) {
                        Link(
                            String(
                                localized: "view.title",
                                bundle: .module
                            ),
                            destination: link.url
                        )
                    }

                    #elseif os(tvOS)
                    // Adding an empty button here so that the row can be
                    // highlighted in a SwiftUI form.
                    Button(action: {}) {
                        LabeledContent(
                            link.title,
                            value: link.url.absoluteString
                        )
                    }

                    #elseif os(watchOS)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(link.title)

                        Text(link.url.absoluteString)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 8)

                    #else
                    Link(link.title, destination: link.url)
                    #endif
                }
            } header: {
                Text("links.title", bundle: .module)
            }
        }
    }
}

#Preview {
    NavigationView {
        HelpTopicView(.example)
    }
}
