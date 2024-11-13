//
//  EngineClasses.swift
//  Matrix3DEngine
//
//  Created by Mike Finimento on 13.11.24.
//

import Foundation

class Lebewesen: ObservableObject{
    @Published private var energie: Int
    @Published private var lebenspunkte: Int
    var worldDimension: Matrix3D = Matrix3D()
    var localDimension: Matrix3D = Matrix3D()
    
    init(energie: Int, lebenspunkte: Int){
        self.energie = energie
        self.lebenspunkte = lebenspunkte
    }
    
    func getEnergie() -> Int{
        return energie
    }
    func getLebenspunkte() -> Int{
        return lebenspunkte
    }
    private func setEnergie(energie: Int){
        self.energie = energie
    }
    private func setLebenspunkte(lebenspunkte: Int){
        self.lebenspunkte = lebenspunkte
    }
    
    func essen(){
        setEnergie(energie: getEnergie() + 1)
        print("Das war lecker!")
    }
    func heilen(){
        setLebenspunkte(lebenspunkte: getLebenspunkte() + 1)
    }
    func energieVerbrauchen(anzahl: Int){
        setEnergie(energie: getEnergie() - anzahl)
    }
}

protocol Landwesen: Lebewesen{
    func stehen()
    func gehen()
    func laufen()
}
extension Landwesen{
    func stehen(){
        print("Ich stehe gerade")
    }
    func gehen(){
        print("Ich gehe gerade")
    }
    func laufen(){
        print("Ich laufe gerade")
    }
}

protocol Wasserwesen: Lebewesen{
    func schwimmen()
    func tauchen()
}
extension Wasserwesen{
    func schwimmen(){
        print("Ich schwimme gerade")
    }
    func tauchen(){
        print("Ich tauche gerade")
    }
}

protocol Luftwesen: Lebewesen{
    
    func fliegen()
    func schweben()
    func drehen()
}
extension Luftwesen{
    func fliegen(){
        print("Ich fliege gerade")
        self.worldDimension.translate(dimension: Matrix3D.Dimension.y, units: 1)
        self.worldDimension.translate(dimension: Matrix3D.Dimension.z, units: 1)
        energieVerbrauchen(anzahl: 1)
        
    }
    func schweben(){
        print("Ich schwebe gerade")
        self.worldDimension.translate(dimension: Matrix3D.Dimension.y, units: 1)
        energieVerbrauchen(anzahl: 1)
    }
    
    func drehen(){
        print("Ich drehe mich")
        self.worldDimension.rotate(dimension: Matrix3D.Dimension.y, radians: 90*Double.pi/180)
        energieVerbrauchen(anzahl: 1)
    }
}

class Adler: Lebewesen & Luftwesen & Landwesen{
    func gehen() {
        print("Ich gehe gerade")
        self.worldDimension.translate(dimension: Matrix3D.Dimension.z, units: 1)
        energieVerbrauchen(anzahl: 1)
    }
    
}
