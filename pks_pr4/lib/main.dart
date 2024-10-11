import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Боровская В.В. ЭФБО-03-22',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductListScreen(),
    );
  }
}

class Product {
  final String name;
  final String price;
  final String discountPrice;
  final String imageUrl;
  final List<String> description;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    this.discountPrice = '',
  });
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [
    Product(
      name: 'Polaroid SuperColor',
      price: '9 990 ₽',
      discountPrice: '6 990 ₽',
      imageUrl: 'https://pola-store.ru/32-7228-thickbox/polaroid-supercolor.jpg',
      description: [
        'Polaroid SuperColor - имеет более острые углы и радужную полоску на передней панели, за что получила название "Радуга". Пленочная фотокамера для моментальной фотографии, производилась компанией Polaroid примерно в то же время, что и знакомая всем 636 Close Up.',
        'Данные фотокамеры предназначались для самого широкого круга пользователей, простота и легкость в эксплуатации позволяла получать снимки, не будучи фотографом и не обладая знаниями в области фотографии. Особым достоинством, было и то, что отпадала необходимость в лабораторной обработке плёнки, а также печати в фотолаборатории. Достаточно было просто нажать на кнопку и получить моментальную красочную фотографию.',
        'Именно на эти камеры были сделаны в 90-ые все те снимки, которые мы так хорошо помним из детства.Произведена в Великобритании.',
        'В комплекте: фотоаппарат, инструкция на русском, гарантия на 6 мес., крафтовая коробка. Кассеты в комплект не входят.',
        'Polaroid выпускал несколько идентичных моделей в данном цветовом варианте. На лицевой панели фотоаппарата может быть нанесено название Spirit 600, Lightmixer 600, LM, LMS и прочие, этот тот же самый фотоаппарат, надпись на лицевой панели может варьироваться.',
        'Обратите внимание, что это винтажные фотокамеры, выпуска 90-х годов. Полностью проверенные нами на работоспособность. Состояние оптики: идеальное. Состояние автоматики: идеальное. Состояние механики: идеальное. Внешнее состояние корпуса: возможны незначительные потертости соразмерные времени.'
      ],
    ),
    Product(
      name: 'EuroShop PC-606',
      price: '1 490 ₽',
      imageUrl: 'https://pola-store.ru/1458-13117-thickbox/euroshop-pc-606-plenochnyj-fotoapparat.jpg',
      description: [
        'EuroShop PC-606 многоразовая пленочная 35-миллиметровая камера без вспышки.',
        'Новый пленочный фотоаппарат в заводской упаковке.',
        'Фиксированная фокусировка.',
        'Объектив 38 мм, F/5,6 (1 элемент).',
        'Расстояние фокусировки от 1,5 м до бесконечности.',
        'Фотоаппарат работает без батареек и имеет разъем под вспышку.',
        'Ручная перемотка и продвижение пленки.',
        'Счетчик кадров на верхней панели.',
        'Размер: 50 х 130 х 70 мм, Вес: 128 гр.',
        'Для получения лучших результатов при фотографировании, рекомендуется снимать при достаточном количестве естественного света, идеальные условия для съемки «улица - солнечный день».',
        'Что входит в комплект: новая фотокамера EuroShop PC-606, ремешок на руку, инструкция, гарантийный талон, коробка.'
      ],
    ),
    Product(
      name: 'FujiFilm Instax Wide',
      price: '44 990 ₽',
      imageUrl: 'https://pola-store.ru/1171-6121-thickbox/fujifilm-instax-wide-300-toffee-bolshoj-kadr-.jpg',
      description: [
        'Обновленная версия Instax WIDE в новом цвете "Toffee" (ириска). Фотоаппарат оснащен гнездом под штатив, что делает возможным студийную фотосъемку, имеет усовершенствованный объектив (f=95mm, 1:14), наводить фокус можно с помощью поворота фокусировочного кольца, за счет продуманной конструкции ручки фотокамеру стало гораздо удобнее держать в руке.',
        'Размер кадра Instax 300 Toffee составляет 8 на 10 см (самый большой размер фото в современной моментальной фотографии). Кадр 8 на 10 см - идеальный размер для групповых и свадебных фото, для съемки пейзажей и архитектуры. Встроенная автовспышка позволит получить резкое контрастное изображение практически в любых условиях освещенности. Имеется также вариативная заполняющая вспышка, для дополнительного освещения объектов на фотографии.',
        'Модель Toffee (ириска) имеет функцию корректировки экспозиции: кадр можно осветлять или затемнять по мере необходимости. Два режима съемки с фокусным расстояние от 1 м до 3 м и от 3 м до бесконечности. В комплекте с фотокамерой прилагается макролинза, которая позволит делать качественные снимки на расстоянии 30-50 см до объекта съемки.',
        'Из приятных новшеств можно также отметить вынесенный на заднюю панель фотокамеры LCD-дисплей, который отображает текущие настройки экспозиции и количество оставшихся кадров. Внимания заслуживает и оптический видоискатель серьезно доработанный компанией Fujifilm, он наконец-то стал показывать реальное положение объекта, тогда как у предыдущей модели был смещен влево.',
        'Кому подойдет фотоаппарат: как основная камера фотографу-любителю, как дополнительная камера фотографу-профессионалу, идеальный вариант для свадебной фотосъемки (снимки можно сразу отдать гостям или вклеить в книгу пожеланий).',
        'Комплектация: фотоаппарат Instax 300, инструкция на русском, гарантия 12 мес., макро-линза, ремешок, 4 батарейки AA, коробка.'],
    ),
    Product(
      name: 'Instax Square SQ40',
      price: '27 990 ₽',
      imageUrl: 'https://pola-store.ru/2197-13512-thickbox/instax-square-sq40-kvadratnyj-kadr-.jpg',
      description: [
        'Instax Square SQ40 — суперстильная камера мгновенной печати с черной текстурированной отделкой, которая выглядит так же хорошо, как и снимает. Instax хотел добавить ощущение аналоговой фотографии, чтобы вы выглядели вне времени.',
        'Кроме того, делая SQ40 удивительно универсальным, он всегда готов к любым вашим творческим начинаниям. Просто поверните, чтобы включить, поверните, чтобы войти в режим селфи, и поверните, чтобы выключить. Ничего более сложного, ничто не мешает сделать снимок до того, как момент уйдет.',
        'Квадратный формат 1:1 передает красоту каждого момента, так что вы можете сохранить эти воспоминания на всю жизнь. Размер снимка 86 мм х 72 мм, размер изображения 62 мм × 62 мм.',
        'С автоматической экспозицией выразить свои творческие способности действительно не может быть проще, независимо от того, находитесь ли вы за камерой или кадрируете себя в зеркале для селфи, готовясь к крупному плану. Просто наведите и щёлкните, а Instax SQ40 сделает всё остальное.',
        'Когда вы закончите фотографировать, включите instax UP! Здесь вы найдете оригинальный способ хранить все свои фотографии instax в цифровом виде в одном месте. Просто отсканируйте свои отпечатки с помощью телефона, чтобы превратить их в цифровые снимки, которыми можно делиться, которые вы можете точно настроить, пометить и сохранить.',
        'Технические характеристики: размеры 134,2 × 120,2 × 60,5 мм, вес 453 г (без батареек, ремешка и пленки), работает на пленка instax SQUARE 86 мм x 72 мм (в комплект не входит), видоискатель обратного Галилея, 0,4x, с целевым пятном, объектив 2 компонента, 2 элемента, f = 65,75 мм, 1:12,6, программируемый электронный затвор с выдержкой от 1/2 до 1/400 с, медленная синхронизация для слабого освещения, постоянная вспышка (автоматическая регулировка освещения), время перезарядки: 7,5 секунд или менее (при использовании новых батарей), эффективная дальность действия вспышки: от 0,3 до 2,2 м, режимы съемки: стандартный, режим селфи, диапазон съемки: 0,3 м и более (используйте режим «Селфи» для 0,3–0,5 м), питание от 2 шт батареи (CR2).',
        'В комплекте: фотокамера мгновенной печати Fujifilm Instax Square SQ40 (черная), ремешок для камеры, 2 батарейки CR2, инструкция по применению.',
        'К фотокамере подойдут специальные картриджи Instax Square квадратного размера.',
        'Вы можете купить фотоаппарат моментальной печати Instax Square SQ40 с квадратным размером кадра в черном цвете по доступной цене в магазине Pola STORE на Новой Басманной или оформить заказ через сайт с доставкой, цена на сайте и в магазине одинаковая на все представленные товары.'],
    ),
    Product(
      name: 'Fujifilm Instax wide 300',
      price: '29 990 ₽',
      imageUrl: 'https://pola-store.ru/196-6120-thickbox/fujifilm-instax-wide-300-bolshoj-kadr.jpg',
      description: [
        'Обновленная версия Instax WIDE с большим размером кадра. Фотоаппарат оснащен гнездом под штатив, что делает возможным студийную фотосъемку, имеет усовершенствованный объектив (f=95mm, 1:14), наводить фокус можно с помощью поворота фокусировочного кольца, за счет продуманной конструкции ручки фотокамеру стало гораздо удобнее держать в руке.',
        'Размер кадра Instax Wide 300 составляет 8 на 10 см (самый большой размер фото в современной моментальной фотографии). Кадр 8 на 10 см - идеальный размер для групповых и свадебных фото, для съемки пейзажей и архитектуры. Встроенная автовспышка позволит получить резкое контрастное изображение практически в любых условиях освещенности. Имеется также вариативная заполняющая вспышка, для дополнительного освещения объектов на фотографии.',
        'Fuji Instax Wide 300 имеет функцию корректировки экспозиции: кадр можно осветлять или затемнять по мере необходимости. Два режима съемки с фокусным расстояние от 1 м до 3 м и от 3 м до бесконечности. В комплекте с фотокамерой прилагается макролинза, которая позволит делать качественные снимки на расстоянии 30-50 см до объекта съемки.',
        'Из приятных новшеств можно также отметить вынесенный на заднюю панель фотокамеры LCD-дисплей, который отображает текущие настройки экспозиции и количество оставшихся кадров. Внимания заслуживает и оптический видоискатель серьезно доработанный компанией Fujifilm, он наконец-то стал показывать реальное положение объекта, тогда как у предыдущей модели был смещен влево.',
        'Кому подойдет фотоаппарат: как основная камера фотографу-любителю, как дополнительная камера фотографу-профессионалу, идеальный вариант для свадебной фотосъемки (снимки можно сразу отдать гостям или вклеить в книгу пожеланий).',
        'Комплектация: фотоаппарат Instax 300, инструкция на русском, гарантия 12 мес., макро-линза, ремешок, 4 батарейки AA, коробка.'],
    ),
    Product(
      name: 'Instax mini Evo Brown гибридный',
      price: '44 990 ₽',
      discountPrice: '39 990 ₽',
      imageUrl: 'https://pola-store.ru/2196-13504-thickbox/instax-mini-evo-brown.jpg',
      description: [
        'Уникальная гибридная фотокамера в ретро-дизайне, с большим экраном и впечатляющими возможностями печати Instax Evo Brown - флагман нового поколения фотоаппаратов моментальной печати.',
        'Инструмент мгновенного творчества: делитесь прекрасными моментами жизни с INSTAX MINI EVO от FUJIFILM. Эта инновационная гибридная камера мгновенной печати имеет 10 эффектов объектива и 10 эффектов пленки, что дает вам 100 различных способов мгновенного создания собственных уникальных фотографий размером 5 x 9 сантиметров. Вы можете экспериментировать с яркими цветами, добавлять мягкость к фокусу, регулировать экспозицию, изменить баланс белого и даже выбрать режим макросъемки, когда ситуация требует крупного плана.',
        'Гибридный дизайн камеры и печать на картриджах формата INSTAX MINI: гибридная камера мгновенной печати сочетает в себе удобное создание цифровых изображений с традиционным мгновенным выводом на пленку. Этот метод позволяет свободно снимать и печатать в любое время или перепечатывать изображение столько раз, сколько необходимо.',
        'Фиксированный объектив с фокусным расстоянием, эквивалентным 28 мм, обеспечивает универсальную широкоугольную перспективу, а диафрагма f/2 хорошо подходит для работы в различных условиях освещения. Объектив также имеет минимальное расстояние фокусировки 3,9 дюйма для работы с крупным планом.Встроенная перезаряжаемая литий-ионная батарея используется для питания камеры и поддерживает печать до 100 изображений на одном заряде. Камеру можно зарядить через USB примерно за 2-3 часа. Внутренняя память вмещает приблизительно 45 фотографий, а слот для карт памяти microSD/SDHC можно использовать для увеличения объема памяти.',
        'Ретро-дизайн: на корпусе, похожем на классический фотоаппарат, имеется ряд циферблатов и рычагов, которые делают творческий процесс тактильным и интуитивно понятным. Рычаг печати: подобно рычагу продвижения пленки, потяните этот рычаг, чтобы мгновенно распечатать выбранную фотографию. Шестеренка пленки: как заводная ручка, поверните эту ручку, чтобы переключаться между различными эффектами пленки. Кольцо объектива: можно использовать для выбора различных эффектов объектива.',
        'Встроенное зеркало для селфи рядом с объективом помогает создавать идеальные автопортреты. Двойные кнопки спуска затвора на верхней панели и передней панели камеры для портретной и пейзажной съемки. Задний 3,0-дюймовый ЖК-экран с разрешением 460 000 точек для создания композиций в режиме реального времени, навигации по меню и выбора печати. Башмак для аксессуаров можно использовать для крепления сторонних аксессуаров, таких как оптические видоискатели или светодиодные фонари. Также имеется нижнее крепление для штатива 1/4"-20. Встроенная вспышка помогает осветить сцену при работе в условиях низкой освещенности.',
        'Беспроводное подключение и приложение INSTAX MINI EVO: можно использовать для беспроводного дистанционного управления камерой, а также для передачи изображений с MINI EVO на смартфон или для передачи изображений со смартфона на печать. Удаленная съемка: используйте свой смартфон в качестве пульта дистанционного управления и беспроводным способом спускайте затвор камеры из приложения.',
        'Вы можете купить фотоаппарат моментальной печати Fujifilm Instax Evo в магазине Pola STORE онлайн, для этого нажмите на кнопку "В корзину", заполните имя и телефон для оформления заказа. Или приехать в магазин на Новой Басманной. Также вы можете посмотреть фото, узнать характеристики и почитать отзывы покупателей, скачать инструкцию и выбрать все нужные вам аксессуары.'],
    ),
    Product(
      name: 'Product 1',
      price: '',
      imageUrl: 'https://via.placeholder.com/300',
      description: ['This is the description of Product 1.'],
    ),
    Product(
      name: 'Product 1',
      price: '',
      imageUrl: 'https://via.placeholder.com/300',
      description: ['This is the description of Product 1.'],
    ),
    Product(
      name: 'Product 1',
      price: '',
      imageUrl: 'https://via.placeholder.com/300',
      description: ['This is the description of Product 1.'],
    ),
    Product(
      name: 'Product 1',
      price: '',
      discountPrice: '',
      imageUrl: 'https://via.placeholder.com/300',
      description: ['This is the description of Product 1.'],
    ),
    // Add more products as needed
  ];

  void _addProduct() async {
    final newProduct = await showDialog<Product>(
      context: context,
      builder: (context) => AddProductDialog(),
    );
    if (newProduct != null) {
      setState(() {
        products.add(newProduct);
      });
    }
  }

  void _removeProduct(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Удаление'),
        content: Text('Вы точно хотите удалить этот товар?'),
        actions: [
          TextButton(
            child: Text('Нет'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text('Да'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      setState(() {
        products.removeAt(index);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Vintage Click',
            style: TextStyle(
              color: Colors.teal.shade900,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.75,
        ),
        padding: const EdgeInsets.all(8.0),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: products[index]),
                ),
              );
            },
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                          child: Image.network(
                            products[index].imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index].name,
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4.0),
                            products[index].discountPrice.isNotEmpty
                                ? Row(
                              children: [
                                Text(
                                  products[index].price,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    products[index].discountPrice,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Text(
                              products[index].price,
                              style: TextStyle(fontSize: 14.0, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 32, // Adjust the size as needed
                      height: 32, // Adjust the size as needed
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade400, // Gray background
                      ),
                      child: Center(
                        child: IconButton(
                          iconSize: 20, // Adjust the icon size as needed
                          padding: EdgeInsets.zero, // Remove default padding
                          icon: Icon(Icons.delete, color: Colors.black87), // White delete icon
                          onPressed: () {
                            _removeProduct(index);
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        tooltip: 'Add Product',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageUrl),
            SizedBox(height: 16.0),
            Text(
              product.name,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            product.discountPrice.isNotEmpty
                ? Row(
              children: [
                Text(
                  product.price,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    product.discountPrice,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
                : Container(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                product.price,
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
            SizedBox(height: 16.0),
            RichText(
              text: TextSpan(
                children: product.description.map((paragraph) {
                  return TextSpan(
                    text: '$paragraph\n\n',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AddProductDialog extends StatefulWidget {
  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountPriceController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Новый товар'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Название'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Введите название...';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Цена'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Введите цену...';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _discountPriceController,
              decoration: InputDecoration(labelText: 'Цена со скидкой (если есть)'),
            ),
            TextFormField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'URL картинки'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Вставьте url...';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Описание товара'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Опишите товар...';
                }
                return null;
              },
              minLines: 1,
              maxLines: 5,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Отмена'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Добавить'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop(
                Product(
                  name: _nameController.text,
                  price: _priceController.text,
                  discountPrice: _discountPriceController.text,
                  imageUrl: _imageUrlController.text,
                  description: [_descriptionController.text],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}