//
//  CompanyItemViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 09/08/23.
//

import Foundation

class CompanyItemViewModel {
    
    var data: Manufacturer?
    
    init(data: Manufacturer? = nil) {
        self.data = data
    }
    
    var companyLogo: String {
        return data?.logo_url ?? ""
    }
    
    var companyName: String {
        return data?.name ?? ""
    }
    
    var companyDescription: String {
        return data?.description ?? ""
    }
    
    var totalLaunches: Int {
        return data?.total_launch_count ?? 0
    }
    
    var foundingYear: String {
        return data?.founding_year ?? ""
    }
    
    var failedLaunches: Int {
        return data?.failed_launches ?? 0
    }
    
    var successLaunches: Int {
        return data?.successful_launches ?? 0
    }
    
    var wikiURL: String {
        return data?.wiki_url ?? ""
    }
}
