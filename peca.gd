extends CharacterBody3D

signal peca_clicada(esta_peca)

# NOVO: A peça sabe onde está no tabuleiro lógico
var coord_grid_atual: Vector2i

func _input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Cliquei na peça na coordenada: ", coord_grid_atual)
		peca_clicada.emit(self)
