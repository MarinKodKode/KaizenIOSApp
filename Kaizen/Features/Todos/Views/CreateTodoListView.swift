//
//  CreateTodoListView.swift
//  ToDoList
//
//  Created by Desarrollo on 31/03/26.
//

import SwiftUI

struct CreateTodoListView: View {
    @EnvironmentObject var router:Router
    @EnvironmentObject var vmTodoHome:TodoHomeViewModel
    @State var crearList = true
    @State var crearTodo = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            
            Color(vmTodoHome.currentColor.color)
                .opacity(vmTodoHome.currentColor.isOpacity ? 0.5 : 1)
                .ignoresSafeArea()
            
            VStack(spacing:20){
                HStack{
                    if vmTodoHome.currentList != nil{
                        BackButtonView(action: {
                            vmTodoHome.defaultView()
                        })
                    }
                    
                    Text(vmTodoHome.currentList?.nombre ?? "")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    
                    Spacer()
                }
                
                LazyVStack{
                    ForEach(vmTodoHome.currentList?.todos ?? [], id: \.self) { todo in
                        CardSmallView(todoName:todo.todoName)
                    }
                }
                
                Spacer()
            }.frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
            
            Button(action:{ crearTodo = true },label: {
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 15,height: 15)
                    .foregroundColor(.white)
                    .padding()
            })
            .clipShape(Circle())
            .background(.bruguer)
            .cornerRadius(10)
            .padding()
            
        }.sheet(isPresented: $crearList){
            CrearListaTareaView(currentColor:$vmTodoHome.currentColor)
                .interactiveDismissDisabled(true)
                .presentationDetents([.fraction(0.25)])
        }
        .sheet(isPresented: $crearTodo){
            CrearTareaView()
                .presentationDetents([.fraction(0.15)])
        }
        .onAppear{
            crearList = vmTodoHome.isModify ? false : true
        }
    }
}

#Preview {
    @StateObject var router = Router.shared
    @StateObject var todo = TodoHomeViewModel()
    
    CreateTodoListView()
        .environmentObject(router)
        .environmentObject(todo)
}
