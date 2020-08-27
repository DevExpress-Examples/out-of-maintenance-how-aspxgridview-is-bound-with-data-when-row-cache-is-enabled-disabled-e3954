<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v15.1, Version=15.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web" TagPrefix="dx" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<script language="javascript" type="text/javascript">
		function SetLabelsText(s, e) {
			label.SetText(s.cpDataBindingCount);
			label2.SetText(s.cpEventOrder);
		}    
	</script>
</head>
<body>
	<form id="form1" runat="server">
	<div>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<dx:ASPxCheckBox ID="ASPxCheckBox1" runat="server" CheckState="Checked" Text="EnableRowCache">
						<ClientSideEvents CheckedChanged="function(s, e) {
	ASPxClientUtils.SetCookie('cacheEnabled', s.GetChecked());
}" />
					</dx:ASPxCheckBox>
				</td>
				<td style="padding-left: 10px">
					<dx:ASPxButton ID="ASPxButton1" runat="server" AutoPostBack="False" Text="Apply">
						<ClientSideEvents Click="function(s, e) {
	window.location = window.location;
}" />
					</dx:ASPxButton>
				</td>
			</tr>
		</table>
		<br />
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
				<dx:ASPxCheckBox ID="ASPxCheckBox6" runat="server" CheckState="Unchecked" Text="Call DataBind before methods"
						AutoPostBack="True">
						<ClientSideEvents CheckedChanged="function(s, e) {
	ASPxClientUtils.SetCookie('firstDataBind', s.GetChecked());
}" />
					</dx:ASPxCheckBox>
					<dx:ASPxCheckBox ID="ASPxCheckBox2" runat="server" CheckState="Unchecked" Text="Call the GetRowValue method"
						AutoPostBack="True">
						<ClientSideEvents CheckedChanged="function(s, e) {
	ASPxClientUtils.SetCookie('GetRowValue', s.GetChecked());
}" />
					</dx:ASPxCheckBox>
					<dx:ASPxCheckBox ID="ASPxCheckBox3" runat="server" CheckState="Unchecked" Text="Call the GetRow method"
						AutoPostBack="True">
						<ClientSideEvents CheckedChanged="function(s, e) {
	ASPxClientUtils.SetCookie('GetRow', s.GetChecked());
}" />
					</dx:ASPxCheckBox>
					<dx:ASPxCheckBox ID="ASPxCheckBox4" runat="server" CheckState="Unchecked" Text="Call the GetDataRow method"
						AutoPostBack="True">
						<ClientSideEvents CheckedChanged="function(s, e) {
	ASPxClientUtils.SetCookie('GetDataRow', s.GetChecked());
}" />
					</dx:ASPxCheckBox>
					<dx:ASPxCheckBox ID="ASPxCheckBox5" runat="server" CheckState="Unchecked" Text="Call the FindRowCellTemplateControl method"
						AutoPostBack="True">
						<ClientSideEvents CheckedChanged="function(s, e) {
	ASPxClientUtils.SetCookie('FindRowCellTemplateControl', s.GetChecked());
}" />
					</dx:ASPxCheckBox>                    
					<dx:ASPxCheckBox ID="ASPxCheckBox7" runat="server" CheckState="Unchecked" Text="Call DataBind after methods"
						AutoPostBack="True">
						<ClientSideEvents CheckedChanged="function(s, e) {
	ASPxClientUtils.SetCookie('lastDataBind', s.GetChecked());
}" />
					</dx:ASPxCheckBox>
				</td>
				<td valign="middle" style="padding: 0 10px	">
					in the
				</td>
				<td valign="middle">
					<dx:ASPxComboBox ID="combo" runat="server" ValueType="System.Int32" Width="220px"
						AutoPostBack="True">
						<ClientSideEvents ValueChanged="function(s, e) {
	ASPxClientUtils.SetCookie('OnEvent', s.GetValue());
}" />
						<Items>
							<dx:ListEditItem Text="Init" Value="0" />
							<dx:ListEditItem Text="Load" Value="1" />
							<dx:ListEditItem Text="PreRender/BeforeGetCallbackResult" Value="2" Selected="true" />
						</Items>
					</dx:ASPxComboBox>
				</td>
				<td valign="middle" style="padding-left: 10px">
					event handler
				</td>
			</tr>
		</table>
		<dx:ASPxButton ID="ASPxButton2" runat="server" AutoPostBack="False" Text="Send an external callback">
			<ClientSideEvents Click="function(s, e) {
	cbPanel.PerformCallback();
}" />
		</dx:ASPxButton>
		<dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="200px" ClientInstanceName="cbPanel"
			OnBeforeGetCallbackResult="ASPxCallbackPanel1_BeforeGetCallbackResult">
			<ClientSideEvents EndCallback="function(s, e) {
	SetLabelsText(grid, e);
}" />
			<PanelCollection>
				<dx:PanelContent ID="PanelContent1" runat="server" SupportsDisabledAttribute="True">
					<dx:ASPxGridView ID="grid" runat="server" AutoGenerateColumns="False" ClientInstanceName="grid"
						DataSourceID="dsProducts" KeyFieldName="ProductID" OnBeforeGetCallbackResult="grid_BeforeGetCallbackResult"
						OnCustomJSProperties="grid_CustomJSProperties" OnPreRender="grid_PreRender" OnRowDeleting="grid_RowDeleting"
						OnRowInserting="grid_RowInserting" OnRowUpdating="grid_RowUpdating">
						<ClientSideEvents EndCallback="SetLabelsText" />
						<Columns>
                            <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" ShowEditButton="True" ShowNewButton="True" ShowDeleteButton="True"/>
							<dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" ShowInCustomizationForm="True"
								VisibleIndex="1">
								<EditFormSettings Visible="False" />
							</dx:GridViewDataTextColumn>
							<dx:GridViewDataTextColumn FieldName="ProductName" ShowInCustomizationForm="True"
								VisibleIndex="2">
							</dx:GridViewDataTextColumn>
							<dx:GridViewDataTextColumn FieldName="SupplierID" ShowInCustomizationForm="True"
								VisibleIndex="3">
							</dx:GridViewDataTextColumn>
							<dx:GridViewDataTextColumn FieldName="CategoryID" ShowInCustomizationForm="True"
								VisibleIndex="4">
								<DataItemTemplate>
									<dx:ASPxComboBox ID="ASPxComboBox1" runat="server" DataSourceID="dsCategories" TextField="CategoryName"
										Value='<%#Bind("CategoryID")%>' ValueField="CategoryID" ValueType="System.Int32">
									</dx:ASPxComboBox>
								</DataItemTemplate>
							</dx:GridViewDataTextColumn>
							<dx:GridViewDataTextColumn FieldName="QuantityPerUnit" ShowInCustomizationForm="True"
								VisibleIndex="5">
							</dx:GridViewDataTextColumn>
							<dx:GridViewDataTextColumn FieldName="UnitPrice" ShowInCustomizationForm="True" VisibleIndex="6">
							</dx:GridViewDataTextColumn>
							<dx:GridViewDataTextColumn FieldName="UnitsInStock" ShowInCustomizationForm="True"
								VisibleIndex="7">
							</dx:GridViewDataTextColumn>
							<dx:GridViewDataTextColumn FieldName="UnitsOnOrder" ShowInCustomizationForm="True"
								VisibleIndex="8">
							</dx:GridViewDataTextColumn>
							<dx:GridViewDataTextColumn FieldName="ReorderLevel" ShowInCustomizationForm="True"
								VisibleIndex="9">
							</dx:GridViewDataTextColumn>
							<dx:GridViewDataCheckColumn FieldName="Discontinued" ShowInCustomizationForm="True"
								VisibleIndex="10">
							</dx:GridViewDataCheckColumn>
						</Columns>
						<SettingsDetail ShowDetailRow="True" />
						<Templates>
							<DetailRow>
								Detail Row content
							</DetailRow>
						</Templates>
						<SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" ProcessFocusedRowChangedOnServer="True"
							ProcessSelectionChangedOnServer="True" />
						<Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True"
							ShowHeaderFilterButton="True" />
					</dx:ASPxGridView>
					<br />
					Data binding count:
					<dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="" ClientInstanceName="label" OnPreRender="ASPxLabel1_PreRender"
						Font-Bold="True">
					</dx:ASPxLabel>
					<br />
					<br />
					Server-side events order:<br />
					<dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="" ClientInstanceName="label2"
						OnPreRender="ASPxLabel2_PreRender" EncodeHtml="False" Font-Bold="False" Width="300px">
					</dx:ASPxLabel>
				</dx:PanelContent>
			</PanelCollection>
		</dx:ASPxCallbackPanel>

	</div>
	<asp:SqlDataSource ID="dsProducts" runat="server" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>"
		SelectCommand="SELECT [ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued] FROM [Products]"
		OnSelecting="dsProducts_Selecting"
		UpdateCommand="UPDATE [Products] SET [ProductName] = @ProductName, [SupplierID] = @SupplierID, [CategoryID] = @CategoryID, [QuantityPerUnit] = @QuantityPerUnit, [UnitPrice] = @UnitPrice, [UnitsInStock] = @UnitsInStock, [UnitsOnOrder] = @UnitsOnOrder, [ReorderLevel] = @ReorderLevel, [Discontinued] = @Discontinued WHERE [ProductID] = @ProductID">
		<UpdateParameters>
			<asp:Parameter Name="ProductName" Type="String" />
			<asp:Parameter Name="SupplierID" Type="Int32" />
			<asp:Parameter Name="CategoryID" Type="Int32" />
			<asp:Parameter Name="QuantityPerUnit" Type="String" />
			<asp:Parameter Name="UnitPrice" Type="Decimal" />
			<asp:Parameter Name="UnitsInStock" Type="Int16" />
			<asp:Parameter Name="UnitsOnOrder" Type="Int16" />
			<asp:Parameter Name="ReorderLevel" Type="Int16" />
			<asp:Parameter Name="Discontinued" Type="Boolean" />
			<asp:Parameter Name="ProductID" Type="Int32" />
		</UpdateParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="dsCategories" runat="server" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>"
		SelectCommand="SELECT [CategoryID], [CategoryName], [Description] FROM [Categories]">
	</asp:SqlDataSource>
	</form>
</body>
</html>