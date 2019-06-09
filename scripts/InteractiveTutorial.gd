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
		"widget": $Grid
	},
	{
		"title" : "Score",
		"text" : [
			"Le Score du jeu",
			"Chaque bloc qui tombe fait perdre du score",
			"Quand l'arrivée et le départ sont reliés, 100 points gagnés",
			"Et l'arrivée monte d'un étage, augmentant la difficulté du niveau",
			],
		"widget" : $ScoreLabel
	},
	{
		"title" : "Les blocs suivants",
		"text" : [
			"Ici on peut voir le bloc suivant qui va tomber",
			"Cela permet d'anticiper le placement des blocs"
			],
		"widget" : $Incomings	
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
		"widget": $Lithographies
	},
	{
		"title" : "Impact écologique",
		"text" : [
			"Chaque bloc qui tombe (conducteur ou non) augmente l'impact écologique",
			"Si la barre se remplie avant la fin de la partie, vous avez perdu !",
			"Il faut donc essayer de terminer les niveaux le plus rapidement possible"
			],
		"widget": $VBoxContainer
	}
]

onready var dialog = $TutorialDialog

func _ready():
	for i in parts:
		i["widget"].visible = false
	$Grid/TileMap.stateMachine.show_victory()
	#dialog.connect("popup_hide", self, "show_next")
	# dialog.popup_exclusive = true
	show_next()
	
func show_next() -> void:
	if parts[0]["text"].empty():
		parts.pop_front()
		if parts.empty(): 
			emit_signal("tutorial_finished")
			return
		var next = parts[0]
		next["widget"].visible = true
		#dialog.window_title = next["title"]
		#dialog.dialog_text = next["text"].pop_front()
		#dialog.popup_centered()
	else:
		parts[0]["widget"].visible = true
		#dialog.window_title = parts[0]["title"]
		#dialog.dialog_text = parts[0]["text"].pop_front()
		#dialog.popup_centered()