//
//  CategoriesScreenView.swift
//  Recepti
//
//  Created by Digital Atrium on 2.1.23..
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct CategoriesScreenView: View {
    @StateObject var wm = CategoriesViewModel()
    @State var searchText = ""
    var filteredCategories:[Category]{
        if(searchText.isEmpty){
            return wm.categories
        }
        else
        {
            return wm.categories.filter{
                $0.strCategory.contains(searchText) || $0.strCategoryDescription.contains(searchText)
            }
        }
    }
    var body: some View {
        List{
            ForEach(
                filteredCategories, id: \.self.idCategory
            ){ category in
                NavigationLink(destination: RecepiesView(category: category)){
                    CategoryListItemView(category: category)
                }
            }
        
        }.navigationTitle("Recipes Categories")
            .searchable(text: $searchText)
            .navigationBarItems(
                leading: NavigationLink(destination: MapView(), label: {
                    Text("Restoraunts")
                }),
                trailing: Button(action: {
                    let firebaseAuth = Auth.auth()
                    do {
                      try firebaseAuth.signOut()
                    } catch let signOutError as NSError {
                      print("Error signing out: %@", signOutError)
                    }
                }, label: {
                    Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                })
            )
    }
}

struct CategoriesScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesScreenView()
    }
}
