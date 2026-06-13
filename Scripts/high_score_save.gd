class_name HighScoreSave extends Resource

const SAVE_PATH: String = "user://high_score_save"
var high_score: int

func save() -> void:
	ResourceSaver.save(self, SAVE_PATH)

static func load_or_create() -> HighScoreSave:
	var res: HighScoreSave

	if FileAccess.file_exists(SAVE_PATH):
		res = load(SAVE_PATH) as HighScoreSave
	else:
		res = HighScoreSave.new()

	return res
