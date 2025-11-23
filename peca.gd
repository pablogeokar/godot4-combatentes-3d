extends CharacterBody3D

signal peca_clicada(esta_peca)

var coord_grid_atual: Vector2i

# NOVO: Identificador do time (0 = Azul, 1 = Vermelho)
var time_id: int = 0 

func _ready():
	# Assim que a peça nasce, definimos a cor dela baseada no time
	pintar_time()

func _input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		peca_clicada.emit(self)

func pintar_time():
	var mesh = $MeshInstance3D
	var material = StandardMaterial3D.new()
	
	if time_id == 0:
		material.albedo_color = Color(0, 0, 1) # Azul
	else:
		material.albedo_color = Color(1, 0, 0) # Vermelho
		
	mesh.set_surface_override_material(0, material)
