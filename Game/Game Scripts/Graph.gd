extends Line2D

export var graph_width : float = 100
export var graph_height : float = 100
export var graph_max_points : int = 0 # Zero for unlimited graph-points
export var grow : bool = false

var graph : Array

func create_graph() -> void:
	var length : int = len(graph)
	assert(length > 0 and graph[0] is float and graph_max_points >= 0)

	var points_ : PoolVector2Array = []

	var maximum : float = graph[0]
	var minimum : float = graph[0]

	if length == 1:
		graph.append(graph[0])
		length += 1

	for value in graph:
		assert(value is float)
		if value > maximum:
			maximum = value
		if value < minimum:
			minimum = value

	if minimum == maximum:
		minimum -= 1.0
		maximum += 1.0

	for index in range(length):
		points_.append(Vector2(
			0.0,
			lerp(graph_height, 0.0, (graph[index] - minimum) / (maximum - minimum))))
		if grow and graph_max_points:
			points_[-1].x = lerp(0.0, graph_width, index / float(graph_max_points - 1))
		else:
			points_[-1].x = lerp(0.0, graph_width, index / float(length - 1))

	points = points_

func pop_values() -> void:
	if graph_max_points != 0:
		if len(graph) > graph_max_points:
			graph.pop_front()
			pop_values()

func add_value(value : float) -> void:
	graph.append(value)
	pop_values()

var graphColour = "red"

func _on_GreenGraph_pressed():
	graphColour = "green"
	if graphColour == "green":
	 set_default_color(ColorN("Green"))
func _on_Red_Graph_pressed():
	graphColour = "red"
	if graphColour == "red":
	 set_default_color(ColorN("Red"))
func _on_Orange_Graph_pressed():
	graphColour = "orange"
	if graphColour == "orange":
	 set_default_color(ColorN("Orange"))
func _on_Purple_Graph_pressed():
	graphColour = "purple"
	if graphColour == "purple":
		set_default_color(ColorN("Purple"))
func _on_Yellow_Graph_pressed():
	graphColour = "yellow"
	if graphColour == "yellow":
		set_default_color(ColorN("Yellow"))
func _on_Blue_Graph_pressed():
	graphColour = "blue"
	if graphColour == "blue":
		set_default_color(ColorN("Blue"))
func _on_Pink_Graph_pressed():
	graphColour = "pink"
	if graphColour == "pink":
		set_default_color(ColorN("Pink"))
func _on_ColourChecker_timeout():
	if graphColour == "green":
	 set_default_color(ColorN("Green"))
	if graphColour == "orange":
	 set_default_color(ColorN("Orange"))
	if graphColour == "red":
	 set_default_color(ColorN("Red"))
	if graphColour == "purple":
		set_default_color(ColorN("Purple"))
	if graphColour == "yellow":
		set_default_color(ColorN("Yellow"))
	if graphColour == "blue":
		set_default_color(ColorN("Blue"))
	if graphColour == "pink":
		set_default_color(ColorN("Pink"))
