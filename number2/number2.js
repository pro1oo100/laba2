const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

let tokens = [];
let tokenIndex = 0;

rl.on('line', (line) => {
    const numbers = line.trim().split(/\s+/).map(Number);
    tokens.push(...numbers);
});

rl.on('close', () => {
    main();
});

function nextInt() {
    if (tokenIndex < tokens.length) {
        return tokens[tokenIndex++];
    }
    return NaN;
}

function input(distance, planetRef, fuelTankRef) {
    let isDone = 1;
    const planet = nextInt();
    const fuelTank = nextInt();

    if (!isNaN(planet) && !isNaN(fuelTank) && planet > 0 && fuelTank > 0) {
        planetRef.value = planet;
        fuelTankRef.value = fuelTank;

        for (let i = 0; i < planet - 1; ++i) {
            const item = nextInt();
            if (!isNaN(item) && item > 0) {
                distance.push(item);
            } else {
                isDone = 0;
            }
        }
    } else {
        isDone = 0;
    }

    if (isDone === 0) {
        console.log("Введите корректное число планет, объем баков, расстояние между планетами");
    }
    return isDone;
}

function resultFly(distance, planet, fuelTank) {
    let meter = 0, isDone = 1;
    let fuel = fuelTank, isFuel = 1;

    for (let i = 0; i < planet - 1 && isFuel === 1; ++i) {
        if (distance[i] > fuelTank) {
            isFuel = 0;
        }
        if (distance[i] >= fuel) {
            isDone = 0;
        }
        if (distance[i] <= fuel) {
            fuel -= distance[i];
        }
        if (distance[i] <= fuelTank && isDone === 0 && isFuel === 1) {
            ++meter;
            fuel += (fuelTank - fuel);
            isDone = 1;
            fuel -= distance[i];
        }
    }
    return meter;
}

function main() {
    let distance = [];
    let planetRef = { value: 0 };
    let fuelRef = { value: 0 };

    if (input(distance, planetRef, fuelRef) === 1) {
        console.log(resultFly(distance, planetRef.value, fuelRef.value));
    }
    rl.close();
}
