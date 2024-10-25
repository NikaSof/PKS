import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
  class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Padding(
          padding: const EdgeInsets.only(top: 92),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 27),
                child: const Text(
                  "Вероника",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat'
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top:22, left: 27),
                child: Text(
                  "+7 (911) 111-11-11",
                  style: TextStyle(
                    color: Color(0xFF898A8D),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top:16, left: 27),
                child: Text(
                  "borovskaya.v.v@edu.mirea.ru",
                  style: TextStyle(
                    color: Color(0xFF898A8D),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10.0),
              child: ListTile(
                leading: Image.asset("lib/assets/Icon1.png", height: 32, width: 32,),
                title: const Text(
                  'Мои заказы',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Montserrat'
                  ),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10.0),
              child: ListTile(
                leading: Image.asset("lib/assets/Icon2.png", height: 32, width: 32),
                title: Text('Медицинские карты',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Montserrat'
                  ),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10.0),
              child: ListTile(
                leading: Image.asset("lib/assets/Icon3.png", height: 32, width: 32),
                title: Text('Мои адреса',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Montserrat'
                  ),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10),
              child: ListTile(
                leading: Image.asset("lib/assets/Icon4.png", height: 32, width: 32),
                title: Text('Настройки',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Montserrat'
                  ),
                ),
                onTap: () {},
              ),
            ),
            ],
          )
          ),
            const Padding(
              padding: const EdgeInsets.only(top: 48),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Ответы на вопросы',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        color: Color(0xff939396),
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Политика конфиденциальности',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            color: Color(0xff939396),
                            fontWeight: FontWeight.w400
                        ),
                      ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Пользовательское соглашение',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            color: Color(0xff939396),
                            fontWeight: FontWeight.w400
                        ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Выход',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            color: Color(0xffFD3535),
                            fontWeight: FontWeight.w400
                        ),
                    ),
                  ),
                ],
              )
            )
          ]

      ),

    );
  }
}
