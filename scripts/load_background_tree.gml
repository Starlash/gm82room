var f,str,tab,resname,path,curindent;

globalvar bgmenu,bgmenuitems;

tab=chr(9)

bgmenuitems=ds_map_create()
bgmenu=N_Menu_CreatePopupMenu()
background=N_Menu_LoadBitmap("background.bmp")

ds_map_add(bgmenuitems,N_Menu_AddItem(bgmenu,"(no background)",""),"<undefined>")

path[0]=bgmenu
curindent=0

a=argument0

if (file_exists(argument0)) {
    f=file_text_open_read(argument0) do {
        str=file_text_read_string(f)
        file_text_readln(f)
        if (str!="") {
            curindent=string_count(tab,str)
            str=string_replace_all(str,tab,"")
            resname=string_delete(str,1,1)
            if (string_char_at(str,1)=="+") {
                //group
                submenu=N_Menu_CreatePopupMenu()
                N_Menu_ItemSetBitmap(path[curindent],N_Menu_AddMenu(path[curindent],submenu,resname),folder)
                curindent+=1
                path[curindent]=submenu
            } else {
                //resource
                item=N_Menu_AddItem(path[curindent],resname,"")
                N_Menu_ItemSetBitmap(path[curindent],item,background)
                ds_map_add(bgmenuitems,item,resname)
            }
        }
    } until (file_text_eof(f)) file_text_close(f)
}