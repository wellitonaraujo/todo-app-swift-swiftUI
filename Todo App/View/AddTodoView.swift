//
//  AddTodoView.swift
//  Todo App
//
//  Created by Welliton da Conceicao de Araujo on 28/10/22.
//

import SwiftUI

struct AddTodoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String =  ""
    @State private var priority: String = ""
    
    
    let priorities = ["Alto", "Medio", "Baixo"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Tarefa", text: $name)
                    
                    Picker("Prioridades", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button(action: {
                        print("Salvou")
                    }) {
                        Text("Salvar")
                    }
                        
                }
            }
            .navigationBarTitle("Nova Tarefa", displayMode: .inline)
            .navigationBarItems(trailing:
              Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
            }
            )
        }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
