_Main()

Func _Main()

    $accounts = FileOpen(@ScriptDir & '\accounts.txt')

	If $accounts = -1 Then
		TrayTip("", "Невозможно открыть файл accounts.txt, завершаю работу скрипта", 3, 1)
		Exit
	EndIf

	While 1
		$line = FileReadLine($accounts)

		If @error = -1 Then
			TrayTip("", "Все строки прочитаны", 3, 1)
			ExitLoop
		EndIf

		$aAccs = StringSplit($line, ';')

        	$username = $aAccs[1]
        	$pass = $aAccs[2]

		TrayTip("", "Запускаю: " & $username, 3, 1)

		$steamPID = Run($steamExe & " -login " & $username & " " & $pass & _
					    " -applaunch 730" & _
					    " -low" & _
					    " -nosound" & _
					    " -novid" & _
                                	    " -nohltv" & _
					    " -nofriendsui" & _
					    " -window -w 640 -h 480" & _
					    " +exec idle.cfg")
        If Not $steamPID Then
            TrayTip("", "Не удалось запустить steam.exe, завершаю работу скрипта", 3, 1)
            Exit
        EndIf

        $hSteam = WinWait("Вход в Steam", '', 30)

        If Not $hSteam Then
            TrayTip("", "Не удалось дождаться окна (Вход в Steam), завершаю работу скрипта", 3, 1)
            Exit
        EndIf
		
	Sleep(10 * 1000)
			
	WEnd

    FileClose($accounts)
EndFunc
