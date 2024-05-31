class Menupackage {

List<Details> details;


String label;
String imageUrl;
Menupackage(this.label, this.imageUrl,this.details);

static List<Menupackage> samples = [
 Menupackage(
          'Fusion Package', 'assets/images/fusion.png',
          [
              Details('This includes main dishes like Plain Rice, Onion Rice, Chicken Sambal,'
              'Crispy Soy Garlic Honey Chicken, Pineapple Prawn Curry, '
              'Thai Chili Lemongrass Shrimp With Sweet Basil And Lime, and more '
              'From RM50.00pax')
              
          ],
 ),
 Menupackage(
        'Western Package','assets/images/western.png',
 [
      Details( 'This includes main dishes like Chicken Salami Spaghetti Aglio Olio,'
       'Garlic Butter Shrimp Pasta, Chicken Piccata with Caper Sauce,'
     'Chicken Chop with Black Pepper Honey Sauce, and more. '
     'From RM50.00pax')
 ],
 ),
 Menupackage(
        'Thai Package', 'assets/images/thai.png',
          [
              Details('This includes main dishes like Chicken Salami Spaghetti Aglio Olio,' 
              'Garlic Butter Shrimp Pasta, Chicken Piccata with Caper Sauce, '
              'Chicken Chop with Black Pepper Honey Sauce, and more.'
              '\nPrice per pax: RM50.00')
          ],
 ),
];




}

class Details {

String name;
Details(this.name);
}




