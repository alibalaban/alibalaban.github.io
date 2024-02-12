// const numbers = [1, 2, 3, 4, 5];
// function toplamBul(numbers) {
//     let sum = 0;

//     for (const number of numbers) {
//       sum += number;
//     }

//     return sum;
//   }

// console.log(numbers);

// for (let i = 1; i <= 100; i++) {
//     // 3 ve 5 in katı
//     if (i % 3 === 0 && i % 5 === 0) {
//       console.log('FizzBuzz');
//     }
//     // 3 ün katı
//     else if (i % 3 === 0) {
//       console.log('Fizz');
//     }
//     // 5 in katı
//     else if (i % 5 === 0) {
//       console.log('Buzz');
//     }
//     // eğer olmazsa sadece sayıyı yazdırıyoruz.
//     else {
//       console.log(i);
//     }
//   }

//   for (let i = 1; i <= 100; i++) {
//     const result =
//       i % 3 === 0 && i % 5 === 0
//         ? 'FizzBuzz'
//         : i % 3 === 0
//         ? 'Fizz'
//         : i % 5 === 0
//         ? 'Buzz'
//         : i;

//     console.log(result);
//   }

// const Ucgen = (kenar1, kenar2, kenar3) => kenar1 + kenar2 > kenar3 && kenar1 + kenar3 > kenar2 && kenar2 + kenar3 > kenar1;

// const kenar1 = Number(prompt("1. Kenar uzunluğu:"));
// const kenar2 = Number(prompt("2. Kenar uzunluğu:"));
// const kenar3 = Number(prompt("3. Kenar uzunluğu:"));

// if (Ucgen(kenar1, kenar2, kenar3)) {
//   console.log("Bu kenar uzunlukları ile üçgen oluşturabilirsiniz.");
// } else {
//   console.log("Bu kenar uzunlukları ile üçgen oluşturamazsınız.");
// }

// const fiyatlar = [100, 250, 249, 500, 50, 89];

// const yeniFiyatlar = fiyatlar.filter(f => f < 250);

// console.log(yeniFiyatlar);

// let salaries = [18000, 13000, 17000, 24000, 18500, 21000, 19300];

// const maasHesapla = salaries
//   .map(salary => salary * 1.1) // %10 zam
//   .filter(salary => salary < 20000) // 20000 altı
//   .map(salary => salary + (20000 - salary)); // Ek ödeme

// const kisiSayisi = maasHesapla.length;

// console.log("Düşük maaş alanlar:", kisiSayisi);

const myArr = [1, 2, 5, 6, 7, 3, 4];

const newArr = myArr;

myArr.sort();
const numArr = newArr.forEach((item, index) => item);
console.log(numArr);


const points = [67, 77, 34, 97, 55, 42];
// Passing score is 65
// Calculate the average of those who passed the course.


const numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
const oddArr =