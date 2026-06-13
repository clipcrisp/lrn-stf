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
			item := generate_item(random_item_type())
		} else if input == "M" {
			fmt.println("Generation Items and Merging!")
			item := merge_items()
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

generate_item :: proc(item_type: Item_Type) -> Item {
	item_stats : Item_Stats
	if item_type == Item_Type.POTION {
		item_stats = new_potion_stats()
	} else if item_type == Item_Type.SWORD {
		item_stats = new_sword_stats()
	}
	value := rand.uint_range(1, 100)

	item := Item{
		item_type = item_type,
		item_stats = item_stats,
		value = value,
	}

	fmt.println(item)
	return item
}

merge_items :: proc() -> Item {
	new_item : Item
	item_type := random_item_type()
	item1 := generate_item(item_type)
	item2 := generate_item(item_type)

	if item_type == Item_Type.POTION {
		new_item = merge_potion(item1, item2)
	} else if item_type == Item_Type.SWORD {
		new_item = merge_sword(item1, item2)
	}

	fmt.println(new_item)	
	return new_item
}

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

merge_potion :: proc(item1 : Item, item2 : Item) -> Item {
	new_item: Item
	new_item.item_type = Item_Type.POTION
	new_stats: Potion_Stats
	item1_stats := item1.item_stats.(Potion_Stats)
	item2_stats := item2.item_stats.(Potion_Stats)

	if item1.value >= item2.value {
		new_item.value = item1.value + (item2.value / 2)
	} else {
		new_item.value = item2.value + (item1.value / 2)
	}

	item_attr_select := rand.uint_range(0, 1)
	switch item_attr_select {
		case 0:
			new_stats.attr_to_change = item1_stats.attr_to_change
		case 1:
			new_stats.attr_to_change = item2_stats.attr_to_change
	}

	if item1_stats.amount_of_change >=item2_stats.amount_of_change {
		new_stats.amount_of_change = item1_stats.amount_of_change 
	} else {
		new_stats.amount_of_change = item2_stats.amount_of_change 
	}

	new_item.item_stats = new_stats

	return new_item
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

merge_sword :: proc(item1 : Item, item2 : Item) -> Item {
	new_item: Item
	new_item.item_type = Item_Type.SWORD
	new_stats: Sword_Stats
	item1_stats := item1.item_stats.(Sword_Stats)
	item2_stats := item2.item_stats.(Sword_Stats)

	if item1.value >= item2.value {
		new_item.value = item1.value + (item2.value / 2)
	} else {
		new_item.value = item2.value + (item1.value / 2)
	}

	if item1_stats.damage>=item2_stats.damage {
		new_stats.damage = item1_stats.damage
	} else {
		new_stats.damage = item2_stats.damage
	}

	if item1_stats.attack_speed <= item2_stats.attack_speed  {
		new_stats.attack_speed = item1_stats.attack_speed 
	} else {
		new_stats.attack_speed  = item2_stats.attack_speed 
	}

	new_item.item_stats = new_stats
	
	return new_item
}
