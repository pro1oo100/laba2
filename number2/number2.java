import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int[] planet = {0};
        int[] fuelTank = {0};
        List<Integer> distance = new ArrayList<>();

        if (input(scanner, distance, planet, fuelTank)) {
            System.out.println(resultFly(distance, planet[0], fuelTank[0]));
        }
        scanner.close();
    }

    public static boolean input(Scanner scanner, List<Integer> distance, int[] planet, int[] fuelTank) {
        boolean isDone = true;
        if (scanner.hasNextInt()) {
            int p = scanner.nextInt();
            if (scanner.hasNextInt()) {
                int f = scanner.nextInt();
                if (p > 0 && f > 0) {
                    planet[0] = p;
                    fuelTank[0] = f;
                    for (int i = 0; i < p - 1; ++i) {
                        if (scanner.hasNextInt()) {
                            int item = scanner.nextInt();
                            if (item > 0) {
                                distance.add(item);
                            } else {
                                isDone = false;
                            }
                        } else {
                            isDone = false;
                        }
                    }
                } else {
                    isDone = false;
                }
            } else {
                isDone = false;
            }
        } else {
            isDone = false;
        }

        if (!isDone) {
            System.out.println("Введите корректное число планет, объем баков, расстояние между планетами");
        }
        return isDone;
    }

    public static int resultFly(List<Integer> distance, int planet, int fuelTank) {
        int meter = 0;
        int isDone = 1;
        int fuel = fuelTank;
        int isFuel = 1;

        for (int i = 0; i < planet - 1 && isFuel == 1; ++i) {
            int dist = distance.get(i);
            if (dist > fuelTank) {
                isFuel = 0;
            }
            if (dist >= fuel) {
                isDone = 0;
            }
            if (dist <= fuel) {
                fuel -= dist;
            }
            if (dist <= fuelTank && isDone == 0 && isFuel == 1) {
                ++meter;
                fuel += (fuelTank - fuel);
                isDone = 1;
                fuel -= dist;
            }
        }
        return meter;
    }
}
