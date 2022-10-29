//
//  AddTodoView.swift
//  Todo App
//
//  Created by Welliton da Conceicao de Araujo on 28/10/22.
//

import SwiftUI

struct AddTodoView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String =  ""
    @State private var priority: String = ""
    
    
    let priorities = ["Alto", "Medio", "Baixo"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
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
                        if self.name != "" {
                            let todo = Todo(context: self.managedObjectContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            
                            do {
                                try self.managedObjectContext.save()
                                print("nova tarefa: \(todo.name ?? ""), proridade: \(todo.priority ?? "")")
                            } catch {
                                print(error)
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Ops!"
                            self.errorMessage = "O campo tarefa é obrigatório."
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
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
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
