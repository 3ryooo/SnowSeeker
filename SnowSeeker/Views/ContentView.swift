//
//  ContentView.swift
//  SnowSeeker
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var favorites = Favorites()
    
    @State private var searchText = ""
    
    @State private var sortedBy = "default"
    
    var filteredResorts: [Resort] {
        
        var tempResorts = resorts
        
        if searchText.isEmpty {
            tempResorts = resorts
        } else {
            tempResorts = resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
        
        switch sortedBy {
        case "default":
            return tempResorts
        case "name":
            return tempResorts.sorted {
                let p1 = $0.name.localizedCaseInsensitiveContains(searchText)
                let p2 = $1.name.localizedCaseInsensitiveContains(searchText)

                if p1 && !p2 {
                    return true
                } else if !p1 && p2 {
                    return false
                }

                return $0.name < $1.name
            }
        case "country":
            return tempResorts.sorted {
                let p1 = $0.country.localizedCaseInsensitiveContains(searchText)
                let p2 = $1.country.localizedCaseInsensitiveContains(searchText)

                if p1 && !p2 {
                    return true
                } else if !p1 && p2 {
                    return false
                }

                return $0.country < $1.country
            }
        default:
            return tempResorts
        }
        
    }
    
    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                    
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar() {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortedBy) {
                        Text("None")
                            .tag("default")
                        Text("Sort by Name")
                            .tag("name")
                        Text("Sort by Country")
                            .tag("country")
                    }
                }
            }

        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}



#Preview {
    ContentView()
}
