//
//  MockCommsListPresenter.swift
//  IosSummerProjectTests
//
//  Created by Akash Mair on 22/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
@testable import IosSummerProject

class MockCommsListPresenter: CommsListPresenterProtocol {
    func didTapComm(with id: Int) {
        
    }
    
    var didTapAddCommsCount = 0
    
    
    func didTapAddComms() {
        didTapAddCommsCount += 1
    }
    
    func loadData() {
//        let articles = [
//                   Article(title: "First post", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceNow: 86400), highlighted: true, image: "https://picsum.photos/200"),
//                   Article(title: "Second post", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: false, image: "https://picsum.photos/200"),
//                   Article(title: "Second post", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: true, image: "https://picsum.photos/200"),
//                   Article(title: "Second post", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 86400), highlighted: false, image: "https://picsum.photos/200"),
//                   Article(title: "Second post", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 67833), highlighted: true, image: "https://picsum.photos/200"),
//                   Article(title: "Second post", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 90000), highlighted: false, image: "https://picsum.photos/200"),
//                   Article(title: "Second post", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(), highlighted: false, image: "https://picsum.photos/200")
//               ]
    }
}
