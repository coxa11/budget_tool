<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Iteration1Working.Members.MembersOnly" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<script runat="server">
    
   private void btnSubmit_Click(Object Sender, EventArgs e)
   {
       if (radioExpense.Checked)
       {
           double temp = Convert.ToDouble(lblExpenseTotal.Text);  //current total before adding more
           lblExpenseTotal.Text = (Convert.ToDouble(txtAddExpense.Text) + temp).ToString();
           lblExpenseTotal.Text = lblExpenseTotal.Text;
           radioExpense.Checked = false;
           txtAddExpense.Text = "0";  //resets text after button press
       }
       else if (radioDeposit.Checked)
       {
           double temp = Convert.ToDouble(lblDepositTotal.Text);  //current total before adding more
           lblDepositTotal.Text = (Convert.ToDouble(txtAddDeposit.Text) + temp).ToString();
           lblDepositTotal.Text = lblDepositTotal.Text;
           radioDeposit.Checked = false;
           txtAddDeposit.Text = "0";  //resets text after button press
       }
       lblNetTotal.Text = (Convert.ToDouble(lblDepositTotal.Text) - Convert.ToDouble(lblExpenseTotal.Text)).ToString();
   }
</script>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   <div class="jumbotron">
       <h2 style="color: #183677"><%: Title %></h2>
       <h3 style="color: #183677"><strong>Welcome to your SmartChart Dashboard!</strong></h3>
       </br>
       <p>Here you can add basic income and expenses. In the near future, you will be able to add your own expense 
           categories and choose where your precious, hard-earned cash goes first!</p>
       </br>
       <asp:RadioButton ID="radioExpense" GroupName="AddExpenseDeposit" Text="Add Expense" runat="server" AutoPostBack="True" OnCheckedChanged="radioExpense_CheckedChanged" />
       <asp:Textbox TextMode="Number" id="txtAddExpense" Text ="0" min="0" max="1000000" step="1" runat="server" />
       <asp:RadioButton ID="radioDeposit" GroupName="AddExpenseDeposit" Text="Add Deposit" runat="server" AutoPostBack="True" OnCheckedChanged="radioDeposit_CheckedChanged" />
       <asp:TextBox TextMode="Number" id="txtAddDeposit" Text ="0" min="0" max="1000000" step="1" runat="server" />
       </br>
       <asp:Button id="btnSubmit" onclick="btnSubmit_Click" Text="Submit" runat="server" />
       </br></br>
       <p>Expense Total: $<asp:Label id="lblExpenseTotal" Text="0" runat="server" /></p>
       <p>Deposit Total: $<asp:Label ID="lblDepositTotal" Text="0" runat="server" /></p>
       <p><strong>Net Total: $<asp:Label ID="lblNetTotal" Text="0" runat="server" /></strong></p>
   </div>
</asp:Content>