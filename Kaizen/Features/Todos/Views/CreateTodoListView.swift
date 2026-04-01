//
//  CreateTodoListView.swift
//  ToDoList
//
//  Created by Desarrollo on 31/03/26.
//

import SwiftUI

struct CreateTodoListView: View {
    @EnvironmentObject var router:Router
    @ObservedObject var todoVM:TodoHomeViewModel
    @State var crearList = true
    @State var crearTodo = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            
            Color(todoVM.currentColor)
                .ignoresSafeArea()
            
            VStack(spacing:20){
                HStack{
                    if todoVM.currentList != nil{
                        BackButtonView(action: {
                            todoVM.defaultView()
                        })
                    }
                    
                    Text(todoVM.currentList?.nombre ?? "")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    
                    Spacer()
                }
                
                LazyVStack{
                    ForEach(todoVM.currentList?.todos ?? [], id: \.self) { todo in
                        CardSmallView(todoVM:todoVM ,todo: todo)
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
            CrearListaTareaView(todoVM: todoVM, currentColor:$todoVM.currentColor)
                .interactiveDismissDisabled(true)
                .presentationDetents([.fraction(0.25)])
        }
        .sheet(isPresented: $crearTodo){
            CrearTareaView(todoVM:todoVM)
                .presentationDetents([.fraction(0.15)])
        }
        .onAppear{
            crearList = todoVM.isModify ? false : true
        }
    }
}

//#Preview {
//    @StateObject var router = Router.shared
//    @StateObject var todo = TodoHomeViewModel()
//    
//    CreateTodoListView(todoVM:todo)
//        .environmentObject(router)
//}
