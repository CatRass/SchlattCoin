extends Node


#Commands 
func print_hello(name = ''):
	Console.write_line('Hello ' + name + '!')
#Money Command
func money_give(money = ""):
	get_parent().balance = money
#Coin Command
func coin_give(coin = ""):
	get_parent().coin = coin
#Investor Command
func investor_give(trueFalse = ''):
	if trueFalse == "true":
		get_parent().investor = "true"
	if trueFalse == "false":
		get_parent().investor = "false"

#Command addition
func add_commands():
	# Registering command
	# 1. argument is command name
	# 2. arg. is target (target could be a funcref)
	# 3. arg. is target name (name is not required if it is the same as first arg or target is a funcref)
	Console.add_command('sayHello', self, 'print_hello')\
		.set_description('Prints "Hello %name%!"')\
		.add_argument('name', TYPE_STRING)\
		.register()
	#Money Command
	Console.add_command('moneyGive', self, 'money_give')\
		.set_description('Gives you money')\
		.add_argument('money', TYPE_INT)\
		.register()
	#Coim Command
	Console.add_command('coinGive', self, 'coin_give')\
		.set_description('Gives you coins')\
		.add_argument('coin', TYPE_INT)\
		.register()
	#Investor Command
	Console.add_command('investorGive', self, 'investor_give')\
		.set_description('Gives you Investor rank')\
		.add_argument('trueFalse', TYPE_STRING)\
		.register()

