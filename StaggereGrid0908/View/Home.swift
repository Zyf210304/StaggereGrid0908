//
//  Home.swift
//  StaggereGrid0908
//
//  Created by 张亚飞 on 2021/9/8.
//

import SwiftUI

struct Home: View {
    
    @State var posts: [Post] = []
    
    //to show dynamic...
    @State var columns: Int = 3
    
    //smooth hero effect...
    @Namespace var  animation
    
    var body: some View {
        
        NavigationView {
            
            StaggeredGrid(columns: columns,list: posts, content: { post in
                
                //PostCardView
                PostCardView(post: post)
                    .matchedGeometryEffect(id: post.id, in: animation)
                    .onAppear {
                        
                        print(post.imageURL)
                    }
            })
                .padding(.horizontal)
            .navigationTitle("Staggered Grid")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        columns += 1
                    } label: {
                        
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        columns = max(columns - 1, 1)
                    } label: {
                        
                        Image(systemName: "minus")
                    }
                }
            }
            .animation(.easeInOut, value: columns)
        }
        .onAppear {
            
            for index in 1...10 {
                
                posts.append(Post(imageURL: "p\(index)"))
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// since wo declared T as Identifiable...
// so we need to pass Idenfiable conform collection/Array...


struct PostCardView: View {
    
    var post: Post
    var body: some View {
        
        Image(post.imageURL)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
    }
}
