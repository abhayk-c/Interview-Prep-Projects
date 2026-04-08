//
//  Animals.swift
//  AccessControlFun
//
//  Created by Abhay Curam on 5/16/25.
//

import Foundation

private class Animal
{
    fileprivate class Organism {
        func description() {
            print("Organism")
        }
    }
    
    private let organism = Organism()
    
    private func description() {
        print("Animal")
        organism.description()
    }
}

private class Dog
{
    let animal = Animal()
    let organism = Animal.Organism()
    
    private func description() {
        print("Animal")
        print("Dog")
    }
}
