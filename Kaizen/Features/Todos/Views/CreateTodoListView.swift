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
                    
                    Text(todoVM.currentList?.nombre ?? "Pendientes")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .onTapGesture {
                            todoVM.preModiciarLista()
                        }
                    
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
            
            Button(action:{ todoVM.crearTodo = true },label: {
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
            
        }.sheet(isPresented: $todoVM.crearList){
            AgregarListaView(todoVM: todoVM)
                .interactiveDismissDisabled(true)
                .presentationDetents([.fraction(0.25)])
        }
        .sheet(isPresented: $todoVM.crearTodo){
            AgregarTareaView(todoVM:todoVM)
                .presentationDetents([.fraction(0.15)])
        }
        .onAppear{
            todoVM.crearList = todoVM.isModify ? false : true
        }
    }
}

#Preview {
    @StateObject var router = Router.shared
    @StateObject var todo = TodoHomeViewModel()
    
    CreateTodoListView(todoVM:todo)
        .environmentObject(router)
}
