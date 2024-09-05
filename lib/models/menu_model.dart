class MenuModel {
  final String text;

  MenuModel({required this.text});
}

class MenuItems {
  static List<MenuModel> items = [editItem, deleteItem];
  static final deleteItem = MenuModel(text: 'Delete');
  static final editItem = MenuModel(text: 'Edit');
}
