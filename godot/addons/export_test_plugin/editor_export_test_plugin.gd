class_name EditorExportTestPlugin
extends EditorExportPlugin


const NAME="application/config/name"
var _application_config_name: String = ""

func _get_name() -> String:
	return "EditorExportTestPlugin"

func _get_customization_configuration_hash() -> int:
	print("_get_customization_configuration_hash")
	return randi()

func _export_begin(features: PackedStringArray, is_debug: bool, path: String, flags: int) -> void	:
	# -> ends with "..., demo"
	print("Export Begin - %s" % ", ".join(features))
	# false
	if OS.has_feature("demo"):
		# not printed
		print("Is DEMO")
	var export_name = ProjectSettings.get_setting_with_override("application/config/name")
	# shows "Godot Export Test"
	print("Export Name: %s" % export_name)
	var export_name_demo = ProjectSettings.get_setting_with_override("application/config/name.demo")
	# show "Godot Export Test - Demo"
	print("Export Name.demo: %s" % export_name_demo)
	
	
	# :HACK: to manually apply the feature override
	self._application_config_name = ProjectSettings.get_setting( NAME )
	for f in features:
		var s = ProjectSettings.get_setting("%s.%s" % [ NAME, f ], null)
		if s != null:
			print("Found %s overide for .%s -> %s" % [ NAME, f, s])
			ProjectSettings.set_setting(NAME, s)

func _export_end() -> void:
	if !self._application_config_name.is_empty():
		ProjectSettings.set_setting(NAME, self._application_config_name)
		
	pass
	
func _begin_customize_scenes(platform: EditorExportPlatform, features: PackedStringArray) -> bool:
	return true


func _customize_scene(scene: Node, path: String) -> Node:
	print("_customize_scene")
	if scene.has_method("set_project_name_on_export"):
		if OS.has_feature("demo"):
			print("Is DEMO")
		var export_name = ProjectSettings.get_setting_with_override("application/config/name")
		scene.set_project_name_on_export( export_name )
		return scene
		
	return null
	
