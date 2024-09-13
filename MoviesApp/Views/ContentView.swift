//
//  ContentView.swift
//  MoviesApp
//
//  Created by Mohammad Azam on 6/14/20.
//  
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented: Bool = false
    @Environment(\.presentationMode) var presentationMode
    let screenSize = UIScreen.main.bounds
    @ObservedObject var httpClient = HTTPMovieClient()

    var body: some View {
        
        NavigationView {

            List(self.httpClient.movies, id: \.id) { movie in

                NavigationLink(destination: MovieDetailsView(movie: movie)) {
                    
                    VStack {
                        Image(movie.poster)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(movie.title)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .font(.system(size: 25))
                            .cornerRadius(10)

                    }

                }
            }


        .navigationBarTitle("Movies")
            .navigationBarItems(trailing: Button(action: {
                self.isPresented = true
            }){
                Image(systemName: "plus")
            })

            .onAppear {
                self.httpClient.getAllMovies()
            }

        }.sheet(isPresented: $isPresented, onDismiss: {
            self.httpClient.getAllMovies()
        }, content: {
            AddMovieView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
