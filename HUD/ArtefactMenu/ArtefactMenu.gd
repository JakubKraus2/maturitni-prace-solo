extends CanvasLayer


const SAVE_PATH = "user://artefacts_inventory_save_file.save"
var artefacts = {}

export(ButtonGroup) var artefact1_group #only one button can be pressed in Artefacts1 menu
export(ButtonGroup) var artefact2_group
export(ButtonGroup) var artefact3_group
export(ButtonGroup) var artefact4_group


func _ready():
	load_data()
	$CurrentArtefacts.check_for_same_artefacts()
	for i in $Artefacts1.get_child_count():
		$Artefacts1.get_child(i).boost()
	print(artefacts.current_artefact1_artefact_name)
	print(artefacts.current_artefact2_artefact_name)
	print(artefacts.current_artefact3_artefact_name)
	print(artefacts.current_artefact4_artefact_name)
	for i in artefact1_group.get_buttons(): #get all buttons in artefact1_group
		i.connect("pressed", self, "artefact1_button_pressed") #connect signal pressed on itself and renamed it to artefact1_button_pressed
	for j in artefact2_group.get_buttons():
		j.connect("pressed", self, "artefact2_button_pressed")
	for k in artefact3_group.get_buttons():
		k.connect("pressed", self, "artefact3_button_pressed")
	for l in artefact4_group.get_buttons():
		l.connect("pressed", self, "artefact4_button_pressed")


func artefact1_button_pressed(): #after clicking on certain button in artefact1 group do the following
	$DesciptionContainer.update_description_artefact1()
	
	$CurrentArtefacts/Panel1.texture_normal = artefact1_group.get_pressed_button().texture_normal
	$CurrentArtefacts/Panel1.texture_pressed = artefact1_group.get_pressed_button().texture_pressed
	$CurrentArtefacts/Panel1.artefact_name = artefact1_group.get_pressed_button().artefact_name
	$CurrentArtefacts.check_for_same_artefacts()

func artefact2_button_pressed():
	$DesciptionContainer.update_description_artefact2()
	
	$CurrentArtefacts/Panel2.texture_normal = artefact2_group.get_pressed_button().texture_normal
	$CurrentArtefacts/Panel2.texture_pressed = artefact2_group.get_pressed_button().texture_pressed
	$CurrentArtefacts/Panel2.artefact_name = artefact2_group.get_pressed_button().artefact_name
	$CurrentArtefacts.check_for_same_artefacts()

func artefact3_button_pressed():
	$DesciptionContainer.update_description_artefact3()
	
	$CurrentArtefacts/Panel3.texture_normal = artefact3_group.get_pressed_button().texture_normal
	$CurrentArtefacts/Panel3.texture_pressed = artefact3_group.get_pressed_button().texture_pressed
	$CurrentArtefacts/Panel3.artefact_name = artefact3_group.get_pressed_button().artefact_name
	$CurrentArtefacts.check_for_same_artefacts()

func artefact4_button_pressed():
	$DesciptionContainer.update_description_artefact4()
	
	$CurrentArtefacts/Panel4.texture_normal = artefact4_group.get_pressed_button().texture_normal
	$CurrentArtefacts/Panel4.texture_pressed = artefact4_group.get_pressed_button().texture_pressed
	$CurrentArtefacts/Panel4.artefact_name = artefact4_group.get_pressed_button().artefact_name
	$CurrentArtefacts.check_for_same_artefacts()


func _on_Panel1_toggled(button_pressed: bool) -> void:
	$Artefacts1.visible = button_pressed

func _on_Panel2_toggled(button_pressed: bool) -> void:
	$Artefacts2.visible = button_pressed

func _on_Panel3_toggled(button_pressed: bool) -> void:
	$Artefacts3.visible = button_pressed

func _on_Panel4_toggled(button_pressed: bool) -> void:
	$Artefacts4.visible = button_pressed


func save_data():
	var file = File.new()
	file.open(SAVE_PATH, File.WRITE)
	file.store_var(artefacts)
	file.close()

func load_data():
	var file = File.new()
	if !file.file_exists(SAVE_PATH):
		artefacts = {
			"current_artefact1_texture_normal": $CurrentArtefacts/Panel1.texture_normal.resource_path,
			"current_artefact1_texture_pressed": $CurrentArtefacts/Panel1.texture_pressed.resource_path,
			"current_artefact1_artefact_name": $CurrentArtefacts/Panel1.artefact_name,
			"current_artefact2_texture_normal": $CurrentArtefacts/Panel2.texture_normal.resource_path,
			"current_artefact2_texture_pressed": $CurrentArtefacts/Panel2.texture_pressed.resource_path,
			"current_artefact2_artefact_name": $CurrentArtefacts/Panel2.artefact_name,
			"current_artefact3_texture_normal": $CurrentArtefacts/Panel3.texture_normal.resource_path,
			"current_artefact3_texture_pressed": $CurrentArtefacts/Panel3.texture_pressed.resource_path,
			"current_artefact3_artefact_name": $CurrentArtefacts/Panel3.artefact_name,
			"current_artefact4_texture_normal": $CurrentArtefacts/Panel4.texture_normal.resource_path,
			"current_artefact4_texture_pressed": $CurrentArtefacts/Panel4.texture_pressed.resource_path,
			"current_artefact4_artefact_name": $CurrentArtefacts/Panel4.artefact_name,
			
			"artefacts_panel1_disabled": true,
			"artefacts_panel2_disabled": true,
			"artefacts_panel3_disabled": true,
			"artefacts_panel4_disabled": true,
			"artefacts_panel5_disabled": true,
			"artefacts_panel6_disabled": true,
			"artefacts_panel7_disabled": true,
			"artefacts_panel8_disabled": true,
			"artefacts_panel9_disabled": true,
			"artefacts_panel10_disabled": true,
			"artefacts_panel11_disabled": true,
			"artefacts_panel12_disabled": true,
			"artefacts_panel13_disabled": true,
			"artefacts_panel14_disabled": true,
			"artefacts_panel15_disabled": true,
		}
		save_data()
	file.open(SAVE_PATH, File.READ)
	artefacts = file.get_var()
	file.close()
	$CurrentArtefacts/Panel1.texture_normal = load(artefacts.current_artefact1_texture_normal)
	$CurrentArtefacts/Panel1.texture_pressed = load(artefacts.current_artefact1_texture_pressed)
	$CurrentArtefacts/Panel2.texture_normal = load(artefacts.current_artefact2_texture_normal)
	$CurrentArtefacts/Panel2.texture_pressed = load(artefacts.current_artefact2_texture_pressed)
	$CurrentArtefacts/Panel3.texture_normal = load(artefacts.current_artefact3_texture_normal)
	$CurrentArtefacts/Panel3.texture_pressed = load(artefacts.current_artefact3_texture_pressed)
	$CurrentArtefacts/Panel4.texture_normal = load(artefacts.current_artefact4_texture_normal)
	$CurrentArtefacts/Panel4.texture_pressed = load(artefacts.current_artefact4_texture_pressed)
	
	$CurrentArtefacts/Panel1.artefact_name = artefacts.current_artefact1_artefact_name
	$CurrentArtefacts/Panel2.artefact_name = artefacts.current_artefact2_artefact_name
	$CurrentArtefacts/Panel3.artefact_name = artefacts.current_artefact3_artefact_name
	$CurrentArtefacts/Panel4.artefact_name = artefacts.current_artefact4_artefact_name
	
	$Artefacts1/Panel1.disabled = artefacts.artefacts_panel1_disabled
	$Artefacts2/Panel1.disabled = artefacts.artefacts_panel1_disabled
	$Artefacts3/Panel1.disabled = artefacts.artefacts_panel1_disabled
	$Artefacts4/Panel1.disabled = artefacts.artefacts_panel1_disabled
	
	$Artefacts1/Panel2.disabled = artefacts.artefacts_panel2_disabled
	$Artefacts2/Panel2.disabled = artefacts.artefacts_panel2_disabled
	$Artefacts3/Panel2.disabled = artefacts.artefacts_panel2_disabled
	$Artefacts4/Panel2.disabled = artefacts.artefacts_panel2_disabled
	
	$Artefacts1/Panel3.disabled = artefacts.artefacts_panel3_disabled
	$Artefacts2/Panel3.disabled = artefacts.artefacts_panel3_disabled
	$Artefacts3/Panel3.disabled = artefacts.artefacts_panel3_disabled
	$Artefacts4/Panel3.disabled = artefacts.artefacts_panel3_disabled
	
	$Artefacts1/Panel4.disabled = artefacts.artefacts_panel4_disabled
	$Artefacts2/Panel4.disabled = artefacts.artefacts_panel4_disabled
	$Artefacts3/Panel4.disabled = artefacts.artefacts_panel4_disabled
	$Artefacts4/Panel4.disabled = artefacts.artefacts_panel4_disabled
	
	$Artefacts1/Panel5.disabled = artefacts.artefacts_panel5_disabled
	$Artefacts2/Panel5.disabled = artefacts.artefacts_panel5_disabled
	$Artefacts3/Panel5.disabled = artefacts.artefacts_panel5_disabled
	$Artefacts4/Panel5.disabled = artefacts.artefacts_panel5_disabled
	
	$Artefacts1/Panel6.disabled = artefacts.artefacts_panel6_disabled
	$Artefacts2/Panel6.disabled = artefacts.artefacts_panel6_disabled
	$Artefacts3/Panel6.disabled = artefacts.artefacts_panel6_disabled
	$Artefacts4/Panel6.disabled = artefacts.artefacts_panel6_disabled
	
	$Artefacts1/Panel7.disabled = artefacts.artefacts_panel7_disabled
	$Artefacts2/Panel7.disabled = artefacts.artefacts_panel7_disabled
	$Artefacts3/Panel7.disabled = artefacts.artefacts_panel7_disabled
	$Artefacts4/Panel7.disabled = artefacts.artefacts_panel7_disabled
	
	$Artefacts1/Panel8.disabled = artefacts.artefacts_panel8_disabled
	$Artefacts2/Panel8.disabled = artefacts.artefacts_panel8_disabled
	$Artefacts3/Panel8.disabled = artefacts.artefacts_panel8_disabled
	$Artefacts4/Panel8.disabled = artefacts.artefacts_panel8_disabled
	
	$Artefacts1/Panel9.disabled = artefacts.artefacts_panel9_disabled
	$Artefacts2/Panel9.disabled = artefacts.artefacts_panel9_disabled
	$Artefacts3/Panel9.disabled = artefacts.artefacts_panel9_disabled
	$Artefacts4/Panel9.disabled = artefacts.artefacts_panel9_disabled
	
	$Artefacts1/Panel10.disabled = artefacts.artefacts_panel10_disabled
	$Artefacts2/Panel10.disabled = artefacts.artefacts_panel10_disabled
	$Artefacts3/Panel10.disabled = artefacts.artefacts_panel10_disabled
	$Artefacts4/Panel10.disabled = artefacts.artefacts_panel10_disabled
	
	$Artefacts1/Panel11.disabled = artefacts.artefacts_panel11_disabled
	$Artefacts2/Panel11.disabled = artefacts.artefacts_panel11_disabled
	$Artefacts3/Panel11.disabled = artefacts.artefacts_panel11_disabled
	$Artefacts4/Panel11.disabled = artefacts.artefacts_panel11_disabled
	
	$Artefacts1/Panel12.disabled = artefacts.artefacts_panel12_disabled
	$Artefacts2/Panel12.disabled = artefacts.artefacts_panel12_disabled
	$Artefacts3/Panel12.disabled = artefacts.artefacts_panel12_disabled
	$Artefacts4/Panel12.disabled = artefacts.artefacts_panel12_disabled
	
	$Artefacts1/Panel13.disabled = artefacts.artefacts_panel13_disabled
	$Artefacts2/Panel13.disabled = artefacts.artefacts_panel13_disabled
	$Artefacts3/Panel13.disabled = artefacts.artefacts_panel13_disabled
	$Artefacts4/Panel13.disabled = artefacts.artefacts_panel13_disabled
	
	$Artefacts1/Panel14.disabled = artefacts.artefacts_panel14_disabled
	$Artefacts2/Panel14.disabled = artefacts.artefacts_panel14_disabled
	$Artefacts3/Panel14.disabled = artefacts.artefacts_panel14_disabled
	$Artefacts4/Panel14.disabled = artefacts.artefacts_panel14_disabled
	
	$Artefacts1/Panel15.disabled = artefacts.artefacts_panel15_disabled
	$Artefacts2/Panel15.disabled = artefacts.artefacts_panel15_disabled
	$Artefacts3/Panel15.disabled = artefacts.artefacts_panel15_disabled
	$Artefacts4/Panel15.disabled = artefacts.artefacts_panel15_disabled
