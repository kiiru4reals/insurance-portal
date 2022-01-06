class Clients {
  final String firstName;
  final String lastName;
  final int age;

  const Clients({
    required this.firstName,
    required this.lastName,
    required this.age,
  });

  Clients copy({
    String? firstName,
    String? lastName,
    int? age,
  }) =>
      Clients(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        age: age ?? this.age,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Clients &&
              runtimeType == other.runtimeType &&
              firstName == other.firstName &&
              lastName == other.lastName &&
              age == other.age;

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode ^ age.hashCode;
}


final allUsers = <Clients>[
  Clients(firstName: 'Emma', lastName: 'Field', age: 37),
  Clients(firstName: 'Max', lastName: 'Stone', age: 27),
  Clients(firstName: 'Sarah', lastName: 'Winter', age: 20),
  Clients(firstName: 'James', lastName: 'Summer', age: 21),
  Clients(firstName: 'Lorita', lastName: 'Wilcher', age: 18),
  Clients(firstName: 'Anton', lastName: 'Wilbur', age: 32),
  Clients(firstName: 'Salina', lastName: 'Monsour', age: 24),
  Clients(firstName: 'Sunday', lastName: 'Salem', age: 42),
  Clients(firstName: 'Alva', lastName: 'Cowen', age: 47),
  Clients(firstName: 'Jonah', lastName: 'Lintz', age: 18),
  Clients(firstName: 'Kimberley', lastName: 'Kelson', age: 33),
  Clients(firstName: 'Waldo', lastName: 'Cybart', age: 19),
  Clients(firstName: 'Garret', lastName: 'Hoffmann', age: 27),
  Clients(firstName: 'Margaret', lastName: 'Yarger', age: 25),
  Clients(firstName: 'Foster', lastName: 'Lamp', age: 53),
  Clients(firstName: 'Samuel', lastName: 'Testa', age: 58),
  Clients(firstName: 'Sam', lastName: 'Schug', age: 44),
  Clients(firstName: 'Alise', lastName: 'Bryden', age: 41),
];