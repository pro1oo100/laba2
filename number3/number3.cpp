#include <iostream>
#include <vector>
bool input(int& amount, std::vector<int>& numbers);
void palindrome(int amount, std::vector<int> numbers);
int main(){
	int amount=0;
	std::vector<int> numbers;
	if(input(amount, numbers)){
		palindrome(amount, numbers);
	}
	return 0;
}
bool input(int & amount, std::vector<int>& numbers){
	int isDone=1;
	if(std::cin>>amount && amount>-1){
		for(int i=0;i<amount;++i){
			int x;
			if(std::cin>>x && x>0){
				numbers.push_back(x);
			}
			else{
				isDone=0;
			}
		}
	}
	else{
		isDone=0;
	}
	if(isDone==0){
		std::cout<<"Введите коректное количество чисел, числа должны быть положительные"<<std::endl;
	}
	return isDone;
}
void palindrome(int amount, std::vector<int> numbers){
	int number=0, unit=0, tens=0, hung=0;
	for(int i=0; i<amount;++i){
		if(numbers[i]>99 && numbers[i]<1000){
			unit=numbers[i]%10;
			tens=numbers[i]%100-unit;
			hung=numbers[i]%1000-tens-unit;
			number=(unit*100)+(tens)+(hung/100);
			if(number==numbers[i]){
				std::cout<<"Yes ";
			}
			else{
				std::cout<<"No ";
			}
		}
		else{
			std::cout<<"- ";
		}
	}
	std::cout<<std::endl;
}
