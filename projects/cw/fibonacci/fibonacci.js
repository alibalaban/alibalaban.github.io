// let n = +prompt("Enter the value of n:");

// if (n === 1) {
//   console.log(n === 2);
// } else if (n === 2) {
//   console.log("0, 1");
// } else {
//   let n1 = 0,
//     n2 = 1;
//   let output = "0, 1";
//   for (let i = 3; i <= n; i++) {
//     let nextTerm = n1 + n2;
//     output += ", " + nextTerm;
//     n1 = n2;
//     n2 = nextTerm;
//   }
//   console.log("The first " + n + " Fibonacci numbers are: " + output);
// }

function reverseWordsWithoutArray(sentence) {
  let reversedSentence = "";
  let word = "";
  for (let i = sentence.length - 1; i >= 0; i--) {
    if (sentence[i] === " " || i === 0) {
      //Append the word (in reverse) to the result
      if (i === 0) {
        word += sentence[i]; //Include the first character of the first word
      }

      for (let j = word.length - 1; j >= 0; j--) {
        reversedSentence += word[j];
      }

      // If not the last word, add a space
      if (i != 0) {
        reversedSentence += " ";
      }
      //Reset the temporary word
      word = "";
    } else {
      //Build the word
      word += sentence[i];
    }
  }
  return reversedSentence;
}
//Test the function
const inputSentence = "merhaba dunya";
const sonSentence = reverseWordsWithoutArray(inputSentence);
console.log(sonSentence); // Output: "World Hello"
