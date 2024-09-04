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
    public partial class MainMenu : Form
    {
        public MainMenu()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Login lg = new Login();
            lg.Show();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            signup su = new signup();
            su.Show();
        }

        private void button1_Click_2(object sender, EventArgs e)
        {
            Game game = new Game();
            game.Show();
        }

        private void button1_Click_3(object sender, EventArgs e)
        {
            Admin ad = new Admin();
            ad.Show();
        }
    }
}
