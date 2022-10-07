// Dose Diária Ideal de Cafeína
// Nome: Luan Vitor Carvalho Valadares

import 'dart:math';

import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget{
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String result = "";

  TextEditingController incomeController = TextEditingController();
  TextEditingController childrenController = TextEditingController();

  bool singleMother = false;
  bool schooled = false;
  bool vaccinated = false;

  String _calculate(){
    double auxilio = 0.0;
    double minimumWage = 1212.0;

    if(schooled == true && vaccinated == true){

      if(double.parse(incomeController.text) <= (2 * minimumWage))
        if(double.parse(incomeController.text) <= minimumWage){
          if(double.parse(childrenController.text) <= 2){
            auxilio = 2.5 * minimumWage;
          }

        }else{
          if(double.parse(childrenController.text) <= 2){
            auxilio = 1.5 * minimumWage;
          }else if(double.parse(childrenController.text) >= 3){
            auxilio = 3 * minimumWage;
          }
        }
    }

    if(singleMother == true){
      auxilio = auxilio + 600;
    }

    if(auxilio == 0){
      return "Você não está em condições de receber um auxílio";
    }else{
      return "Você receberá um auxílio de R\$$auxilio,00";
    }
  }

  void _clean(){
    _formKey = GlobalKey<FormState>();
    incomeController.text = "";
    childrenController.text = "";

    setState((){
      singleMother = false;
      schooled = false;
      vaccinated = false;
      result = "";
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        title: Text("Cálculo do Auxílio", style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 32.0),),
        centerTitle: true,
        backgroundColor: Colors.teal[400],

        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _clean, color: Colors.white)
        ],
      ),

      body: Container(

        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.0),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),

                child: Column(
                    children: <Widget>[
                      Icon(Icons.family_restroom_outlined,
                          size: 160.0, color: Colors.teal[400]),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text("Preencha os campos abaixo de acordo com suas condições familiares \n para verificar o valor do auxílio que irá receber.",
                          textAlign: TextAlign.center, style: TextStyle(color: Colors.teal[400], fontWeight: FontWeight.bold, fontSize: 12.0)),
                      )
                    ]
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(40.0, 20.0, 160.0, 0.0),

                child: TextFormField(keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
                    labelText: "Renda Familiar (R\$)", labelStyle: TextStyle(color: Colors.teal[400], fontWeight: FontWeight.bold, fontSize: 16.0)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.teal[400], fontSize: 16.0),

                  controller: incomeController,
                  validator: (value){
                    if(value.toString().isEmpty){
                      return "Por favor, insira o valor da renda familiar";
                    }else if(double.parse(value.toString()) <= 0 || double.parse(value.toString()) == null){
                      return "Por favor, digite um valor válido";
                    }
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 200.0, 0.0),

                child: CheckboxListTile(
                  title: Text("Mãe solteira como chefe da família", style: TextStyle(color: Colors.teal[400], fontWeight: FontWeight.bold, fontSize: 16.0)),
                  activeColor: Colors.cyan,

                  value: singleMother,
                  onChanged: (bool? value){
                    setState(() {
                      singleMother = value!;
                    });
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(40.0, 0.0, 160.0, 20.0),

                child: TextFormField(keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
                      labelText: "Número de Filhos", labelStyle: TextStyle(color: Colors.teal[400], fontWeight: FontWeight.bold, fontSize: 16.0)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.teal[400], fontSize: 20.0),

                  controller: childrenController,
                  validator: (value){
                    if(value.toString().isEmpty){
                      return "Por favor, insira o número de filhos da família";
                    }else if(double.parse(value.toString()) <= 0 || double.parse(value.toString()) == null){
                      return "Por favor, digite um valor válido";
                    }
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 200.0, 0.0),

                child: CheckboxListTile(
                  title: Text("Todos Escolarizados?", style: TextStyle(color: Colors.teal[400], fontWeight: FontWeight.bold, fontSize: 16.0)),
                  activeColor: Colors.cyan,

                  value: schooled,
                  onChanged: (bool? value){
                    setState(() {
                      schooled = value!;
                    });
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 200.0, 0.0),

                child: CheckboxListTile(
                  title: Text("Todos Vacinados?", style: TextStyle(color: Colors.teal[400], fontWeight: FontWeight.bold, fontSize: 16.0)),
                  activeColor: Colors.cyan,

                  value: vaccinated,
                  onChanged: (bool? value){
                    setState(() {
                      vaccinated = value!;
                    });
                  },
                ),
              ),

              Padding(
                  padding: EdgeInsets.fromLTRB(120.0, 40.0, 120.0, 0.0),

                  child: ElevatedButton(
                    child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 32.0),),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[400]),

                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        setState((){
                          result = _calculate();
                        });
                      }
                    },
                  )
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(120.0, 40.0, 120.0, 0.0),

                child: Text("$result", textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.teal[400], fontWeight: FontWeight.bold),
                ),
              ),

            ],
          ),

        ),
      ),

    );
  }
}