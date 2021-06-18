//
//  PostCard.swift
//  GenericDrugFromBrandName
//
//  Created by Abdullah Ridwan on 6/13/21.
//

import SwiftUI

struct PostCard: View {
    var post : Post
    
    var body: some View {
        HStack {
            Image(systemName: "pills").foregroundColor(.red)
            VStack(alignment: .leading){
                Text(post.term.lowercased())
                Text("Total Number of Records: \(post.count)").font(.subheadline)
            }
            Spacer()
        }
        
    }
    
    
}

struct PostCard_Previews: PreviewProvider {
    static var previews: some View {
        PostCard(post: Post(term: "FAKE TERMS", count: 0))
    }
}
