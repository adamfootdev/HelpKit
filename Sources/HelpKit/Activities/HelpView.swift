//
//  HelpView.swift
//  HelpKit
//
//  Created by Adam Foot on 28/09/2023.
//

import SwiftUI

public struct HelpView: View {

    /// A custom struct of type `HKConfiguration` containing details for HelpKit.
    private let configuration: HKConfiguration

    /// A `String` containing the current search text for filtering topics.
    @State private var searchText: String = ""

    /// Initializes a new SwiftUI `View` which displays help topics.
    /// - Parameter configuration: A custom struct of type `HKConfiguration` containing details for HelpKit.
    public init(configuration: HKConfiguration) {
        self.configuration = configuration
    }

    public var body: some View {
        Group {
            if filteredSections.isEmpty {
                noResultsView
            } else {
                Form {
                    ForEach(filteredSections) { section in
                        let filteredTopics = filterTopics(from: section.topics)

                        if filteredTopics.isEmpty == false {
                            Section {
                                ForEach(filteredTopics) { topic in
                                    HelpTopicRow(
                                        topic,
                                        displayMode: configuration.displayMode
                                    )
                                }

                            } header: {
                                if let title = section.title {
                                    Text(title)
                                }
                            }
                        }
                    }

                    if let getSupportAction = configuration.getSupportAction {
                        Section {
                            #if os(macOS)
                            LabeledContent(String(
                                localized: "moreOptions.title",
                                bundle: .module
                            )) {
                                Button(String(
                                    localized: "getSupport.alternate.title",
                                    bundle: .module
                                )) {
                                    getSupportAction()
                                }
                            }

                            #else
                            Button(String(
                                localized: "getSupport.title",
                                bundle: .module
                            )) {
                                getSupportAction()
                            }
                            #endif
                        }
                    }
                }
                #if os(macOS)
                .formStyle(.grouped)
                #endif
            }
        }
        .navigationTitle(String(
            localized: "help.title",
            bundle: .module
        ))
        #if !os(tvOS)
        .searchable(
            text: $searchText,
            placement: searchFieldPlacement,
            prompt: Text("filterTopics.title", bundle: .module)
        )
        #endif
    }


    // MARK: - Search

    private var searchFieldPlacement: SearchFieldPlacement {
        #if os(macOS)
        return .toolbar
        #elseif os(tvOS)
        return .automatic
        #elseif os(watchOS)
        return .navigationBarDrawer
        #else
        return .navigationBarDrawer(displayMode: .always)
        #endif
    }

    @ViewBuilder
    private var noResultsView: some View {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
            ContentUnavailableView
                .search(text: searchText)
        } else {
            Text("noResultsFound.title", bundle: .module)
                .font(.title2.bold())
                .foregroundStyle(.secondary)
        }
    }

    private var filteredSections: [HKTopicSection] {
        let searchText = self.searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard searchText.isEmpty == false else {
            return configuration.topicSections
        }

        return configuration.topicSections.filter { section in
            section.topics.contains(where: {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                ($0.keywords ?? []).map { $0.lowercased() }.contains(searchText.lowercased()) ||
                $0.content.lowercased().contains(searchText.lowercased())
            })
        }
    }

    private func filterTopics(from topics: [HKTopic]) -> [HKTopic] {
        let searchText = self.searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard searchText.isEmpty == false else {
            return topics
        }

        return topics.filter {
            $0.title.lowercased().contains(searchText.lowercased()) ||
            ($0.keywords ?? []).map { $0.lowercased() }.contains(searchText.lowercased()) ||
            $0.content.lowercased().contains(searchText.lowercased())
        }
    }
}

#Preview {
    NavigationView {
        HelpView(configuration: .example)
    }
}
