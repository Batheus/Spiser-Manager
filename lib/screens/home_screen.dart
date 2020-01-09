import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:spiser_manager/blocs/orders_bloc.dart';
import 'package:spiser_manager/blocs/user_bloc.dart';
import 'package:spiser_manager/tabs/orders_tab.dart';
import 'package:spiser_manager/tabs/products_tab.dart';
import 'package:spiser_manager/tabs/users_tab.dart';
import 'package:spiser_manager/widgets/edit_category_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController _pageController;
  int _page = 0;

  UserBloc _userBloc;
  OrdersBloc _ordersBloc;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _userBloc = UserBloc();
    _ordersBloc = OrdersBloc();
  }


  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color.fromRGBO(210, 86, 76, 1),
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(color: Colors.white54)
          )
        ),
        child: BottomNavigationBar(
          currentIndex: _page,
          onTap: (p){
            _pageController.animateToPage(
                p,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Clientes")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                title: Text("Pedidos")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                title: Text("Produtos")
            )
          ]
        ),
      ),
      body: SafeArea(
        child: BlocProvider<UserBloc>(
          bloc: _userBloc,
          child: BlocProvider<OrdersBloc>(
            bloc: _ordersBloc,
            child: PageView(
              controller: _pageController,
              onPageChanged: (p){
                setState(() {
                  _page = p;
                });
              },
              children: <Widget>[
                UsersTab(),
                OrdersTab(),
                ProductsTab()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloating(),
    );
  }

  Widget _buildFloating(){
    switch(_page){
      case 0:
        return null;
      case 1:
        return SpeedDial(
          child: Icon(Icons.sort),
          backgroundColor: Color.fromRGBO(210, 86, 76, 1),
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
              child: Icon(Icons.arrow_downward, color: Color.fromRGBO(210, 86, 76, 1),),
              backgroundColor: Colors.white,
              label: "Concluídos Abaixo",
              labelStyle: TextStyle(fontSize: 14),
              onTap: (){
                _ordersBloc.setOrderCriteria(SortCriteria.READY_LAST);
              }
            ),
            SpeedDialChild(
              child: Icon(Icons.arrow_upward, color: Color.fromRGBO(210, 86, 76, 1),),
              backgroundColor: Colors.white,
              label: "Concluídos Acima",
              labelStyle: TextStyle(fontSize: 14),
              onTap: (){
                _ordersBloc.setOrderCriteria(SortCriteria.READY_FIRST);
              }
            )
          ],
        );
      case 2:
        return FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color.fromRGBO(210, 86, 76, 1),
          onPressed: (){
            showDialog(context: context,
                builder: (context) => EditCategoryDialog()
            );
          },
        );
    }
  }
}
