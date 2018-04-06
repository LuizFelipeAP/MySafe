//
//  UserTests.swift
//  MySafeTests
//
//  Created by Luiz Felipe Albernaz Pio on 06/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Quick
import Nimble

@testable import MySafe

class UserTests: QuickSpec {
    
    override func spec() {
        
        describe("testing User model") {
            context("equality") {
                
                //Arrange common User
                let firstUser: User = User(name: "Mark Wahlberg",
                                       username: "markw",
                                       passcode: "**********")
                
                
                it("should match") {

                    //Arrange specific User
                    let matchingUser: User = User(name: "Mark Wahlberg",
                                                  username: "markw",
                                                  passcode: "**********")

                    //Act
                    let isEqual: Bool = firstUser == matchingUser
                    
                    //Assert
                    expect(isEqual) == true
                }
                
                it("should not match") {
                    
                    //Arrange specific non matching user
                    let notMatchingUser: User = User(name: "Mark Wahlberg",
                                                      username: "MW",
                                                      passcode: "**********")
                    
                    let isEqual: Bool = firstUser == notMatchingUser
                    
                    expect(isEqual) == false
                }
            }
        }
    }
}
            /*
            context("parsing data returned from server") {
                it("should return a couple of movies") {
                    
                    //Arrange
                    let m1 = Movie()
                    let m2 = Movie(id: 1, title: "Iron Man 2")
                    
                    let dict = ["results": [m1, m2]]
                    
                    let data = try! JSONEncoder().encode(dict)
                    
                    //Act
                    let parsedMovies = viewModel.parseMoviesData(from: data)
                    
                    //Assert
                    expect(parsedMovies.contains(m1)) == true
                    expect(parsedMovies.contains(m2)) == true
                }
            }
            
            context("filtering movies by text") {
                it("should only contains members matching") {
                    //Arrange
                    let m1 = Movie(title: "Get Out")
                    let m2 = Movie(title: "Rounders")
                    viewModel.movies.accept([m1, m2])
                    
                    //Act
                    viewModel.filter(by: "Get")
                    
                    //Assert
                    expect(viewModel.filteredMovies.value.count).to(equal(1))
                    expect(viewModel.filteredMovies.value.contains(m1)) == true
                }
            }
            
            context("check if movie is favorite") {
                it("should evalute to true") {
                    
                    //Arrange
                    let m1 = Movie(favorite: false)
                    
                    viewModel.favoriteManager.addFavorite(m1)
                    
                    //Act
                    viewModel.mapFavoriteFor(m1)
                    
                    //Assert
                    expect(m1.favorite).to(equal(true))
                }
            }
        }
 
    }
}
 */
