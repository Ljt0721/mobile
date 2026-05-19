class Contact {
  Contact({required this.name, required this.image, required this.phoneNumber});

  final String name;
  final String image;
  final String phoneNumber;

  static List<Contact> getAllContacts() {
    List<Contact> contacts = [];

    contacts.add(
      Contact(
        name: 'James',
        image: 'Assets Chap 4/people-1.jpg',
        phoneNumber: '+1221155667',
      ),
    );

    contacts.add(
      Contact(
        name: 'Mary',
        image: 'Assets Chap 4/people-2.jpg',
        phoneNumber: '+3351155637',
      ),
    );

    contacts.add(
      Contact(
        name: 'Harris',
        image: 'Assets Chap 4/people-3.jpg',
        phoneNumber: '+3351188858',
      ),
    );

    contacts.add(
      Contact(
        name: 'Jacky',
        image: 'Assets Chap 4/people-4.jpg',
        phoneNumber: '+9987788835',
      ),
    );

    contacts.add(
      Contact(
        name: 'Hugo',
        image: 'Assets Chap 4/people-5.jpg',
        phoneNumber: '+2266998881',
      ),
    );

    return contacts;
  }
}
