# Introducción a Godot.
# E.H.S.J - Nov 2017.

# Ejemplo de Uso de Tree y TreeItem.

extends Tree

var root = null
var categoria = null
var consola = null
export(NodePath) var consolaPath
var seleccionado = null

func _ready():

	consola = get_node(consolaPath)
	consola.set_scroll_follow(true)
	set_single_select_cell_editing_only_when_already_selected(true)
	# Tree Cfg.
	set_column_titles_visible(true)
	#set_select_mode(self.SELECT_ROW)
	consola.add_text("Ejemplo Tree & TreeItem:\n")

	# Columnas Cfg:
	set_columns(6)

	set_column_title(0,"Str01")
	set_column_expand(0,true)

	set_column_title(1,"Str02")
	set_column_expand(1,true)

	set_column_title(2,"CHK")
	set_column_expand(2,false)
	set_column_min_width(2,50)

	set_column_title(3,"RANG")
	set_column_expand(3,false)
	set_column_min_width(3,100)

	set_column_title(4,"Boton")
	set_column_expand(4,false)
	set_column_min_width(4,75)

	set_column_title(5,"Custom")
	set_column_expand(5,false)
	set_column_min_width(5,150)

	# Crear Elementos:
	var root = create_item()
	root.set_text(0,"Root")
	set_hide_root(true)

	categoria = create_item(root)
	categoria.set_text(0,"Alpha")
	crearElemento("Andromeda","Cosmos",categoria,false,22)

	var item = create_item(categoria)
	item.set_text(0,"Andrajo")
	item.set_editable(0,true)
	item.set_cell_mode(1,TreeItem.CELL_MODE_RANGE)
	item.set_custom_bg_color(1,Color(0.1,0.5,0.1),true)
	item.set_range(1,44)
	item.set_editable(1,true)

	crearElemento("Casiopea","Cosmos",categoria,true,54)
	crearElemento("Draconis","Cosmos",categoria,false,16)

	categoria = create_item(root)
	categoria.set_text(0,"Bravo")
	crearElemento("Jhon","Persona",categoria,false,63)
	crearElemento("Juan","Persona",categoria,true,34)
	categoria = create_item(categoria)
	categoria.set_text(0,"Bravo - Alpha")
	crearElemento("Jhon","Persona",categoria,false,63)
	crearElemento("Juan","Persona",categoria,true,34)


func crearElemento(campo1,campo2,padre,chk,val):
	var item = create_item(padre)
	item.set_text(0,campo1)
	item.set_editable(0,true)

	item.set_text(1,campo2)
	item.set_editable(1,true)

	item.set_cell_mode(2,TreeItem.CELL_MODE_CHECK)
#	item.set_custom_bg_color(2,Color(0.1,0.1,0.5),true)
	item.set_checked(2,chk)
	item.set_editable(2,true)

	item.set_cell_mode(3,TreeItem.CELL_MODE_RANGE)
#	item.set_custom_bg_color(3,Color(0.1,0.5,0.1),true)
	item.set_range(3,val)
	item.set_editable(3,true)

#	item.add_button(4,load("res://icon.png"),-1,false)

	item.set_cell_mode(5,TreeItem.CELL_MODE_CUSTOM)
	item.set_editable(5,true)
	return item

func _on_Tree_item_selected():
	seleccionado = get_selected()
	consola.add_text("_on_Tree_item_selected: "+seleccionado.get_text(0)+"\n")

func _on_Tree_cell_selected():
	consola.add_text("_on_Tree_cell_selected. ->")
	seleccionado = get_selected()
	consola.append_bbcode("[color=yellow]"
		+seleccionado.get_text(0)
		+"[/color] \n")

func _on_Tree_item_edited():
	consola.add_text("_on_Tree_item_edited: "+get_edited().get_text(0)+"\n")

func _on_Tree_custom_popup_edited( arrow_clicked ):
	consola.add_text("_on_Tree_custom_popup_edited. -> ")
	consola.append_bbcode("[color=yellow]"
		+ str(get_edited())
		+ str(get_custom_popup_rect())
		+"[/color] \n")

func _on_Tree_button_pressed( item, column, id ):
	consola.add_text("_on_Tree_button_pressed: "+str(item)+" "+str(column)+"\n")

func _on_Tree_item_activated():
	consola.add_text("_on_Tree_item_activated: "+str(seleccionado)+"\n")
