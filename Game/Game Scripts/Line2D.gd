extends Line2D

export var graph_width : float = 100
export var graph_height : float = 100
export var graph_max_points : int = 0 # Zero for unlimited graph-points

var graph : Array

func create_graph() -> void:
	var length : int = len(graph)
	assert(length > 0 and graph[0] is float)

	var points_ : PoolVector2Array 

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

	for index in range(length):
		points_.append(Vector2(
					lerp(0.0, graph_width, index / float(length - 1)),
					lerp(graph_height, 0.0, (graph[index] - minimum) / (maximum - minimum))))

	points = points_

func pop_values() -> void:
	if graph_max_points != 0:
		if len(graph) > graph_max_points:
			graph.pop_front()
			pop_values()

func add_value(value : float) -> void:
	graph.append(value)
	pop_values()


var balance = 10

const MINIMUM_PRICE = 100 # no stock will be priced cheaper than this
const FACTOR = 2 # the highest possible price will be 2x your balance

func update_price(price : float) -> void:
	print("Price changed to:", price)

func _on_Timer_timeout():
	randomize()
	var price = generate_stock_price()
	update_price(price)
	add_value(price)
	add_value(price/2)
	create_graph()

func _ready():
	randomize()
	add_value(1)
	var price = generate_stock_price()
	update_price(price)

func generate_stock_price():
	var price = rand_range(MINIMUM_PRICE, balance * FACTOR)
	return price



