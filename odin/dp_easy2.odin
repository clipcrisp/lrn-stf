// r/dailyprogrammer [easy] challenge #2
/*
Hello, coders! An important part of programming is being able to apply your programs, so your challenge for today is to create a 
calculator application that has use in your life. It might be an interest calculator, or it might be something that you can use in the
classroom. For example, if you were in physics class, you might want to make a F = M * A calc.

EXTRA CREDIT: make the calculator have multiple functions! Not only should it be able to calculate F = M * A, but also A = F/M, and M = F/A!
*/

// Not sure if it's useful or a calc but I'm goint to make a item generator that can also merge items
// Been playing PoE2 so items on the brain.
package dpe2 

import "core:fmt"
import "core:os"
import "core:strings"
import "core:math/rand"

main :: proc() {
	fmt.println(`"G" to generate item.`)
	fmt.println(`"M" to generate two items and merge them.`)
	fmt.println(`"q" to exit application.`)
	for {	
		input : string = read_input()
		if input == "G" {
			fmt.println("Generating Item!")
			item := generate_any_item()
			fmt.println(item)
		} else if input == "M" {
			fmt.println("Generation Items and Merging!")
			// TODO item := merge_item()
		} else if input == "q" {
			os.exit(0)
		} else {
			fmt.println(`"G", "M" or "q" are the only valid inputs.`)
		}
	}
}

read_input :: proc() -> string {
	buf: [256]byte
	name, err := os.read(os.stdin, buf[:])
	if err != nil {
		fmt.eprintln("Error reading: ", err)
		return "error"
	}

	str := string(buf[:name - 1])
	return strings.clone(str)
}

random_item_type :: proc() -> Item_Type {
	r : Item_Type = cast(Item_Type)rand.uint_range(0, len(Item_Type))
	return r
}

generate_any_item :: proc() -> Item {
	rand_type := random_item_type()
	item_stats : Item_Stats
	if rand_type == Item_Type.POTION {
		item_stats = new_potion_stats()
	} else if rand_type == Item_Type.SWORD {
		item_stats = new_sword_stats()
	}
	value := rand.uint_range(1, 100)

	item := Item{
		item_type = rand_type,
		item_stats = item_stats,
		value = value,
	}

	return item
}

generate_specific_item :: proc(item_type: Item_Type) -> Item {
	// TODO <
}

// Procedure overloading seems cool
generate_item :: proc {generate_any_item, generate_specific_item}

merge_item :: proc() -> Item {
	item1 = generate_item()
	item2 = generate_item()
	// TODO <
}

// Will expend w/ more props as I go
Item :: struct {
	item_type: Item_Type,
	item_stats: Item_Stats,
	value: uint	
}

Item_Type :: enum {
	POTION,
	SWORD,
}

Item_Stats :: union {
	Potion_Stats,
	Sword_Stats,
}

Potion_Stats :: struct {
	attr_to_change: string,
	amount_of_change: uint,
}

new_potion_stats :: proc() -> Potion_Stats {
	potion_stats : Potion_Stats
	
	attr := rand.uint_range(0, 1)
	switch attr {
		case 0:
			potion_stats.attr_to_change = "HP"
		case 1:
			potion_stats.attr_to_change = "MP"
	}
	potion_stats.amount_of_change = rand.uint_range(5, 20) 

	return potion_stats
}

Sword_Stats :: struct {
	damage: uint,
	attack_speed: uint,
}

new_sword_stats :: proc() -> Sword_Stats {
	sword_stats : Sword_Stats
	
	sword_stats.damage = rand.uint_range(1, 120) 
	sword_stats.attack_speed = rand.uint_range(1, 5) 

	return sword_stats
}
