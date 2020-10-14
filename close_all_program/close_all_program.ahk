﻿#SingleInstance, Force
try{
	Menu, Tray, Icon, cross.ico
}
; close time
settimer, auto_close, -30000
DetectHiddenWindows, Off
gui, color, black
gui, font, s12, KaiTi
gui, add, button, w80 x+15 gclose_sleep, &Sleep
gui, add, button, w80 x10 gclose_shutdown, Shut&down
gui, add, button, w80 x+15 gclose_reboot, &Reboot
gui, add, button, w80 x10 gclose_, &Close All
gui, add, button, w80 x+15 gclose_cancel Default, Cance&l
gui,-Caption
gui, show,,Quick Setting

return

close_:
	Menu, Tray, NoIcon
	close_all()
	exitapp
	return
close_shutdown:
	Menu, Tray, NoIcon
	close_all()
	sleep, 300
	shutdown, 1
	return
close_reboot:
	Menu, Tray, NoIcon
	close_all()
	sleep, 300
	shutdown, 2
	return
close_sleep:
	Menu, Tray, NoIcon
	DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 0)
	exitapp
	return
close_cancel:
	Menu, Tray, NoIcon
	gui, destroy
	tooltip, Bye
	sleep, 200
	keywait, l
	exitapp
	return
auto_close:
	exitapp
	return
	
close_all:
	WinGet, mylist, list
	;;;;;;;;;;;;;;;;;;; except
	WinGet, mylist_except, list, Backup and Sync
	except := []
	Loop % mylist_except {
		except.Push(mylist_except%A_Index%)
	}
	;;;;;;;;;;;;;;;;;;;
	Loop % mylist {
		hwnd := mylist%A_Index%
		;find except
		for index, element in except
		{
			if(element==hwnd)
				break
		}
		;;;;;;;;;;;;;;
		if(element==hwnd){ ;except
			continue
		}
		else{
			WinClose % "ahk_id" hwnd
		}
	}
	tooltip,Finish!!!
	shutdown()
	sleep, 2000
	shutdown()
	return



shutdown()
{
	if WinExist("Shut Down Windows"){
		WinClose,Shut Down Windows 
	}
}


close_all(){
		WinGet, mylist, list
		;;;;;;;;;;;;;;;;;;; except
		WinGet, mylist_except, list, Backup and Sync
		except := []
		Loop % mylist_except {
			except.Push(mylist_except%A_Index%)
		}
		;;;;;;;;;;;;;;;;;;;
		Loop % mylist {
			hwnd := mylist%A_Index%
			;find except
			for index, element in except
			{
				if(element==hwnd)
					break
			}
			;;;;;;;;;;;;;;
			if(element==hwnd){ ;except
				continue
			}
			else{
				WinClose % "ahk_id" hwnd
			}
		}
		tooltip,Finish!!!
		shutdown()
		sleep, 2000
		shutdown()
	
}

