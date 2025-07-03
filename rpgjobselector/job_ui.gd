extends Control

var job_data = []

@onready var select_button = $SelectButton
@onready var job_name_label = $JobName
@onready var job_desc_label = $JobDesc
@onready var skill_list = $SkillList

func _ready():
	load_csv()
	populate_dropdown()
	select_button.connect("item_selected", Callable(self, "_on_job_selected"))
	_on_job_selected(0) # show first job by default

func load_csv():
	var file = FileAccess.open("res://resource/class.csv", FileAccess.READ)
	if file:
		file.get_csv_line() # skip header
		while not file.eof_reached():
			var line = file.get_csv_line()
			if line.size() >= 4:
				var job = {
					"id": line[0],
					"name": line[1],
					"description": line[2],
					"skills": line[3].split(";")
				}
				job_data.append(job)

func populate_dropdown():
	for job in job_data:
		select_button.add_item(job["name"])

func _on_job_selected(index):
	var job = job_data[index]
	job_name_label.text = job["name"]
	job_desc_label.text = job["description"]

	# Clear skills
	for child in skill_list.get_children():
		child.queue_free()

	# Populate new skills
	for skill in job["skills"]:
		if skill.strip_edges() != "":
			var lbl = Label.new()
			lbl.text = "- " + skill.strip_edges()
			skill_list	.add_child(lbl)
