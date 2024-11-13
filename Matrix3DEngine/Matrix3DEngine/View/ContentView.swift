//
//  ContentView.swift
//  Matrix3DEngine
//
//  Created by Mike Finimento on 13.11.24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var felsAdler: Adler = Adler(energie: 5, lebenspunkte: 3)
    
    var body: some View {
        VStack {
            HStack{
                Button("fliegen"){
                    if felsAdler.getEnergie() > 0{
                        felsAdler.fliegen()
                    }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                Button("schweben"){
                    if felsAdler.getEnergie() > 0{
                        felsAdler.schweben()
                    }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            HStack{
                Button("gehen"){
                    if felsAdler.getEnergie() > 0{
                        felsAdler.gehen()
                    }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                Button("rotieren 90°"){
                    if felsAdler.getEnergie() > 0{
                        felsAdler.drehen()
                    }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            HStack{
                Button("Essen"){
                    felsAdler.essen()
                    print(felsAdler.worldDimension.matrix)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.green)
            }
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<felsAdler.worldDimension.matrix.count, id: \.self) { rowIndex in
                    HStack(spacing: 0) {
                        ForEach(0..<felsAdler.worldDimension.matrix[rowIndex].count, id: \.self) { columnIndex in
                            let value = felsAdler.worldDimension.matrix[rowIndex][columnIndex]
                            let zahl = abs(value) < 0.000001 || abs(value) > 1_000_000
                                ? String(format: "%.2e", value) // wissenschaftliche Notation
                                : String(format: "%.1f", value)  // normale Darstellung
                            let subString = String(value).prefix(6)
                            Text(subString)
                                
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .border(Color.gray)
                        }
                    }
                }
            }
            .padding()
            Text("Energie: \(felsAdler.getEnergie())")
            if felsAdler.getEnergie() < 1{
                Text("Ersteinmal was essen").tint(.red)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
