#tag Module
Protected Module DemoMultipartForms
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target32Bit or Target64Bit))
	#tag Method, Flags = &h0
		Sub RequestProcess(Request As AloeExpress.Request)
		  // By default, the Request.StaticPath points to an "htdocs" folder.
		  // In this example, we're using an alternate folder.
		  Request.StaticPath = GetFolderItem("").Parent.Child("htdocs").Child("demo-multipart-forms")
		  
		  // If content has been posted...
		  If Request.Method = "POST" Then
		    
		    // Hand the request off to the form processor.
		    Dim FP As New FormProcessor(Request)
		    
		    // This is the folder that files will be uploaded to.
		    FP.UploadFolder = GetFolderItem("").Parent.Child("uploads")
		    
		    // This is an optional prefix that will be added to files that are saved.
		    'FP.FilenamePrefix = AloeExpress.UUIDGenerate
		    
		    // Process the form.
		    FP.Process
		    
		    // Load the template...
		    Dim FI as FolderItem = Request.StaticPath.Child("templates").Child("upload-response.html")
		    Dim Template As String = AloeExpress.FileRead(FI)
		    
		    // Replace tokens.
		    Template = Template.ReplaceAll("[[data]]", FP.FormData.ToString)
		    
		    // Set the response content.
		    Request.Response.Content = Template
		    
		  Else
		    
		    // Map the request to a file.
		    Request.MapToFile
		    
		    // If the request couldn't be mapped to a static file...
		    If Request.Response.Status = "404" Then
		      
		      // Return the standard 404 error response.
		      // You could also use a custom error handler that sets Request.Response.Content.
		      Request.ResourceNotFound
		      
		    Else
		      
		      // Set the Cache-Control header value so that static content is cached for 1 hour.
		      Request.Response.Headers.Value("Cache-Control") = "public, max-age=3600"
		      
		    End If
		    
		  End If
		  
		  
		  
		  
		  
		  
		  
		  
		  
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
