extends Node2D

#Constants
const MINIMUM_PRICE = 11 # no stock will be priced cheaper than this
const FACTOR = 2.0 # the highest possible price will be 2x your balance
const PROGRESS = 1.0 # adds to noise_progress

#Variables
var balance : float = 10
var coin : int = 0
var price : float = MINIMUM_PRICE
var noise : OpenSimplexNoise
var noise_progress : float = 0.0
var oldbalance = 10
var investor = "false"


#Onready Variables
onready var pricelabel : Label = $PriceLabel 
onready var boughtpricelabel : Label = $LastBought
onready var soldpricelabel : Label = $LastSold
onready var walletlabel : Label = $Wallet
onready var coinlabel : Label = $CoinLabel
onready var graph : Line2D = $Graph
onready var music : AudioStreamPlayer = $AudioStreamPlayer
onready var investmentCounter : Label = $InvestmentCounter
onready var console : Node = $CommandHandler
#onready var oldbalancetimer : Timer = $Buy/OldBalanceTimer

var noise_modify : float = (balance * (FACTOR / 2.0 ))
var noise_modifyCoin : float = (oldbalance * (FACTOR / 2.0))

func _ready():
	if Global.console_load == "0":
		console.add_commands()
	else:
		pass
	randomize()
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	# --- tweak this to your needs ---
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.9
	# --------------------------------
	load_level()
	update_price()


func _on_PriceGenerator_timeout():
	generate_stock_price()

func generate_stock_price():
	price = noise_modify 
	price += noise.get_noise_1d(noise_progress) * noise_modify 
	noise_progress += PROGRESS
	
	if coin > 0:
		price = noise_modifyCoin
		price += noise.get_noise_1d(noise_progress) * noise_modify 
		noise_progress += PROGRESS
	update_price()

func update_price():
	pricelabel.update_price(price)
	graph.add_value(price)
	graph.create_graph()

#Button
func _on_BackButton_pressed():
# warning-ignore:return_value_discarded
	Global.console_load = "1"
	get_tree().change_scene("res://Title Screen/title_screen.tscn")

#Buying
func _on_Buy_pressed():
	buy()
func buy():
	if balance < price:
		oldbalance = oldbalance
		coin = coin
		balance = balance
	elif balance > price:
		print("Bought at: ", price)
		print("Old balance is:", oldbalance)
		boughtpricelabel.bought_price(price)
		oldbalance = balance
		balance = balance - price
		coin = coin+1

#Selling
func _on_Sell_pressed():
	sell()
func sell():
	if coin > 0:
		balance = balance + coin * price
		coin = coin-1
		print("Sold at: ", price)
		oldbalance = balance
		soldpricelabel.sold_price(price)
	else:
		pass

#Investment Checker
func investmentBegin():
	if balance >= 1000:
		investor = "true"

#Wallet Updating
func _on_WalletTimer_timeout():
	investmentCounter.InvestmentCounter(balance)	#Updates Investment Goal
	investmentCounter.Checker(investor) 			#Updates Investment
	walletlabel.update_wallet(balance)				#Updates the balance
	coinlabel.update_coin(coin)						#Updates the coins
	investmentBegin()
	
	#Investment
	if investor == "true":
		$InvestmentsWindow/Unavailable.hide()
		$InvestmentsWindow/Test.show()
		$InvestmentsWindow/Invest.show()
	
	#Music
	if music.musicPreference == "muted":
		music.mute()
	if music.musicPreference == "unmuted":
		music.unmute()

#Saving
func save_level():
	var save_file = File.new()
	save_file.open_encrypted_with_pass("user://savefile.stonks", File.WRITE, OS.get_unique_id())
	save_file.store_line(str(balance))
	save_file.store_line(str(coin))
	save_file.store_line(str(price))
	save_file.store_line(str(noise_progress))
	save_file.store_line(str(noise.seed))
	save_file.store_line(str(investor))
	
	save_file.open_encrypted_with_pass("user://preferences.stonks", File.WRITE, OS.get_unique_id())
	save_file.store_line(str(music.musicPreference))
	
#	save_file.open_encrypted_with_pass("user://transactions.stonks", File.WRITE, OS.get_unique_id())
#	save_file.store_line(float(soldpricelabel.soldPrice))
#	save_file.store_line(float(boughtpricelabel.boughtPrice))
	
	
	print("Saved!")
	save_file.close()
#Loading
func load_level():
	var save_file = File.new()
	if not save_file.file_exists("user://savefile.stonks"):
		return
	save_file.open_encrypted_with_pass("user://savefile.stonks", File.READ, OS.get_unique_id())
	balance = float(save_file.get_line())
	coin = int(save_file.get_line())
	price = float(save_file.get_line())
	noise_progress = float(save_file.get_line())
# warning-ignore:narrowing_conversion
	noise.seed = float(save_file.get_line())
	investor = str(save_file.get_line())
	
	save_file.open_encrypted_with_pass("user://preferences.stonks", File.READ, OS.get_unique_id())
	music.musicPreference = str(save_file.get_line())
	
#	save_file.open_encrypted_with_pass("user://preferences.stonks", File.READ, OS.get_unique_id())
#	soldpricelabel.soldPrice = float(save_file.get_line())
#	boughtpricelabel.boughtPrice = float(save_file.get_line())
	
	print("Loaded")
	save_file.close()

func _on_Save_pressed():
	save_level()

