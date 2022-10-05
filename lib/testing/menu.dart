
import 'package:flutter/material.dart';

List dataList = [
  {
    "name": "Sales",
    "icon": Icons.payment,
    "subMenu": [
      {"name": "Orders"},
      {"name": "Invoices"}
    ]
  },
  {
    "name": "Marketing",
    "icon": Icons.volume_up,
    "subMenu": [
      {
        "name": "Promotions",
        "subMenu": [
          {"name": "Catalog Price Rule"},
          {"name": "Cart Price Rules"}
        ]
      },
      {
        "name": "Communications",
        "subMenu": [
          {"name": "Newsletter Subscribers"}
        ]
      },
      {
        "name": "SEO & Search",
        "subMenu": [
          {"name": "Search Terms"},
          {"name": "Search Synonyms"}
        ]
      },
      {
        "name": "User Content",
        "subMenu": [
          {"name": "All Reviews"},
          {"name": "Pending Reviews"}
        ]
      }
    ]
  }
];