class_name HighScoreSave
extends Resource

# THE "@export" PART IS NECESSARY!
@export var high_score: int = 0

const SAVE_PATH: String = "user://high_score_save.tres"

func save() -> void:
	ResourceSaver.save(self, SAVE_PATH)

# If there is a save, load the save. If there is no save, create a save.
static func load_or_create() -> HighScoreSave:
	var res: HighScoreSave

	if FileAccess.file_exists(SAVE_PATH):
		res = load(SAVE_PATH) as HighScoreSave
	else:
		res = HighScoreSave.new()

	return res
