class_name ArenaHandler extends Node2D

var arena:Arena

func loadArena(packedArena:PackedScene):
	remove_child(arena)
	arena = packedArena.instantiate()
	add_child(arena)
	
