<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Iteration1Working.Members.MembersOnly" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<script runat="server">
    static ArrayList expenses = new ArrayList();  //holds user's expenses (name)
    static ArrayList expenseAmounts = new ArrayList();  //hold's expense amounts specific to category
    static double depositTotal = 0;
    static double billTotal = 0;
    static double loanTotal = 0;
    static double savingsGoal = 0;
    static double expenseTotal = 0;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (expenses.Count == 0)
        {
            ddlAddToExpense.Items.Add(new ListItem("add category"));
            ddlDeleteExpense.Items.Add(new ListItem("add category"));
            ddlViewExpense.Items.Add(new ListItem("add category")); 
        }

        if (expenses.Count > 0)
            lblViewExpense.Text = "The selected expense amount total is $" + 
                expenseAmounts[expenses.IndexOf(ddlViewExpense.SelectedItem.Text)].ToString() + ".";
    }
    
    private void btnSubmit_Click(Object Sender, EventArgs e)
    {
       //If text is not empty and is not already a category, add new item to expense list
       if (!(txtAddExpenseCategory.Text.Equals("")) && 
           !(expenses.Contains(txtAddExpenseCategory.Text)))
       {
           expenses.Add(txtAddExpenseCategory.Text);
           expenseAmounts.Insert(expenses.Count - 1, 0.00);
           
           ddlDeleteExpense.DataSource = expenses;
           ddlDeleteExpense.DataBind();

           ddlAddToExpense.DataSource = expenses;
           ddlAddToExpense.DataBind();

           ddlViewExpense.DataSource = expenses;
           ddlViewExpense.DataBind();
       }

       if (!(txtAddToDeposit.Equals("")))
       {
           try
           {
               depositTotal += Convert.ToDouble(txtAddToDeposit.Text);
               txtAddToDeposit.Text = "";
           }
           catch (Exception exception) { }
       }
       
        //Deletes selected item when checked
       if(radioDeleteExpense.Checked)
       {
           expenseAmounts[expenses.IndexOf(ddlDeleteExpense.SelectedItem.Value)] = 0;
           //expenseTotal -= Convert.ToDouble(expenseAmounts[expenses.IndexOf(ddlDeleteExpense.SelectedItem.Value)]);
           expenseAmounts.Remove(expenses.IndexOf(ddlDeleteExpense.SelectedItem.Value));
           expenses.Remove(ddlDeleteExpense.SelectedItem.Value);

           ddlDeleteExpense.DataSource = expenses;
           ddlDeleteExpense.DataBind();

           ddlAddToExpense.DataSource = expenses;
           ddlAddToExpense.DataBind();

           ddlViewExpense.DataSource = expenses;
           ddlViewExpense.DataBind();
 
           radioDeleteExpense.Checked = false;
       }

       //Adding expenses
       if (!(txtAddToExpense.Equals("")) && expenses.Count > 0)
       {
           try
           {
               int temp = expenses.IndexOf(ddlAddToExpense.SelectedItem.Text);
               expenseAmounts[temp] = (Convert.ToDouble(expenseAmounts[temp]) + Convert.ToDouble(txtAddToExpense.Text));
               //expenseAmounts.Insert(temp, (Convert.ToDouble(expenseAmounts[temp]) + Convert.ToDouble(txtAddToExpense.Text)));
               lblViewExpense.Text = expenseAmounts[temp].ToString();
           }
           catch (Exception exception) { }
       }

       if (!(txtBillAmount.Equals("")))
       {
           try
           {
               billTotal += Convert.ToDouble(txtBillAmount.Text);
               txtBillAmount.Text = "";
           }
           catch (Exception exception) { }
       }

       if (!(txtLoanAmount.Equals("")))
       {
           try
           {
               loanTotal += Convert.ToDouble(txtLoanAmount.Text);
               txtLoanAmount.Text = "";
           }
           catch (Exception exception) { }
       }

       if (!(txtSavingsGoal.Equals("")))
       {
           try
           {
               savingsGoal = Convert.ToDouble(txtSavingsGoal.Text);
               txtSavingsGoal.Text = "";
           }
           catch (Exception exception) { }
       }

       //Sets total expense amount
       expenseTotal = 0;
       foreach (double d in expenseAmounts)
       {
            expenseTotal += d;
       }

       //Show net total of funds based on deposits/loans minus expenses/bills
       lblNetTotal.Text = "$" + (depositTotal + loanTotal - expenseTotal - billTotal).ToString();
       lblBillTotal.Text = "$" + billTotal.ToString();
       lblLoanTotal.Text = "$" + loanTotal.ToString();
       lblExpenseTotal.Text = "$" + expenseTotal.ToString();
       lblDepositTotal.Text = "$" + depositTotal.ToString();

       lblSavingsGoal.Text = "Savings goal: $" + savingsGoal.ToString();
       lblSavingsDifference.Text = "$" + (savingsGoal + (expenseTotal + billTotal - depositTotal - loanTotal)).ToString();
       
       txtAddExpenseCategory.Text = "";  //Resets text box after submission
       txtAddToExpense.Text = "";

       if (expenses.Count > 0)
           lblViewExpense.Text = "The selected expense amount total is $" + 
               expenseAmounts[expenses.IndexOf(ddlViewExpense.SelectedItem.Text)].ToString() + ".";
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
       <div class="jumbodiv">
           <h3>Add Deposits and Expenses</h3>
           <asp:Label Text="Add expense to: " runat="server" />
           <asp:DropDownList ID="ddlAddToExpense" runat="server" />
           <asp:Label Text=" Amount: " runat="server" />
           <asp:TextBox TextMode="SingleLine" ID="txtAddToExpense" Text="" runat="server" />
           </br>
           <asp:Label Text="Add deposit amount: " runat="server" />
           <asp:TextBox TextMode="SingleLine" ID="txtAddToDeposit" Text="" runat="server" />
       </div>
       </br>
       <div class="jumbodiv" style="width: 55%; display:inline-block">
           <h3>Add/Delete Expense Categories</h3>
           <asp:Label Text="Add expense category: " runat="server" />
           <asp:TextBox TextMode="SingleLine" ID="txtAddExpenseCategory" Text="" runat="server"/>
           </br>
           <asp:RadioButton ID="radioDeleteExpense" Text="Delete Expense Category: " runat="server" />
           <asp:DropDownList ID="ddlDeleteExpense" runat="server" />
           </br>
           <asp:DropDownList ID="ddlViewExpense" runat="server" AutoPostBack="True" />
           <asp:Label ID="lblViewExpense" Text="The selected expense amount total is $0." runat="server" />
       </div>
       <div class="jumbodiv" style="width: 40%; display:inline-block; margin-left: auto;">
           <h3>Add Bills, Loans, and Savings Goals</h3>
           <asp:Label Text="Add bill amount: " runat="server" />
           <asp:TextBox TextMode="SingleLine" ID="txtBillAmount" Text="" runat="server"/>
           </br>
           <asp:Label Text="Add loan amount: " runat="server" />
           <asp:TextBox TextMode="SingleLine" ID="txtLoanAmount" Text="" runat="server"/>
           </br>
           <asp:Label Text="Add savings goal: " runat="server" />
           <asp:TextBox TextMode="SingleLine" ID="txtSavingsGoal" Text="" runat="server"/>
       </div>
       </br>
       </br>
       <asp:Button id="btnSubmit" onclick="btnSubmit_Click" Text="Submit" runat="server" />
       </br></br>
       <div class="jumbodiv">
           <h3>Summary</h3>
           <p>Expense(s) Total: <asp:Label id="lblExpenseTotal" Text="0" runat="server" /></p>
           <p>Deposit(s) Total: <asp:Label ID="lblDepositTotal" Text="0" runat="server" />
           <img src="http://placehold.it/500x300" style="display:inline-block; float:right; margin-right: 50px;"></p>
           <p>Loan(s) Total: <asp:Label ID="lblLoanTotal" Text="0" runat="server" /></p>
           <p>Bill(s) Total: <asp:Label ID="lblBillTotal" Text="0" runat="server" /></p>
           <p><asp:Label Text="Savings goal: $0" ID="lblSavingsGoal" runat="server" /></p>
           <p><strong>Net Total: <asp:Label ID="lblNetTotal" Text="0" runat="server" /></strong></p>
           <p><strong>Distance from savings goal: <asp:Label ID="lblSavingsDifference" Text="N/A" runat="server" /></strong></p>
           </br>
           &nbsp;</div>
   </div>
   </div>
</asp:Content>