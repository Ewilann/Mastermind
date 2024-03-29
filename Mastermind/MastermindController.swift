//
//  main.swift
//  Mastermind
//
//  Created by Maxime Duguet on 20/06/2019.
//  Copyright © 2019 Maxime Duguet. All rights reserved.
//

import Foundation

class MastermindController {
    
    // Couleurs : Jaune, Bleu, Rouge, Vert, Blanc, Noir
    private let colorList : [String] = ["yellow", "blue", "red", "green", "white", "black"]
    //combinaison à trouver
    private var combination : [String] = []
    // 10 essaies possibles
    private var countTry : Int = 0
    
    func getCombination() -> [String] {
        return combination
    }
    
    func setCombination(colorList: [String]) {
        self.combination = colorList.map({$0.lowercased()})
    }
    
    // Fonction qui va créer la combinaison
    func generateRandomCombination(length: Int) {
        //clean la combinaison courante
        self.combination.removeAll()
        //ajoute de nouvelles couleurs suivant le nombre souhaité
        for _ in 0...length-1 {
            self.combination.append(self.colorList[Int.random(in: 0...self.colorList.count-1)])
        }
        
        print("Combinaison à trouver :"+combination.joined())
    }
    
    //Fonction qui va comparer la combinaison proposé avec celle demandé
    func evaluate (newCombination : [String]) -> [Int] {
        
        if self.combination.count != newCombination.count {
            print("le nombre de couleurs des combinaisons est différente")
            return [-1,-1]
        }
        
        var wellplaced: Int = 0
        var misplaced: Int = 0
        
        //vérifie les couleurs bien placées
        for i in 0...self.combination.count-1 {
            if newCombination[i].lowercased() == self.combination[i]  {
                wellplaced += 1
            }
        }
        
        //Couleur unique vérifiée
        var colorUniqueArray: [String] = []
        
        //comparaison entre la combinaison proposé et la principale
        for color in self.combination {
            if !colorUniqueArray.contains(color) {
                colorUniqueArray.append(color)
                let colorCountInNewCombi = newCombination.map({$0.lowercased()}).filter({$0 == color}).count
                let colorCountInCombi = self.combination.filter({$0 == color}).count
                
                //la combinaison proprosée possède un compteur plus élevé de la couleur que celle initiale
                if colorCountInNewCombi > colorCountInCombi {
                    //on ajoute alors le nombre maximal dans la combinaison initale
                    misplaced += colorCountInCombi
                }
                else {
                    //Sinon on ajoute le nombre dans la combinaison proposée
                    misplaced += colorCountInNewCombi
                }
            }
        }
        
        //on retire le compteur de couleurs bien placées à celui des mals placées pour éviter de compter leurs couleus 2 fois
        return [wellplaced,misplaced-wellplaced]
    }
    
}
