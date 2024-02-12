#tag Module
Protected Module DemoServerThreads
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target32Bit or Target64Bit))
	#tag Method, Flags = &h0
		Sub RequestProcess(Request As AloeExpress.Request)
		  // Demonstrates processing requests when the app is running multiple AE server instances.
		  // Note that while a server is listening on port 64003 (see App.MultipleServerDemo), it isn't
		  // "wired up" in this method. If you send a request to that port, you should get a 
		  // "501 Not Implemented" response.
		  
		  
		  // Route the request based on the port that the request came in on.
		  If Request.Port = 64000 Then
		    DemoHelloWorld.RequestProcess(Request)
		  ElseIf Request.Port = 64001 Then
		    DemoSessions.RequestProcess(Request)
		  ElseIf Request.Port = 64002 Then
		    DemoTemplatesServerSide.RequestProcess(Request)
		  Else 
		    Request.Response.Status = "501 Not Implemented"
		    Request.Response.Content = "The server is not configured to handle requests on port " + Request.Port.ToText + "."
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ServersLaunch()
		  // See the comments in the App.Run event handler for information about this method.
		  
		  
		  // Create AloeExpress ServerThread instances with servers listening on port 64000, 64001, etc.
		  Dim ServerThread1 As New AloeExpress.ServerThread
		  ServerThread1.Server.Port = 64000
		  ServerThread1.Run
		  
		  Dim ServerThread2 As New AloeExpress.ServerThread
		  ServerThread2.Server.Port = 64001
		  ServerThread2.Server.SessionsEnabled = True
		  ServerThread2.Run
		  
		  Dim ServerThread3 As New AloeExpress.ServerThread
		  ServerThread3.Server.Port = 64002
		  ServerThread3.Run
		  
		  Dim ServerThread4 As New AloeExpress.ServerThread
		  ServerThread4.Server.Port = 64003
		  ServerThread4.Run
		  
		  While True
		    app.DoEvents
		  Wend
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
