extends Node3D

@export var tile_scene: PackedScene 
@export var peca_scene: PackedScene 

var tamanho_grid = 10
var espaco_entre_tiles = 2.0

var peca_selecionada: Node3D = null

func _ready():
	gerar_tabuleiro()
	criar_peca(0, 0)
	criar_peca(1, 0)
	criar_peca(5, 5)

func gerar_tabuleiro():
	for x in range(tamanho_grid):
		for z in range(tamanho_grid):
			var novo_tile = tile_scene.instantiate()
			var pos_mundo = Vector3(x * espaco_entre_tiles, 0, z * espaco_entre_tiles)
			
			novo_tile.position = pos_mundo
			
			# ATUALIZADO: Passamos a coordenada lógica para o Tile guardar
			novo_tile.minha_coord_grid = Vector2i(x, z)
			
			novo_tile.tile_clicado.connect(_on_tile_clicado)
			add_child(novo_tile)

func criar_peca(x_logico, z_logico):
	var nova_peca = peca_scene.instantiate()
	nova_peca.position = Vector3(x_logico * espaco_entre_tiles, 0, z_logico * espaco_entre_tiles)
	
	# NOVO: Ensinamos à peça onde ela nasceu
	nova_peca.coord_grid_atual = Vector2i(x_logico, z_logico)
	
	nova_peca.peca_clicada.connect(_on_peca_clicada)
	add_child(nova_peca)

# --- LÓGICA DO JOGO ---

func _on_peca_clicada(peca_que_foi_clicada):
	print("Selecionei peça em: ", peca_que_foi_clicada.coord_grid_atual)
	peca_selecionada = peca_que_foi_clicada
	
# No script Main.gd

func _on_tile_clicado(coord_destino: Vector2i, posicao_mundo_destino: Vector3):
	if peca_selecionada == null:
		return 
		
	var coord_origem = peca_selecionada.coord_grid_atual
	
	var distancia_x = abs(coord_origem.x - coord_destino.x)
	var distancia_z = abs(coord_origem.y - coord_destino.y) 
	var distancia_total = distancia_x + distancia_z
	
	if distancia_total == 1:
		print("Movimento Válido!")
		
		# --- A CORREÇÃO MÁGICA ---
		# Ignoramos a 'posicao_mundo_destino' que veio do clique.
		# Recalculamos o destino usando a MESMA fórmula de quando geramos o tabuleiro.
		# Isso garante 100% de precisão matemática.
		var destino_calculado = Vector3(coord_destino.x * espaco_entre_tiles, 0, coord_destino.y * espaco_entre_tiles)
		
		mover_peca_com_animacao(peca_selecionada, destino_calculado)
		
		# Atualiza a coordenada lógica da peça
		peca_selecionada.coord_grid_atual = coord_destino
	else:
		print("Movimento Inválido!")

	
func mover_peca_com_animacao(peca, destino_3d):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(peca, "position", destino_3d, 0.3) # Um pouco mais rápido (0.3s)
