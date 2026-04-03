#include <iostream>
#include <vector>
bool input(std::vector<int>& distance, int& planet, int& fuelTank);
int resultFly(std::vector<int> distance, int planet, int fuelTank);
int main(){
	int planet=0, fuelTank=0;
	std::vector<int> distance;
	if(input(distance, planet, fuelTank)){
		std::cout<<resultFly(distance, planet, fuelTank)<<std::endl;
	}
	return 0;
}
bool input(std::vector<int>& distance, int& planet, int& fuelTank){
	int isDone=1;
	if(std::cin>>planet && std::cin>>fuelTank && planet>0 && fuelTank>0){
		for(int i=0;i<planet-1;++i){
			int item=0;
			if(std::cin>>item && item>0){
				distance.push_back(item);
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
		std::cout<<"Введите корректное число планет, объем баков, расстояние между планетами"<<std::endl;
	}
	return isDone;
}
int resultFly(std::vector<int> distance, int planet, int fuelTank){
	int meter=0, isDone=1;
	int fuel=fuelTank, isFuel=1;
	for(int i=0;i<planet-1 && isFuel==1;++i){
		if(distance[i]>fuelTank){
			isFuel=0;
		}
		if(distance[i]>=fuel){
			isDone=0;
		}
		if(distance[i]<=fuel){
			fuel-=distance[i];
		}
		if(distance[i]<=fuelTank && isDone==0 && isFuel==1){
			++meter;
			fuel+=(fuelTank-fuel);
			isDone=1;
			fuel-=distance[i];
		}
	}
	return meter;
}
