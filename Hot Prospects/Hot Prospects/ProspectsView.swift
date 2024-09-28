//
//  ProspectsView.swift
//  Hot Prospects
//
//  Created by Alfonso Acosta on 2024-09-24.
//

import SwiftUI
import SwiftData

struct ProspectsView: View {
    
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext
    enum FilterType {
        case none, contacted, uncontacted //weird to have three diff prospect views
    }
    let filter: FilterType
    
    var title: String{
        switch filter{
        case .none:
            "Everyone"
        case .contacted:
            "Contacted People"
        case .uncontacted:
            "Uncontacted People"
        }
    }
    init(filter: FilterType) {
        self.filter = filter

        if filter != .none {
            let showContactedOnly = filter == .contacted
            //is it true that we are on the page that shows only contacted
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    }

    var body: some View {
        NavigationStack{
            List(prospects) { prospect in
                VStack(alignment: .leading) {
                    Text(prospect.name)
                        .font(.headline)
                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                }
            }
                .navigationTitle(title)
                .toolbar{
                    Button("Scan", systemImage: "qrcode.viewfinder"){
                        let prospect = Prospect(name: "Paul Hudson", emailAddress: "paul@hackingwithswift.com", isContacted: false)
                        modelContext.insert(prospect)
                    }
                }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
}

