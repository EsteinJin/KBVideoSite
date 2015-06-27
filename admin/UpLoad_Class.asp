<%

Dim StreamT
Class AnUpLoad
	Private Form, Fils
	Private vCharSet, vMaxSize, vSingleSize, vErr, vVersion, vTotalSize, vExe, pID, vOP, vErrExe,vboundary, vLostTime, vMode, vFileCount,StreamOpened
	
	Public Property Let Mode(ByVal value)
		vMode = value
	End Property
	
	Public Property Let MaxSize(ByVal value)
		vMaxSize = value
	End Property
	
	Public Property Let SingleSize(ByVal value)
		vSingleSize = value
	End Property
	
	Public Property Let Exe(ByVal value)
		vExe = LCase(value)
	End Property
	
	Public Property Let CharSet(ByVal value)
		vCharSet = value
	End Property
	
	Public Property Get ErrorID()
		ErrorID = vErr
	End Property
	
	Public Property Get FileCount()
		FileCount = Fils.count
	End Property
	
	Public Property Get Description()
		Description = GetErr(vErr)
	End Property
	
	Public Property Get Version()
		Version = vVersion
	End Property
	
	Public Property Get TotalSize()
		TotalSize = vTotalSize
	End Property
	
	Public Property Get ProcessID()
		ProcessID = pID
	End Property
	
	Public Property Let openProcesser(ByVal value)
		vOP = value
	End Property
	
	Public Property Get LostTime()
		LostTime = vLostTime
	End Property

	
	Private Sub Class_Initialize()
		set Form = server.createobject("Scripting.Dictionary")
		set Fils = server.createobject("Scripting.Dictionary")
		Set StreamT = server.CreateObject("Adodb.stream")
		vVersion = "艾恩ASP无组件上传类V11.03.25"
		vMaxSize = -1
		vSingleSize = -1
		vErr = -1
		vExe = ""
		vTotalSize = 0
		vCharSet = "gb2312"
		vOP=false
		pID="AnUpload"
		setApp "",0,0,""
		vMode = 0
		StreamOpened=false
	End Sub
	
	Private Sub Class_Terminate()
		Dim f
		Form.RemoveAll()
		For each f in Fils 
			Fils(f).value=empty
			Set Fils(f) = Nothing
		Next
		Fils.RemoveAll()
		Set Form = Nothing
		Set Fils = Nothing
		if StreamOpened then StreamT.close()
		Set StreamT = Nothing
	End Sub

	Public Sub GetData()
		Dim time1
		time1 = timer()
		if vOP And trim(request.querystring("processid"))<>"" then pID=request.querystring("processid")
		Dim value, str, bcrlf, fpos, sSplit, slen, istart,ef
		Dim TotalBytes,tempdata,BytesRead,ChunkReadSize,PartSize,DataPart,formend, formhead, startpos, endpos, formname, FileName, fileExe, valueend, NewName,localname,type_1,contentType
		TotalBytes = Request.TotalBytes
		ef = false
		If checkEntryType = false Then ef = true : vErr = 2
		
		If Not ef Then
			If vMaxSize > 0 And TotalBytes > vMaxSize Then ef = true : vErr = 1
		End If
		If ef Then Exit Sub
		If vMode = 0 Then
			vTotalSize = 0 
			StreamT.Type = 1
			StreamT.Mode = 3
			StreamT.Open
			StreamOpened = true
			BytesRead = 0
			ChunkReadSize = 1024 * 16
			Do While BytesRead < TotalBytes
				PartSize = ChunkReadSize
				If PartSize + BytesRead > TotalBytes Then PartSize = TotalBytes - BytesRead
				DataPart = Request.BinaryRead(PartSize)
				StreamT.Write DataPart
				BytesRead = BytesRead + PartSize
				setApp "uploading",TotalBytes,BytesRead,""
			Loop
			setApp "uploaded",TotalBytes,BytesRead,""
			StreamT.Position = 0
			tempdata = StreamT.Read
		Else
			tempdata = Request.BinaryRead(TotalBytes)
		End If
		bcrlf = ChrB(13) & ChrB(10)
		fpos = InStrB(1, tempdata, bcrlf)
        sSplit = MidB(tempdata, 1, fpos - 1)
		slen = LenB(sSplit)
		istart = slen + 2
        Do
            formend = InStrB(istart, tempdata, bcrlf & bcrlf)
            formhead = MidB(tempdata, istart, formend - istart)
            str = Bytes2Str(formhead)
            startpos = InStr(str, "name=""") + 6
            endpos = InStr(startpos, str, """")
            formname = LCase(Mid(str, startpos, endpos - startpos))
            valueend = InStrB(formend + 3, tempdata, sSplit)
			If InStr(str, "filename=""") > 0 Then
				startpos = InStr(str, "filename=""") + 10
				endpos = InStr(startpos, str, """")
				type_1=instr(endpos,lcase(str),"content-type")
				contentType=trim(mid(str,type_1+13))
				FileName = Mid(str, startpos, endpos - startpos)
				If Trim(FileName) <> "" Then
					FileName = Replace(FileName, "/", "\")
					FileName = Replace(FileName, chr(0), "")
					LocalName = FileName
					FileName = Mid(FileName, InStrRev(FileName, "\") + 1)
					If instr(FileName,".")>0 Then
						fileExe = Split(FileName, ".")(UBound(Split(FileName, ".")))
					else
						fileExe = ""
					End If
					If vExe <> "" Then '判断扩展名
						If checkExe(fileExe) = True Then
							vErr = 3
							vErrExe = fileExe
							tempdata = empty
							Exit Sub
						End If
					End If
					NewName = FileName
					'Getname()
					'NewName = NewName & "." & fileExe
					vTotalSize = vTotalSize + valueend - formend - 6
					If vSingleSize > 0 And (valueend - formend - 6) > vSingleSize Then '判断上传单个文件大小
						vErr = 5
						tempdata = empty
						Exit Sub
					End If
					If vMaxSize > 0 And vTotalSize > vMaxSize Then '判断上传数据总大小
						vErr = 1
						tempdata = empty
						Exit Sub
					End If
					If Fils.Exists(formname) Then
						vErr = 4
						tempdata = empty
						Exit Sub
					Else
						Dim fileCls:set fileCls= new UploadFileEx
						fileCls.ContentType=contentType
						fileCls.Size = (valueend - formend - 6)
						fileCls.Position = (formend + 3)
						fileCls.FormName = formname
						fileCls.NewName = NewName
						fileCls.FileName = FileName
						fileCls.LocalName = FileName
						fileCls.extend=split(NewName,".")(ubound(split(NewName,".")))
						Fils.Add formname, fileCls
						Set fileCls = Nothing
					End If
				End If
			Else
				value = MidB(tempdata, formend + 4, valueend - formend - 6)
				If Form.Exists(formname) Then
					Form(formname) = Form(formname) & "," & Bytes2Str(value)
				Else
					Form.Add formname, Bytes2Str(value)
				End If
			End If
            istart = valueend + 2 + slen
        Loop Until (istart + 2) >= LenB(tempdata)
		vErr = 0
		tempdata = empty
		vLostTime = FormatNumber((timer-time1)*1000,2)
	End Sub
	
	Public sub setApp(stp,total,current,desc)
		Application.lock()
		Application(pID)="{ID:""" & pID & """,step:""" & stp & """,total:" & total & ",now:" & current & ",description:""" & desc & """,dt:""" & now() & """}"
		Application.unlock()
	end sub

	Private Function checkExe(ByVal ex)
		Dim notIn: notIn = True
		If vExe="*" then
			notIn=false 
		elseIf InStr(1, vExe, "|") > 0 Then
			Dim tempExe: tempExe = Split(vExe, "|")
			Dim I: I = 0
			For I = 0 To UBound(tempExe)
				If LCase(ex) = tempExe(I) Then
					notIn = False
					Exit For
				End If
			Next
		Else
			If vExe = LCase(ex) Then
				notIn = False
			End If
		End If
		checkExe = notIn
	End Function
	

	Public Function GetSize(ByVal Size)
		If Size < 1024 Then
			GetSize = FormatNumber(Size, 2) & "B"
		ElseIf Size >= 1024 And Size < 1048576 Then
			GetSize = FormatNumber(Size / 1024, 2) & "KB"
		ElseIf Size >= 1048576 Then
			GetSize = FormatNumber((Size / 1024) / 1024, 2) & "MB"
		End If
	End Function
	

	Private Function Bytes2Str(ByVal byt)
		If LenB(byt) = 0 Then
			Bytes2Str = ""
			Exit Function
		End If
		Dim mystream, bstr
		Set mystream =server.createobject("ADODB.Stream")
		mystream.Type = 2
		mystream.Mode = 3
		mystream.Open
		mystream.WriteText byt
		mystream.Position = 0
		mystream.CharSet = vCharSet
		mystream.Position = 2
		bstr = mystream.ReadText()
		mystream.Close
		Set mystream = Nothing
		Bytes2Str = bstr
	End Function
	

	Private Function GetErr(ByVal Num)
		Select Case Num
			Case 0
				GetErr = "Data Handled Successfully!"
			Case 1
				GetErr = "File Size over limited" & GetSize(vMaxSize) & "You can change MaxSize property"
			Case 2
				GetErr = "Please set up upload form enctype as multipart/form-data or method set as post, this upload failed"
			Case 3
				GetErr = "Known error extention detected" & vErrExe & ")Allowed Extension should be" & Replace(vExe, "|", ",") 
			Case 4
				GetErr = "same name property or file ."
			Case 5
				GetErr = "File size over limited" & GetSize(vSingleSize) 
		End Select
	End Function
	
	'==============================
	'根据日期生成随机文件名
	'==============================
	Private Function Getname()
		Dim y, m, d, h, mm, S, r
		Randomize
		y = Year(Now)
		m = right("0" & Month(Now),2)
		d = right("0" & Day(Now),2)
		h = right("0" & Hour(Now),2)
		mm =right("0" & Minute(Now),2)
		S = right("0" & Second(Now),2)
		r = 0
		r = CInt(Rnd() * 10000)
		S = right("0000" & r,4)
		Getname = y & m & d & h & mm & S & r
	End Function
	

	Private Function checkEntryType()
		Dim ContentType, ctArray, bArray,RequestMethod
		RequestMethod=trim(LCase(Request.ServerVariables("REQUEST_METHOD")))
		if RequestMethod="" or RequestMethod<>"post" then
			checkEntryType = False
			exit function
		end if
		ContentType = LCase(Request.ServerVariables("HTTP_CONTENT_TYPE"))
		ctArray = Split(ContentType, ";")
		if ubound(ctarray)>=0 then
			If Trim(ctArray(0)) = "multipart/form-data" Then
			checkEntryType = True
			vboundary = Split(ContentType,"boundary=")(1)
			Else
			checkEntryType = False
			End If
		else
			checkEntryType = False
		end if
	End Function
	

	Public Function Forms(ByVal formname)
		If trim(formname) = "-1" Then
			Set Forms = Form
		Else
			If Form.Exists(LCase(formname)) Then
				Forms = Form(LCase(formname))
			Else
				Forms = ""
			End If
		End If
	End Function
	

	Public Function Files(ByVal formname)
		If trim(formname) = "-1" Then
			Set Files = Fils
		Else
			If Fils.Exists(LCase(formname)) Then
				Set Files = Fils(LCase(formname))
			Else
				Set Files = Nothing
			End If
		End If
	End Function
End Class

Class UploadFileEx
	Private mvarFormName , mvarNewName , mvarLocalName , mvarFileName , mvarUserSetName , mvarContentType ,mException,mvarPosition
	Private mvarSize , mvarValue , mvarPath , mvarExtend ,mvarWidth, mvarHeight
	
	Public Property Let Extend(ByVal vData )
		mvarExtend = vData
	End Property
	Public Property Get Extend() 
		Extend = mvarExtend
	End Property

	Public Property Get Width() 
		Width = mvarWidth
	End Property
	
	Public Property Get Height() 
		Height = mvarHeight
	End Property
	
		
	Public Property Let Path(ByVal vData )
		mvarPath = vData
	End Property
	Public Property Get Path() 
		Path = mvarPath
	End Property
	
	Public Property Get Exception() 
		Exception = mException
	End Property
	
	Public Property Let Value(ByVal vData )
		mvarValue = vData
	End Property
	
	Public Property Get Value() 
		Value = mvarValue
	End Property
	
	Public Property Let Size(ByVal vData )
		mvarSize = vData
	End Property
	Public Property Get Size() 
		Size = mvarSize
	End Property

	Public Property Let Position(ByVal vData )
		mvarPosition = vData
	End Property
	Public Property Get Position() 
		Size = mvarPosition
	End Property
		
	Public Property Let ContentType(ByVal vData )
		mvarContentType = vData
	End Property
	Public Property Get ContentType() 
		ContentType = mvarContentType
	End Property
	
	Public Property Let UserSetName(ByVal vData )
		mvarUserSetName = vData
	End Property
	Public Property Get UserSetName() 
		UserSetName = mvarUserSetName
	End Property
	
	Public Property Let FileName(ByVal vData )
		mvarFileName = vData
	End Property
	Public Property Get FileName() 
		FileName = mvarFileName
	End Property
	
	Public Property Let LocalName(ByVal vData )
		mvarLocalName = vData
	End Property
	Public Property Get LocalName() 
		LocalName = mvarLocalName
	End Property
	
	Public Property Let NewName(ByVal vData )
		mvarNewName = vData
	End Property
	Public Property Get NewName() 
		NewName = mvarNewName
	End Property
	
	Public Property Let FormName(ByVal vData )
		mvarFormName = vData
	End Property
	Public Property Get FormName() 
		FormName = mvarFormName
	End Property
	
	Private Sub Class_Initialize()
		mvarSize =0
		mvarWidth = 0
		mvarHeight = 0
	End Sub
	
	Public Function SaveToFile(ByVal Path , byval tOption, byval OverWrite)
		On Error Resume Next
		Dim IsP 
		IsP = (InStr(Path, ":") = 2)
		If Not IsP Then Path = Server.MapPath(Path)
		Path = Replace(Path, "/", "\")
		If Mid(Path, Len(Path) - 1) <> "\" Then Path = Path + "\"
		CreateFolder Path
		mvarPath = Path
		If tOption = 1 Then
			Path = Path & mvarLocalName: mvarFileName = mvarLocalName
		Else
			If tOption = -1 And mvarUserSetName <> "" Then
				Path = Path & mvarUserSetName & "." & mvarExtend: mvarFileName = mvarUserSetName & "." & mvarExtend
			Else
				Path = Path & mvarNewName: mvarFileName = mvarNewName
			End If
		End If
		If Not OverWrite Then
			Path = GetFilePath()
		End If
		Dim tmpStrm
		Set tmpStrm =server.CreateObject("ADODB.Stream")
		tmpStrm.Mode = 3
		tmpStrm.Type = 1
		tmpStrm.Open
		StreamT.Position = mvarPosition
		StreamT.copyto tmpStrm,mvarSize
		tmpStrm.SaveToFile Path, 2
		tmpStrm.Close
		Set tmpStrm = Nothing
		'Set SaveToFile = new ErrorMessage_
		If Not Err Then
			SaveToFile = true
		Else
			SaveToFile = false
			mException=Err.Description
		End If
	End Function
	
	Public Function Save(ByVal Path , byval tOption, byval OverWrite)
		Dim result
		set result = SaveToFile(Path,tOption,OverWrite)
		Save = result.error
		set result = nothing
	End Function
	Public Function GetBytes()
		StreamT.Position = mvarPosition
		GetBytes = StreamT.read(mvarSize)
	End Function
	Private Function CreateFolder(ByVal folderPath )
		Dim oFSO
		Set oFSO = server.CreateObject("Scripting.FileSystemObject")
		Dim sParent 
		sParent = oFSO.GetParentFolderName(folderPath)
		If sParent = "" Then Exit Function
		If Not oFSO.FolderExists(sParent) Then CreateFolder (sParent)
		If Not oFSO.FolderExists(folderPath) Then oFSO.CreateFolder (folderPath)
		Set oFSO = Nothing
	End Function
	
	Private Function GetFilePath() 
		Dim oFSO, Fname , FNameL , i 
		i = 0
		Set oFSO = server.CreateObject("Scripting.FileSystemObject")
		Fname = mvarPath & mvarFileName
		FNameL = Mid(mvarFileName, 1, InStr(mvarFileName, ".") - 1)
		Do While oFSO.FileExists(Fname)
			Fname = mvarPath & FNameL & "(" & i & ")." & mvarExtend
			mvarFileName = FNameL & "(" & i & ")." & mvarExtend
			i = i + 1
		Loop
		Set oFSO = Nothing
		GetFilePath = Fname
	End Function
End Class
%>