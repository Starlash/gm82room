globalvar sprites,backgrounds,objects,sprloaded,bgloaded,objloaded,objspr,objvis,objdepth;

globalvar gamename,roomname,roomcode,roomspeed,roomcaption,roompersistent,clearscreen,clearview,settings,gridx,gridy;

globalvar backgroundcolor,bg_visible,bg_is_foreground,bg_source,bg_xoffset,bg_yoffset,bg_tile_h,bg_tile_v,bg_hspeed,bg_vspeed,bg_stretch;
globalvar vw_enabled,vw_visible,vw_x,vw_y,vw_w,vw_h,vw_xp,vw_yp,vw_wp,vw_hp,vw_follow,vw_hspeed,vw_vspeed,vw_hbor,vw_vbor;
globalvar layers;
globalvar paths,pathnum;

globalvar extended_instancedata,viewspeedcorrection;

var f,p,i,inst,layer,map,tileid;

draw_loader("Loading project...",0)

//find room
if (parameter_count()) {
    //summoned from gm82
    dir=parameter_string(1)
} else {
    //clicked on
    dir=filename_dir(get_open_filename("GM8.2 Room|room.txt","room.txt"))
    window_default()
}

if (dir="") {
    //this is for faster testing on my computer :)
    if (working_directory!=program_directory) dir="C:\Stuff\github\renex-engine\rooms\rmDemo3"
    if (!file_exists(dir+"\room.txt")) {
        //shrug
        game_end()
        return 0
    }
}

roomname=filename_name(dir)

draw_loader("Loading project...",0.125)

dir+="\"
root=directory_previous(directory_previous(dir))
gamename=filename_change_ext(file_find_first(root+"*.gm82",0),"") file_find_close()
room_caption+=" - "+roomname
set_application_title(roomname+" - Room Editor")
global.default_caption=room_caption

//set up thumbnails
directory_create(root+"cache")
if (directory_exists(root+"cache\backgrounds") && directory_exists(root+"cache\sprites")) {
    icon_mode=1
}
fn=root+"cache\background.bmp" export_include_file_location("background.bmp",fn) background_menuicon=N_Menu_LoadBitmap(fn)
fn=root+"cache\folder.bmp" export_include_file_location("folder.bmp",fn) folder_menuicon=N_Menu_LoadBitmap(fn)
fn=root+"cache\object.bmp" export_include_file_location("object.bmp",fn) object_menuicon=N_Menu_LoadBitmap(fn)

//load assets
objlookup=ds_map_create()
bglookup=ds_map_create()

sprites=file_text_read_list(root+"sprites\index.yyd",noone,true)
sprites_length=ds_list_size(sprites)
sprloaded[sprites_length]=0

backgrounds=file_text_read_list(root+"backgrounds\index.yyd",bglookup,true)
backgrounds_length=ds_list_size(backgrounds)
bgloaded[backgrounds_length]=0
load_background_tree(root+"backgrounds\tree.yyd")

objects=file_text_read_list(root+"objects\index.yyd",objlookup,true)
objects_length=ds_list_size(objects)
objloaded[objects_length]=0
load_object_tree(root+"objects\tree.yyd")


//load main project file
project=ds_map_create()
ds_map_read_ini(project,dir+"..\..\"+file_find_first(dir+"..\..\*.gm82",0)) file_find_close()

    gm82version=real(ds_map_find_value(project,"gm82_version"))
    if (gm82version==0) viewspeedcorrection=max_uint else viewspeedcorrection=0
    extended_instancedata=(gm82version>1)

ds_map_destroy(project)


//look for paths
load_paths()


//read room settings
settings=ds_map_create()
ds_map_read_ini(settings,dir+"room.txt")

backgroundcolor=real(ds_map_find_value(settings,"bg_color"))
clearscreen=real(ds_map_find_value(settings,"clear_screen"))
clearview=real(ds_map_find_value(settings,"clear_view"))
roomwidth=real(ds_map_find_value(settings,"width"))
roomheight=real(ds_map_find_value(settings,"height"))
roomspeed=real(ds_map_find_value(settings,"roomspeed"))
roompersistent=real(ds_map_find_value(settings,"roompersistent"))
gridx=real(ds_map_find_value(settings,"snap_x"))
gridy=real(ds_map_find_value(settings,"snap_y"))
roomcaption=ds_map_find_value(settings,"caption")
vw_enabled=real(ds_map_find_value(settings,"views_enabled"))

roomcode=string_replace_all(file_text_read_all(dir+"code.gml"),chr(13),"")
if (string_replace_all(string_replace_all(string_replace_all(roomcode,chr(9),""),lf,"")," ","")="") roomcode=""

for (i=0;i<8;i+=1) {
    k=string(i)
    bg_visible[i]=real(ds_map_find_value(settings,"bg_visible"+k))
    bg_is_foreground[i]=real(ds_map_find_value(settings,"bg_is_foreground"+k))
    bg_source[i]=ds_map_find_value(settings,"bg_source"+k)
    bg_tex[i]=get_background(bg_source[i])
    bg_xoffset[i]=real(ds_map_find_value(settings,"bg_xoffset"+k))
    bg_yoffset[i]=real(ds_map_find_value(settings,"bg_yoffset"+k))
    bg_tile_h[i]=real(ds_map_find_value(settings,"bg_tile_h"+k))
    bg_tile_v[i]=real(ds_map_find_value(settings,"bg_tile_v"+k))
    bg_hspeed[i]=real(ds_map_find_value(settings,"bg_hspeed"+k))
    bg_vspeed[i]=real(ds_map_find_value(settings,"bg_vspeed"+k))
    bg_stretch[i]=real(ds_map_find_value(settings,"bg_stretch"+k))

    vw_visible[i]=real(ds_map_find_value(settings,"view_visible"+k))
    vw_x[i]=real(ds_map_find_value(settings,"view_xview"+k))
    vw_y[i]=real(ds_map_find_value(settings,"view_yview"+k))
    vw_w[i]=real(ds_map_find_value(settings,"view_wview"+k))
    vw_h[i]=real(ds_map_find_value(settings,"view_hview"+k))
    vw_xp[i]=real(ds_map_find_value(settings,"view_xport"+k))
    vw_yp[i]=real(ds_map_find_value(settings,"view_yport"+k))
    vw_wp[i]=real(ds_map_find_value(settings,"view_wport"+k))
    vw_hp[i]=real(ds_map_find_value(settings,"view_hport"+k))
    vw_hbor[i]=real(ds_map_find_value(settings,"view_fol_hbord"+k))
    vw_vbor[i]=real(ds_map_find_value(settings,"view_fol_vbord"+k))
    vw_hspeed[i]=real(ds_map_find_value(settings,"view_fol_hspeed"+k))-viewspeedcorrection
    vw_vspeed[i]=real(ds_map_find_value(settings,"view_fol_vspeed"+k))-viewspeedcorrection
    vw_follow[i]=ds_map_find_value(settings,"view_fol_target"+k)
}


//load tiles
progress=0.25
time=current_time
layers=file_text_read_list(dir+"layers.txt",noone,false)
layersize=ds_list_size(layers)
if (layersize) {
    for (i=0;i<layersize;i+=1) {
        layer=real(ds_list_find_value(layers,i))
        ds_list_replace(layers,i,layer)
        f=file_text_open_read_safe(dir+string(layer)+".txt") if (f) do {str=file_text_read_string(f) file_text_readln(f)
            o=instance_create(0,0,tileholder) get_uid(o)

            string_token_start(str,",")
            o.bgname=string_token_next()
            o.x=real(string_token_next())
            o.y=real(string_token_next())
            tileu=real(string_token_next())
            tilev=real(string_token_next())
            o.tilew=real(string_token_next())
            o.tileh=real(string_token_next())

            o.bg=get_background(o.bgname)
            if (micro_optimization_bgid!=noone && o.tilew && o.tileh) {
                //check that the tile is inside the background
                bgw=background_get_width(bg_background[micro_optimization_bgid])
                bgh=background_get_height(bg_background[micro_optimization_bgid])
                if (tileu<bgw && tilev<bgh) {
                    o.tile=tile_add(o.bg,tileu,tilev,o.tilew,o.tileh,o.x,o.y,layer)
                    o.tlayer=layer

                    //add tiles to unique tile hashmap
                    map=bg_tilemap[micro_optimization_bgid]
                    tileid=string(tileu)+","+string(tilev)+","+string(o.tilew)+","+string(o.tileh)
                    if (!ds_map_exists(map,tileid)) {
                        //add this tile
                        list=ds_list_create()
                        ds_list_add(list,tileu)
                        ds_list_add(list,tilev)
                        ds_list_add(list,o.tilew)
                        ds_list_add(list,o.tileh)
                        ds_map_add(map,tileid,list)
                    }
                    o.image_xscale=o.tilew
                    o.image_yscale=o.tileh

                    if (extended_instancedata) {
                        string_token_next() //skip "locked" flag
                        o.tilesx=real(string_token_next())
                        o.tilesy=real(string_token_next())
                        tileblend=real(string_token_next())

                        o.image_xscale*=o.tilesx
                        o.image_yscale*=o.tilesy
                        o.image_alpha=floor(tileblend/$1000000)/$ff
                        o.image_blend=tileblend&$ffffff

                        tile_set_scale(o.tile,o.tilesx,o.tilesy)
                        tile_set_alpha(o.tile,o.image_alpha)
                        tile_set_blend(o.tile,o.image_blend)
                    }
                } else with (o) instance_destroy()
            } else with (o) instance_destroy()

            if (current_time>time) {
                time=current_time
                progress=(progress*9+0.25+0.5*i/layersize)/10
                draw_loader("Loading tiles...",progress)
            }
        } until (file_text_eof(f)) file_text_close(f)
    }
} else add_tile_layer()


//load instances
time=current_time
f=file_text_open_read_safe(dir+"instances.txt") if (f) do {str=file_text_read_string(f) file_text_readln(f)
    if (str!="") {
        o=instance_create(0,0,instance) get_uid(o)

        string_token_start(str,",")
        o.objname=string_token_next()
        o.x=real(string_token_next())
        o.y=real(string_token_next())
        o.code=string_token_next()

        o.obj=get_object(o.objname)

        o.depth=objdepth[o.obj]
        o.sprite_index=objspr[o.obj]

        o.sprw=sprite_get_width(o.sprite_index)
        o.sprh=sprite_get_height(o.sprite_index)
        o.sprox=sprite_get_xoffset(o.sprite_index)
        o.sproy=sprite_get_yoffset(o.sprite_index)

        if (extended_instancedata) {
            string_token_next() //skip "locked" flag
            o.image_xscale=real(string_token_next())
            o.image_yscale=real(string_token_next())
            o.image_blend=real(string_token_next())
            o.image_angle=real(string_token_next())

            o.image_alpha=floor(o.image_blend/$1000000)/$ff
            o.image_blend=o.image_blend&$ffffff
        }

        if (o.code!="") o.code=file_text_read_all(dir+o.code+".gml")

        if (current_time>time) {
            time=current_time
            progress=(progress*9+1)/10
            draw_loader("Loading instances...",progress)
        }
    }
} until (file_text_eof(f)) file_text_close(f)

//load last object as per gm8 standard
//make sure it's one that exists
i=objects_length
do {i-=1 o=ds_list_find_value(objects,objects_length-i)} until (i==0 || o!="")
if (i!=0) get_object(o)

return 1
