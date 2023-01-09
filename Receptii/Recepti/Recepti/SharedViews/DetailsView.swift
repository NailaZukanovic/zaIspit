//
//  DetailsView.swift
//  Recepti
//
//  Created by MacLab6 on 5.11.22..
//

import SwiftUI

struct DetailsView: View {
    @StateObject var viewModel = DetailsViewModel()
    var mealId: String
    var body: some View {
        ScrollView{
            VStack{
                if let details = viewModel.details{
                    AsyncImage(url: URL(string:details.strMealThumb)){
                        image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    Text(details.strMeal).font(.title)
                    Text("Ingredients").font(.title2).padding()
                    ForEach(details.ingredients, id: \.self.name){
                        ingredient in
                        VStack(alignment: .leading){
                            Text("\(ingredient.name) \(ingredient.measure)").padding(.leading)
                            Divider()
                        }
                    }
                    Text("Instructions").font(.title2)
                    ForEach(details.strInstructions, id: \.self){ instruction in
                        VStack(alignment: .center) {
                            Image(systemName: "arrow.down.circle").resizable().scaledToFit().frame(width: 32, height: 32)
                            Text(instruction).font(.body).multilineTextAlignment(.center).padding()
                        }
                    }
                    
                }
            }.onAppear{
                viewModel.fetchDetails(mealId: mealId)
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
      DetailsView(mealId: "52772")
        
    }
}
