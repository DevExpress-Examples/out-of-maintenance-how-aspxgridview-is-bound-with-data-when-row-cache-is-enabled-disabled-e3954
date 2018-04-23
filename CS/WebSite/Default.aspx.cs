using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxEditors;
using DevExpress.Web.ASPxGridView;

public partial class _Default : System.Web.UI.Page {
	private int dataBindingCount;
	private string eventOrder;
	protected void Page_Init(object sender, EventArgs e) {
		SynchronizeEditorsWithCookies();

		grid.EnableRowsCache = ASPxCheckBox1.Checked;

		if ((int)combo.Value == 0)
			CallMethods();

		AddEventLog("Page Init");
	}

	protected void Page_Load(object sender, EventArgs e) {
		if ((int)combo.Value == 1)
			CallMethods();

		AddEventLog("Page Load");
	}
	protected void Page_PreRender(object sender, EventArgs e) {
		AddEventLog("Page PreRender");
	}
	protected void cbEditCategories_TextChanged(object sender, EventArgs e) {

	}

	protected void grid_CustomJSProperties(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewClientJSPropertiesEventArgs e) {
		e.Properties["cpDataBindingCount"] = dataBindingCount;
		e.Properties["cpEventOrder"] = eventOrder;

	}
	protected void ASPxLabel1_PreRender(object sender, EventArgs e) {
		(sender as ASPxLabel).Text = dataBindingCount.ToString();
	}
	protected void ASPxLabel2_PreRender(object sender, EventArgs e) {
		(sender as ASPxLabel).Text = eventOrder;

	}
	protected void dsProducts_Selecting(object sender, SqlDataSourceSelectingEventArgs e) {
		dataBindingCount++;
		AddEventLog("<b>Database request</b>");
	}
	protected void grid_BeforeGetCallbackResult(object sender, EventArgs e) {
		if ((int)combo.Value == 2)
			CallMethods();

		AddEventLog("ASPxGridView BeforeGetCallbackResult");
	}
	protected void grid_PreRender(object sender, EventArgs e) {
		if ((int)combo.Value == 2)
			CallMethods();

		AddEventLog("ASPxGridView PreRender");
	}
	protected void ASPxCallbackPanel1_BeforeGetCallbackResult(object sender, EventArgs e) {
		if ((int)combo.Value == 2)
			CallMethods();

		AddEventLog("ASPxCallbackPanel BeforeGetCallbackResult");
	}

	protected void grid_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e) {
		throw new NotSupportedException("Operation is disallowed in a demo");
	}
	protected void grid_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e) {
		//Data modifying is disallowed in this example
		for (int i = 0; i < e.OldValues.Count; i++) {
			e.NewValues[i] = e.OldValues[i];
		}
	}
	protected void grid_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e) {
		throw new NotSupportedException("Operation is disallowed in a demo");
	}
	
	private void CallMethods() {
		bool methodsCalled = false;

		if (ASPxCheckBox6.Checked)
			grid.DataBind();
		
		if (ASPxCheckBox2.Checked) {
			grid.GetRowValues(0, "ProductName");
			methodsCalled = true;
		}
		if (ASPxCheckBox3.Checked) {
			grid.GetRow(0);
			methodsCalled = true;
		}
		if (ASPxCheckBox4.Checked) {
			grid.GetDataRow(0);
			methodsCalled = true;
		}
		if (ASPxCheckBox5.Checked) {
			grid.FindRowCellTemplateControl(0, grid.Columns["CategoryID"] as GridViewDataColumn, "ASPxComboBox1");
			methodsCalled = true;
		}
		if (ASPxCheckBox7.Checked)
			grid.DataBind();

		if (methodsCalled)
			AddEventLog("<b>Methods are called</b>");
	}

	#region Service methods
	private void AddEventLog(string eventLog) {
		if (!String.IsNullOrEmpty(eventOrder))
			eventOrder += "<br/>";
		eventOrder += eventLog;
	}

	private void SynchronizeEditorWithCookie(ASPxEdit editor, string cookieName) {
		HttpCookie c = Request.Cookies[cookieName];
		if (c != null) {
			bool boolResult;
			if (bool.TryParse(c.Value, out boolResult))
				editor.Value = boolResult;
			int intResult;
			if (int.TryParse(c.Value, out intResult))
				editor.Value = intResult;
		}
	}

	private void SynchronizeEditorsWithCookies() {
		SynchronizeEditorWithCookie(ASPxCheckBox1, "cacheEnabled");
		SynchronizeEditorWithCookie(ASPxCheckBox2, "GetRowValue");
		SynchronizeEditorWithCookie(ASPxCheckBox3, "GetRow");
		SynchronizeEditorWithCookie(ASPxCheckBox4, "GetDataRow");
		SynchronizeEditorWithCookie(ASPxCheckBox5, "FindRowCellTemplateControl");
		SynchronizeEditorWithCookie(ASPxCheckBox6, "firstDataBind");
		SynchronizeEditorWithCookie(ASPxCheckBox7, "lastDataBind");
		SynchronizeEditorWithCookie(combo, "OnEvent");
	}
	#endregion service methods
}