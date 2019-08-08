extends Enemy

func _ready():
	self.target_list.append(get_node("/root/Root/Player").position)

func updateTargetList():
	if self.target_list.size()>1 or self.target_list.empty():
		self.target_list.clear()
		self.target_list.append(get_node("/root/Root/Player").position)
	else:
		self.target_list[0]=get_node("/root/Root/Player").position

func _process(delta):
	updateTargetList()
	._process(delta)