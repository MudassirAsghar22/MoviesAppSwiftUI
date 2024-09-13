//
//  AddMovieView.swift
//  MoviesApp
//
//  Created by Mohammad Azam on 6/14/20.
//  
//

import SwiftUI

struct AddMovieView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var name: String = ""
    @State private var posters = ["10":false, "avengers": false, "black-panther": false, "birds": false]
    
    private func handleTapGesture(movie: String) {
        
        // set all values to be false
        posters.forEach {
            posters[$0.key] = false
        }
        
        // mark the movie to be selected
        posters[movie]?.toggle()
    }
    
    private func saveMovie() {
        // get the selected poster
        let selectedPoster = posters.first {
            $0.value == true
        }.map {$0.key} ?? "placeholder"

        HTTPMovieClient().saveMovie(name: self.name, poster: selectedPoster) { success in

            if success {
                // close te model
                self.presentationMode.wrappedValue.dismiss()
            } else {
                // show the user the error message that save was not successful
            }

        }

    }

    var body: some View {
        NavigationView {
            
            ScrollView {
                
                VStack(alignment: .center, spacing: 20) {
                    
                    TextField("Enter name", text: self.$name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    // movies
                    VStack {
                        HStack {
                            Image("10")
                                .resizable()
                                .border(Color.white, width: self.posters["10"]! ? 10 : 0)
                                .aspectRatio(contentMode: .fill)
                                .onTapGesture {
                                    self.handleTapGesture(movie: "10")
                            }
                            
                            Image("avengers")
                                .resizable()
                                .border(Color.white, width: self.posters["avengers"]! ? 10 : 0)
                                .aspectRatio(contentMode: .fill)
                                .onTapGesture {
                                    self.handleTapGesture(movie: "avengers")
                            }
                        }
                        HStack {
                            Image("black-panther")
                                .resizable()
                                .border(Color.white, width: self.posters["black-panther"]! ? 10 : 0)
                                .aspectRatio(contentMode: .fill)
                                .onTapGesture {
                                    self.handleTapGesture(movie: "black-panther")
                            }
                            
                            Image("birds")
                                .resizable()
                                .border(Color.white, width: self.posters["birds"]! ? 10 : 0)
                                .aspectRatio(contentMode: .fill)
                                .onTapGesture {
                                    self.handleTapGesture(movie: "birds")
                            }
                        }
                    }.padding()
                    
                    
                    Button("Add Movie") {
                        
                        // save the movie
                        self.saveMovie()

                    }
                    .padding(8)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .cornerRadius(8)
                    
                }.padding()
                    .background(Color.black)
                
                
                
            }
                
            .navigationBarTitle("Add Movie")
            .navigationBarItems(trailing: Button("Close") {
                print("closed fired")
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AddMovieView()
    }
}
