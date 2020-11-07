class clr_palette {
  int chk_color1(Gender x) {
    if (x == Gender.Male) {
      return (0XFF43AA8B);
    }
    return 0xFF39FF14;
  }

  int chk_color2(Gender x) {
    if (x == Gender.Female) {
      return (0XFF43AA8B);
    }
    return 0xFF39FF14;
  }

  int weight_counter({int counter, int x = 0, int y = 0}) {
    if (x == 1) {
      if (counter < 130) {
        return counter + 1;
      } else {
        return 130;
      }
    }
    if (y == 1) {
      if (counter > 1)
        return counter - 1;
      else
        return 1;
    }
  }

  int age_counter({int age, int w = 0, int z = 0}) {
    if (w == 1) {
      if (age > 2) {
        return age - 1;
      }
    }
    if (z == 1) {
      if (age < 110) {
        return age + 1;
      }
    }
  }
}

enum Gender { Male, Female }
