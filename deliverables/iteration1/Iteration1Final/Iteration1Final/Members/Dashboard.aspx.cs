using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Iteration1Working.Members
{
    public partial class MembersOnly : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtAddDeposit.Enabled = false;
            txtAddExpense.Enabled = false;
        
        }

        protected void radioExpense_CheckedChanged(object sender, EventArgs e)
        {
            if (radioExpense.Checked)
            {
                txtAddDeposit.Enabled = false;
                txtAddExpense.Enabled = true;
            }
        }

        protected void radioDeposit_CheckedChanged(object sender, EventArgs e)
        {
            if (radioDeposit.Checked)
            {
                txtAddDeposit.Enabled = true;
                txtAddExpense.Enabled = false;
            }
        }
    }
}