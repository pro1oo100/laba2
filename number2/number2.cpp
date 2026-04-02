#include <iostream>
#include <vector>
void input(std::vector<int>& distance, int& planet, int& fuelTank);
int resultFly(std::vector<int> distance, int planet, int fuelTank);
int main(){
	int planet=0, fuelTank=0;
	std::vector<int> distance;
	input(distance, planet, fuelTank);
	std::cout<<resultFly(distance, planet, fuelTank);
	return 0;
}
void input(std::vector<int>& distance, int& planet, int& fuelTank){
	if(std::cin>>planet && std::cin>>fuelTank && planet>0 && fuelTank>0){
		for(int i=0;i<planet-1;++i){
			int item=0;
			std::cin>>item;
			distance.push_back(item);
		}
	}
	else{
		std::cout<<"Введите корректное число планет и объем баков";
	}
}
int resultFly(std::vector<int> distance, int planet, int fuelTank){
	int meter=0, isDone=1;
	int fuel=fuelTank, isFuel=1;
	for(int i=0;i<planet-1 && isFuel==1;++i){
		if(distance[i]>fuelTank){
			isFuel=0;
		}
		if(distance[i]>fuel){
			isDone=0;
		}
		if(distance[i]<fuel){
			fuel-=distance[i];
		}
		if(distance[i]<fuel+(fuelTank-fuel) && isDone==0 && isFuel==1){
			++meter;
			fuel+=(fuelTank-fuel);
			isDone=1;
		}
                if(distance[i]<fuel){
			fuel-=distance[i];
                  }
	}
	return meter;
}
