@tool

extends Control

@export var export_name: String = "[unknown]"
@onready var runtime_label: Label = %RuntimeLabel
@onready var export_label: Label = %ExportLabel


func _ready() -> void:
	var runtime_name: String = ProjectSettings.get_setting_with_override("application/config/name")
	self.runtime_label.text = "Runtime: %s" % runtime_name
	self.export_label.text = "Export: %s" % self.export_name
	if OS.has_feature("demo"):
		print("Is DEMO")
	
func set_project_name_on_export( export_name: String ) -> void:
	print("set_project_name_on_export: %s" % export_name)
	self.export_name = export_name
