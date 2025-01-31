//
//  View.swift
//  appletv
//
//  Created by Fredrik Vedvik on 14/03/2023.
//

import SwiftUI

struct PageDisplay: View {
    var page: API.GetPageQuery.Data.Page

    func mapToItem(item: API.ItemSectionFragment.Items.Item) -> Item {
        Item(id: item.id, title: item.title, description: item.description, image: item.image)
    }
    
    var body: some View {
        List(page.sections.items, id: \.id) { section in
            if let itemSection = section.asItemSection {
                switch section.__typename {
                case "FeaturedSection":
                    FeaturedSection(title: itemSection.title, items: itemSection.items.items.map(mapToItem))
                case "DefaultSection":
                    ItemListView(title: itemSection.title, items: itemSection.items.items.map(mapToItem)) { item in
                        ItemView(item: item, destination: EpisodeViewer(episodeId: item.id))
                    }
                default:
                    EmptyView()
                }
            }
        }.navigationTitle(page.title)
    }
}

struct PageView: View {
    @State var pageId: String
    @State var page: API.GetPageQuery.Data.Page? = nil
    
    init(pageId: String) {
        self.pageId = pageId
    }

    func load() {
        page = nil
        apolloClient.fetch(query: API.GetPageQuery(id: pageId)) { result in
            switch result {
            case let .success(res):
                if let p = res.data {
                    page = p.page
                }
            case .failure:
                print("FAILED")
            }

            print("OK")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let p = page {
                PageDisplay(page: p).refreshable { load() }
            } else {
                ProgressView()
            }
        }.task { load() }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pageId: "29")
    }
}
