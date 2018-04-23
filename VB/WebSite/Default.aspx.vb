Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports DevExpress.Web

Partial Public Class _Default
	Inherits System.Web.UI.Page
	Private dataBindingCount As Integer
	Private eventOrder As String
	Protected Sub Page_Init(ByVal sender As Object, ByVal e As EventArgs)
		SynchronizeEditorsWithCookies()

		grid.EnableRowsCache = ASPxCheckBox1.Checked

		If CInt(Fix(combo.Value)) = 0 Then
			CallMethods()
		End If

		AddEventLog("Page Init")
	End Sub

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		If CInt(Fix(combo.Value)) = 1 Then
			CallMethods()
		End If

		AddEventLog("Page Load")
	End Sub
	Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As EventArgs)
		AddEventLog("Page PreRender")
	End Sub
	Protected Sub cbEditCategories_TextChanged(ByVal sender As Object, ByVal e As EventArgs)

	End Sub

	Protected Sub grid_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewClientJSPropertiesEventArgs)
		e.Properties("cpDataBindingCount") = dataBindingCount
		e.Properties("cpEventOrder") = eventOrder

	End Sub
	Protected Sub ASPxLabel1_PreRender(ByVal sender As Object, ByVal e As EventArgs)
		TryCast(sender, ASPxLabel).Text = dataBindingCount.ToString()
	End Sub
	Protected Sub ASPxLabel2_PreRender(ByVal sender As Object, ByVal e As EventArgs)
		TryCast(sender, ASPxLabel).Text = eventOrder

	End Sub
	Protected Sub dsProducts_Selecting(ByVal sender As Object, ByVal e As SqlDataSourceSelectingEventArgs)
		dataBindingCount += 1
		AddEventLog("<b>Database request</b>")
	End Sub
	Protected Sub grid_BeforeGetCallbackResult(ByVal sender As Object, ByVal e As EventArgs)
		If CInt(Fix(combo.Value)) = 2 Then
			CallMethods()
		End If

		AddEventLog("ASPxGridView BeforeGetCallbackResult")
	End Sub
	Protected Sub grid_PreRender(ByVal sender As Object, ByVal e As EventArgs)
		If CInt(Fix(combo.Value)) = 2 Then
			CallMethods()
		End If

		AddEventLog("ASPxGridView PreRender")
	End Sub
	Protected Sub ASPxCallbackPanel1_BeforeGetCallbackResult(ByVal sender As Object, ByVal e As EventArgs)
		If CInt(Fix(combo.Value)) = 2 Then
			CallMethods()
		End If

		AddEventLog("ASPxCallbackPanel BeforeGetCallbackResult")
	End Sub

	Protected Sub grid_RowDeleting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataDeletingEventArgs)
		Throw New NotSupportedException("Operation is disallowed in a demo")
	End Sub
	Protected Sub grid_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)
		'Data modifying is disallowed in this example
		For i As Integer = 0 To e.OldValues.Count - 1
			e.NewValues(i) = e.OldValues(i)
		Next i
	End Sub
	Protected Sub grid_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs)
		Throw New NotSupportedException("Operation is disallowed in a demo")
	End Sub

	Private Sub CallMethods()
		Dim methodsCalled As Boolean = False

		If ASPxCheckBox6.Checked Then
			grid.DataBind()
		End If

		If ASPxCheckBox2.Checked Then
			grid.GetRowValues(0, "ProductName")
			methodsCalled = True
		End If
		If ASPxCheckBox3.Checked Then
			grid.GetRow(0)
			methodsCalled = True
		End If
		If ASPxCheckBox4.Checked Then
			grid.GetDataRow(0)
			methodsCalled = True
		End If
		If ASPxCheckBox5.Checked Then
			grid.FindRowCellTemplateControl(0, TryCast(grid.Columns("CategoryID"), GridViewDataColumn), "ASPxComboBox1")
			methodsCalled = True
		End If
		If ASPxCheckBox7.Checked Then
			grid.DataBind()
		End If

		If methodsCalled Then
			AddEventLog("<b>Methods are called</b>")
		End If
	End Sub

	#Region "Service methods"
	Private Sub AddEventLog(ByVal eventLog As String)
		If (Not String.IsNullOrEmpty(eventOrder)) Then
			eventOrder &= "<br/>"
		End If
		eventOrder &= eventLog
	End Sub

	Private Sub SynchronizeEditorWithCookie(ByVal editor As ASPxEdit, ByVal cookieName As String)
		Dim c As HttpCookie = Request.Cookies(cookieName)
		If c IsNot Nothing Then
			Dim boolResult As Boolean
			If Boolean.TryParse(c.Value, boolResult) Then
				editor.Value = boolResult
			End If
			Dim intResult As Integer
			If Integer.TryParse(c.Value, intResult) Then
				editor.Value = intResult
			End If
		End If
	End Sub

	Private Sub SynchronizeEditorsWithCookies()
		SynchronizeEditorWithCookie(ASPxCheckBox1, "cacheEnabled")
		SynchronizeEditorWithCookie(ASPxCheckBox2, "GetRowValue")
		SynchronizeEditorWithCookie(ASPxCheckBox3, "GetRow")
		SynchronizeEditorWithCookie(ASPxCheckBox4, "GetDataRow")
		SynchronizeEditorWithCookie(ASPxCheckBox5, "FindRowCellTemplateControl")
		SynchronizeEditorWithCookie(ASPxCheckBox6, "firstDataBind")
		SynchronizeEditorWithCookie(ASPxCheckBox7, "lastDataBind")
		SynchronizeEditorWithCookie(combo, "OnEvent")
	End Sub
	#End Region ' service methods
End Class