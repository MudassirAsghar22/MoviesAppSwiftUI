//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by Mohammad Azam on 6/19/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct MovieDetailsView: View {
    
    let movie: Movie
    
    
    @State private var reviewTitle: String = ""
    @State private var reviewBody: String = ""

    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var httpClient = HTTPMovieClient()

    private func saveReview() {
        let review = Review(title: self.reviewTitle, body: self.reviewBody, movie: self.movie)

        HTTPMovieClient().saveReview(review: review) { success in

            if success {
                // load all the reviews again
                self.httpClient.getReviewsById(movie: self.movie)
            }

        }
    }

    private func deleteMovie() {
        HTTPMovieClient().deleteMovie(movie: movie) { success in
            DispatchQueue.main.async {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }


    var body: some View {
        
        Form {
            
            Image(movie.poster)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Section(header: Text("ADD A REVIEW").fontWeight(.bold)) {
                VStack(alignment: .center, spacing: 10) {
                    TextField("Enter Title",text: $reviewTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Enter Body",text: $reviewBody) .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button("Save") {
                        print("save")
                        self.saveReview()
                    }.frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
            }
            
            Section(header: Text("REVIEWS").fontWeight(.bold)) {
                ForEach(self.httpClient.reviews ?? [Review](), id: \.id) { review in
                    Text(review.title)
                }
            }
        }

        .onAppear(perform: {
            //get movie with reviews
            self.httpClient.getReviewsById(movie: self.movie)
        })


        .navigationBarTitle(movie.title)
            
        .navigationBarItems(trailing: Button(action: {
            
            self.deleteMovie()

        }) {
            Image(systemName: "trash.fill")
        })
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: Movie(title: "Birds of Prey", poster: "birds"))
        
    }
}
