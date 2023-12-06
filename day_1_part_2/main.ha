use bufio;
use os;
use ascii;
use fmt;
use encoding::utf8;
use types;
use io;
use strconv;
use strings;

export fn main() void = {
	let input = os::open("input.txt")!;
	let inputscanner = bufio::newscanner(input, types::SIZE_MAX);
	let total = 0;
	for (true) {
		let nextline = match (bufio::scan_line(&inputscanner)) {
			case let nextline: const str => yield nextline;
			case io::EOF => break;
			case io::error => break;
			case encoding::utf8::invalid => break;
		};
		let digit_one = 0;
		let digit_two = 0;
		let  iternextline = strings::iter(nextline);
		for ( let j =0u; j < len(nextline); j+= 1) {
			let currentvalue  = match (strings::next(&iternextline)){
				case let currentvalue:rune => yield currentvalue;
				case void => continue;
			};
			if (ascii::isdigit(currentvalue)) {
				let currentvalue = strconv::stoi8(strings::fromrunes([currentvalue])) as i8;				if (digit_one == 0) {
					digit_one = currentvalue;
				};
				digit_two = currentvalue;
			};
		};
		total += digit_one*10 + digit_two;
		};
	fmt::println(total)!;
};

fn identifyword(string:str,reverse:bool) (int|void) = {
	let reference:[9]str = ["eno","owt","eerth","rouf","evif","xis","neves", "thgie`", "enin"];
		if(reverse == false){
			reference = ["one", "two","three","four","five","six","seven", "eight","nine"];
	};
	let number = "";
	let position = len(string);
	let charecters = string::runes(string);
	for( let i=0u; i<9; i+=1){
		if (!(number ==  "")){
			break;
		};
		let word = reference[i];
		let wordletters = string::runes(word);
		let j = 0;
		for (let k=0u;  k<(charecters); k+=1){
			let letter = wordletters[j];
			if(letter =! charecters[k]){
				j = 0;
				continue;
			};
			if(j == len(wordletters)-1){
				if(k<position){
				number =  word;
				position = k - j;
				};
				break;
			};
			j +=1;
		};
	};
};
