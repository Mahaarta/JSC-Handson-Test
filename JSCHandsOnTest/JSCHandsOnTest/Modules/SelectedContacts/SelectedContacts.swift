//
//  SelectedContacts.swift
//  JSCHandsOnTest
//
//  Created by Minata Mahaarta on 26/01/21.
//

import Foundation

class SelectedContacts {
    var gender = ""
    var name_title = ""
    var name_first = ""
    var name_last = ""
    var location_street_number = 0
    var location_street_name = ""
    var location_city = ""
    var location_state = ""
    var location_country = ""
    var location_postcode = ""
    var coordinates_latitude = ""
    var coordinates_longitude = ""
    var email = ""
    var dob_date = ""
    var profile_thumbnail = ""
    var cell = ""
    var phone = ""
    
    init(
        gender: String,
        name_title: String,
        name_first: String,
        name_last: String,
        location_street_number: Int,
        location_street_name: String,
        location_city: String,
        location_state: String,
        location_country: String,
        profile_thumbnail: String,
        email: String,
        cell: String,
        phone: String
        
    ) {
        self.gender = gender
        self.name_title = name_title
        self.name_first = name_first
        self.name_last = name_last
        self.location_street_number = location_street_number
        self.location_street_name = location_street_name
        self.location_city = location_city
        self.location_state = location_state
        self.location_country = location_country
        self.profile_thumbnail = profile_thumbnail
        self.email = email
        self.cell = cell
        self.phone = phone
        
        
    }
}
