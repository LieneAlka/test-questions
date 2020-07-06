import Foundation

/****
 2. Write a function to find the longest common prefix from string array (function should take string as parameter and return a string).
 For example, input could be [“market”, “maxima”, “mama”], then longest common prefix would be “ma”.
 Another example - [“sale”, “safe”, “sun”], then result would be “s”.
 If there is no common prefix return an empty string.
 ***/

func longestCommonPrefix(words: [String]) -> String {
  return ""
}


/****
3. In given a sentence return last words length (characters count). For example “Today is sunny” - answer is 5, because “sunny” has 5 letters.
Write a function that takes a string as parameter and returns number.
***/

func lastWordsLength(sentence: String) -> Int {
  var byWord: [String] = []
  let range = sentence.startIndex ..< sentence.endIndex
  
  //To get string by words into String array, I use Foundation library's function enumerateSubstrings
  sentence.enumerateSubstrings(in: range, options: .byWords) { w,_,_,_ in
    guard let word = w else { return }
    byWord.append(word)
  }
  
  if let lastWord = byWord.last {
    return lastWord.count
  }
  return 0
}



/****
4. Write a function, that takes an array of Int’s and returns filtered array without duplicates. You can not use Set.
An example: Input - [1,1,3,4,5,5], output - [1,3,4,5]
***/

func filterArray(numbers: [Int]) -> [Int] {
  var filteredArray: [Int] = []
  var counter = 0 //Use counter to check if I have looked into all filtered array's item
  
  if let first = numbers.first {
    filteredArray.append(first)
  }
  
  for itemA in numbers {
    counter = 0
    for itemB in filteredArray {
      counter += 1
      if itemA == itemB { break }
      if counter == filteredArray.count { //if counter is as much as filtered array item count, that means that itemA is not duplicate
        filteredArray.append(itemA)
      }
    }
  }
  return filteredArray
}


3


/****
5. Write a function excel sheet column converter, that takes String as a parameter and
returns a number of the column. Some examples:
A -> 1
B -> 2
C -> 3
Z -> 26
AA -> 27
AB-> 28
****/
  



