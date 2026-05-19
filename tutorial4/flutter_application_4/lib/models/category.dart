import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    required this.color,
    required this.imagePath,
    required this.rating,
    required this.foodName,
    required this.description,
  });

  final String id;
  final String title;
  final Color color;
  final String imagePath;
  final double rating;
  final String foodName;
  final String description;

  static List<Category> getAllCategories() {
    return const [
      Category(
        id: 'c1',
        title: 'Italian',
        color: Colors.purple,
        imagePath: 'Assets - Chap 5/italian.jpg',
        rating: 4.5,
        foodName: 'Lasagna',
        description:
            'Lasagna is a traditional Italian dish made by stacking layers of pasta sheets with rich meat or vegetable sauce, creamy bechamel, and cheese. It is then baked to create a flavorful and comforting meal.',
      ),
      Category(
        id: 'c2',
        title: 'French',
        color: Colors.amber,
        imagePath: 'Assets - Chap 5/french.jpg',
        rating: 4.3,
        foodName: 'Quiche',
        description:
            'Quiche is a savory French tart made with a pastry crust filled with eggs, milk or cream, cheese, meat, seafood, or vegetables. Popular versions include Quiche Lorraine with bacon and cheese.',
      ),
      Category(
        id: 'c3',
        title: 'Chinese',
        color: Colors.blue,
        imagePath: 'Assets - Chap 5/chinese.jpg',
        rating: 4.4,
        foodName: 'Dumplings',
        description:
            'Chinese dumplings are soft dough parcels filled with a mixture of meat, vegetables, or seafood. They can be boiled, steamed, or fried, and are a popular dish served during festivals and family gatherings.',
      ),
      Category(
        id: 'c4',
        title: 'Indian',
        color: Colors.green,
        imagePath: 'Assets - Chap 5/indian.jpg',
        rating: 4.7,
        foodName: 'Pani Puri',
        description:
            'Pani Puri is a beloved Indian street food consisting of hollow, crispy puris filled with spicy tangy water, mashed potatoes, chickpeas, and chutneys. It delivers a burst of flavors in every bite.',
      ),
      Category(
        id: 'c5',
        title: 'Korean',
        color: Colors.pink,
        imagePath: 'Assets - Chap 5/korean.jpg',
        rating: 4.6,
        foodName: 'Tteokbokki',
        description:
            'Tteokbokki is a popular Korean dish made from chewy rice cakes cooked in a spicy, sweet gochujang chili paste sauce. It is commonly served with fish cakes and boiled eggs.',
      ),
      Category(
        id: 'c6',
        title: 'Mexican',
        color: Colors.teal,
        imagePath: 'Assets - Chap 5/mexican.jpg',
        rating: 4.5,
        foodName: 'Burrito',
        description:
            'A burrito is a Mexican dish consisting of a flour tortilla wrapped around fillings such as rice, beans, meat, cheese, and vegetables. It is usually served warm and can be eaten on the go.',
      ),
    ];
  }
}
