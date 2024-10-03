import 'package:flutter/material.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: BMICalculatorHome());
  }
}

enum Gender { male, female } // Enum pentru selecția de gen: Masculin și Feminin

class BMICalculatorHome extends StatefulWidget {
  @override
  _BMICalculatorHomeState createState() => _BMICalculatorHomeState();
}

class _BMICalculatorHomeState extends State<BMICalculatorHome> {
  double weight = 70,
      height = 0,
      bmi = 0; // Variabile pentru greutate, înălțime și calculul BMI
  int age = 23; // Variabilă pentru vârstă
  String status = "Underweight"; // Variabilă pentru statusul BMI-ului
  Gender selectedGender = Gender.male;

  // Funcție pentru calcularea BMI-ului
  void calculateBMI() {
    if (height > 0) {
      setState(() {
        bmi = weight /
            ((height / 100) *
                (height / 100)); // Formula BMI: greutate / înălțime^2
        status = (bmi < 18.5)
            ? "Underweight"
            : (bmi < 24.9)
                ? "Normal"
                : (bmi < 29.9)
                    ? "Overweight"
                    : "Obese";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDCE0E8),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text("Welcome 😊",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold)), // Text de bun venit
            SizedBox(height: 5),
            Text("BMI Calculator",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold)), // Titlu pentru calculatorul de BMI
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      // Buton pentru selecția de gen Masculin
                      CustomButton(
                        label: "Male",
                        icon: Icons.male,
                        isSelected: selectedGender == Gender.male,
                        onTap: () =>
                            setState(() => selectedGender = Gender.male),
                      ),
                      SizedBox(width: 15),
                      // Buton pentru selecția de gen Feminin
                      CustomButton(
                        label: "Female",
                        icon: Icons.female,
                        isSelected: selectedGender == Gender.female,
                        onTap: () =>
                            setState(() => selectedGender = Gender.female),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      // Componentă pentru greutate, cu butoane de + și -
                      LabeledValueChanger(
                        label: "Weight",
                        value: weight,
                        onAdd: () => setState(() => weight++),
                        onRemove: () => setState(() => weight--),
                      ),
                      SizedBox(width: 15),
                      // Componentă pentru vârstă, cu butoane de + și -
                      LabeledValueChanger(
                        label: "Age",
                        value: age.toDouble(),
                        onAdd: () => setState(() => age++),
                        onRemove: () => setState(() => age--),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Text pentru înălțime
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Height",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Câmp pentru introducerea înălțimii
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          onChanged: (value) => setState(
                              () => height = double.tryParse(value) ?? 0),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Height",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Rezultatul calculului BMI și statusul
                  Center(
                    child: Column(
                      children: [
                        Text(bmi.toStringAsFixed(1),
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3A6FFF))),
                        Text(status,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3A6FFF))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Buton pentru calcularea BMI
            GestureDetector(
              onTap: calculateBMI,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: Color(0xFF3A6FFF),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text("Let's Go",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String? label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomButton({
    this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: isSelected
                ? Color(0xFF3A6FFF)
                : Colors
                    .white, // Fundal alb pentru buton inactiv, fundal albastru când este selectat
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: isSelected
                      ? Colors.white
                      : Color(
                          0xFF3A6FFF)), // Iconiță albă pentru butonul selectat, albastră pentru cel inactiv
              if (label != null) ...[
                SizedBox(width: 5),
                Text(
                  label!,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Color(
                            0xFF3A6FFF), // Text alb pentru butonul selectat, albastru pentru cel inactiv
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Widget reutilizabil pentru schimbarea valorilor greutății și vârstei
class LabeledValueChanger extends StatelessWidget {
  final String label;
  final double value;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const LabeledValueChanger({
    required this.label,
    required this.value,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey)), // Etichetă pentru greutate sau vârstă
            SizedBox(height: 5),
            Text(value.toStringAsFixed(0),
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold)), // Afișează valoarea curentă
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Buton pentru micșorarea valorii
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF3A6FFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.remove, color: Colors.white, size: 30),
                  ),
                ),
                // Buton pentru mărirea valorii
                GestureDetector(
                  onTap: onAdd,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF3A6FFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.add, color: Colors.white, size: 30),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
