//
//  HelpView.swift
//  HelpKit
//
//  Created by Adam Foot on 28/09/2023.
//

import SwiftUI

struct HelpView: View {
    private let configuration: HKConfiguration

    @State private var searchText: String = ""

    init(configuration: HKConfiguration) {
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
                }
            }
        }
        .navigationTitle("Help")
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: Text("Filter Topics")
        )
    }


    // MARK: - Search

    @ViewBuilder
    private var noResultsView: some View {
        if #available(iOS 17.0, *) {
            ContentUnavailableView
                .search(text: searchText)
        } else {
            Text("No Results Found")
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
    NavigationStack {
        HelpView(configuration: .example)
    }
}
