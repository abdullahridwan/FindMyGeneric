//
//  ContentView.swift
//  Shared
//
//  Created by Abdullah Ridwan on 6/13/21.
//

import SwiftUI

struct ContentView: View {
    @State var completeLoadFromApi = CompleteLoad(meta: Meta(disclaimer: "none", terms: "non", license: "none", last_updated: "none") , results: [Post(term: "0", count: 0)])
    
    @State var brandMedicationName: String = "Advil"
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                HStack {
                    Spacer()
                    Image(systemName: "magnifyingglass.circle").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        ///.padding()
                    TextField("Input Brand Name Medication", text: $brandMedicationName)
                    Spacer()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                //.padding(.bottom)
                List(completeLoadFromApi.results){postItem in
                    PostCard(post: postItem)
                }
                .navigationTitle(Text("Generics For \(brandMedicationName)"))
            }
        }
        .onChange(of: brandMedicationName, perform: { value in
            
            API().getPosts(item: brandMedicationName){ completeLoadFromApi in
                print(completeLoadFromApi)
                self.completeLoadFromApi = completeLoadFromApi
            }
            
            
        })

            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
