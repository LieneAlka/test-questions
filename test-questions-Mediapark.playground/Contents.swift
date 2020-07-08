import Foundation
import UIKit

/**
1. Demo code
 We have theoretical shop object with working hours for each day. Demo object structure is provided below,
 image if this is the data we received from BE and we have to work with it. “WorkHours” is optional because if it is that means shop is not working that day,
 otherwise we would have some formatted date, like “10:00", “16:30”, etc…
 
 Your main task is to display shops working hours sorted by weekdays and time. If several days in succession have exact same time, those days should be grouped together (Monday-Wednesday in the example below). If shop is closed then instead of time show “Closed” (Friday in the example below).
 
 For example:
    I-III                               IV                            V                              VI-VII
 09:00 - 21:00            10:00 - 21:00               Closed                    09:00 - 21:00
 
 ***/
 
 
struct Shop {
 let name: String
 let adress: String
 let workSchedule: WorkSchedule

 struct WorkSchedule {
   let monday: WorkHours?
   let tuesday: WorkHours?
   let wednesday: WorkHours?
   let thursday: WorkHours?
   let friday: WorkHours?
   let saturay: WorkHours?
   let sunday: WorkHours?
 }

 struct WorkHours {
   let from: String
   let to: String
 }
}

//Generate test data for shop schedule
let shop1 = Shop(name: "Shop Name", adress: "Shop Adress 24",
                workSchedule: Shop.WorkSchedule(monday: Shop.WorkHours(from: "09:00", to: "21:00"),
                                                tuesday: Shop.WorkHours(from: "09:00", to: "21:00"),
                                                wednesday: Shop.WorkHours(from: "09:00", to: "21:00"),
                                                thursday: Shop.WorkHours(from: "10:00", to: "21:00"),
                                                friday: nil,
                                                saturay: Shop.WorkHours(from: "09:00", to: "21:00"),
                                                sunday: Shop.WorkHours(from: "09:00", to: "21:00")))

let shop2 = Shop(name: "Shop Name", adress: "Shop Adress 24",
                 workSchedule: Shop.WorkSchedule(monday: Shop.WorkHours(from: "09:00", to: "21:00"),
                                                 tuesday: Shop.WorkHours(from: "09:00", to: "21:00"),
                                                 wednesday: Shop.WorkHours(from: "09:00", to: "21:00"),
                                                 thursday: Shop.WorkHours(from: "09:00", to: "21:00"),
                                                 friday: Shop.WorkHours(from: "09:00", to: "21:00"),
                                                 saturay: Shop.WorkHours(from: "09:00", to: "21:00"),
                                                 sunday: Shop.WorkHours(from: "09:00", to: "21:00")))

let shop3 = Shop(name: "Shop Name", adress: "Shop Adress 24",
                workSchedule: Shop.WorkSchedule(monday: Shop.WorkHours(from: "09:00", to: "20:00"),
                                                tuesday: Shop.WorkHours(from: "09:00", to: "21:00"),
                                                wednesday: Shop.WorkHours(from: "09:00", to: "22:00"),
                                                thursday: Shop.WorkHours(from: "10:00", to: "21:00"),
                                                friday: nil,
                                                saturay: Shop.WorkHours(from: "08:00", to: "21:00"),
                                                sunday: Shop.WorkHours(from: "07:00", to: "21:00")))

var workHours: [String] = []

func displayShopWorkSchedule(shop: Shop) {
  let dayValues = ["I", "II", "III", "IV", "V", "VI", "VII"]
  let workSchedule = shop.workSchedule
 
  workHours = []
  
  if let mon = workSchedule.monday { addHours(hours: mon) } else { addClosed() }
  if let tue = workSchedule.tuesday { addHours(hours: tue) } else { addClosed() }
  if let wed = workSchedule.wednesday { addHours(hours: wed) } else { addClosed() }
  if let thu = workSchedule.thursday { addHours(hours: thu) } else { addClosed() }
  if let fri = workSchedule.friday { addHours(hours: fri) } else { addClosed() }
  if let sat = workSchedule.saturay { addHours(hours: sat) } else { addClosed() }
  if let sun = workSchedule.sunday { addHours(hours: sun) } else { addClosed() }
  
  var idx = 0 // store first index of identical item in workHours array
  var lastIdx = 0 // store last index of identical item in workHours array
  
  for (index, hours) in workHours.enumerated() {
    if index > 0 {
      if workHours[idx] == workHours[index] {
        lastIdx = index
      } else {
        
        if idx < lastIdx {
          print("\(dayValues[idx])-\(dayValues[lastIdx])    \(workHours[lastIdx])")
        } else {
          print("\(dayValues[lastIdx])    \(workHours[lastIdx])")
        }
        
        idx = index
        lastIdx = index
      }
      
      if index+1 == workHours.count {
        if idx < lastIdx {
          print("\(dayValues[idx])-\(dayValues[index])    \(hours)")
        } else {
          print("\(dayValues[index])    \(hours)")
        }
      }
    }
  }
}

func addHours(hours: Shop.WorkHours) {
  workHours.append("\(hours.from)-\(hours.to)")
}

func addClosed() {
  workHours.append("Closed")
}

displayShopWorkSchedule(shop: shop1)
print("")
print("")
displayShopWorkSchedule(shop: shop2)
print("")
print("")
displayShopWorkSchedule(shop: shop3)



/****
 2. Write a function to find the longest common prefix from string array (function should take string as parameter and return a string).
 For example, input could be [“market”, “maxima”, “mama”], then longest common prefix would be “ma”.
 Another example - [“sale”, “safe”, “sun”], then result would be “s”.
 If there is no common prefix return an empty string.
 ***/

//Idea from https://stackoverflow.com/questions/48449365/how-to-determine-longest-common-prefix-and-suffix-for-array-of-strings?rq=1
//using Foundation library

func longestCommonPrefix(words: [String]) -> String {
  guard let first = words.first.map({ String($0) }) else { return "" }
  return words.dropFirst().reduce(first, { $0.commonPrefix(with: $1) })
}

longestCommonPrefix(words: ["market", "maxima", "mama"])
longestCommonPrefix(words: ["sale", "safe", "sun"])




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

lastWordsLength(sentence: "Today is sunny")



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

filterArray(numbers: [1,1,3,4,5,5])



/****
5. Write a function excel sheet column converter, that takes String as a parameter and
returns a number of the column. Some examples:
A -> 1
B -> 2
C -> 3
Z -> 26
AA -> 27
AB -> 28
****/

//Idea from https://www.geeksforgeeks.org/find-excel-column-number-column-title/?ref=lbp
func getExcelColumnNumber(column: String) -> Int {
  var result = 0
  for char in column {
    result *= 26
    result += Int(Character(String(char)).asciiValue! - Character("A").asciiValue!) + 1
  }
  return result
}

getExcelColumnNumber(column: "AB")



/**
 6. Integer to Roman number converter. Write a function that takes an Int as parameter and returns Roman number.
 Here’s Roman number converter:
Symbol Value
I 1
V 5
X 10
L 50
C 100
D 500
M 1000
 ***/

//Idea from https://learnappmaking.com/roman-numerals-swift/
func getRomanNumberFromNumber(number: Int) -> String {
  let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
  let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]

  var romanValue = ""
  var startingValue = number
  
  for (index, romanChar) in romanValues.enumerated() {
    let arabicValue = arabicValues[index]
    let div = startingValue / arabicValue
  
    if (div > 0) {
      for _ in 0..<div {
        romanValue += romanChar
      }
      startingValue -= arabicValue * div
    }
  }
  return romanValue
}

getRomanNumberFromNumber(number: 2000)




 /**
 7. Calculate smallest time difference. Function should take 2 strings in “hh:mm” format (hours:minutes) and return a difference in minutes.
 For example:
 Input - [“13:45”, ”12:45”], output 60
 Input - [“13:45”, ”14:00”], output 15
  ***/

func smallestTimeDifference(time: [String]) -> Int {
  let formatter = DateFormatter()
  formatter.dateFormat = "HH:mm"

  let time1 = formatter.date(from: time[0])!
  let time2 = formatter.date(from: time[1])!

  let elapsedTime = time2.timeIntervalSince(time1)
  
  let hours = floor(elapsedTime / 60)
  let minutes = floor((elapsedTime - (hours * 60)) / 60)
  
  return abs(Int(minutes)+Int(hours))
}

smallestTimeDifference(time: ["13:45", "12:45"])
smallestTimeDifference(time: ["13:45", "14:00"])




/**
 8. Write a mini investment algorithm. Function will take an array of numbers, where each number represents a stock price for a single day.
 Your goal is to buy stock when price is low and sell when price is high. You cannot buy until you have sold your stock.
 
Example:
Input - [1, 4, 5, 6, 2, 8], output - 11
Explanation you should buy stock from for 1 (on 1st day), sell it for 6 (on 4th day), buy
it again for 2 (on 5th day) and sell it next day for 8. Thus total profit would be 6-1+8-2= 11
 
Another example:
Input - [6, 3, 3, 6, 2, 9, 1], output - 10
This time you should buy stock on 2nd day for 3, sell it on 5th day for 6, buy it again
on 6th day for 2 and sell it next day for 9. Thus total profit would be: 6-3+9-2 = 10
 ***/

func investmentAlgorithm(stockPrices: [Int]) -> Int {
  var profit = 0
  var needToBuy = true
  
  for (index, price) in stockPrices.enumerated() {
    if needToBuy {
      if index+1 < stockPrices.count, stockPrices[index] < stockPrices[index+1] {
        profit -= price
        needToBuy = false
      }
    } else {
      if (index+1 < stockPrices.count && stockPrices[index] > stockPrices[index+1]) || index+1 == stockPrices.count {
        profit += price
        needToBuy = true
      }
    }
  }
  
  return profit
}

investmentAlgorithm(stockPrices: [1, 4, 5, 6, 2, 8])
investmentAlgorithm(stockPrices: [6, 3, 3, 6, 2, 9, 1])
