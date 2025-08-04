class_name ArenaHandler extends Node2D

var arena:Arena

func loadArena(packedArena:PackedScene):
	if arena != null : remove_child(arena)
	arena = packedArena.instantiate()
	add_child(arena)
