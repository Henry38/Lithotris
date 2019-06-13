extends CanvasLayer

signal tutorial_finished

onready var parts = [
	{
		"title": "Grille principale",
		"text": [
				"La grille principale, l'élément principal du jeu",
				"A gauche, en bleu, le départ du courant",
				"A droite, en rose, l'arrivée du courant",
				"Les blocs qui tombent servent à faire le lien"
			],
		"position": $Grid.get_position(),
		"size": Vector2(($Grid/TileMap.width + 1) * 32, ($Grid/TileMap.height + 1) * 32)
	},
	{
		"title" : "Score",
		"text" : [
			"Le Score du jeu",
			"Chaque bloc qui tombe fait perdre du score",
			"Quand l'arrivée et le départ sont reliés, 100 points gagnés",
			"Et l'arrivée monte d'un étage, augmentant la difficulté du niveau",
			],
		"position" : $ScoreLabel.get_position(),
		"size" : $ScoreLabel/VBoxContainer.get_size()
	},
	{
		"title" : "Les blocs suivants",
		"text" : [
			"Ici on peut voir le bloc suivant qui va tomber",
			"Cela permet d'anticiper le placement des blocs"
			],
		"position" : $Incomings/IncomingblocLabel.get_position(),
		"size" :  $Incomings/IncomingblocLabel.get_size() + Vector2(5,200)
	},
	{
		"title" : "Litographies",
		"text" : [
			"La litographie est un outil très puissant",
			"Pour l'activer, il faut appuyer sur 'shift' ",
			"Quand le bloc qui est en train de tomber a atteri, la litographie s'active",
			"Et elle détruit tous les conducteurs qui sont exposés à la surface (en haut)",
			"Le nombre de litographies est limité, utilise le intelligement !"
			],
		"position": $Lithographies.get_position() - Vector2(20,0),
		"size" : Vector2(190, 110)
	},
	{
		"title" : "Impact écologique",
		"text" : [
			"Chaque bloc qui tombe (conducteur ou non) augmente l'impact écologique",
			"Si la barre se remplie avant la fin de la partie, vous avez perdu !",
			"Il faut donc essayer de terminer les niveaux le plus rapidement possible"
			],
		"position": $VBoxContainer.get_position(),
		"size" : $VBoxContainer.get_size() + Vector2(90, 30)
	}
]

onready var dialog = $TutorialDialog
onready var tween = $Tween

var currentState = {
	"position" : Vector2(),
	"size" : Vector2()	
}

func _ready():
	$Grid/TileMap.stateMachine.show_victory()
	dialog.connect("next_clicked", self, "next")
	dialog.connect("skip_clicked", self, "skip")
	do_transition()
	update_text()

func skip() -> void:
	Transition.fade_to("res://scenes/Gameplay.tscn")

func _update_pos(pos: Vector2):
	currentState["position"] = pos
	$TutorialDialog.update_rect(currentState["position"], currentState["size"])

func _update_size(size: Vector2):
	currentState["size"] = size
	$TutorialDialog.update_rect(currentState["position"], currentState["size"])

func do_transition():
	tween.interpolate_method(self, "_update_pos", currentState["position"], parts[0]["position"], 0.5, Tween.TRANS_CIRC, Tween.EASE_OUT)
	tween.interpolate_method(self, "_update_size", currentState["size"], parts[0]["size"], 0.5, Tween.TRANS_CIRC, Tween.EASE_OUT)
	tween.start()

func update_text() -> bool:
	if parts.size() == 0: return false
	var txts = parts[0]["text"]
	var retSize = txts.size()
	if txts.size() > 0:
		var nxt_txt = txts.pop_front()
		$TutorialDialog.set_infos(parts[0]["title"], nxt_txt)
	return retSize > 0

func next() -> void:
	if parts.size() == 0:
		Transition.fade_to("res://scenes/Gameplay.tscn")
		return
	if update_text(): return
	parts.pop_front()
	if parts.size() == 0:
		$TutorialDialog/VBoxContainer/HBoxContainer/Next.set_text("Jouer")
	else:
		update_text()
		do_transition()

