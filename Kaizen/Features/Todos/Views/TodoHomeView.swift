//
//  TodoHomeView.swift
//  Kaizen App
//
//  Created by Lettuce, Gaona & KodKode on 30/03/26.
//

import SwiftUI
import Combine

struct TodoHomeView: View {
    
    @EnvironmentObject private var router : Router
    
    @ObservedObject private var vmTodoHome : TodoHomeViewModel = TodoHomeViewModel()
    
    let gridItems = [GridItem(.flexible())]
    
    let bgColor:Color = .beige
    
    let fgColorText:Color = .black
    
    let bgColorButtonCrear:Color = .bruguer
    
    var body: some View{
        ZStack(alignment: .bottomTrailing){
            bgColor
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                
                HStack{
                    VStack(alignment:.leading){

                        Text("Ahmed Garcia")
                    }
                    .font(.system(size:25).bold())
                    .foregroundColor(fgColorText)
                    
                    Spacer()
                
                    ZStack {
                        Circle()
                            .fill(Color.cyan)
                            .frame(width: 48, height: 48)
                        
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 20, height: 28)
                    }
                    
                    Image("company_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                }
                
//                HStack{
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.gray)
//                        .padding(.leading)
//                    
//                    TextField("Buscar categoria",text: $vmTodoHome.categoria)
//                    Spacer()
//                    Image(systemName: "slider.horizontal.3")
//                        .foregroundColor(.gray)
//                        .padding(.trailing)
//                }
//                .frame(maxWidth: .infinity,maxHeight: 40)
//                .clipShape(Rectangle())
//                .background(.white)
//                .cornerRadius(10)
                
                Text("Listas")
                    .font(.system(size:20))
                    .foregroundColor(fgColorText)
                    .bold()
                
                if vmTodoHome.listas.isEmpty{
                    
                    VStack{
                        Image(systemName: "tree")
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(width: 150,height: 150)
                         
                         Text("""
                             Todavia no hay ninguna lista de tareas.
                             Pulsa + para empezar a planificar tus tareas
                             """)
                         .multilineTextAlignment(.center)
                         .frame(maxWidth: .infinity)
                    }
                }else{
                    ScrollView(.horizontal){
                        LazyHStack(spacing:20){
                            ForEach(vmTodoHome.listas, id: \.self) { lista in
                                CardListaView(lista: lista)
                            }
                        }
                    }
                    .frame(height:150)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 48)
            
            Button(action:{ router.navigate(to: .createAndModifyToDo) },label: {
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 15,height: 15)
                    .foregroundColor(.white)
                    .padding()
            })
            .clipShape(Circle())
            .background(bgColorButtonCrear)
            .cornerRadius(10)
            .padding()
        }
    }
}

#Preview {
    TodoHomeView()
}
