//
//  AgregarMejoraView.swift
//  Kaizen
//
//  Created by Desarrollo on 06/04/26.
//

import SwiftUI

enum Nivel:String,CaseIterable,Identifiable{
    
    var id:String { self.rawValue }
    case bajo = "Bajo"
    case medio = "Medio"
    case alto = "Alto"
        
    var color:String{
        switch self {
        case .bajo: return "#4CAF50"
        case .medio: return "#FFA500"
        case .alto: return "#FF4D4D"
        }
    }
}

struct AgregarMejoraView:View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var todoVM:TodoHomeViewModel
    @FocusState var focus:Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                TextField("Agregar mejora", text: $todoVM.descripcion)
                    .focused($focus)
                Button(action:{
                    if let mejora = todoVM.mejoraActual {
                        todoVM.modificarMejora(mejora:mejora)
                    }else{
                        todoVM.agregarMejora()
                    }
                },label:{
                    Image(systemName: "arrowtriangle.up.square.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25,height: 25)
                })
                .disabled(todoVM.descripcion.isEmpty)
            }
            Divider()
            Picker("Nivel de prioridad",selection: $todoVM.seleccionado){
                ForEach(Nivel.allCases) { nivel in
                    Text(nivel.rawValue).tag(nivel)
                }
            }.pickerStyle(.palette)
//            ScrollView(.horizontal,showsIndicators: false){
//                HStack(spacing:20){
//                    ButtonTextImage(text: "Definir fecha de vencimiento", image: "calendar")
//                    ButtonTextImage(text: "Recordarme", image: "bell")
//                    ButtonTextImage(text: "Repetir", image: "repeat")
//                }
//            }
//            Spacer()
        }
        .onAppear{
            focus = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .background(.white)
    }
}

#Preview {
    @State var todoVM:TodoHomeViewModel = TodoHomeViewModel()
    AgregarMejoraView(todoVM: todoVM)
}
