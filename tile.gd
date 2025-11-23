extends StaticBody3D

signal tile_clicado(coord_grid: Vector2i, posicao_mundo: Vector3)

var minha_coord_grid: Vector2i

func _input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		# O ERRO ESTAVA AQUI:
		# Antes enviávamos 'position' (o ponto do clique do mouse)
		
		# A CORREÇÃO:
		# Enviamos 'self.global_position' (o centro exato deste objeto quadrado)
		tile_clicado.emit(minha_coord_grid, self.global_position)
