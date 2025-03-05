//
//  MockJSONResponse.swift
//  EnvoyCoffeeTests
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation

struct MockJSONResponse: Encodable {
   static let venueSearchSuccess = """
{
          "results": [
            {
              "fsq_id": "592f142acf72a063b395cb43",
              "categories": [
                {
                  "id": 13034,
                  "name": "Café",
                  "short_name": "Café",
                  "plural_name": "Cafés",
                  "icon": {
                    "prefix": "https://ss3.4sqi.net/img/categories_v2/food/cafe_",
                    "suffix": ".png"
                  }
                }
              ],
              "distance": 942,
              "location": {
                "address": "189 N Michigan Ave",
                "formatted_address": "189 N Michigan Ave, Chicago, IL 60601",
                "locality": "Chicago",
                "postcode": "60601",
                "region": "IL",
                "country": "US"
              },
              "name": "Nutella Cafe"
            },
            {
              "fsq_id": "553977b7498eb9779dcb0592",
              "categories": [
                {
                  "id": 13002,
                  "name": "Bakery",
                  "short_name": "Bakery",
                  "plural_name": "Bakeries",
                  "icon": {
                    "prefix": "https://ss3.4sqi.net/img/categories_v2/food/bakery_",
                    "suffix": ".png"
                  }
                }
              ],
              "distance": 468,
              "location": {
                "address": "33 S Wabash Ave",
                "formatted_address": "33 S Wabash Ave, Chicago, IL 60603",
                "locality": "Chicago",
                "postcode": "60603",
                "region": "IL",
                "country": "US"
              },
              "name": "Goddess and the Baker"
            }
          ],
          "context": {
            "geo_bounds": {
              "circle": {
                "center": {
                  "latitude": 37.7777,
                  "longitude": -122.3952
                },
                "radius": 1000
              }
            }
          }
        }
"""
}

