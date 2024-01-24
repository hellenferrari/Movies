//
// Copyright (c) Hellen Ferrari. All rights reserved.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel: MoviesViewModel
    
    var body: some View {
        NavigationStack {
            TextField("Search for movies", text: $viewModel.searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding([.leading, .trailing], 8)
                .textFieldStyle(PlainTextFieldStyle())
                .onChange(of: viewModel.searchText) { newText in
                    Task {
                        await viewModel.fetchMovies(with: newText)
                    }
                }
            Spacer()
            
            switch viewModel.loadingState {
            case .loading:
                ProgressView()
            case .empty:
                Text("No data to display")
            case .failed:
                Text("Failed to load movies")
            case .loaded:
                ScrollView(.horizontal) {
                    HStack{
                        ForEach(viewModel.movies, id: \.id) { movie in
                            VStack {
                                ImageView(url: movie.poster)
                                VStack {
                                    Text(movie.title)
                                    Text(movie.year)
                                    Button {
                                        // TODO:
                                    } label: {
                                        Text("Learn More")
                                    }
                                    .buttonStyle(.bordered)
                                    .tint(.blue)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Movies")
                .navigationBarTitleDisplayMode(.inline)
            }
            Spacer()
        }
    }
}


