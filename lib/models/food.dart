class Food {
String? thName;
String? eName;
String? foodvalue;
int? price;



Food(this.thName, this.eName,this.foodvalue, this.price );


static List<Food>getFood(){
  return[
    Food('Pizza', 'พิซซ่า','Pizza', 59),
    Food('Steak', 'สเต็ก','Steak', 59),
    Food('Salad', 'สลัด','Salad', 59),
    Food('Shabu', 'ชาบู','Shabu', 59),
  ];
}

}