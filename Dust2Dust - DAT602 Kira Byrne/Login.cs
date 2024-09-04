using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Dust2Dust___DAT602_Kira_Byrne
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void btnMenu_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.OK;
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void btnLoginAttempt_Click(object sender, EventArgs e)
        {
            LogInDAO logInDAO = new LogInDAO();
            logInDAO.CheckUsernameAndPassword(textBox1.Text, textBox2.Text);
        }
    }
}
