#include <iostream>
#include <cmath>
int simpleNumber(int number);
bool isSimple(int number);
int main(){
	int number=0;
	if(std::cin>>number && number>1){
	if (isSimple(number)){
	std::cout<<0;
	}
	else{
	std::cout<<simpleNumber(number);
	}}
	else{
	std::cout<<"Введите число ,которое больше 1";
	}
	return 0;
}
bool isSimple(int number){
         int left=number, resultLeft=0;
         for (;left>1 && resultLeft==0;--left){
                 int isDone=1;
                 for(int i=2;i*i<left+1 && isDone==1;++i){
                         if (left%i==0){
                                 isDone=0;
			 }
		 }
                          if(isDone==1){
                          resultLeft=left;
                  }
          }
	return resultLeft==number?true:false;
}
int simpleNumber(int number){
	int left=number, right=number, resultLeft=0, resultRight=0;
	if(number<2){
	resultLeft=abs(2-number);
	}
	for (;left>1 && resultLeft==0;--left){
		int isDone=1;
		for(int i=2;i*i<left + 1 && isDone==1;++i){
			if (left%i==0){
				isDone=0;
			}
		}
			if(isDone==1){
			resultLeft=abs(left-number);
		}
	}
	while(resultRight==0){
		int isDone=1;
		for(int i=2;i*i<right + 1 && isDone==1;++i){
			if (right%i==0){
				isDone=0;
			}
		}
		if(isDone==1){
			resultRight=abs(right-number);
		}
	++right;
		}
	return resultLeft<resultRight?resultLeft:resultRight;
}
