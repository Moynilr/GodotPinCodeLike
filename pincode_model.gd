extends Control


var is_drawing = false
var checkbox_list = Array()
var checkbox_items = Array()
var last_item
var pin_nb = 6
var drawing_lenght = 4
var has_to_close = true
var drawing_end = false
var color = Color.chartreuse

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, pin_nb):
		checkbox_list.append(-1)
		checkbox_items.append(get_node("Control").get_child(i))
		last_item = -1
	# for has_to_close
	checkbox_list.append(-1)

func restart_drawing(lenght = pin_nb, close = true):
	is_drawing = false
	has_to_close = close
	drawing_lenght = lenght
	drawing_end = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_drawing and not drawing_end:
		update()
	
	
func _draw():
	var line_width = 3
	
	var nb_lines
	if has_to_close:
		nb_lines = drawing_lenght
	else:
		nb_lines = drawing_lenght -1
	
	for i in range(0, nb_lines):
		var item1= checkbox_list[i] 
		var i_pos = checkbox_items[item1].rect_position \
			+ checkbox_items[item1].rect_size/4
			
		if checkbox_list[i] != -1 and checkbox_list[i+1] != -1:
			var item2 = checkbox_list[i+1]
			var i_plus_pos =  checkbox_items[item2].rect_position \
			 + checkbox_items[item2].rect_size/4
			
			draw_line(i_pos, i_plus_pos, color, line_width)
		elif checkbox_list[i] != -1:
		#	print("draw line", get_viewport().get_mouse_position())
			draw_line(i_pos, get_viewport().get_mouse_position(), color,line_width)
		


func checking():
	if not drawing_end:
		for i in range(0,pin_nb):
			if checkbox_list[i] != -1:
				is_drawing = true
				break
		update()


func add_next_butt(button_pressed_nb):
	print("add butt:", button_pressed_nb)
	if not button_pressed_nb in checkbox_list:
		if last_item == -1:
			checkbox_list[0] = button_pressed_nb
			last_item = 0
		elif last_item < drawing_lenght-1:
			last_item += 1
			checkbox_list[last_item] = button_pressed_nb
			checkbox_items[checkbox_list[last_item - 1]].disabled = true
			if has_to_close and last_item == drawing_lenght-1:
				for i in range(0, pin_nb):
					checkbox_items[i].disabled = true
				checkbox_items[checkbox_list[0]].disabled = false
				checkbox_items[checkbox_list[0]].pressed = false
		elif last_item == drawing_lenght-1:
			if not has_to_close:
				end_of_drawing()
	else:
		if has_to_close and last_item == drawing_lenght-1:
			if button_pressed_nb == checkbox_list[0]:
				last_item += 1
				checkbox_list[last_item] = button_pressed_nb
				checkbox_items[checkbox_list[last_item - 1]].disabled = true
				checkbox_items[button_pressed_nb].disabled = false
				end_of_drawing()
	print("end of add",  last_item, checkbox_list,checkbox_items[button_pressed_nb].disabled)

func end_of_drawing():
	print("end of drawing")
	drawing_end = true
	is_drawing = false
	for i in range(0, pin_nb):
		checkbox_items[i].disabled = true
	update()


func remove_last_butt(button_pressed_nb):
	print("remove:", button_pressed_nb)
	if button_pressed_nb == checkbox_list[last_item]:
		checkbox_items[checkbox_list[last_item - 1]].disabled = false
		checkbox_list[last_item] = -1
		last_item -= 1
		print("end of remove", last_item, checkbox_list, checkbox_items[button_pressed_nb].disabled)

func _on_1_toggled(button_pressed):
	if button_pressed:
		add_next_butt(0)
	else:
		remove_last_butt(0)
	checking()


func _on_2_toggled(button_pressed):
	if button_pressed:
		add_next_butt(1)
	else:
		remove_last_butt(1)
	checking()


func _on_3_toggled(button_pressed):
	if button_pressed:
		add_next_butt(2)
	else:
		remove_last_butt(2)
	checking()


func _on_4_toggled(button_pressed):
	if button_pressed:
		add_next_butt(3)
	else:
		remove_last_butt(3)
	checking()


func _on_5_toggled(button_pressed):
	if button_pressed:
		add_next_butt(4)
	else:
		remove_last_butt(4)
	checking()


func _on_6_toggled(button_pressed):
	if button_pressed:
		add_next_butt(5)
	else:
		remove_last_butt(5)
	checking()
