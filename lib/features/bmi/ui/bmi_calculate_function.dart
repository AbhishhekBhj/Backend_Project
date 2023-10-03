class BMICalculations {
  static List<dynamic> calculateBMI(double weight, double height) {
    var bmi, bmiCategory;

    if (weight > 0 && height > 0) {
      bmi = weight / (height * height);

      if (bmi < 18.5) {
        bmiCategory = 'Underweight';
      } else if (bmi >= 18.5 && bmi < 25) {
        bmiCategory = 'Normal';
      } else if (bmi >= 25 && bmi < 30) {
        bmiCategory = 'Overweight';
      } else {
        bmiCategory = 'Obese';
      }

      return [bmi, bmiCategory];
    }
    return [0];
  }
}
