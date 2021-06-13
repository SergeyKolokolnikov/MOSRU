//
//  MainModuleDelegate.swift
//  City of discoveries
//
//  Created by Sergey Kolokolnikov on 6/12/21.
//  Copyright © 2021 Bellmobile. All rights reserved.
//

import Foundation

protocol MainModuleDelegate {
    func getCountAction() -> Int
    func getItem(_ index: Int) -> Action
    func setRange(_ index: Int)

    func getCountActionsSpeech() -> Int
    func startSpeech()
    func getItemSpeech(_ index: Int) -> Action
    func removeItemSpeech(_ index: Int)

    func getFilter() -> String

    func recognizeHandler()
    func shuffleActions()

    func setDateFoRange(_ value: Date)
    func getDayFoRange() -> Day?
    func getDaysForChoose() -> [Day]
}
