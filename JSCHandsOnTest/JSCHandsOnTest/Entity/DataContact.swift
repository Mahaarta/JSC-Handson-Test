//
//  DataContact.swift
//  JSCHandsOnTest
//
//  Created by Minata Mahaarta on 26/01/21.
//

import Foundation
import ObjectMapper

class DataContact: Mappable {
    
    var gender = ""
    var name_title = ""
    var name_first = ""
    var name_last = ""
    var location_street_number = 0
    var location_street_name = ""
    var location_city = ""
    var location_state = ""
    var location_country = ""
    var location_postcode = 0
    var coordinates_latitude = ""
    var coordinates_longitude = ""
    var timezone_offset = ""
    var timezone_description = ""
    var email = ""
    var dob_date = ""
    var dob_age = 0
    var phone = ""
    var cell = ""
    var id_name = ""
    var id_value = ""
    var picture_thumbnail = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        gender <- map["gender"]
        name_title <- map["name.title"]
        name_first <- map["name.first"]
        name_last <- map["name.last"]
        location_street_number <- map["location.street.number"]
        location_street_name <- map["location.street.name"]
        location_city <- map["location.city"]
        location_state <- map["location.state"]
        location_country <- map["location.country"]
        location_postcode <- map["location.postcode"]
        coordinates_latitude <- map["location.coordinates.latitude"]
        coordinates_longitude <- map["location.coordinates.longitude"]
        timezone_offset <- map["location.timezone.offset"]
        timezone_description <- map["location.timezone.description"]
        email <- map["email"]
        dob_date <- map["dob.date"]
        dob_age <- map["dob.age"]
        phone <- map["phone"]
        cell <- map["cell"]
        id_name <- map["id.name"]
        id_value <- map["id.value"]
        picture_thumbnail <- map["picture.thumbnail"]
    }
}

class DataContactList: Mappable {
    
    var currentPage = 0
    var from = 0
    var lastPage = 0
    var perPage = 0
    var to = 0
    var total = 0
    var arrDataContact: [DataContact] = []
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        currentPage <- map["meta.current_page"]
        from <- map["meta.from"]
        lastPage <- map["meta.last_page"]
        perPage <- map["meta.per_page"]
        to <- map["meta.to"]
        total <- map["meta.total"]
        arrDataContact <- map["results"]
    }
}
