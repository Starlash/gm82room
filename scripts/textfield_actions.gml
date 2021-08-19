///apply
var val;

down=0
if (active) {
    active=0
    if (text!="") switch (action) {
        case "grid x": {gridx=median(1,real(text),roomwidth ) text=string(gridx)}break
        case "grid y": {gridy=median(1,real(text),roomheight) text=string(gridy)}break

        case "room width" : {val=clamp(round(real(text)),1,999999) undo_global("roomwidth")  roomwidth=val }break
        case "room height": {val=clamp(round(real(text)),1,999999) undo_global("roomheight") roomheight=val}break
        case "room speed" : {val=clamp(round(real(text)),1,9999  ) undo_global("roomspeed")  roomspeed=val }break
        case "room caption": {roomcaption=text}break

        case "inst x"    : {val=round(real(text)) with (instance) if (sel) {x=val do_change_undo()}}break
        case "inst y"    : {val=round(real(text)) with (instance) if (sel) {y=val do_change_undo()}}break
        case "inst xs"   : {val=real(text) with (instance) {if (sel) image_xscale=val if (abs(image_xscale*sprw)<1) image_xscale=1/sprw do_change_undo()}}break
        case "inst ys"   : {val=real(text) with (instance) {if (sel) image_yscale=val if (abs(image_yscale*sprw)<1) image_yscale=1/sprw do_change_undo()}}break
        case "inst ang"  : {val=real(text) with (instance) if (sel) image_angle=val do_change_undo()}break
        case "inst col"  : {val=round(real(text)) with (instance) if (sel) image_blend=val do_change_undo()}break
        case "inst alpha": {val=real(text)/255    with (instance) if (sel) image_alpha=val do_change_undo()}break

        case "tile x"    : {val=round(real(text)) with (tileholder) if (sel) {x=val tile_set_position(tile,x,y) do_change_undo()}}break
        case "tile y"    : {val=round(real(text)) with (tileholder) if (sel) {y=val tile_set_position(tile,x,y) do_change_undo()}}break
        case "tile xs"   : {val=real(text) with (tileholder) if (sel) {image_xscale=val*tilew if (abs(image_xscale)<1) image_xscale=1 tilesx=image_xscale/tilew tile_set_scale(tile,tilesx,tilesy) do_change_undo()}}break
        case "tile ys"   : {val=real(text) with (tileholder) if (sel) {image_yscale=val*tileh if (abs(image_yscale)<1) image_yscale=1 tilesy=image_yscale/tileh tile_set_scale(tile,tilesx,tilesy) do_change_undo()}}break
        case "tile col"  : {val=round(real(text)) with (tileholder) if (sel) {image_blend=val tile_set_blend(tile,image_blend) do_change_undo()}}break
        case "tile alpha": {val=real(text)/255    with (tileholder) if (sel) {image_alpha=val tile_set_alpha(tile,image_alpha) do_change_undo()}}break

        case "layer depth": {val=clamp(round(real(text)),-1000000000,1000000000) change_tile_layer(val)}break

        case "bgcol"  : {val=round(real(text)) undo_global("background_color") background_color=val}break
        case "bg xpos": {val=round(real(text)) bg_xoffset[bg_current]=val}break
        case "bg ypos": {val=round(real(text)) bg_yoffset[bg_current]=val}break
        case "bg hsp" : {val=round(real(text)) bg_hspeed [bg_current]=val}break
        case "bg vsp" : {val=round(real(text)) bg_vspeed [bg_current]=val}break

        case "view x": {val=round(real(text)) vw_x[vw_current]=val}break
        case "view y": {val=round(real(text)) vw_y[vw_current]=val}break
        case "view w": {val=round(real(text)) if (val=0) {val=16 text="16"} vw_w[vw_current]=val}break
        case "view h": {val=round(real(text)) if (val=0) {val=16 text="16"} vw_h[vw_current]=val}break

        case "view xp": {val=round(real(text)) vw_xp[vw_current]=val}break
        case "view yp": {val=round(real(text)) vw_yp[vw_current]=val}break
        case "view wp": {val=round(real(text)) if (val=0) {val=16 text="16"} vw_wp[vw_current]=val}break
        case "view hp": {val=round(real(text)) if (val=0) {val=16 text="16"} vw_hp[vw_current]=val}break

        case "view hbor"  : {val=round(real(text)) vw_hbor  [vw_current]=val}break
        case "view vbor"  : {val=round(real(text)) vw_vbor  [vw_current]=val}break
        case "view hspeed": {val=round(real(text)) vw_hspeed[vw_current]=val}break
        case "view vspeed": {val=round(real(text)) vw_vspeed[vw_current]=val}break
    }
    event_user(4)
}
