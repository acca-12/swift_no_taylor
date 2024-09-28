//
//  ContentView.swift
//  SwiftDataTest
//
//  Created by Alfonso Acosta on 2024-09-22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}
//swift automatically takes care of writing and storing permanent changes to storage with @Bindable
//recall the difference b/t binding and bindable
//Binding - designed to let us read and write some external piece of data created else where like an @State from a parent view
//Bindable = allows us to get bindings from ANY property in an @Observable object

//if for some reason you want to clear everything from your modelContext you can use
//try? modelContext.delete(model: Class.self) which says to remove all instance of type Class


//In the last Project, we went over how to sort the query
//we can also make custom queries using predicates

/*@Query(filter: #Predicate<User> { user in
  user.name.contains("R")
}, sort: \User.name) var users: [User]
*/

// #Predicate<User> just means we're writing a predicate
// This then gives as a single user instance to check our conditions on and adds it to our result
// localizedStandardContains() ignores casing (contains is case-sensitive)


//How do we filter according to user input??

//Step one: Make a seperate view for whatever you are listing out
//Step two: You mark the list of objects to be filered with @Query This means marking the view with modelContainer
//Step three: We need to somehow pass the info in from the user, so we will use an initialier for the User view to mark it with custome filters
//Specifically with: how we want to filter it and the array of SortDescriptors, we can attach .tag to a picker for sorting techniques and specify our sortOrder

//Menu UI allows you to create menus in the nav bar, and place bittons, pickers, and more inside

// Swift allows us to create models that reference each other

//This means deleting certain model objects can create hanging references
//if we want to recursively delete the references first we need to do it with an @Relationship macro, so if we want to delete the job as well as the owner we can use .cascade for job


//can also sync with cloudkit
#Preview {
    ContentView()
}
