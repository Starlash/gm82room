var str;

str=string(argument[0])

if (string_length(str)>8192) return "size limit"

if (string_pos("execute_",str)) return "execute_"
if (string_pos("globalvar ",str)) return "globalvar "
if (string_pos("registry_",str)) return "registry_"
if (string_pos("action_",str)) return "action_"
if (string_pos("font_",str)) return "font_"
if (string_pos("effect_",str)) return "effect_"
if (string_pos("YoYo_",str)) return "YoYo_"
if (string_pos("MCI_",str)) return "MCI_"
if (string_pos("cd_",str)) return "cd_"
if (string_pos("display_",str)) return "display_"
if (string_pos("screen_",str)) return "screen_"
if (string_pos("window_",str)) return "window_"
if (string_pos("parameter_",str)) return "parameter_"
if (string_pos("external_",str)) return "external_"
if (string_pos("_include",str)) return "_include"
if (string_pos("_write",str)) return "_write"
if (string_pos("mplay_",str)) return "mplay_"
if (string_pos("game_",str)) return "game_"
if (string_pos("highscore_",str)) return "highscore_"
if (string_pos("ini_",str)) return "ini_"
if (string_pos("mp_",str)) return "mp_"
if (string_pos("file_",str)) return "file_"
if (string_pos("joystick_",str)) return "joystick_"
if (string_pos("message_",str)) return "message_"
if (string_pos("part_sy",str)) return "part_sy"
if (string_pos("part_ty",str)) return "part_ty"
if (string_pos("part_pa",str)) return "part_pa"
if (string_pos("part_em",str)) return "part_em"
if (string_pos("part_de",str)) return "part_de"
if (string_pos("part_ch",str)) return "part_ch"
if (string_pos("part_at",str)) return "part_at"
if (string_pos("room_",str)) return "room_"
if (string_pos("script_",str)) return "script_"
if (string_pos("sound_",str)) return "sound_"
if (string_pos("splash_",str)) return "splash_"
if (string_pos("transition_",str)) return "transition_"
if (string_pos("timeline_",str)) return "timeline_"
if (string_pos("socket_",str)) return "socket_"
if (string_pos("httprequest_",str)) return "httprequest_"
if (string_pos("N_Menu_",str)) return "N_Menu_"
if (string_pos("application_surface",str)) return "application_surface"
if (string_pos("buffer_",str)) return "buffer_"
if (string_pos("event_",str)) return "event_"
if (string_pos("object_",str)) return "object_"
if (string_pos("__gm82",str)) return "__gm82"
if (string_pos("instance_create",str)) return "instance_create"
if (string_pos("surface_",str)) return "surface_"
if (string_pos("clipboard_",str)) return "clipboard_"
if (string_pos("string_byte_at",str)) return "string_byte_at"
if (string_pos("ds_map_read(chr(13))",str)) return "ds_map_read(chr(13))"
if (string_pos("variable_",str)) return "variable_"

return ""